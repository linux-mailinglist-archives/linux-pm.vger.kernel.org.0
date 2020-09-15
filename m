Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4C126AF19
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 23:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgIOVBz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 17:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgIOUpA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 16:45:00 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7142FC061788;
        Tue, 15 Sep 2020 13:44:43 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z2so4309359qtv.12;
        Tue, 15 Sep 2020 13:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b4wyyxtHiFl+MY62NzX6PyD2B1xSNShVZ1s5WeOMeHQ=;
        b=s+fKAZuS+OKD6h1qW+fpmsng/DA3/JVQWrzIuxFOJo5C1LG+ix4EWwiUDJ4+qrZSox
         N/fpeHqM5ZyKO1L6zSaCQ0DsUPYXV1k56WKNBOV+hDRLM9xIq5LMK6iyPNeKW3oPaZA6
         6uARsFSo38knHq5kxONGJ1Cp7OfzZM0XhzAjaZfn9PR0xG8OVspmXfwnR4OPm0ztG2AY
         kkZWcNaVomTiY9rfOb2SfWUMEVkv8I5QbzyyJIKUOGOoju1046oiffj/4Sp9FGjc1DUx
         Atb/VRE1azkszba/DUSqqRUQhcT5sb6zGpLv3RRX7vfe5zpdBdBRI3sUI5rvJf34b4p4
         vgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=b4wyyxtHiFl+MY62NzX6PyD2B1xSNShVZ1s5WeOMeHQ=;
        b=BGLUylqnfE6Z2c1pmC7/JuR+yuOj+HMi4kPd4X8gGfDspN3beeUmIydfpDvOu3NMWh
         mr4W9Xd3THTYmnkkiOmeKDX7ehsw6L+yXSDZ+2a0c+q1Cs+49s8sVAZnVjmMBej6UEsa
         mGf0T9Lwy+PD0ZT/tpnsc6i/ZjMlEaKXxMJfOma/mqHh+V/C5wNMeg5pdedZ60CSO0DQ
         1OeULH1UrjWGXkoqPe2o+o1oZ1w5WX4iLZK0z8u+h77Q/90zf5x2gVo01SGYKfDoGsxW
         W+OdmWU0jioGMsW7UjEu3jZapV35dzKsJt/ROpPvXCAwGdp8/HHdxlUqoPFNWTVdJ1WO
         6KpA==
X-Gm-Message-State: AOAM530LwL7BgALPn3KpTxLsEcLFgQumgwSE/L/4XOq+3BlbnDTsvOsF
        JCTf+J/nek8UCE6w9mInCFmJKhW/1Rk=
X-Google-Smtp-Source: ABdhPJwj4te/fZrlQ9OJQ5kwQ0efpoi5ZSeytiaTHPqUuJIbDTREw39fhN58jm7+uhI2D2BBWC623A==
X-Received: by 2002:aed:2433:: with SMTP id r48mr2584894qtc.58.1600202682584;
        Tue, 15 Sep 2020 13:44:42 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o26sm3446298qtb.24.2020.09.15.13.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 13:44:41 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 15 Sep 2020 16:44:40 -0400
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, Roman Kiryanov <rkir@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-pm@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Alistair Delva <adelva@google.com>,
        Haitao Shan <hshan@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
Message-ID: <20200915204440.GA1087647@rani.riverdale.lan>
References: <20200915172658.1432732-1-rkir@google.com>
 <20200915174643.GT14436@zn.tnic>
 <CAKwvOdm9bQmL=gZypkosH0MG=S28=jJ6wZiTMCNP6=Z+NfN1AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdm9bQmL=gZypkosH0MG=S28=jJ6wZiTMCNP6=Z+NfN1AA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 15, 2020 at 11:00:30AM -0700, Nick Desaulniers wrote:
> On Tue, Sep 15, 2020 at 10:46 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Tue, Sep 15, 2020 at 10:26:58AM -0700, rkir@google.com wrote:
> > > From: Haitao Shan <hshan@google.com>
> > >
> > > This is a workaround which fixes triple fault
> > > in __restore_processor_state on clang when
> > > built with LTO.
> > >
> > > When load_TR_desc and load_mm_ldt are inlined into
> > > fix_processor_context due to LTO, they cause

Does this apply to load_TR_desc()? That is an inline function even
without LTO, no?

> > > fix_processor_context (or in this case __restore_processor_state,
> > > as fix_processor_context was inlined into __restore_processor_state)
> > > to access the stack canary through %gs, but before
> > > __restore_processor_state has restored the previous value
> > > of %gs properly. LLVM appears to be inlining functions with stack
> > > protectors into functions compiled with -fno-stack-protector,
> > > which is likely a bug in LLVM's inliner that needs to be fixed.
> > >
> > > The LLVM bug is here: https://bugs.llvm.org/show_bug.cgi?id=47479
> > >
> > > Signed-off-by: Haitao Shan <hshan@google.com>
> > > Signed-off-by: Roman Kiryanov <rkir@google.com>
> >
> > Ok, google guys, pls make sure you Cc LKML too as this is where *all*
> > patches and discussions are archived. Adding it now to Cc.
> 
> Roman, please use ./scripts/get_maintainer.pl (in the kernel tree) for that.
> 
> >
> > > ---
> > >  arch/x86/power/cpu.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> > > index db1378c6ff26..e5677adb2d28 100644
> > > --- a/arch/x86/power/cpu.c
> > > +++ b/arch/x86/power/cpu.c
> > > @@ -274,6 +274,16 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
> > >  /* Needed by apm.c */
> > >  void notrace restore_processor_state(void)
> > >  {
> > > +#ifdef __clang__
> 
> Should be CONFIG_CC_IS_CLANG; is more canonical throughout the tree.
> Or if this is only a bug when doing builds with LTO, and LTO is not
> yet upstream, then maybe Sami should carry this in his series, at
> least until I can fix the bug in Clang.  Or guard this with the
> CONFIG_LTO_CLANG config (not upstream yet; see Sami's series).
> 
> > > +     // The following code snippet is copied from __restore_processor_state.
> > > +     // Its purpose is to prepare GS segment before the function is called.
> > > +#ifdef CONFIG_X86_64
> > > +     wrmsrl(MSR_GS_BASE, saved_context.kernelmode_gs_base);
> > > +#else
> > > +     loadsegment(fs, __KERNEL_PERCPU);
> > > +     loadsegment(gs, __KERNEL_STACK_CANARY);
> > > +#endif
> > > +#endif
> >
> > Ok, so why is the kernel supposed to take yet another ugly workaround
> > because there's a bug in the compiler?
> 
> This is exactly the same code from __restore_processor_state.  If it's
> ugly, talk to the author of 7ee18d677989e. ;)  All this patch is doing
> is moving this up a call frame (though now this is effectively being
> run twice).
> 

Possibly dumb question: why does this fix anything? Won't
__restore_processor_state(), which is a static function with only one
caller, in turn get inlined into restore_processor_state(), so that
restore_processor_state() will also have stack protection enabled, and
the canary will be accessed before the MSR or segment register is
loaded?

Thanks.
