Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBC5632AA
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 10:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfGIIJp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jul 2019 04:09:45 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33572 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfGIIJo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Jul 2019 04:09:44 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AB78F200558;
        Tue,  9 Jul 2019 10:09:42 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 79F03200561;
        Tue,  9 Jul 2019 10:09:29 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E8279402E3;
        Tue,  9 Jul 2019 16:09:15 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, p.zabel@pengutronix.de, ping.bai@nxp.com,
        daniel.baluta@nxp.com, l.stach@pengutronix.de, abel.vesa@nxp.com,
        angus@akkea.ca, andrew.smirnov@gmail.com, ccaione@baylibre.com,
        agx@sigxcpu.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 2/4] opp: of: Support multiple suspend OPPs defined in DT
Date:   Tue,  9 Jul 2019 16:00:13 +0800
Message-Id: <20190709080015.43442-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190709080015.43442-1-Anson.Huang@nxp.com>
References: <20190709080015.43442-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

With property "opp-supported-hw" introduced, the OPP table
in DT could be a large OPP table and ONLY a subset of OPPs
are available, based on the version of the hardware running
on. That introduces restriction of using "opp-suspend"
property to define the suspend OPP, as we are NOT sure if the
OPP containing "opp-suspend" property is available for the
hardware running on, and the of opp core does NOT allow multiple
suspend OPPs defined in DT OPP table.

To eliminate this restrition, make of opp core allow multiple
suspend OPPs defined in DT, and pick the OPP with highest rate
and with "opp-suspend" property present to be suspend OPP, it
can speed up the suspend/resume process.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 drivers/opp/of.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index b313aca..7e8ec6c 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -617,9 +617,12 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	/* OPP to select on device suspend */
 	if (of_property_read_bool(np, "opp-suspend")) {
 		if (opp_table->suspend_opp) {
-			dev_warn(dev, "%s: Multiple suspend OPPs found (%lu %lu)\n",
-				 __func__, opp_table->suspend_opp->rate,
-				 new_opp->rate);
+			/* Pick the OPP with higher rate as suspend OPP */
+			if (new_opp->rate > opp_table->suspend_opp->rate) {
+				opp_table->suspend_opp->suspend = false;
+				new_opp->suspend = true;
+				opp_table->suspend_opp = new_opp;
+			}
 		} else {
 			new_opp->suspend = true;
 			opp_table->suspend_opp = new_opp;
-- 
2.7.4

