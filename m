Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29BBB5934E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 07:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfF1FRG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 01:17:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42451 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfF1FRG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2019 01:17:06 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so2536806plb.9
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2019 22:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JiuWbBYG7AfK/w1wk/7crXpN7tqYeJAjUVndLvw0OqY=;
        b=LNBWauIRWJdvQQ5iQjrMW10ERFBpdZ3V2k7NsVJ6ur+EyKnBcibhTym3sMLyCs/FTM
         1udsABeiIwh7E5DcI8gzZu+y4yYL1Vn76SMDlajlLUjDeFJrrkq8ANOcxDHlA/dpHRDG
         saAQOJgTmFqF39BeigMkfkLwVq6fo78QMT0o7w8wZ7dzPaPmMXp8JfKzzArGZMGUStS2
         UsBjWlh24gHHdhzAxSKcmP3+nK30vkCEqXZ04/rORYrP3Gi0CaRLn1XckQG3/4xgrWot
         mq/Tf56IoylsA+2MetV7Nv3B2KS8X7TgPBOTbkFEzdhjVCKu5ZkmDiWbQNv3SnTm/ATd
         jaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JiuWbBYG7AfK/w1wk/7crXpN7tqYeJAjUVndLvw0OqY=;
        b=BkbN+Ma5N3gHBEA0vLRB/lmb/gT8ODttUcKDI++ldXiV9ci7gq50jFGthSuOXArbPg
         56YFs9jDBfPiA4RsO385XYINakqdYlNQiWFjGGuuAmkR3H9K3utiP4JJbHG59wJyjrPq
         HVKoKlbjL1UC3J6cS1JaZTM7V/z+k0yB2WbqFj9RvV4eGWZ8f/EErV0nYOC17g10eAlf
         F6Y7VJepLg5Pkipljw3egTsBmCyYfJdI1lXTSy/0sI1gdJhDf9x/YVzb6r/SQy6g2QaG
         7Aauc8FpHKIAUKJkIIW25gweN4oUWahzk8KZJnW9yKXQq1F1dCWvep6KC+caNF8/UQxl
         AByQ==
X-Gm-Message-State: APjAAAX/Jq94PVnuzFVthg9gwHvkThzUcEpnknEECOzd7XmoCBMx4xW1
        4aEOz/W8DQcnQ0wRCsjswXeMzw==
X-Google-Smtp-Source: APXvYqzdcdiIFMDU4e8+XLfMrmVS+O+aFXYB4G47R1WpL+iOleUF+4H1ST+eAvQx7g1AXvFXl4hGKQ==
X-Received: by 2002:a17:902:b592:: with SMTP id a18mr9342428pls.278.1561699025319;
        Thu, 27 Jun 2019 22:17:05 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id 201sm822777pfz.24.2019.06.27.22.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 22:17:03 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/5] cpufreq: Don't skip frequency validation for has_target() drivers
Date:   Fri, 28 Jun 2019 10:46:55 +0530
Message-Id: <88da7cfabad5e19a361fe2843e5ef547d50fd221.1561698236.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <88da7cfabad5e19a361fe2843e5ef547d50fd221.1560999838.git.viresh.kumar@linaro.org>
References: <88da7cfabad5e19a361fe2843e5ef547d50fd221.1560999838.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CPUFREQ_CONST_LOOPS was introduced in a very old commit from pre-2.6
kernel release by commit 6a4a93f9c0d5 ("[CPUFREQ] Fix 'out of sync'
issue").

If we you look at that commit, it does two things:

- It adds the frequency verification code (which is quite similar to
  what we have today as well).

- And it sets the CPUFREQ_CONST_LOOPS flag only for setpolicy drivers,
  rightly so based on the code we had then. The idea was to avoid
  frequency validation for setpolicy drivers as the cpufreq core doesn't
  know what frequency the hardware is running at and so no point in
  doing frequency verification.

The problem happened when we started to use the same CPUFREQ_CONST_LOOPS
flag for constant loops-per-jiffy thing as well and many has_target()
drivers started using the same flag and unknowingly skipped the
verification of frequency. There is no logical reason behind skipping
frequency validation because of the presence of CPUFREQ_CONST_LOOPS
flag otherwise.

This patch fixes this issue by skipping frequency validation only for
setpolicy drivers and always doing it for has_target() drivers
irrespective of the presence or absence of CPUFREQ_CONST_LOOPS flag.

cpufreq_notify_transition() is only called for has_target() type driver
and not for set_policy type, and the check is simply redundant. Remove
it as well.

Also remove () around freq comparison statement as they aren't required
and checkpatch also warns for them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2->V3:
- Updated commit log and $subject.

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

