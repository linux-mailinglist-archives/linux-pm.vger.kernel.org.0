Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6094010ADAD
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 11:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfK0K3d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 05:29:33 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41563 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfK0K3d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 05:29:33 -0500
Received: by mail-lf1-f67.google.com with SMTP id m30so14858619lfp.8
        for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2019 02:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YDuIKF2u/t0zqT/PFLBo98uaEM9517X/GbUauBtkgr4=;
        b=uwA+m9WfDKjbBezkbOrLRu6yVTPgdRr7kEaV+WDMwVHp8ndZU/bqjiqpTu6iTDRlwE
         GEWtK1C4weec3gXsxWUz/Zt1apMdmrxCCgNwXHY7InzJGDHWLtrYlLRO35DEsLa1CTJn
         1l99Xc5nKfxNduW4sFOWbjZ3zYHkk/mf5TJlf7YixTNEvWaG8LrHE0i5fl45a4zGrGp1
         iXLfXve7JYW27J32oSQ90Gl7NOb/jFc8I9ZxbFGbYFzT5zDOD25O6IAc7rkRood2iEFi
         bUj9OMlBVeQ4c8LxU358f78a4DJDQ/xZvj9XRyBM1QFFM4b9F7yFMc0Xwsd+wQusQnuS
         Nu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YDuIKF2u/t0zqT/PFLBo98uaEM9517X/GbUauBtkgr4=;
        b=szlqJRnQXAT7OM5LbkJaJw5s3VWCd57X6OQohM6jhtNhK9KoMN12UHNaD5UVBe8ruD
         B8Fu74NdNaE8TCp+0PFqtDBCwTQ5ypFhPwe9gslHV2qV3amNCzQ79E/eAHN1iQF+ZSo6
         Z+hZMKMF28rKdI41RvB5pXO+dXlp+QkS/OJeAvaImucFsmz4nsn2QgBASAqtlMR0MVbA
         IMzIgr44ycYRHxDlEpUa50WDTnwfgfr1a+2/1VYYUCh+tQGswXZHQxvslTpiwMnBE73f
         BCxzxrNw6NLODddpNsoE29aG6pD4Ku+0f1tw5cZavSu1dIpUk2qJQLnWvLRlFOgWJSuv
         y6iw==
X-Gm-Message-State: APjAAAWyVkgELUMnGkExq+jzgIBzhqPzVQu/FrzFfl288Li5YCgP3kzm
        hrQgwn/3F5r9Ow945q8xti79Tw==
X-Google-Smtp-Source: APXvYqzR+IbfU/o0Fa1cQvZhfrwH8z5ze9YCQCLSUiMUNU6DIDIY20P09bbx6zldipb6zrULTiqGXw==
X-Received: by 2002:ac2:5462:: with SMTP id e2mr18613613lfn.181.1574850570998;
        Wed, 27 Nov 2019 02:29:30 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t9sm6868260ljj.19.2019.11.27.02.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 02:29:30 -0800 (PST)
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
Subject: [PATCH v3 09/13] cpuidle: psci: Attach CPU devices to their PM domains
Date:   Wed, 27 Nov 2019 11:29:10 +0100
Message-Id: <20191127102914.18729-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191127102914.18729-1-ulf.hansson@linaro.org>
References: <20191127102914.18729-1-ulf.hansson@linaro.org>
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

Changes in v3:
	- None.

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

