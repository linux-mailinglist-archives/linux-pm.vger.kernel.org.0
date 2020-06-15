Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4781F9BD4
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 17:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbgFOPVH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 11:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbgFOPVG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 11:21:06 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165F0C061A0E
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 08:21:06 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a9so19694908ljn.6
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 08:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1DzsoTjhcIMb9+A4N/cXj76UygN5PXLTTjiX9hXk5EQ=;
        b=R0/G6JK86gTEe2vWg8LbA/u3P1xlSlDzO2cBwJ+jyc0Eyl/SwAQQeoz0nmHzEM9rYG
         a8C5hk3FatI1oDaBKtXmf3+5kDyy62EmcpnoKxRHDDReh/iU/lkb0M3PLXDf8aINzQh4
         QI1dTzd06nIDvJMSyEZdHKFqHbdjdupZB6AUPdAPLN5I0c3AP6Os0XceOiYbeQCb3ilZ
         y51fAxDJmGo9fXYkYBbpYfTFG7x2KSFGUIUHwflaE6Geg2EOtDrjONRn4up1dxpUweV4
         NCX0O91K4uoulbUiz6v+9NZzVzAsyYPHg+B170chZGL7TCwEPmyZFsymoEGalxo25AbC
         MwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1DzsoTjhcIMb9+A4N/cXj76UygN5PXLTTjiX9hXk5EQ=;
        b=thXTz71mFZ3XERckR1GiCHhd4719RLJdc7LOGWs6PbObIEB42IgN5hXUn1tB1fdWcT
         xVtaHai9IMQX37aMH3feP7oHboJtsIwHINwlaaFMpBV5AiTcJEVxxucMqXXZBxzgGwem
         GMjdJZyhm/oQa/wA+DuNPfTmNDy+ILd5pImmiC4bekkuRwJovytbYj34hRLEo6A+5M0T
         AlcRBQjLJE9mAbFH9X2VuHhCe6FG9SRIdconyGzzZcQIO+A2G/9BwZ+sU5xkNgv9OERt
         fFj2Cm2jT4NKIy9XrBj5H+qbh+45KyoCQEZ7oJfvt9nl9wSfQbxOk8H4nlM8VjFP/Ixl
         Cm8Q==
X-Gm-Message-State: AOAM533a0cvo6/tSwljXYDYj7mXN69eWg12Ierlzlaa3o+0kbNlLPwdA
        iNTecBAtCzizWaeNEQr+hwsFNA==
X-Google-Smtp-Source: ABdhPJxUiGsMJiGa6NWQ1gHqTK4kiAuFXfOMrnslZR159WBYtn3a8+/eBsanXQlkThSgss57C1FYNQ==
X-Received: by 2002:a2e:7016:: with SMTP id l22mr14031408ljc.284.1592234464325;
        Mon, 15 Jun 2020 08:21:04 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id r13sm507045lfp.80.2020.06.15.08.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 08:21:03 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] cpuidle: psci: Split into two separate build objects
Date:   Mon, 15 Jun 2020 17:20:52 +0200
Message-Id: <20200615152054.6819-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200615152054.6819-1-ulf.hansson@linaro.org>
References: <20200615152054.6819-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The combined build object for the PSCI cpuidle driver and the PSCI PM
domain, is a bit messy. Therefore let's split it up by adding a new Kconfig
ARM_PSCI_CPUIDLE_DOMAIN and convert into two separate objects.

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
index 0690d66df829..d8e925e84c27 100644
--- a/drivers/cpuidle/cpuidle-psci.h
+++ b/drivers/cpuidle/cpuidle-psci.h
@@ -9,7 +9,7 @@ struct device_node;
 void psci_set_domain_state(u32 state);
 int psci_dt_parse_state_node(struct device_node *np, u32 *state);
 
-#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
+#ifdef CONFIG_ARM_PSCI_CPUIDLE_DOMAIN
 struct device *psci_dt_attach_cpu(int cpu);
 void psci_dt_detach_cpu(struct device *dev);
 #else
-- 
2.20.1

