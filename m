Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 922981BE07
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 21:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfEMTbc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 15:31:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47089 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfEMTbb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 15:31:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so10338243ljk.13
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2019 12:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tL+sK5pEBsAoCFopnPPwt4es9T7EwxPGgYEkm8O7IBI=;
        b=PleXZ03XqpXkNBmDfAycSfGQdOAnwKcgjPE/yvddT6ahyVQYQIimbvzlM0ZT24i2e5
         LUFZWo+Tdttrv0PhN9+zyZsiyAIl0piyFql/WuOFoJwf6rT/ApfowwA2yVJk5ycqSnHJ
         tVjZQ/8bSIufYfq7D+pcmCxP7awzaUFp1ndubavu4Rg3LGgEgIDKhT1v5im0eJXErzwM
         yeE7sM0FGOsZqtCWMwGXPx4qW6dtJwALcEcJrbDFKC6sEY00Uvvm8/vcCf8KVozLm45m
         GNwRj8IB28P/Qgq9gd8i2bHXXGget+HBMR2KuUq4pUtz49trTZoVO+c/X53DLD2flOHv
         U9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tL+sK5pEBsAoCFopnPPwt4es9T7EwxPGgYEkm8O7IBI=;
        b=S5K8Z8PSxid0Qa/48RSWbwKUMyL4Mzh17w7QhEY/nnKQMNoR3LgArdEgAkLKjc7O6K
         siPDiwwZXtLTX5EQYORt0E67LPpXj3stwh9BBV427vzf+KLUSurvROy3mFHfuMa2E7PF
         6VIr01nXq0cHxCv00WRElw9Fejy1/wdWOY63siZjenARoDtixRQRlFlp0/rOgUwDgMn8
         SM6T1Bay8s/tI3f/dwmHvKDKpYrBg3Q9ST2S3j8NUnlHKJYxex/q1aH57TmnSxsYXfPz
         esUQjYemc//HXc7K2LrmMpUsGfD7aoazsHsD0x/Y7JD4cBtDxSz6ueHDfcFzDba1Ap4Y
         1NHg==
X-Gm-Message-State: APjAAAWdO4RYhjlqeAxfOe2yLdQe5BGZbAvykrYSEaYAfE/AV7srNwia
        iGQTcncA7VtwIYr1jxchqtzrVA==
X-Google-Smtp-Source: APXvYqx4whMnRpTm4m80h2xmvQbwZJE+FnBv/f7E0p3WgnHRPkfQ9mN1Bj/AUSzvNa+UTmcvCbPkvw==
X-Received: by 2002:a2e:81cf:: with SMTP id s15mr14626643ljg.193.1557775400776;
        Mon, 13 May 2019 12:23:20 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q21sm3449365lfa.84.2019.05.13.12.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 12:23:19 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 08/18] drivers: firmware: psci: Prepare to support PM domains
Date:   Mon, 13 May 2019 21:22:50 +0200
Message-Id: <20190513192300.653-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513192300.653-1-ulf.hansson@linaro.org>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Subsequent changes implements support for PM domains to PSCI. Those changes
are mainly implemented in a new separate c-file, hence a couple of the
internal PSCI functions needs to be shared to be accessible. Let's do that
via adding a new PSCI header file.

Moreover, to implement support for PM domains, switching the PSCI FW into
the OS initiated mode is sometimes needed. Therefore, let's share a new
function that implement this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes:
	- Convert psci_set_osi_mode() to return an int.
	- Don't share psci_get_domain_state() as that's no longer needed.
	- Update changelog.

---
 drivers/firmware/psci/psci.c | 17 ++++++++++++++---
 drivers/firmware/psci/psci.h | 16 ++++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)
 create mode 100644 drivers/firmware/psci/psci.h

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 4aec513136e4..0e91d864e346 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -34,6 +34,8 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 
+#include "psci.h"
+
 /*
  * While a 64-bit OS can make calls with SMC32 calling conventions, for some
  * calls it is necessary to use SMC64 to pass or return 64-bit values.
@@ -96,7 +98,7 @@ static inline bool psci_has_ext_power_state(void)
 				PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK;
 }
 
-static inline bool psci_has_osi_support(void)
+bool psci_has_osi_support(void)
 {
 	return psci_cpu_suspend_feature & PSCI_1_0_OS_INITIATED;
 }
@@ -161,6 +163,15 @@ static u32 psci_get_version(void)
 	return invoke_psci_fn(PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0);
 }
 
+int psci_set_osi_mode(void)
+{
+	int err;
+
+	err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
+			     PSCI_1_0_SUSPEND_MODE_OSI, 0, 0);
+	return psci_to_linux_errno(err);
+}
+
 static int psci_cpu_suspend(u32 state, unsigned long entry_point)
 {
 	int err;
@@ -292,12 +303,12 @@ static inline u32 psci_get_domain_state(void)
 	return __this_cpu_read(domain_state);
 }
 
-static inline void psci_set_domain_state(u32 state)
+void psci_set_domain_state(u32 state)
 {
 	__this_cpu_write(domain_state, state);
 }
 
-static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
+int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 {
 	int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
 
diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
new file mode 100644
index 000000000000..f2277c3ad405
--- /dev/null
+++ b/drivers/firmware/psci/psci.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __PSCI_H
+#define __PSCI_H
+
+struct device_node;
+
+int psci_set_osi_mode(void);
+bool psci_has_osi_support(void);
+
+#ifdef CONFIG_CPU_IDLE
+void psci_set_domain_state(u32 state);
+int psci_dt_parse_state_node(struct device_node *np, u32 *state);
+#endif
+
+#endif /* __PSCI_H */
-- 
2.17.1

