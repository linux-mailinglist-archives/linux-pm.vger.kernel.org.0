Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49EFA11B3BB
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 16:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388751AbfLKPoJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 10:44:09 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45995 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731834AbfLKPoI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 10:44:08 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so17016568lfa.12
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 07:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZEqQy0QuBsg1TqWJIDaDl2CROKkjokF3ooQD0C47ttQ=;
        b=crgggGsC3dwf7AJpgrpv7kiGHF0JSSV9L2QDRT6xPS3QwxZWH7sgggU0/LquhhHokm
         zkco4V/uRz2u/hqibm2QejtHtq4Ir5uj3ArxE/PyRQ0aIkkaTRzgm/KIwgkEvRZkKlM+
         cBaNX4NfPKTCSakCdK7opEN0D6LCpsB6Cq/zFgnvyqUWWayJQrvaVPOYLyONQIlIFtnU
         5/PvHNppqyW2XqLkgWXRI2iZRezylJ0cOdImrm90k8NP72fDvgO07gNPQabsjcPMhBzt
         fPCkAiYyGUfyR0ONYMqaTRoqjqGxXWM8qiud4j7NNNGaz3dralBEf1UmqJWYm3cn9x8r
         3fLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZEqQy0QuBsg1TqWJIDaDl2CROKkjokF3ooQD0C47ttQ=;
        b=hNKaQxy7SXEGgNlTGD+Zv0i/9kXgQ+/N6o5xUrE702JJpGc0uDYsjdNljWQP4xi7nj
         09l553EwEhC7n2+3lF8t3KZBiFz8H45V/mdotLtjPuN31QWd/OzYEovX1XTRyeTlMMvL
         2rJ77ct2RTIl3l8356zUxSUBlWsY8KgkDW9EXDoamM+JU7GmfB2ae7FpjA7TWh4niDSe
         4wzoTknolqKrcgsCkDB/vsiTE1fnEw6AOyoLEwqpewGXSvnIoH444Y3COlW+ejXCv4t8
         IuCTeSZur8vlQdMtTcsx3ofukibK5JOvvD/Nuf/njxfAvqI/sc/RbSZ3jWp1/477S/we
         eLKQ==
X-Gm-Message-State: APjAAAWos5CTZAOqgUvsaXXFTB4gsSu7/dTXOnzNzj8oZBXsQNDfJChl
        4UjsotoVN1HxoPQSu1t1/dtfSa90DiA=
X-Google-Smtp-Source: APXvYqz6G0V9w/CiBy3QQqH4g4H8jB9GpTQH6XahhQT/gJ+INB0/yKI1QY+9Pl+Z9bTJ0xaRV6xGag==
X-Received: by 2002:ac2:5e9b:: with SMTP id b27mr2649079lfq.147.1576079046311;
        Wed, 11 Dec 2019 07:44:06 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b14sm1389608lff.68.2019.12.11.07.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:44:05 -0800 (PST)
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
Subject: [PATCH v4 09/14] cpuidle: psci: Attach CPU devices to their PM domains
Date:   Wed, 11 Dec 2019 16:43:38 +0100
Message-Id: <20191211154343.29765-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211154343.29765-1-ulf.hansson@linaro.org>
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
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

Changes in v4:
	- Add check for OSI support before calling psci_dt_attach_cpu().

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

