Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DEE334C24
	for <lists+linux-pm@lfdr.de>; Thu, 11 Mar 2021 00:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhCJXD2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 18:03:28 -0500
Received: from foss.arm.com ([217.140.110.172]:54984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231368AbhCJXDN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Mar 2021 18:03:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1185D31B;
        Wed, 10 Mar 2021 15:03:13 -0800 (PST)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8946B3F800;
        Wed, 10 Mar 2021 15:03:11 -0800 (PST)
Date:   Wed, 10 Mar 2021 23:03:01 +0000
From:   Beata Michalska <beata.michalska@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Subject: Re: [PATCH] opp: Invalidate current opp when draining the opp list
Message-ID: <20210310230300.GA26976@e120325.cambridge.arm.com>
References: <1614870454-18709-1-git-send-email-beata.michalska@arm.com>
 <20210305042401.gktrgach4dzxp7on@vireshk-i7>
 <418fc3cb-d5ec-9216-269a-e055e78718e5@arm.com>
 <20210308115053.ua2gfo6kfnfjslyd@vireshk-i7>
 <20210308181446.GA26783@e120325.cambridge.arm.com>
 <20210309043121.546mlvl4jmshogor@vireshk-i7>
 <20210309121455.GA13095@e120325.cambridge.arm.com>
 <20210310084738.pe7ppyeq6hn7wbvv@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310084738.pe7ppyeq6hn7wbvv@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 10, 2021 at 02:17:38PM +0530, Viresh Kumar wrote:
> On 09-03-21, 12:14, Beata Michalska wrote:
> > With the current version, once the _opp_get_next returns opp
> > that is the current_opp, the while loop will break, leaving all
> > the opps that are on the list after current_opp
> 
> Thanks for your excellent review Beata. I have been missing a lot
> lately :(
> 
> Though now I have spent more time on it and the bug seems to be more
> severe. This is what I have applied now :)
> 
> I was able to test that the OPP table gets freed without any reference
> counts issues now.
> 
> -- 
> viresh
> 
> -------------------------8<-------------------------
> From: Beata Michalska <beata.michalska@arm.com>
> Date: Thu, 4 Mar 2021 15:07:34 +0000
> Subject: [PATCH] opp: Don't drop extra references to OPPs accidentally
> 
> We are required to call dev_pm_opp_put() from outside of the
> opp_table->lock as debugfs removal needs to happen lock-less to avoid
> circular dependency issues.
> 
> commit cf1fac943c63 ("opp: Reduce the size of critical section in
> _opp_kref_release()") tried to fix that introducing a new routine
> _opp_get_next() which keeps returning OPPs that can be freed by the
> callers and this routine shall be called without holding the
> opp_table->lock.
> 
> Though the commit overlooked the fact that the OPPs can be referenced by
> other users as well and this routine will end up dropping references
> which were taken by other users and hence freeing the OPPs prematurely.
> 
> In effect, other users of the OPPs will end up having invalid pointers
> at hand. We didn't see any crash reports earlier as the exact situation
> never happened, though it is certainly possible.
> 
> We need a way to mark which OPPs are no longer referenced by the OPP
> core, so we don't drop extra references to them accidentally.
> 
> This commit adds another OPP flag, "removed", which is used to track
> this. And now we should never end up dropping extra references to the
> OPPs.
> 
> Cc: v5.11+ <stable@vger.kernel.org> # v5.11+
> Fixes: cf1fac943c63 ("opp: Reduce the size of critical section in _opp_kref_release()")
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> [ Viresh: Almost rewrote entire patch, added new "removed" field,
> 	  rewrote commit log and added the correct Fixes tag. ]
> Co-developed-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/core.c | 48 ++++++++++++++++++++++++----------------------
>  drivers/opp/opp.h  |  2 ++
>  2 files changed, 27 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index c2689386a906..150be4c28c99 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1492,7 +1492,11 @@ static struct dev_pm_opp *_opp_get_next(struct opp_table *opp_table,
>  
>  	mutex_lock(&opp_table->lock);
>  	list_for_each_entry(temp, &opp_table->opp_list, node) {
> -		if (dynamic == temp->dynamic) {
> +		/*
> +		 * Refcount must be dropped only once for each OPP by OPP core,
> +		 * do that with help of "removed" flag.
> +		 */
> +		if (!temp->removed && dynamic == temp->dynamic) {
>  			opp = temp;
>  			break;
>  		}
How about tweaking the _opp_get_next to use list_for_each_entry_continue
instead ? It would eliminate the need of tracking the 'removed' status
and could save few cycles as it wouldn't have to go through the list
starting from it's beginning each time it is being called.
Happy to draft another version.

Otherwise it looks good.

> @@ -1502,10 +1506,27 @@ static struct dev_pm_opp *_opp_get_next(struct opp_table *opp_table,
>  	return opp;
>  }
>  
> -bool _opp_remove_all_static(struct opp_table *opp_table)
> +/*
> + * Can't call dev_pm_opp_put() from under the lock as debugfs removal needs to
> + * happen lock less to avoid circular dependency issues. This routine must be
> + * called without the opp_table->lock held.
> + */
> +static void _opp_drain_list(struct opp_table *opp_table, bool dynamic)
>  {
>  	struct dev_pm_opp *opp;
>  
> +	while ((opp = _opp_get_next(opp_table, dynamic))) {
> +		opp->removed = true;
> +		dev_pm_opp_put(opp);
> +
> +		/* Drop the references taken by dev_pm_opp_add() */
> +		if (dynamic)
> +			dev_pm_opp_put_opp_table(opp_table);
> +	}
> +}
> +
Neat: The 'drain' in the function name is not entirely describing
what the function actually does anymore.

---
BR
B.
> +bool _opp_remove_all_static(struct opp_table *opp_table)
> +{
>  	mutex_lock(&opp_table->lock);
>  
>  	if (!opp_table->parsed_static_opps) {
> @@ -1520,13 +1541,7 @@ bool _opp_remove_all_static(struct opp_table *opp_table)
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
> @@ -1539,25 +1554,12 @@ bool _opp_remove_all_static(struct opp_table *opp_table)
>  void dev_pm_opp_remove_all_dynamic(struct device *dev)
>  {
>  	struct opp_table *opp_table;
> -	struct dev_pm_opp *opp;
> -	int count = 0;
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
> -
> -	/* Drop the references taken by dev_pm_opp_add() */
> -	while (count--)
> -		dev_pm_opp_put_opp_table(opp_table);
> +	_opp_drain_list(opp_table, true);
>  
>  	/* Drop the reference taken by _find_opp_table() */
>  	dev_pm_opp_put_opp_table(opp_table);
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 50fb9dced3c5..407c3bfe51d9 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -56,6 +56,7 @@ extern struct list_head opp_tables, lazy_opp_tables;
>   * @dynamic:	not-created from static DT entries.
>   * @turbo:	true if turbo (boost) OPP
>   * @suspend:	true if suspend OPP
> + * @removed:	flag indicating that OPP's reference is dropped by OPP core.
>   * @pstate: Device's power domain's performance state.
>   * @rate:	Frequency in hertz
>   * @level:	Performance level
> @@ -78,6 +79,7 @@ struct dev_pm_opp {
>  	bool dynamic;
>  	bool turbo;
>  	bool suspend;
> +	bool removed;
>  	unsigned int pstate;
>  	unsigned long rate;
>  	unsigned int level;
