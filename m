Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648ED394507
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 17:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbhE1P24 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 May 2021 11:28:56 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59055 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S235792AbhE1P2z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 May 2021 11:28:55 -0400
Received: (qmail 1475088 invoked by uid 1000); 28 May 2021 11:27:19 -0400
Date:   Fri, 28 May 2021 11:27:19 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PM: runtime: Allow unassigned
 ->runtime_suspend|resume callbacks
Message-ID: <20210528152719.GA1473569@rowland.harvard.edu>
References: <20210528091202.11603-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528091202.11603-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 28, 2021 at 11:12:02AM +0200, Ulf Hansson wrote:
> We are currently allowing ->rpm_idle() callbacks to be unassigned without
> returning an error code from rpm_idle(). This has been useful to avoid
> boilerplate code in drivers. Let's take this approach a step further, by
> allowing unassigned ->runtime_suspend|resume() callbacks as well.
> 
> In this way, a consumer/supplier device link can be used to let a consumer
> device be power managed through its supplier device, without requiring
> assigned ->runtime_suspend|resume() callbacks for the consumer device, for
> example.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/runtime.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 68bebbf81347..8a66eaf731e4 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -345,7 +345,7 @@ static void rpm_suspend_suppliers(struct device *dev)
>  static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
>  	__releases(&dev->power.lock) __acquires(&dev->power.lock)
>  {
> -	int retval, idx;
> +	int retval = 0, idx;
>  	bool use_links = dev->power.links_count > 0;
>  
>  	if (dev->power.irq_safe) {
> @@ -373,7 +373,8 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
>  		}
>  	}
>  
> -	retval = cb(dev);
> +	if (cb)
> +		retval = cb(dev);
>  
>  	if (dev->power.irq_safe) {
>  		spin_lock(&dev->power.lock);
> @@ -484,9 +485,6 @@ static int rpm_callback(int (*cb)(struct device *), struct device *dev)
>  {
>  	int retval;
>  
> -	if (!cb)
> -		return -ENOSYS;

This is a change in behavior, right?  What about drivers or subsystems 
that don't support runtime PM and consequently don't have any RPM 
callbacks assigned?

Also, assuming Rafael accepts this change, don't you also need to update 
the runtime-PM documentation?

Alan Stern

> -
>  	if (dev->power.memalloc_noio) {
>  		unsigned int noio_flag;
>  
> -- 
> 2.25.1
