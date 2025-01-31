# AWS S3 + CloudFront Static Website

This repository contains Terraform code that deploys a **website** on **Amazon S3** and serves it via an **Amazon CloudFront** distribution. It’s ideal for hosting websites with high performance and low cost.

## Architecture Overview

1. **Amazon S3**  
   - Stores static files: `index.html`, `style.css`, and `script.js`.
   - Can be configured as **public** (with a bucket policy) or **private** (using Origin Access Control).

2. **Amazon CloudFront**  
   - Retrieves content from the S3 origin.
   - Delivers content worldwide from edge locations, reducing latency.
   - Enforces HTTP to HTTPS redirection and caches files.

3. **Terraform**  
   - Automates creation of all AWS resources: S3 bucket, bucket policy, CloudFront distribution, and OAC (if private).
   - Code is organized into multiple `.tf` files for clarity.

## Files

- **`s3bucket.tf`**  
  - Creates an S3 bucket.  
  - Disables block public access (if you want a public bucket).  
  - Applies a public-read bucket policy or sets up for OAC usage.  
  - Uploads static files (`index.html`, `style.css`, `script.js`).

- **`cfdistribution.tf`**  
  - Creates a CloudFront Origin Access Control (OAC) (recommended).  
  - Creates a CloudFront distribution pointing to the S3 bucket.  
  - Configures default cache behavior and HTTP to HTTPS redirection.

## Usage

1. **Prerequisites**  
   - [Terraform](https://www.terraform.io/downloads) installed.  
   - AWS credentials configured via environment variables or AWS CLI.

2. **Clone the Repo**  
   ```bash
   git clone https://github.com/your-username/aws-s3-cloudfront-static-website.git
   cd aws-s3-cloudfront-static-website
