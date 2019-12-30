Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F4912D0FE
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 15:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfL3OoZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 09:44:25 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44343 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbfL3OoZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2019 09:44:25 -0500
Received: by mail-lj1-f195.google.com with SMTP id u71so33510098lje.11
        for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2019 06:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F62eMHvAlv7nF3GieiDqKuJt4z4o+7t76tdVx5DtOc8=;
        b=xKKUKeIOyuo2s2W+neuN/sbW173fQNrou3tC+j6v7Ko/GuV217MXietDZKhjA3Uskq
         +oGLDtucefGKWLnVAkdy0EhggOa4EVlAW3GgnRf3Q///TpMXhcvS47NgjBgaWEZcvHEa
         sNPyCIaZTNdpqI7KOnRBwON5a3hrpogrN9d9Ws+HKMrAubG/J+RRvvjmiuXp2X5RAeLx
         6xSd9DNxkiJYPcmnO5P1a2Ljaf0kWX0Uv0AmAJhO8VjFrwyPTyVlJYM0h5cT5tIv0xYm
         DOGryt9AIk3n2s3w+VoyOqVcAFEb685q0iz4QCXHyot3S9+MEpZiMmxb1W2IxQea5VsV
         oLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F62eMHvAlv7nF3GieiDqKuJt4z4o+7t76tdVx5DtOc8=;
        b=Qz/Cp93DkwYf79DcfnGuflKxwZuKm6IdXdt8UkaKsyeeCZB6zwyis90xUVgtoGWSPJ
         utG7hH2yc/gwtQdft9MHiHZVSmCWVvfT/bLokUDzg5U9t8rpxibfriyD6yCiHR3PM6Ic
         Ss7CA+95alkTPnEi6pT6knYIVpx3XzYuwu0vfbP8P5KYC6vTw9Y5QfEVTwbvDBmubGOe
         hAxyfyxC07BCr03z4TChY+X6X1NE6x2b1GiH8Kj+haGGeDkbpCf2vExvcW8l0O+1SJzB
         KpDWrXa4ngHAmzE3vr5hlGeOaYEAbwbRIZWlifQvIn+syNjRPdVwywBbs+uJYUgGswBM
         bYDQ==
X-Gm-Message-State: APjAAAUgpvp3xRhvkLViWgCbMbI2ezYEL+P5Y0MbIAXlc9/Uc1SA+o6J
        7htUO3CmKoSMg9MBujRslfySMQ==
X-Google-Smtp-Source: APXvYqx5ku6KI9MfPdQZ+SWjpmvOotL42D1PWyIwc9k7LE5GzctpSfHSXBO4s15SrZ/WJeAsBlX0Ug==
X-Received: by 2002:a2e:8e22:: with SMTP id r2mr32224867ljk.51.1577717063226;
        Mon, 30 Dec 2019 06:44:23 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id a21sm18744931lfg.44.2019.12.30.06.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 06:44:22 -0800 (PST)
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
Subject: [PATCH v5 09/15] cpuidle: psci: Attach CPU devices to their PM domains
Date:   Mon, 30 Dec 2019 15:43:56 +0100
Message-Id: <20191230144402.30195-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230144402.30195-1-ulf.hansson@linaro.org>
References: <20191230144402.30195-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to enable a CPU to be power managed through its PM domain, let's
try to attach it by calling psci_dt_attach_cpu() during the cpuidle
initialization.

psci_dt_attach_cpu() returns a pointer to the attached struct device, which
later should be used for runtime PM, hence we need to store it somewhere.
Rather than adding yet another per CPU variable, let's create a per CPU
struct to collect the relevant per CPU variables.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---

Changes in v5:
	- None.

---
 drivers/cpuidle/cpuidle-psci.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 830995b8a56f..6a87848be3c3 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -20,14 +20,20 @@
 
 #include <asm/cpuidle.h>
 
+#include "cpuidle-psci.h"
 #include "dt_idle_states.h"
 
-static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
+struct psci_cpuidle_data {
+	u32 *psci_states;
+	struct device *dev;
+};
+
+static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
 
 static int psci_enter_idle_state(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int idx)
 {
-	u32 *state = __this_cpu_read(psci_power_state);
+	u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
 
 	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter,
 					   idx, state[idx]);
@@ -79,6 +85,7 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
 	int i, ret = 0;
 	u32 *psci_states;
 	struct device_node *state_node;
+	struct psci_cpuidle_data *data = per_cpu_ptr(&psci_cpuidle_data, cpu);
 
 	state_count++; /* Add WFI state too */
 	psci_states = kcalloc(state_count, sizeof(*psci_states), GFP_KERNEL);
@@ -104,8 +111,17 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
 		goto free_mem;
 	}
 
-	/* Idle states parsed correctly, initialize per-cpu pointer */
-	per_cpu(psci_power_state, cpu) = psci_states;
+	/* Currently limit the hierarchical topology to be used in OSI mode. */
+	if (psci_has_osi_support()) {
+		data->dev = psci_dt_attach_cpu(cpu);
+		if (IS_ERR(data->dev)) {
+			ret = PTR_ERR(data->dev);
+			goto free_mem;
+		}
+	}
+
+	/* Idle states parsed correctly, store them in the per-cpu struct. */
+	data->psci_states = psci_states;
 	return 0;
 
 free_mem:
-- 
2.17.1

