Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDACC10AD9C
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 11:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfK0K3Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 05:29:24 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40161 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfK0K3Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 05:29:24 -0500
Received: by mail-lf1-f67.google.com with SMTP id y5so4001372lfy.7
        for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2019 02:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HTpoNIOk6QVHLkL5hD/y3Oh3mM1LWBHn64GrXkiktTA=;
        b=AyUxtvbcofFh17U604la4Y1G39mBOWKGJg5dHe2xNMOmUM+72q8KFL+MRj9MXbX1cg
         6TGADlEWGQG3IeUrcLndrG52Pb3xsYv/O4+js502Oo4yMQF+CBIfC6qa+QnnT5sGyBP2
         TBoTGuANUAcOEiHVUgGaySfBTjOTRiGHqALcwOsEdIhI2aK06Qcf6q+7cHDOX/EEt6m9
         408m8uS7ul/++ymsVs+h1d0qHZ4rTaqbZH/E6Jsnx4XhbHYMMq9nKxz5tLDMlr6qXfUf
         JfF4LZpBdnWLuZ9iIxL9MNTFOhBS4AwUO8u59tKLkSbAMxjg+Ymn4a6pqkfGJM72On3K
         FllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HTpoNIOk6QVHLkL5hD/y3Oh3mM1LWBHn64GrXkiktTA=;
        b=CiZnoFtru5Xf2DMn5K7ewT2K1oKqcwO+54Kskpzxv2TOjO07XK9ezlDoQ3ASUV9SZE
         nq7M1j+ZjFjvBLa4UgA6T0BQyvLQngamjH3KjSxjpfoklXixOAQVFAvM+QLoJalnLyW3
         lfPU1WHt6/Dj14ozmiGteybmUWGaBsFAM7ebCqoOCrtK7u7PGbp9w12a106RMbWtm5Do
         uvnC0gfubXEDTzpWSjsIwilksqCMElWWv6INEad1dZsWRna9hjK72AcCkjyf4DmTNkRz
         1EGaq5JlEDGThe0prctscIjkBTKO7o5SL1FmPqlGdU8aoxieI2QJqEUZPHASBjVMguBv
         MYzg==
X-Gm-Message-State: APjAAAVrsaZjoFST+043rsZemFDrmRf45uhKlmjp4hu25YF6Kv8GE2w4
        RmqSR+BZzcbM+PP8t+GJwEzGtQ==
X-Google-Smtp-Source: APXvYqwFJjqYM7aDnhXGNf9deKSkKCg+5HFB9vXDa+I/5Qtw5VKdR0KMezOx2PnWjK5Zoh8cIB0ztg==
X-Received: by 2002:ac2:55a3:: with SMTP id y3mr17405016lfg.108.1574850562474;
        Wed, 27 Nov 2019 02:29:22 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t9sm6868260ljj.19.2019.11.27.02.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 02:29:21 -0800 (PST)
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
Subject: [PATCH v3 03/13] firmware: psci: Export functions to manage the OSI mode
Date:   Wed, 27 Nov 2019 11:29:04 +0100
Message-Id: <20191127102914.18729-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191127102914.18729-1-ulf.hansson@linaro.org>
References: <20191127102914.18729-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To allow subsequent changes to implement support for OSI mode through the
cpuidle-psci driver, export the existing psci_has_osi_support(). Export
also a new function, psci_set_osi_mode(), that allows its caller to enable
the OS-initiated CPU-suspend mode in the PSCI FW.

To deal with backwards compatibility for a kernel started through a kexec
call, default to set the CPU-suspend mode to the Platform Coordinated mode
during boot.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---

Changes in v3:
	- None.

---
 drivers/firmware/psci/psci.c | 18 ++++++++++++++++--
 include/linux/psci.h         |  2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index b3b6c15e7b36..2937d44b5df4 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -97,7 +97,7 @@ static inline bool psci_has_ext_power_state(void)
 				PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK;
 }
 
-static inline bool psci_has_osi_support(void)
+bool psci_has_osi_support(void)
 {
 	return psci_cpu_suspend_feature & PSCI_1_0_OS_INITIATED;
 }
@@ -162,6 +162,15 @@ static u32 psci_get_version(void)
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
@@ -544,9 +553,14 @@ static int __init psci_1_0_init(struct device_node *np)
 	if (err)
 		return err;
 
-	if (psci_has_osi_support())
+	if (psci_has_osi_support()) {
 		pr_info("OSI mode supported.\n");
 
+		/* Default to PC mode. */
+		invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
+			       PSCI_1_0_SUSPEND_MODE_PC, 0, 0);
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/psci.h b/include/linux/psci.h
index ebe0a881d13d..a67712b73b6c 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -18,6 +18,8 @@ bool psci_tos_resident_on(int cpu);
 
 int psci_cpu_suspend_enter(u32 state);
 bool psci_power_state_is_valid(u32 state);
+int psci_set_osi_mode(void);
+bool psci_has_osi_support(void);
 
 enum smccc_version {
 	SMCCC_VERSION_1_0,
-- 
2.17.1

