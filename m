Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A0B649311
	for <lists+linux-pm@lfdr.de>; Sun, 11 Dec 2022 08:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiLKHYE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Dec 2022 02:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLKHYD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Dec 2022 02:24:03 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FFA1209F
        for <linux-pm@vger.kernel.org>; Sat, 10 Dec 2022 23:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670743439; x=1702279439;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S2GdPNkTTWvBRzYVmjQkQA9UjLpvqvak8n/l1HyK2ek=;
  b=UNAUcRdvLr2Ufkmduy3ov7zN8PnpWvZBqjtmif9U073Rcke8zQuq8AHY
   47CJjvgq/LrjJXzivNyOChTOk3JQFnHKHGOYIRHptl+eGYH9/SuDbknSW
   W0ZICp3MijZaeyI2JUVz3cl3i8cyHdBa80UiAbxJKQEl84jmwoW0KvL8r
   ED/njV29rBgivZYtlTll7bET4AzHg9AdZynpVMJuEJeFifJKEfmU1qC8D
   AzxB2mSaq0p2/I15N1nLLShWKgYjXyTt784Q774x4koPMmLn+IjiBI+uM
   FqYb/eaX0gnB9m+wYeag/cUq77KkJOK/lkBZi5gspKD/dhavu2MeVDrSa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="403932157"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="403932157"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 23:23:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="736617072"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="736617072"
Received: from zhenzhu-mobl1.ccr.corp.intel.com ([10.255.30.120])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 23:23:56 -0800
Message-ID: <b40f141c0266b6971f8dec0e63964dd1311b1747.camel@intel.com>
Subject: Re: [PATCH 1/6] thermal/intel: Introduce Intel TCC library
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Date:   Sun, 11 Dec 2022 15:23:54 +0800
In-Reply-To: <c827d96fcf50a39ebd219cd09d9b4bd1db2f0398.camel@intel.com>
References: <20221108033332.27760-1-rui.zhang@intel.com>
         <20221108033332.27760-2-rui.zhang@intel.com>
         <CAJZ5v0hOzCRnoH52EEMZm+CRDNKSYg2iZax2CnowzdMXjX8QYA@mail.gmail.com>
         <c827d96fcf50a39ebd219cd09d9b4bd1db2f0398.camel@intel.com>
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
> > So the return value of this function could be tjmax if positive or
> > a
> > negative error code otherwise.  No return pointers needed.
> 
> I tried both. And I think I chose this solution just because it makes
> the following cleanup patches in this series looks prettier.
> 
> I will try your suggestion, and if there is any other reason I wrote
> it
> in this way, I will find it out again. :p

I see.
Say, we have to use

intel_tcc_get_temp(int cpu, int *temp)

so I keep the same format for all the intel_tcc_get_XXX APIs

intel_tcc_get_tjmax(int cpu, int *tjmax)
intel_tcc_get_offset(int cpu, int *offset)

so that the return value is decoded in the same way. This helps avoid
return value check mistakes for the callers.

surely I can remove the return pointer if you still prefer that. :p

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
> > I think that this cannot be negative, so maybe say "in K" instead
> > of
> > "in degree C"?
> 
> degree C is the unit used in the Intel SDM, so better to keep this
> comment aligned.
> 
> > And maybe it's better to pass u8 here?
> 
> sounds good, will do in next version.
> 
to keep consistent, we can use either
int intel_tcc_get_offset(int cpu)
int intel_tcc_set_offset(int cpu, int offset)
or
int intel_tcc_get_offset(int cpu, u8 *offset)
int intel_tcc_set_offset(int cpu, u8 offset)

or else callers need to declare 'offset' but with different type, when
getting and setting it, which looks strange.

thanks,
rui
> > > + *
> > > + * Set the TCC Offset value to Tjmax. The effective thermal
> > > throttling or TCC
> > > + * activation temperature equals "Tjmax" - "TCC Offset", in
> > > degree
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
> 
> > > +
> > > +       eax &= ~(0x3f << 24);
> > > +       eax |= (offset << 24);
> > 
> > The parens are not needed AFAICS.
> > 
> Agreed.
> 
> > > +
> > > +       return wrmsr_safe_on_cpu(cpu,
> > > MSR_IA32_TEMPERATURE_TARGET,
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
> 
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(intel_tcc_set_offset, INTEL_TCC);
> > > +
> > > +/**
> > > + * intel_tcc_get_temp() - returns the current temperature
> > > + * @cpu: cpu that the MSR should be run on.
> > > + * @pkg: true: Package Thermal Sensor. false: Core Thermal
> > > Sensor.
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
> tjmax is read only. Only firmware can change its value at runtime,
> say
> this field is updated when SST-PP level is changed.
> 
> thanks,
> rui
> > > +
> > > +       err = rdmsr_safe_on_cpu(cpu, msr, &eax, &edx);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       if (eax & 0x80000000) {
> > > +               *temp = tjmax - ((eax >> 16) & 0x7f);
> > > +               return 0;
> > > +       }
> > > +       return -EINVAL;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(intel_tcc_get_temp, INTEL_TCC);
> > > +
> > > diff --git a/include/linux/intel_tcc.h
> > > b/include/linux/intel_tcc.h
> > > new file mode 100644
> > > index 000000000000..94f8ceab5dd0
> > > --- /dev/null
> > > +++ b/include/linux/intel_tcc.h
> > > @@ -0,0 +1,18 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + *  header for Intel TCC (thermal control circuitry) library
> > > + *
> > > + *  Copyright (C) 2022  Intel Corporation.
> > > + */
> > > +
> > > +#ifndef __INTEL_TCC_H__
> > > +#define __INTEL_TCC_H__
> > > +
> > > +#include <linux/types.h>
> > > +
> > > +int intel_tcc_get_tjmax(int cpu, int *tjmax);
> > > +int intel_tcc_get_offset(int cpu, int *offset);
> > > +int intel_tcc_set_offset(int cpu, int offset);
> > > +int intel_tcc_get_temp(int cpu, bool pkg, int *temp);
> > > +
> > > +#endif /* __INTEL_TCC_H__ */
> > > --

