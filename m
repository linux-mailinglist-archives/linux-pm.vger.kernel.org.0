Return-Path: <linux-pm+bounces-23737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD16A58D63
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 08:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49BC77A3D56
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 07:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFEE223335;
	Mon, 10 Mar 2025 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5nQZ++0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAE22222BC;
	Mon, 10 Mar 2025 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593442; cv=none; b=B0Ru+yYHx0/Txyp+8PuhT/tmVaPenMBFjY4FaT6KFSGhSNEAG6E/F5I3s7v5McEP+ww/9eTZLNtwsWkSxkTDsLdeAc4WLuAYdwL68BCGEXDceE5POSkEq/KfE/y0TRbfn0bBC4PCc5T0aDEctzutkThuycSXwnQLxGxOBaMUL4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593442; c=relaxed/simple;
	bh=IRW2DIUZjUg11Wxpe6r9qiFzm+6oup2NeqXVoEzJym4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwl+egwQXh48mE2faGMI+pVzzyu9+PmVj8cNIXv4pwBYfa1hADzkB4XWsDcScBQjRSeXPrG15E2I2S9eiVICdBBOYJFNQINx0tbfLYkdc659CUhm5Fgpa2bcWhm9Q6wMNFxv70LlOVMhRGI/arGeUVURlXsd2tPtjxb4MN3IjdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5nQZ++0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac286d4ed05so177349266b.3;
        Mon, 10 Mar 2025 00:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741593437; x=1742198237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Um6v6XdMIQ/YPUNEUAxNwsTqTXuDEykk4Jq5COm9hZ0=;
        b=L5nQZ++0DJposk6lKH7IR5UUCspl6BOG7gwNjXSLuJxn9ALXeyiqmXWc6wJAuleqpT
         mAV/VEaAdwgaH4b2DLauZcOjV6XQtS8sfM1RrsZ2pnKZ/Zz6Y9TySPEQBTv8VqxvjnBj
         yU7PoxXl0wtIzQ7RYstrqRDV0tUi5i5/nm9LhfFpcK/kl54KFxwtca/ymqoMVnHxDdL7
         fosQ4T7Qd2UdMQoMFPxy/WIYWKH4niW9GHgD5ArooUmubXn9ScWHhfQhjUTk7Bm6839c
         emZSD82JOUhkGoeTW6aoswpgZHDG+sy+6TbvncfYF7V7DC/t3C+RlUbw6OBNIp2908US
         TFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741593437; x=1742198237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Um6v6XdMIQ/YPUNEUAxNwsTqTXuDEykk4Jq5COm9hZ0=;
        b=NU3TUZnwJ/Z0kOMGDQIXYy9ZD2zc/nkNlRNZlUbQ7TON+uDiKDlIS5Qy3Fk2suQosc
         uDvUHP4tf+FManvKU7z691kzb3uauGAOslwrFsc1Zhvst1zj7PeLUtO8d4gFoYDkoWND
         mLuijwKk1Jrvzu71XDGDSLKS1EmNSknjLz0tMNWzeO2nltGYB7vk6/lyRlepE6qw7tsJ
         tocWD+swz289FuMDClepog6aKKJfE1WCZfTBt2SvzTaVQEXF9WG0CEbCMp1LmrF2F8ne
         BoFvxUUzovW9XvB57G6Ybpy6icYB5YN3dV/Rnn1IqeYB7zpSDetGJ8LBv1kJglOIKxxU
         ircg==
X-Forwarded-Encrypted: i=1; AJvYcCULGQjrqHKi55oFZqZrOwV4KQO+UMS/GxStVcwREiEvB9rDd5+diJgiumsF/jxG0pzCoedDlpBOv1Z2BJ/X@vger.kernel.org, AJvYcCW1uDsU4ShZoLbuSlf5QpWNTKwRrH2zJoDx6XaQSxjv4+KfNIXJvp1WVXxwJ4nCQvCk88yyAoLMGBL9@vger.kernel.org
X-Gm-Message-State: AOJu0YzWevfc5QOqVeX10AOpns775JcmGtTDeVkx577q7aW2Cl2S5JTQ
	oCKW2Y3jQEPlSUoH9XrSPheiOmljedDwsS7JKoI+IshX955mtU82
X-Gm-Gg: ASbGncvt8GHfAMKZfm0Cg7C6eGQJjdm+/7RHjvgfC0hkCjauuElIarBKtnDi2UwofAU
	fHx/FYLJbvL96pghG80IA8yU8g7p9eYz3NwXwJ9MsvCuYUALczfv8CQ1KftkNP6aKppPV4HbjO1
	ZUIW7ON6FvaAtscei8zufo4zg9yEL8bMvn8MGqNsMdkWxwd+PIsC9Rc1P02Oh3vL57qrV/bUHyC
	XHGEnVKM7AwSjdo4LFscg6ZhefFm2g9bLUzGNNfWl5pXmbASMzP097rXdYU86gj6Q++PN8B05Hc
	oaCePxOTfISbInSPVVrHnW6beX/T82VUkosGJEeFp3clYCU=
X-Google-Smtp-Source: AGHT+IFLKGUKxsl6twHWzzRJajNzVYfmXdVnBYN9298SUG7/OC3ET3EOjHh1Ib8lt3dCyN+uJOv1UQ==
X-Received: by 2002:a17:907:1998:b0:ac2:a473:4186 with SMTP id a640c23a62f3a-ac2a4734ebdmr264406366b.34.1741593434836;
        Mon, 10 Mar 2025 00:57:14 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2895e7e6asm274697566b.54.2025.03.10.00.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 00:57:14 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] thermal: thermal-generic-adc: add temperature sensor channel
Date: Mon, 10 Mar 2025 09:56:38 +0200
Message-ID: <20250310075638.6979-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250310075638.6979-1-clamor95@gmail.com>
References: <20250310075638.6979-1-clamor95@gmail.com>
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

The temperature data, while technically a product of conversion and thus
categorized as IIO_CHAN_INFO_PROCESSED, maintains its unscaled state
(milli-degree). To account for this, IIO_CHAN_INFO_RAW is used along with
IIO_CHAN_INFO_SCALE to provide different degrees of accuracy.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/thermal/thermal-generic-adc.c | 62 ++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index ee3d0aa31406..7dcc2e1168a4 100644
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
@@ -73,6 +74,65 @@ static const struct thermal_zone_device_ops gadc_thermal_ops = {
 	.get_temp = gadc_thermal_get_temp,
 };
 
+static const struct iio_chan_spec gadc_thermal_iio_channel[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
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
+	case IIO_CHAN_INFO_RAW:
+		ret = gadc_thermal_get_temp(gtinfo->tz_dev, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		/* scale to a degree centigrade */
+		*val = 1;
+		*val2 = 1000;
+		return IIO_VAL_FRACTIONAL;
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
@@ -153,7 +213,7 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 
 	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
 
-	return 0;
+	return gadc_iio_register(&pdev->dev, gti);
 }
 
 static const struct of_device_id of_adc_thermal_match[] = {
-- 
2.43.0


