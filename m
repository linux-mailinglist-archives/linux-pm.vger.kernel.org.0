Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD0ABE8D0E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 17:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390553AbfJ2QpD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 12:45:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43961 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390515AbfJ2QpD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 12:45:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id s4so15137016ljj.10
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2019 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rmTg5S9BzhED65UVWftQq6ljq1LQZhA0EBbzU9hhqeQ=;
        b=aqzEO0G1RyLhLQmCiDT2JleGD1IdETwghK3gyCVpU3BoJ9IuHC/mJJtZqyEw7OS5bY
         8Pt4WTtjZ+5IeX1WyaqK0oxx9v79xIuTQqk2y4zsdW41U0BO6JplWCJNK0dtZpODoM0L
         0lKghAQnovyr1JsLBsc29QAhAX43dJTSGZc4b1wvan915ofokrkC+6XjliyFzkzr/lyG
         NG0DkvysJMRGehwK4eH/+gmFLoocqpJy2k/jfeIAAVJjfDpLGzFhNnCrBqv5ZeazYjAn
         JlUcvaviVU0GvIb7r3OWkBXXWrrW+mGtVJequx0KFAO2HlykGcmi2A0fAv9aJQmGLA+b
         GqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rmTg5S9BzhED65UVWftQq6ljq1LQZhA0EBbzU9hhqeQ=;
        b=gaZt0qWTbo7sNIJ0ViI9dMpsnrcn24bwjFcHfXcGyDEQeZcUPJkahzteX3HVuSuIAD
         MrbfRnaw2Khb0X9clgP3Gk5aTkNkuUQIU5BIPIT+18PfMfdi87m8776lSNwbZhsT4dTh
         uzk7ZkGy2SArgel2Hk6zft6NzBkhdads4AVH0rPjWyJJlzy0sTemY0vZgO9nv77l7H4h
         SCy3IxN6HeSM25vBgIspZgAsGFOOdrhEsARy8xt3duBDOqdTmjMC5oYBkNaABb88Xb7m
         OQsNu/omtFzCrWgLBdIiyFZViZ6nJqz08vggPiFdSnCCELbHKNkhid6kq1mjq/rz2VZt
         uJFg==
X-Gm-Message-State: APjAAAVOFkxZ0/Zo3iXy8Hf/py/3lD74DVGrbcHaspiPD3eVJAyXQ36s
        7fvFTETNzXY3AtAgxNNR3SipEIC/P2g=
X-Google-Smtp-Source: APXvYqzEL/7R3mVVyBqWfGuEW21GUqv79UeOF7RbekoESh7r+dEmrlO8kUYeAvjCF8KRrW5zWEFfXw==
X-Received: by 2002:a2e:8113:: with SMTP id d19mr3480037ljg.229.1572367500173;
        Tue, 29 Oct 2019 09:45:00 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id f28sm2048161lfh.35.2019.10.29.09.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 09:44:59 -0700 (PDT)
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
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 10/13] cpuidle: psci: Prepare to use OS initiated suspend mode via PM domains
Date:   Tue, 29 Oct 2019 17:44:35 +0100
Message-Id: <20191029164438.17012-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029164438.17012-1-ulf.hansson@linaro.org>
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
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
domain_state take precedence over the regular selected state, when entering
and idle state.

Finally, let's also avoid sprinkling the existing non-OSI path with
operations being specific for OSI.

Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Rebased.

---
 drivers/cpuidle/cpuidle-psci.c | 47 +++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 167249d0493f..4b0183d010e0 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -29,14 +29,55 @@ struct psci_cpuidle_data {
 };
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
+static DEFINE_PER_CPU(u32, domain_state);
+
+static inline void psci_set_domain_state(u32 state)
+{
+	__this_cpu_write(domain_state, state);
+}
+
+static inline u32 psci_get_domain_state(void)
+{
+	return __this_cpu_read(domain_state);
+}
+
+static inline int _psci_enter_state(int idx, u32 state)
+{
+	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
+}
+
+static int psci_enter_domain_state(int idx, struct psci_cpuidle_data *data)
+{
+	int ret;
+	u32 *states = data->psci_states;
+	u32 state = psci_get_domain_state();
+
+	if (!state)
+		state = states[idx];
+
+	ret = _psci_enter_state(idx, state);
+
+	/* Clear the domain state to start fresh when back from idle. */
+	psci_set_domain_state(0);
+	return ret;
+}
+
+static int psci_enter_state(int idx, struct psci_cpuidle_data *data)
+{
+	u32 *states = data->psci_states;
+
+	return _psci_enter_state(idx, states[idx]);
+}
 
 static int psci_enter_idle_state(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int idx)
 {
-	u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
+	struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
+
+	if (!data->dev)
+		return psci_enter_state(idx, data);
 
-	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter,
-					   idx, state[idx]);
+	return psci_enter_domain_state(idx, data);
 }
 
 static struct cpuidle_driver psci_idle_driver __initdata = {
-- 
2.17.1

