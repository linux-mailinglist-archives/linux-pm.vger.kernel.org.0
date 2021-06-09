Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815A63A1BFD
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 19:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhFIRmA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 13:42:00 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:34384 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhFIRl7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 13:41:59 -0400
Received: by mail-ot1-f44.google.com with SMTP id v27-20020a056830091bb02903cd67d40070so21654440ott.1;
        Wed, 09 Jun 2021 10:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqEr4btZ0y6qNjAmzXVmjI6B8oa6KV1R095KTeHz4wU=;
        b=dqKjyVxBF5Zvk8VaS+Hb+aQy48wEYv7UhWW5HAY88GiFq08rp1R72rMaGirUkYqH0L
         zsVYCAv6YMpuNa6ugz+B0TwAKjtYpjVC/9x9WsOI/WqIdwrNPVOnIPvvY44YHrt5PvRU
         EZzVgSDZLHci24FMNWB0OkuOyNgkIHbNzxGKOq7/gZPIBX2vTFYQ2MtGWhJhwPSbMask
         kUklAtChkSSwW0SdUkO3BcBuJvhseDTHq845/G+BKo2ssnIk7TMsi9tpnk/g5KHCZI7S
         RwmowaDUZjGh9mlr8l0XcY6Xpl6qCL8hVN6j6Elaej10dZafERecs+2lXEfMkJeboEri
         59IQ==
X-Gm-Message-State: AOAM532HHAfdrc4cm3R/rU7xNiKFXpQ/+ZY5YVRPzmxWkAGRJ/LR+GN0
        LuRByG6k7QVDBN90YyPMrX10ovEJutEC5hdXYjQ=
X-Google-Smtp-Source: ABdhPJy80Gx8Kl/o2Q3+1lAB1Cg9ZjUPswb7lfBXpV0wqFJMy/jFPLJvodwxqqr0HnAnscxyMtWZDKKOWwfg0Fi18+Y=
X-Received: by 2002:a05:6830:1bf7:: with SMTP id k23mr491737otb.206.1623260404502;
 Wed, 09 Jun 2021 10:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210528081417.31474-1-puwen@hygon.cn> <CAJZ5v0j-9zZvuSyKtRYePHE6aSr824SZz=E6VS_Ysv3cByGZyQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j-9zZvuSyKtRYePHE6aSr824SZz=E6VS_Ysv3cByGZyQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Jun 2021 19:39:53 +0200
Message-ID: <CAJZ5v0gF47KEAsC4fQzsBMLM=p70K5dWvb2dvjQMkZkZ-jtdSw@mail.gmail.com>
Subject: Re: [PATCH] x86/cstate: Allow ACPI C1 FFH MWAIT use on Hygon systems
To:     Pu Wen <puwen@hygon.cn>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 9, 2021 at 7:30 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, May 28, 2021 at 10:44 AM Pu Wen <puwen@hygon.cn> wrote:
> >
> > Hygon systems support the Monitor/Mwait instructions and these can be used
> > for ACPI C1 in the same way as on AMD and Intel systems.
> >
> > The BIOS declares a C1 state in _CST to use FFH and CPUID_Fn00000005_EDX
> > is non-zero on Hygon systems.
> >
> > Allow ffh_cstate_init() to succeed on Hygon systems to default using FFH
> > MWAIT instead of HALT for ACPI C1.
> >
> > Tested successfully on Hygon Fam18h systems.
> >
> > Signed-off-by: Pu Wen <puwen@hygon.cn>
> > ---
> >  arch/x86/kernel/acpi/cstate.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> > index 49ae4e1ac9cd..7de599eba7f0 100644
> > --- a/arch/x86/kernel/acpi/cstate.c
> > +++ b/arch/x86/kernel/acpi/cstate.c
> > @@ -197,7 +197,8 @@ static int __init ffh_cstate_init(void)
> >         struct cpuinfo_x86 *c = &boot_cpu_data;
> >
> >         if (c->x86_vendor != X86_VENDOR_INTEL &&
> > -           c->x86_vendor != X86_VENDOR_AMD)
> > +           c->x86_vendor != X86_VENDOR_AMD &&
> > +           c->x86_vendor != X86_VENDOR_HYGON)
> >                 return -1;
> >
> >         cpu_cstate_entry = alloc_percpu(struct cstate_entry);
> > --
>
> Applied as 5.14 material, thanks!

And dropped, because it has been applied already by Boris:
https://git.kernel.org/tip/280b68a3b3b96b027fcdeb5a3916a8e2aaf84d03
