Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A88B212D0EF
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 15:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfL3OoM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 09:44:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33079 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfL3OoM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2019 09:44:12 -0500
Received: by mail-lj1-f196.google.com with SMTP id y6so25494261lji.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2019 06:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yJwsi3DMV/pwzB8sWAmHjBjjwOzOWtOVx10q5OKc/Qg=;
        b=VLgbT14aKbIweXjePyokMcXGIZ6qb6kWlnLdbU2O9QNBikijGUeMsDJ5BerDOGJVyP
         hT/gOq3EcoVXwl4kpM8e3733iP90YILT3RaXDUM2AuU9KGQt4qYTgy6f6jabQM8o6m0z
         f2Dw+FKT/VwRq6dj/Q+Mb4OPmk5DBWeU3Am8tGUkQkau5kdcLudikh879SjNbyZlbktm
         lKJi0S1dkLtuKh4sR51iIzOPusJcnwu9cu+P1Mbyr5xhvb7FvMb2wY+1GVhDzNKRCsz4
         LDcl7o0n0E5yYOD6GEMWIYriiQq1ppx9SFRSm2kbu+C3hWO2xWy6bgqtGzmp6tbF8BLn
         M+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yJwsi3DMV/pwzB8sWAmHjBjjwOzOWtOVx10q5OKc/Qg=;
        b=M1j01Oa2w0WOdd3pwurrg33Nx0k5ifeNuQto/FPbfyHjwCFZ/ih2h4tqz42CnMF6eh
         wE8ogBXunK9owXLJflnmLur/mLUUtf1QdEnd9f1kcOYv92hcTiZfnUC4k1aZHReXlDfv
         qLWg8qk7HxVbdiPJqj1m+yRcKIiwjpaueW79/oJI5opocXW8B1oD9BECBSC8reLxLFGl
         9KL3xtCm1hpJn/J+efBjFWLWYfdKjLaY8UW0rx+DvrJKUnBSIK5DbbdGcidx/MIDRyKw
         OxCaURPDHkvptVOkgyEW0YET4dAFPQ1iq6dEx/EkGIQ4NydJzTn2vMgb5J/gPMoncQ9D
         A6Gw==
X-Gm-Message-State: APjAAAWCSFL0euNSFgv2J9qZ1iFqNUUtGr8Fm/TcEkqndPTQfMqeI70W
        mDKzaxZsCnb/nGHWpIQfdCEniA==
X-Google-Smtp-Source: APXvYqwN0EAf9bCeoE9MhNqvKtGj6Kuzpeq236RUFu+VyIzagp3j7CmYdCtkZY/sNNfmqJXTyE+Ieg==
X-Received: by 2002:a2e:9e43:: with SMTP id g3mr23393509ljk.37.1577717050174;
        Mon, 30 Dec 2019 06:44:10 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id a21sm18744931lfg.44.2019.12.30.06.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 06:44:09 -0800 (PST)
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
Subject: [PATCH v5 01/15] cpuidle: psci: Align psci_power_state count with idle state count
Date:   Mon, 30 Dec 2019 15:43:48 +0100
Message-Id: <20191230144402.30195-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230144402.30195-1-ulf.hansson@linaro.org>
References: <20191230144402.30195-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

Instead of allocating 'n-1' states in psci_power_state to manage 'n'
idle states which include "ARM WFI" state, it would be simpler to have
1:1 mapping between psci_power_state and cpuidle driver states.

ARM WFI state(i.e. idx == 0) is handled specially in the generic macro
CPU_PM_CPU_IDLE_ENTER_PARAM and hence state[-1] is not possible. However
for sake of code readability, it is better to have 1:1 mapping and not
use [idx - 1] to access psci_power_state corresponding to driver cpuidle
state for idx.

psci_power_state[0] is default initialised to 0 and is never accessed
while entering WFI state.

Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v5:
	- None.

---
 drivers/cpuidle/cpuidle-psci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index f3c1a2396f98..361985f52ddd 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -30,7 +30,7 @@ static int psci_enter_idle_state(struct cpuidle_device *dev,
 	u32 *state = __this_cpu_read(psci_power_state);
 
 	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter,
-					   idx, state[idx - 1]);
+					   idx, state[idx]);
 }
 
 static struct cpuidle_driver psci_idle_driver __initdata = {
@@ -89,12 +89,14 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 	if (!count)
 		return -ENODEV;
 
+	count++; /* Add WFI state too */
 	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
 	if (!psci_states)
 		return -ENOMEM;
 
-	for (i = 0; i < count; i++) {
-		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+	for (i = 1; i < count; i++) {
+		state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
+					      i - 1);
 		ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
 		of_node_put(state_node);
 
-- 
2.17.1

