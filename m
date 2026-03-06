Return-Path: <linux-pm+bounces-43820-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J9BDwTbqmk3XwEAu9opvQ
	(envelope-from <linux-pm+bounces-43820-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 14:47:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEB22220F0
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 14:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39B8131C103B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 13:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3603128A3;
	Fri,  6 Mar 2026 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RARZgury"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7364C30F55B
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772804066; cv=none; b=rU1RxQ/g+pmZ4QmxcnHrClXL0DCtTJiUPterIpmS/HNJRMskscv/lbm3PRA/trF9h03qGEkwMt8+SI4FLVs8LxeNVcU9Jxh/RJc70ZiZQZ0Wcp7jZ4miWxmKK52OqIIa9oFKrVm3EQGGhrJiURd6J7B9WYtU0jEtgaajxnsDrrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772804066; c=relaxed/simple;
	bh=OCqMqTV3Fk0GHlGjVJ0UFzNI1DHV1XFUgzJgSRR9AZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f71EEh0nErhqIuFLpilnatWJD4zVbRPLKHzu+HcwPtUiELyzjEV/GIl0ZiUqnmGdGMiLDSlSTpDJozY9coymN6MGZmDI4mWATc1Vu/a8kzBF9HhbkHWp7TRUuvg62xE3Q5YuSOtq7iJXBJpIF1T3DXUwR93BSdKU2aTRLX3qJew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RARZgury; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-482f454be5bso94696935e9.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 05:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772804063; x=1773408863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+87770G0UGJrf+jBGNAZwy7BjuGZ53X0m5gpUF71N68=;
        b=RARZguryO4ErVuxUbv/YdeAplJY3bpibccbpThpiYNLNRwG17J7VE6S8BWBeHmR2+Z
         QsOd/YFpG1NSzx10htZk3tk8pUE/2MddazrvFOOLieHn2F6YNNttrGzAhaDvKrSsACus
         2Rj064GoDsgbyztWp/zEtYSfDc8UiE/zZw4FoPjuMWPyyjcIJYN6tde83x4mzxO74EWl
         WBMUFcdgoyX2O/zOHO/ThiSqt4QpT3XTwKV8psQdwGA9k6LlGtTF3vAvuagO0l93VjZj
         xGS2eS66/n/N2fpWR6P80IDA1IIwgAsEKk1rlE68oEO+iOlJ4k4SFwm1QSppgwgEvou1
         l5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772804063; x=1773408863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+87770G0UGJrf+jBGNAZwy7BjuGZ53X0m5gpUF71N68=;
        b=Gzm8RAZwhzrjMNbXLyE0oNsEyJsdV9QuA8boh7Xy8K+qatIu1AudrL3fejpb4OOiKs
         lYi7szzdLpPlql86NtiJugT/axLCpV2gXf+4htBtbDMaQgvMoMgxub3d3ogaBQ+5CGte
         IYSqEoTSb1DBgPyncWval8qixZBWpbqIulLuFUp2tvIgCzsYYS98sEppEXcs+yBmfOaC
         +PysezDt4pfVwjf50RQq5mY04u8bI2+979m4NXr+64omtMD9iXVdd4mz1+Fu7uEYY5n6
         lgBUHFPoZfGM1h16V1RSCVDnZsNQT4q2Yp2aEAJfgqst0jzJCghQErmIoCwLQNyaWoXz
         5gHg==
X-Forwarded-Encrypted: i=1; AJvYcCWN60ygiEyyRpX6ivsAHkFVCKHHbN5Z/SKHvOEKnYFcQEyqaPPv643ypx79vFgmkfuYEpeByneSUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSXymw2GyoL/Hf4+RsyXNdFJGyqcNHAkhKaPHgirDLj9s3PYjz
	Isk+hnPuozwUeA5FIwMUIl65vEFhr2vcvsiTfx+CfLHGiUvE2QxAOtbY
X-Gm-Gg: ATEYQzztmlOkBYc+d7JhHZHApc6MNQ3L14SMyUQuIu4re3sAENOS6KXKsHMSEmSDrha
	XdmQ5hVThx33ZYIh/NOOFtsuCDuJDDSTigutsM0lbnptlUuHu8qmjDTdH29w2Kd4heodKjOqQny
	Fsk6wfadopydhQ0MtVRXpPegbRaM1cuNJKP1mVVRS+Xv4q3C2S91OxgBBLh+fLaSTZ9h95QLkSX
	/UCBJDsWwOjBIllgoYFVBUy3L62rtUuAcoUSqpdw+9KWLL+ZWAg4q95niqmN0AmuCnHXEi2qmhQ
	Y7krT8BHJ+u3QY+ZmG/6ssMI7ea20JchFWIimeY1QRPWvjN+9YGAvYVSjYYhtxrbvHbhunpSYfE
	kA6DRJ4YQbZQ85nXgBqDkJEKWqEoVCP9D7LaKi9jDhO9UyHbh5NZn70aW1DGjrkWfKyt9zIESoe
	D0zt0XOF64CsyL
X-Received: by 2002:a05:600c:3147:b0:481:a662:b3f3 with SMTP id 5b1f17b1804b1-4852671cbebmr31770145e9.7.1772804062705;
        Fri, 06 Mar 2026 05:34:22 -0800 (PST)
Received: from xeon ([188.163.112.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48527681a3esm80856735e9.4.2026.03.06.05.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 05:34:22 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v3 6/6] rtc: max77686: convert to i2c_new_ancillary_device
Date: Fri,  6 Mar 2026 15:33:51 +0200
Message-ID: <20260306133351.31589-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306133351.31589-1-clamor95@gmail.com>
References: <20260306133351.31589-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DDEB22220F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-43820-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,intel.com,arm.com,samsung.com,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Convert RTC I2C device creation from devm_i2c_new_dummy_device() to
i2c_new_ancillary_device() to enable the use of a device tree-specified
RTC address instead of a hardcoded value. If the device tree does not
provide an address, use hardcoded values as a fallback.

This addresses an issue with the MAX77663 PMIC, which can have the RTC at
different I2C positions (either 0x48, like the MAX77714, or 0x68, like
the MAX77620). The MAX77620 value is used as the default. The I2C position
of the MAX77663 is factory-set and cannot be detected from the chip
itself.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/rtc/rtc-max77686.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 69ea3ce75b5a..3cdfd78a07cc 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -686,6 +686,11 @@ static int max77686_rtc_init_reg(struct max77686_rtc_info *info)
 	return ret;
 }
 
+static void max77686_rtc_release_dev(void *client)
+{
+	i2c_unregister_device(client);
+}
+
 static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 {
 	struct device *parent = info->dev->parent;
@@ -713,12 +718,17 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 		goto add_rtc_irq;
 	}
 
-	client = devm_i2c_new_dummy_device(info->dev, parent_i2c->adapter,
-					   info->drv_data->rtc_i2c_addr);
+	client = i2c_new_ancillary_device(parent_i2c, "rtc",
+					  info->drv_data->rtc_i2c_addr);
 	if (IS_ERR(client))
 		return dev_err_probe(info->dev, PTR_ERR(client),
 				     "Failed to allocate I2C device for RTC\n");
 
+	ret = devm_add_action_or_reset(info->dev, max77686_rtc_release_dev,
+				       client);
+	if (ret)
+		return ret;
+
 	info->rtc_regmap = devm_regmap_init_i2c(client,
 						info->drv_data->regmap_config);
 	if (IS_ERR(info->rtc_regmap))
-- 
2.51.0


