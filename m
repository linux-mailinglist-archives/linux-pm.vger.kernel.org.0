Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2A81E8D0B
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 17:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390530AbfJ2QpB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 12:45:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34272 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390436AbfJ2QpA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 12:45:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id f5so11065557lfp.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2019 09:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vOTQa6UzVCEIiTs5syxBeghS5mOeakZSLZW0GE/rgZA=;
        b=z8D6HMBXssHVDql8bLgtR21ZuCihMSUrMxv2eBZ40PvewQtBvycZT+f6DhSg4lOPiH
         7X6DV43O6E661txvqWeXUWoySBr10Ft01XAmu1gP2suZk6RSa72qHIJlGIHMvm9PG/Sz
         VYV8bUCAYhqleRebOWTeJnJZvkyLOlkQ++cuaphGdxEwLiXzanV7i4N3AicqdXk0jh5M
         lYyDE2BARBRrwWZl3e/LgY/OenCQvf9S5DNlT/61rEWfrhETf7Bp9NtUscMqwO0HyaYG
         NkY3lp5XTuwq+hjJ90gfgvGZMhttbI3ELQivgUivPLVBXgFES08i/H+E/hmBPlDPq9m9
         bcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vOTQa6UzVCEIiTs5syxBeghS5mOeakZSLZW0GE/rgZA=;
        b=fYrx05C/gNl/DozuQS8/8JnEym4yJH2CW59/qh1ExE+zSKMs9oOsRfHxamlyzu8jIT
         YECzvDqGaSX3tZhb/ZZsJOgg8hpFdHhTGO9G7xFsbaxdXnDtDsUVUgLWBr1/bOZ4zJkh
         aBo/wZqDjHNnH3S8mJJNVesyqmpYuGE7GoAV3c+c9NK2oMJOAZmSK8zupgR4KfY0e6MA
         SiYbVHmFvrc6yDF1LWoz3XrsKKQcjy+txu+u7exOs4uubpFw0PfEu85HF7lMAMaN+F2P
         bIEVgTvuwE6yLW7GnhkfrKuWcfplngXd7Nl3YWZpVqmomf8ajROfbbih9Zw7DvmhI9Jv
         /Hdw==
X-Gm-Message-State: APjAAAVqE6RdBpMJyZhNmQzoUscYlEqPZaB5GWgjULO4Xzfhfz2zxN0H
        S84sHdhsxeLobk+BfUo5rfevvQ==
X-Google-Smtp-Source: APXvYqzNnr8T4A4xJlPf4SZM23Erro4aD3FFBbZzMuE+TOuRb5sHtT49+bOmhLjeNMTLoN2Ve55vSg==
X-Received: by 2002:ac2:520e:: with SMTP id a14mr2981413lfl.43.1572367498613;
        Tue, 29 Oct 2019 09:44:58 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id f28sm2048161lfh.35.2019.10.29.09.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 09:44:57 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 09/13] cpuidle: psci: Attach CPU devices to their PM domains
Date:   Tue, 29 Oct 2019 17:44:34 +0100
Message-Id: <20191029164438.17012-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029164438.17012-1-ulf.hansson@linaro.org>
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
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
---

Changes in v2:
	- Rebased.

---
 drivers/cpuidle/cpuidle-psci.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 830995b8a56f..167249d0493f 100644
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
@@ -78,7 +84,9 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
 {
 	int i, ret = 0;
 	u32 *psci_states;
+	struct device *dev;
 	struct device_node *state_node;
+	struct psci_cpuidle_data *data = per_cpu_ptr(&psci_cpuidle_data, cpu);
 
 	state_count++; /* Add WFI state too */
 	psci_states = kcalloc(state_count, sizeof(*psci_states), GFP_KERNEL);
@@ -104,8 +112,16 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
 		goto free_mem;
 	}
 
-	/* Idle states parsed correctly, initialize per-cpu pointer */
-	per_cpu(psci_power_state, cpu) = psci_states;
+	dev = psci_dt_attach_cpu(cpu);
+	if (IS_ERR(dev)) {
+		ret = PTR_ERR(dev);
+		goto free_mem;
+	}
+
+	data->dev = dev;
+
+	/* Idle states parsed correctly, store them in the per-cpu struct. */
+	data->psci_states = psci_states;
 	return 0;
 
 free_mem:
-- 
2.17.1

