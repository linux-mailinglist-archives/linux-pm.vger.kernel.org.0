Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21BBAD282B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 13:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbfJJLkY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 07:40:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40055 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732923AbfJJLkY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 07:40:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id 7so5835469ljw.7
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2019 04:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xwB/tavfIMYf7rxHdkrDdviMkDSYXD3kklyLW60B66Q=;
        b=y5fnfZfzF20HGrbuklXhoX4IRAb3sw2pVHlyIgINlkZsqTCt4OVzOnIglZ5AC79CtD
         DsNOJpfSilfGfXZtv/tEgCB3gQiuhIGvs1zshF7zwNcTf2qOF8Fc/rMwNcZXiZTL+kw6
         Yzr2TdiZrnORg1wGpq19yH9Xcs0CIUPV2lm1fsXVYSjXlq+ZlST41yjYA2oN1KG7fjS6
         5gBBGJP6W0zkh27WfEp5bCy2cXFBBYwBVSQxDFzIbvzoUWu2TihJdw0pV2UQGtwkzvsY
         tHxQK36pjsfWSB57iJO/4O/taNsevtQefN+dNqFOeyJ3soL1660gFAXKDgtQIhwhU66S
         B0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xwB/tavfIMYf7rxHdkrDdviMkDSYXD3kklyLW60B66Q=;
        b=fTC416As53r5yhuknTSKjlst5E7dDcNdQqRbQfIUiR4jhuJTLEDySc6nbb1BvbEUIq
         4TzBR7nQK+/NOp0UZmdFH8ld+fm372p2aLjKJPivVN7XuPyYpm1iI7TS1ALSNQmT7UmP
         4MKjXaSm2l/fWWILDsNM50t+TY+NiVU40g282Sm7+CfUQCIiIQaqTRqppu7YBUOTQXLY
         ID/9A0CCqmdVpbEFODQCCjMkvpW20GpeHLt6i0jiTqkLyhCS2Rh8Zkpzomkg+DppYlk3
         Bg0gGLUUjdkqgVMZArcPZc2LBiadnpdXks9R6eLjzLzCIg2XzcLG7qHa6fjUhryg+xvo
         Q2lQ==
X-Gm-Message-State: APjAAAVO7pwLmztVNHyyeFvNO7URKBtUx5UQiBTrYbD9ZpcnBDYnrVlC
        Ncv4D08FyMJDRQAXnulympdHDg==
X-Google-Smtp-Source: APXvYqx9XzUujAF/LwxrlZOzoBs1q0AvlrOroFuQxRIn7MA18US1H4Ia1dTMLsrPBuGfqUBKeebXeA==
X-Received: by 2002:a2e:9f4d:: with SMTP id v13mr6239064ljk.226.1570707622756;
        Thu, 10 Oct 2019 04:40:22 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id p3sm1168937ljn.78.2019.10.10.04.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 04:40:22 -0700 (PDT)
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 11/13] cpuidle: psci: Attach CPU devices to their PM domains
Date:   Thu, 10 Oct 2019 13:39:35 +0200
Message-Id: <20191010113937.15962-12-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010113937.15962-1-ulf.hansson@linaro.org>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
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
 drivers/cpuidle/cpuidle-psci.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index a16467daf99d..1510422c7a53 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -23,7 +23,12 @@
 #include "cpuidle-psci.h"
 #include "dt_idle_states.h"
 
-static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
+struct psci_cpuidle_data {
+	u32 *psci_states;
+	struct device *dev;
+};
+
+static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
 static DEFINE_PER_CPU(u32, domain_state);
 
 void psci_set_domain_state(u32 state)
@@ -45,7 +50,7 @@ static int psci_enter_idle_state(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int idx)
 {
 	int ret;
-	u32 *states = __this_cpu_read(psci_power_state);
+	u32 *states = __this_cpu_read(psci_cpuidle_data.psci_states);
 	u32 state = psci_get_domain_state();
 
 	if (!state && idx)
@@ -103,7 +108,9 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
 {
 	int i, ret = 0;
 	u32 *psci_states;
+	struct device *dev;
 	struct device_node *state_node;
+	struct psci_cpuidle_data *data = per_cpu_ptr(&psci_cpuidle_data, cpu);
 
 	psci_states = kcalloc(state_nodes, sizeof(*psci_states), GFP_KERNEL);
 	if (!psci_states)
@@ -128,8 +135,16 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
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

