Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0669F4CBE1F
	for <lists+linux-pm@lfdr.de>; Thu,  3 Mar 2022 13:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiCCMsi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Mar 2022 07:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiCCMsi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2022 07:48:38 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589FF9549E
        for <linux-pm@vger.kernel.org>; Thu,  3 Mar 2022 04:47:52 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6495:14e6:1343:3ecb])
        by laurent.telenet-ops.be with bizsmtp
        id 1onq2700A5ER6nL01onqlo; Thu, 03 Mar 2022 13:47:50 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nPks1-002XsO-TL; Thu, 03 Mar 2022 13:47:49 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nPks1-008DGD-7J; Thu, 03 Mar 2022 13:47:49 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] thermal: ti-soc-thermal: Drop comma after SoC match table sentinel
Date:   Thu,  3 Mar 2022 13:47:48 +0100
Message-Id: <8a0317505effc417b947fa2dfd53ca8e2ca6aa44.1646311640.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It does not make sense to have a comma after a sentinel, as any new
elements must be added before the sentinel.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 83a34d698414b177..40133bf52a059888 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -877,7 +877,7 @@ static struct ti_bandgap *ti_bandgap_build(struct platform_device *pdev)
  */
 static const struct soc_device_attribute soc_no_cpu_notifier[] = {
 	{ .machine = "OMAP4430" },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 /***   Device driver call backs   ***/
-- 
2.25.1

