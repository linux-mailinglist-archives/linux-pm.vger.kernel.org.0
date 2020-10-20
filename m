Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8F029367B
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 10:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbgJTIKs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 04:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732899AbgJTIKs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2020 04:10:48 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F59CC061755
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 01:10:47 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l28so996693lfp.10
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 01:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+qmrTn42A9meMBNr8/scSJZCTaFsW8DFZBuBr4kH1t8=;
        b=x074Hkl8ScUXPg6O2rB95tB/MfKF2Vz7qv2Fa4eUbh4tiV1O3+43q9irSTP006BJpQ
         A342MOW4k9FsvnBVzSRoP97ofqYcMf+dqshNLZadAOVYvty/O0Y5qih7T9gMcmhB+Ror
         f0icui74Um/dL+NQoSzS7X758DDvpYGYooIGkUPXsQH7UFMprHJKGnY78BzXk+8n76E1
         bJMLQFh/Dmz/zdi+cPUk4m6RdJwMgAxo7aFy6p3gEyG67jTaQnUP6r9EeTmEk+T7h8My
         VeXeQUaKDkfVuLQ84MQScLAHfxYa6trz8ULwF2KAgSAog0jPs1ZpNELPl1uCEIZKuo6P
         odvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+qmrTn42A9meMBNr8/scSJZCTaFsW8DFZBuBr4kH1t8=;
        b=Fm6nJNRsslhJoik17rB9EV6/+YJEOuZlOByDZUyZacZ0jk/FueBZah5H948GhYWWrD
         w+3h35oS/PHc/yQo2sN5mMJN4u+aFrZFy7oS8FTvBiNbujtKWYy+OPujYuVKv+aeDXJ1
         7XbRNlOcNPitRhO++9G7TQdjfqy4NMkSiX7ClWi+PU+ZpWqbKXV77UDa/GuRp2bBYA5f
         kPeRWiaaBTWDJgoL3KVruR0zf/qG7UQff5CaYttlxtgYDzQrcMxUmpa8ciE0JAuwJ1cU
         0OesLNJ5TG/jRYW2acQNYV4tV5NF3f/tmxAOoEbyKw5em+JWdbXaUT4IICw2bVBhOWFj
         3Mxw==
X-Gm-Message-State: AOAM532gXHNnxIgHlTM/NXks9w5J/9oLJAriFLyBuZ6SGATkB6EZkzJF
        lbD4ULJXmRmqLds8ZpPARDxT9g==
X-Google-Smtp-Source: ABdhPJxQkU3HIQQXGKCb1pNwRZ6dmIE+7lkzFyy+0AEzSdqVMuAqTDfTNhAJyUonOiSyDq+h7mT9mQ==
X-Received: by 2002:a19:12:: with SMTP id 18mr558717lfa.237.1603181446013;
        Tue, 20 Oct 2020 01:10:46 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-214.NA.cust.bahnhof.se. [98.128.180.214])
        by smtp.gmail.com with ESMTPSA id 67sm180756lfk.305.2020.10.20.01.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 01:10:44 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] PM: domains: Fix build error for genpd notifiers
Date:   Tue, 20 Oct 2020 10:10:35 +0200
Message-Id: <20201020081035.563849-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The __raw_notifier_call_chain() was recently removed and replaced with
raw_notifier_call_chain_robust(). Recent changes to genpd didn't take that
into account, which causes a build error. Let's fix this by converting to
the raw_notifier_call_chain_robust() in genpd.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Rafael, feel free to to squash this into the patch "PM: domains: Add support
for PM domain on/off notifiers for genpd".

Kind regards
Uffe

---
 drivers/base/power/domain.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 859cdb207010..743268996336 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -413,15 +413,15 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 	unsigned int state_idx = genpd->state_idx;
 	ktime_t time_start;
 	s64 elapsed_ns;
-	int ret, nr_calls = 0;
+	int ret;
 
 	/* Notify consumers that we are about to power on. */
-	ret = __raw_notifier_call_chain(&genpd->power_notifiers,
-					GENPD_NOTIFY_PRE_ON, NULL, -1,
-					&nr_calls);
+	ret = raw_notifier_call_chain_robust(&genpd->power_notifiers,
+					     GENPD_NOTIFY_PRE_ON,
+					     GENPD_NOTIFY_OFF, NULL);
 	ret = notifier_to_errno(ret);
 	if (ret)
-		goto err;
+		return ret;
 
 	if (!genpd->power_on)
 		goto out;
@@ -462,15 +462,15 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 	unsigned int state_idx = genpd->state_idx;
 	ktime_t time_start;
 	s64 elapsed_ns;
-	int ret, nr_calls = 0;
+	int ret;
 
 	/* Notify consumers that we are about to power off. */
-	ret = __raw_notifier_call_chain(&genpd->power_notifiers,
-					GENPD_NOTIFY_PRE_OFF, NULL, -1,
-					&nr_calls);
+	ret = raw_notifier_call_chain_robust(&genpd->power_notifiers,
+					     GENPD_NOTIFY_PRE_OFF,
+					     GENPD_NOTIFY_ON, NULL);
 	ret = notifier_to_errno(ret);
 	if (ret)
-		goto busy;
+		return ret;
 
 	if (!genpd->power_off)
 		goto out;
@@ -502,10 +502,7 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 				NULL);
 	return 0;
 busy:
-	if (nr_calls)
-		__raw_notifier_call_chain(&genpd->power_notifiers,
-					  GENPD_NOTIFY_ON, NULL, nr_calls - 1,
-					  NULL);
+	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON, NULL);
 	return ret;
 }
 
-- 
2.25.1

