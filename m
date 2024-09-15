Return-Path: <linux-pm+bounces-14295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC49197955A
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 10:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841832839C6
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 08:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A7D8288C;
	Sun, 15 Sep 2024 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTlimL0E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18BB8175F;
	Sun, 15 Sep 2024 08:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726387707; cv=none; b=hSjNwNiIyNSC3v1NsEY7+TVgONvZEayUx4W2rd6pW5SuuEgNA4Mq/ApoPZtrWj7Z9ihcc0RpXMMHoS0Gr563rELewlQKIx9HDFNFqJMKIiHTvvS1KbEk2LTIHXbjayYakfDTnnsvOb6mZ3PCQ6L1rG+ogPqc2R3TBbWx4Eslbe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726387707; c=relaxed/simple;
	bh=F+fvD8tj9Q89DXXtcIua1ke1r+dlwF7u6BI3SFUU4HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dq1xOHFUSot59J6XKrEbwKQAz5Pvrrpz48Np6XTlN+krBtQhPHILrUMzGGHILe3Bkps18vfLysPTbftWY7PRH94UUp/5CoYWKXiir3cs1i9mAEelS/bgXeuW2w2lO7G1uBYbw+CxEg1NpydBITMh0qmVl2mZ30xDXTlKZsINW8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTlimL0E; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2057835395aso40393255ad.3;
        Sun, 15 Sep 2024 01:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726387705; x=1726992505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g//YBvaXm4NDbD/O/tpcG0z+ryfJ+nqPnLFYEOt6ung=;
        b=NTlimL0E4+Kf9YoMVDhaufyAcIOpqiGXwqOOLOTFtFj4htr2FleYzLFCGlGyWIPUAX
         XVsbG46ebx82W4YvBX60YHc3g1xo+9vs8uQcJNr288fKwyE7KRDygKCK7vlTZGBeLoJM
         v9wmQkL7jTKMOT7w2A8FkQRToQTtd7gLArVvRG043pvvMHRvXZ8i+1O+HE6DPrwtAcWl
         OuijYZ8R/P+KOFh7Kd/zFclplwcPyYAksQ0AGCxMh8CxUV5/TFf7ZNA2Wik9cNVXmz50
         lfCyZYKXiC9LA7eohwCeq0sLxs41zI5+ALH7R67Xvk/CrWzDbiOrZNAeJF3478QHG6/y
         hjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726387705; x=1726992505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g//YBvaXm4NDbD/O/tpcG0z+ryfJ+nqPnLFYEOt6ung=;
        b=oz4HuYXv3UOLSCZYs8QUTR+rjdcE0MmV9FYj4foId31J9AIn7BIXyVmx1lmoVz0nyh
         jNOZJT4MTdoL5AYFQ1xuYWpvUJ3VoV46d/9zqojlDbYlHJRGXFP6H1E0O6dR/3enui+s
         x7NKoT+EsoWdI4++JDD/lRe6ecWJlrTzd25VdCQ/mtsdTbDiOuPLce12xMd3hbh1rJ0G
         78eqd78SSznvrvfTQuKxwn6O/a6KJJkL8NBUKQQKWYyV29cpLzx2WwsIcEKjzDjI6yQe
         LDaGVhTPyeWW/KiACNJL5TyDOaqN2xWR/e1YiFCRvbe/DzAgEQeRcVrH+9i5P9rjS5V+
         XheQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+sGFg0Nlm8ZVOxJ3ylq+4b4KNQD8pCuIlHMb5Tnj865K4VxH3vc1WaPfIHwIxyX/iGTj5kRMpz8qKgg==@vger.kernel.org, AJvYcCV5gInF+Moblhb8WO7XUbQ0mrt6zZiXDjp6IQeWYt0NE3AFrSpMCel8MmfKfJU67UhnKOVrm3WAO9y+sLIiKj0=@vger.kernel.org, AJvYcCVhi+9t14njhV8/VpB23Vz3R9VNthed2UBB+m5HLYumBbJFYEcS7if708+k74NA3wMLwmVbKPlgWbqillrn@vger.kernel.org, AJvYcCXYYKk4eB/7gW5xdr9VdYEYV8UHdsIxa1AK69kOxz55xtv48oC3pJI/l6cPYIesej5rrEtrpFXN7c5D@vger.kernel.org, AJvYcCXxK45884hQfjK3I22NNKy5RjxZjgkm9Dk+BW+4vCdpRlWelooMQ5Ni3yW8CJu5x1hcSlTcWsjt+LM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf95CozKBDny7dRIihHmy1ES1YfckBAQq620lmtBjqteM87UCB
	OIsSXUqN1jFy39U7TduvCZdYtIBsO3hWw//rD8sychAt5emK4G65
X-Google-Smtp-Source: AGHT+IHdX7eWd+p3aBlKuZ6bSnf/MvFuZFPzc6/zjqFg1OTMtKAyvfO6LP8P/6z288oIM+Pt4B1/Yg==
X-Received: by 2002:a17:902:e5c3:b0:205:709e:1949 with SMTP id d9443c01a7336-2076e421fd0mr191259825ad.57.1726387705031;
        Sun, 15 Sep 2024 01:08:25 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207945db012sm18248865ad.19.2024.09.15.01.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 01:08:23 -0700 (PDT)
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
Cc: Nick Chan <towinchenmi@gmail.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH v3 03/20] dt-bindings: pinctrl: apple,pinctrl: Add A7-A11 compatibles
Date: Sun, 15 Sep 2024 15:58:48 +0800
Message-ID: <20240915080733.3565-4-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240915080733.3565-1-towinchenmi@gmail.com>
References: <20240915080733.3565-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The block found on Apple's A7-A11 SoCs are compatible with the
existing driver so add their per-SoC compatibles.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
index 9c07935919ea..63737d858944 100644
--- a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
@@ -18,6 +18,11 @@ properties:
   compatible:
     items:
       - enum:
+          - apple,s5l8960x-pinctrl
+          - apple,t7000-pinctrl
+          - apple,s8000-pinctrl
+          - apple,t8010-pinctrl
+          - apple,t8015-pinctrl
           - apple,t8103-pinctrl
           - apple,t8112-pinctrl
           - apple,t6000-pinctrl
-- 
2.46.0


