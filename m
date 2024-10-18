Return-Path: <linux-pm+bounces-15953-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B34109A3EBE
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 14:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410AC1F24F45
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 12:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35F81D7E43;
	Fri, 18 Oct 2024 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ml+tP7aD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FB6F9DF
	for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255784; cv=none; b=JlpP7Ri2hFUzeG2dPIicb0Q6rwwr2QpwWf2OzAy9o4nb5ndxIYezgQSt8stmsmzgBbz/90INzFFousx+o/9/tYr9J7h5KMuTn/xEixhsOUOARjzNRrhlEMiy5+5nXXI6soDrA61NrGr8sxHC/YrG/O3IFoqdvWMWkYYn6p7uRzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255784; c=relaxed/simple;
	bh=hjSlU2gxSWCop+hBvftwzPuKHq8KM6fyKWuyNw14hJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nf2ouqD8BOf68xTdv82MhRXIN6sDy1YQDF57RGr9XJPzXCr1Y/KJ/Vczex+h+0dzy93yOCRd/MvZXZIFAo3vkfx9kLGTz6BSBqHYh9ff1OsmeOHZbQCKrdsqnh23IF+Voezg7x6cTCVLKRR5GLZsTqQUj3s+RH8/L5tPWlFwzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ml+tP7aD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so17408495e9.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729255780; x=1729860580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPRs0w0MxEGgnxDO7g24yPQwpAr5gvzr/mzcIR+fDQg=;
        b=ml+tP7aD5KA4obM4sOjmiz0qjNwVYxs1h224sElAXTVlrMc+fjfawXnkl8Uc5wzhap
         FyDSOkQkjcVzkkICWLD8Lw0C1MUATtEMevbNE4nXiyQ+gg4aqWX6ItSP7AML3dqdsNBM
         U0UoZD4JPxGPhTN9uWWJMa6ukOCo+JpQVt4vmbrob5NwY+/AQiSKrvmELf0FlE+xCHD+
         p6Dg6WPDKXMmnecS3zLZEx4hGfaAqpqeGZPMOYHOvJmFV5aeuOb3eE2tNiqB5NoLoNE7
         6f+yvKoOjJZbXjVxdT2UECnBTLlZJBMpFeNo76lKlvUKsJvyeuq8NlXw9/gpshexi0IO
         Y63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729255780; x=1729860580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPRs0w0MxEGgnxDO7g24yPQwpAr5gvzr/mzcIR+fDQg=;
        b=GmdnWWaacBepOihMwYrxNyQbDxmjHcndLIlNvbVRXj1vWXeQL7XAJeEe7I8f5vFgIT
         KXL65J8avqDK4678cDD5E6sFRrXQOW8ImVmFnITS92S13813OTUZsx1jZDQkKMFlpUzj
         ZAgDRzZlw6mPyTPj4+VH9BcwSV0QHBWhz87EjJkmtxEb01jq7irAOjelxN36GzzCME8y
         oSF8j60GW/4RoM+mEk64YhJnNw9wDYFfqgImEESbh4AjqqvIk1iTsuQ2+apu8ChutP/4
         O0xWCFLLex6Eso+h4uMuGyRvFE+yhojgUVZRIEUxJSbAZa6IbLpEDKLsA+PbWS89jo/w
         rGfA==
X-Forwarded-Encrypted: i=1; AJvYcCURd868hOBCRkCkGa/MxfeReoHVci9AOMDjL2xiB4ymuQYNk2n+5zr/vfRDkRaGbADLH37oJyjx7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPpohQHs/zwEch2R61Z/kMsN5fgmrjOxxnCksw42HFfhfLo1Yo
	7fcJOO2v77NnTzlU4NHME3Gfrj+fE8//v9NBzDIkM7Wj7vturEQtYSIhYVg4A2Y=
X-Google-Smtp-Source: AGHT+IEIqw8kUmJihhMwDgPJitdV2JACtgTL4TNLOBjhAV3udeTjvvchkzKbUkVpGd6jNrhJYTpzbg==
X-Received: by 2002:a05:600c:46c6:b0:42c:b220:4778 with SMTP id 5b1f17b1804b1-4316169127dmr18151415e9.33.1729255780398;
        Fri, 18 Oct 2024 05:49:40 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:45a3:93e:5196:d8ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160695d8fsm26640835e9.27.2024.10.18.05.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:49:39 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 18 Oct 2024 14:49:12 +0200
Subject: [PATCH v6 2/6] power: sequencing: qcom-wcn: improve support for
 wcn6855
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-sc8280xp-pwrseq-v6-2-8da8310d9564@linaro.org>
References: <20241018-sc8280xp-pwrseq-v6-0-8da8310d9564@linaro.org>
In-Reply-To: <20241018-sc8280xp-pwrseq-v6-0-8da8310d9564@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Johan Hovold <johan+linaro@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6994;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=wVgH0vy0LFJruCxGn7HHmD4PkWROab2fVJIQAlt3CXs=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnEllfsBsZmyRrH2pE5TQOodqN6VXrIyUAgK/g/
 9eUResIs22JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZxJZXwAKCRARpy6gFHHX
 csEbD/9s1CuSb8y7vzkO3hEQvtki5RwrD/clMXivveK+FJM0HtjKoBFKACCorQwUOgO8Q1XwRfq
 lNAnxYdBCxwWxjvD0YpRTrxd3iTR02vO+iAPoTAa8L79c+/Ee1H+4aeu9CjzlxQSiLbeH1eFi0o
 bk2lRh4fbRXs74wV2OaMgHVtJMPFWJvD87nVihzua17MO15cF9JeCUMw1zUhsZu6nJs5STyp2pE
 kWdUd9BE0XCqEg6WiqZcwyHL5XamvFCH7m6eY2tyOTMpCQ4vWGV18X605S8BAWRNP4G5JloMbvV
 vf6Dwg2Ug7dTApd1ciVgsNbrJt0aYFr8ogTdtzKCFAwB7d87BsjKJfisUwIzBoZUmMUNKev2vZY
 g9DjkZ3iMTcYQbBgs8TK7I5H9zORYh9mMeK3rcco+dml6hzhYvZuPhbi+CmFhe/ApOzSXia+h0l
 TR5YuL0tqU8XYNmxM930Vdz5myAWFx7os8d4D/V3QbsQz1ovn64umdCdsE2U64LejuGES8f3g5u
 ZaTKpOyj/Zlg0D51DjYVUvKLMdzgQHTvhyVbX1ndFTNXpn+njABx6iDAEuh+/jyF2nN5khs8k2h
 R8Eb6knpNu+REUIqtXRWaxKeQgd2W1nCqBMviwjD2moNcqySo3nc2vN4Q/dn9x9tkI7qFfQvT7w
 qi0ba9tYsZPBmdA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

WCN6855 (also known as QCA6490) is similar to the already supported
QCA6390 but takes in two more supplies so add a new vregs list for it.

On sm8450-hdk it also requires a short assert of the xo-clk pin so add
handling for it in a dedicated unit.

As we now have a separate set of targets for this variant, store the
pointer to the targets struct associated with a model in the device
match data.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 101 ++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 3 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index 4fa129877d7e..682a9beac69e 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -22,6 +22,7 @@ struct pwrseq_qcom_wcn_pdata {
 	size_t num_vregs;
 	unsigned int pwup_delay_ms;
 	unsigned int gpio_enable_delay_ms;
+	const struct pwrseq_target_data **targets;
 };
 
 struct pwrseq_qcom_wcn_ctx {
@@ -31,6 +32,7 @@ struct pwrseq_qcom_wcn_ctx {
 	struct regulator_bulk_data *regs;
 	struct gpio_desc *bt_gpio;
 	struct gpio_desc *wlan_gpio;
+	struct gpio_desc *xo_clk_gpio;
 	struct clk *clk;
 	unsigned long last_gpio_enable_jf;
 };
@@ -98,6 +100,33 @@ static const struct pwrseq_unit_data *pwrseq_qcom_wcn_unit_deps[] = {
 	NULL
 };
 
+static int pwrseq_qcom_wcn6855_clk_assert(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	if (!ctx->xo_clk_gpio)
+		return 0;
+
+	msleep(1);
+
+	gpiod_set_value_cansleep(ctx->xo_clk_gpio, 1);
+	usleep_range(100, 200);
+
+	return 0;
+}
+
+static const struct pwrseq_unit_data pwrseq_qcom_wcn6855_xo_clk_assert = {
+	.name = "xo-clk-assert",
+	.enable = pwrseq_qcom_wcn6855_clk_assert,
+};
+
+static const struct pwrseq_unit_data *pwrseq_qcom_wcn6855_unit_deps[] = {
+	&pwrseq_qcom_wcn_vregs_unit_data,
+	&pwrseq_qcom_wcn_clk_unit_data,
+	&pwrseq_qcom_wcn6855_xo_clk_assert,
+	NULL
+};
+
 static int pwrseq_qcom_wcn_bt_enable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
@@ -125,6 +154,13 @@ static const struct pwrseq_unit_data pwrseq_qcom_wcn_bt_unit_data = {
 	.disable = pwrseq_qcom_wcn_bt_disable,
 };
 
+static const struct pwrseq_unit_data pwrseq_qcom_wcn6855_bt_unit_data = {
+	.name = "wlan-enable",
+	.deps = pwrseq_qcom_wcn6855_unit_deps,
+	.enable = pwrseq_qcom_wcn_bt_enable,
+	.disable = pwrseq_qcom_wcn_bt_disable,
+};
+
 static int pwrseq_qcom_wcn_wlan_enable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
@@ -152,6 +188,13 @@ static const struct pwrseq_unit_data pwrseq_qcom_wcn_wlan_unit_data = {
 	.disable = pwrseq_qcom_wcn_wlan_disable,
 };
 
+static const struct pwrseq_unit_data pwrseq_qcom_wcn6855_wlan_unit_data = {
+	.name = "wlan-enable",
+	.deps = pwrseq_qcom_wcn6855_unit_deps,
+	.enable = pwrseq_qcom_wcn_wlan_enable,
+	.disable = pwrseq_qcom_wcn_wlan_disable,
+};
+
 static int pwrseq_qcom_wcn_pwup_delay(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
@@ -162,6 +205,18 @@ static int pwrseq_qcom_wcn_pwup_delay(struct pwrseq_device *pwrseq)
 	return 0;
 }
 
+static int pwrseq_qcom_wcn6855_xo_clk_deassert(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	if (ctx->xo_clk_gpio) {
+		usleep_range(2000, 5000);
+		gpiod_set_value_cansleep(ctx->xo_clk_gpio, 0);
+	}
+
+	return pwrseq_qcom_wcn_pwup_delay(pwrseq);
+}
+
 static const struct pwrseq_target_data pwrseq_qcom_wcn_bt_target_data = {
 	.name = "bluetooth",
 	.unit = &pwrseq_qcom_wcn_bt_unit_data,
@@ -174,12 +229,30 @@ static const struct pwrseq_target_data pwrseq_qcom_wcn_wlan_target_data = {
 	.post_enable = pwrseq_qcom_wcn_pwup_delay,
 };
 
+static const struct pwrseq_target_data pwrseq_qcom_wcn6855_bt_target_data = {
+	.name = "bluetooth",
+	.unit = &pwrseq_qcom_wcn6855_bt_unit_data,
+	.post_enable = pwrseq_qcom_wcn6855_xo_clk_deassert,
+};
+
+static const struct pwrseq_target_data pwrseq_qcom_wcn6855_wlan_target_data = {
+	.name = "wlan",
+	.unit = &pwrseq_qcom_wcn6855_wlan_unit_data,
+	.post_enable = pwrseq_qcom_wcn6855_xo_clk_deassert,
+};
+
 static const struct pwrseq_target_data *pwrseq_qcom_wcn_targets[] = {
 	&pwrseq_qcom_wcn_bt_target_data,
 	&pwrseq_qcom_wcn_wlan_target_data,
 	NULL
 };
 
+static const struct pwrseq_target_data *pwrseq_qcom_wcn6855_targets[] = {
+	&pwrseq_qcom_wcn6855_bt_target_data,
+	&pwrseq_qcom_wcn6855_wlan_target_data,
+	NULL
+};
+
 static const char *const pwrseq_qca6390_vregs[] = {
 	"vddio",
 	"vddaon",
@@ -196,13 +269,28 @@ static const struct pwrseq_qcom_wcn_pdata pwrseq_qca6390_of_data = {
 	.num_vregs = ARRAY_SIZE(pwrseq_qca6390_vregs),
 	.pwup_delay_ms = 60,
 	.gpio_enable_delay_ms = 100,
+	.targets = pwrseq_qcom_wcn_targets,
+};
+
+static const char *const pwrseq_wcn6855_vregs[] = {
+	"vddio",
+	"vddaon",
+	"vddpmu",
+	"vddpmumx",
+	"vddpmucx",
+	"vddrfa0p95",
+	"vddrfa1p3",
+	"vddrfa1p9",
+	"vddpcie1p3",
+	"vddpcie1p9",
 };
 
 static const struct pwrseq_qcom_wcn_pdata pwrseq_wcn6855_of_data = {
-	.vregs = pwrseq_qca6390_vregs,
-	.num_vregs = ARRAY_SIZE(pwrseq_qca6390_vregs),
+	.vregs = pwrseq_wcn6855_vregs,
+	.num_vregs = ARRAY_SIZE(pwrseq_wcn6855_vregs),
 	.pwup_delay_ms = 50,
 	.gpio_enable_delay_ms = 5,
+	.targets = pwrseq_qcom_wcn6855_targets,
 };
 
 static const char *const pwrseq_wcn7850_vregs[] = {
@@ -219,6 +307,7 @@ static const struct pwrseq_qcom_wcn_pdata pwrseq_wcn7850_of_data = {
 	.vregs = pwrseq_wcn7850_vregs,
 	.num_vregs = ARRAY_SIZE(pwrseq_wcn7850_vregs),
 	.pwup_delay_ms = 50,
+	.targets = pwrseq_qcom_wcn_targets,
 };
 
 static int pwrseq_qcom_wcn_match(struct pwrseq_device *pwrseq,
@@ -295,6 +384,12 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
 				     "Failed to get the WLAN enable GPIO\n");
 
+	ctx->xo_clk_gpio = devm_gpiod_get_optional(dev, "xo-clk",
+						   GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->xo_clk_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->xo_clk_gpio),
+				     "Failed to get the XO_CLK GPIO\n");
+
 	/*
 	 * Set direction to output but keep the current value in order to not
 	 * disable the WLAN module accidentally if it's already powered on.
@@ -313,7 +408,7 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 	config.owner = THIS_MODULE;
 	config.drvdata = ctx;
 	config.match = pwrseq_qcom_wcn_match;
-	config.targets = pwrseq_qcom_wcn_targets;
+	config.targets = ctx->pdata->targets;
 
 	ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
 	if (IS_ERR(ctx->pwrseq))

-- 
2.43.0


