Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76FFE11BDE6
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 21:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfLKUcF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 15:32:05 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35883 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfLKUcE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 15:32:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id x184so2372102pfb.3;
        Wed, 11 Dec 2019 12:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g7cIIA2fUKT3XoPncLJ8inchwLvzx7zJ6yCBfGCD0Kk=;
        b=Lf3l10NjokJTOzULJqrys4crSiRGGaVRpF7yZSm4XkNOqQe3ZXMy/OBLaU2AkIzQBz
         L1GSLt1JIzu38qUN8fPnPaCBzk5AgHB4zYdBaDOVdrzbI86OJfV6S4rX2VcS300Jj+DI
         psuofx1zEr4mAmM4/Lvsp6WseLe6l2f7gvIE86l1btmXTpcHiDrUgo0iGE5ekdnUjHwm
         i1NKzWzJMEM+C1Ar0EEAWSA5wKfkE/fNNnX/oL8MMgB/DIxnpCwvaASxofXFd8m5WiFv
         fNKjhV0ECWLPHiP/hfNOrr/Y6R6KJiemIrt2BuwGfXMFGPrQuFnlU02QJsBcR2KY+c+2
         iOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g7cIIA2fUKT3XoPncLJ8inchwLvzx7zJ6yCBfGCD0Kk=;
        b=ocZDwB3mEGFWCdfqlil8h3Y9TpNuGNc/3nO6Pf0aS8OemgchQAbPJnt25C3os0pVLy
         UH+hrH9okTLsHhRdTsO6gbO++qYDfeM1CrGIiVieMvR11n2UjHFVGZeDu+4Ck0HcluPb
         f5EwRIqTdUS0bgkWgn1WlJBDcSGcxV/Kl1cCZvsqZrrPFTxi0eI0krOjfG1qqkXpgYLm
         5/e+sABUzgeQp75tY55iPHa7XdL/aXsSkwUP8n57wfn/SUJmItKGodbcrjocsEmaEHUt
         TOKp59AQaydQ94FJHp3vzpQWZpHu9rg+GyaxDyYJ43qc1oCMix+i+bGc3tolGjrF/y78
         vhOQ==
X-Gm-Message-State: APjAAAWdc4qc9JqZ+aG70SHa6jJsvPQ8YCdqLp+w4yPiKqpDO+p+HI3q
        CBqhjrI1gdHdXACiwY2YAqs=
X-Google-Smtp-Source: APXvYqwprBE2vLChSP+ukiV9PRJ5kqS/aFkDnKefJvtf8znhGjt+UG4gh9WbCvcxO9Ut62p6AUXuvw==
X-Received: by 2002:a63:5801:: with SMTP id m1mr6150099pgb.139.1576096323582;
        Wed, 11 Dec 2019 12:32:03 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a19sm917570pju.11.2019.12.11.12.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 12:32:02 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, daniel.lezcano@linaro.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 6/6] thermal: brcmstb_thermal: Register different ops per process
Date:   Wed, 11 Dec 2019 12:31:43 -0800
Message-Id: <20191211203143.2952-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211203143.2952-1-f.fainelli@gmail.com>
References: <20191211203143.2952-1-f.fainelli@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since we do not have interrupts on BCM7216, we cannot have trip point
crossing, the thermal subsystem expects us to provide a NULL set_trips
operation in that case, so make it possible to provide per-process
thermal_zone_of_device_ops

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 47b622f33900..8170ea1b8227 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -105,6 +105,7 @@ static struct avs_tmon_trip avs_tmon_trips[] = {
 struct brcmstb_thermal_params {
 	unsigned int offset;
 	unsigned int mult;
+	const struct thermal_zone_of_device_ops *of_ops;
 };
 
 struct brcmstb_thermal_priv {
@@ -287,19 +288,25 @@ static int brcmstb_set_trips(void *data, int low, int high)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops of_ops = {
+static const struct thermal_zone_of_device_ops brcmstb_16nm_of_ops = {
 	.get_temp	= brcmstb_get_temp,
-	.set_trips	= brcmstb_set_trips,
 };
 
 static const struct brcmstb_thermal_params brcmstb_16nm_params = {
 	.offset	= 457829,
 	.mult	= 557,
+	.of_ops	= &brcmstb_16nm_of_ops,
+};
+
+static const struct thermal_zone_of_device_ops brcmstb_28nm_of_ops = {
+	.get_temp	= brcmstb_get_temp,
+	.set_trips	= brcmstb_set_trips,
 };
 
 static const struct brcmstb_thermal_params brcmstb_28nm_params = {
 	.offset	= 410040,
 	.mult	= 487,
+	.of_ops	= &brcmstb_28nm_of_ops,
 };
 
 static const struct of_device_id brcmstb_thermal_id_table[] = {
@@ -338,7 +345,7 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 
 	thermal = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, priv,
-						       &of_ops);
+						       priv->temp_params.of_ops);
 	if (IS_ERR(thermal)) {
 		ret = PTR_ERR(thermal);
 		dev_err(&pdev->dev, "could not register sensor: %d\n", ret);
-- 
2.17.1

