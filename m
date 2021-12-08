Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF8746D71D
	for <lists+linux-pm@lfdr.de>; Wed,  8 Dec 2021 16:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbhLHPjd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Dec 2021 10:39:33 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:50510 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230518AbhLHPjd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Dec 2021 10:39:33 -0500
X-IronPort-AV: E=Sophos;i="5.88,189,1635174000"; 
   d="scan'208";a="102817348"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 09 Dec 2021 00:35:52 +0900
Received: from localhost.localdomain (unknown [10.226.92.71])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 318B8400AFD5;
        Thu,  9 Dec 2021 00:35:50 +0900 (JST)
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
Subject: [PATCH] thermal/drivers: Add error check for reset_control_deassert()
Date:   Wed,  8 Dec 2021 15:35:47 +0000
Message-Id: <20211208153547.3612-1-biju.das.jz@bp.renesas.com>
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
---
 drivers/thermal/rzg2l_thermal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index d47d4a30cd6c..b069cbfa6795 100644
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
+		return dev_err_probe(dev, PTR_ERR(ret), "failed to deassert");
 
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
-- 
2.17.1

