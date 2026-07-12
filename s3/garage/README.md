# garage

由于 Garage 默认没有域名解析服务（类似 test-bucket.localhost），我们必须显式指定 UsePathStyle: true，让 SDK 走 http://localhost:3900/test-bucket 的路径模式。

```golang
package main

import (
	"context"
	"bytes"
	"fmt"
	"io"
	"log"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/service/s3"
)

func main() {
	// 1. 配置 Garage 的 S3 凭证与端点
	endpoint := "http://localhost:3900"
	region := "garage"
	accessKey := "GK96ef087d1d23b293af21abf7"
	secretKey := "2ca6cf2f5c147171d248a74e167d92fabe08ab873f6416d88f45690031549ed5"
	bucketName := "test-bucket"

	// 2. 加载自定义配置
	cfg, err := config.LoadDefaultConfig(context.TODO(),
		config.WithRegion(region),
		config.WithCredentialsProvider(credentials.NewStaticCredentialsProvider(accessKey, secretKey, "")),
	)
	if err != nil {
		log.Fatalf("无法加载 SDK 配置: %v", err)
	}

	// 3. 实例化 S3 客户端，重写 Endpoint 并启用 PathStyle
	s3Client := s3.NewFromConfig(cfg, func(o *s3.Options) {
		o.BaseEndpoint = aws.String(endpoint)
		o.UsePathStyle = true // 关键：必须使用路径样式路由
	})

	fmt.Println("成功连接到 Garage 对象存储...")

	// 4. 测试：上传一个简单的文本对象
	objectKey := "hello-garage.txt"
	content := []byte("Hello Arthur, Garage S3 is working perfectly with Go!")

	_, err = s3Client.PutObject(context.TODO(), &s3.Input{
		Bucket: aws.String(bucketName),
		Key:    aws.String(objectKey),
		Body:   bytes.NewReader(content),
	})
	if err != nil {
		log.Fatalf("文件上传失败: %v", err)
	}
	fmt.Printf("成功上传对象: %s\n", objectKey)

	// 5. 测试：下载刚才上传的对象
	resp, err := s3Client.GetObject(context.TODO(), &s3.GetObjectInput{
		Bucket: aws.String(bucketName),
		Key:    aws.String(objectKey),
	})
	if err != nil {
		log.Fatalf("文件下载失败: %v", err)
	}
	defer resp.Body.Close()

	downloadedContent, err := io.ReadAll(resp.Body)
	if err != nil {
		log.Fatalf("读取下载内容失败: %v", err)
	}

	fmt.Printf("成功下载对象，内容为:\n> %s\n", string(downloadedContent))
}

```
