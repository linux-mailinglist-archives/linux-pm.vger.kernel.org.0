Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C5926DFA3
	for <lists+linux-pm@lfdr.de>; Thu, 17 Sep 2020 17:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgIQP3G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Sep 2020 11:29:06 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:15494 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727390AbgIQP3D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2020 11:29:03 -0400
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 11:27:58 EDT
X-IronPort-AV: E=Sophos;i="5.76,437,1592838000"; 
   d="scan'208";a="57328970"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 18 Sep 2020 00:21:53 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 12D424006C6E;
        Fri, 18 Sep 2020 00:21:51 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2] thermal: Kconfig: Update description for RCAR_GEN3_THERMAL config
Date:   Thu, 17 Sep 2020 16:21:41 +0100
Message-Id: <20200917152141.30070-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The rcar_gen3_thermal driver also supports RZ/G2 SoC's, update the
description to reflect this.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
v1->v2
* Updated commit description
* Included Ack from Niklas

v1 - https://patchwork.kernel.org/patch/11770127/
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

