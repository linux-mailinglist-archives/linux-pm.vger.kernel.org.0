Return-Path: <linux-pm+bounces-13992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271D0974D2D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300AE288669
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAA71865E2;
	Wed, 11 Sep 2024 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jH0+x0PF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F571865E5;
	Wed, 11 Sep 2024 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044452; cv=none; b=T5HaKQQgmHFKQMqSU3nn6+DTJDB7AGU2YSVHFQUS/bDpnLzqYVot6fB8ch/V1SU9kE58AlDzo0l/aQBCoiH0hoTTLmhPt7lJx+WvLBBpyL7k/lWaCcKOeL2BWKLodMKfA79VDBCqNzjqMrmfM2cSnHaF/MwU6RSi5EguWr+Ahvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044452; c=relaxed/simple;
	bh=UhU7//LLPdJwfMnsrPFXCgGaL4nYzWl6Sy0XKuREjU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKOXiGtYy7uFQGZ4nvytB+bx/ZKMgv3GLX+yFR9UHNypfYER3w1il9iChxCoshrMnZxOAsB8/o+WvrceD6owGy/0Vlxlg7R2dIIFqmaJWXCrUVTX2t4qpeannE2POLNhAiml1DkDJ96he4qZl/YiLpXb2E54MWxNflL5jiavFnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jH0+x0PF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71911585911so1148267b3a.3;
        Wed, 11 Sep 2024 01:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044450; x=1726649250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGIw9gVC7lsgAYuQP3STO88xNXXw/JJZyndkt0vNvtc=;
        b=jH0+x0PFl5qksz2MEAn00l5ykkdyGG3fHTxLqM6edCX74y1+zp+hTDWXbs7afsLd+E
         evSls7vQiBlbAGcv+m1O+V8N7S4bLQZlBbYxJC7iiZXm8SeIKCKS5HO63inNifGOlftG
         f7OS5v6EquraW5GnM0brxTFiq0sIqL+C29lGPmH2VwCcX6VTGmEQcggDBILzznG1Fiat
         SA1Jf0d/MKSf6rqKuz1pCK3vhNZRLTw9u9yM9CDcrmjoVI8bpF2ErJkWIj783Dho9Zge
         OSYjwDuQYpN56dEVPPv9vf8R8pSWIkfOO+rjH2biONK3BJ8pAnukjGiqFPyP/Rn2eG2w
         Fu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044450; x=1726649250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGIw9gVC7lsgAYuQP3STO88xNXXw/JJZyndkt0vNvtc=;
        b=F7sqkVI4+L4jSQ1Dqqz65eRG9ayrTC/a34yjEinbHwq0qlKwnXrtNd/GahuJpPforc
         GweFCZPb9TqZKigqcBVyguKsxYWQ4hHEg9HPJ9gWAGknL/F8ropq0eVk0F1RTe6x8lOw
         ZPM8ovcjZyiHqmDuhaEUv2811sv0dlgAFLWSZk8GKLBZTj4+iLHAS/MTKpgU3MRRO3fY
         /FYWaUzDqJAAWuXfMMK6htiEQyaCjshToR0yijIhdDrxZp/HsPhOrtgxz3BAHmK3CxFD
         DXeYC/0C4m527j4OnMSTxxggVYamfZLwnBDPzwdzh6dX0fE/uxYIpTtniAJ2deyCtkrF
         tDNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVM+gw5paXtTqKOta8wLCQ/F9LwAXGVivCxNBexZpNQxaamxTxpEq+7GqcRUKn4UuIcO2m5HNJg7Y=@vger.kernel.org, AJvYcCVBXO4WqAlaIEVunb9IqI4DjzftagRRUzWYyx7W1IQhEJQ5NkSu5QnJAxNCmAm1uGePQD1CAE5gnrLT@vger.kernel.org, AJvYcCWdJLOmoNxBn5gGJ5oXKiPKL6qQJtJ7Vge3ugAbrRKANAUBl7sracdRP/6VUV0UGJtprR7VfplcXURHUNgv@vger.kernel.org, AJvYcCWppOaxkycF5qUw9h5zK3BK5GzdZKRaRzPcWIY6ZfcJRKKF3M78Y4Gw17ymantzWqZGNJXVIbkivMmm1g==@vger.kernel.org, AJvYcCXyy4qaclWesraYuJ2aZ4hPPjQl0BnSah1ofpGSdRR8dmhMr4eDxovn3nZozQB2n2mHnm5oWNAfSzAUeCILGuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtK0NxClD5ya2/Lu2mzPFSiVSmwFer+oPh8cTuQr9/4k7Vs9q1
	HNlEjfpOhcorknWMJVzevw152SnoKxlbF8SkMJmNvJsqeasTFlJI
X-Google-Smtp-Source: AGHT+IF0wh/4ve5zW3DQwRA88FpDWlUvKJZ0MPzTYhVqYgh0gGlRFOCd56bPec4nO9iXMD5ZBj7dOw==
X-Received: by 2002:a05:6a21:2d8f:b0:1cf:440a:d785 with SMTP id adf61e73a8af0-1cf62cba095mr3438507637.11.1726044450055;
        Wed, 11 Sep 2024 01:47:30 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:47:29 -0700 (PDT)
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
Subject: [PATCH 08/22] dt-bindings: arm: apple: Add A9 devices
Date: Wed, 11 Sep 2024 16:40:58 +0800
Message-ID: <20240911084353.28888-10-towinchenmi@gmail.com>
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

Adds the following apple,s8000 and apple,s8003 based platforms:

- iPhone 6S
- iPhone 6S Plus
- iPhone SE (2016)
- iPad 5

apple,s8000 is the Samsung A9, while apple,s8003 is the TSMC A9.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/arm/apple.yaml        | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index dd5f0f6eb52b..f3f100ce8072 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -31,6 +31,13 @@ description: |
 
   - iPad Air 2
 
+  Devices based on the "A9" SoC:
+
+  - iPhone 6s
+  - iPhone 6s Plus
+  - iPhone SE (2016)
+  - iPad 5
+
   Devices based on the "M1" SoC:
 
   - Mac mini (M1, 2020)
@@ -121,6 +128,28 @@ properties:
           - const: apple,t7001
           - const: apple,arm-platform
 
+      - description: Apple Samsung A9 SoC based platforms
+        items:
+          - enum:
+              - apple,j71s # iPad 5 (Wi-Fi) (S8000)
+              - apple,j72s # iPad 5 (Cellular) (S8000)
+              - apple,n66  # iPhone 6s Plus (S8000)
+              - apple,n69u # iPhone SE (S8000)
+              - apple,n71  # iPhone 6S (S8000)
+          - const: apple,s8000
+          - const: apple,arm-platform
+
+      - description: Apple TSMC A9 SoC based platforms
+        items:
+          - enum:
+              - apple,j71t # iPad 5 (Wi-Fi) (S8003)
+              - apple,j72t # iPad 5 (Cellular) (S8003)
+              - apple,n66m # iPhone 6s Plus (S8003)
+              - apple,n69  # iPhone SE (S8003)
+              - apple,n71m # iPhone 6S (S8003)
+          - const: apple,s8003
+          - const: apple,arm-platform
+
       - description: Apple M1 SoC based platforms
         items:
           - enum:
-- 
2.46.0


