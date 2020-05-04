Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390E91C488F
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 22:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgEDUuw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 16:50:52 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:22762 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726627AbgEDUuv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 16:50:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588625450; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=bcYfoncDFBuQvvrc9fHsqwOFMUFX3Nud1sv0zHvJPHs=;
 b=bJTaTiHp90P3nx8rF4hTC6p1pfFlEJ5jntD+vfd1JHXrruURnN0q1qePHsyfTK/wm0u4iV0h
 3elsU/A/6LPpo7YfIBqo0Em8uPDEe5f2AhAJgvPvuECAO5vncIcGdBvvOTTdhBO6nWniZCa7
 avnK8wLG2jjY5yVI2QHQANqu03g=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb08027.7fae535a61f0-smtp-out-n05;
 Mon, 04 May 2020 20:50:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 29FF3C44788; Mon,  4 May 2020 20:50:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 63A03C433D2;
        Mon,  4 May 2020 20:50:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 May 2020 02:20:46 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, saravanak@google.com,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, jcrouse@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 7/7] cpufreq: dt: Add support for interconnect
 bandwidth scaling
In-Reply-To: <20200424155404.10746-8-georgi.djakov@linaro.org>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-8-georgi.djakov@linaro.org>
Message-ID: <be1020b835a2b6a2a5d1e23d39aa0f95@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Georgi,

On 2020-04-24 21:24, Georgi Djakov wrote:
> In addition to clocks and regulators, some devices can scale the 
> bandwidth
> of their on-chip interconnect - for example between CPU and DDR memory. 
> Add
> support for that, so that platforms which support it can make use of 
> it.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> v7:
> * Drop using dev_pm_opp_set_paths(), as it has been removed.
> * Add Kconfig dependency on INTERCONNECT, as it can be module.
> 
> 
> v2: 
> https://lore.kernel.org/r/20190423132823.7915-6-georgi.djakov@linaro.org
> 
>  drivers/cpufreq/Kconfig      |  1 +
>  drivers/cpufreq/cpufreq-dt.c | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index c3e6bd59e920..db2ad54ee67f 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -217,6 +217,7 @@ config CPUFREQ_DT
> 
>  config CPUFREQ_DT_PLATDEV
>  	bool
> +	depends on INTERCONNECT || !INTERCONNECT
>  	help
>  	  This adds a generic DT based cpufreq platdev driver for frequency
>  	  management.  This creates a 'cpufreq-dt' platform device, on the
> diff --git a/drivers/cpufreq/cpufreq-dt.c 
> b/drivers/cpufreq/cpufreq-dt.c
> index 26fe8dfb9ce6..4ecef3257532 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -13,6 +13,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
>  #include <linux/err.h>
> +#include <linux/interconnect.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/pm_opp.h>
> @@ -95,6 +96,7 @@ static int resources_available(void)
>  	struct device *cpu_dev;
>  	struct regulator *cpu_reg;
>  	struct clk *cpu_clk;
> +	struct icc_path *cpu_path;
>  	int ret = 0;
>  	const char *name;
> 
> @@ -121,6 +123,19 @@ static int resources_available(void)
> 
>  	clk_put(cpu_clk);
> 
> +	cpu_path = of_icc_get(cpu_dev, NULL);
> +	ret = PTR_ERR_OR_ZERO(cpu_path);

Wouldn't we want to verify all
available paths instead of just
the first path?

> +	if (ret) {
> +		if (ret == -EPROBE_DEFER)
> +			dev_dbg(cpu_dev, "defer icc path: %d\n", ret);
> +		else
> +			dev_err(cpu_dev, "failed to get icc path: %d\n", ret);
> +
> +		return ret;
> +	}
> +
> +	icc_put(cpu_path);
> +
>  	name = find_supply_name(cpu_dev);
>  	/* Platform doesn't require regulator */
>  	if (!name)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
