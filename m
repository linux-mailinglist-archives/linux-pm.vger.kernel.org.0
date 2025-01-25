Return-Path: <linux-pm+bounces-20948-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DA6A1C24E
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jan 2025 09:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05114188A416
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jan 2025 08:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6E420765D;
	Sat, 25 Jan 2025 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0chwiUA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EF31E480;
	Sat, 25 Jan 2025 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737795074; cv=none; b=S4W77Dok/uM0OPc12Zd7KfAF0lb/T7htJzQdQEgQ2HvKCcW1Li7TbSNTlUrvwDyn/z4dsPTaQ0tcAzS5MT1iPKzjfkKa7hC8GpYoF8MdhXXuFxe309XhagL9bgZjOhVMvVwu619WvADN9PLfF4v2RMPMFrxHY1cDR9aDGTjcS88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737795074; c=relaxed/simple;
	bh=mI66l6l0huyWqgCXVfMBSqwO0h15P4BA0g6eoB4DzN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C81TC/1f5a87xJK+/C6D6uDmMi5Vph0QTmscPzZ+PWMxOfQ/LROTHlhKpStaWFNJSZ9L9Rvwn5ZAxTuXRfPoVzU7/3vz92LazRPI7NGnBvEr38DTMB0Dneey57MdPNBgNAjkTspzlHkgY157ABuUPflMa494zssdM/8i5aOrOU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0chwiUA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21675fd60feso65668855ad.2;
        Sat, 25 Jan 2025 00:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737795073; x=1738399873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBxdX+pDRGBBw2V4lK1CenNQQ1raR5rv8Dl3DBVJp/4=;
        b=A0chwiUA47FaLH9NsPfcaHM7go/XI/phP1Xc/oXg75sZ9Dm/vWjPo1S6OfJsKiQII9
         iXxVURGgRAUA01nJEXEPa+W0k+wgmuka76UsZ4GoPazx60Ie8zufFggKh63ulhu2jGKG
         S3vQdVqBP8wWC2isfj+oKZbuqCInB8FwCG2hht9UsbUsc8Y9RHfo4r9p5lTImfTI8GvC
         lfiOS7PhT+4GjzS1BWTRDWL1lK4R2KWm09QWDJWBiusplrmjeVjfOD5NgtKtvF5SqVI9
         v9bo+1HHnyJ26nzqzeqmYgr+YlVAWvgn03srbPAD7AgKvrGBCQN8aoSH2uIe4BVohNGJ
         b70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737795073; x=1738399873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBxdX+pDRGBBw2V4lK1CenNQQ1raR5rv8Dl3DBVJp/4=;
        b=rQTGOOwgREo+1obbxlMhIElTYqxKlJDr9xTbQfK9azStmjxNvt66JWfk0ms20CksjO
         UvgtAKLkWHWYJaUvAtyvU+QOkWOtM6P5pvyBhhdsTW4tBpWnxHXTHFimuaKfZb7C6zC4
         mBEEqUq5cpnTP3JX6AD4y1Q6X2Pl/rZ409dq25Btsj0yM4U6Yu7quaClCL84iO2zSR7f
         V3ubSdl+N8FydLiEmiC+XXMKiDzcJZ/0Xgkjwe7MKjQOxC5vpcFF1O7yUbraGqM1FopR
         aAyC6xcJ1+cGv874c1/UBc4nLF8E+/0aW399u/bwauiQsnsYs24rK4hn1rWpnYhueesk
         GeyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmVljJPUglNK+aabtV2b5RaYWgvuDuLVogd+/9usouQFl/jd2g7On4sHqDScWjUWfSIQyPJ1I6M2Y3BlI=@vger.kernel.org, AJvYcCXrX1AdaOF2ake4r4pTZZKd8+QTQBJ/A69MNNxL+U3ywGUAQQktPVdIlYSb+dIHnz+KM4Ty60k0Ox4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM3rx12i1Y41qcZp+qs1UPTtqxnGIEDXHAW/on3ILq9BCNgw0z
	hJrFC73mBeH8qRHBP+0af0t0X8iCp6dRYZ5r05vmuxn39Mzen3+T
X-Gm-Gg: ASbGnctv/+kanebgHRUY7Rwf4hcDjStkePgTxfiVUhGrH7T31FZ9d/FMPgOZ/56H+/d
	gzqYoWdnlnTJQ44mzRehEdzsAnhvG7BDU22ioesOTw3PjcAN3UcVTOj6qMqG3dsf0wIoVkd2gfq
	69tR+VnHAB1C6c+JegH/1ilL8xfTtwxXHxoDAo7OgACJ8l5OicqRmOG1wFuMGwyUaBEWMsx6yyh
	8AnR4g9z3XjZh14XWzxm4rNBzdCqXzR84kknctSVPeJv6VKOAXKO9qM3x8G7c+HaLpy+aa+DL+d
	CkfSCaw8Pb4=
X-Google-Smtp-Source: AGHT+IGYCHcPPJzFAwOLFsqByGZMJhSQta+6ueiLdNEcAg1/S285xQuqJARwbKjkKlRnBneHJqnaHg==
X-Received: by 2002:a17:902:e5d1:b0:215:6e01:ad07 with SMTP id d9443c01a7336-21c353ef811mr447000735ad.6.1737795072698;
        Sat, 25 Jan 2025 00:51:12 -0800 (PST)
Received: from phytium-Ubuntu.. ([218.76.62.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3ea3bc4sm27860765ad.95.2025.01.25.00.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 00:51:12 -0800 (PST)
From: zuoqian <zuoqian113@gmail.com>
To: sudeep.holla@arm.com,
	dan.carpenter@linaro.org,
	cristian.marussi@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	zuoqian <zuoqian113@gmail.com>
Subject: [PATCH v2] cpufreq: scpi: compare kHz instead of Hz
Date: Sat, 25 Jan 2025 08:49:49 +0000
Message-ID: <20250125084950.1680-1-zuoqian113@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250123075321.4442-1-zuoqian113@gmail.com>
References: <20250123075321.4442-1-zuoqian113@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CPU rate from clk_get_rate() may not be divisible by 1000
(e.g., 133333333). But the rate calculated from frequency(kHz) is
always divisible by 1000 (e.g., 133333000).
Comparing the rate causes a warning during CPU scaling:
"cpufreq: __target_index: Failed to change cpu frequency: -5".
When we choose to compare kHz here, the issue does not occur.

Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
Signed-off-by: zuoqian <zuoqian113@gmail.com>
---
V1 -> V2: rename freq to freq_khz, change rate to unsigned long, and
update patch summary.
---
 drivers/cpufreq/scpi-cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index cd89c1b9832c..9e09565e41c0 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -39,8 +39,9 @@ static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
 static int
 scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	u64 rate = policy->freq_table[index].frequency * 1000;
+	unsigned long freq_khz = policy->freq_table[index].frequency;
 	struct scpi_data *priv = policy->driver_data;
+	unsigned long rate = freq_khz * 1000;
 	int ret;
 
 	ret = clk_set_rate(priv->clk, rate);
@@ -48,7 +49,7 @@ scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 	if (ret)
 		return ret;
 
-	if (clk_get_rate(priv->clk) != rate)
+	if (clk_get_rate(priv->clk) / 1000 != freq_khz)
 		return -EIO;
 
 	return 0;
-- 
2.43.0


