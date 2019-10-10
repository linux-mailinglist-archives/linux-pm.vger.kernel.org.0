Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92BC0D282F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 13:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfJJLk0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 07:40:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36979 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732931AbfJJLk0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 07:40:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id l21so5851290lje.4
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2019 04:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i3G8ogm8QKvXwM8+rijht3ULF4gYpDZkzueQGi7751M=;
        b=S1K49Am4kSDehLMFo+y+aCn++SGdGyNEXyDKQRhsyEPFb1U+Qix4b9k4PUVRkwMwNo
         H1Drcbx+EDc2EDWjdPplZZWExubE/UfjqHL/TFs1EpwMdzjNtIKS46NPjhea/SBAVuq0
         ayS5Uvhu+BLV2F9mmm/wYqmAwVyQLTTLhdmXercedrMYUeL842KegEAPuu1HoOsC5IYo
         wCEzh1VrCwNsmAM5iFSLdMYtQZX5h9kLTbBXKGX6RsmAHRa+SZp3SSXIEoYZ89kE7QUv
         Ygj6ExCVVuMj5lOyunwckLd0vQXnx7AbRGLkFUfRtC+bX6wI8fQg8yvPZKfW/oaWQgOe
         QXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i3G8ogm8QKvXwM8+rijht3ULF4gYpDZkzueQGi7751M=;
        b=fTY/UWflDmxpHJDyaoHthhm40BsngCL1TW/979767za6jXYxtwBUNJqMEJewKcrojw
         7MSzizPEu52UDT0YoKrbZQGyt2E2eYL6Zi/MwzTYN2epjrBhdyMNuB85jDuyLADf8J8T
         Qtqp6u6qR+dluqWf9o7kW38qqyJcaa73kz0d+01jWxWZm2mLG3no9yzN+Ah7CxFi+hFJ
         FwyC6TJn61lyMUk1xIsyhilCL4+T43E89vI9JaBSEDH7pvaBHhRXeBWAcbXVk8fLfXpW
         b0PoT2qBvpgeHvoJZ/I+cIzcrnwiMas4vrS27MfvDXVgq6h71vjWkmacfhs5Rp3B/xPu
         +ItQ==
X-Gm-Message-State: APjAAAVpDDv5kA2Dt0hXUTPXNynd5UOPq123Y8CyEuEeW6zJRDSvgV9d
        SLMSEKvcdms+YCXI4/bamA0uzg==
X-Google-Smtp-Source: APXvYqwOX8ItiDZEA+kQQBb68Jv+sNmaYtISkfDtd1UlzUU+vXQj3Y0mD4hDx6nLR//tbqlRlepYnA==
X-Received: by 2002:a2e:8310:: with SMTP id a16mr177041ljh.48.1570707624283;
        Thu, 10 Oct 2019 04:40:24 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id p3sm1168937ljn.78.2019.10.10.04.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 04:40:23 -0700 (PDT)
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
Subject: [PATCH 12/13] cpuidle: psci: Manage runtime PM in the idle path
Date:   Thu, 10 Oct 2019 13:39:36 +0200
Message-Id: <20191010113937.15962-13-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010113937.15962-1-ulf.hansson@linaro.org>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
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
 drivers/cpuidle/cpuidle-psci.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 1510422c7a53..0919b40c1a85 100644
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
 
@@ -50,14 +52,28 @@ static int psci_enter_idle_state(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int idx)
 {
 	int ret;
-	u32 *states = __this_cpu_read(psci_cpuidle_data.psci_states);
-	u32 state = psci_get_domain_state();
+	struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
+	u32 *states = data->psci_states;
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
 	if (!state && idx)
 		state = states[idx - 1];
 
 	ret = __psci_enter_idle_state(idx, state);
 
+	if (runtime_pm)
+		pm_runtime_get_sync(pd_dev);
+
 	/* Clear the domain state to start fresh when back from idle. */
 	psci_set_domain_state(0);
 	return ret;
@@ -142,6 +158,7 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
 	}
 
 	data->dev = dev;
+	data->rpm_state_id = state_nodes;
 
 	/* Idle states parsed correctly, store them in the per-cpu struct. */
 	data->psci_states = psci_states;
-- 
2.17.1

