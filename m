Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8712EA87F
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 11:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbhAEKUk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 05:20:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51600 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbhAEKUk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 05:20:40 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kwjRV-0002M9-C5; Tue, 05 Jan 2021 10:19:57 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Warren <swarren@nvidia.com>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V3] cpufreq: powernow-k8: pass policy rather than use cpufreq_cpu_get
Date:   Tue,  5 Jan 2021 10:19:57 +0000
Message-Id: <20210105101957.59072-1-colin.king@canonical.com>
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
Fix this by passing the policy to transition_frequency_fidvid from the
caller and hence eliminating the need for the cpufreq_cpu_get and
cpufreq_cpu_put.  Thanks to Viresh Kumar for suggesting the fix.

Addresses-Coverity: ("Dereference null return")
Fixes: b43a7ffbf33b ("cpufreq: Notify all policy->cpus in cpufreq_notify_transition()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: pass the policy to transition_frequency_fidvid rather than add
    a null pointer check on the return from a cpufreq_cpu_get call.
V3: update subject line to match the fix

---
 drivers/cpufreq/powernow-k8.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 0acc9e241cd7..b9ccb6a3dad9 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -878,9 +878,9 @@ static int get_transition_latency(struct powernow_k8_data *data)
 
 /* Take a frequency, and issue the fid/vid transition command */
 static int transition_frequency_fidvid(struct powernow_k8_data *data,
-		unsigned int index)
+		unsigned int index,
+		struct cpufreq_policy *policy)
 {
-	struct cpufreq_policy *policy;
 	u32 fid = 0;
 	u32 vid = 0;
 	int res;
@@ -912,9 +912,6 @@ static int transition_frequency_fidvid(struct powernow_k8_data *data,
 	freqs.old = find_khz_freq_from_fid(data->currfid);
 	freqs.new = find_khz_freq_from_fid(fid);
 
-	policy = cpufreq_cpu_get(smp_processor_id());
-	cpufreq_cpu_put(policy);
-
 	cpufreq_freq_transition_begin(policy, &freqs);
 	res = transition_fid_vid(data, fid, vid);
 	cpufreq_freq_transition_end(policy, &freqs, res);
@@ -969,7 +966,7 @@ static long powernowk8_target_fn(void *arg)
 
 	powernow_k8_acpi_pst_values(data, newstate);
 
-	ret = transition_frequency_fidvid(data, newstate);
+	ret = transition_frequency_fidvid(data, newstate, pol);
 
 	if (ret) {
 		pr_err("transition frequency failed\n");
-- 
2.29.2

