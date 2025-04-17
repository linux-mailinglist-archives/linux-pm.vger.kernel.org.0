Return-Path: <linux-pm+bounces-25610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 361ABA9159F
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 09:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED71017E658
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 07:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1268321C176;
	Thu, 17 Apr 2025 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Drj80sNg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD6522156A
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876011; cv=none; b=iyC+kpqGCEUteof1nU01QdxHYplTeNTs9Iy/9u+wttXKt7jsoHbxSOUMqNnh0VtPTxfnpeXLVcVO189XtbVmEYqEID5sgva58Ijlr0AbTg95uaEEwKTJrkVQDPFxVbichF0+SLc+2f+j1WyHzhvc7NtXXkyBlrdTYVPmor9YyJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876011; c=relaxed/simple;
	bh=d6IlT9ShC4wilEO6tmmh9Fe1IzuZTHCQ29TmJiiTPPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Grr7hW5JrhcIlQbME2cOOQHPbPB+BoGWLNgpAWL85Vv/ZZSNkBpIVUvXHcjFEBqFFlGlPlflBiXTCc37G44PCg8gFW/2DRt+H/zeZGXFrXIHond1aTtFsK0SV/QTRu2Mp0/eZZtmCtzWMb7Gd8ATQToFLffGAVSPYSFIbaFPePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Drj80sNg; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3913290f754so83916f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 00:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744876007; x=1745480807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iufXt7XGPWVnixx75DmjBxxr/EKI8vcJNq5OOoFoztM=;
        b=Drj80sNgO3vuNmkKhmiy5OI9x859ZXIcJ2Ge/A2acKPPZ3xTtbK8t5qYONqZPKPjmZ
         fNRduuDF+rRDwNfogxXCCBerq5Kacm8WqmjNhdTQBi6BSq/CKgcF1t5cMYArVRTrFP7T
         k23GacsS7GAprw6AZDiT8tXMTls+FncI3qqxJA3DBu4jnU7sVyQkcTqjzigmLuh+vlNE
         kcvbT67HKL8ADGh3m2Vg1HGEyopUSg2VSjYd0feG4aZLe9GSiMiB/MMQEMHfRTWcxfag
         CoIqGH22ZwxSXrXKeyYCGqVoJ4wEqBVqeHyGHYve+f9attdXhdWyvQsrjtsjYi0DStL5
         N0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744876007; x=1745480807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iufXt7XGPWVnixx75DmjBxxr/EKI8vcJNq5OOoFoztM=;
        b=DFPLgwcePAXJfX7WNDiAaJtVwy+Kcy0iyM4eEhSQVMea8fh8ItEey/zw7xyRGaQ88Q
         CHLKoL4C5ZG0FIAr57H7zgUQ7OLTmeqK0+WR7QJFZIe9EUQ7DIjb3BLFFjlHUBfPvhmk
         3/C4VaODG/gNZn4TMDO/FSwD9+nbcZjtuR7iHUA1FES8XGgfiULqBw/GAhgS08F/iFhh
         CdF23MA06CJrKdKXePa/FsHeuA/FyGGFtyS7eob5jUtHvy9TDLwZZryttWFvdMaPXtUs
         BeY9ddE48y6s0EkbSdsjSk/w7Yqo+4RiK9AfiRTO5vbVv3E2/obFV6g8OOw70WoEgPOf
         YvVg==
X-Forwarded-Encrypted: i=1; AJvYcCUQmycjda3lpmBNdY+uAN1gVgLw81y+E2IEG+Dl9pQj8XPf9AzrfRtu32dJqwm3180orW79+G9itA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Ggpo134Eiyj4rhUPnYTjLaHQNAwsYUiYDcY4U4/GpaaTpHOs
	ii42gXebh2pFptAZnXAQYy+KgORa4PimXu31RQWAuoNmHq59Qy/aMVCeCUVcHac=
X-Gm-Gg: ASbGncuqfuNJ60m2ULhhhMWBD5BVxsPEbmbvCZMIXRnJnf6aWBtZA/YiRUH6rZ1Ajw0
	yGLCsFTw4l/3tRVW341pHzis5s8ciXWkdKM/4TZ96T/ZCnDI1riSM7F6K0SAD2ZhkA8ijzau5xW
	bLgvZN2CtkzOghGx4OiWB7Jh1B4X5EQ823sNYI8DKdZ3xl4YCdEyXQq/2I32Np3bIptSbHYKuo3
	F8A0nPK7gLk24SPQZAj8ukBpJiEGKjJPW8Z0MOrcA4rneaQHBkGKerbXUvKvonOqzFs8sdXXz9s
	kQFgZJfXLNvlQLwpJkwySwiDuQM/DW10TGkn8Og5UB9voxW2/96xAGNbGpGPbSHISRUy5IkKOaa
	diJaQ/w==
X-Google-Smtp-Source: AGHT+IHN0gCWGlfh6M10BCj9GpPYoIMHd3DPtjGO5OnRlWIDylaeB61eTs5nJuHYx+5YI8rHxxIREA==
X-Received: by 2002:a5d:584a:0:b0:39a:be16:9f1e with SMTP id ffacd0b85a97d-39ee8fd638cmr684683f8f.12.1744876007476;
        Thu, 17 Apr 2025 00:46:47 -0700 (PDT)
Received: from kuoka.. (46.150.74.144.lvv.nat.volia.net. [46.150.74.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4d2ddfsm43130005e9.10.2025.04.17.00.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 00:46:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] pmdomain: arm: Do not enable by default during compile testing
Date: Thu, 17 Apr 2025 09:46:45 +0200
Message-ID: <20250417074645.81480-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling the compile test should not cause automatic enabling of all
drivers, but only allow to choose to compile them.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

For longer rationale:
https://lore.kernel.org/all/191543a8-2e2e-4ac4-9b2b-d253820a0c9f@app.fastmail.com/
---
 drivers/pmdomain/arm/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/arm/Kconfig b/drivers/pmdomain/arm/Kconfig
index efa139c34e08..afed10d382ad 100644
--- a/drivers/pmdomain/arm/Kconfig
+++ b/drivers/pmdomain/arm/Kconfig
@@ -2,7 +2,7 @@
 config ARM_SCMI_PERF_DOMAIN
 	tristate "SCMI performance domain driver"
 	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
-	default y
+	default ARM_SCMI_PROTOCOL
 	select PM_GENERIC_DOMAINS if PM
 	help
 	  This enables support for the SCMI performance domains which can be
@@ -14,7 +14,7 @@ config ARM_SCMI_PERF_DOMAIN
 config ARM_SCMI_POWER_DOMAIN
 	tristate "SCMI power domain driver"
 	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
-	default y
+	default ARM_SCMI_PROTOCOL
 	select PM_GENERIC_DOMAINS if PM
 	help
 	  This enables support for the SCMI power domains which can be
@@ -27,7 +27,7 @@ config ARM_SCMI_POWER_DOMAIN
 config ARM_SCPI_POWER_DOMAIN
 	tristate "SCPI power domain driver"
 	depends on ARM_SCPI_PROTOCOL || (COMPILE_TEST && OF)
-	default y
+	default ARM_SCPI_PROTOCOL
 	select PM_GENERIC_DOMAINS if PM
 	help
 	  This enables support for the SCPI power domains which can be
-- 
2.45.2


