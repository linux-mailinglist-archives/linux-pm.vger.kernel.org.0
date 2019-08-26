Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 414E99CC73
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 11:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbfHZJUY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 05:20:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44725 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfHZJUY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Aug 2019 05:20:24 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 2b9292fac4598eca; Mon, 26 Aug 2019 11:20:21 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Colin King <colin.king@canonical.com>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: remove redundant assignment to ret
Date:   Mon, 26 Aug 2019 11:20:21 +0200
Message-ID: <2250924.CPEEF64KPg@kreacher>
In-Reply-To: <20190819065814.333kowws4mpw3qfx@vireshk-i7>
References: <20190813122121.28160-1-colin.king@canonical.com> <20190819065814.333kowws4mpw3qfx@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, August 19, 2019 8:58:14 AM CEST Viresh Kumar wrote:
> On 13-08-19, 13:21, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Variable ret is initialized to a value that is never read and it is
> > re-assigned later. The initialization is redundant and can be removed.
> > 
> > Addresses-Coverity: ("Unused value")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index c28ebf2810f1..26d82e0a2de5 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2140,7 +2140,7 @@ int cpufreq_driver_target(struct cpufreq_policy *policy,
> >  			  unsigned int target_freq,
> >  			  unsigned int relation)
> >  {
> > -	int ret = -EINVAL;
> > +	int ret;
> >  
> >  	down_write(&policy->rwsem);
> >  
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

Patch applied, thanks!




