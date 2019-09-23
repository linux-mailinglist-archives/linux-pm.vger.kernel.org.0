Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A40CBB6A6
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2019 16:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407984AbfIWO0A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 10:26:00 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:52316 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407439AbfIWO0A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2019 10:26:00 -0400
X-IronPort-AV: E=Sophos;i="5.64,540,1559487600"; 
   d="scan'208";a="27259438"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Sep 2019 23:25:58 +0900
Received: from be1yocto.ree.adwin.renesas.com (unknown [172.29.43.62])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1416140078B2;
        Mon, 23 Sep 2019 23:25:55 +0900 (JST)
From:   Biju Das <biju.das@bp.renesas.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Biju Das <biju.das@bp.renesas.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] thermal: rcar_gen3_thermal: Add r8a774b1 support
Date:   Mon, 23 Sep 2019 15:25:46 +0100
Message-Id: <1569248746-56718-1-git-send-email-biju.das@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add r8a774b1 specific compatible string.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index a564633..ca214b2 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -315,6 +315,10 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
 		.data = &rcar_gen3_ths_tj_1_m3_w,
 	},
 	{
+		.compatible = "renesas,r8a774b1-thermal",
+		.data = &rcar_gen3_ths_tj_1,
+	},
+	{
 		.compatible = "renesas,r8a7795-thermal",
 		.data = &rcar_gen3_ths_tj_1,
 	},
-- 
2.7.4

