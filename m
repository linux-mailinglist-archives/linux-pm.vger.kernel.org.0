Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C714C5AB
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2019 05:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbfFTDG2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 23:06:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40184 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfFTDG1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 23:06:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so757264pgj.7
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 20:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p8q7duu3NM5D7B0/JJEPNRH7AiTiNoUPeRHE8XCCFpc=;
        b=pi9g95KXO8T2J62vjV8PPB7VJfoSs9c6QwY71RXsD9brl+T2e/1eGRO3sjle2j1XQ+
         79PG7kurlPGO8rSAzq+FCPPsyvxIXduSBxqvxKch5MjoumOWdYsue+oY+ontfPUIRE1d
         td/3JGqWefy6RUFofSUzIWdRy2ez/S2fkFPNcADiit7knMzt6PmgtaoNaaXHswygLFh3
         xCOw1TPLwojNrUEmXwXhclxKxHVYcEaKfCm9aynndRo6HjwdInS2IDrK/FIcUaYaY67J
         I04Cyu4DqdjbMZI1OZHzFjYUY00KZPKff4relP1bI6YkZ+bB1pnDUaljewOnVXX5gZ7Z
         gJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p8q7duu3NM5D7B0/JJEPNRH7AiTiNoUPeRHE8XCCFpc=;
        b=bUj6C1FihLIZs+kjzJrjlRjuzPPzpNOJTl576c1ciT4CwgHyl1Ytqo/vdTLcRBTP/W
         k5X7RKnuZM6UrajSFxi2oa5MWUZ7yDOEJUBrcRl8n7d6lwnJe7JfiJgkcl5AEsUYjDid
         eV1QHM2Dwo94T5VZOXgci0M4Si1G7F1J1niUm9IVIYFazI33F+D69z6gwTiv2OGUNfRP
         QbevJeSKwglK8gXJ0bqaeHV/x/pQlVQVDeuFw3Z0FuzVkAPbAysZI42WbOQYyQZQVBrB
         2lMTE8CcnqgqipLMdVgdDrXr4hJ3JnWZ3bLVZSeLWsTsmfVkRF2y9aW+M38cRCSk/jMb
         1Q8A==
X-Gm-Message-State: APjAAAWe2st3OguR36CNzb79dRPgPNrJJ10BwWNreEFHsI/dVem/cGkd
        lzF1WQx7lxxQOZZDvyTCKOJjPg==
X-Google-Smtp-Source: APXvYqxFAhFFPNFzp204E1IW8iP5ZxzaHvAie5ju+82McHT0juXkxxe5Mzqm7beuZ+WBswCm00XCxg==
X-Received: by 2002:a62:82c2:: with SMTP id w185mr109064201pfd.202.1560999986860;
        Wed, 19 Jun 2019 20:06:26 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id g8sm19236053pfi.8.2019.06.19.20.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 20:06:26 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/5] cpufreq: Replace few CPUFREQ_CONST_LOOPS checks with has_target()
Date:   Thu, 20 Jun 2019 08:35:47 +0530
Message-Id: <88da7cfabad5e19a361fe2843e5ef547d50fd221.1560999838.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1560999838.git.viresh.kumar@linaro.org>
References: <cover.1560999838.git.viresh.kumar@linaro.org>
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

cpufreq_notify_transition() is only called for has_target() type driver
and not for set_policy type, and the check is simply redundant. Remove
it as well.

Also remove () around freq comparison statement as they aren't required
and checkpatch also warns for them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 54befd775bd6..41ac701e324f 100644
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
+		if (policy->cur && policy->cur != freqs->old) {
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

