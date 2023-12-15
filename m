Return-Path: <linux-pm+bounces-1212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF23814BF1
	for <lists+linux-pm@lfdr.de>; Fri, 15 Dec 2023 16:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6539CB22359
	for <lists+linux-pm@lfdr.de>; Fri, 15 Dec 2023 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C16837141;
	Fri, 15 Dec 2023 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lwNlnLXx"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FCF37166
	for <linux-pm@vger.kernel.org>; Fri, 15 Dec 2023 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B78EFC0008;
	Fri, 15 Dec 2023 15:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702654699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=agzZ4BylaA3IrnjSpRUsV7CheWAcikmN1pEeQ+7n8RA=;
	b=lwNlnLXxs+Ce0D50khjj+Yg0HhZwhsPMRWUC42wcSRHZaUXirzACZB/4n4jMDYnK7LR8nO
	iT0sFq4OjWILNhALxKr78n56+J0a7LuFBAbjm0ePxOmuLWEZ548Fw41Daf3ZIJlRIOfQJA
	RdsBC4ynV2INnBIasLzCzBtNZU8WNoBESO589ijOXswbSKSA720Iah6dGfcMdKXid3gy/r
	NvzVIHG4K4coIaWiVRS5hYqjZL7UNFrlHfMGGT4A3WRgNZ7CWvrOVEuQGCQ4LUNRhKHq9d
	Yj9u9/HckoBKwI3le6HHbLPl+2ocXSRlLjPV7kIPOFycqpiwTsPHGEP7YS2Wvg==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] cpufreq: armada-8k: Fix parameter type warning
Date: Fri, 15 Dec 2023 16:37:06 +0100
Message-ID: <20231215153706.2087883-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com

The second parameter of clk_get() is of type 'const char *', so use
NULL instead of the integer 0 to resolve a sparse warning:

drivers/cpufreq/armada-8k-cpufreq.c:60:40: warning: Using plain integer as NULL pointer
drivers/cpufreq/armada-8k-cpufreq.c:168:40: warning: Using plain integer as NULL pointer

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312141651.lCAXGAZ2-lkp@intel.com/
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/cpufreq/armada-8k-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
index 8afefdea4d80..ce5a5641b6dd 100644
--- a/drivers/cpufreq/armada-8k-cpufreq.c
+++ b/drivers/cpufreq/armada-8k-cpufreq.c
@@ -57,7 +57,7 @@ static void __init armada_8k_get_sharing_cpus(struct clk *cur_clk,
 			continue;
 		}
 
-		clk = clk_get(cpu_dev, 0);
+		clk = clk_get(cpu_dev, NULL);
 		if (IS_ERR(clk)) {
 			pr_warn("Cannot get clock for CPU %d\n", cpu);
 		} else {
@@ -165,7 +165,7 @@ static int __init armada_8k_cpufreq_init(void)
 			continue;
 		}
 
-		clk = clk_get(cpu_dev, 0);
+		clk = clk_get(cpu_dev, NULL);
 
 		if (IS_ERR(clk)) {
 			pr_err("Cannot get clock for CPU %d\n", cpu);
-- 
2.42.0


