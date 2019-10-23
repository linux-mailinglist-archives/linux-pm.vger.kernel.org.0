Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD940E15BF
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 11:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390875AbfJWJ2c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 05:28:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:50490 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390165AbfJWJ2c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Oct 2019 05:28:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 20CDCB5AF;
        Wed, 23 Oct 2019 09:28:26 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mperttunen@nvidia.com, linux-tegra@vger.kernel.org,
        jonathanh@nvidia.com, Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH] cpufreq: tegra186: add CPUFREQ_NEED_INITIAL_FREQ_CHECK flag
Date:   Wed, 23 Oct 2019 11:27:03 +0200
Message-Id: <20191023092703.30767-1-ykaukab@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver doesn't provide ->get() method to read current frequency.
Let cpufreq core set a frequency which is specified in freq-table by
setting CPUFREQ_NEED_INITIAL_FREQ_CHECK flag. As a result policy->cur
is set to a correct value as well.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 drivers/cpufreq/tegra186-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index bcecb068b51b..6ce6298bd2d7 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -93,7 +93,8 @@ static int tegra186_cpufreq_set_target(struct cpufreq_policy *policy,
 
 static struct cpufreq_driver tegra186_cpufreq_driver = {
 	.name = "tegra186",
-	.flags = CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
+	.flags = CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+			CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = tegra186_cpufreq_set_target,
 	.init = tegra186_cpufreq_init,
-- 
2.16.4

