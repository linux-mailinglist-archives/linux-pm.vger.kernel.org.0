Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8449D4FE937
	for <lists+linux-pm@lfdr.de>; Tue, 12 Apr 2022 22:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiDLUEx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Apr 2022 16:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiDLUEn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2022 16:04:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153FF517F8
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 12:55:11 -0700 (PDT)
Received: from localhost.localdomain ([37.4.249.94]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MO9qz-1nKC7Y43lB-00OUo9; Tue, 12 Apr 2022 21:54:54 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] thermal: bcm2711_thermal: Don't clamp temperature at zero
Date:   Tue, 12 Apr 2022 21:54:23 +0200
Message-Id: <20220412195423.104511-1-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+i8XMmcNKW3lfYXVWU6LxSEO33j+KiiS8sH073h7LXB4Bp+EtYy
 ktmzHl+sfrevQYkju8llxe4wY0O077uR5UUdo57ZNkbM+Fc4GXiasX/7Mv9gm2KzEIcMm26
 2fJm9tLAFP4FQUzujo40xTwSAkHpwiWV5Bm0CNU0TjELAC+TsT/W4hbAP4PTOa1RB5bXJKu
 zZFj7oNEiosWjaRqeU5dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F06av8L7Aho=:R+YpjLZuiRQPqoolWRuSpU
 0iFKdnXF6NaVNcUT6H+fmZu9y4wJd/4df5SaTcWb6idd/EU5bU1hlJnA8+VNr747ItOQ2KTO3
 e2+awDanHZZUd4JZEiOum4rG4FRppDy/xSdodH01Jh0flOw2KhQc350GItoyDuDe7KLVwnqO+
 Tv06T2gxJBcJJFGVJkMsoBb0LBMuXCqIVfpZRk5KXoMEto5sG47DfdPSpNWSfQFCtTzCtx0Gl
 PIvwxf5Tj1FHKa4MaE0V2SxfsCQlbBG2YQmQXK8KkCSJUFJ0/LOVmz4AgN7TPjpquVEomX1lL
 LehKVaUXKOBCHORl1vGEz9u/YjAnwFA/HyGi97pNQlUU2on68hpCR8Jmf+OuuQL/8MMXku15L
 +TWnGarkGGe/S5g0zCqgmxdDV4lDDYI+O2UeHvJnGCFD76yAgHufdahAZPVYcCYtSqaZ8EuT2
 d7J+bLASJe/3AJv7tKvjtp6C/ZI1K2cAHoreq/Pdlx1Fmm4fWpFsKaSE61EXXbegfin5z1tcl
 OrpYyfso9I+NRIyzXFDbGWf+NtI7ksjyE6CzDhBAxKPQnMaklhd1aQ3iwXP9Kn117CLntSsWy
 F762hjgFr2smrW53WBfBirlUhjTUV03aEQZyMerP21jP2LD1AvR8tP7eIIOQf0bg1+rBUhLNB
 +Kmn9Q93Cwx/skH44kRKoQcOKgBnhwu1fO/DN5Cp1Ys+YIIy/lYM5szRpAjvvFdG9vy4s2dH4
 ijqiOGKJGME96JMx
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal sensor on BCM2711 is capable of negative temperatures, so don't
clamp the measurements at zero. Since this was the only use for variable t,
drop it.

This change based on a patch by Dom Cobley, who also tested the fix.

Fixes: 59b781352dc4 ("thermal: Add BCM2711 thermal driver")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/thermal/broadcom/bcm2711_thermal.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2711_thermal.c b/drivers/thermal/broadcom/bcm2711_thermal.c
index 1ec57d9ecf53..e9bef5c3414b 100644
--- a/drivers/thermal/broadcom/bcm2711_thermal.c
+++ b/drivers/thermal/broadcom/bcm2711_thermal.c
@@ -38,7 +38,6 @@ static int bcm2711_get_temp(void *data, int *temp)
 	int offset = thermal_zone_get_offset(priv->thermal);
 	u32 val;
 	int ret;
-	long t;
 
 	ret = regmap_read(priv->regmap, AVS_RO_TEMP_STATUS, &val);
 	if (ret)
@@ -50,9 +49,7 @@ static int bcm2711_get_temp(void *data, int *temp)
 	val &= AVS_RO_TEMP_STATUS_DATA_MSK;
 
 	/* Convert a HW code to a temperature reading (millidegree celsius) */
-	t = slope * val + offset;
-
-	*temp = t < 0 ? 0 : t;
+	*temp = slope * val + offset;
 
 	return 0;
 }
-- 
2.25.1

