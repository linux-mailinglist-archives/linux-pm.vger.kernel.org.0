Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E15210280
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 05:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgGAD0S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jun 2020 23:26:18 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:42785 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbgGAD0R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2020 23:26:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U1E1Ert_1593573974;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0U1E1Ert_1593573974)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Jul 2020 11:26:15 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     rjw@rjwysocki.net
Cc:     viresh.kumar@linaro.org, xhao@linux.alibaba.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2]  cpufreq: CPPC: fix some unreasonable codes in cppc_cpufreq_perf_to_khz()
Date:   Wed,  1 Jul 2020 11:26:10 +0800
Message-Id: <20200701032610.11944-1-xhao@linux.alibaba.com>
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
 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 257d726a4456..444ee76a6bae 100644
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
--
2.24.1
