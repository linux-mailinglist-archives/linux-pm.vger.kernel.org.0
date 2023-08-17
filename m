Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBCE77EED8
	for <lists+linux-pm@lfdr.de>; Thu, 17 Aug 2023 03:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345198AbjHQBtY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Aug 2023 21:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347596AbjHQBtU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 21:49:20 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C47B270A;
        Wed, 16 Aug 2023 18:49:18 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RR7Dq3LjMz1GDjn;
        Thu, 17 Aug 2023 09:47:55 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 09:49:16 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <edubezval@gmail.com>, <j-keerthy@ti.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <amitk@kernel.org>,
        <rui.zhang@intel.com>
CC:     <lizetao1@huawei.com>, <linux-pm@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH -next] thermal: ti-soc-thermal: Use helper function IS_ERR_OR_NULL()
Date:   Thu, 17 Aug 2023 09:49:00 +0800
Message-ID: <20230817014900.3094512-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use IS_ERR_OR_NULL() to detect an error pointer or a null pointer
open-coding to simplify the code.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index a1c9a1530183..0c2eb9c6e58b 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -314,7 +314,7 @@ int ti_bandgap_adc_to_mcelsius(struct ti_bandgap *bgp, int adc_val, int *t)
  */
 static inline int ti_bandgap_validate(struct ti_bandgap *bgp, int id)
 {
-	if (!bgp || IS_ERR(bgp)) {
+	if (IS_ERR_OR_NULL(bgp)) {
 		pr_err("%s: invalid bandgap pointer\n", __func__);
 		return -EINVAL;
 	}
-- 
2.34.1

