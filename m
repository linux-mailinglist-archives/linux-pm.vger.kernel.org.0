Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4044F9381
	for <lists+linux-pm@lfdr.de>; Fri,  8 Apr 2022 13:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiDHLLe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Apr 2022 07:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiDHLLd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2022 07:11:33 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052711F9
        for <linux-pm@vger.kernel.org>; Fri,  8 Apr 2022 04:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1649416169; x=1680952169;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IqnIPBsHWhvZbm8kM51kc2kEYT//7sWoxLqS4RXRUXI=;
  b=dfxjDe5ct3P7tSET9ZTcKWvchDS5rWD1FvZ8IWdKgXgS8wAME/IhXFpc
   VwgYosknbPyEcur/Gw7vc6cd1BJ0Fb52j+iaZ8hJtFbsECkfDYvILB9sT
   PoVIEz1GIaxpMa2Jqqbg324luj+YSYPgE6G+YO1UnKu3fpAzZ1VWe+hKA
   COWWDoaxHTd00PyjDpiHeuDkVv5QOHmd/NjhkU0HMTdiiVI2hxbkPPwBF
   oLhTegi2Oi9U6y3VRWcQc7UED+GpNNUmv/Bx9DJLhbUIkw1sq6GI+rinI
   0P51KHTmbBQyOtxs0xYVbIP4Zl5hGIVX0XTveKD6aXuMxFMQGqHJUMD63
   g==;
X-IronPort-AV: E=Sophos;i="5.90,244,1643670000"; 
   d="scan'208";a="23186343"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 Apr 2022 13:09:25 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 08 Apr 2022 13:09:25 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 08 Apr 2022 13:09:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1649416165; x=1680952165;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IqnIPBsHWhvZbm8kM51kc2kEYT//7sWoxLqS4RXRUXI=;
  b=GjUw6kxmTc5yuEhvC4CFnvowXbhuug0+2HRAncY0MhS30maYSWXCjPeq
   PmQ2KiIh41ULg3j28VSSZRdetACwPhetnNcRg+/WVXi1pzFqPqykx5zt+
   4cBskVtTq9kOK79kOwg2YUCNskukyTZR7FBmY0QJj0np1c+gP8eqskEOy
   +pce9mAii/ecFI7NygB8oTMkB9xyVHyWlD9tloDu5d4WdaGmxMNiAoeWe
   veRllRES6RmtDr1/xQTq4TzpjNzMJcRFXEvUi9E5YxnN3vEXdH/4b4D/5
   u9kcyFgwAE3vA/GoSGEFelnSmhAxw+uKywpRLzbmriiQLkeZMafZ2w/dD
   g==;
X-IronPort-AV: E=Sophos;i="5.90,244,1643670000"; 
   d="scan'208";a="23186342"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Apr 2022 13:09:25 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 3095E280070;
        Fri,  8 Apr 2022 13:09:25 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] thermal: imx8mm: Add hwmon support
Date:   Fri,  8 Apr 2022 13:09:19 +0200
Message-Id: <20220408110920.3809225-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Expose thermal sensors as HWMON devices.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
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

