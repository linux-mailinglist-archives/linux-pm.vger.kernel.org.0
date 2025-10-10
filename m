Return-Path: <linux-pm+bounces-35907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C992BCCBF8
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 13:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 871BD34A060
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 11:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E4C2F0C6C;
	Fri, 10 Oct 2025 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="vlNOeGig"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2BA2EDD76
	for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095437; cv=none; b=QDKdyf91/StBMr5xFPQe9rwCwXUJ3ioA9mJG6Fbj0cOmGkxLWU4UgBW27ZLDdX+i23ARLd6Prd5ky6pgrZfd4qitS+jLhVBMN7Se5vQGF1qrhF3p4CCp2nrwIR41fwqKl+Is3wR0XS7FHoiAnzpefU6q+/T8eyeJcKcl8XLIK0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095437; c=relaxed/simple;
	bh=rybSxxhw1JotC0EVvnPnvDxaGD0GBvkGpkXdb1a1CO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DIv5DUHZIVUDkLg55BTKDydIgrT0p5a4hDMbJFY9RkxXNpzCTBjldWuO655xU8jxspNmfaDiobBfgFDdqwCP/dzGyrTzNAGnea8mW3I/yeoxX/NoNaT6ZjwzU+rSEf0NXpInZ254ycoBW8eaGK7jbVEzxYOu4dr0xdewcjgroc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=vlNOeGig; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b50206773adso550607566b.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 04:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760095433; x=1760700233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JR1QbCUpiXRUCwLKLdHPO8x+lkjmFTnSPPaWi/d3ZRE=;
        b=vlNOeGigQ4qhYttAwAyDs+DLpQsokD7pjZ1ROsEYA/Yy+w/2LIecSmts+rkyT/1cWH
         kRLa/UX7Z7JUQRNNN7Ormu7dwXDJlJuCgYSSbfpBWDp7HAdiGkkxV4JMOpYOEb14v49O
         ethk+l/8dEMnnDQavUIyGMDByCbUy+CSlSFtf/GPqMdTaJpWoS+6TGMa9d/50ZqTxdrN
         W1/DI9HP6Yr2x3Pv7VS7GpWpwskIAwAxzMsboOFWjPp1xnFUuJEzfGbruxeKGQIsS6Hs
         K367uW091ssZ2ZwzAI+v7tXkiYXlDvXTA0QynKdOqKdW9qo/S2DqkQTWaUodGq/KZ5gq
         IUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760095433; x=1760700233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JR1QbCUpiXRUCwLKLdHPO8x+lkjmFTnSPPaWi/d3ZRE=;
        b=HoAaKnbUo6iZLPDkIhMA0wTXU2k2ZRUBU9BLo8z2AcQNMQxbhGCiX31r+X57Yar8VN
         cAncBM3uy5LotCCfl435vQ+yOhumVRVxTSrBQPwqTzs9j0KASJLDlleH5oVtABhvfcEA
         P+R5o6EueThyBpJ46bAuFRbpQVGKaoC4r0Kn1ZRFAkKXctdh1PD2l8pTJ6J+7pPX0Ery
         SvPRAb7t3EMi3bZIoxkYqNb4287ZI0Oc1Tvst0eB2cSUT7QT7YSmwqw0uZcPL/kwVmQs
         9J3ghzJVDUtDOnSWrdTs21Q8lmaBUsg6qFf7csT7CBwJlmhlk4cyrkss3T/3ZkdSeRVk
         BLMA==
X-Forwarded-Encrypted: i=1; AJvYcCUYFo0KwUJMsaCBSCzzE5jzOXkm8R0ZvYPl62JU+FIVBrPziFO/5no1pLdSAnmXFX4r/Dc20+L7IQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtvQTPfXn4+J9KadXlHh7IsrwHNb25UJMTDoC1qddjNChi0D5J
	/qqbrXm5pL3LZEvW+e1FE1CDKDB/GaZtC5vlJzf9vmo1bCb5DvpMKDNDWHa5VD0grbk=
X-Gm-Gg: ASbGncuU72msizXx7L/5d5LH0ngx76J2qf1mE7VHRfYU5uzNg2dFULkP35oSOGou9EP
	aC8kT7W3yP2C9gKsazFuObx8irhw+BXn8hNQ+ef+jdhkbZZk32MYsnhvic+s1eZLG9+bvfDeNQ/
	0h/ohinvUK90nF8i6+bJk+tNZzOmu+UB2u+1wdp9rgQ6JF+qm0y3qCG4aM23siLuWGpZRk7oBHz
	dri7MBEKiHTE17RQriKJTvnDYVFrUEbreWkKWveuBCnem3q36RO+6u0zBMZS0bhnNlW0hqZguIj
	xLKN3R8NpT7aEw1EA6PfaPC1YKYhl1yAkmJK/KTgUlnm+bjI1OctJ0jM3kNyOE5Y8PngOk5sBnL
	ra2mL5HG/TzE6DOsdcYk6yB2H7qirQ7tjpuaz2haJiFW1fZdzT26SS+k9SVMgnbn+M42dXgu6Wa
	Uk0+W1qH8468h7e7X6HMw=
X-Google-Smtp-Source: AGHT+IFLrf/4N+O+0nhBGG1lU67A0rcFh0CE0ABq2ryOs2uijVAnZxJ+WemBal4mL43bCWhHez8qkw==
X-Received: by 2002:a17:906:794b:b0:b41:8ad3:1b5c with SMTP id a640c23a62f3a-b50bd23ebebmr1530935566b.13.1760095433066;
        Fri, 10 Oct 2025 04:23:53 -0700 (PDT)
Received: from [172.16.240.99] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d900bf8csm209905766b.59.2025.10.10.04.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 04:23:52 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 10 Oct 2025 13:22:01 +0200
Subject: [PATCH RFC 3/6] thermal/drivers/generic-adc: Register as IIO
 device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-bat-temp-adc-v1-3-d51ec895dac6@fairphone.com>
References: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
In-Reply-To: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760095429; l=2769;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=rybSxxhw1JotC0EVvnPnvDxaGD0GBvkGpkXdb1a1CO8=;
 b=3PsVEzygrJHYdPvkcHsM4cNpPtkZ6H6GZeqjAfQBvgyjpuGjMffNHRlKsNnJiWIsW72DwVl+4
 tJVfZBOE+MdB3TU+4/hGB+hucyEo+AFPGN0Ut3L21wrUf4hpyVs05hK
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Register an IIO channel to allow reading the temperature using the IIO
interface.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/thermal/thermal-generic-adc.c | 56 +++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index ee3d0aa31406..14aef682e0fb 100644
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
@@ -23,6 +24,10 @@ struct gadc_thermal_info {
 	int nlookup_table;
 };
 
+struct gadc_iio {
+	struct gadc_thermal_info *gti;
+};
+
 static int gadc_thermal_adc_to_temp(struct gadc_thermal_info *gti, int val)
 {
 	int temp, temp_hi, temp_lo, adc_hi, adc_lo;
@@ -115,10 +120,44 @@ static int gadc_thermal_read_linear_lookup_table(struct device *dev,
 	return 0;
 }
 
+static int gadc_adc_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct gadc_iio *data = iio_priv(indio_dev);
+	int iio_val;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = iio_read_channel_processed(data->gti->channel, &iio_val);
+		if (ret < 0)
+			return ret;
+
+		*val = gadc_thermal_adc_to_temp(data->gti, iio_val);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info gadc_adc_info = {
+	.read_raw = &gadc_adc_read_raw,
+};
+
+static const struct iio_chan_spec gadc_adc_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+	},
+};
+
 static int gadc_thermal_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct gadc_thermal_info *gti;
+	struct iio_dev *indio_dev;
+	struct gadc_iio *data;
 	int ret;
 
 	if (!dev->of_node) {
@@ -153,6 +192,23 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 
 	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
 
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->gti = gti;
+
+	indio_dev->name = pdev->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &gadc_adc_info;
+	indio_dev->channels = gadc_adc_channels;
+	indio_dev->num_channels = ARRAY_SIZE(gadc_adc_channels);
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register IIO device\n");
+
 	return 0;
 }
 

-- 
2.51.0


