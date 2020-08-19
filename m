Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9A1249A9D
	for <lists+linux-pm@lfdr.de>; Wed, 19 Aug 2020 12:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgHSKls (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Aug 2020 06:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgHSKlc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2020 06:41:32 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95209C061342
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 03:41:31 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id j22so11820608lfm.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 03:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6AfisJdiJUtL2PXoC9gz6YzWImXc+sSWUPeXDWlUbHI=;
        b=FDmP20zScS9Lp7NKqKhHNqZWR3liO/ZnL7w+TyagTnjUgOnvbWYGP2viYAlT07dtf9
         tzK3xWyFoLgHKBhueu6FnaKkhTojI9LUqKWVL8IsUd5nmJLNd8CZzvGMPbbwzwm9iW8z
         O087glIP1Z7zeJKFKxZwBIOC3bJlf/NudjYGq4tcFESU3ROywqhOTSrQ83v+uqDEZe3k
         D59T/x538Q36zAC1Q7SAWFT0byDw1FjFnmfs484p02nBj2CKmFOizB29nOJ4Zm1GroJr
         xiorhamZgN4JM/GM+2+jfuXcACWB3Wj12pb9iBlAZE4okK13c3vLRwcrOb8Z6+36YDAQ
         0boA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6AfisJdiJUtL2PXoC9gz6YzWImXc+sSWUPeXDWlUbHI=;
        b=W2yPZEL+M2DQo1wKAbGsQJ6v8Dsw3lLNs21I/NdhA/wqDZWphSSzsd722CE9O2Gcbu
         kwgplGR9nlK9P8vYGZmKOH2qwbB38wCdj95kE8C6HQQqBv60/60iNkJQ/L55ob3AGdE9
         BkhRW2mMf9SuRrj2oQsA3kI0AZRCfKWY2o9dfp1TY55Qv/6I0jCbiXz90nMLyhZh2cEL
         hvWxNH10DF5S9l7jEs3VELtnzyUC3En1MLlVhNNaX+8h2ydVrTzhmrqxaz4w8u6noz9c
         oRh9TnKyj6SEAJ+AHguY1QKGAGd6TOKeKWAUaS3NOIKzlmksV2aoRkgYzL/9OetTYY1b
         Kn0Q==
X-Gm-Message-State: AOAM530kFx5BYEz9lHzEjZuE7WXkxH9mmttt8s1L0t+kLQUHOHansSw9
        dqz9DY2A5BbTCgGk2J/QfVBpiA==
X-Google-Smtp-Source: ABdhPJygHSyy3z4agvjAxmYVV4QRQjCkH5wyaAw1ePZcKIW+aup9SWYdYaWUsgZtrrWbS9OSPi9VCQ==
X-Received: by 2002:a19:cb53:: with SMTP id b80mr11846376lfg.77.1597833686628;
        Wed, 19 Aug 2020 03:41:26 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-79.NA.cust.bahnhof.se. [98.128.180.79])
        by smtp.gmail.com with ESMTPSA id y13sm6534822ljd.19.2020.08.19.03.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 03:41:25 -0700 (PDT)
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
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] PM / Domains: Allow to abort power off when no ->power_off() callback
Date:   Wed, 19 Aug 2020 12:40:56 +0200
Message-Id: <20200819104057.318230-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819104057.318230-1-ulf.hansson@linaro.org>
References: <20200819104057.318230-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
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
 drivers/base/power/domain.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2ea99032b658..4b787e1ff188 100644
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

