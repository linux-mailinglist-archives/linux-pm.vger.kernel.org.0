Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 047EE6AD8B
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 19:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbfGPRSA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 13:18:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40504 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbfGPRSA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 13:18:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D12AC6182E; Tue, 16 Jul 2019 17:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563297478;
        bh=2pOtf9PAXP9nJ+aXw11UJheCUnN8qsVoa6sjUXL/eY0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MdnSzCKSx+jCnmAeBGER9CfrVbybhdcNY+6w8+hbzhw//XFe9xMlLN5uTl4+R9ZV8
         lsDH1D6eL5H0EhBEvvS1aJ+f3uIn6yQGaOrQNStCox8ZOEy8tbbiZwkY5toKKD9vhY
         cPz8gL1chZVpO2wZhZC2LYf7iwHRHxGOIW9QUK+w=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.79.43.230] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D351616DA;
        Tue, 16 Jul 2019 17:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563297477;
        bh=2pOtf9PAXP9nJ+aXw11UJheCUnN8qsVoa6sjUXL/eY0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VuYlcP9Y12kqT5/0k1rwiindCKNLQtZjs/QD+mxM1nKRJMfwFwroNYZOx48P+/03z
         MDIR6L5RTOf2LPaWvewbQbODEJykRgLR3ZQr1NSQZkh6Uq82qYOazGhcz2ImOyIJSt
         fi7LsP7cfbvP82lYCI/6DpOpoyORmoXJfGeGwYFU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D351616DA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v2 1/4] OPP: Allow required-opps even if the device
 doesn't have power-domains
To:     Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kernel-team@android.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190625213337.157525-1-saravanak@google.com>
 <20190625213337.157525-2-saravanak@google.com>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <e7a5b387-fa85-15a8-8d79-fbc441c36293@codeaurora.org>
Date:   Tue, 16 Jul 2019 22:47:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190625213337.157525-2-saravanak@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Saravana,
Thanks for taking time to post out this series.

On 6/26/19 3:03 AM, Saravana Kannan wrote:
> A Device-A can have a (minimum) performance requirement on another
> Device-B to be able to function correctly. This performance requirement
> on Device-B can also change based on the current performance level of
> Device-A.
> 
> The existing required-opps feature fits well to describe this need. So,
> instead of limiting required-opps to point to only PM-domain devices,
> allow it to point to any device.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>   drivers/opp/core.c |  2 +-
>   drivers/opp/of.c   | 14 --------------
>   2 files changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 0e7703fe733f..74c7bdc6f463 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -710,7 +710,7 @@ static int _set_required_opps(struct device *dev,
>   		return 0;
>   
>   	/* Single genpd case */
> -	if (!genpd_virt_devs) {
> +	if (!genpd_virt_devs && required_opp_tables[0]->is_genpd) {
https://patchwork.kernel.org/patch/10940671/
This was already removed as a part of ^^ and is in linux-next.

>   		pstate = opp->required_opps[0]->pstate;
>   		ret = dev_pm_genpd_set_performance_state(dev, pstate);
>   		if (ret) {
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index c10c782d15aa..7c8336e94aff 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -195,9 +195,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>   	 */
>   	count_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
>   					      "#power-domain-cells");
> -	if (!count_pd)
> -		goto put_np;
> -
>   	if (count_pd > 1) {
>   		genpd_virt_devs = kcalloc(count, sizeof(*genpd_virt_devs),
>   					GFP_KERNEL);
> @@ -226,17 +223,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>   
>   		if (IS_ERR(required_opp_tables[i]))
>   			goto free_required_tables;
> -
> -		/*
> -		 * We only support genpd's OPPs in the "required-opps" for now,
> -		 * as we don't know how much about other cases. Error out if the
> -		 * required OPP doesn't belong to a genpd.
> -		 */
> -		if (!required_opp_tables[i]->is_genpd) {
> -			dev_err(dev, "required-opp doesn't belong to genpd: %pOF\n",
> -				required_np);
> -			goto free_required_tables;
> -		}

I expect the series to not work as is in its current state since I
see a circular dependency here. The required-opp tables of the parent
devfreq won't be populated until we add the opp-table of the child
devfreq node while the child devfreq using passive governor would
return -EPROBE_DEFER until the parent devfreq probes.

The same applies to this patch -> https://patchwork.kernel.org/patch
/11046147/ I posted out based on your series. So we would probably have
to address the dependency here.

>   	}
>   
>   	goto put_np;
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
