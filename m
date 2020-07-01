Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991EC21023A
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 04:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgGACy2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jun 2020 22:54:28 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:35470 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbgGACy1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2020 22:54:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0U1Dur.y_1593572065;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0U1Dur.y_1593572065)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Jul 2020 10:54:25 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH]  cpufreq: CPPC: fix some unreasonable codes in cppc_cpufreq_perf_to_khz()
Date:   Wed,  1 Jul 2020 10:54:23 +0800
Message-Id: <20200701025423.10206-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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
