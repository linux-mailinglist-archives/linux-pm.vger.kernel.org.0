Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9FE1F9BD7
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 17:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbgFOPVL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 11:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730313AbgFOPVK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 11:21:10 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0EBC061A0E
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 08:21:09 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c21so9792171lfb.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 08:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhNL1X1q5NcFvN2K8EIYcmkOuXak8nPvZVNGDqJ5u0c=;
        b=OQjdZzsxvgkgfaKvQLiV9tJflG/RmsGfS4m0I+TNrGoWmxvcK+jbLmLbY/ExTtyYIY
         Vg0NakP5xmuAUYG5zcgPGVkCT9VZF1veYdWFoUD5fUgHkfVGaeNHKEJN25AAgTF8V8LQ
         PgzfhEgTzMOyHpSDNFa2qyo9TypmPVyqxH4getv5l1aDBZQ3JkpJ8cxAiWzEzKFR4E10
         49TbJjXKfSkjjPLPMQcqrsoyB/Ois6R99dzAT+FzaGoCQbXGJ1dSBUfaQ4MCqVesCMIo
         7R4yEVofwZbDenbjuj6hfTqi7qeLn8Gkf0aQ0W8V+NzNUTtNWCiLwAcU9+i8nBfBxN1i
         aXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhNL1X1q5NcFvN2K8EIYcmkOuXak8nPvZVNGDqJ5u0c=;
        b=nWuSrnIWdL9yIAEAcmREyMu6lgstllwP3QSqrKIyrnZFMA9XdGjVbzluS4ZCz8uh0t
         +fdfG1rA5oHpHV16sE//swsPTJP1UrRYMd5SgItfFoOGXvkVJy73RjP8QceTvu+PgRlp
         rOUW3K6fic/Ur9P/SFpSaWXvIBJtXm5TibQCzxbCyAu1lpABONWvVK0JNqtb88mILHPO
         auoZJD8sVQIe4lmC6jJ8uTpl+dq2Q3uuHLeX0iwkAewvRSwl3J1Io4nYsNQSDMY8eVpv
         tb62ZIj9RNoJyZdxVGvvjs5A182kySdLtgbVaw/0xEENOGywV/NKxSTJaMQhF1c8FHtr
         or+A==
X-Gm-Message-State: AOAM533K0s92qKAsxI5LbZvNyiXhN7qgKLz/eq1y3KncIm9KGIEYRIR8
        ZyXWbEJN0Ktkv4L5XPbL4fi7SA==
X-Google-Smtp-Source: ABdhPJy/VD1VcdDp5UE7jhofG7cpZxBVfQ4WtriMy9A+lszsVJNqiExptjmpyOBm9TPvrcBrm8QvWA==
X-Received: by 2002:a19:a44:: with SMTP id 65mr2240250lfk.69.1592234468265;
        Mon, 15 Jun 2020 08:21:08 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id r13sm507045lfp.80.2020.06.15.08.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 08:21:07 -0700 (PDT)
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
Subject: [PATCH 5/5] cpuidle: psci: Prevent domain idlestates until consumers are ready
Date:   Mon, 15 Jun 2020 17:20:54 +0200
Message-Id: <20200615152054.6819-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200615152054.6819-1-ulf.hansson@linaro.org>
References: <20200615152054.6819-1-ulf.hansson@linaro.org>
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

