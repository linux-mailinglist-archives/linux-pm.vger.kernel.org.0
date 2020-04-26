Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8381B9104
	for <lists+linux-pm@lfdr.de>; Sun, 26 Apr 2020 17:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgDZPCP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Apr 2020 11:02:15 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51532 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgDZPCP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Apr 2020 11:02:15 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 2c4431b5b229701a; Sun, 26 Apr 2020 17:02:13 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq/pstate: Only mention the BIOS disabling turbo mode once
Date:   Sun, 26 Apr 2020 17:02:12 +0200
Message-ID: <15275956.dygttixizy@kreacher>
In-Reply-To: <20200410192629.6779-1-chris@chris-wilson.co.uk>
References: <20200410192629.6779-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, April 10, 2020 9:26:29 PM CEST Chris Wilson wrote:
> Make a note of the first time we discover the turbo mode has been
> disabled by the BIOS, as otherwise we complain every time we try to
> update the mode.
> 
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index c81e1ff29069..b4c014464a20 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1058,7 +1058,7 @@ static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
>  
>  	update_turbo_state();
>  	if (global.turbo_disabled) {
> -		pr_warn("Turbo disabled by BIOS or unavailable on processor\n");
> +		pr_notice_once("Turbo disabled by BIOS or unavailable on processor\n");
>  		mutex_unlock(&intel_pstate_limits_lock);
>  		mutex_unlock(&intel_pstate_driver_lock);
>  		return -EPERM;
> 

Applied as a fix for 5.7-rc4, sorry for the delay.

Thanks!



