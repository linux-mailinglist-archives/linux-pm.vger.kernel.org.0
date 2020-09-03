Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1AC25C822
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 19:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgICRg2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 13:36:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39140 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICRg1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2020 13:36:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id c10so3505107edk.6;
        Thu, 03 Sep 2020 10:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gh69+24/Chdrnxcf6KgQPJmRC4c9fN5aU1ZFyq23BhM=;
        b=g9uKFjziYXjDVHYf0ALrhfihIehF1nlnfyWvwi0tVgdp2nPiEFDHKbKB8v0UwBfbu+
         XRL6EC71e0QxI2cYMQWs9CTZ1A+YwUoWUyzVNDSw+oPVtZ8goxc1f1tubY9Hivzavl/8
         JifHXR/zKelCuYFp7ARM0IzdHP7H5wJKRsEz9Xt1WhPt/FKim4ROQsQH4dYcfiL4qQZ9
         GIBaRmEOS8eVHplonVfiOt4aWdbUp2fdqk/pOjeLGbPL815mP46JxYVKRDN37llKXEca
         /uHmKEWyDIcuI9IqpVew9I+kzB2YpsGN9QyH7NYzmISMi5KZkgByca3YSvWmkw/pVvl/
         8tKA==
X-Gm-Message-State: AOAM532X0JhBSo5wIEJH0wkxRiD7CcY4qghWKtq1np43aOUaNFv2Qm7D
        eZI1fXTIy0tOrUbOON6WPjUqfkfxSUz2TDpPSLq/QnknSPc=
X-Google-Smtp-Source: ABdhPJx7Im4zZcqn+QWwgAsgUOeBpXbqj93qwsM7wEGQ3Tf5TTX74jmGTxVUg7FM0dZMbsAGdWlM6dbuB0Hgkf7PjWQ=
X-Received: by 2002:a05:6402:1495:: with SMTP id e21mr4155933edv.146.1599154585348;
 Thu, 03 Sep 2020 10:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200717060849.12469-1-liwei.song@windriver.com>
 <CAJvTdKm9WHgQuP38Y2o1zQ-VgLKMMDup4crAPrW3pexoWft+6Q@mail.gmail.com>
 <52f16995-6d2d-fa7d-ed5e-682db3461d03@windriver.com> <CAJvTdKms0Qj3d+g_tK8oboMXebYgnPm51EdSL_UvLdw3GV6A3A@mail.gmail.com>
 <alpine.LNX.2.20.13.2008232345570.12553@monopod.intra.ispras.ru> <cce63c40-1633-5b86-6aaf-7f9a93c63eac@windriver.com>
In-Reply-To: <cce63c40-1633-5b86-6aaf-7f9a93c63eac@windriver.com>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 3 Sep 2020 13:36:14 -0400
Message-ID: <CAJvTdKk7Gd3G4K7um=6HC3YJu48aVW+4WFvr8jVqyOKcSZc7qQ@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: call pread64 in kernel directly
To:     Liwei Song <liwei.song@windriver.com>
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> -D_FILE_OFFSET_BITS=64

Applied.

thanks!
-Len

On Mon, Aug 24, 2020 at 12:09 AM Liwei Song <liwei.song@windriver.com> wrote:
>
>
>
> On 8/24/20 04:54, Alexander Monakov wrote:
> > Hi,
> >
> > I am not the original submitter, but I have answers and a proper patch :)
> >
> > On Fri, 21 Aug 2020, Len Brown wrote:
> >
> >> Re: offset size
> >>
> >> The offsets on this file are the MSR offsets.
> >> What MSR are you trying to access at offset 0xc0010299?
> >
> > This MSR is particular is part of AMD RAPL (energy measurements) interface.
> >
> >> Re: pread vs pread64
> >>
> >> If I take on faith that you have some kind of 32-bit execution
> >> environment that makes pread into pread32 instead of pread64, and that
> >> truncates an off_t to 32-bits from 64-bits, and it actually makes
> >> sense to request a read at this large offset...
> >
> > The problem here stems from the backward compatibility in Glibc: off_t is
> > 32-bit on 32-bit x86, unless compiled with -D_FILE_OFFSET_BITS=64. This
> > macro should be used for all new code. Distros should enable it for all
> > builds, but when one builds turbostat 'by hand', they hit the issue.
> >
> >> would we really have to invoke syscall() directly -- couldn't we
> >> invoke pread64() directly? (eg. below)
> >
> > No, the proper fix is to pass -D_FILE_OFFSET_BITS=64 to the compiler.
> >
> > Here's the patch:
>
> This path works with my case.
>
> Thanks,
> Liwei.
>
>
> >
> > ---8<---
> >
> > From: Alexander Monakov <amonakov@ispras.ru>
> > Date: Sun, 23 Aug 2020 23:27:02 +0300
> > Subject: [PATCH] turbostat: build with _FILE_OFFSET_BITS=64
> >
> > For compatibility reasons, Glibc off_t is a 32-bit type on 32-bit x86
> > unless _FILE_OFFSET_BITS=64 is defined. Add this define, as otherwise
> > reading MSRs with index 0x80000000 and above attempts a pread with a
> > negative offset, which fails.
> >
> > Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> > ---
> >  tools/power/x86/turbostat/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbostat/Makefile
> > index 2b6551269e43..40ae44402eec 100644
> > --- a/tools/power/x86/turbostat/Makefile
> > +++ b/tools/power/x86/turbostat/Makefile
> > @@ -12,6 +12,7 @@ turbostat : turbostat.c
> >  override CFLAGS +=   -O2 -Wall -I../../../include
> >  override CFLAGS +=   -DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
> >  override CFLAGS +=   -DINTEL_FAMILY_HEADER='"../../../../arch/x86/include/asm/intel-family.h"'
> > +override CFLAGS +=   -D_FILE_OFFSET_BITS=64
> >  override CFLAGS +=   -D_FORTIFY_SOURCE=2
> >
> >  %: %.c
> >



-- 
Len Brown, Intel Open Source Technology Center
