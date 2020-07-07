Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFD5216D4C
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 14:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgGGM6b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 08:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgGGM6b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 08:58:31 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD26FC061755
        for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2020 05:58:30 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so49791083ljg.13
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2020 05:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CYhuF0zVY5i8kQEARQ65YbwasNE9FCG8p/MJLf/CDkM=;
        b=XRKE1m42wozCzlMVoYCRUQuqeOC9av7JxEB0gwGu6watUzk7LuG9aJ/E6jKGbRvkPf
         lu+/bZqn3eoofwBRRy6Kb2FRSiGWl7+BlPuBspBCydJFUTN6aXo5mOUABE8Xb62Sqc0q
         PElQwHWDYxvQXUUwipKFhU6k/MdymHIo4xd16Srh65KoyBXb5a3p+vvoTCH1TyzitwkI
         0lhh/qL0W69CpnF8Hv7TFmkHA7lf4oDTGeErnaSb5PVXiL9KebNEjbSpZIrK76ZwSlz0
         E1O4cn1fnbBkVATsvl9XuczLYbOuF/jm0yuOMyykFxBPDxn6SOQfbqxnP7aIGeF6pbFR
         fYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYhuF0zVY5i8kQEARQ65YbwasNE9FCG8p/MJLf/CDkM=;
        b=rNOPfHXnkAf9fe9R+VjUi1IVwszU5/HH0x3UxzZEfHN1IPktn2TBZBWyeBMJ/+t6p2
         fj3tkI1sOvrPzP3aIOaprSHh6l+nvOraxPcwrklAnXS5smfvJ5zzeDxHEsC28isomX/x
         Tx3MueuztOjOf05NGm06JoaqMeSYR/wQ/GSHqWnIDb/phr8NzMKDA6U1Nokya1prS7pN
         fPi4xyR15yN2HgNA3B/ggExRpX/2e4RwFAnb6yLBG4Ol/TidYeauWTigitKIbzWIleBN
         uFOLpB/A48lZkeI9VzT82yJ8OENf5gVpLDJ4YUEeeDw/z6OCNsRKXIcdRH++r9yaRuEE
         Y74Q==
X-Gm-Message-State: AOAM531gzhkrZv3in5K48aA+1csQ1Vs46Lacn/OgGF9oewl6h0z3LibI
        HWfuC90GUsKU/FM3Jsv9Xokg1w==
X-Google-Smtp-Source: ABdhPJxbyT/FghZpCKz9xb09tQjwD2xzc8YuE3qmmbt66tP8td4H3OMfxh3JHoGmbJoHRbHEExwVww==
X-Received: by 2002:a05:651c:2043:: with SMTP id t3mr30863147ljo.0.1594126709210;
        Tue, 07 Jul 2020 05:58:29 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id 11sm9554395lfz.78.2020.07.07.05.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 05:58:28 -0700 (PDT)
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
Subject: [PATCH v2 5/5] cpuidle: psci: Prevent domain idlestates until consumers are ready
Date:   Tue,  7 Jul 2020 14:58:04 +0200
Message-Id: <20200707125804.13030-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707125804.13030-1-ulf.hansson@linaro.org>
References: <20200707125804.13030-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Depending on the SoC/platform, additional devices may be part of the PSCI
PM domain topology. This is the case with 'qcom,rpmh-rsc' device, for
example, even if this is not yet visible in the corresponding DTS-files.

Without going into too much details, a device like the 'qcom,rpmh-rsc' may
have HW constraints that needs to be obeyed to, before a domain idlestate
can be picked.

Therefore, let's implement the ->sync_state() callback to receive a
notification when all consumers of the PSCI PM domain providers have been
attached/probed to it. In this way, we can make sure all constraints from
all relevant devices, are taken into account before allowing a domain
idlestate to be picked.

Acked-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index bf527d2bb4b6..b6e9649ab0da 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -27,6 +27,7 @@ struct psci_pd_provider {
 };
 
 static LIST_HEAD(psci_pd_providers);
+static bool psci_pd_allow_domain_state;
 
 static int psci_pd_power_off(struct generic_pm_domain *pd)
 {
@@ -36,6 +37,9 @@ static int psci_pd_power_off(struct generic_pm_domain *pd)
 	if (!state->data)
 		return 0;
 
+	if (!psci_pd_allow_domain_state)
+		return -EBUSY;
+
 	/* OSI mode is enabled, set the corresponding domain state. */
 	pd_state = state->data;
 	psci_set_domain_state(*pd_state);
@@ -222,6 +226,15 @@ static void psci_pd_remove_topology(struct device_node *np)
 	psci_pd_init_topology(np, false);
 }
 
+static void psci_cpuidle_domain_sync_state(struct device *dev)
+{
+	/*
+	 * All devices have now been attached/probed to the PM domain topology,
+	 * hence it's fine to allow domain states to be picked.
+	 */
+	psci_pd_allow_domain_state = true;
+}
+
 static const struct of_device_id psci_of_match[] = {
 	{ .compatible = "arm,psci-1.0" },
 	{}
@@ -289,6 +302,7 @@ static struct platform_driver psci_cpuidle_domain_driver = {
 	.driver = {
 		.name = "psci-cpuidle-domain",
 		.of_match_table = psci_of_match,
+		.sync_state = psci_cpuidle_domain_sync_state,
 	},
 };
 
-- 
2.20.1

