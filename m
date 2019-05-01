Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE27106E6
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 12:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfEAKUM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 06:20:12 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55204 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfEAKUM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 06:20:12 -0400
Received: from 79.184.254.69.ipv4.supernova.orange.pl (79.184.254.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id ba2c7db3dd85b69f; Wed, 1 May 2019 12:20:10 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>, Yue Hu <zbestahu@gmail.com>
Cc:     rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        huyue2@yulong.com
Subject: Re: [PATCH] cpufreq / boost: Remove CONFIG_CPU_FREQ_BOOST_SW Kconfig option
Date:   Wed, 01 May 2019 12:20:09 +0200
Message-ID: <2085382.RNldxVhX4H@kreacher>
In-Reply-To: <20190410041005.iwuppsv7je5oa537@vireshk-i7>
References: <20190410035952.5728-1-zbestahu@gmail.com> <20190410041005.iwuppsv7je5oa537@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, April 10, 2019 6:10:05 AM CEST Viresh Kumar wrote:
> On 10-04-19, 11:59, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Commit 2fb4719b2560 ("cpufreq / boost: Kconfig: Support for
> > software-managed BOOST") added the CONFIG_CPU_FREQ_BOOST_SW config.
> > However EXYNOS based cpufreq drivers have been removed because of
> > switching to cpufreq-dt driver which will set boost-attr if required.
> > 
> > So, let's remove this option and update cpufreq_generic_attr[].
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  drivers/cpufreq/Kconfig      | 4 ----
> >  drivers/cpufreq/freq_table.c | 3 ---
> >  2 files changed, 7 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> > index b22e6bb..4d2b33a 100644
> > --- a/drivers/cpufreq/Kconfig
> > +++ b/drivers/cpufreq/Kconfig
> > @@ -26,10 +26,6 @@ config CPU_FREQ_GOV_COMMON
> >  	select IRQ_WORK
> >  	bool
> >  
> > -config CPU_FREQ_BOOST_SW
> > -	bool
> > -	depends on THERMAL
> > -
> >  config CPU_FREQ_STAT
> >  	bool "CPU frequency transition statistics"
> >  	help
> > diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> > index 3a8cc99..e7be0af 100644
> > --- a/drivers/cpufreq/freq_table.c
> > +++ b/drivers/cpufreq/freq_table.c
> > @@ -290,9 +290,6 @@ static ssize_t scaling_boost_frequencies_show(struct cpufreq_policy *policy,
> >  
> >  struct freq_attr *cpufreq_generic_attr[] = {
> >  	&cpufreq_freq_attr_scaling_available_freqs,
> > -#ifdef CONFIG_CPU_FREQ_BOOST_SW
> > -	&cpufreq_freq_attr_scaling_boost_freqs,
> > -#endif
> >  	NULL,
> >  };
> >  EXPORT_SYMBOL_GPL(cpufreq_generic_attr);
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!



