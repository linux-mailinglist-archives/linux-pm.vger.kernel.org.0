Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BFB41C183
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 11:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243688AbhI2JWr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 05:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhI2JWr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 05:22:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4B3C06161C;
        Wed, 29 Sep 2021 02:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=14U3k36Tp8lwBDHBEI+fHr5mj+qMDhRdlDDHaE06HLM=; b=ISjal99/+JgvVwsl6sxop+nyFg
        1inixt5C+LXLsXAHCEBAzwPbxJm1n1H/wwX1ogz3hMgx7XT95Xyj6vG5AhXGEfjCGS5iitELwMlpi
        busYmi2gPIY26xP8AD/U1ro5THLlY9C6+xjglqYE2bj7pRGwespHUDQy3EwuWP//xuUT5yZU3fbXa
        n2YYauVs/a8EGbYXdWo7cZGl3XLqeOFsQ+hK0IJtRpsiN3Qw9tOAzK6WQ2K4raeptmFT72VdVuILc
        AF/8H/2d99eEPvGFjSRI21WkkQd2qp+fG3XtzN6hoP0rQ1pyaIRLqxt6uAyffXVLnS/wDmYgWngtC
        ViEW8H5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVVln-006gHA-89; Wed, 29 Sep 2021 09:20:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD5BD300056;
        Wed, 29 Sep 2021 11:20:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FBC729AD1D57; Wed, 29 Sep 2021 11:20:54 +0200 (CEST)
Date:   Wed, 29 Sep 2021 11:20:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Deepak Sharma <deepak.sharma@amd.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RESEND PATCH] x86: ACPI: cstate: Optimize C3 entry on AMD CPUs
Message-ID: <YVQv9tkwOZSP+Ruc@hirez.programming.kicks-ass.net>
References: <20210924061205.5523-1-deepak.sharma@amd.com>
 <CAJZ5v0iS+TnkoqCxLa92Na=By53PXY-qW=k4utr_84KYaw+sVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iS+TnkoqCxLa92Na=By53PXY-qW=k4utr_84KYaw+sVQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 24, 2021 at 06:48:48PM +0200, Rafael J. Wysocki wrote:
> On Fri, Sep 24, 2021 at 8:12 AM Deepak Sharma <deepak.sharma@amd.com> wrote:
> >
> > All Zen or newer CPU which support C3 shares cache. Its not necessary to
> > flush the caches in software before entering C3. This will cause drop in
> > performance for the cores which share some caches. ARB_DIS is not used
> > with current AMD C state implementation. So set related flags correctly.
> >
> > Signed-off-by: Deepak Sharma <deepak.sharma@amd.com>
> 
> I'm planning to take this one unless the x86 maintainers have concerns, thanks.
> 
> > ---
> >  arch/x86/kernel/acpi/cstate.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> > index 7de599eba7f0..7945eae5b315 100644
> > --- a/arch/x86/kernel/acpi/cstate.c
> > +++ b/arch/x86/kernel/acpi/cstate.c
> > @@ -79,6 +79,21 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
> >                  */
> >                 flags->bm_control = 0;
> >         }
> > +       if (c->x86_vendor == X86_VENDOR_AMD && c->x86 >= 0x17) {
> > +               /*
> > +                * For all AMD Zen or newer CPUs that support C3, caches
> > +                * should not be flushed by software while entering C3
> > +                * type state. Set bm->check to 1 so that kernel doesn't
> > +                * need to execute cache flush operation.
> > +                */
> > +               flags->bm_check = 1;
> > +               /*
> > +                * In current AMD C state implementation ARB_DIS is no longer
> > +                * used. So set bm_control to zero to indicate ARB_DIS is not
> > +                * required while entering C3 type state.
> > +                */
> > +               flags->bm_control = 0;
> > +       }

My only concern is the blatant code duplication between AMD and ZHAOXIN
here. Other than that, this is obviously correct since the ZHAOXIN thing
is basically rebranded AMD IP.
