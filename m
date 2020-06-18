Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15201FFAB4
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jun 2020 20:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgFRSCr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jun 2020 14:02:47 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:11974 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727022AbgFRSCq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2020 14:02:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592503365; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=0wfkwopuLx8hs9G0OXE+EBnMO69t9YFTTa2ykBZeSkI=; b=XyLcCeGQMUXlRNN3qfbplME0adih9h178NeQOVH3qrqQI/F2qB3oX/vDh511Tm/8Gsju8y/w
 x6l/0nFbyOBCTlY5JAeZ7a1WiwhF6adZpG8XUn69UhAnbLwGh8cpqPU1mC45ZHTtJ0PyI/kt
 gUvo2MkCc5ZPiGshkOeCXzUytDs=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5eebac11356bcc26abdbffe2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Jun 2020 18:01:53
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5DB23C4339C; Thu, 18 Jun 2020 18:01:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 59BFEC433C9;
        Thu, 18 Jun 2020 18:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59BFEC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 18 Jun 2020 12:01:50 -0600
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
Subject: Re: [PATCH 1/5] cpuidle: psci: Fail cpuidle registration if set OSI
 mode failed
Message-ID: <20200618180150.GK12942@codeaurora.org>
References: <20200615152054.6819-1-ulf.hansson@linaro.org>
 <20200615152054.6819-2-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200615152054.6819-2-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 15 2020 at 09:21 -0600, Ulf Hansson wrote:
>Currently we allow the cpuidle driver registration to succeed, even if we
>failed to enable the OSI mode when the hierarchical DT layout is used. This
>means running in a degraded mode, by using the available idle states per
>CPU, while also preventing the domain idle states.
>
>Moving forward, this behaviour looks quite questionable to maintain, as
>complexity seems to grow around it, especially when trying to add support
>for deferred probe, for example.
>
>Therefore, let's make the cpuidle driver registration to fail in this
>situation, thus relying on the default architectural cpuidle backend for
>WFI to be used.
>
>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

May be PATCH 3/5 should come before this change, but for this patch itself,
please consider -

Reviewed-by: Lina Iyer <ilina@codeaurora.org>

>---
> drivers/cpuidle/cpuidle-psci-domain.c | 5 -----
> 1 file changed, 5 deletions(-)
>
>diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
>index 423f03bbeb74..f07786aad673 100644
>--- a/drivers/cpuidle/cpuidle-psci-domain.c
>+++ b/drivers/cpuidle/cpuidle-psci-domain.c
>@@ -26,7 +26,6 @@ struct psci_pd_provider {
> };
>
> static LIST_HEAD(psci_pd_providers);
>-static bool osi_mode_enabled __initdata;
>
> static int psci_pd_power_off(struct generic_pm_domain *pd)
> {
>@@ -272,7 +271,6 @@ static int __init psci_idle_init_domains(void)
> 		goto remove_pd;
> 	}
>
>-	osi_mode_enabled = true;
> 	of_node_put(np);
> 	pr_info("Initialized CPU PM domain topology\n");
> 	return pd_count;
>@@ -293,9 +291,6 @@ struct device __init *psci_dt_attach_cpu(int cpu)
> {
> 	struct device *dev;
>
>-	if (!osi_mode_enabled)
>-		return NULL;
>-
> 	dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), "psci");
> 	if (IS_ERR_OR_NULL(dev))
> 		return dev;
>-- 
>2.20.1
>
