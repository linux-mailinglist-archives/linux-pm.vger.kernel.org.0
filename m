Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725BD6474A3
	for <lists+linux-pm@lfdr.de>; Thu,  8 Dec 2022 17:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiLHQt3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Dec 2022 11:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiLHQt2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Dec 2022 11:49:28 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F8C84B7B
        for <linux-pm@vger.kernel.org>; Thu,  8 Dec 2022 08:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670518167; x=1702054167;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mxS2PotpsGz8+tw2+kXpzz3/78UFhWc80yCB3ZDPPGY=;
  b=Q2oQbUfYKyzqQ0AkzgKYjPh1hhIBbiG2X3VRK7fjcML3zqKcdLZOJ4rb
   UU04fBZuqF6XEyaYOWAO3TTic6xIS9lF6vETuQ2PfFuNNz3hA29qZDMhq
   j6Dbst9FTjg6tbDC+PkWCrCGuQMMLZXQqvUlgOZ0NRLEX/WBzqUszsrH/
   K7sOnxDGW7Z18SFtDHpMVIta6GEfrZXeSJpVihxxnom7JI7zTofHny+N4
   BUR44ZcfAqLy9xvy6zdlzA73wL9De2HBYrKRjtDb2fcIPjrcLmPXj5eP5
   APz3to4+nuDMKwR1UuWpuTJmU5016KcevC6eVodgkBTfW89CPObzyO317
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="297577344"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="297577344"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 08:49:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="892302677"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="892302677"
Received: from hlin7-mobl.ccr.corp.intel.com ([10.255.30.254])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 08:49:24 -0800
Message-ID: <c827d96fcf50a39ebd219cd09d9b4bd1db2f0398.camel@intel.com>
Subject: Re: [PATCH 1/6] thermal/intel: Introduce Intel TCC library
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Date:   Fri, 09 Dec 2022 00:49:21 +0800
In-Reply-To: <CAJZ5v0hOzCRnoH52EEMZm+CRDNKSYg2iZax2CnowzdMXjX8QYA@mail.gmail.com>
References: <20221108033332.27760-1-rui.zhang@intel.com>
         <20221108033332.27760-2-rui.zhang@intel.com>
         <CAJZ5v0hOzCRnoH52EEMZm+CRDNKSYg2iZax2CnowzdMXjX8QYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2022-12-08 at 14:49 +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 8, 2022 at 4:31 AM Zhang Rui <rui.zhang@intel.com> wrote:
> > There are several different drivers that accesses the Intel TCC
> > (thermal control circuitry) MSRs, and each of them has its own
> > implementation for the same functionalities, e.g. getting the
> > current
> > temperature, getting the tj_max, and getting/setting the tj_max
> > offset.
> > 
> > Introduce a library to unify the code for Intel CPU TCC MSR access.
> > 
> > At the same time, ensure the temperature is got based on the
> > updated
> > tjmax value because tjmax can be changed at runtime for cases like
> > the Intel SST-PP (Intel Speed Select Technology - Performance
> > Profile)
> > level change.
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> 
> Nice series, overall I like it a lot, but I have some comments
> regarding this particular patch (below).  Some of them are arguably
> minor, but at least one thing is more serious.

Hi, Rafael,

Thanks for reviewing the patch set.
> 
> > ---
> >  drivers/thermal/intel/Kconfig     |   4 +
> >  drivers/thermal/intel/Makefile    |   1 +
> >  drivers/thermal/intel/intel_tcc.c | 131
> > ++++++++++++++++++++++++++++++
> >  include/linux/intel_tcc.h         |  18 ++++
> >  4 files changed, 154 insertions(+)
> >  create mode 100644 drivers/thermal/intel/intel_tcc.c
> >  create mode 100644 include/linux/intel_tcc.h
> > 
> > diff --git a/drivers/thermal/intel/Kconfig
> > b/drivers/thermal/intel/Kconfig
> > index f0c845679250..6b938c040d6e 100644
> > --- a/drivers/thermal/intel/Kconfig
> > +++ b/drivers/thermal/intel/Kconfig
> > @@ -12,6 +12,10 @@ config X86_THERMAL_VECTOR
> >         def_bool y
> >         depends on X86 && CPU_SUP_INTEL && X86_LOCAL_APIC
> > 
> > +config INTEL_TCC
> > +       bool
> > +       depends on X86
> > +
> >  config X86_PKG_TEMP_THERMAL
> >         tristate "X86 package temperature thermal driver"
> >         depends on X86_THERMAL_VECTOR
> > diff --git a/drivers/thermal/intel/Makefile
> > b/drivers/thermal/intel/Makefile
> > index 9a8d8054f316..5d8833c82ab6 100644
> > --- a/drivers/thermal/intel/Makefile
> > +++ b/drivers/thermal/intel/Makefile
> > @@ -2,6 +2,7 @@
> >  #
> >  # Makefile for various Intel thermal drivers.
> > 
> > +obj-$(CONFIG_INTEL_TCC)        += intel_tcc.o
> >  obj-$(CONFIG_INTEL_POWERCLAMP) += intel_powerclamp.o
> >  obj-$(CONFIG_X86_PKG_TEMP_THERMAL)     += x86_pkg_temp_thermal.o
> >  obj-$(CONFIG_INTEL_SOC_DTS_IOSF_CORE)  += intel_soc_dts_iosf.o
> > diff --git a/drivers/thermal/intel/intel_tcc.c
> > b/drivers/thermal/intel/intel_tcc.c
> > new file mode 100644
> > index 000000000000..74b434914975
> > --- /dev/null
> > +++ b/drivers/thermal/intel/intel_tcc.c
> > @@ -0,0 +1,131 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * intel_tcc.c - Library for Intel TCC (thermal control circuitry)
> > MSR access
> > + * Copyright (c) 2022, Intel Corporation.
> > + */
> > +
> > +#include <linux/errno.h>
> > +#include <linux/intel_tcc.h>
> > +#include <asm/msr.h>
> > +
> > +/**
> > + * intel_tcc_get_tjmax() - returns the default TCC activation
> > Temperature
> > + * @cpu: cpu that the MSR should be run on.
> > + * @tjmax: a valid pointer to where to store the Tjmax value
> > + *
> > + * Get the TjMax value, which is the default thermal throttling or
> > TCC
> > + * activation temperature in degrees C.
> > + *
> > + * Return: On success returns 0, an error code otherwise
> > + */
> > +
> 
> This extra empty line is not needed (and not desirable even).  And
> same below.

Sure. will remove it.
> 
> > +int intel_tcc_get_tjmax(int cpu, int *tjmax)
> > +{
> > +       u32 eax, edx;
> > +       int err;
> > +
> > +       err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET,
> > +                                       &eax, &edx);
> 
> The current trend is to align the arguments after a line break with
> the first one, but I would just put them all on the same line (and
> below too).

I agree putting them in the same line looks prettier.

> 
> > +       if (err)
> > +               return err;
> > +
> > +       *tjmax = (eax >> 16) & 0xff;
> 
> This means that the tjmax value cannot be negative.
> 
> > +
> > +       return *tjmax ? 0 : -EINVAL;
> 
> So the return value of this function could be tjmax if positive or a
> negative error code otherwise.  No return pointers needed.

I tried both. And I think I chose this solution just because it makes
the following cleanup patches in this series looks prettier.

I will try your suggestion, and if there is any other reason I wrote it
in this way, I will find it out again. :p

> 
> And why do you want to return -EINVAL (rather than any other error
> code) if tjmax turns out to be 0?

Because x86_pkg_temp_thermal driver returns -EINVAL previously.
Any suggestions on this?

> > +}
> > +EXPORT_SYMBOL_NS_GPL(intel_tcc_get_tjmax, INTEL_TCC);
> > +
> > +/**
> > + * intel_tcc_get_offset() - returns the TCC Offset value to Tjmax
> > + * @cpu: cpu that the MSR should be run on.
> > + * @offset: a valid pointer to where to store the offset value
> > + *
> > + * Get the TCC offset value to Tjmax. The effective thermal
> > throttling or TCC
> > + * activation temperature equals "Tjmax" - "TCC Offset", in
> > degrees C.
> > + *
> > + * Return: On success returns 0, an error code otherwise
> > + */
> > +
> > +int intel_tcc_get_offset(int cpu, int *offset)
> > +{
> > +       u32 eax, edx;
> > +       int err;
> > +
> > +       err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET,
> > +                                       &eax, &edx);
> > +       if (err)
> > +               return err;
> > +
> > +       *offset = (eax >> 24) & 0x3f;
> 
> Well, offset cannot be negative here, so (again) the return value of
> this function could be interpreted as the offsent (if non-negative)
> or
> a negative error code on failure.
> 
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(intel_tcc_get_offset, INTEL_TCC);
> > +
> > +/**
> > + * intel_tcc_set_offset() - set the TCC offset value to Tjmax
> > + * @cpu: cpu that the MSR should be run on.
> > + * @offset: TCC offset value in degree C
> 
> I think that this cannot be negative, so maybe say "in K" instead of
> "in degree C"?

degree C is the unit used in the Intel SDM, so better to keep this
comment aligned.

> 
> And maybe it's better to pass u8 here?

sounds good, will do in next version.

> 
> > + *
> > + * Set the TCC Offset value to Tjmax. The effective thermal
> > throttling or TCC
> > + * activation temperature equals "Tjmax" - "TCC Offset", in degree
> > C.
> > + *
> > + * Return: On success returns 0, an error code otherwise
> > + */
> > +
> > +int intel_tcc_set_offset(int cpu, int offset)
> > +{
> > +       u32 eax, edx;
> > +       int err;
> > +
> > +       if (offset > 0x3f)
> > +               return -EINVAL;
> > +
> > +       err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET,
> > +                                       &eax, &edx);
> > +       if (err)
> > +               return err;
> > +
> > +       if (eax & BIT(31))
> > +               return -EPERM;
> 
> Why -EPERM?

Bit 31 set means the MSR is locked, and os software cannot write it.
should I use -EACCES instead?

> 
> > +
> > +       eax &= ~(0x3f << 24);
> > +       eax |= (offset << 24);
> 
> The parens are not needed AFAICS.
> 
Agreed.

> > +
> > +       return wrmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET,
> > eax, edx);
> 
> So is any protection against concurrent access needed here?  Like
> what
> if two different callers invoke this function at the same time for
> the
> same CPU?

Given that the tcc offset is the only field that kernel code writes,
all the other bits won't change, so this is not a problem.

> 
> > +}
> > +EXPORT_SYMBOL_NS_GPL(intel_tcc_set_offset, INTEL_TCC);
> > +
> > +/**
> > + * intel_tcc_get_temp() - returns the current temperature
> > + * @cpu: cpu that the MSR should be run on.
> > + * @pkg: true: Package Thermal Sensor. false: Core Thermal Sensor.
> > + * @temp: a valid pointer to where to store the resulting
> > temperature
> > + *
> > + * Get the current temperature returned by the CPU core/package
> > level
> > + * thermal sensor, in degrees C.
> > + *
> > + * Return: On success returns 0, an error code otherwise
> > + */
> > +int intel_tcc_get_temp(int cpu, bool pkg, int *temp)
> > +{
> > +       u32 eax, edx;
> > +       u32 msr = pkg ? MSR_IA32_PACKAGE_THERM_STATUS :
> > MSR_IA32_THERM_STATUS;
> > +       int tjmax, err;
> > +
> > +       err = intel_tcc_get_tjmax(cpu, &tjmax);
> > +       if (err)
> > +               return err;
> 
> Well, what if somebody change tjmax on this cpu while this function
> is running?

tjmax is read only. Only firmware can change its value at runtime, say
this field is updated when SST-PP level is changed.

thanks,
rui
> 
> > +
> > +       err = rdmsr_safe_on_cpu(cpu, msr, &eax, &edx);
> > +       if (err)
> > +               return err;
> > +
> > +       if (eax & 0x80000000) {
> > +               *temp = tjmax - ((eax >> 16) & 0x7f);
> > +               return 0;
> > +       }
> > +       return -EINVAL;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(intel_tcc_get_temp, INTEL_TCC);
> > +
> > diff --git a/include/linux/intel_tcc.h b/include/linux/intel_tcc.h
> > new file mode 100644
> > index 000000000000..94f8ceab5dd0
> > --- /dev/null
> > +++ b/include/linux/intel_tcc.h
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + *  header for Intel TCC (thermal control circuitry) library
> > + *
> > + *  Copyright (C) 2022  Intel Corporation.
> > + */
> > +
> > +#ifndef __INTEL_TCC_H__
> > +#define __INTEL_TCC_H__
> > +
> > +#include <linux/types.h>
> > +
> > +int intel_tcc_get_tjmax(int cpu, int *tjmax);
> > +int intel_tcc_get_offset(int cpu, int *offset);
> > +int intel_tcc_set_offset(int cpu, int offset);
> > +int intel_tcc_get_temp(int cpu, bool pkg, int *temp);
> > +
> > +#endif /* __INTEL_TCC_H__ */
> > --

