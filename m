Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA752E9575
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 14:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbhADNDL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 08:03:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46334 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbhADNDK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 08:03:10 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kwPVD-00014n-SD; Mon, 04 Jan 2021 13:02:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Warren <swarren@nvidia.com>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] cpufreq: powernow-k8: add null check to policy to avoid null pointer dereference
Date:   Mon,  4 Jan 2021 13:02:27 +0000
Message-Id: <20210104130227.35354-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently there is an unlikely case where cpufreq_cpu_get returns a
null policy and this will cause a null pointer dereference later on.
Fix this by adding a null check and adding an error return.

Addresses-Coverity: ("Dereference null return")
Fixes: b43a7ffbf33b ("cpufreq: Notify all policy->cpus in cpufreq_notify_transition()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/cpufreq/powernow-k8.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 0acc9e241cd7..c5368545ba1f 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -913,6 +913,8 @@ static int transition_frequency_fidvid(struct powernow_k8_data *data,
 	freqs.new = find_khz_freq_from_fid(fid);
 
 	policy = cpufreq_cpu_get(smp_processor_id());
+	if (!policy)
+		return 1;
 	cpufreq_cpu_put(policy);
 
 	cpufreq_freq_transition_begin(policy, &freqs);
-- 
2.29.2

