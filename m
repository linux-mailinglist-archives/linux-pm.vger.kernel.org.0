Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C213735B596
	for <lists+linux-pm@lfdr.de>; Sun, 11 Apr 2021 16:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhDKOKL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Apr 2021 10:10:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:47659 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235407AbhDKOKK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 11 Apr 2021 10:10:10 -0400
IronPort-SDR: UwakNE6MAzXbKForf4pCxUlpH8zWnzIU9okdHvCCiMf2F/JgUOP90QxxLst/riEtTOG1ozzY4t
 YPmbeGn9KIvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="181160627"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="181160627"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 07:09:52 -0700
IronPort-SDR: I7zlx+wuWsefyCXsX6iqeqy+4N13YuYt62IZ7TDa11ln4lSYYMbbPv9mWwWBhNDeIMKNE1Kc2Y
 BdlhdkwqVhDg==
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="423440473"
Received: from xumingcu-mobl.ccr.corp.intel.com ([10.249.169.220])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 07:09:50 -0700
Message-ID: <51542423fbea44257e52cf3fdf879a891b53b951.camel@intel.com>
Subject: Re: [PATCH] tools/power/x86/turbostat: Fix TCC offset bit mask
From:   Zhang Rui <rui.zhang@intel.com>
To:     Doug Smythies <dsmythies@telus.net>, Len Brown <lenb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Date:   Sun, 11 Apr 2021 22:09:47 +0800
In-Reply-To: <CAAYoRsXX74eDQ_vCdLnyNQhMutwE4TWMZsB7HeW5tu4kxVEFJQ@mail.gmail.com>
References: <20210116170725.5245-1-dsmythies@telus.net>
         <CAJvTdKm3h_msmu-NjTPY+09bLqyVL_-GCHnGFdNGdTcSZRP4zQ@mail.gmail.com>
         <CAAYoRsVYejQRByDz78jbv5cMfd+ctT8N3YxfOBndW8FJiuk9MA@mail.gmail.com>
         <CAJvTdKkpbFqDRL9BP3Ri0Yeb0VMXv79dr+C=ym2+GWMRZEEYpw@mail.gmail.com>
         <CAAYoRsXX74eDQ_vCdLnyNQhMutwE4TWMZsB7HeW5tu4kxVEFJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 2021-03-13 at 07:16 -0800, Doug Smythies wrote:
> On Fri, Mar 12, 2021 at 2:16 PM Len Brown <lenb@kernel.org> wrote:
> > 
> > Doug,
> > The offset works for control.
> > 
> > However, it is erroneous to use it for reporting of the actual
> > temperature, like I did in turbostat.
> 
> Agreed.
> I have been running with a correction for that for a while,
> and as discussed on Rui's thread.
> But this bit mask correction patch is still needed isn't it?
> for this:
> cpu4: MSR_IA32_TEMPERATURE_TARGET: 0x1a64100d (90 C) (100 default -
> 10 offset)
> which should be this:
> cpu4: MSR_IA32_TEMPERATURE_TARGET: 0x1a64100d (74 C) (100 default -
> 26 offset)
> 
> But yes, I do now see the field size is only 4 bits for some parts.

As this is CPU specific, and we don't know which is which for all the
CPUs, so it seems that we can have a white list for the ones that we
care and have been verified.

For the others, by default, we only show the raw value and default TCC
activation temperature, like

cpu4: MSR_IA32_TEMPERATURE_TARGET: 0x1a64100d (100 default )

And this white list can be updated together with the one in the kernel
tcc_offset_cooling driver.

what do you think?

thanks,
rui



> 
> ... Doug
> 
> > Thus, I'm going to revert the patch that added it's use in
> > turbostat
> > for the Temperature column.
> > 
> > thanks,
> > -Len
> > 
> > On Fri, Mar 12, 2021 at 1:26 AM Doug Smythies <dsmythies@telus.net>
> > wrote:
> > > 
> > > Hi Len,
> > > 
> > > 
> > > thank you for your reply.
> > > 
> > > On Thu, Mar 11, 2021 at 3:19 PM Len Brown <lenb@kernel.org>
> > > wrote:
> > > > 
> > > > Thanks for the close read, Doug.
> > > > 
> > > > This field size actually varies from system to system,
> > > > but the reality is that the offset is never that big, and so
> > > > the
> > > > smaller mask is sufficient.
> > > 
> > > Disagree.
> > > 
> > > I want to use an offset of 26.
> > > 
> > > > Finally, this may all be moot, because there is discussion that
> > > > using
> > > > the offset this way is simply erroneous.
> > > 
> > > Disagree.
> > > It works great.
> > > As far as I know/recall I was the only person that responded to
> > > Rui's thread
> > > "thermal/intel: introduce tcc cooling driver" [1]
> > > And, I spent quite a bit of time doing so.
> > > However, I agree the response seems different between the two
> > > systems
> > > under test, Rui's and mine.
> > > 
> > > [1] https://marc.info/?l=linux-pm&m=161070345329806&w=2
> > > 
> > > >  stay tuned.
> > > 
> > > O.K.
> > > 
> > > ... Doug
> > > > 
> > > > -Len
> > > > 
> > > > 
> > > > On Sat, Jan 16, 2021 at 12:07 PM Doug Smythies <
> > > > doug.smythies@gmail.com> wrote:
> > > > > 
> > > > > The TCC offset mask is incorrect, resulting in
> > > > > incorrect target temperature calculations, if
> > > > > the offset is big enough to exceed the mask size.
> > > > > 
> > > > > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> > > > > ---
> > > > >  tools/power/x86/turbostat/turbostat.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/tools/power/x86/turbostat/turbostat.c
> > > > > b/tools/power/x86/turbostat/turbostat.c
> > > > > index 389ea5209a83..d7acdd4d16c4 100644
> > > > > --- a/tools/power/x86/turbostat/turbostat.c
> > > > > +++ b/tools/power/x86/turbostat/turbostat.c
> > > > > @@ -4823,7 +4823,7 @@ int read_tcc_activation_temp()
> > > > > 
> > > > >         target_c = (msr >> 16) & 0xFF;
> > > > > 
> > > > > -       offset_c = (msr >> 24) & 0xF;
> > > > > +       offset_c = (msr >> 24) & 0x3F;
> > > > > 
> > > > >         tcc = target_c - offset_c;
> > > > > 
> > > > > --
> > > > > 2.25.1
> > > > > 
> > > > 
> > > > 
> > > > --
> > > > Len Brown, Intel Open Source Technology Center
> > 
> > 
> > 
> > --
> > Len Brown, Intel Open Source Technology Center

