Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C376EA33A
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 19:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfJ3SWX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 14:22:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37063 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfJ3SWX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 14:22:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id p1so2025194pgi.4;
        Wed, 30 Oct 2019 11:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RMrszFJgqQZnz4BQZjFom+3bPfD40qA/+5eRpXchJeY=;
        b=NS0T9NTn2sGO0rWBgW+4jVzupq39TCXDMIQTAD01DlJUEUxJasNRvYxTN7lhEcBxAO
         MJnXnU2YnlB5hJLWIYhhQJPobtXE07VNl3h8cPpZX3RaQK2Pqvysp1i2oTAKqoR3uMdB
         f74lLKWqLpqaNrN2EaQK/FTBSE2S4Qv2LdoxZObnuHBUKJCh31lwglekb9hOGGovtoVY
         W3N8p/9IH+gPHj8dmWQ0VB+tMf4EwMbPdE1UrNf6MUdlk3VrGn2jM11wUEeN7LnpIuAv
         MI2oK0TN/QUT5PpN2X0uZKU1TKX2+lL87m6iXHXsAGNam2rQmBqKAl9+YixKSr966MBy
         6BUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RMrszFJgqQZnz4BQZjFom+3bPfD40qA/+5eRpXchJeY=;
        b=NPCYaMQfY34Vx4j63qVjirfOVw/pUqqpcXuoxMi0keLQp4pQ1Y8VDwtSL/fsd1veSv
         PSwNpljDVgfDe6ruv9sPJf6yAhvJBvRbyZcd2JggHwVQyfg4cfMO5VQ+71faau1H2VWx
         oK9ZQL+ZqD8X4yO32C1Y//tvyp64+kORw125TsQ+miQxftSmcfHKnHVhXQ6GoB93G3HS
         q/r5VXtwpt8VljHbF0N8bB3ANfJ+94nKkYoctwgJIxdtZoYke5o9HMnAIfDow4V6mFW0
         F5IGPuFrHicQ9ifhiMGisz6dUX7in7hn5voVQ5Ft+3slDRMu8NmGiu2FWmO+V8YLBh2Y
         WQPg==
X-Gm-Message-State: APjAAAXCbMGqaWhNb4jbdW2C7SwulJvr5F8Y2HVQCEsRt1l/Gdh0Ud0L
        Xci40t4oANxmw0j+0ziinrgPnFgC
X-Google-Smtp-Source: APXvYqx5ES4peqb/VFYaSUgBoAeQE3RpPCPQ5SNkOCGGUcY1JED3KHtlljdhgijC8J6e++KDRJUf4A==
X-Received: by 2002:a17:90a:d58f:: with SMTP id v15mr767564pju.17.1572459741909;
        Wed, 30 Oct 2019 11:22:21 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z5sm521637pgi.19.2019.10.30.11.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 11:22:21 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 6/6] thermal: brcmstb_thermal: Register different ops per process
Date:   Wed, 30 Oct 2019 11:21:32 -0700
Message-Id: <20191030182132.25763-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030182132.25763-1-f.fainelli@gmail.com>
References: <20191030182132.25763-1-f.fainelli@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since we do not have interrupts on BCM7216, we cannot have trip point
crossing, the thermal subsystem expects us to provide a NULL set_trips
operation in that case, so make it possible to provide per-process
thermal_zone_of_device_ops

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 64f715053ce9..a75a335d1bb3 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -96,6 +96,7 @@ static struct avs_tmon_trip avs_tmon_trips[] = {
 struct brcmstb_thermal_params {
 	unsigned int offset;
 	unsigned int mult;
+	const struct thermal_zone_of_device_ops *of_ops;
 };
 
 struct brcmstb_thermal_priv {
@@ -278,19 +279,25 @@ static int brcmstb_set_trips(void *data, int low, int high)
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
@@ -329,7 +336,7 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 
 	thermal = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, priv,
-						       &of_ops);
+						       priv->temp_params.of_ops);
 	if (IS_ERR(thermal)) {
 		ret = PTR_ERR(thermal);
 		dev_err(&pdev->dev, "could not register sensor: %d\n", ret);
-- 
2.17.1

