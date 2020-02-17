Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2612F160BC2
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2020 08:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgBQHjx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Feb 2020 02:39:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:3856 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgBQHjx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Feb 2020 02:39:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2020 23:39:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,451,1574150400"; 
   d="scan'208";a="235148738"
Received: from zhouy1-mobl1.ccr.corp.intel.com ([10.249.169.88])
  by orsmga003.jf.intel.com with ESMTP; 16 Feb 2020 23:39:49 -0800
Message-ID: <6abe2d62a08d38d53c85b3892ed77dbcc543c8fc.camel@intel.com>
Subject: Re: [PATCH] thermal: fix indentation in makefile
From:   Zhang Rui <rui.zhang@intel.com>
To:     Frank Lee <tiny.windzz@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 17 Feb 2020 15:39:48 +0800
In-Reply-To: <CAEExFWte+2f0ys5pmUyo1Fcf+FxpPOTDD3bgiAyOu2wgJ2vy4Q@mail.gmail.com>
References: <20191221173737.30906-1-tiny.windzz@gmail.com>
         <19c1277f-f0b1-899d-6db0-5c7ff4fe7512@linaro.org>
         <CAEExFWte+2f0ys5pmUyo1Fcf+FxpPOTDD3bgiAyOu2wgJ2vy4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2019-12-23 at 01:38 +0800, Frank Lee wrote:
> ：q
> 
> On Sun, Dec 22, 2019 at 2:57 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> > 
> > On 21/12/2019 18:37, Yangtao Li wrote:
> > > To unify code style.
> > > 
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  drivers/thermal/Makefile | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > > index baeb70bf0568..ab9389bc42b2 100644
> > > --- a/drivers/thermal/Makefile
> > > +++ b/drivers/thermal/Makefile
> > > @@ -5,7 +5,7 @@
> > > 
> > >  obj-$(CONFIG_THERMAL)                += thermal_sys.o
> > >  thermal_sys-y                        += thermal_core.o
> > > thermal_sysfs.o \
> > > -                                     thermal_helpers.o
> > > +                                thermal_helpers.o
> > 
> > Here a tabulation is replaced with spaces.
> 
> It won't align after using tab here, shouldn't modify it?

I'd prefer using tab here. Other changes seem okay to me.

thanks,
rui
> 
> 
> Yours,
> Yangtao
> 
> > 
> > >  # interface to/from other layers providing sensors
> > >  thermal_sys-$(CONFIG_THERMAL_HWMON)          += thermal_hwmon.o
> > > @@ -25,11 +25,11 @@ thermal_sys-$(CONFIG_CPU_THERMAL) +=
> > > cpu_cooling.o
> > >  thermal_sys-$(CONFIG_CLOCK_THERMAL)  += clock_cooling.o
> > > 
> > >  # devfreq cooling
> > > -thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
> > > +thermal_sys-$(CONFIG_DEVFREQ_THERMAL)        +=
> > > devfreq_cooling.o
> > > 
> > >  # platform thermal drivers
> > >  obj-y                                += broadcom/
> > > -obj-$(CONFIG_THERMAL_MMIO)           += thermal_mmio.o
> > > +obj-$(CONFIG_THERMAL_MMIO)   += thermal_mmio.o
> > >  obj-$(CONFIG_SPEAR_THERMAL)  += spear_thermal.o
> > >  obj-$(CONFIG_ROCKCHIP_THERMAL)       += rockchip_thermal.o
> > >  obj-$(CONFIG_RCAR_THERMAL)   += rcar_thermal.o
> > > @@ -49,9 +49,9 @@ obj-$(CONFIG_TI_SOC_THERMAL)        += ti-soc-
> > > thermal/
> > >  obj-y                                += st/
> > >  obj-$(CONFIG_QCOM_TSENS)     += qcom/
> > >  obj-y                                += tegra/
> > > -obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
> > > +obj-$(CONFIG_HISI_THERMAL)   += hisi_thermal.o
> > >  obj-$(CONFIG_MTK_THERMAL)    += mtk_thermal.o
> > >  obj-$(CONFIG_GENERIC_ADC_THERMAL)    += thermal-generic-adc.o
> > >  obj-$(CONFIG_ZX2967_THERMAL) += zx2967_thermal.o
> > >  obj-$(CONFIG_UNIPHIER_THERMAL)       += uniphier_thermal.o
> > > -obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
> > > +obj-$(CONFIG_AMLOGIC_THERMAL)        += amlogic_thermal.o
> > > 
> > 
> > 
> > --
> >  <http://www.linaro.org/> Linaro.org │ Open source software for ARM
> > SoCs
> > 
> > Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> > <http://twitter.com/#!/linaroorg> Twitter |
> > <http://www.linaro.org/linaro-blog/> Blog
> > 

