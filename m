Return-Path: <linux-pm+bounces-2863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA0A84044E
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jan 2024 12:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CD91F22D31
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jan 2024 11:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ED460EFD;
	Mon, 29 Jan 2024 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L2VxAzQW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D93760DC9
	for <linux-pm@vger.kernel.org>; Mon, 29 Jan 2024 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529159; cv=none; b=B8HzWbSOFNd24wQ9LdAmdJJd96v6z/df+YmBABoMMMLnXZ2+gusDgxZcbuGOLMrbb/Rehi69D+TSujBsuBwbQDWDDcHqegwgothLHv7cg8Avi1oTlbvraZWNxdr3ZVHTQ/jXChrXuvvFKFMESdIUoXcnYqjiGAv2B1OY2aiknWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529159; c=relaxed/simple;
	bh=oh0sTMif6CnOQLiL5a5MmyT0hcKnwI/jjGqAII0YSDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fJqfzUI2HVAuFPE+aXaeyc8l/CZnT8sgSOw379hXnIE6u5R9MeH4Ns7EcpH52Hhw5P6QDpASi8Fic0CcL0j3awCcZqdvrVH24FjhX5Q+XJY7ALw5FluETvZVOJLKwLNOxttWnohJ63vx680ZS6k0A/YryBicFVJvKyn3UluA3I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L2VxAzQW; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55790581457so2827270a12.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jan 2024 03:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706529155; x=1707133955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRX88GpgU1fgsZxup3Gn93xc8N0Fj24AFUmctHwLfn4=;
        b=L2VxAzQWX1GxMHZawNcSSglVzdU8GE/dTzhkaUYCwbLIfIFdfglH4xrCZUS2u10rn0
         PZHJHmisvtHx2Q3t5CI7wtlfZuO+QnZ6uF2ZpdPLJWj9DWiiswTD/l36yGhVR8uS8cKu
         sNu2o27nCbjhlx07Wg5HPEtPXXS3yi70FL4WCOY1KbTkKWek1g4rqJcnoM0aYkZJCwKT
         A1cZ5NLK7jChQZPG0e+ew2gUAjE3gDDF9UmCXqWtnFDD/w6IRonTSQUvM4pMCYsGFZN+
         9sX6h2hphk5RQrhagev6fNM1JiVw9sxK+lxK+qstUEArGIOCuj5gYOWOPtaAN23F8+Sk
         /9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706529155; x=1707133955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRX88GpgU1fgsZxup3Gn93xc8N0Fj24AFUmctHwLfn4=;
        b=pZiR+qWYBz12MgJxjSn3plbD2Wv6jrbJ61/+6yNNkZVrhPbN+aL+rm62WNwygNyADD
         9/yOtNNxXEmLkY8D2gSHDDqzRxDyBiTyqCmtmab60GpBJyh0IZhZCA6UXFO8AMT2snq8
         0rooC3wmQwCcQr6Ms+snfeE9S3BTQDLirCAQTqOyEPWW/1F91r6/HWGxSJ/YYTGXgrhh
         vp++sePZK0nbJC29dUOxopbwx5tgRkOBArHPJIe8H126x4y3ugTVFc7BhS6S+oZHPguT
         GsMaxHLHMY95jqPmjEJLC3a1C3RAcmN5a9iCJZDbe+42bQTMQfThPhhCzC0BykBOPOtT
         Xzvw==
X-Gm-Message-State: AOJu0Yw5p1eEKFQdn/8BAiQ/gtegGDODAZjEaxsMW1UX8hZV2UUbeQ/N
	jsZDvxwLnzMFf/L0gCPxvdtaUEyYFF30UsfP2OWPCy0YniMKjIQDM6x8AvoUDl0=
X-Google-Smtp-Source: AGHT+IEdaNoU/u2ZWAjjwYyfTwmF1ZYX/t6iKURfjubU1MuWVDghYTbMVUM9h4+w4ZCmDBHTCFQd+A==
X-Received: by 2002:aa7:d695:0:b0:55f:72f:5caf with SMTP id d21-20020aa7d695000000b0055f072f5cafmr1120034edr.11.1706529154944;
        Mon, 29 Jan 2024 03:52:34 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id ec19-20020a0564020d5300b0055f29ececeasm19907edb.57.2024.01.29.03.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:52:34 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v6 6/6] ASoC: codecs: wsa884x: Allow sharing reset GPIO
Date: Mon, 29 Jan 2024 12:52:16 +0100
Message-Id: <20240129115216.96479-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
References: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some boards with multiple WSA8840/WSA8845 speakers, the reset
(shutdown) GPIO is shared between two speakers.  Use the reset
controller framework and its "reset-gpio" driver to handle this case.
This allows bring-up and proper handling of all WSA884x speakers on
X1E80100-CRD board.

Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

If previous patches are fine, then this commit is independent and could
be taken via ASoC.
---
 sound/soc/codecs/wsa884x.c | 53 +++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wsa884x.c b/sound/soc/codecs/wsa884x.c
index f2653df84e4a..a9767ef0e39d 100644
--- a/sound/soc/codecs/wsa884x.c
+++ b/sound/soc/codecs/wsa884x.c
@@ -13,6 +13,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_registers.h>
@@ -699,6 +700,7 @@ struct wsa884x_priv {
 	struct sdw_stream_runtime *sruntime;
 	struct sdw_port_config port_config[WSA884X_MAX_SWR_PORTS];
 	struct gpio_desc *sd_n;
+	struct reset_control *sd_reset;
 	bool port_prepared[WSA884X_MAX_SWR_PORTS];
 	bool port_enable[WSA884X_MAX_SWR_PORTS];
 	unsigned int variant;
@@ -1799,9 +1801,22 @@ static struct snd_soc_dai_driver wsa884x_dais[] = {
 	},
 };
 
-static void wsa884x_gpio_powerdown(void *data)
+static void wsa884x_reset_powerdown(void *data)
 {
-	gpiod_direction_output(data, 1);
+	struct wsa884x_priv *wsa884x = data;
+
+	if (wsa884x->sd_reset)
+		reset_control_assert(wsa884x->sd_reset);
+	else
+		gpiod_direction_output(wsa884x->sd_n, 1);
+}
+
+static void wsa884x_reset_deassert(struct wsa884x_priv *wsa884x)
+{
+	if (wsa884x->sd_reset)
+		reset_control_deassert(wsa884x->sd_reset);
+	else
+		gpiod_direction_output(wsa884x->sd_n, 0);
 }
 
 static void wsa884x_regulator_disable(void *data)
@@ -1809,6 +1824,27 @@ static void wsa884x_regulator_disable(void *data)
 	regulator_bulk_disable(WSA884X_SUPPLIES_NUM, data);
 }
 
+static int wsa884x_get_reset(struct device *dev, struct wsa884x_priv *wsa884x)
+{
+	wsa884x->sd_reset = devm_reset_control_get_optional_shared(dev, NULL);
+	if (IS_ERR(wsa884x->sd_reset))
+		return dev_err_probe(dev, PTR_ERR(wsa884x->sd_reset),
+				     "Failed to get reset\n");
+	else if (wsa884x->sd_reset)
+		return 0;
+	/*
+	 * else: NULL, so use the backwards compatible way for powerdown-gpios,
+	 * which does not handle sharing GPIO properly.
+	 */
+	wsa884x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
+						GPIOD_OUT_HIGH);
+	if (IS_ERR(wsa884x->sd_n))
+		return dev_err_probe(dev, PTR_ERR(wsa884x->sd_n),
+				     "Shutdown Control GPIO not found\n");
+
+	return 0;
+}
+
 static int wsa884x_probe(struct sdw_slave *pdev,
 			 const struct sdw_device_id *id)
 {
@@ -1838,11 +1874,9 @@ static int wsa884x_probe(struct sdw_slave *pdev,
 	if (ret)
 		return ret;
 
-	wsa884x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
-						GPIOD_OUT_HIGH);
-	if (IS_ERR(wsa884x->sd_n))
-		return dev_err_probe(dev, PTR_ERR(wsa884x->sd_n),
-				     "Shutdown Control GPIO not found\n");
+	ret = wsa884x_get_reset(dev, wsa884x);
+	if (ret)
+		return ret;
 
 	dev_set_drvdata(dev, wsa884x);
 	wsa884x->slave = pdev;
@@ -1858,9 +1892,8 @@ static int wsa884x_probe(struct sdw_slave *pdev,
 	pdev->prop.sink_dpn_prop = wsa884x_sink_dpn_prop;
 	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
 
-	/* Bring out of reset */
-	gpiod_direction_output(wsa884x->sd_n, 0);
-	ret = devm_add_action_or_reset(dev, wsa884x_gpio_powerdown, wsa884x->sd_n);
+	wsa884x_reset_deassert(wsa884x);
+	ret = devm_add_action_or_reset(dev, wsa884x_reset_powerdown, wsa884x);
 	if (ret)
 		return ret;
 
-- 
2.34.1


