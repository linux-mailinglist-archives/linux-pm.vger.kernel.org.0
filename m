Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B0C276F56
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 13:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgIXLGe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 07:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgIXLGV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 07:06:21 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520A0C0613CE
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 04:06:21 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z19so3445301lfr.4
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 04:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gaTG8nB7urYK9rRS90jMgYPOQXnTJzMb/qGUVRNiFp8=;
        b=H3Oho9fGD6RyE7bc1Vbkj0h4ig5GO+l5hocswqpFb3dkMRdGklpkEO9eBeBB09TcZ9
         dftfi52ZqomV7nQ5Jw4OENJNRUEafEY7gOz2sx2BWm9cKXHYJ3ewwEeGRbghiXv6jogt
         pq/UIkU9ZDJCvoaCwnFnveqJoBFTG0thF0oLs7pGD1AQss2M3HJgb8Sxn5yiuQodFhYQ
         hJ06vs873IdJJRlZHWgRr0oI3i4ffJ+zB+41wDaroaypmlaxB1CosR1jfIh3LdygOJ+e
         NyQtY3j5INzmct44KCjDtbRCFhjJPwVkl5ISX6mEJuMJa0p1tORTGhFUuRX7TYNJ50ZX
         vkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gaTG8nB7urYK9rRS90jMgYPOQXnTJzMb/qGUVRNiFp8=;
        b=sOUOZvyTQ+dGTnzW1kAoYls/z5p1zcGc+eVqBdOOIuAG0Ee4n0HYrqcx8ayjqLN/oj
         kCa30uDxBRGhZlAyENIx5QH7n9GtOcZuUl814eJ/PLZHIz+d/dATK+y5fjVsy5bWqzS2
         B7s3J8aSsjHwfB7M2w9nwOlkJ3nLPCWA5t1zvPyhD5xtJLVSpsLHTWqcb8TLyxTDe0KK
         rTKOusC8JNN0vGK+8YS8TkhPhJzXGAZmFv7Oy/XH35rX4VRESbD53s+3woGAH+nlTd+z
         ENanMocvWHnGhPmHZPGVs5BRvvwCT9UO+7ROLUH+pzTE4YHOtFc4to1e7wZBkfWdgDzi
         nI1g==
X-Gm-Message-State: AOAM531dz+4UlBY5Wpo1zSeyxKDVoWVP7l93oFzkjNKlPjEIEziMr87n
        RaHHm4nP+RN7N4c+I45uJH3PJCZ7ewENsPOa
X-Google-Smtp-Source: ABdhPJymetcRsIgXO87ErAfpmmQHrT9SqTFIGB3QpkJ315XgLg9UgC/VPtV4CqPurtYJMsiQe6O3rQ==
X-Received: by 2002:a19:674f:: with SMTP id e15mr108526lfj.50.1600945579746;
        Thu, 24 Sep 2020 04:06:19 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-169.NA.cust.bahnhof.se. [155.4.133.169])
        by smtp.gmail.com with ESMTPSA id w4sm1762393lfr.139.2020.09.24.04.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 04:06:18 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] PM / Domains: Allow to abort power off when no ->power_off() callback
Date:   Thu, 24 Sep 2020 13:04:48 +0200
Message-Id: <20200924110449.329523-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924110449.329523-1-ulf.hansson@linaro.org>
References: <20200924110449.329523-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In genpd_power_off() we may decide to abort the power off of the PM domain,
even beyond the point when the governor would accept it. The abort is done
if it turns out that a child domain has been requested to be powered on,
which means it's waiting for the lock of the parent to be released.

However, the abort is currently only considered if the genpd in question
has a ->power_off() callback assigned. This is unnecessary limiting,
especially if the genpd would have a parent of its own. Let's remove the
limitation and make the behaviour consistent.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- None.

---
 drivers/base/power/domain.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 23aa2feced77..0198af358503 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -497,6 +497,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	struct pm_domain_data *pdd;
 	struct gpd_link *link;
 	unsigned int not_suspended = 0;
+	int ret;
 
 	/*
 	 * Do not try to power off the domain in the following situations:
@@ -544,24 +545,13 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	if (!genpd->gov)
 		genpd->state_idx = 0;
 
-	if (genpd->power_off) {
-		int ret;
-
-		if (atomic_read(&genpd->sd_count) > 0)
-			return -EBUSY;
+	/* Don't power off, if a child domain is waiting to power on. */
+	if (atomic_read(&genpd->sd_count) > 0)
+		return -EBUSY;
 
-		/*
-		 * If sd_count > 0 at this point, one of the subdomains hasn't
-		 * managed to call genpd_power_on() for the parent yet after
-		 * incrementing it.  In that case genpd_power_on() will wait
-		 * for us to drop the lock, so we can call .power_off() and let
-		 * the genpd_power_on() restore power for us (this shouldn't
-		 * happen very often).
-		 */
-		ret = _genpd_power_off(genpd, true);
-		if (ret)
-			return ret;
-	}
+	ret = _genpd_power_off(genpd, true);
+	if (ret)
+		return ret;
 
 	genpd->status = GENPD_STATE_OFF;
 	genpd_update_accounting(genpd);
-- 
2.25.1

