Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE7324DFF5
	for <lists+linux-pm@lfdr.de>; Fri, 21 Aug 2020 20:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgHUSuT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 14:50:19 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:33914 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgHUSuS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 14:50:18 -0400
Received: by mail-ej1-f67.google.com with SMTP id o23so3526321ejr.1;
        Fri, 21 Aug 2020 11:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYzLZgwpvbGKths6LYp8+ddZvzUQfeDT+gGev5xd+mQ=;
        b=uANUCq4AkqWLkoH2FU99OPkqwdK+63+Q+fuAQiZtQj6PdoZpe2WIL2I8kN5ZossFXX
         1ojLCVg6HqESB0klZGeNRh1RolTaEKgTZFfQ4M3O2OyqC7mw4v6/UFrmXKtPtR60Tf4S
         j3Ry+IMl6hzhPmx1YcIVNrgAuse6sDUNrwnN/V9YhznzRup0373t3M3gMZYmilUmcHyR
         N7jN2DHAYx/pgJo23rP9lrW8Vl/IqZjwMMY+dmRS/9hpRnNlngKPnwU06DyLGnzj/xFz
         IhPOyFITZJqD9JHrB5dHkpXo3QAmsGablkAzarrDhflfhhVn6wfRc8t4gjqoxqEKITQu
         AaZg==
X-Gm-Message-State: AOAM532DwVbC/H4P7zXTr3jPX4mq9QvjjWSrwUby5CoPEnts52PjAetf
        6ARLXzzAuEwgJmm31cH5/VKxxLaGvZ+fkIsq7wUW82fPtIY=
X-Google-Smtp-Source: ABdhPJy/3f/bgh6Ufo4q/gpnOxySM0lm90ZX/2duRJBB/eV9Nk76yTVwEcSKbIuZwDEUYC+1H1UmBaDPnP42ZotHBv4=
X-Received: by 2002:a17:906:b157:: with SMTP id bt23mr4451828ejb.354.1598035815823;
 Fri, 21 Aug 2020 11:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200717060849.12469-1-liwei.song@windriver.com>
 <CAJvTdKm9WHgQuP38Y2o1zQ-VgLKMMDup4crAPrW3pexoWft+6Q@mail.gmail.com> <52f16995-6d2d-fa7d-ed5e-682db3461d03@windriver.com>
In-Reply-To: <52f16995-6d2d-fa7d-ed5e-682db3461d03@windriver.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 21 Aug 2020 14:50:04 -0400
Message-ID: <CAJvTdKms0Qj3d+g_tK8oboMXebYgnPm51EdSL_UvLdw3GV6A3A@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: call pread64 in kernel directly
To:     Liwei Song <liwei.song@windriver.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Re: offset size

The offsets on this file are the MSR offsets.
What MSR are you trying to access at offset 0xc0010299?

Re: pread vs pread64

If I take on faith that you have some kind of 32-bit execution
environment that makes pread into pread32 instead of pread64, and that
truncates an off_t to 32-bits from 64-bits, and it actually makes
sense to request a read at this large offset...

would we really have to invoke syscall() directly -- couldn't we
invoke pread64() directly? (eg. below)

thanks,
-Len


@@ -490,11 +491,12 @@ int get_msr_fd(int cpu)
        return fd;
 }

-int get_msr(int cpu, off_t offset, unsigned long long *msr)
+int get_msr(int cpu, unsigned long long offset, unsigned long long *msr)
 {
        ssize_t retval;

-       retval = pread(get_msr_fd(cpu), msr, sizeof(*msr), offset);
+       retval = pread64(get_msr_fd(cpu), msr, sizeof(*msr), offset);

        if (retval != sizeof *msr)
                err(-1, "cpu%d: msr offset 0x%llx read failed", cpu,
(unsigned long long)offset);

On Thu, Aug 13, 2020 at 10:17 PM Liwei Song <liwei.song@windriver.com> wrote:
>
> with multilib lib32 support, the rootfs will be 32-bit,
> the kernel is still 64-bit, in this case run turbostat
> will failed with "out of range" error.
>
> Thanks,
> Liwei.
>
> On 8/14/20 05:43, Len Brown wrote:
> > Huh?
> >
> > On Fri, Jul 17, 2020 at 2:09 AM Liwei Song <liwei.song@windriver.com> wrote:
> >>
> >> with 32-bit rootfs, the offset may out of range when set it
> >> to 0xc0010299, define it as "unsigned long long" type and
> >> call pread64 directly in kernel.
> >>
> >> Signed-off-by: Liwei Song <liwei.song@windriver.com>
> >> ---
> >>  tools/power/x86/turbostat/turbostat.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> >> index 33b370865d16..4c5cdfcb5721 100644
> >> --- a/tools/power/x86/turbostat/turbostat.c
> >> +++ b/tools/power/x86/turbostat/turbostat.c
> >> @@ -33,6 +33,7 @@
> >>  #include <sys/capability.h>
> >>  #include <errno.h>
> >>  #include <math.h>
> >> +#include <sys/syscall.h>
> >>
> >>  char *proc_stat = "/proc/stat";
> >>  FILE *outf;
> >> @@ -381,11 +382,11 @@ int get_msr_fd(int cpu)
> >>         return fd;
> >>  }
> >>
> >> -int get_msr(int cpu, off_t offset, unsigned long long *msr)
> >> +int get_msr(int cpu, unsigned long long offset, unsigned long long *msr)
> >>  {
> >>         ssize_t retval;
> >>
> >> -       retval = pread(get_msr_fd(cpu), msr, sizeof(*msr), offset);
> >> +       retval = syscall(SYS_pread64, get_msr_fd(cpu), msr, sizeof(*msr), offset);
> >>
> >>         if (retval != sizeof *msr)
> >>                 err(-1, "cpu%d: msr offset 0x%llx read failed", cpu, (unsigned long long)offset);
> >> --
> >> 2.17.1
> >>
> >
> >



-- 
Len Brown, Intel Open Source Technology Center
