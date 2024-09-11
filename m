Return-Path: <linux-pm+bounces-13994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DC3974D3B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D471DB263DE
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A9A187329;
	Wed, 11 Sep 2024 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTi7flKf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B343618732A;
	Wed, 11 Sep 2024 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044462; cv=none; b=Ox09LPrr9qT/jhn/Y8beMZEjK5sE5anCfmwwDvPYGGJvIg6yn9oH8jsobKNRztDWb+n1JaYfCAc8nYZKU4F+aBQhxaEOHSe5m5JWiRJ8KK0n+jfgzlfuVHWbzakP33+vmltNIve8YusdiqjorgBi+x0kYLR2BWLBR5iLxrJyvfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044462; c=relaxed/simple;
	bh=PxOC33i0Rsl2lUZhdV9oiRVYZC88KWzOhKL37rPt97U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=No0Q7YI7lSecsISWAcV4QBsbkZNX3R9IT82t354gwqIrttqzYFNtzsGjE4tnI33Q5mnqmBB1vwq2vVvkcxJt8z5EwESn3vUAvCwfRnq5mijX2NABlpzGkVG3TqVRc2wqHQJw8BHdXAqTs5116ng7wgD2h4WfSn6j6vl7qV8Kyjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTi7flKf; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71790ed8c2dso5626314b3a.3;
        Wed, 11 Sep 2024 01:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044460; x=1726649260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+/aZHkh5FNnLm5U5M09ijcJHqZIVes5WSergbQUG0M=;
        b=aTi7flKfi5iBporkqdaXSKs/zY0OdRi0b98H6/bWi+sCa/UgDgh1I+xPhdJWzBEltq
         3WQabvOv35TBkEDgUHw1VaoGF72l3SewsIeFBHEruGhrcbrAOvsab2B5t16KKhndMdaf
         Wl1xAtFE8Qtr3YPY0iXQFYjInx8p4mw6PPM66vfRWAlG3hfqpG8hArwc+SSSUhK4oU3k
         VUKd8zvSVGCV/s/gLwt6C9/jY/5PY3Kchv1P/4QQWIAJs01/TAdrmDmydoMug5t2oQ3/
         j0WG6mEjpDeXgEgatF7+fO9jKpJYLalywb54JYNfo3Ro+37hXr9IAUTSr9oMp/wiKq2T
         iBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044460; x=1726649260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+/aZHkh5FNnLm5U5M09ijcJHqZIVes5WSergbQUG0M=;
        b=JVyZ8KBSUDMc4bwk9ZrFVRA6jjR/H0xA4ye0VehSc9F9QxS1jslzKTngPBWTlegl+T
         MBpW6amkxYkawbCbQRiGSOdUMx59sS9B4k4rKEV5FogFTDrYeJCnwLiIqcMUm5xHaBG1
         0F4ZowYLMb6FmDiVvIpvTkkHct4n2Wv/d+KVTeBJbk99QrF8Y8TlKMgvrNslLGroi0od
         XSMahUQE116ZRHwO7j6B84VCU1IUXiFkSCqC5XWfDkJ+R5EsSKYcCudwRJDfhgHRsdys
         6zv7J53/Pnyyw3C0d8ScqKODT9n0FPkiR9Ou450muTnNqNI3pm4o8HIOaqRgXoa37ybg
         cYiA==
X-Forwarded-Encrypted: i=1; AJvYcCUC/1UW9vuQHUU6Lk6lpc51Gi4l24YG1Dv1c9PQrQGxRr+RvY02qMX3jpdPBE0BrJ+BLYnQeYsZzW7How==@vger.kernel.org, AJvYcCUuptHey8ZYZNJhwWJ4lZY3WjmjmAvEwFhh9vt/hfaktmpFpC0SofbX1g/jr426uaLsWL/cPRkFELRv@vger.kernel.org, AJvYcCVNK9/2bw2go0i7z5RtdVawPgOeDdcXxHXaSjAf6KPKnRLbVHJwdyaZ8BwBanUvSI2v2GPNMC7NQtLrIgYw4ts=@vger.kernel.org, AJvYcCX0DP8KaL5ACFy4jqgNcX5WS6FVqF7ob3sEhbzxcJBTw/AklQkA9Uv4wiJ4LohZ5ebIGjeKOv2G+NLJ+DOC@vger.kernel.org, AJvYcCXIYXTS6KJjZ5/FEI5xaoxQghdrnonc+r1/nlHOK8VWnJnO+/0gxIRtLHNQmjweRMtfxuDJn1xgMKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC5H8hwS4bzONezX6mpqDh7ETiPiIJabeLGukAe78Q2HNz++qz
	Ed62B2DE3GvEqyMQb/fDPZbHIdC2CglM3vSXiI6CcNEFYbBIxA+O
X-Google-Smtp-Source: AGHT+IFWm+lBeW7Fn0wnv9eqQIov8poKTN3KAm+U4yVC5EqrImWQGILS/ta6tYOmIbYfpse5ZrzOdQ==
X-Received: by 2002:a05:6a00:23ca:b0:719:2046:5d69 with SMTP id d2e1a72fcca58-71920466977mr861707b3a.22.1726044459800;
        Wed, 11 Sep 2024 01:47:39 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:47:39 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 10/22] dt-bindings: arm: apple: Add A10 devices
Date: Wed, 11 Sep 2024 16:41:00 +0800
Message-ID: <20240911084353.28888-12-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911084353.28888-2-towinchenmi@gmail.com>
References: <20240911084353.28888-2-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds the following apple,t8010 based platforms:

 - iPhone 7
 - iPhone 7 Plus
 - iPod Touch 7
 - iPad 6
 - iPad 7

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/arm/apple.yaml        | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 27311c75faad..873b62035bc4 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -43,6 +43,14 @@ description: |
   - iPad Pro (9.7-inch)
   - iPad Pro (12.9-inch)
 
+  Devices based on the "A10" SoC:
+
+  - iPhone 7
+  - iPhone 7 Plus
+  - iPod Touch 7
+  - iPad 6
+  - iPad 7
+
   Devices based on the "M1" SoC:
 
   - Mac mini (M1, 2020)
@@ -165,6 +173,21 @@ properties:
           - const: apple,s8001
           - const: apple,arm-platform
 
+      - description: Apple A10 SoC based platforms
+        items:
+          - enum:
+              - apple,d10  # iPhone 7 (Qualcomm)
+              - apple,d11  # iPhone 7 (Intel)
+              - apple,d101 # iPhone 7 Plus (Qualcomm)
+              - apple,d111 # iPhone 7 Plus (Intel)
+              - apple,j71b # iPad 6 (Wi-Fi)
+              - apple,j72b # iPad 6 (Cellular)
+              - apple,j171 # iPad 7 (Wi-Fi)
+              - apple,j172 # iPad 7 (Cellular)
+              - apple,n112 # iPod Touch 7
+          - const: apple,t8010
+          - const: apple,arm-platform
+
       - description: Apple M1 SoC based platforms
         items:
           - enum:
-- 
2.46.0


