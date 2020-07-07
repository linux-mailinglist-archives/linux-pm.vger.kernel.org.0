Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31EB216D46
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 14:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgGGM6X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 08:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgGGM6X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 08:58:23 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3169C061755
        for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2020 05:58:22 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id j11so1021158ljo.7
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2020 05:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JmH1BfPiU4RoSWuHQPEJ8Sx4+RN7bhXBUvJ2uLAr9qM=;
        b=Ad7XXos1cMmY+GKjq/D9UtSBmDNPOeVXkEk3XQ8wQl0QlkUWtCwInOmjZmoDIncBHb
         XK6+h7K+uqUHqZXaTO/qeFFYBZ/TGnH2PC2189v/S6CCjKuMkMGXkOhaIB+GjZsRkXGP
         sZlwnSie+aPey2AKnh2JAKCuFh3oGUOu0n2/RvUWQQHtCbS+yFnqUaLPv6igWPkwW4Oj
         6MnRpJOehFo5cmYc6/vsfoQuy25/s4gsoreVtAlkV5pLjTpOhJxullGUTeW+KgwGcki6
         vEDYWNZL4eOuJ4W7a8oOxNgk29NhvZA+uOHbJI5AmMwuTcfOIe8DqXORy5X+/1bnSSOl
         e8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JmH1BfPiU4RoSWuHQPEJ8Sx4+RN7bhXBUvJ2uLAr9qM=;
        b=VUhVCeQ3TPkw9W/sW6//cNcnw4YGDYKYoK/6LKklTz3uV9HauYJvkhSrf0RF8t2VUH
         OGHckOhLHb/7TQVh29SP5BT1fVW2tyPqPhAZlljtXzk9kIwsupa59wkV/i+qCPoyVj8D
         8Th2Qb+4bMF95KTbDCb7PHCYzoa7p7sG8RCXfSQNeVoRFZF1jbxMf4qoCU/bvtrs7DlL
         W3IjZsBiI9xyI65W7lnmAuzk7ydgC2UcUsdspqZ9JOCq3NapWoFgRW0DguRoDaFVIhWu
         egderHaKqtxo7ybZqPmPPnG7vmvW87ozTCKbKIJ0b13KTlHI3gzDL15Glmvt6HnaXkKU
         /vMQ==
X-Gm-Message-State: AOAM5304n2wYE4d4yN0pSJAxYJceU1NHn8t5ypGA2RK+fnVNuJNZQAzx
        9DF6ITWvldaKI4DIOR0UJLrvZA==
X-Google-Smtp-Source: ABdhPJzUlqKwp5fDTuJIhcklcQOJEemZfGYMUbMkILw8e1U/ymMGmHmpI3jEkHFPEWctxqwO/X56vg==
X-Received: by 2002:a05:651c:21a:: with SMTP id y26mr14747466ljn.106.1594126701205;
        Tue, 07 Jul 2020 05:58:21 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id 11sm9554395lfz.78.2020.07.07.05.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 05:58:20 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Saravana Kannan <saravanak@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/5] cpuidle: psci: Split into two separate build objects
Date:   Tue,  7 Jul 2020 14:58:00 +0200
Message-Id: <20200707125804.13030-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707125804.13030-1-ulf.hansson@linaro.org>
References: <20200707125804.13030-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The combined build object for the PSCI cpuidle driver and the PSCI PM
domain, is a bit messy. Therefore let's split it up by adding a new Kconfig
ARM_PSCI_CPUIDLE_DOMAIN and convert into two separate objects.

Reviewed-by: Lina Iyer <ilina@codeaurora.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/Kconfig.arm    | 10 ++++++++++
 drivers/cpuidle/Makefile       |  5 ++---
 drivers/cpuidle/cpuidle-psci.h |  2 +-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 51a7e89085c0..0844fadc4be8 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -23,6 +23,16 @@ config ARM_PSCI_CPUIDLE
 	  It provides an idle driver that is capable of detecting and
 	  managing idle states through the PSCI firmware interface.
 
+config ARM_PSCI_CPUIDLE_DOMAIN
+	bool "PSCI CPU idle Domain"
+	depends on ARM_PSCI_CPUIDLE
+	depends on PM_GENERIC_DOMAINS_OF
+	default y
+	help
+	  Select this to enable the PSCI based CPUidle driver to use PM domains,
+	  which is needed to support the hierarchical DT based layout of the
+	  idle states.
+
 config ARM_BIG_LITTLE_CPUIDLE
 	bool "Support for ARM big.LITTLE processors"
 	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS || COMPILE_TEST
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index f07800cbb43f..26bbc5e74123 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -21,9 +21,8 @@ obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
 obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
 obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
 obj-$(CONFIG_ARM_CPUIDLE)		+= cpuidle-arm.o
-obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle_psci.o
-cpuidle_psci-y				:= cpuidle-psci.o
-cpuidle_psci-$(CONFIG_PM_GENERIC_DOMAINS_OF) += cpuidle-psci-domain.o
+obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle-psci.o
+obj-$(CONFIG_ARM_PSCI_CPUIDLE_DOMAIN)	+= cpuidle-psci-domain.o
 obj-$(CONFIG_ARM_TEGRA_CPUIDLE)		+= cpuidle-tegra.o
 obj-$(CONFIG_ARM_QCOM_SPM_CPUIDLE)	+= cpuidle-qcom-spm.o
 
diff --git a/drivers/cpuidle/cpuidle-psci.h b/drivers/cpuidle/cpuidle-psci.h
index 7299a04dd467..ac8170684d4f 100644
--- a/drivers/cpuidle/cpuidle-psci.h
+++ b/drivers/cpuidle/cpuidle-psci.h
@@ -8,7 +8,7 @@ struct device_node;
 void psci_set_domain_state(u32 state);
 int __init psci_dt_parse_state_node(struct device_node *np, u32 *state);
 
-#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
+#ifdef CONFIG_ARM_PSCI_CPUIDLE_DOMAIN
 struct device __init *psci_dt_attach_cpu(int cpu);
 #else
 static inline struct device __init *psci_dt_attach_cpu(int cpu) { return NULL; }
-- 
2.20.1

