Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC519358248
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 13:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhDHLnz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 07:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231192AbhDHLnx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Apr 2021 07:43:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2D736112F;
        Thu,  8 Apr 2021 11:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617882221;
        bh=+4psGGWw3ZVh4ekY8H4nHgj/unzB+zQ0VmpJVSLylRc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SI+Dt71Cw/R47fzrFaik8V/+kny9t+rjWLlbMptY+Ic0CC17ekLrrt3u3hX/HreTs
         DVF9DRMEyLdhiXWfoSTuNVs6HC1cFTfhxxHA/MfTYzdV5/B+GJEqUiL3nZogB7FSmp
         RbPXTLZFZgTsmFNcEnYwcs+pCJhlV58I8d45A8NYd6qAhIAe9Kgjm2KaZlsSpkdKhX
         UDoo6W2ZHA3hlv358VZriwdFEQ+CiixKjNl4PErIiYOmQ1jc3w0aUAM+llyB9QyRco
         V6N2bRxdv8inODpYgg/sXABhnWjlPyQl1wzjCDpj4cjnoG3tzuDiJddj6gtWkEMzmz
         HTYqj1zOuGvzg==
Received: by pali.im (Postfix)
        id 1F262EDE; Thu,  8 Apr 2021 13:43:40 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RESEND PATCH mvebu v3 09/10] cpufreq: armada-37xx: Remove cur_frequency variable
Date:   Thu,  8 Apr 2021 13:42:22 +0200
Message-Id: <20210408114223.8471-9-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408114223.8471-1-pali@kernel.org>
References: <20210408114223.8471-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Variable cur_frequency in armada37xx_cpufreq_driver_init() is unused.

Signed-off-by: Pali Rohár <pali@kernel.org>
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
Tested-by: Anders Trier Olesen <anders.trier.olesen@gmail.com>
Tested-by: Philip Soares <philips@netisense.com>
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index e4782f562e7a..050abff18308 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -400,7 +400,7 @@ static int __init armada37xx_cpufreq_driver_init(void)
 	struct armada_37xx_dvfs *dvfs;
 	struct platform_device *pdev;
 	unsigned long freq;
-	unsigned int cur_frequency, base_frequency;
+	unsigned int base_frequency;
 	struct regmap *nb_clk_base, *nb_pm_base, *avs_base;
 	struct device *cpu_dev;
 	int load_lvl, ret;
@@ -461,14 +461,6 @@ static int __init armada37xx_cpufreq_driver_init(void)
 		return -EINVAL;
 	}
 
-	/* Get nominal (current) CPU frequency */
-	cur_frequency = clk_get_rate(clk);
-	if (!cur_frequency) {
-		dev_err(cpu_dev, "Failed to get clock rate for CPU\n");
-		clk_put(clk);
-		return -EINVAL;
-	}
-
 	dvfs = armada_37xx_cpu_freq_info_get(base_frequency);
 	if (!dvfs) {
 		clk_put(clk);
-- 
2.20.1

