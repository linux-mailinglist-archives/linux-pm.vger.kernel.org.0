Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BAE64CDC6
	for <lists+linux-pm@lfdr.de>; Wed, 14 Dec 2022 17:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbiLNQPx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Dec 2022 11:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238547AbiLNQPx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Dec 2022 11:15:53 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921F8D6E
        for <linux-pm@vger.kernel.org>; Wed, 14 Dec 2022 08:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671034551; x=1702570551;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o35XzpiljWu0FhFYYvOsdC3jGqOcJHLLxDWiW78McRM=;
  b=g6IyzWNbCUJ6P3MhfPTmNcP7YCwr26oRNQ2fKuJBuv99pdO0g518/Wfo
   4E2ixGlVg9xVfkRA3Bb1r8e6XjnJxNJvpi+JVCxyErx6uuKaWzYjLGrHu
   EPi/U9z41uxbYKUrbjGiHq9cYcIfubD0yK7kdUS33gKK4nwrWVLgUdBs5
   qhQ50VnLpeeqGp03amRY5aqIrQipiQopXjpDxodgOanuSdLgCkW1s59W2
   r97awDZboJGW0Eyde5N96FsGWgzzqQ+2yq0du3laOKaNJViGQot7icF7s
   9GHSmcz8O6dyU43DGr0K9zellc3VmS6ZMeZ6GbppY9pAHaq13BsFi+1WS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="320304103"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="320304103"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 08:15:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="626787129"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="626787129"
Received: from fangshux-mobl.ccr.corp.intel.com ([10.249.168.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 08:15:46 -0800
Message-ID: <144b4c404eeaac1cf323ff3801d622d1beda3efc.camel@intel.com>
Subject: Re: [PATCH 1/6] thermal/intel: Introduce Intel TCC library
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Date:   Thu, 15 Dec 2022 00:15:43 +0800
In-Reply-To: <CAJZ5v0gscS-b+B-uqSFOVX=wA-gABP8f9n+oJ5WMZTRcrs66bQ@mail.gmail.com>
References: <20221108033332.27760-1-rui.zhang@intel.com>
         <20221108033332.27760-2-rui.zhang@intel.com>
         <CAJZ5v0hOzCRnoH52EEMZm+CRDNKSYg2iZax2CnowzdMXjX8QYA@mail.gmail.com>
         <c827d96fcf50a39ebd219cd09d9b4bd1db2f0398.camel@intel.com>
         <b40f141c0266b6971f8dec0e63964dd1311b1747.camel@intel.com>
         <CAJZ5v0j=x6ofgTFcoRw1bsoCbsbA7uAqQNddXVeXXOuwQzcNBQ@mail.gmail.com>
         <10cae7a3db86278c39ecb8837ec000b054c51ebc.camel@intel.com>
         <CAJZ5v0gscS-b+B-uqSFOVX=wA-gABP8f9n+oJ5WMZTRcrs66bQ@mail.gmail.com>
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

On Tue, 2022-12-13 at 16:34 +0100, Rafael J. Wysocki wrote:
> On Tue, Dec 13, 2022 at 2:38 AM Zhang Rui <rui.zhang@intel.com>
> wrote:
> > On Mon, 2022-12-12 at 13:11 +0100, Rafael J. Wysocki wrote:
> > > On Sun, Dec 11, 2022 at 8:24 AM Zhang Rui <rui.zhang@intel.com>
> > > wrote:
> > > > > > > +       if (err)
> > > > > > > +               return err;
> > > > > > > +
> > > > > > > +       *tjmax = (eax >> 16) & 0xff;
> > > > > > 
> > > > > > This means that the tjmax value cannot be negative.
> > > > > > 
> > > > > > > +
> > > > > > > +       return *tjmax ? 0 : -EINVAL;
> > > > > > 
> > > > > > So the return value of this function could be tjmax if
> > > > > > positive
> > > > > > or
> > > > > > a
> > > > > > negative error code otherwise.  No return pointers needed.
> > > > > 
> > > > > I tried both. And I think I chose this solution just because
> > > > > it
> > > > > makes
> > > > > the following cleanup patches in this series looks prettier.
> > > > > 
> > > > > I will try your suggestion, and if there is any other reason
> > > > > I
> > > > > wrote
> > > > > it
> > > > > in this way, I will find it out again. :p
> > > > 
> > > > I see.
> > > > Say, we have to use
> > > > 
> > > > intel_tcc_get_temp(int cpu, int *temp)
> > > 
> > > Do we?
> > 
> > temp = tjmax - digital_readout
> > 
> > tjmax and digital_readout are from MSR and they are both positive
> > values, but temp can be negative in theory.
> 
> I know, but is this ever expected to happen?
> 
> > so are you suggesting that we should treat the negative CPU
> > temperature
> > as an error because this won't happen in real world?
> 
> No.
> 
> If it's necessary to handle negative temperatures, an int is needed
> and the additional return value is useful.
> 
> Now there is also the question of what the callers will do with a
> negative temperature value.  Do they care?

Currently, all the callers are from sysfs attribute.
for userspace tools, at least thermald ignores negative CPU
temperature.
So I will return an error for negative temperature in next version.

thanks,
rui

