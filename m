Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274A2216D47
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 14:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgGGM6Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 08:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgGGM6Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 08:58:24 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A171DC061755
        for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2020 05:58:24 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q7so36508181ljm.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2020 05:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tyb4FTg+dS/M/U030tOYrYBkxinzi9TyZY+2pXYSj8s=;
        b=WcTZPDyrGuD+JpLr2CvFSOW4wI/84AB9XBsPM+jNP55/QXFFMDJ2Kcuad7JKSuEgl4
         CMsJcDQJheQ23rJe96pFp9zvexdXKEVqmJE+BhjbytMKWA3ME0ZHKt6RLTMMacnHJqX2
         eHz9Jr/J9Itm7q4oL7NVLhg9l448S2Q49iTD4WdSJCSYCeU5QUE0K3iXcaJ0Y2WYHFGZ
         XQj2KfRpp0yZshd2s60tgduYEi8cCEBXVk/68tYWIKGTQCdf3nT3UUM+49atzgZzQd/F
         NEWIC0yJKMlERT7u2126WmBfK+sVr1OqaCYc11UQHPCZl/pL+tJtV+RipTMslbw9Rv7W
         GhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tyb4FTg+dS/M/U030tOYrYBkxinzi9TyZY+2pXYSj8s=;
        b=CfwieFFehAtfd2dSHJu9laQ8o2x9+Y9Xh5Pvn7vj3FkVQevfO7x6Tkz2gc2BFDU/gZ
         HWoGMrn9faW4idRYXFALYgDJ4KHWTSAN68wNw5vxR5lxcn2haqBOgjFbvRjcFCOB5xOL
         nC+DpbnQ3NQDmVWHstwTgdcUEqseR97IGt4fAGKihbWurvCYPuEUwXnAZLe5R4uGFFqF
         PuyL82i2kbAtC+uigLQGkTb/Qkza7nIE1Ohnz+317Yqmr/ERQkbZ3hMZPSUV6c6CaMBT
         w8UKfJiWb9lQzQELvHH3gQv8hJnC84LPUrV7raj2GJCKbYYeRmXtDAaaxWH2d7+JbmIA
         C6ZA==
X-Gm-Message-State: AOAM533DFgLvaUe40mqPm6rndK6BLXbtXVZgvb6RxP2A35dw3ti87qZE
        OGkVT/x7BmsR3NDZr5fZkLCaGw==
X-Google-Smtp-Source: ABdhPJylq0jjpwH2fsuo8vkN+Gf9ZYpUxI0iRGTwMhIxlrERcqaj5/+hQ1rGx4VxvHtG/4ViNKkMrA==
X-Received: by 2002:a2e:9a8d:: with SMTP id p13mr6597746lji.36.1594126703088;
        Tue, 07 Jul 2020 05:58:23 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id 11sm9554395lfz.78.2020.07.07.05.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 05:58:21 -0700 (PDT)
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
        Saravana Kannan <saravanak@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/5] cpuidle: psci: Fail cpuidle registration if set OSI mode failed
Date:   Tue,  7 Jul 2020 14:58:01 +0200
Message-Id: <20200707125804.13030-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707125804.13030-1-ulf.hansson@linaro.org>
References: <20200707125804.13030-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently we allow the cpuidle driver registration to succeed, even if we
failed to enable the OSI mode when the hierarchical DT layout is used. This
means running in a degraded mode, by using the available idle states per
CPU, while also preventing the domain idle states.

Moving forward, this behaviour looks quite questionable to maintain, as
complexity seems to grow around it, especially when trying to add support
for deferred probe, for example.

Therefore, let's make the cpuidle driver registration to fail in this
situation, thus relying on the default architectural cpuidle backend for
WFI to be used.

Reviewed-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index 423f03bbeb74..f07786aad673 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -26,7 +26,6 @@ struct psci_pd_provider {
 };
 
 static LIST_HEAD(psci_pd_providers);
-static bool osi_mode_enabled __initdata;
 
 static int psci_pd_power_off(struct generic_pm_domain *pd)
 {
@@ -272,7 +271,6 @@ static int __init psci_idle_init_domains(void)
 		goto remove_pd;
 	}
 
-	osi_mode_enabled = true;
 	of_node_put(np);
 	pr_info("Initialized CPU PM domain topology\n");
 	return pd_count;
@@ -293,9 +291,6 @@ struct device __init *psci_dt_attach_cpu(int cpu)
 {
 	struct device *dev;
 
-	if (!osi_mode_enabled)
-		return NULL;
-
 	dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), "psci");
 	if (IS_ERR_OR_NULL(dev))
 		return dev;
-- 
2.20.1

