Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0103F3315A7
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 19:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhCHSP1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 13:15:27 -0500
Received: from foss.arm.com ([217.140.110.172]:41854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhCHSPA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Mar 2021 13:15:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 283E8D6E;
        Mon,  8 Mar 2021 10:15:00 -0800 (PST)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8C283F71B;
        Mon,  8 Mar 2021 10:14:58 -0800 (PST)
Date:   Mon, 8 Mar 2021 18:14:49 +0000
From:   Beata Michalska <beata.michalska@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Subject: Re: [PATCH] opp: Invalidate current opp when draining the opp list
Message-ID: <20210308181446.GA26783@e120325.cambridge.arm.com>
References: <1614870454-18709-1-git-send-email-beata.michalska@arm.com>
 <20210305042401.gktrgach4dzxp7on@vireshk-i7>
 <418fc3cb-d5ec-9216-269a-e055e78718e5@arm.com>
 <20210308115053.ua2gfo6kfnfjslyd@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308115053.ua2gfo6kfnfjslyd@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 08, 2021 at 05:20:53PM +0530, Viresh Kumar wrote:
> On 05-03-21, 13:55, Beata Michalska wrote:
> > Actually, that one might be problematic: by the time the
> > _opp_table_kref_release is being reached, the opp pointed to
> > by current_opp may no longer be valid.
> > _opp_remove_all_static and/or dev_pm_opp_remove_all_dynamic
> > will release all the opps by going through opp_table->opp_list.
> > It will drop the reference for each opp on the list, until
> > the list gets empty(for given opp type), which means,
> > all the opps will actually get released
> > (only upon _opp_kref_release the opp will get removed
> > from the list).
> 
> Sorry for missing the context completely, I get it now.
> 
> This is what I have applied instead, please see if it breaks anything
> or works as expected.
> 
> -------------------------8<-------------------------
> 
> From: Beata Michalska <beata.michalska@arm.com>
> Date: Thu, 4 Mar 2021 15:07:34 +0000
> Subject: [PATCH] opp: Invalidate current opp when draining the opp list
> 
> The current_opp when set, grabs additional reference on the opp,
> which is then supposed to be dropped upon releasing the opp table.
> 
> Still both dev_pm_opp_remove_table and dev_pm_opp_remove_all_dynamic
> will completely drain the OPPs list, including dropping the additional
> reference on current_opp because they run until the time list gets
> empty.
> 
> This will lead releasing the current_opp one more time when the OPP
> table gets removed and so will raise ref counting issues.
> 
> Fix that by making sure we don't release the extra reference to the
> current_opp.
> 
> Fixes: 81c4d8a3c414 ("opp: Keep track of currently programmed OPP")
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> [ Viresh: Rewrite _opp_drain_list() to not drop the extra count instead
> 	  of depending on reference counting. Update commit log and
> 	  other minor changes. ]
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/core.c | 52 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index c2689386a906..3cc0a1b82adc 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1502,10 +1502,38 @@ static struct dev_pm_opp *_opp_get_next(struct opp_table *opp_table,
>  	return opp;
>  }
>  
> -bool _opp_remove_all_static(struct opp_table *opp_table)
> +/*
> + * Can't remove the OPP from under the lock, debugfs removal needs to happen
> + * lock less to avoid circular dependency issues. This must be called without
> + * the opp_table->lock held.
> + */
> +static int _opp_drain_list(struct opp_table *opp_table, bool dynamic)
>  {
> -	struct dev_pm_opp *opp;
> +	struct dev_pm_opp *opp, *current_opp = NULL;
> +	int count = 0;
> +
> +	while ((opp = _opp_get_next(opp_table, dynamic))) {
> +		if (opp_table->current_opp == opp) {
> +			/*
> +			 * Reached at current OPP twice, no other OPPs left. The
> +			 * last reference to current_opp is dropped from
> +			 * _opp_table_kref_release().
> +			 */
> +			if (current_opp)
> +				break;
> +
> +			current_opp = opp;
> +		}
Having a quick look at the code ...
Shouldn't the current_opp be moved at the end of the list ?
Otherwise there is a risk of leaving unreferenced opps (and opp_table).
Might be also worth adding warning (?)

    WARN_ONCE(!list_is_singular())


---
BR
B.
> +
> +		dev_pm_opp_put(opp);
> +		count++;
> +	}
> +
> +	return count;
> +}
>  
> +bool _opp_remove_all_static(struct opp_table *opp_table)
> +{
>  	mutex_lock(&opp_table->lock);
>  
>  	if (!opp_table->parsed_static_opps) {
> @@ -1520,13 +1548,7 @@ bool _opp_remove_all_static(struct opp_table *opp_table)
>  
>  	mutex_unlock(&opp_table->lock);
>  
> -	/*
> -	 * Can't remove the OPP from under the lock, debugfs removal needs to
> -	 * happen lock less to avoid circular dependency issues.
> -	 */
> -	while ((opp = _opp_get_next(opp_table, false)))
> -		dev_pm_opp_put(opp);
> -
> +	_opp_drain_list(opp_table, false);
>  	return true;
>  }
>  
> @@ -1539,21 +1561,13 @@ bool _opp_remove_all_static(struct opp_table *opp_table)
>  void dev_pm_opp_remove_all_dynamic(struct device *dev)
>  {
>  	struct opp_table *opp_table;
> -	struct dev_pm_opp *opp;
> -	int count = 0;
> +	int count;
>  
>  	opp_table = _find_opp_table(dev);
>  	if (IS_ERR(opp_table))
>  		return;
>  
> -	/*
> -	 * Can't remove the OPP from under the lock, debugfs removal needs to
> -	 * happen lock less to avoid circular dependency issues.
> -	 */
> -	while ((opp = _opp_get_next(opp_table, true))) {
> -		dev_pm_opp_put(opp);
> -		count++;
> -	}
> +	count = _opp_drain_list(opp_table, true);
>  
>  	/* Drop the references taken by dev_pm_opp_add() */
>  	while (count--)
