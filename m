Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E3D2102B3
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 06:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgGAEUV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 00:20:21 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:35844 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725272AbgGAEUV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 00:20:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U1EplZ._1593577218;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0U1EplZ._1593577218)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Jul 2020 12:20:18 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     rjw@rjwysocki.net
Cc:     viresh.kumar@linaro.org, xhao@linux.alibaba.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3]  cpufreq: CPPC: simply the code access 'highest_perf' value in cppc_perf_caps struct
Date:   Wed,  1 Jul 2020 12:20:07 +0800
Message-Id: <20200701042007.13333-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

 The 'caps' variable has been defined, so there is no need to get
 'highest_perf' value through 'cpu->caps.highest_perf', you can use
 'caps->highest_perf' instead.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 257d726a4456..051d0e56c67a 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -161,7 +161,7 @@ static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu,
 		if (!max_khz)
 			max_khz = cppc_get_dmi_max_khz();
 		mul = max_khz;
-		div = cpu->perf_caps.highest_perf;
+		div = caps->highest_perf;
 	}
 	return (u64)perf * mul / div;
 }
@@ -184,7 +184,7 @@ static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu,
 	} else {
 		if (!max_khz)
 			max_khz = cppc_get_dmi_max_khz();
-		mul = cpu->perf_caps.highest_perf;
+		mul = caps->highest_perf;
 		div = max_khz;
 	}
 
-- 
2.24.1

