Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6A0265D46
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 12:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgIKKBz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 06:01:55 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:23526 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725710AbgIKKBy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2020 06:01:54 -0400
X-IronPort-AV: E=Sophos;i="5.76,414,1592838000"; 
   d="scan'208";a="57030369"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 Sep 2020 19:01:53 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9028E4007526;
        Fri, 11 Sep 2020 19:01:51 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH] thermal: Kconfig: Update description for RCAR_GEN3_THERMAL config
Date:   Fri, 11 Sep 2020 11:01:48 +0100
Message-Id: <20200911100148.19673-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

rcar_gen3_thermal driver is also used on Renesas RZ/G2 SoC's, update the
same to reflect the description for RCAR_GEN3_THERMAL config.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
 drivers/thermal/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index b668224f906d..7edc8dc6bbab 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -346,13 +346,13 @@ config RCAR_THERMAL
 	  thermal framework.
 
 config RCAR_GEN3_THERMAL
-	tristate "Renesas R-Car Gen3 thermal driver"
+	tristate "Renesas R-Car Gen3 and RZ/G2 thermal driver"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on HAS_IOMEM
 	depends on OF
 	help
-	  Enable this to plug the R-Car Gen3 thermal sensor driver into the Linux
-	  thermal framework.
+	  Enable this to plug the R-Car Gen3 or RZ/G2 thermal sensor driver into
+	  the Linux thermal framework.
 
 config KIRKWOOD_THERMAL
 	tristate "Temperature sensor on Marvell Kirkwood SoCs"
-- 
2.17.1

