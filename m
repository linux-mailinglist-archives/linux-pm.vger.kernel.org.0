Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C54023E116
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 20:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgHFSkX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 14:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729389AbgHFSkW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Aug 2020 14:40:22 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D68A230FF;
        Thu,  6 Aug 2020 18:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738273;
        bh=zSPJaWHqH2p/CnzlIYBwfeQwSQSWPlKg7XPNzrWLNhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S5KbQ5A9Y1pof988/YmoJ7Aa3Z9HTb54MDsEFrSUXTpzc8LRFH74k+14NcynvJz4r
         BUrQZBTHPraTFJJmjSlc1Ft3yqBz/GxSSihYvWiOsSKQStmqnmtun1SbwMXH6YATtp
         +dU3HKOOTlyG8degP9b5d7+7XoeTj1PK87Xl82lw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 36/41] cpufreq: s3c2412: use global s3c2412_cpufreq_setrefresh
Date:   Thu,  6 Aug 2020 20:20:53 +0200
Message-Id: <20200806182059.2431-36-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are two identical copies of the s3c2412_cpufreq_setrefresh
function: a static one in the cpufreq driver and a global
version in iotiming-s3c2412.c.

As the function requires the use of a hardcoded register address
from a header that we want to not be visible to drivers, just
move the existing global function and add a declaration in
one of the cpufreq header files.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/cpufreq/s3c2412-cpufreq.c            | 23 --------------------
 include/linux/soc/samsung/s3c-cpufreq-core.h |  1 +
 2 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/cpufreq/s3c2412-cpufreq.c b/drivers/cpufreq/s3c2412-cpufreq.c
index 38dc9e6db633..a77c63e92e1a 100644
--- a/drivers/cpufreq/s3c2412-cpufreq.c
+++ b/drivers/cpufreq/s3c2412-cpufreq.c
@@ -25,8 +25,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/s3c2412.h>
-
 #include <mach/map.h>
 
 #define S3C2410_CLKREG(x) ((x) + S3C24XX_VA_CLKPWR)
@@ -156,27 +154,6 @@ static void s3c2412_cpufreq_setdivs(struct s3c_cpufreq_config *cfg)
 	clk_set_parent(armclk, cfg->divs.dvs ? hclk : fclk);
 }
 
-static void s3c2412_cpufreq_setrefresh(struct s3c_cpufreq_config *cfg)
-{
-	struct s3c_cpufreq_board *board = cfg->board;
-	unsigned long refresh;
-
-	s3c_freq_dbg("%s: refresh %u ns, hclk %lu\n", __func__,
-		     board->refresh, cfg->freq.hclk);
-
-	/* Reduce both the refresh time (in ns) and the frequency (in MHz)
-	 * by 10 each to ensure that we do not overflow 32 bit numbers. This
-	 * should work for HCLK up to 133MHz and refresh period up to 30usec.
-	 */
-
-	refresh = (board->refresh / 10);
-	refresh *= (cfg->freq.hclk / 100);
-	refresh /= (1 * 1000 * 1000);	/* 10^6 */
-
-	s3c_freq_dbg("%s: setting refresh 0x%08lx\n", __func__, refresh);
-	__raw_writel(refresh, S3C2412_REFRESH);
-}
-
 /* set the default cpu frequency information, based on an 200MHz part
  * as we have no other way of detecting the speed rating in software.
  */
diff --git a/include/linux/soc/samsung/s3c-cpufreq-core.h b/include/linux/soc/samsung/s3c-cpufreq-core.h
index c578b07ccd5d..e0c7217a0f53 100644
--- a/include/linux/soc/samsung/s3c-cpufreq-core.h
+++ b/include/linux/soc/samsung/s3c-cpufreq-core.h
@@ -248,6 +248,7 @@ extern int s3c2412_iotiming_calc(struct s3c_cpufreq_config *cfg,
 
 extern void s3c2412_iotiming_set(struct s3c_cpufreq_config *cfg,
 				 struct s3c_iotimings *iot);
+extern void s3c2412_cpufreq_setrefresh(struct s3c_cpufreq_config *cfg);
 #else
 #define s3c2412_iotiming_debugfs NULL
 #define s3c2412_iotiming_calc NULL
-- 
2.17.1

