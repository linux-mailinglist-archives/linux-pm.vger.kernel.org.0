Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 183E113B2A3
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 20:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgANTGi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 14:06:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34379 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbgANTGa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 14:06:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id i6so7029030pfc.1;
        Tue, 14 Jan 2020 11:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pdqFhCoobMXuCQErm2fyAM9nvtAnhN2zKc0BHszTXso=;
        b=XICSL1Rk08ZtNKUFEan9CneKTurtx+KU4l8I9KYCJJvel3de5/tnLtPzCWmhy5tWuS
         zVJOubUDyYYgFfZMSuVu6UORRh4R0C8s21pJ1m/QNOMDcN3ZLNKu/6MtF1C9jqskKbOZ
         zQLTmkbcdraiIGNfhTHDULSOzrM2hc1dNAwqe4eEVeDCY8lkA9HxRZe0yO31aeVjm+oh
         oi+SZ1Q/rG55ihhOiS8a/ZCTXezKkZLpDbz5NYUpjM3zWRQKgzd88Ppyk0X1fuc5uiLC
         06SOKTxr+xAuXG8NScl6LMDuQXAeHzzqiG27mfSvgm80c77vroHU+MzrVg/XPZE4V+Ic
         s1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pdqFhCoobMXuCQErm2fyAM9nvtAnhN2zKc0BHszTXso=;
        b=f1bZ1wwMLn2pzOe4RhV0TsePdFy+NF4MCUOZN2p8KSiZ6jp1nkpQ5vlXyP95gUBEKr
         8bMkZc2KotIaZrLUhiZ70Trx8zZbVOKZRXFCm1/3GyUGmvv2rEEUkP8Oq2eZcmmOZEUB
         L0+BI6G8eXhhL+J7Yecoz1qazp64N8M2K29oqQhoHQZqWvKCKIfRnBbBWLdbgdv1s89+
         2jrCASlWdiyt5+3g6P4yjCFV1Bpg7+I/3LVzmw9z1cnwzN1n7di50zmusG9iv1AGHk87
         A878ZP4BNd9CgFrWz/6E3YkamVdvyBkcPPfvI4/jt7Xz0aR0wRxVeRobL7Jlx6w6E9/F
         OPHg==
X-Gm-Message-State: APjAAAWLBBgZ2EW2h9qC17ozmZFIs5SE5GoewH6kIpHqR463GtYYRLlr
        m55QwQ780y7zmIRpmpqeUkN07JRH
X-Google-Smtp-Source: APXvYqzRroJjj7y1B13WecukIAzkgxjPBRhiKYGRxVC0DQon8cavTK407Wh+9iS54uf7EUBtSdwnPg==
X-Received: by 2002:aa7:9111:: with SMTP id 17mr27652957pfh.163.1579028789694;
        Tue, 14 Jan 2020 11:06:29 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a195sm19284528pfa.120.2020.01.14.11.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:06:29 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH v3 6/6] thermal: brcmstb_thermal: Register different ops per process
Date:   Tue, 14 Jan 2020 11:06:07 -0800
Message-Id: <20200114190607.29339-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200114190607.29339-1-f.fainelli@gmail.com>
References: <20200114190607.29339-1-f.fainelli@gmail.com>
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
 drivers/thermal/broadcom/brcmstb_thermal.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 6ded4b9c53be..8df5edef1ded 100644
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
@@ -311,6 +318,7 @@ MODULE_DEVICE_TABLE(of, brcmstb_thermal_id_table);
 
 static int brcmstb_thermal_probe(struct platform_device *pdev)
 {
+	const struct thermal_zone_of_device_ops *of_ops;
 	struct thermal_zone_device *thermal;
 	struct brcmstb_thermal_priv *priv;
 	struct resource *res;
@@ -331,9 +339,10 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 
 	priv->dev = &pdev->dev;
 	platform_set_drvdata(pdev, priv);
+	of_ops = priv->temp_params->of_ops;
 
 	thermal = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, priv,
-						       &of_ops);
+						       of_ops);
 	if (IS_ERR(thermal)) {
 		ret = PTR_ERR(thermal);
 		dev_err(&pdev->dev, "could not register sensor: %d\n", ret);
-- 
2.17.1

