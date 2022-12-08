Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15656474CA
	for <lists+linux-pm@lfdr.de>; Thu,  8 Dec 2022 18:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLHRBD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Dec 2022 12:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLHRBB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Dec 2022 12:01:01 -0500
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBAA73F4D
        for <linux-pm@vger.kernel.org>; Thu,  8 Dec 2022 09:00:59 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id o12so1352945qvn.3
        for <linux-pm@vger.kernel.org>; Thu, 08 Dec 2022 09:00:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZnpRRUvtT9FXAJg0Q4UnH1CiKi5D1gX1FVb4blEE04=;
        b=nhYZ9Ju/IltlbitDy+7nqQU3kFnMQoRq2YQPypcT2NuCzw39RE51Wj0G4/5umqnXNC
         0yUaBCmQuM9vb29S98xNc88ch00qpdzJztWIT7iYYekG51HerPiHiiZE3ylrL4PRC3ug
         QA/fG0XSQwSrNcpj9QQEMPiG2mfYcv94YLuxVJdl0uDWzno3h5sakPLKY08qtPBCh9dW
         UKm1/LH+olqMhlJua45V9Q25nFuVvOknjKHRKzR2fTvnkILrFfq/j4lsPYikMptuL8XM
         2Xpq80MLxlJjKPueFKB3pxqxM2oGgQCPhDkQCvEGvmzK6zRUiGkxFc7elyIVVevuHVCR
         zlEQ==
X-Gm-Message-State: ANoB5pmK0zXKSrXeU/MMHg/jwz44UQrRC0TUqqlGAM4iqbdUAwkTebU5
        lrSzitIlF5yqRgkb6AZ/6fzFiAdTnkcqqYRhrmk=
X-Google-Smtp-Source: AA0mqf5c0xRhd8FQ+g0l9806txVsOUI59ilWi9h4wG+9R4to18B4UxLpWgunXgIRpMwK3SQ+at+C13Xh/NgcAAb80uk=
X-Received: by 2002:a0c:c589:0:b0:4b1:a9ac:21de with SMTP id
 a9-20020a0cc589000000b004b1a9ac21demr67365066qvj.119.1670518857941; Thu, 08
 Dec 2022 09:00:57 -0800 (PST)
MIME-Version: 1.0
References: <20221108033332.27760-1-rui.zhang@intel.com> <20221108033332.27760-2-rui.zhang@intel.com>
 <CAJZ5v0hOzCRnoH52EEMZm+CRDNKSYg2iZax2CnowzdMXjX8QYA@mail.gmail.com> <c827d96fcf50a39ebd219cd09d9b4bd1db2f0398.camel@intel.com>
In-Reply-To: <c827d96fcf50a39ebd219cd09d9b4bd1db2f0398.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Dec 2022 18:00:46 +0100
Message-ID: <CAJZ5v0gFMewt-paH4D3sDpgUSAfGJojGHOdUxXH9ahSHA6P7+Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] thermal/intel: Introduce Intel TCC library
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 8, 2022 at 5:49 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On Thu, 2022-12-08 at 14:49 +0100, Rafael J. Wysocki wrote:
> > On Tue, Nov 8, 2022 at 4:31 AM Zhang Rui <rui.zhang@intel.com> wrote:
> > > There are several different drivers that accesses the Intel TCC
> > > (thermal control circuitry) MSRs, and each of them has its own
> > > implementation for the same functionalities, e.g. getting the
> > > current
> > > temperature, getting the tj_max, and getting/setting the tj_max
> > > offset.
> > >
> > > Introduce a library to unify the code for Intel CPU TCC MSR access.
> > >
> > > At the same time, ensure the temperature is got based on the
> > > updated
> > > tjmax value because tjmax can be changed at runtime for cases like
> > > the Intel SST-PP (Intel Speed Select Technology - Performance
> > > Profile)
> > > level change.
> > >
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> >
> > Nice series, overall I like it a lot, but I have some comments
> > regarding this particular patch (below).  Some of them are arguably
> > minor, but at least one thing is more serious.
>
> Hi, Rafael,
>
> Thanks for reviewing the patch set.
> >
> > > ---
> > >  drivers/thermal/intel/Kconfig     |   4 +
> > >  drivers/thermal/intel/Makefile    |   1 +
> > >  drivers/thermal/intel/intel_tcc.c | 131
> > > ++++++++++++++++++++++++++++++
> > >  include/linux/intel_tcc.h         |  18 ++++
> > >  4 files changed, 154 insertions(+)
> > >  create mode 100644 drivers/thermal/intel/intel_tcc.c
> > >  create mode 100644 include/linux/intel_tcc.h
> > >
> > > diff --git a/drivers/thermal/intel/Kconfig
> > > b/drivers/thermal/intel/Kconfig
> > > index f0c845679250..6b938c040d6e 100644
> > > --- a/drivers/thermal/intel/Kconfig
> > > +++ b/drivers/thermal/intel/Kconfig
> > > @@ -12,6 +12,10 @@ config X86_THERMAL_VECTOR
> > >         def_bool y
> > >         depends on X86 && CPU_SUP_INTEL && X86_LOCAL_APIC
> > >
> > > +config INTEL_TCC
> > > +       bool
> > > +       depends on X86
> > > +
> > >  config X86_PKG_TEMP_THERMAL
> > >         tristate "X86 package temperature thermal driver"
> > >         depends on X86_THERMAL_VECTOR
> > > diff --git a/drivers/thermal/intel/Makefile
> > > b/drivers/thermal/intel/Makefile
> > > index 9a8d8054f316..5d8833c82ab6 100644
> > > --- a/drivers/thermal/intel/Makefile
> > > +++ b/drivers/thermal/intel/Makefile
> > > @@ -2,6 +2,7 @@
> > >  #
> > >  # Makefile for various Intel thermal drivers.
> > >
> > > +obj-$(CONFIG_INTEL_TCC)        += intel_tcc.o
> > >  obj-$(CONFIG_INTEL_POWERCLAMP) += intel_powerclamp.o
> > >  obj-$(CONFIG_X86_PKG_TEMP_THERMAL)     += x86_pkg_temp_thermal.o
> > >  obj-$(CONFIG_INTEL_SOC_DTS_IOSF_CORE)  += intel_soc_dts_iosf.o
> > > diff --git a/drivers/thermal/intel/intel_tcc.c
> > > b/drivers/thermal/intel/intel_tcc.c
> > > new file mode 100644
> > > index 000000000000..74b434914975
> > > --- /dev/null
> > > +++ b/drivers/thermal/intel/intel_tcc.c
> > > @@ -0,0 +1,131 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * intel_tcc.c - Library for Intel TCC (thermal control circuitry)
> > > MSR access
> > > + * Copyright (c) 2022, Intel Corporation.
> > > + */
> > > +
> > > +#include <linux/errno.h>
> > > +#include <linux/intel_tcc.h>
> > > +#include <asm/msr.h>
> > > +
> > > +/**
> > > + * intel_tcc_get_tjmax() - returns the default TCC activation
> > > Temperature
> > > + * @cpu: cpu that the MSR should be run on.
> > > + * @tjmax: a valid pointer to where to store the Tjmax value
> > > + *
> > > + * Get the TjMax value, which is the default thermal throttling or
> > > TCC
> > > + * activation temperature in degrees C.
> > > + *
> > > + * Return: On success returns 0, an error code otherwise
> > > + */
> > > +
> >
> > This extra empty line is not needed (and not desirable even).  And
> > same below.
>
> Sure. will remove it.
> >
> > > +int intel_tcc_get_tjmax(int cpu, int *tjmax)
> > > +{
> > > +       u32 eax, edx;
> > > +       int err;
> > > +
> > > +       err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET,
> > > +                                       &eax, &edx);
> >
> > The current trend is to align the arguments after a line break with
> > the first one, but I would just put them all on the same line (and
> > below too).
>
> I agree putting them in the same line looks prettier.
>
> >
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       *tjmax = (eax >> 16) & 0xff;
> >
> > This means that the tjmax value cannot be negative.
> >
> > > +
> > > +       return *tjmax ? 0 : -EINVAL;
> >
> > So the return value of this function could be tjmax if positive or a
> > negative error code otherwise.  No return pointers needed.
>
> I tried both. And I think I chose this solution just because it makes
> the following cleanup patches in this series looks prettier.
>
> I will try your suggestion, and if there is any other reason I wrote it
> in this way, I will find it out again. :p
>
> >
> > And why do you want to return -EINVAL (rather than any other error
> > code) if tjmax turns out to be 0?
>
> Because x86_pkg_temp_thermal driver returns -EINVAL previously.
> Any suggestions on this?

I would use -ENODATA.

> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(intel_tcc_get_tjmax, INTEL_TCC);
> > > +
> > > +/**
> > > + * intel_tcc_get_offset() - returns the TCC Offset value to Tjmax
> > > + * @cpu: cpu that the MSR should be run on.
> > > + * @offset: a valid pointer to where to store the offset value
> > > + *
> > > + * Get the TCC offset value to Tjmax. The effective thermal
> > > throttling or TCC
> > > + * activation temperature equals "Tjmax" - "TCC Offset", in
> > > degrees C.
> > > + *
> > > + * Return: On success returns 0, an error code otherwise
> > > + */
> > > +
> > > +int intel_tcc_get_offset(int cpu, int *offset)
> > > +{
> > > +       u32 eax, edx;
> > > +       int err;
> > > +
> > > +       err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET,
> > > +                                       &eax, &edx);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       *offset = (eax >> 24) & 0x3f;
> >
> > Well, offset cannot be negative here, so (again) the return value of
> > this function could be interpreted as the offsent (if non-negative)
> > or
> > a negative error code on failure.
> >
> > > +
> > > +       return 0;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(intel_tcc_get_offset, INTEL_TCC);
> > > +
> > > +/**
> > > + * intel_tcc_set_offset() - set the TCC offset value to Tjmax
> > > + * @cpu: cpu that the MSR should be run on.
> > > + * @offset: TCC offset value in degree C
> >
> > I think that this cannot be negative, so maybe say "in K" instead of
> > "in degree C"?
>
> degree C is the unit used in the Intel SDM, so better to keep this
> comment aligned.

OK

> >
> > And maybe it's better to pass u8 here?
>
> sounds good, will do in next version.
>
> >
> > > + *
> > > + * Set the TCC Offset value to Tjmax. The effective thermal
> > > throttling or TCC
> > > + * activation temperature equals "Tjmax" - "TCC Offset", in degree
> > > C.
> > > + *
> > > + * Return: On success returns 0, an error code otherwise
> > > + */
> > > +
> > > +int intel_tcc_set_offset(int cpu, int offset)
> > > +{
> > > +       u32 eax, edx;
> > > +       int err;
> > > +
> > > +       if (offset > 0x3f)
> > > +               return -EINVAL;
> > > +
> > > +       err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET,
> > > +                                       &eax, &edx);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       if (eax & BIT(31))
> > > +               return -EPERM;
> >
> > Why -EPERM?
>
> Bit 31 set means the MSR is locked, and os software cannot write it.
> should I use -EACCES instead?

No, -EPERM is fine in this case, but a short comment would be useful.

> >
> > > +
> > > +       eax &= ~(0x3f << 24);
> > > +       eax |= (offset << 24);
> >
> > The parens are not needed AFAICS.
> >
> Agreed.
>
> > > +
> > > +       return wrmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET,
> > > eax, edx);
> >
> > So is any protection against concurrent access needed here?  Like
> > what
> > if two different callers invoke this function at the same time for
> > the
> > same CPU?
>
> Given that the tcc offset is the only field that kernel code writes,
> all the other bits won't change, so this is not a problem.

OK

> >
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(intel_tcc_set_offset, INTEL_TCC);
> > > +
> > > +/**
> > > + * intel_tcc_get_temp() - returns the current temperature
> > > + * @cpu: cpu that the MSR should be run on.
> > > + * @pkg: true: Package Thermal Sensor. false: Core Thermal Sensor.
> > > + * @temp: a valid pointer to where to store the resulting
> > > temperature
> > > + *
> > > + * Get the current temperature returned by the CPU core/package
> > > level
> > > + * thermal sensor, in degrees C.
> > > + *
> > > + * Return: On success returns 0, an error code otherwise
> > > + */
> > > +int intel_tcc_get_temp(int cpu, bool pkg, int *temp)
> > > +{
> > > +       u32 eax, edx;
> > > +       u32 msr = pkg ? MSR_IA32_PACKAGE_THERM_STATUS :
> > > MSR_IA32_THERM_STATUS;
> > > +       int tjmax, err;
> > > +
> > > +       err = intel_tcc_get_tjmax(cpu, &tjmax);
> > > +       if (err)
> > > +               return err;
> >
> > Well, what if somebody change tjmax on this cpu while this function
> > is running?
>
> tjmax is read only. Only firmware can change its value at runtime, say
> this field is updated when SST-PP level is changed.

Do we get any type of notification on tjmax changes, or do we need to
poll for it?
