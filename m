Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5426D113B76
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 06:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfLEFub (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 00:50:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:19127 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfLEFub (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Dec 2019 00:50:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 21:50:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; 
   d="scan'208";a="361814167"
Received: from yuanwan1-mobl.ccr.corp.intel.com ([10.249.174.225])
  by orsmga004.jf.intel.com with ESMTP; 04 Dec 2019 21:50:27 -0800
Message-ID: <f948e348f4d3a096d42b80f79288cb88903ad800.camel@intel.com>
Subject: Re: linux-next: Tree for Nov 15 (thermal:
 THERMAL_GOV_POWER_ALLOCATOR)
From:   Zhang Rui <rui.zhang@intel.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 05 Dec 2019 13:50:27 +0800
In-Reply-To: <20191205043609.GA231782@google.com>
References: <20191115190525.77efdf6c@canb.auug.org.au>
         <247cd41e-a07b-adf0-4ec2-6467f0257837@infradead.org>
         <9436e207-8a65-f01b-c348-32a8a00f03d4@infradead.org>
         <6d43c93a748872293df489d397f894b77b221bc9.camel@intel.com>
         <20191205043609.GA231782@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2019-12-05 at 04:36 +0000, Quentin Perret wrote:
> Hi all,
> 
> On Thursday 05 Dec 2019 at 12:27:47 (+0800), Zhang Rui wrote:
> > I overlooked the original report probably because I was not CCed.
> > 
> > This is introduced by commit a4e893e802e6("thermal: cpu_cooling:
> > Migrate to using the EM framework") which adds the dependency of
> > ENERGY_MODEL for THERMAL_GOV_POWER_ALLOCATOR.
> > 
> > To fix this, it's better to make
> > THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
> > depends on THERMAL_GOV_POWER_ALLOCATOR instead.
> > 
> > Please confirm the problem is fixed by below patch.
> > 
> > thanks,
> > rui
> > 
> > From c9429f6e28ea2219686a4294d39f015ba373774b Mon Sep 17 00:00:00
> > 2001
> > From: Zhang Rui <rui.zhang@intel.com>
> > Date: Thu, 5 Dec 2019 12:17:07 +0800
> > Subject: [PATCH] thermal: fix a Kconfig warning
> > 
> > Currently, THERMAL_GOV_POWER_ALLOCATOR is selected by
> > THERMAL_DEFAULT_GOV_POWER_ALLOCATOR even if it has some unmet
> > dependencies.
> > 
> > This causes the Kconfig warning
> >    WARNING: unmet direct dependencies detected for
> >       THERMAL_GOV_POWER_ALLOCATOR
> >       Depends on [n]: THERMAL [=y] && ENERGY_MODEL [=n]
> >       Selected by [y]:
> >       - THERMAL_DEFAULT_GOV_POWER_ALLOCATOR [=y] && <choice>
> > 
> > Fix the problem by making THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
> > depends on
> > THERMAL_GOV_POWER_ALLOCATOR instead.
> > 
> > Fixes: a4e893e802e6("thermal: cpu_cooling: Migrate to using the EM
> > framework")
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/thermal/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 59b79fc48266..79b27865c6f4 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -108,7 +108,7 @@ config THERMAL_DEFAULT_GOV_USER_SPACE
> >  
> >  config THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
> >  	bool "power_allocator"
> > -	select THERMAL_GOV_POWER_ALLOCATOR
> > +	depends on THERMAL_GOV_POWER_ALLOCATOR
> >  	help
> >  	  Select this if you want to control temperature based on
> >  	  system and device power allocation. This governor can only
> > -- 
> > 2.17.1
> 
> FWIW, a similar fix has been suggested a couple weeks back:
> 
>   
> https://lore.kernel.org/lkml/20191113105313.41616-1-yuehaibing@huawei.com/

Right, this patch was just merged by Daniel. It seems that we need a
second PR in this merge window.

thanks,
rui
> 
> Thanks,
> Quentin

