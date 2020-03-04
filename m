Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C01311798F5
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 20:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbgCDT0G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 14:26:06 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45871 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDT0G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 14:26:06 -0500
Received: by mail-ed1-f68.google.com with SMTP id h62so3641454edd.12
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2020 11:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFsbFw0YKq63mN4kk6cHyhQWkj6+cfAUWsGxTYtg/zw=;
        b=nDBn0SdZFqEAWyplGDuVVyCUbVweD3UVmTUas+PF5dDOYARN/7YmBRHICsQ65dOabg
         1CV71i2U64XmzdBXXOUhdWzg3vyWxAZOcINdLaJ3/Dz245ZCnNgJv2yPIGfjoCB19RyP
         c0pOAlPq9+G9kihFmOZZfCArlHHOjP6Zlf8cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFsbFw0YKq63mN4kk6cHyhQWkj6+cfAUWsGxTYtg/zw=;
        b=WJwU8MO6V34e+paDLiiMtmIzKgBrBHc+XkrM3kfUP4cJ71mq+BYT5CHBteNo+w0X/K
         fbO/UspGxKihh0e/PSbdFzlwgA54g2yhGChruJuPUfWAuk/XKdG3HaTFai2jx83sOU3n
         eL1BSLYtLeR4DbJc2teO2MHLzbGwJdK3AcWLSFOQr6kxj8CxNPQoym+SJ8dxqS4F0+90
         AaicnS6vnkMj2L5ZXn3Pn6II8FMG65JZmxvvd/NnyvXLGr3HwUje0EbsgphFzFnl6BDW
         AT6kV0nEaEeIVonj+fnLuuUWZMXJK0OIoqc2GQqmKr8vb2YAD9O8/IZs1mg3HGbGKECU
         GnRw==
X-Gm-Message-State: ANhLgQ1sOtHTWZnJ2t3wLc4xc9pdPrEY7NPmQjcb214JegHq7TmNVQx8
        Tg1JwGKO3QtjrR4hfwk3LdOk4Yk/Q/w=
X-Google-Smtp-Source: ADFU+vu0u2xoUj2bI83AlydO7ZtTXGXs/M5gsyjwv0dsBi7LpnD75Ws4mA8DV6zymFj1wHF3dKGIeQ==
X-Received: by 2002:aa7:c1d0:: with SMTP id d16mr4429244edp.69.1583349964014;
        Wed, 04 Mar 2020 11:26:04 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id z6sm259270edi.37.2020.03.04.11.26.03
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 11:26:03 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id i9so3487172wml.4
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2020 11:26:03 -0800 (PST)
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr5219880wmk.83.1583349596173;
 Wed, 04 Mar 2020 11:19:56 -0800 (PST)
MIME-Version: 1.0
References: <20200228000105.165012-1-thgarnie@chromium.org>
 <202003022100.54CEEE60F@keescook> <20200303095514.GA2596@hirez.programming.kicks-ass.net>
 <CAJcbSZH1oON2VC2U8HjfC-6=M-xn5eU+JxHG2575iMpVoheKdA@mail.gmail.com>
 <6e7e4191612460ba96567c16b4171f2d2f91b296.camel@linux.intel.com>
 <202003031314.1AFFC0E@keescook> <20200304092136.GI2596@hirez.programming.kicks-ass.net>
 <202003041019.C6386B2F7@keescook> <e60876d0-4f7d-9523-bcec-6d002f717623@zytor.com>
In-Reply-To: <e60876d0-4f7d-9523-bcec-6d002f717623@zytor.com>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Wed, 4 Mar 2020 11:19:44 -0800
X-Gmail-Original-Message-ID: <CAJcbSZHBB1u2Vq0jZKsmd0UcRj=aichxTtbGvbWgf8-g8WPa7w@mail.gmail.com>
Message-ID: <CAJcbSZHBB1u2Vq0jZKsmd0UcRj=aichxTtbGvbWgf8-g8WPa7w@mail.gmail.com>
Subject: Re: [PATCH v11 00/11] x86: PIE support to extend KASLR randomization
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Allison Randal <allison@lohutok.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 4, 2020 at 10:45 AM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 2020-03-04 10:21, Kees Cook wrote:
> > On Wed, Mar 04, 2020 at 10:21:36AM +0100, Peter Zijlstra wrote:
> >> But at what cost; it does unspeakable ugly to the asm. And didn't a
> >> kernel compiled with the extended PIE range produce a measurably slower
> >> kernel due to all the ugly?
> >
> > Was that true? I thought the final results were a wash and that earlier
> > benchmarks weren't accurate for some reason? I can't find the thread
> > now. Thomas, do you have numbers on that?

I have never seen a significant performance impact. Performance and
size is better on more recent versions of gcc as it has better
generation of PIE code (for example generation of switches).

> >
> > BTW, I totally agree that fgkaslr is the way to go in the future. I
> > am mostly arguing for this under the assumption that it doesn't
> > have meaningful performance impact and that it gains the kernel some
> > flexibility in the kinds of things it can do in the future. If the former
> > is not true, then I'd agree, the benefit needs to be more clear.
> >
>
> "Making the assembly really ugly" by itself is a reason not to do it, in my
> Not So Humble Opinion[TM]; but the reason the kernel and small memory models
> exist in the first place is because there is a nonzero performance impact of
> the small-PIC memory model. Having modules in separate regions would further
> add the cost of a GOT references all over the place (PLT is optional, useless
> and deprecated for eager binding) *plus* might introduce at least one new
> vector of attack: overwrite a random GOT slot, and just wait until it gets hit
> by whatever code path it happens to be in; the exact code path doesn't matter.
> From an kASLR perspective this is *very* bad, since you only need to guess the
> general region of a GOT rather than an exact address.

I agree that it would add GOT references and I can explore that more
in terms of performance impact and size. This patchset makes the GOT
readonly too so I don't think the attack vector applies.

>
> The huge memory model, required for arbitrary placement, has a very
> significant performance impact.

I assume you mean mcmodel=large, it doesn't use it. It uses -fPIE and
removes -mcmodel=kernel. It favors relative references whenever
possible.

>
> The assembly code is *very* different across memory models.
>
>         -hpa
