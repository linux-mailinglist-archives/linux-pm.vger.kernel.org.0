Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCAA1FFAB2
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jun 2020 20:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgFRSCg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jun 2020 14:02:36 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:43280 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgFRSCg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Jun 2020 14:02:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592503355; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=lCdbSGdi/eKz+yk7v3H4F1EFosxd309eL9sHFCGRvJc=; b=oLWTeA1BtlwlObJRGqsyOsh4CPy+6AwUiseIp/Pk5w41PwI7tprf6y4yL3gvbsl/EdfR8LnU
 zzfCCd4S4Xisgtr1iNBIQcMOlx5JdoXPspjcHNAvaYWLQJbmpa314A77bBTvXSTOO94yHGXK
 M8DI1mQYCiUSEjP5EqlLT4w2fCM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5eebac275866879c76b6e43e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Jun 2020 18:02:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 22C13C43391; Thu, 18 Jun 2020 18:02:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2ECA4C433C8;
        Thu, 18 Jun 2020 18:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2ECA4C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 18 Jun 2020 12:02:13 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] cpuidle: psci: Split into two separate build objects
Message-ID: <20200618180213.GL12942@codeaurora.org>
References: <20200615152054.6819-1-ulf.hansson@linaro.org>
 <20200615152054.6819-4-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200615152054.6819-4-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 15 2020 at 09:21 -0600, Ulf Hansson wrote:
>The combined build object for the PSCI cpuidle driver and the PSCI PM
>domain, is a bit messy. Therefore let's split it up by adding a new Kconfig
>ARM_PSCI_CPUIDLE_DOMAIN and convert into two separate objects.
>
>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Lina Iyer <ilina@codeaurora.org>

>---
> drivers/cpuidle/Kconfig.arm    | 10 ++++++++++
> drivers/cpuidle/Makefile       |  5 ++---
> drivers/cpuidle/cpuidle-psci.h |  2 +-
> 3 files changed, 13 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
>index 51a7e89085c0..0844fadc4be8 100644
>--- a/drivers/cpuidle/Kconfig.arm
>+++ b/drivers/cpuidle/Kconfig.arm
>@@ -23,6 +23,16 @@ config ARM_PSCI_CPUIDLE
> 	  It provides an idle driver that is capable of detecting and
> 	  managing idle states through the PSCI firmware interface.
>
>+config ARM_PSCI_CPUIDLE_DOMAIN
>+	bool "PSCI CPU idle Domain"
>+	depends on ARM_PSCI_CPUIDLE
>+	depends on PM_GENERIC_DOMAINS_OF
>+	default y
>+	help
>+	  Select this to enable the PSCI based CPUidle driver to use PM domains,
>+	  which is needed to support the hierarchical DT based layout of the
>+	  idle states.
>+
> config ARM_BIG_LITTLE_CPUIDLE
> 	bool "Support for ARM big.LITTLE processors"
> 	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS || COMPILE_TEST
>diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
>index f07800cbb43f..26bbc5e74123 100644
>--- a/drivers/cpuidle/Makefile
>+++ b/drivers/cpuidle/Makefile
>@@ -21,9 +21,8 @@ obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
> obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
> obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
> obj-$(CONFIG_ARM_CPUIDLE)		+= cpuidle-arm.o
>-obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle_psci.o
>-cpuidle_psci-y				:= cpuidle-psci.o
>-cpuidle_psci-$(CONFIG_PM_GENERIC_DOMAINS_OF) += cpuidle-psci-domain.o
>+obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle-psci.o
>+obj-$(CONFIG_ARM_PSCI_CPUIDLE_DOMAIN)	+= cpuidle-psci-domain.o
> obj-$(CONFIG_ARM_TEGRA_CPUIDLE)		+= cpuidle-tegra.o
> obj-$(CONFIG_ARM_QCOM_SPM_CPUIDLE)	+= cpuidle-qcom-spm.o
>
>diff --git a/drivers/cpuidle/cpuidle-psci.h b/drivers/cpuidle/cpuidle-psci.h
>index 0690d66df829..d8e925e84c27 100644
>--- a/drivers/cpuidle/cpuidle-psci.h
>+++ b/drivers/cpuidle/cpuidle-psci.h
>@@ -9,7 +9,7 @@ struct device_node;
> void psci_set_domain_state(u32 state);
> int psci_dt_parse_state_node(struct device_node *np, u32 *state);
>
>-#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>+#ifdef CONFIG_ARM_PSCI_CPUIDLE_DOMAIN
> struct device *psci_dt_attach_cpu(int cpu);
> void psci_dt_detach_cpu(struct device *dev);
> #else
>-- 
>2.20.1
>
