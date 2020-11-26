Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095632C5DD5
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 23:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbgKZWaj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 17:30:39 -0500
Received: from vsp-unauthed02.binero.net ([195.74.38.227]:39178 "EHLO
        vsp-unauthed02.binero.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388465AbgKZWai (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 17:30:38 -0500
X-Halon-ID: ff5c21c7-3036-11eb-a78a-0050569116f7
Authorized-sender: niklas.soderlund@fsdn.se
Received: from bismarck.berto.se (p4fca2458.dip0.t-ipconnect.de [79.202.36.88])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPA
        id ff5c21c7-3036-11eb-a78a-0050569116f7;
        Thu, 26 Nov 2020 23:30:34 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 3/3] thermal: rcar_gen3_thermal: Add r8a779a0 support
Date:   Thu, 26 Nov 2020 23:30:28 +0100
Message-Id: <20201126223028.3119044-4-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126223028.3119044-1-niklas.soderlund+renesas@ragnatech.se>
References: <20201126223028.3119044-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for R-Car V3U. The new THCODE values are taken from the
example in the datasheet.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 94f2c133a47f66b6..75c69fe6e9553f25 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -60,13 +60,14 @@
 #define MCELSIUS(temp)	((temp) * 1000)
 #define GEN3_FUSE_MASK	0xFFF
 
-#define TSC_MAX_NUM	3
+#define TSC_MAX_NUM	4
 
 /* default THCODE values if FUSEs are missing */
 static const int thcodes[TSC_MAX_NUM][3] = {
 	{ 3397, 2800, 2221 },
 	{ 3393, 2795, 2216 },
 	{ 3389, 2805, 2237 },
+	{ 3415, 2694, 2195 },
 };
 
 /* Structure for thermal temperature calculation */
@@ -276,6 +277,10 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
 		.compatible = "renesas,r8a77980-thermal",
 		.data = &rcar_gen3_ths_tj_1,
 	},
+	{
+		.compatible = "renesas,r8a779a0-thermal",
+		.data = &rcar_gen3_ths_tj_1,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
-- 
2.29.2

