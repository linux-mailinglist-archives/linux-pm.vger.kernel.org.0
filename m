Return-Path: <linux-pm+bounces-22396-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B5DA3B3B9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 09:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221F33A95F9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 08:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAA41CF5C0;
	Wed, 19 Feb 2025 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8j9bmZJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3171C5F30;
	Wed, 19 Feb 2025 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953729; cv=none; b=okbO9b6ODvOxpgwqEEENBWXFiaYlZ9teUy01wuk9w22BwVcv8AII2FfMCdgHuhyA8KMsrYcdezWA4nUFHZx81TY3QvDRj+2xgH5yI5XESt9MZlPaPY/8BOULjOZ30+4A2xMSbqA1Lchl+3yBkQfrooX3MCCQq4unxsQB1wVGsgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953729; c=relaxed/simple;
	bh=DH/xZMhSH8ynD52oowUymgudk5IjN6lg5l9IfRSh8ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfAYWmwX8lZ3UcKceGIMVRCEkYdy1Cjh4ORRxxGjJVt29FkeOyU9M6t9XklCd7g9AjrP+/xc1mKserzFV+bLbXwMedGluMAvYlz8tMGYQht9+RzMRMrd7eGwFHfcq0HB4WrXDxVWBdH206t14DVsjGtw4YVAn3rhM/1d7p82ZqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8j9bmZJ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54298ec925bso8711444e87.3;
        Wed, 19 Feb 2025 00:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739953721; x=1740558521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHYTZrz6GZA/L1iere2facMYU/yYLi2NzG3azmv8Y+0=;
        b=O8j9bmZJHP/kMR4Qawbo8MxocLmmJfZxBnDOX+XW8R5OFymufiIZatKXi2Bn0kyJP/
         4Dx6lJPwVNOoT5qp0YKhrB8kST3hr4qq9DpQHCnwG+he+hBI14zsB3SzZiJsJTzTJkhU
         gwmB3kxr3mw6CcTCrg/AeC998gt3HY2f0ossCtGNhMWDzTK66MqZUAAjtgPHa28r6Qgh
         5IPXewbws12xawQHAEM+LUNolb5aHD19dPTzV2LVrTrGMaItDxkEfWZBaUOdvtlvNgkZ
         dg7e9J2zzQf+/kk5SVdRby+qBXRsZc7yAFkgymi15xX17e7D/EGQ0ZvCBrBMSODl+hwo
         yc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739953721; x=1740558521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHYTZrz6GZA/L1iere2facMYU/yYLi2NzG3azmv8Y+0=;
        b=i4DX9WLiikASIp5cluJ1+zAdXvkMaerJeXtjg33OzGhH4BKN6qWHcfaSkQL4z8q8e0
         s3oiv44CH8ixAB8TXieLvgvwe5l0Ylg3CiDwT4wtYO3v3udJLCJitsTeY1mm7OfOOl8k
         92mRllCFuZ09O2t4BkiZTdG0YMQRF5CEbkR2368i5lMSgpRntEbY0NEKcNni8MoMAJNk
         BhRyVOL+IW5R2oX6R34w38/qQK5YO6ccJSjwoFjAQ9Vaxtc1Ux8sUwGgzMv09Cs6fSla
         u8NBq0gGmECFYRJWE62umrN+MHSrMNEoGYoaF3e0fUQh1adEU7DUHevtKF5rZ7BWQC0W
         kSNw==
X-Forwarded-Encrypted: i=1; AJvYcCXuBr0gEf2aH2u0a/kTLlRrzhK2HkuHhQh46Cj1PbUmrMwrg6GVDE3QOpYYUNckVvPj+DzWhcIjjmucbVpQ@vger.kernel.org, AJvYcCXy6xeKLl5zFiZADBmgjeMduQ3H95UE7dprwIACoaVA+Q7ZeJwT+XF33SR/wwf/wUk7BkHV2JGPJDST@vger.kernel.org
X-Gm-Message-State: AOJu0YzwfdwY0g0zDx8TqRbMIBgZ94rCun7b3CocnWAUGU2fkhZD6xdv
	aeCY9BLzBoM8h3tQnORNz6NWyWZHCkgbwAmGR4VTemQKMnu7VbT1
X-Gm-Gg: ASbGncs5TVVB8oKR4g+BbypprYacw3OugPku7nF6swAmQcKNqqrgJFm7M7O0ObI4WNg
	PDcDnEl5YJwHZm83/QX8cxYmxPmaen1mGbz7Vq3zWqWus1Yicaf4CJbVJ9jOfKcJbTlx+dV955+
	4v2NGC0laRxabObwxP0Axl9UHUMaf4o92h8AdQlKevhvS6Giew1jBPp8YDmlyR8bl8sPIyFNzK6
	8FUcfKm2QovTEDpuCAjfr+dRw3cvfY0wAbc1X8ZyMKX5UiUYN+F0lvkDO098201GAIKecT7ySsS
	kSmTCw==
X-Google-Smtp-Source: AGHT+IFfVVVfldOWPhpqAZS1m2hbaANoq3uHgRuujOed8KLNQB9ShoXXC6Ur37c12N6UCOCsjCOUdQ==
X-Received: by 2002:a05:6512:33cd:b0:540:1b07:e033 with SMTP id 2adb3069b0e04-5462ef2373cmr1084382e87.45.1739953721207;
        Wed, 19 Feb 2025 00:28:41 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2699d0f5sm12645911fa.78.2025.02.19.00.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 00:28:40 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] thermal: thermal-generic-adc: add temperature sensor channel
Date: Wed, 19 Feb 2025 10:28:17 +0200
Message-ID: <20250219082817.56339-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219082817.56339-1-clamor95@gmail.com>
References: <20250219082817.56339-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add IIO sensor channel along with existing thermal sensor cell. This
would benefit devices that use adc sensors to detect temperature and
need a custom conversion table.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/thermal/thermal-generic-adc.c | 54 ++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index ee3d0aa31406..a8f3b965b39b 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -7,6 +7,7 @@
  * Author: Laxman Dewangan <ldewangan@nvidia.com>
  */
 #include <linux/iio/consumer.h>
+#include <linux/iio/iio.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -73,6 +74,57 @@ static const struct thermal_zone_device_ops gadc_thermal_ops = {
 	.get_temp = gadc_thermal_get_temp,
 };
 
+static const struct iio_chan_spec gadc_thermal_iio_channel[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+	}
+};
+
+static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int *temp, int *val2, long mask)
+{
+	struct gadc_thermal_info *gtinfo = iio_priv(indio_dev);
+	int ret;
+
+	if (mask != IIO_CHAN_INFO_PROCESSED)
+		return -EINVAL;
+
+	ret = gadc_thermal_get_temp(gtinfo->tz_dev, temp);
+	if (ret < 0)
+		return ret;
+
+	*temp /= 1000;
+
+	return IIO_VAL_INT;
+}
+
+static const struct iio_info gadc_thermal_iio_info = {
+	.read_raw = gadc_thermal_read_raw,
+};
+
+static int gadc_iio_register(struct device *dev, struct gadc_thermal_info *gti)
+{
+	struct gadc_thermal_info *gtinfo;
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct gadc_thermal_info));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	gtinfo = iio_priv(indio_dev);
+	memcpy(gtinfo, gti, sizeof(struct gadc_thermal_info));
+
+	indio_dev->name = dev_name(dev);
+	indio_dev->info = &gadc_thermal_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = gadc_thermal_iio_channel;
+	indio_dev->num_channels = ARRAY_SIZE(gadc_thermal_iio_channel);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
 static int gadc_thermal_read_linear_lookup_table(struct device *dev,
 						 struct gadc_thermal_info *gti)
 {
@@ -153,7 +205,7 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 
 	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
 
-	return 0;
+	return gadc_iio_register(&pdev->dev, gti);
 }
 
 static const struct of_device_id of_adc_thermal_match[] = {
-- 
2.43.0


