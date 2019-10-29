Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE32E8D0F
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 17:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390515AbfJ2QpD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 12:45:03 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36513 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390643AbfJ2QpD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 12:45:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so16064333ljj.3
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2019 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oPeghc6WqG1iFH3/ouy3iONyWp9Iyx8uFEd3HgEFhLk=;
        b=wrOFgiwtszMolhgnzxseLGcu4GGivTDev2DuMZF5S+K3pvdZw3gzV80jSc+iKNalzg
         3jq/ygxLZUPCte2H+90aboCJeYosvTFeewSQrUp7gqdUcTpxl2olrUzW55dSFxqS2X4n
         pK6cwxmnWPlTEEUyOPd/NTtCaGlcbrQ1XyAZcYAnRFmd1nJTnWC+Ak01jyggNQ7zs2c1
         NUiNV7ukM36egEaPE8tXtJ5wQQVAmC7mbh2vRWBvR9tX36/S5DjLvCefJHgRLIOLINKH
         U+hqAkGNAqm8UWIDOOoA5iB7zVQgM5M46iPMTWTjK3fHlbDHnMfQ19bhe297cLV4GuUj
         9OeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oPeghc6WqG1iFH3/ouy3iONyWp9Iyx8uFEd3HgEFhLk=;
        b=dMJt8GLLvteMyDVom12Q5YLQgJdoxFy+xqM8whUYUGnHvHihHTqlij6pMvfuQkPEZM
         xGmx+aZnQ439UuyxBzvMYOTTsbtUbAhZpAgwEp2CXrzoe4PX+8wdmFQ02R8f/LgiHQIJ
         lcTeiurn2KfguEr2Wo8Mk2Ne2/cMcKxBZy4M6bmDr5PWQonJM/P5DG6fo09+hrb1tqJi
         CbkvvhOe0w3IQeGkKVaHAn7MIZkx8dMZInpjkE14F5UdbuM8Qq5k1Tnr3g6sVT3UCurt
         A0p3g7cK2F0EwKLqA/AxrB9kV8TiUIALdJdyzuHFKnrG/uEvEB54d+XYFItI7ZMFjQUZ
         +EnA==
X-Gm-Message-State: APjAAAV4dKiM+tws4XS/7W6Zp+xpfMtX92NSfFHlC6J/sYDYBdYZCVNH
        SuG92qxKwotS7GElLVwPxAPdqA==
X-Google-Smtp-Source: APXvYqyIFKxFkqbyPaXM93D7aym8tj0pRQr9/BS4/DANzI/lG6G74uINtsQQx6lGNYgWxgUkzs6yiA==
X-Received: by 2002:a05:651c:293:: with SMTP id b19mr3286729ljo.176.1572367501795;
        Tue, 29 Oct 2019 09:45:01 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id f28sm2048161lfh.35.2019.10.29.09.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 09:45:01 -0700 (PDT)
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
Subject: [PATCH v2 11/13] cpuidle: psci: Manage runtime PM in the idle path
Date:   Tue, 29 Oct 2019 17:44:36 +0100
Message-Id: <20191029164438.17012-12-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029164438.17012-1-ulf.hansson@linaro.org>
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In case we have succeeded to attach a CPU to its PM domain, let's deploy
runtime PM support for the corresponding attached device, to allow the CPU
to be powered-managed accordingly.

To set the triggering point for when runtime PM reference counting should
be done, let's store the index of deepest idle state for the CPU in the per
CPU struct. Then use this index to compare the selected idle state index
when entering idle, as to understand whether runtime PM reference counting
is needed or not.

Note that, from the hierarchical point view, there may be good reasons to
do runtime PM reference counting even on shallower idle states, but at this
point this isn't supported, mainly due to limitations set by the generic PM
domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Rebased.

---
 drivers/cpuidle/cpuidle-psci.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 4b0183d010e0..937a8e450251 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/psci.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include <asm/cpuidle.h>
@@ -25,6 +26,7 @@
 
 struct psci_cpuidle_data {
 	u32 *psci_states;
+	u32 rpm_state_id;
 	struct device *dev;
 };
 
@@ -50,13 +52,26 @@ static int psci_enter_domain_state(int idx, struct psci_cpuidle_data *data)
 {
 	int ret;
 	u32 *states = data->psci_states;
-	u32 state = psci_get_domain_state();
+	struct device *pd_dev = data->dev;
+	bool runtime_pm = (pd_dev && data->rpm_state_id == idx);
+	u32 state;
 
+	/*
+	 * Do runtime PM if we are using the hierarchical CPU toplogy, but only
+	 * when cpuidle have selected the deepest idle state for the CPU.
+	 */
+	if (runtime_pm)
+		pm_runtime_put_sync_suspend(pd_dev);
+
+	state = psci_get_domain_state();
 	if (!state)
 		state = states[idx];
 
 	ret = _psci_enter_state(idx, state);
 
+	if (runtime_pm)
+		pm_runtime_get_sync(pd_dev);
+
 	/* Clear the domain state to start fresh when back from idle. */
 	psci_set_domain_state(0);
 	return ret;
@@ -160,6 +175,7 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
 	}
 
 	data->dev = dev;
+	data->rpm_state_id = state_count - 1;
 
 	/* Idle states parsed correctly, store them in the per-cpu struct. */
 	data->psci_states = psci_states;
-- 
2.17.1

