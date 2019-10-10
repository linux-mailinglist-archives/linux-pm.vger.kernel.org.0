Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEF9D2826
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 13:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbfJJLkV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 07:40:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42041 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732848AbfJJLkV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 07:40:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id c195so4110677lfg.9
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2019 04:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p5qrlgEHHz72OqawbaM4oNKQbRiSCqvlNCrVec5FI84=;
        b=fpTsBvZBXrvTN9zR+IrMwIGukuhZz6A+ldBwdcZi85by9XgVOP/bWsZrqXdciNslhQ
         hPSQ87yb+x0ew8Zra1SvLTZ/P48Hr3FZUtR+nc3Bf+KjolueaFc8mzWO7hCTf5JTZ53J
         GY5IkZKAU60fnj9UwZMeKc4KEFiIVOqUHjv08fBOzAHTlLevorIgxgahat41rZdmOHja
         NUdOFzdcgrXCmknjYH2vORo7/nhAmDa0V6rUyNJERU3OmJlYnNSJONJXOFyK9xkZzVhT
         BZKrXoMMpkDffL35v7BHgNLabiW8/lWryfjLPNpRXqpI8THMQwTtCoxQ3KIMmGeK8+Ak
         oyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p5qrlgEHHz72OqawbaM4oNKQbRiSCqvlNCrVec5FI84=;
        b=UstTZvgkwjkoHIpCJmeycr5npYygRJ7W0qZt+cOXy7GX3ZnHspoau//0PqiMWDUeIo
         QChnuZzxb52ncFFf3Vi79nAtDaI0DKhczNpDzk9QHmUM5wEFtpIW8ii/7lwOEXdp686x
         JibtIAXgyTxi7uHuqY+kSbqnD6sDuc5qEztL0WcOHo/j8gYyBPcnXPXC/h7MocgYyASA
         X6PvB2BL63IISRmXP95ytU7zKO5p1iNRg1vr/9l4ZOEQsg8d2qSy722NNRE4xa23amnJ
         HkVasnK/jssZi8hnZrRonpQXTcyVmPrkcSMQ3R2AnY3JiyUtESR8Yj617qXVCKdp5s17
         F6Cw==
X-Gm-Message-State: APjAAAXouk0ctl8h/jrpDqq36xYBfgM9hOfeSsc2aGFNbI9hoGNC1wRj
        +HwR9NiOz74M1R1UeaPFwxj+mQ==
X-Google-Smtp-Source: APXvYqwurmeJAb45mxPdDwDdgYZyKg506CrXtVc4YhleXcNpg+js8O9MZD5A1KTQyHAY5EPoYkaFnA==
X-Received: by 2002:a19:ed14:: with SMTP id y20mr5807432lfy.4.1570707618117;
        Thu, 10 Oct 2019 04:40:18 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id p3sm1168937ljn.78.2019.10.10.04.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 04:40:17 -0700 (PDT)
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
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 08/13] cpuidle: psci: Prepare to use OS initiated suspend mode via PM domains
Date:   Thu, 10 Oct 2019 13:39:32 +0200
Message-Id: <20191010113937.15962-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010113937.15962-1-ulf.hansson@linaro.org>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The per CPU variable psci_power_state, contains an array of fixed values,
which reflects the corresponding arm,psci-suspend-param parsed from DT, for
each of the available CPU idle states.

This isn't sufficient when using the hierarchical CPU topology in DT, in
combination with having PSCI OS initiated (OSI) mode enabled. More
precisely, in OSI mode, Linux is responsible of telling the PSCI FW what
idle state the cluster (a group of CPUs) should enter, while in PSCI
Platform Coordinated (PC) mode, each CPU independently votes for an idle
state of the cluster.

For this reason, introduce a per CPU variable called domain_state and
implement two helper functions to read/write its value. Then let the
domain_state take precedence over the regular selected state, when idling
the CPU in psci_enter_idle_state().

This allows subsequent patches that implements support for PM domains for
cpuidle-psci, to write the selected idle state parameter for the cluster
into the domain_state variable. Furthermore, let's share the needed
functions in a header file, to enable the support for PM domains to be
implemented in a separate c-file.

Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci.c | 31 ++++++++++++++++++++++++++++---
 drivers/cpuidle/cpuidle-psci.h | 11 +++++++++++
 2 files changed, 39 insertions(+), 3 deletions(-)
 create mode 100644 drivers/cpuidle/cpuidle-psci.h

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 5c30f23a8a7b..a16467daf99d 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -20,17 +20,42 @@
 
 #include <asm/cpuidle.h>
 
+#include "cpuidle-psci.h"
 #include "dt_idle_states.h"
 
 static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
+static DEFINE_PER_CPU(u32, domain_state);
+
+void psci_set_domain_state(u32 state)
+{
+	__this_cpu_write(domain_state, state);
+}
+
+static inline u32 psci_get_domain_state(void)
+{
+	return __this_cpu_read(domain_state);
+}
+
+static int __psci_enter_idle_state(int idx, u32 state)
+{
+	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
+}
 
 static int psci_enter_idle_state(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int idx)
 {
+	int ret;
 	u32 *states = __this_cpu_read(psci_power_state);
-	u32 state = idx ? states[idx - 1] : 0;
+	u32 state = psci_get_domain_state();
 
-	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
+	if (!state && idx)
+		state = states[idx - 1];
+
+	ret = __psci_enter_idle_state(idx, state);
+
+	/* Clear the domain state to start fresh when back from idle. */
+	psci_set_domain_state(0);
+	return ret;
 }
 
 static struct cpuidle_driver psci_idle_driver __initdata = {
@@ -56,7 +81,7 @@ static const struct of_device_id psci_idle_state_match[] __initconst = {
 	{ },
 };
 
-static int __init psci_dt_parse_state_node(struct device_node *np, u32 *state)
+int __init psci_dt_parse_state_node(struct device_node *np, u32 *state)
 {
 	int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
 
diff --git a/drivers/cpuidle/cpuidle-psci.h b/drivers/cpuidle/cpuidle-psci.h
new file mode 100644
index 000000000000..e593de1784c3
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-psci.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __CPUIDLE_PSCI_H
+#define __CPUIDLE_PSCI_H
+
+struct device_node;
+
+void psci_set_domain_state(u32 state);
+int __init psci_dt_parse_state_node(struct device_node *np, u32 *state);
+
+#endif /* __CPUIDLE_PSCI_H */
-- 
2.17.1

