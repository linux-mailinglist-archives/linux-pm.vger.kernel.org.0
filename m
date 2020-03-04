Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09D0F178F4E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 12:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgCDLIC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 06:08:02 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:45242 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729286AbgCDLIB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 06:08:01 -0500
Received: from 79.184.237.41.ipv4.supernova.orange.pl (79.184.237.41) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 2bd8be21abd0c5ba; Wed, 4 Mar 2020 12:07:58 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     madhuparnabhowmik10@gmail.com
Cc:     pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org
Subject: Re: [PATCH 1/2] drivers: base: power: main.c: Use built-in RCU list checking
Date:   Wed, 04 Mar 2020 12:07:58 +0100
Message-ID: <1643853.WSYDh8IRHD@kreacher>
In-Reply-To: <20200303194130.24617-1-madhuparnabhowmik10@gmail.com>
References: <20200303194130.24617-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, March 3, 2020 8:41:30 PM CET madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> This patch passes the cond argument to list_for_each_entry_rcu()
> to fix the following false-positive lockdep warnings:
> (with CONFIG_PROVE_RCU_LIST = y)
> 
> [  330.302784] =============================
> [  330.302789] WARNING: suspicious RCU usage
> [  330.302796] 5.6.0-rc1+ #5 Not tainted
> [  330.302801] -----------------------------
> [  330.302808] drivers/base/power/main.c:326 RCU-list traversed in non-reader section!!
> 
> [  330.303303] =============================
> [  330.303307] WARNING: suspicious RCU usage
> [  330.303311] 5.6.0-rc1+ #5 Not tainted
> [  330.303315] -----------------------------
> [  330.303319] drivers/base/power/main.c:1698 RCU-list traversed in non-reader section!!
> 
> [  331.934969] =============================
> [  331.934971] WARNING: suspicious RCU usage
> [  331.934973] 5.6.0-rc1+ #5 Not tainted
> [  331.934975] -----------------------------
> [  331.934977] drivers/base/power/main.c:1238 RCU-list traversed in non-reader section!!
> 
> [  332.467772] WARNING: suspicious RCU usage
> [  332.467775] 5.6.0-rc1+ #5 Not tainted
> [  332.467775] -----------------------------
> [  332.467778] drivers/base/power/main.c:269 RCU-list traversed in non-reader section!!
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> ---
>  drivers/base/power/main.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 0e99a760aebd..6d1dee7051eb 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -40,6 +40,10 @@
>  
>  typedef int (*pm_callback_t)(struct device *);
>  
> +#define list_for_each_entry_rcu_locked(pos, head, member) \
> +	list_for_each_entry_rcu(pos, head, member, \
> +			device_links_read_lock_held())
> +
>  /*
>   * The entries in the dpm_list list are in a depth first order, simply
>   * because children are guaranteed to be discovered after parents, and
> @@ -266,7 +270,7 @@ static void dpm_wait_for_suppliers(struct device *dev, bool async)
>  	 * callbacks freeing the link objects for the links in the list we're
>  	 * walking.
>  	 */
> -	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
> +	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
>  		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
>  			dpm_wait(link->supplier, async);
>  
> @@ -323,7 +327,7 @@ static void dpm_wait_for_consumers(struct device *dev, bool async)
>  	 * continue instead of trying to continue in parallel with its
>  	 * unregistration).
>  	 */
> -	list_for_each_entry_rcu(link, &dev->links.consumers, s_node)
> +	list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_node)
>  		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
>  			dpm_wait(link->consumer, async);
>  
> @@ -1235,7 +1239,7 @@ static void dpm_superior_set_must_resume(struct device *dev)
>  
>  	idx = device_links_read_lock();
>  
> -	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
> +	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
>  		link->supplier->power.must_resume = true;
>  
>  	device_links_read_unlock(idx);
> @@ -1695,7 +1699,7 @@ static void dpm_clear_superiors_direct_complete(struct device *dev)
>  
>  	idx = device_links_read_lock();
>  
> -	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
> +	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
>  		spin_lock_irq(&link->supplier->power.lock);
>  		link->supplier->power.direct_complete = false;
>  		spin_unlock_irq(&link->supplier->power.lock);
> 

Applied along with the [2/2] (with updated changelogs) as 5.7 material.

Thanks!




