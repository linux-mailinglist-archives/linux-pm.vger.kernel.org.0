Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDAD1F006E
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jun 2020 21:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgFETdP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 15:33:15 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:1171 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbgFETdO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Jun 2020 15:33:14 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49dt943zkfz4D;
        Fri,  5 Jun 2020 21:33:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591385592; bh=NbpDYpdkf930A2wnbJzAI2o3zbz9vWpgpt6I40W+VCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dHH1QfOvGdT+0jlPvJhvNdEPxayLlke1XA/H17Io9Mw+avbdQA7j75d3vVaRl9G2v
         VR89bMtAsuM76o8qbQQDcoY951iOUjdr/psu8iSSIEQBWDVQpcby+SqLyetOvWkx74
         Zx76TmvuYuTjv3/f9DfCpkPTsA4Oqd63TUbeahNkz3bVI7QHUS51xuF7Izh1Aynyhj
         sLecXOE19bzO53Bq0p52ov20ZJ+WcftN1Dw+xdv2DMPJVdJtaA95Pg4bVBVN7xjG5K
         5l8rJGBfCUK0UzlDqwhWiqqDyKGYyniwEagGpZw8pvFz4/8gtbVf/LRrSDKpspbh8+
         Bbt6OjLZWC20g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 5 Jun 2020 21:33:11 +0200
From:   Michal Miroslaw <mirq-linux@rere.qmqm.pl>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2][RFC] PM-runtime: add tracepoints to cover all
 usage_count changes
Message-ID: <20200605193311.GB9553@qmqm.qmqm.pl>
References: <cover.1591380524.git.yu.c.chen@intel.com>
 <6ce5c2d21758363b7c9a31187eda1787bc4a6160.1591380524.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ce5c2d21758363b7c9a31187eda1787bc4a6160.1591380524.git.yu.c.chen@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 06, 2020 at 03:05:52AM +0800, Chen Yu wrote:
> Commit d229290689ae ("PM-runtime: add tracepoints for usage_count changes")
> has added some tracepoints to monitor the change of runtime usage, and
> there is something to improve:
> 1. There are some places that adjust the usage count have not
>    been traced yet. For example, pm_runtime_get_noresume() and
>    pm_runtime_put_noidle()
> 2. The change of the usage count will not be tracked if decreased
>    from 1 to 0.
[...]
> @@ -1448,16 +1453,17 @@ EXPORT_SYMBOL_GPL(pm_runtime_forbid);
>   */
>  void pm_runtime_allow(struct device *dev)
>  {
> +	bool is_zero;
> +
>  	spin_lock_irq(&dev->power.lock);
>  	if (dev->power.runtime_auto)
>  		goto out;
>  
>  	dev->power.runtime_auto = true;
> -	if (atomic_dec_and_test(&dev->power.usage_count))
> +	is_zero = atomic_dec_and_test(&dev->power.usage_count);
> +	trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);
> +	if (is_zero)
>  		rpm_idle(dev, RPM_AUTO | RPM_ASYNC);
> -	else
> -		trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);
> -
[...]

IIRC, rpm_idle() has a tracepoint already.

> @@ -1523,9 +1529,8 @@ static void update_autosuspend(struct device *dev, int old_delay, int old_use)
>  		/* If it used to be allowed then prevent it. */
>  		if (!old_use || old_delay >= 0) {
>  			atomic_inc(&dev->power.usage_count);
> -			rpm_resume(dev, 0);
> -		} else {
>  			trace_rpm_usage_rcuidle(dev, 0);
> +			rpm_resume(dev, 0);
>  		}
>  	}
[...]

This actually changes logic, so it doesn't match the patch description.

Best Regards
Micha³ Miros³aw
