Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17B9E9CC7F
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 11:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfHZJW7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 05:22:59 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45663 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729753AbfHZJW7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Aug 2019 05:22:59 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 5f4a13a5f27ca4dc; Mon, 26 Aug 2019 11:22:56 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Print driver name if cpufreq_suspend() fails
Date:   Mon, 26 Aug 2019 11:22:56 +0200
Message-ID: <9030003.WlOONWmqy1@kreacher>
In-Reply-To: <b534e21b-af00-bbec-2a53-0c3bda8c8ce9@gmail.com>
References: <20190821231632.29133-1-f.fainelli@gmail.com> <20190822024221.wt7mx2zrm3fetnjp@vireshk-i7> <b534e21b-af00-bbec-2a53-0c3bda8c8ce9@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, August 22, 2019 6:21:20 PM CEST Florian Fainelli wrote:
> On 8/21/19 7:42 PM, Viresh Kumar wrote:
> > On 21-08-19, 16:16, Florian Fainelli wrote:
> >> Instead of printing the policy, which is incidentally a kernel pointer,
> >> so with limited interest, print the cpufreq driver name that failed to
> >> be suspend, which is more useful for debugging.
> >>
> >> Fixes: 2f0aea936360 ("cpufreq: suspend governors on system suspend/hibernate")
> > 
> > I will drop this tag as this isn't a bug really.
> 
> Indeed, that was a bit too trigger happy on my side. Thanks!

Applied without the Fixes tag, thanks!

> > 
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>  drivers/cpufreq/cpufreq.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index c28ebf2810f1..330d789f81fc 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >> @@ -1807,8 +1807,8 @@ void cpufreq_suspend(void)
> >>  		}
> >>  
> >>  		if (cpufreq_driver->suspend && cpufreq_driver->suspend(policy))
> >> -			pr_err("%s: Failed to suspend driver: %p\n", __func__,
> >> -				policy);
> >> +			pr_err("%s: Failed to suspend driver: %s\n", __func__,
> >> +				cpufreq_driver->name);
> >>  	}
> >>  
> >>  suspend:
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> 
> 
> 




