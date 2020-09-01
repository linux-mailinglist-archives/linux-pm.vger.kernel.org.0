Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771EF258A54
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 10:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgIAI1V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 04:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgIAI1T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 04:27:19 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C696FC061245
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 01:27:18 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v23so492473ljd.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+5tYnQUX16Q+heMCNRPh41Y4CeDI+HHRPCn/NIvgA2k=;
        b=yxjSKuPUj5jB/wd3E8BkAdEXpcwx+QYNlsPC+DlHOjFfNJIeYoAl+TOYLt71CG5nws
         4wfPK6ihZGANEYge9CnzaRZHhIfU85mFZAjm5NIeQHIeTcT8xhHssr37u5c82vV3Xg6e
         xkaIuaf0XNj5qVPUGpCAxh1r2VKsdBceZ1rao2PrnuhOMMKML5sA/N/PePhhSTZeZpiC
         DvQ9ojYsgfYnm3yMYakbKCVddVBeIPTRRwTGlN6Oh7ThjJdgVYpmaZi1RKDRomNJUHSf
         cTUn/ZKpPJV1SIQhRuxZSJkuVw2eNdB3EoSbTyhnzkNnWaC1aYkicnw01akLplRv1s5o
         85RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+5tYnQUX16Q+heMCNRPh41Y4CeDI+HHRPCn/NIvgA2k=;
        b=LA4VLPMwOHZqxsemmzsj3uF5LyaqeXO6SU8NqB8OUnvWpksC6jDU+ZQOR2Kxfavhfp
         PWSfXVBbpvW32obDBCaDwc6AW/gaeUqP9Nz1PtX2kTqXN+LWa60ZNmRFMpPz1N6Xj4Ah
         yC/rZhR2/Jj1jdLcM0Rxavy46WzWPvQP35ZlwWNqS4a8BHrO3FnScyuSGT+/jmR18WHl
         QMIPQfe3LcNzF/krRfgu8AKOxuHbZMq8jbrypm6LC/ZHJRrHTbbddIFYsEvL+2Mrlkpr
         LGnt3xstPKhIDjOCX4hbu5r2HUFBy+A6Tb16ji2bXhQqlDnncH7L5a43X/eVB8G3g2K4
         B3FA==
X-Gm-Message-State: AOAM532G71PhHsM8N8K+OjFJgrQX/3lDsLoUY+El0ABVqM+v80El4ybG
        F/VzWU8n93BshK/7VNQQGSQt2g==
X-Google-Smtp-Source: ABdhPJzBA4RJyll+BAH3x5aIMti9jSrmCxrccc4R3hcNImFw9LL9oQ7gvcPr4tUtek3iqAyzWjLKIw==
X-Received: by 2002:a2e:900e:: with SMTP id h14mr438675ljg.103.1598948837167;
        Tue, 01 Sep 2020 01:27:17 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-79.NA.cust.bahnhof.se. [98.128.180.79])
        by smtp.gmail.com with ESMTPSA id c5sm111252lfb.24.2020.09.01.01.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 01:27:16 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] PM / Domains: Enable locking for syscore devices for IRQ safe genpds
Date:   Tue,  1 Sep 2020 10:27:06 +0200
Message-Id: <20200901082707.106860-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200901082707.106860-1-ulf.hansson@linaro.org>
References: <20200901082707.106860-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The genpd lock is currently not being used, while suspending/resuming
syscore devices through genpd. This because we need to avoid using a mutex
when running in the syscore phase.

However, the locking can be useful under special circumstances (as shown in
subsequent changes) and for a genpd having the flag GENPD_FLAG_IRQ_SAFE
set. Therefore, let's make use of the lock when it's possible.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2cb5e04cf86c..55d99a36bf6b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1342,18 +1342,27 @@ static void genpd_complete(struct device *dev)
 static void genpd_syscore_switch(struct device *dev, bool suspend)
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
 
 void pm_genpd_syscore_poweroff(struct device *dev)
-- 
2.25.1

