Return-Path: <linux-pm+bounces-26437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0B7AA42C6
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 07:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A837F4C11D0
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 05:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68281E5710;
	Wed, 30 Apr 2025 05:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6QUmFs2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B49D1C69D;
	Wed, 30 Apr 2025 05:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992703; cv=none; b=LqL2Y4m6NtC7G/N8Pv4Rxq++9TrB8B7DjVRVM1HrZtlsmu0b68mRNbmam+YHSH806A92EwLuZMn9V1n2Zwm3EJy+IYhq8pKw03YPg56EMBt5ZIWMExmNecReNOI3KxyRIVhmPKGDEv5plZDwrTxVco62WzNvJGC4lgxMTcqf3hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992703; c=relaxed/simple;
	bh=34WEZ44/MrHQVgCTajt1Sr51VclPXiPMlaXERMZVGYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7BBHEG+ryjSU9j9IU7y+T1nkn7QU5oGtn5Qpg2y6da8KGnuni/zsSjrrqEWnbXNRpVUGRbV7yoilVBSxd3aZJorey9npp9+nKavpipcP4inLLx4gbOjDZ3tOsSIsZpPWp3+1CkGAOToQD9QjyewSXMMU0pR4xn2BpsVborVdus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6QUmFs2; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso10601634a12.0;
        Tue, 29 Apr 2025 22:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745992700; x=1746597500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoTjCdYidn1+RX2SwsxVZJTjHTaPgwNT5sLg483wiSo=;
        b=c6QUmFs2lf6pgfdDktBnBVYKltYD8q0w7bS/gZ2JpZaqUTDHNDRJl9N5fsKFLeZUrB
         wD2q6O6C0S+TWFob157mkvvMygrCQtcvtVg7X5NPlrGjkYcycKTyshgFBJdpaIlL40z5
         hoz6vR/ldIAFQ3V8ohMX6foGFdLvAqJYrJKZDlYAbFxXx0V4zPMZ9aXiZb/aUyOMqN3G
         etJ8zvei3sx5asWIuoq3zOd+iPwt98e5xWscoRjt7Ra6GQ6Dydy8cTnoxgvl33ec7L4c
         8gHUcWYIF/RbqvyQp6fbFs7FDONtiQ8B9g/qfDtJPmzPOt77fXUem+e6ziVr5iQx0dgS
         Nu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745992700; x=1746597500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoTjCdYidn1+RX2SwsxVZJTjHTaPgwNT5sLg483wiSo=;
        b=uFFKy1W8aMtcmLXacAYhDwhjev+UT8luvixIBeZe4BAFLWIzy3vCOYSw7Cs4u0owXS
         6nwHsvE6Ips0fSzysA4oT3KoMf27cqPVqxdJ573sExPkZqSn/wyyGjgI7sgPjseFvOg6
         Fptz+0BTv7NDOvNuUkDn6jduyc5yJCm87TsPKrYqg495R6OAtO7lO+afL9KLD6ubUmTL
         ZdUhnI0PH3cke3M+7g+Ersczb9pu4bpLDsl8EUc3wsUPREQIDG4SEdxOhmscmw/9rMgk
         uni56uBlQmEEl2/vKNPIZl86sjFxULneXilLbNS8//A0nDEUE2h/aUuTWhOOGWJtiMoW
         Jvjg==
X-Forwarded-Encrypted: i=1; AJvYcCWREBVBxjb02hzhOiLXDtfK7IU7BT4kYljwFw249XH7+gyB1nbayleqHocFGmWTlTCXQq3TOWCnGldD@vger.kernel.org, AJvYcCWVUJyZkwQ1io8/+PBamfEbbfmtCuTVIoVl9wQoONtLTEL7j5VrI4bzlC6UFb0m+5Ud+0MzuwXNQgv9NKjR@vger.kernel.org
X-Gm-Message-State: AOJu0YzSubLxA5fLPdxZgEVW1lX9gh/qMc/EQ2MQK1YPsxerc7MlxYvm
	Gb2M0ktMFzTqgq9sJXlth8ndiA1WgYI+5Aphx/s+I2iMozt1Vu7a
X-Gm-Gg: ASbGncvgAcTDbPs+a0tyuMpTbxhs5QOwGLO4JyTP92SJ9OjXZzJym1XrgTcaZSvq/3o
	hPlOzbECcLR8J+VMkr/W9ux6PWI6NM3F6TDFEGtY/wtILOjj9LRHSDZtBVQynvDm/uJ+SrJpqMa
	cqx+Dc08nGxYXADO10Fk4U6sjUPrVsLklHlEQRRvVUvDd0T1IcLS+IOqBpLha6oM1ygOGLU+Th4
	7A3bSCHYBCgKK44u23dcWFjVKajlKqLKtaYvvEvC1IV6ZQgiy5dJfN5axkXaAIUDLikWu0E45OE
	/nZR0RI/IVJ+Q560QswAHhcgqHyN8JnRZ7lbQ7jsdpA=
X-Google-Smtp-Source: AGHT+IErSYm5jnKFoKiCDwMKciBfcW9QBYd/cIiMLhbjUs0AxkjHm3VrZSevy8MCardTbXXqSoy7/g==
X-Received: by 2002:a17:907:1b0d:b0:aca:c532:cf07 with SMTP id a640c23a62f3a-acedc65d3famr222305366b.35.1745992700071;
        Tue, 29 Apr 2025 22:58:20 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41c71csm883134066b.4.2025.04.29.22.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 22:58:19 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/1] thermal: thermal-generic-adc: add temperature sensor channel
Date: Wed, 30 Apr 2025 08:58:07 +0300
Message-ID: <20250430055807.11805-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250430055807.11805-1-clamor95@gmail.com>
References: <20250430055807.11805-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid duplicating sensor functionality and conversion tables, this
design allows converting an ADC IIO channel's output directly into a
temperature IIO channel. This is particularly useful for devices where
hwmon isn't suitable or where temperature data must be accessible through
IIO.

One such device is, for example, the MAX17040 fuel gauge.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/thermal/thermal-generic-adc.c | 55 ++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index ee3d0aa31406..7c844589b153 100644
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
@@ -73,6 +74,58 @@ static const struct thermal_zone_device_ops gadc_thermal_ops = {
 	.get_temp = gadc_thermal_get_temp,
 };
 
+static const struct iio_chan_spec gadc_thermal_iio_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+	}
+};
+
+static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int *val, int *val2, long mask)
+{
+	struct gadc_thermal_info *gtinfo = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = gadc_thermal_get_temp(gtinfo->tz_dev, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
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
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*gtinfo));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	gtinfo = iio_priv(indio_dev);
+	memcpy(gtinfo, gti, sizeof(*gtinfo));
+
+	indio_dev->name = dev_name(dev);
+	indio_dev->info = &gadc_thermal_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = gadc_thermal_iio_channels;
+	indio_dev->num_channels = ARRAY_SIZE(gadc_thermal_iio_channels);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
 static int gadc_thermal_read_linear_lookup_table(struct device *dev,
 						 struct gadc_thermal_info *gti)
 {
@@ -153,7 +206,7 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 
 	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
 
-	return 0;
+	return gadc_iio_register(&pdev->dev, gti);
 }
 
 static const struct of_device_id of_adc_thermal_match[] = {
-- 
2.48.1


