Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC7736944C
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 16:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhDWOA4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 10:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhDWOAz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Apr 2021 10:00:55 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7DDC06174A
        for <linux-pm@vger.kernel.org>; Fri, 23 Apr 2021 07:00:19 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id y136so17549196qkb.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Apr 2021 07:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=91ekDJXVgfwpLgSEU6EfScTLzN1EQxy8q++S/uFtrf8=;
        b=WQdJMPV+gF4pVn8tObs9agKPNPZOvDAB4/1Zr8qhOSC5bS516+EmOhVZ7pxYwOQ+rz
         DFEfBdHXJSTJAiPKkymKGTf8Xb+mLLHhjPWmZeQYwVbjYPotaVBZe+QEeWwCj/n0SRS4
         Jgi7LkTOW/TOx1YB2aDG5MxNTRyrlr4qJzIMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=91ekDJXVgfwpLgSEU6EfScTLzN1EQxy8q++S/uFtrf8=;
        b=kclvq2CqQyQKqtv216cxi0Knnq6wD7hYIehG+mcJruRk/uFn49mfRUJq1hxrR78k9S
         9gFfDglUPurQtZXcdMt37GjXGapq5Y4jWbdnIwLuv8NfOX4j3eEYqoNgmY/paeLEBwYW
         miU3WSgNcPn/cplMhAA3o8wO2qUw0Qn9+ZnGL2+zfeCQm6q/Q/3oUyX0P9zVmrBm4Ng5
         2nnPe9dVWkIEwxKck0PjHPc+LsFvenJCFT5pb0gqj59I0K/bWmqHTn+EjxUE0CEN2n69
         B0buY8LvlgwHJCtT0YpZMA765c4gTwgP7JMD7zH6Oin7e+38oP7Udpa8+TIxwegFwVOF
         ww2g==
X-Gm-Message-State: AOAM530RjOL1ipmo3dx5456NwuH46egUrsnBTCOm4vuWqpRkS1q91ANT
        7xPMAgk9GH/VrHkSRXmZx+GYOg==
X-Google-Smtp-Source: ABdhPJyiNYSj32/cj2GQgKymQhpjfGi8r2EhPJo1VwLclB+YLH6u112BLcv/rBjignkdjvJfKTRbLg==
X-Received: by 2002:a05:620a:d51:: with SMTP id o17mr4330852qkl.96.1619186418469;
        Fri, 23 Apr 2021 07:00:18 -0700 (PDT)
Received: from sasami.kepstin.ca (dhcp-108-168-125-232.cable.user.start.ca. [108.168.125.232])
        by smtp.gmail.com with ESMTPSA id b8sm4318386qka.117.2021.04.23.07.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:00:17 -0700 (PDT)
Message-ID: <23f75aaf3d37cbad6f8ed7bd970434e4a2dc388e.camel@kepstin.ca>
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection
 on AMD processors
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Borislav Petkov <bp@suse.de>, Chen Yu <yu.c.chen@intel.com>
Cc:     Terry Bowman <terry.bowman@amd.com>, lenb@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        wei.huang2@amd.com, aros@gmx.com, rui.zhang@intel.com
Date:   Fri, 23 Apr 2021 10:00:14 -0400
In-Reply-To: <20210423121934.GC24710@zn.tnic>
References: <20210419195812.147710-1-terry.bowman@amd.com>
         <20210420020336.GA386151@chenyu-desktop> <20210420080701.GA2326@zn.tnic>
         <20210420131541.GA388877@chenyu-desktop>
         <4cbb1eff77de1e843912267ade4686cfa1acd610.camel@kepstin.ca>
         <20210420143754.GA390118@chenyu-desktop>
         <5cf35f3742d1181421d955174b1aa9434d042c96.camel@kepstin.ca>
         <20210423121607.GA426003@chenyu-desktop> <20210423121934.GC24710@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2021-04-23 at 14:19 +0200, Borislav Petkov wrote:
> On Fri, Apr 23, 2021 at 08:16:07PM +0800, Chen Yu wrote:
> > From b2e63fe4f02e17289414b4f61237da822df115fb Mon Sep 17 00:00:00
> > 2001
> > From: Calvin Walton <calvin.walton@kepstin.ca>
> > Date: Fri, 23 Apr 2021 17:32:13 +0800
> > Subject: [PATCH 3/5] tools/power turbostat: Fix offset overflow
> > issue in index
> >  converting
> > 
> > The idx_to_offset() function returns type int (32-bit signed), but
> > MSR_PKG_ENERGY_STAT is greater than INT_MAX (or rather, would be
> > interpreted as a negative number). The end result is that it hits
> > the if (offset < 0) check in update_msr_sum() resulting in the
> > timer
> > callback for updating the stat in the background when long
> > durations
> > are used to not happen. The similar issue exists in offset_to_idx()
> > and update_msr_sum().
> > 
> > This patch fixes this issue by converting the 'int' type to 'off_t'
> > accordingly.
> > 
> > Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL
> > display")
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> 
> This patch's authorship is weird: it says From: Calvin but doesn't
> have
> his SOB here - only yours.

I think this patch is adapted from one of my earlier submissions? I
don't think I can really say that I wrote it, but I'll certainly review
it.

> 
> > ---
> >  tools/power/x86/turbostat/turbostat.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/power/x86/turbostat/turbostat.c
> > b/tools/power/x86/turbostat/turbostat.c
> > index a211264b57fd..77557122b292 100644
> > --- a/tools/power/x86/turbostat/turbostat.c
> > +++ b/tools/power/x86/turbostat/turbostat.c
> > @@ -296,9 +296,9 @@ struct msr_sum_array {
> >  /* The percpu MSR sum array.*/
> >  struct msr_sum_array *per_cpu_msr_sum;
> >  
> > -int idx_to_offset(int idx)
> > +off_t idx_to_offset(int idx)
> 
> And this is silly. MSRs are unsigned int. Fullstop.
> 
> So that function should either return u32 or unsigned int or so.

So, there's two problems with that:
   1. This function needs to be able to return an error value that cannot be
      confused with a valid MSR. This is currently done by returning a
      negative number. If an unsigned value is used, a different way of
      indicating errors needs to be written.
   2. We are not using CPU instructions to access MSRs direction. Instead
      they are being read from /dev/msr. So the "offset" value is actually a
      seek into the /dev/msr file (using pread), and thus is of type off_t.

-- 
Calvin Walton <calvin.walton@kepstin.ca>

