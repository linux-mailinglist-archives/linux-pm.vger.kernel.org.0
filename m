Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64A346D8AC
	for <lists+linux-pm@lfdr.de>; Wed,  8 Dec 2021 17:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbhLHQns (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Dec 2021 11:43:48 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:38284 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234715AbhLHQns (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Dec 2021 11:43:48 -0500
X-IronPort-AV: E=Sophos;i="5.88,190,1635174000"; 
   d="scan'208";a="102820885"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 09 Dec 2021 01:40:15 +0900
Received: from localhost.localdomain (unknown [10.226.92.71])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A22B7400F7AA;
        Thu,  9 Dec 2021 01:40:12 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] thermal/drivers: Add error check for reset_control_deassert()
Date:   Wed,  8 Dec 2021 16:40:09 +0000
Message-Id: <20211208164010.4130-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If reset_control_deassert() fails, then we won't be able to access
the device registers. Therefore check the return code of
reset_control_deassert() and bail out in case of error.

While at it replace the parameter "&pdev->dev" -> "dev" in
devm_reset_control_get_exclusive().

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
v1->v2:
 * removed the cast operation "PTR_ERR(ret)" -> ret
 * Added Rb tag from Philipp.
---
 drivers/thermal/rzg2l_thermal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index d47d4a30cd6c..7a9cdc1f37ca 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -170,12 +170,14 @@ static int rzg2l_thermal_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 
 	priv->dev = dev;
-	priv->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	priv->rstc = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(priv->rstc))
 		return dev_err_probe(dev, PTR_ERR(priv->rstc),
 				     "failed to get cpg reset");
 
-	reset_control_deassert(priv->rstc);
+	ret = reset_control_deassert(priv->rstc);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to deassert");
 
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
-- 
2.17.1

