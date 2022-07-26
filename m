Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427C7581319
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jul 2022 14:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiGZMXk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jul 2022 08:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiGZMXj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2022 08:23:39 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ED514D02
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 05:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1658838217; x=1690374217;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dI9JKgnIOeviq6/jYPE3rPuPUaDKP54yKfeQUXs+/MM=;
  b=beHw3p07vlOl60GASHat4L17/4HOX/2ucd9tppnDXBOlNNpEH2hraISD
   DhWm2DTGTo0PD+kAUf81lHhgPpL5y+5QzGy2asVD7D5f1XnmFDMw/coXw
   5DHOs8/twFaDYEi1TrhzB2IkyyHsPONEpdQsBQgYUtfNStSSo6sW2vDRs
   31aINSwZu0OgI+kAnmfNhkQo7973Q64sKA2a9k4pg7j8tvf/sXYn+K8DX
   xRWGQza76piO+fJU+HDpJkw5cqn3MkNxwVrDhQHarf9FOWsVncj5WkoAo
   e0mP7fNMu/TO1A0uUn6QN9y3LtBnFeN/u7Pqn1aBmS+aThB4oiNbzBNlb
   w==;
X-IronPort-AV: E=Sophos;i="5.93,193,1654552800"; 
   d="scan'208";a="25268033"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Jul 2022 14:23:35 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 26 Jul 2022 14:23:35 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 26 Jul 2022 14:23:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1658838215; x=1690374215;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dI9JKgnIOeviq6/jYPE3rPuPUaDKP54yKfeQUXs+/MM=;
  b=AQf0rGgwNZM1S2Ha9hXQypcjFh+PAXFWrFRBTrVkLA3qAaBf0vAmxmUb
   gG7++AgAq0HjkvwTShikY3SLvM24G9SViIozxDBWci2X1gFfB1MhcYnN/
   yHXbhWP1rorSDHuj5T0C8fKuyqYuU2Ap0jt8KLgQrPyZVh4Om0D2qcp+m
   NnFmSDIsogSSr6ShvmFkoyaYF4wppU920PjCTgUFhZJ86FH1/txcCrD/8
   blmPC878XGjTxyDzNK8iwHTyn+zYL49DNPeXPbDWtXEyOAvWv91G3hZbY
   deOXE5M3/FLcffv731/ez1qTkJBViAiu4b3b2juC7hzVX9T/76Oqw2NoP
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,193,1654552800"; 
   d="scan'208";a="25268032"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Jul 2022 14:23:35 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 07B7F280056;
        Tue, 26 Jul 2022 14:23:35 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/1] thermal: imx8mm: Add hwmon support
Date:   Tue, 26 Jul 2022 14:23:31 +0200
Message-Id: <20220726122331.323093-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Expose thermal sensors as HWMON devices.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Split from thermal_helpers patch
* No change otherwise

The helper patch need some additional work, but this can go as it is.

 drivers/thermal/imx8mm_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index af666bd9e8d4..ca8e2c393030 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -16,6 +16,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
+#include "thermal_hwmon.h"
 
 #define TER			0x0	/* TMU enable */
 #define TPS			0x4
@@ -176,6 +177,9 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 			goto disable_clk;
 		}
 		tmu->sensors[i].hw_id = i;
+
+		if (devm_thermal_add_hwmon_sysfs(tmu->sensors[i].tzd))
+			dev_warn(&pdev->dev, "failed to add hwmon sysfs attributes\n");
 	}
 
 	platform_set_drvdata(pdev, tmu);
-- 
2.25.1

