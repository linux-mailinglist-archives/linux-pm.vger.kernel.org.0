Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52B2E4B72A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 13:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbfFSLf5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 07:35:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35942 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731691AbfFSLfy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 07:35:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so9591233pfl.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 04:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WHo+CK98Hk560A324w9NgmPfYqiucAAoOc1YvZRRmoc=;
        b=OiuBJyYMUwp7Feymf81ldAOyO51jCbmcCR+ngPCLcmMfJHERBLuEK/NtPFeN8+K+6T
         5/0SjsluzJJsesg4+W5STJStN4hWNLIcBT1aCRImcHUGxT3RG/6WbQ5aLsJR13ptzBpD
         p+QEtCFBEOATUSVe2ryWCzsoIeDaI39Bm7GB0aMEfN6LG2nFoW2+vjpRABHRvUTCdlQy
         UYrE3MLG4Oosu0hnZIIBU8BwsjW479JrJxmnoQZ2dcvYeSFh2hoGcACQ4peHEKnfsiTW
         FXNHd+kydKJOwYyrxFX8yxTIV+2HiZ/7KSpYEGXw8jhg6+fMMEtFImqU237wWKj+1wQN
         N+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WHo+CK98Hk560A324w9NgmPfYqiucAAoOc1YvZRRmoc=;
        b=mFXLd1jLRNtAirCRJPYgcsJSwoPnNXs+0I3K0wLiT3CCDF+Rl507DexLqQR7fHDksG
         0/ovkF5Y8eEEZJvGj5Vr0jvQ4np6WHoZXzLCD6yMSl+hlUqDUo/ne45CmS9lnpzf/GgN
         0s0V5GFv6JVR2Lkg95uOp1LW+F6comuEr3cJizJC8v0/EQLYYZmw27/10KJYJbUmhfmc
         3i2AuJGkRdaC5x6rK2/D0JTLuE4pe+JVPZmnPGCdm7WZ1zoYuxP62JLL4SE6BiY2pcRP
         ZKefmypGQfvmSxv5j2H+wNoE2fHPqrp5JW70tX/gv0iYmJ7K2orBt8wzNk9f0TLVZTgH
         E4NA==
X-Gm-Message-State: APjAAAUt9XVH6hb9xJo8TJUeCx0BXuL0Ag+bMRkLJHfEPHCwnEyKIgIT
        3+lYsIe1iNT6Y755V606lO9Y6HYPcjo=
X-Google-Smtp-Source: APXvYqxDL5o/8GAGOXNmziNNKY5OxiV9QQF3uCMMooHoEQ3XZDdUhEVFVVkwYjmDlXX4/XN6VXw8eQ==
X-Received: by 2002:a63:6f47:: with SMTP id k68mr7245648pgc.327.1560944154053;
        Wed, 19 Jun 2019 04:35:54 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id d9sm19205662pgj.34.2019.06.19.04.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 04:35:53 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] cpufreq: Replace few CPUFREQ_CONST_LOOPS checks with has_target()
Date:   Wed, 19 Jun 2019 17:05:38 +0530
Message-Id: <0660b023a0d80c63ec7a1f7fcb692de9a9f4d604.1560944014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1560944014.git.viresh.kumar@linaro.org>
References: <cover.1560944014.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CPUFREQ_CONST_LOOPS was introduced in a very old commit from pre-2.6
kernel release commit 6a4a93f9c0d5 ("[CPUFREQ] Fix 'out of sync'
issue").

Probably the initial idea was to just avoid these checks for set_policy
type drivers and then things got changed over the years. And it is very
unclear why these checks are there at all.

Replace the CPUFREQ_CONST_LOOPS check with has_target(), which makes
more sense now.

Also remove () around freq comparison statement as they aren't required
and checkpatch also warns for them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 54befd775bd6..e59194c2c613 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -359,12 +359,10 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
 		 * which is not equal to what the cpufreq core thinks is
 		 * "old frequency".
 		 */
-		if (!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
-			if (policy->cur && (policy->cur != freqs->old)) {
-				pr_debug("Warning: CPU frequency is %u, cpufreq assumed %u kHz\n",
-					 freqs->old, policy->cur);
-				freqs->old = policy->cur;
-			}
+		if (has_target() && policy->cur && policy->cur != freqs->old) {
+			pr_debug("Warning: CPU frequency is %u, cpufreq assumed %u kHz\n",
+				 freqs->old, policy->cur);
+			freqs->old = policy->cur;
 		}
 
 		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
@@ -1618,8 +1616,7 @@ static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
 	if (policy->fast_switch_enabled)
 		return ret_freq;
 
-	if (ret_freq && policy->cur &&
-		!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
+	if (has_target() && ret_freq && policy->cur) {
 		/* verify no discrepancy between actual and
 					saved value exists */
 		if (unlikely(ret_freq != policy->cur)) {
-- 
2.21.0.rc0.269.g1a574e7a288b

