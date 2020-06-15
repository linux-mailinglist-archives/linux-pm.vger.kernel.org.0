Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A321F9BD0
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 17:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbgFOPVE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 11:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730276AbgFOPVD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 11:21:03 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716BBC061A0E
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 08:21:01 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q19so19695118lji.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 08:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zKuQg/V734JQ52Bk2AkHR9NRP89P2pyrqBomz/3R808=;
        b=pvtc1SZFZTITynG6EAMVZtWwt6lRnyd/IzhXA/GcyT1APmIZRJjKvOFBulO0VpBUZp
         bvz9hCSRcYaxOsiDD5aSDarY9I0SBwqIkrusZOPH+r0qm7Hk1ixgsqn2Q+moDrS/ab4s
         /krAWc9u7RQPETLSw2VMzG/aZJnBTZ0qN88eK/MOdk+a8M8S3zUlzZk3maOnFESycdDA
         cFFcyXPo2frLFTbVPpZgMoDq4FmRJnXp59Ep1jtKuprRcSTFoXUwq0VNevxw4/AAyS1L
         O6/InAf3ar6Vt2CXzMxDD06ypaHu3Cpn0U4mwr7m2XWS2HUOuNNOx3u6l5+7Iywn7SUh
         xEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zKuQg/V734JQ52Bk2AkHR9NRP89P2pyrqBomz/3R808=;
        b=sX19/ZF1DCqIPZ0OqmlBO4dfqEx93dh8pWTG5DLRihwQ3Itncfc2yhykG0CSGc5KeJ
         4fh0rZxAnEI0j3blJ89LdBpoOZMdhW05CGuJunbvZAgdRM7Y8BFai4+Yogk3HD/hfEoC
         mapzp13gQUlFUAH+v72PQi4a/ZE3CF17pOBuWrb9cG5kh3jP8tG2Hny1G5zwD/Sr6JkL
         HP3bP52D0SP00TSuWrAWd33vq11FSPcAVbVA5aWEOdGg9qxQtcbh8fI0O68V5X+rGhO5
         uZK2LihzXT8YbG53pvVshnCwKuidd5rBUcI36OQHahINwXBulD+XqGvgIyPRocV4NJO4
         V+7Q==
X-Gm-Message-State: AOAM530FtG2gjoz0IiUULgoDOC29Gfk+4U/Lo51qBgsr11knDKuFFzhg
        6w+TlE8Wj74PWS99f/yU+X6a1A==
X-Google-Smtp-Source: ABdhPJzk+/msjtPy+gK56odrzaAF+uDCn54CXNp4xuAEJt/Zr3zDNx3DSb7724QQbj0z/HWq04YcBg==
X-Received: by 2002:a2e:9e86:: with SMTP id f6mr11881801ljk.95.1592234459927;
        Mon, 15 Jun 2020 08:20:59 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id r13sm507045lfp.80.2020.06.15.08.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 08:20:58 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/5] cpuidle: psci: Fail cpuidle registration if set OSI mode failed
Date:   Mon, 15 Jun 2020 17:20:50 +0200
Message-Id: <20200615152054.6819-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200615152054.6819-1-ulf.hansson@linaro.org>
References: <20200615152054.6819-1-ulf.hansson@linaro.org>
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

