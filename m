Return-Path: <linux-pm+bounces-23306-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF055A4C039
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 13:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9C21893754
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB2A211700;
	Mon,  3 Mar 2025 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7TV8fFC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C59211261;
	Mon,  3 Mar 2025 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004532; cv=none; b=Gpm8trc6eiEvy0axRoVfGXvPQb+6bwDNyvT1pZ7I9jMo9KmdjXZHG7BgE77inKoaHwaVSQe6wJy/YGsOzjW4+G/P4NHxA1SJLpzhzxufmCzxvcf5B2AA3fUsUzui8XZkB5yckzLEyVqD/Je7f6JtzC8rzi2PYKFG+Njjt3BBkl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004532; c=relaxed/simple;
	bh=/RoB+O5ZCm4Jt93NVDs+1xICxKfZ4DLQGNO3TjWMPtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFU4PeDdnuTyOEoDy2C3ToJGpKOQlLQonjKOa8irfM/DuJKaADpQhJY/QFY4Slrb88+hNc7ZZT6orpR/hhQTynmVG6zQkKeJhaxOAxrXZSDMNLniAskV2El316oswmfMmaKjhLT9j7r/zPhZ1cSqyGV34zGV8RJsMUi4QYn3YYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7TV8fFC; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30b9f7c4165so20927941fa.3;
        Mon, 03 Mar 2025 04:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741004528; x=1741609328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOGpGJnVdsS2eqbkL2yrs0irjDblflxlQ891CwEclog=;
        b=W7TV8fFC+6O9TCz9jLCPIZSfz4gejQRNrN+h2rtLMqI6dWClZR6Jxaqi1n+GGtJEnZ
         u6wgA9jgLQMMuGn1EBOu4Yx6gQ2vtNT7v5BAjklfKSQEnZpB4gm1wekA+1zjiDJh3uOc
         9ByiCqyyxOf7vEFtlzqEYXCzNQ4QM0wNnX9Yv/Evu+6hVYBTll5mLsnw9YaySNrEqiB7
         IKXlO2NUouBOIv+j3xekTBYS4BeS+mF+PTL+A61P5OWhVkI5MtZyZ4rwaZmUL+vRuwM6
         3+rwnu32QLxoYFLXNgE1hN83YI5Zk4d6zOFpwsGysf9Asec/3DDf3S6Ey2b2eKRqubDr
         0lEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741004528; x=1741609328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOGpGJnVdsS2eqbkL2yrs0irjDblflxlQ891CwEclog=;
        b=T+zeo7NLX1PXsFiSod9JToJJhWk+IOThnzQ7Rj1T+rZJNnjFYPIDXFW5NbceJb3s2/
         BhxWmc8qF5rKb9MRpLdix2G1UU4TVSUhafqe/DBpbja4m94oj8jWQqc5bzpoXTt1/YQ8
         7ddEPGmQl9o7GP1J2zF/MOtqlRwZbaB4PNu6Vfjo7m++sj868/+EtteQomkneaE37zr7
         tmS5rTxZI3jlUgjUfoGqOFTl9qRveyupE795OIvCxaKaN5HEQPtLdHl5NBxE0l6C3Ov2
         P1KhDOVr8rOHwtztNMjDjhheY/6WzIB9ecFL/jv5DChe5oP3TltZM5oOYroNMNeStX06
         i0Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXnUiT3DcpVS07PK7jFSenuJ+u8XB1Pq04SVipRNRZXXq5R2a4dBENYL9Nbd3P9ZOAAi1EaxUTOd6OU@vger.kernel.org, AJvYcCXyKvoAfhqmT78e1PCX4TelrF9CE/0IqJoXV8AuyiGfkIE2WBdofSKKalrO3PkjDDQ1bj27W8VUz4HA5zam@vger.kernel.org
X-Gm-Message-State: AOJu0YzcBdjp3L/jJEbtocF37SwtiAGk84cak2XJH5SoE9T4y0hyrGy4
	w2zetoc3Gyy8Y1k5G2jf4HRuQogGR0Vrymi2Prg+9urI/pJFTaCxQcrK5A==
X-Gm-Gg: ASbGncvQlT6fQax3jgR5kkuw/x6WNU+kFVRvGN8gLForEzNPtuhlCH3O+ypyvTQaHIp
	Y/Sgc8tXfefZFpEGgYzH2WMeGXpeEqXz4NjEescoxJ5ZakmR4bMBDc2TJ4vD2vjgk2owZlKiFQD
	8XGd5LGrHTMv9e9tF8gvRr1me7SQGMyZ/RKrpFmsJ5pEKrOGsJ5ulsUJllVTuMYaAO1hj/EFtsU
	Qi6NHZEsfktmEJv9fxJfS2+dHH5/cmtdzkBj3dI9W3Tv32C8UDOpFAk2uwJ3ow/uE6lLEsW08ks
	Qm0A+/y4TUbUCn8+Kup8lxHag5qOjmu31hs=
X-Google-Smtp-Source: AGHT+IGI1Gd+yOAoF2e2IdT9/R4jZ9Lr6thS4xPZWq9Os6HxY5dMlAcS7PgHy1ECByIHbtsiXkFQgQ==
X-Received: by 2002:a2e:bc14:0:b0:308:ee65:7f4d with SMTP id 38308e7fff4ca-30b93454590mr44700661fa.32.1741004528273;
        Mon, 03 Mar 2025 04:22:08 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b868766desm13486611fa.100.2025.03.03.04.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 04:22:07 -0800 (PST)
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
Subject: [PATCH v3 2/2] thermal: thermal-generic-adc: add temperature sensor channel
Date: Mon,  3 Mar 2025 14:21:51 +0200
Message-ID: <20250303122151.91557-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303122151.91557-1-clamor95@gmail.com>
References: <20250303122151.91557-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid duplicating sensor functionality and conversion tables, this design
allows converting an ADC IIO channel's output directly into a temperature IIO
channel. This is particularly useful for devices where hwmon isn't suitable
or where temperature data must be accessible through IIO.

One such device is, for example, the MAX17040 fuel gauge.

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


