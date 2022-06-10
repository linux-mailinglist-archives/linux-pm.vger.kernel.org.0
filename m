Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C03D545DD9
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jun 2022 09:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiFJHyW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jun 2022 03:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346776AbiFJHyU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2022 03:54:20 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486F320B7C5;
        Fri, 10 Jun 2022 00:54:19 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LKCqF6pydz1GCWR;
        Fri, 10 Jun 2022 15:52:25 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 15:54:17 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <yangyicong@hisilicon.com>, <andriy.shevchenko@linux.intel.com>,
        <daniel.lezcano@linaro.org>
Subject: [PATCH] cpufreq: qcom-cpufreq-hw: use HZ_PER_KHZ macro in units.h
Date:   Fri, 10 Jun 2022 15:53:09 +0800
Message-ID: <20220610075309.59608-1-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

HZ macros has been centralized in units.h since [1]. Use it to avoid
duplicated definition.

[1] commit e2c77032fcbe ("units: add the HZ macros")

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 0253731d6d25..7f118be969d3 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -15,6 +15,7 @@
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/units.h>
 
 #define LUT_MAX_ENTRIES			40U
 #define LUT_SRC				GENMASK(31, 30)
@@ -26,8 +27,6 @@
 
 #define GT_IRQ_STATUS			BIT(2)
 
-#define HZ_PER_KHZ			1000
-
 struct qcom_cpufreq_soc_data {
 	u32 reg_enable;
 	u32 reg_domain_state;
-- 
2.24.0

