Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D982F17BAD5
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 11:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgCFKzK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 05:55:10 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:49722 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgCFKzJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 05:55:09 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id Ayv72200g5USYZQ01yv7nw; Fri, 06 Mar 2020 11:55:08 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jAAdH-000479-Qz; Fri, 06 Mar 2020 11:55:07 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jAAdH-0006KG-Oh; Fri, 06 Mar 2020 11:55:07 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] thermal: rcar_gen3_thermal: Add r8a77961 support
Date:   Fri,  6 Mar 2020 11:55:03 +0100
Message-Id: <20200306105503.24267-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200306105503.24267-1-geert+renesas@glider.be>
References: <20200306105503.24267-1-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for the Thermal Sensor/Chip Internal Voltage Monitor in the
R-Car M3-W+ (R8A77961) SoC.

According to the R-Car Gen3 Hardware Manual Errata for Revision 2.00 of
Jan 31, 2020, the thermal parameters for R-Car M3-W+ are the same as for
R-Car M3-W.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/thermal/rcar_gen3_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 72877bdc072daaed..a6b0c31f1509c45c 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -324,6 +324,10 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
 		.compatible = "renesas,r8a7796-thermal",
 		.data = &rcar_gen3_ths_tj_1_m3_w,
 	},
+	{
+		.compatible = "renesas,r8a77961-thermal",
+		.data = &rcar_gen3_ths_tj_1_m3_w,
+	},
 	{
 		.compatible = "renesas,r8a77965-thermal",
 		.data = &rcar_gen3_ths_tj_1,
-- 
2.17.1

