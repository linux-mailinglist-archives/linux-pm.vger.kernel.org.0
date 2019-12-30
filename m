Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44F9012D103
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 15:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfL3Oo2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 09:44:28 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37525 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfL3Oo2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2019 09:44:28 -0500
Received: by mail-lj1-f194.google.com with SMTP id o13so22091858ljg.4
        for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2019 06:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KzTTqj8p23Akt27Kd2Hs4c3lg6YLbPXs3ATs0EVFR2M=;
        b=JCpPFKZuzoDLpUkDOuKcE6t8dYafbfR22Clus44/n9Hef4fPXDwh1TRjb+z065rvDg
         o/viC2PDowY6Nd/qjdwLbcafGiUjQEFMxLU6yqRKI8wPY10/9rarX+BejUdqBkbDm9vd
         9Z9n5/eM+fkJVT5R5Vs/Dr7pRB35rJUaDClIXV9Z+UrVQ94QdsySErw4oBeFMtYlFd5L
         tOxKqgfFBSF+ojOLNFP8YRMHr8AIQ2jAmYy+8sa7jcSo3mkI1ZZ596uUE56pv1SOGxM5
         lWD6v8tteSg8CojtKOusDP2q7wvntfRbAU4K2tC50TgVk4h7PGpP/FbUnVvDzNIXkm7h
         Qpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KzTTqj8p23Akt27Kd2Hs4c3lg6YLbPXs3ATs0EVFR2M=;
        b=pYbJfthEOkaaZ6ziaG0uRx1QckFbOB5ofjitH16DOgQxZ0nA8J5Un2voQ0iyTFX9bC
         plIGM6ZR4CICh3Hfi5I6VwjPHIr5PAFthXcJo5hsio3OtUVHqoPEZRfNyaZwRH6q8R9v
         YE8yJ2VljYERHdajjkd9Yqy2BwyXuJgKNdQPpE8r4J1Dec7ALy8K9zLgLXVdoWYtBajq
         1gpi961ZmdqpE7O8t/xW5h6brlrts6aeJDtBio4oqzKfBeA6519Vf47iRSfd7aOAGHYR
         hLwfVad3lQi8Cwp50s6+6NpENJX6nzT6gOhAwjwAtUEx+TX99ExPZpc4pJrp9DPJmURz
         ggNQ==
X-Gm-Message-State: APjAAAWv2CUbyZ6PN1jU/1r8r5oLoTyIX5ZUEr6PnZ4ALFF1n9CHmDXu
        Ir59R1W1rFXKFGJAxUV9fU58Gg==
X-Google-Smtp-Source: APXvYqzGA3gtYNDs67k65CEee1AiLGVULQ9UOPYgswEyii5PPQ7+p9U9ijvBI9aT4vNl0v8Jdj0WmQ==
X-Received: by 2002:a2e:a402:: with SMTP id p2mr39436965ljn.143.1577717066026;
        Mon, 30 Dec 2019 06:44:26 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id a21sm18744931lfg.44.2019.12.30.06.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 06:44:25 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 11/15] cpuidle: psci: Manage runtime PM in the idle path
Date:   Mon, 30 Dec 2019 15:43:58 +0100
Message-Id: <20191230144402.30195-12-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230144402.30195-1-ulf.hansson@linaro.org>
References: <20191230144402.30195-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In case we have succeeded to attach a CPU to its PM domain, let's deploy
runtime PM support for the corresponding attached device, to allow the CPU
to be powered-managed accordingly.

The triggering point for when runtime PM reference counting should be done,
has been selected to the deepest idle state for the CPU. However, from the
hierarchical point view, there may be good reasons to do runtime PM
reference counting even on shallower idle states, but at this point this
isn't supported, mainly due to limitations set by the generic PM domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---

Changes in v5:
	- None.

---
 drivers/cpuidle/cpuidle-psci.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 9600fe674a89..6e7804e697ed 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/psci.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include <asm/cpuidle.h>
@@ -51,14 +52,21 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
 {
 	struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
 	u32 *states = data->psci_states;
-	u32 state = psci_get_domain_state();
+	struct device *pd_dev = data->dev;
+	u32 state;
 	int ret;
 
+	/* Do runtime PM to manage a hierarchical CPU toplogy. */
+	pm_runtime_put_sync_suspend(pd_dev);
+
+	state = psci_get_domain_state();
 	if (!state)
 		state = states[idx];
 
 	ret = psci_enter_state(idx, state);
 
+	pm_runtime_get_sync(pd_dev);
+
 	/* Clear the domain state to start fresh when back from idle. */
 	psci_set_domain_state(0);
 	return ret;
-- 
2.17.1

