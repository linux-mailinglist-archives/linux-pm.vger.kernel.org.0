Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB276482CD
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 14:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiLINdF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 08:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLINdE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 08:33:04 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90F31C925
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 05:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670592773; x=1702128773;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KrBHiuS4qk3yA9BhTeW61+O4/x4QsFPWF0vLm4QwNbI=;
  b=G+JAh7P59XW1+IqcElH4BkSQEIVWI1F3P/grEtmGkg6KVzAJ3Huqw1iw
   g+Ydq+FpyguRS7LwrAms4QAiC3GU0b1VW2VUc1E8AbpsdZo2OnHFJreTn
   a1hWa8NNy4pu2d/nPtxfovt5VzKq+CzMBmXCKJkl04dNWvKq5p0hXdRO5
   lalbwrEvPCgNkwUnSVcVyM/nhgw8+/qtut1ZwCU1dt45c/ViIFZtYuj1p
   NgFZ99C7mCVwJj4mtk+hky0/U8M6ziIeK/cQLOddPQXl9GnO2MHJluhj6
   SIpM+tR7nROqbjX5lZp9IGhCk/oHWvn8VJgn1t/RdA4T3LZ5VqyM073MP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="300879320"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="300879320"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 05:32:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="625115496"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="625115496"
Received: from zhiyongy-mobl.gar.corp.intel.com ([10.249.169.157])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 05:32:48 -0800
Message-ID: <015c7c006b0bbe935a31c837ed0fc5da9d7e43cd.camel@intel.com>
Subject: Re: [PATCH 1/6] thermal/intel: Introduce Intel TCC library
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Date:   Fri, 09 Dec 2022 21:32:43 +0800
In-Reply-To: <CAJZ5v0gFMewt-paH4D3sDpgUSAfGJojGHOdUxXH9ahSHA6P7+Q@mail.gmail.com>
References: <20221108033332.27760-1-rui.zhang@intel.com>
         <20221108033332.27760-2-rui.zhang@intel.com>
         <CAJZ5v0hOzCRnoH52EEMZm+CRDNKSYg2iZax2CnowzdMXjX8QYA@mail.gmail.com>
         <c827d96fcf50a39ebd219cd09d9b4bd1db2f0398.camel@intel.com>
         <CAJZ5v0gFMewt-paH4D3sDpgUSAfGJojGHOdUxXH9ahSHA6P7+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> > > 
> > > > +
> > > > +       return *tjmax ? 0 : -EINVAL;
> > > 
> > > So the return value of this function could be tjmax if positive
> > > or a
> > > negative error code otherwise.  No return pointers needed.
> > 
> > I tried both. And I think I chose this solution just because it
> > makes
> > the following cleanup patches in this series looks prettier.
> > 
> > I will try your suggestion, and if there is any other reason I
> > wrote it
> > in this way, I will find it out again. :p
> > 
> > > And why do you want to return -EINVAL (rather than any other
> > > error
> > > code) if tjmax turns out to be 0?
> > 
> > Because x86_pkg_temp_thermal driver returns -EINVAL previously.
> > Any suggestions on this?
> 
> I would use -ENODATA.

Sure, will do.

> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(intel_tcc_set_offset, INTEL_TCC);
> > > > +
> > > > +/**
> > > > + * intel_tcc_get_temp() - returns the current temperature
> > > > + * @cpu: cpu that the MSR should be run on.
> > > > + * @pkg: true: Package Thermal Sensor. false: Core Thermal
> > > > Sensor.
> > > > + * @temp: a valid pointer to where to store the resulting
> > > > temperature
> > > > + *
> > > > + * Get the current temperature returned by the CPU
> > > > core/package
> > > > level
> > > > + * thermal sensor, in degrees C.
> > > > + *
> > > > + * Return: On success returns 0, an error code otherwise
> > > > + */
> > > > +int intel_tcc_get_temp(int cpu, bool pkg, int *temp)
> > > > +{
> > > > +       u32 eax, edx;
> > > > +       u32 msr = pkg ? MSR_IA32_PACKAGE_THERM_STATUS :
> > > > MSR_IA32_THERM_STATUS;
> > > > +       int tjmax, err;
> > > > +
> > > > +       err = intel_tcc_get_tjmax(cpu, &tjmax);
> > > > +       if (err)
> > > > +               return err;
> > > 
> > > Well, what if somebody change tjmax on this cpu while this
> > > function
> > > is running?
> > 
> > tjmax is read only. Only firmware can change its value at runtime,
> > say
> > this field is updated when SST-PP level is changed.
> 
> Do we get any type of notification on tjmax changes, or do we need to
> poll for it?

I'm not aware of such a notification.
Srinivas, do you know if there is one?

thanks,
rui


