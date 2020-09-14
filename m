Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD6B269619
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 22:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgINULs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 16:11:48 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:30924 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgINULp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2020 16:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1600114299;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=vQITCXnG/2YZ2774yYTecNxsLQZF33SDBa0LlBI8CQs=;
        b=Na2kUwbRnYn95j+bM8Fj17OyL6ydD9prX/J2QzkoH/zj4+sPSjW9txZ5DR2EIzkB1o
        7Pa+T/o45ZHEgwhXmLzIqgkeiUc8Ae4kA6kGFnjjhUtd/xs6v462GpO8xSAMw7JyHxqC
        /jbKDI4oZe5by6/uZLSASAzXYonlFEwRJ6ADGbAW/B2J6SQxmA+CniZJrE9K2LNMQJSF
        0eknMZivDyju33E1Kb3hIqNgoz0y8XVo8O3uW/BeI8B6lpj9a8oPzyr3ErBLiiABvsqb
        1r9ONdM2Bg/ccEliwg7H/nDidkd/bM+SdEgi9brscLbwY1MUVOuNAzp5JbmT2Ouo8IrU
        /ctg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7IcfFBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w8EKBct9y
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 14 Sep 2020 22:11:38 +0200 (CEST)
Date:   Mon, 14 Sep 2020 22:11:32 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Allow opp-level to be set to 0
Message-ID: <20200914201132.GA163547@gerhold.net>
References: <40b676a1e261d1cfd12788d88e0d2026dbbe226b.1599817789.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40b676a1e261d1cfd12788d88e0d2026dbbe226b.1599817789.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 11, 2020 at 03:19:53PM +0530, Viresh Kumar wrote:
> The DT bindings don't put such a constraint, nor should the kernel. It
> is perfectly fine for opp-level to be set to 0, if we need to put the
> performance state votes for a domain for a particular OPP.
> 
> Reported-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I tried adding an opp-level = <0> and voting for it using required-opps
for some of the OPPs in the CPU OPP table and it seems to work fine now.

Tested-by: Stephan Gerhold <stephan@gerhold.net>

Just need to solve the "enable power domains" problem now :)

Thanks!
Stephan

> ---
>  drivers/opp/core.c |  3 ---
>  drivers/opp/of.c   | 20 +++++++-------------
>  2 files changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 214c1619b445..2483e765318a 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2117,9 +2117,6 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
>  	int dest_pstate = -EINVAL;
>  	int i;
>  
> -	if (!pstate)
> -		return 0;
> -
>  	/*
>  	 * Normally the src_table will have the "required_opps" property set to
>  	 * point to one of the OPPs in the dst_table, but in some cases the
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index e72753be7dc7..87f839a1899a 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -842,7 +842,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
>  {
>  	struct device_node *np;
> -	int ret, count = 0, pstate_count = 0;
> +	int ret, count = 0;
>  	struct dev_pm_opp *opp;
>  
>  	/* OPP table is already initialized for the device */
> @@ -876,20 +876,14 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
>  		goto remove_static_opp;
>  	}
>  
> -	list_for_each_entry(opp, &opp_table->opp_list, node)
> -		pstate_count += !!opp->pstate;
> -
> -	/* Either all or none of the nodes shall have performance state set */
> -	if (pstate_count && pstate_count != count) {
> -		dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
> -			count, pstate_count);
> -		ret = -ENOENT;
> -		goto remove_static_opp;
> +	list_for_each_entry(opp, &opp_table->opp_list, node) {
> +		/* Any non-zero performance state would enable the feature */
> +		if (opp->pstate) {
> +			opp_table->genpd_performance_state = true;
> +			break;
> +		}
>  	}
>  
> -	if (pstate_count)
> -		opp_table->genpd_performance_state = true;
> -
>  	return 0;
>  
>  remove_static_opp:
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 
