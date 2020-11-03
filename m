Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FED82A48F7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 16:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgKCPHl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 10:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgKCPGm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 10:06:42 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C030C0617A6
        for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2020 07:06:42 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id p15so19436012ljj.8
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2020 07:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kdoh+vwsEl16Yv/ER7Hhev3sO3MvjrueZiYq3HqyYgg=;
        b=aKENhJfJOgbz3Z80D8/HTRaDGis97wYnQ7c6Vk5LMIdkp8+btBMJV85vwFmdaGqtZF
         vFuuCdmCgskoX9lAVsxq/VPlWhlkNHoVsfpTfzgaX/qylT3wlmo/wmvTOWqjEWXQOGZO
         C+Ym+Aa5KsYsi+XPAU2q7FVpk4MUL/mqpaSCcABHwobDjgiiAY54kWsCwAUjl4rel6LN
         5a4j7hHlgD8opdaOnLOipRT3Dm36PXH1KvC08Ht+19WwE4t76ZeMwJAE2gz715MYk9z+
         FP8b0XmmZLYrVI7AvWawpeKptZfmj1Tj2VAjFaFRJ9z4rLGSuwc7VB8er4C12yb2fg9Y
         lREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kdoh+vwsEl16Yv/ER7Hhev3sO3MvjrueZiYq3HqyYgg=;
        b=mygmEM+mUtI4HOzLkKO838ZCW6fvfMuf+AJSGxFcuQjqI4iERBpZm3Z6PsRqxycJPZ
         jXdmXg6jAK0ZeSacnifgJcc8pvpLK/0NnPjijTSdYV+hdgkP793o4J8nqpojPAL7cSwC
         uWmY/fIVkiAU7KijyeGEeOBO0JTDeDFNxXGk1pP/B/VmKo6WftJjAfyVCOpYqhcz1dVu
         YeyPXkz1F52t+HJHctx+s7nvmaqV8iF1qcuGswpwMJ4873ckmTjmNXHBJA3u+XfMilEg
         U6LJxB4yuFQwYsAHXO2np2OEMhApD792+DZB6UnZamw/YZWkIERq9FMSG6eiQ1h0yh6+
         R98Q==
X-Gm-Message-State: AOAM532tVZ2in5dmovgmea2z5fPQsaQZOI0aTdwcFAnuCmfGe2jdfJ1h
        SkR6gBD50GYho7JziF91fL4EyVsma6s8UQ==
X-Google-Smtp-Source: ABdhPJxL5L/dqtMLU8eglrRK4+pkCsIeAA+kIcRq8/oJXsL1Sx/dg6nEod+1dvGOt0AnvFCnoqtwgg==
X-Received: by 2002:a2e:7c17:: with SMTP id x23mr9593284ljc.366.1604416000443;
        Tue, 03 Nov 2020 07:06:40 -0800 (PST)
Received: from localhost.localdomain (h-155-4-131-134.NA.cust.bahnhof.se. [155.4.131.134])
        by smtp.gmail.com with ESMTPSA id a25sm3522169lfo.141.2020.11.03.07.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:06:39 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/3] PM: domains: Enable dev_pm_genpd_suspend|resume() for suspend-to-idle
Date:   Tue,  3 Nov 2020 16:06:26 +0100
Message-Id: <20201103150627.233438-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103150627.233438-1-ulf.hansson@linaro.org>
References: <20201103150627.233438-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The dev_pm_genpd_suspend|resume() have so far only been used during the
syscore suspend/resume phases. However, during suspend-to-idle, where the
syscore phases doesn't exist, similar operations are sometimes needed.

An existing example are the timekeeping_suspend|resume() functions, which
are being called both through a registered syscore ops during the syscore
phases, but also as regular functions calls from cpuidle (via
tick_freeze()) during suspend-to-idle.

For similar reasons, let's enable the dev_pm_genpd_suspend|resume() APIs to
be re-used for corresponding CPU devices that are attached to a genpd,
during suspend-to-idle.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Renamed and add documentation of the APIs.
	- Updated the commit message and its header.

---
 drivers/base/power/domain.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 9b4881b67683..4a55f3c949ae 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1366,18 +1366,27 @@ static void genpd_complete(struct device *dev)
 static void genpd_switch_state(struct device *dev, bool suspend)
 {
 	struct generic_pm_domain *genpd;
+	bool use_lock;
 
 	genpd = dev_to_genpd_safe(dev);
 	if (!genpd)
 		return;
 
+	use_lock = genpd_is_irq_safe(genpd);
+
+	if (use_lock)
+		genpd_lock(genpd);
+
 	if (suspend) {
 		genpd->suspended_count++;
-		genpd_sync_power_off(genpd, false, 0);
+		genpd_sync_power_off(genpd, use_lock, 0);
 	} else {
-		genpd_sync_power_on(genpd, false, 0);
+		genpd_sync_power_on(genpd, use_lock, 0);
 		genpd->suspended_count--;
 	}
+
+	if (use_lock)
+		genpd_unlock(genpd);
 }
 
 /**
@@ -1385,7 +1394,9 @@ static void genpd_switch_state(struct device *dev, bool suspend)
  * @dev: The device that is attached to the genpd, that can be suspended.
  *
  * This routine should typically be called for a device that needs to be
- * suspended during the syscore suspend phase.
+ * suspended during the syscore suspend phase. It may also be called during
+ * suspend-to-idle to suspend a corresponding CPU device that is attached to a
+ * genpd.
  */
 void dev_pm_genpd_suspend(struct device *dev)
 {
@@ -1398,7 +1409,8 @@ EXPORT_SYMBOL_GPL(dev_pm_genpd_suspend);
  * @dev: The device that is attached to the genpd, which needs to be resumed.
  *
  * This routine should typically be called for a device that needs to be resumed
- * during the syscore resume phase.
+ * during the syscore resume phase. It may also be called during suspend-to-idle
+ * to resume a corresponding CPU device that is attached to a genpd.
  */
 void dev_pm_genpd_resume(struct device *dev)
 {
-- 
2.25.1

