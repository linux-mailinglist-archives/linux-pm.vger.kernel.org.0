Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 304DC10ADAA
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 11:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfK0K3g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 05:29:36 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36506 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfK0K3g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 05:29:36 -0500
Received: by mail-lf1-f68.google.com with SMTP id f16so16727474lfm.3
        for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2019 02:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9WNvBkAbCPmItbuJwau3VVcwaQ3svcRnmaumQExcBPY=;
        b=LVyx7O2W4qGw1a4q/S1Yriak16eQr191zdaPkA2t1RAdn2hi6FFOjti6ZrYVNL10DX
         RJ+WW95uhdNfmuZRig1tBSv/JMjWpg2BvY9fHYN5vuR/Ns4VGoBlNzrmJacvs5mWJtWX
         gaSvfQ7eTU8Q1nxVVjkpaWtZIcfi/GE6HURMotCbiwX00oXBD158f9x+TVIgJ/3ZH7/h
         xZxZiv+9oQiDI8L2bE5YSYH0cmDP9/6phxaCR2dA3EjHx3DBO93b+vMkfbgzGN/mhSgG
         1oXq4QU9PiRHlmui545BrHmoZKkPIC/CMAAQ5rX9b+o1nys9wnH9b+OaoOBTod0wJMSx
         SXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9WNvBkAbCPmItbuJwau3VVcwaQ3svcRnmaumQExcBPY=;
        b=imC0takUQsGLP9kThFsTXEWLLarFhGvhSsj0+GxF04VIA6g43td+11P/yi35cscp61
         onNhK4kLt8DuBLVd3lTSpNwBkXTHdKW99H3G1RbzvJWQJcU6fGyywANiGK5wbmnFrF03
         2o6vFiyzo6W2aTwji2Ke4tfOqP0Ra0jjdcHnA6QrCn60wCht2IX74JzHoAM/G4yljmY5
         PmeOb8CGUk1jIchabZwBGWZUSAz3wK6HHuNac1lgP07GCblsWAtl/TpMwnoM7xEVvP5b
         LW1z42xYEDK6TsPKJGhnnfyRJN34tr/GyhZ+D7ualPtISRW7GLqyiQD/nnDefz57f6HG
         Ldjw==
X-Gm-Message-State: APjAAAVVbDInToIUPEGZZXj0WivL3ITbyJRoFbm1Ym4fXj1CqUyYAY2P
        BPy+/pOVCcg+TGytIcO88XHO8Q==
X-Google-Smtp-Source: APXvYqzsOoSi6stZEgi5yA03RC0schvNTFrtwjh9J7y625so1R/qDc8W8M0BhvwXYWHzLQaWLFUSfQ==
X-Received: by 2002:a19:9149:: with SMTP id y9mr29230817lfj.15.1574850573630;
        Wed, 27 Nov 2019 02:29:33 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t9sm6868260ljj.19.2019.11.27.02.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 02:29:32 -0800 (PST)
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
Subject: [PATCH v3 11/13] cpuidle: psci: Manage runtime PM in the idle path
Date:   Wed, 27 Nov 2019 11:29:12 +0100
Message-Id: <20191127102914.18729-12-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191127102914.18729-1-ulf.hansson@linaro.org>
References: <20191127102914.18729-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In case we have succeeded to attach a CPU to its PM domain, let's deploy
runtime PM support for the corresponding attached device, to allow the CPU
to be powered-managed accordingly.

The triggering point for when runtime PM reference counting should be done,
has been selected to the deepest idle state for the CPU. However, from the
hierarchical point view, there may be good reasons to do runtime PM
reference counting even on shallower idle states, but at this point this
isn't supported, mainly due to limitations set by the generic PM domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Rebased.

---
 drivers/cpuidle/cpuidle-psci.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index fd664e134c3f..0707222a40bd 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/psci.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include <asm/cpuidle.h>
@@ -51,14 +52,21 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
 {
 	struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
 	u32 *states = data->psci_states;
-	u32 state = psci_get_domain_state();
+	struct device *pd_dev = data->dev;
+	u32 state;
 	int ret;
 
+	/* Do runtime PM to manage a hierarchical CPU toplogy. */
+	pm_runtime_put_sync_suspend(pd_dev);
+
+	state = psci_get_domain_state();
 	if (!state)
 		state = states[idx];
 
 	ret = psci_enter_state(idx, state);
 
+	pm_runtime_get_sync(pd_dev);
+
 	/* Clear the domain state to start fresh when back from idle. */
 	psci_set_domain_state(0);
 	return ret;
-- 
2.17.1

