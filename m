Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7FB64AD33
	for <lists+linux-pm@lfdr.de>; Tue, 13 Dec 2022 02:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiLMBjC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Dec 2022 20:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbiLMBi1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2022 20:38:27 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E0E95A3
        for <linux-pm@vger.kernel.org>; Mon, 12 Dec 2022 17:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670895506; x=1702431506;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F4wPUPfxF5k+WMzEUncwFNzeTARJIlhOv/ZY9EGkYUo=;
  b=Ub0b/40gIVx7TJGG12nmn/Vy7xRK/Fxe+cuhsQ8ezGxVDWXcsmWKeoA3
   8wdRjlGwyPjBOV+BdSSksmrf2dx6lzXIixNluSlb3H3gaJmshx/G+01Wt
   qPtNJUGrITQdk3etiC5hmp3u6xGbH1r/VxdEE/KJ6+YLqQejZeyP9Zb8Y
   Jk1sjMk1EaGH/8t3cNJY2DweHnR2PkwrE4L116yzAwU1PBAVR8WTb8ljU
   QGLIUCIKq/Gddb9Ch8bgLhMxn2sGoYuh5b4a7t+4MEL11g8ywT4Af27gI
   Ie/AHVDLtvGf0zct7JVGSNZXMTgBvefCCtQg7SCv7FrbclVfshDQAld0n
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="382321090"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="382321090"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 17:38:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="680891075"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="680891075"
Received: from yujiedou-mobl1.ccr.corp.intel.com ([10.255.29.106])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 17:38:22 -0800
Message-ID: <10cae7a3db86278c39ecb8837ec000b054c51ebc.camel@intel.com>
Subject: Re: [PATCH 1/6] thermal/intel: Introduce Intel TCC library
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Date:   Tue, 13 Dec 2022 09:38:17 +0800
In-Reply-To: <CAJZ5v0j=x6ofgTFcoRw1bsoCbsbA7uAqQNddXVeXXOuwQzcNBQ@mail.gmail.com>
References: <20221108033332.27760-1-rui.zhang@intel.com>
         <20221108033332.27760-2-rui.zhang@intel.com>
         <CAJZ5v0hOzCRnoH52EEMZm+CRDNKSYg2iZax2CnowzdMXjX8QYA@mail.gmail.com>
         <c827d96fcf50a39ebd219cd09d9b4bd1db2f0398.camel@intel.com>
         <b40f141c0266b6971f8dec0e63964dd1311b1747.camel@intel.com>
         <CAJZ5v0j=x6ofgTFcoRw1bsoCbsbA7uAqQNddXVeXXOuwQzcNBQ@mail.gmail.com>
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

On Mon, 2022-12-12 at 13:11 +0100, Rafael J. Wysocki wrote:
> On Sun, Dec 11, 2022 at 8:24 AM Zhang Rui <rui.zhang@intel.com>
> wrote:
> > 
> > > > > +       if (err)
> > > > > +               return err;
> > > > > +
> > > > > +       *tjmax = (eax >> 16) & 0xff;
> > > > 
> > > > This means that the tjmax value cannot be negative.
> > > > 
> > > > > +
> > > > > +       return *tjmax ? 0 : -EINVAL;
> > > > 
> > > > So the return value of this function could be tjmax if positive
> > > > or
> > > > a
> > > > negative error code otherwise.  No return pointers needed.
> > > 
> > > I tried both. And I think I chose this solution just because it
> > > makes
> > > the following cleanup patches in this series looks prettier.
> > > 
> > > I will try your suggestion, and if there is any other reason I
> > > wrote
> > > it
> > > in this way, I will find it out again. :p
> > 
> > I see.
> > Say, we have to use
> > 
> > intel_tcc_get_temp(int cpu, int *temp)
> 
> Do we?

temp = tjmax - digital_readout

tjmax and digital_readout are from MSR and they are both positive
values, but temp can be negative in theory.
so are you suggesting that we should treat the negative CPU temperature
as an error because this won't happen in real world?

thanks,
rui

> 
> > so I keep the same format for all the intel_tcc_get_XXX APIs
> > 
> > intel_tcc_get_tjmax(int cpu, int *tjmax)
> > intel_tcc_get_offset(int cpu, int *offset)
> > 
> > so that the return value is decoded in the same way. This helps
> > avoid
> > return value check mistakes for the callers.
> > 
> > surely I can remove the return pointer if you still prefer that. :p
> 
> Using a function value directly is very much preferred unless there
> really are two values to return.
> 
> In these particular cases a negative return value can be clearly
> interpreted as an error condition, so using the return value directly
> is sufficient.
> 
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +EXPORT_SYMBOL_NS_GPL(intel_tcc_get_offset, INTEL_TCC);
> > > > > +
> > > > > +/**
> > > > > + * intel_tcc_set_offset() - set the TCC offset value to
> > > > > Tjmax
> > > > > + * @cpu: cpu that the MSR should be run on.
> > > > > + * @offset: TCC offset value in degree C
> > > > 
> > > > I think that this cannot be negative, so maybe say "in K"
> > > > instead
> > > > of
> > > > "in degree C"?
> > > 
> > > degree C is the unit used in the Intel SDM, so better to keep
> > > this
> > > comment aligned.
> > > 
> > > > And maybe it's better to pass u8 here?
> > > 
> > > sounds good, will do in next version.
> > > 
> > to keep consistent, we can use either
> > int intel_tcc_get_offset(int cpu)
> > int intel_tcc_set_offset(int cpu, int offset)
> 
> What about intel_tcc_set_offset(int cpu, u8 offset)?
> 
> > or
> > int intel_tcc_get_offset(int cpu, u8 *offset)
> > int intel_tcc_set_offset(int cpu, u8 offset)
> > 
> > or else callers need to declare 'offset' but with different type,
> > when
> > getting and setting it, which looks strange.
> 
> Well, one can surely pass an int as a u8 argument and assign a u8
> return value to an int variable.

