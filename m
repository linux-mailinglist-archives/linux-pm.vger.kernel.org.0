Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B3831A17
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jun 2019 09:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfFAHfg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Jun 2019 03:35:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726013AbfFAHff (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 1 Jun 2019 03:35:35 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 245A96B0BBF58C89DE03;
        Sat,  1 Jun 2019 15:35:32 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sat, 1 Jun 2019 15:35:22 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] cpufreq: armada-37xx: Remove set but not used variable 'freq'
Date:   Sat, 1 Jun 2019 07:43:38 +0000
Message-ID: <20190601074338.64187-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/cpufreq/armada-37xx-cpufreq.c: In function 'armada37xx_cpufreq_avs_setup':
drivers/cpufreq/armada-37xx-cpufreq.c:260:28: warning:
 variable 'freq' set but not used [-Wunused-but-set-variable]

It's never used since introduction in commit 1c3528232f4b ("cpufreq:
armada-37xx: Add AVS support")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index 0df16eb1eb3c..aa0f06dec959 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -257,7 +257,7 @@ static void __init armada37xx_cpufreq_avs_configure(struct regmap *base,
 static void __init armada37xx_cpufreq_avs_setup(struct regmap *base,
 						struct armada_37xx_dvfs *dvfs)
 {
-	unsigned int avs_val = 0, freq;
+	unsigned int avs_val = 0;
 	int load_level = 0;
 
 	if (base == NULL)
@@ -275,8 +275,6 @@ static void __init armada37xx_cpufreq_avs_setup(struct regmap *base,
 
 
 	for (load_level = 1; load_level < LOAD_LEVEL_NR; load_level++) {
-		freq = dvfs->cpu_freq_max / dvfs->divider[load_level];
-
 		avs_val = dvfs->avs[load_level];
 		regmap_update_bits(base, ARMADA_37XX_AVS_VSET(load_level-1),
 		    ARMADA_37XX_AVS_VDD_MASK << ARMADA_37XX_AVS_HIGH_VDD_LIMIT |



