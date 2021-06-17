Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A993ABAAA
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 19:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhFQRen (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 13:34:43 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:42510 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhFQRen (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 13:34:43 -0400
Received: by mail-ot1-f45.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so6896479oth.9;
        Thu, 17 Jun 2021 10:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81Ce+c7gQdmhNFYfxwHdHAzT80ECkLbi7pk1F5wt6Z0=;
        b=Z1YiSHnM9uAUEeYNJz+TUI8ULXcNZ3soPhSOJsKhuua/22KXCJXyYzBbiH9xZK557N
         s1TlS1pA9t/QesWJ9uHtgtBKXHOPEaNt7E5DOkuN2m3u6S+qTGPXX0mQ93FqRngCfIpb
         JJZTJYOOEnLmrgPj/IndhLRAUqpjU92BRuwRXyhMkS1kZDJh1YkTBwdBdK+6eJk2ysZi
         QCGcOVhjSt/gR+XTVe7RcgrWiSSKeqj2BXWCRKiVJaH6JV31BdExS6q5cPlLzbtoNmz2
         aJszRDHbpiOWqHxYPR0CNdadPkRuozZSdNyCRffRhEuMppt9waEF2IMcMWdpHiZKT9PD
         vU7A==
X-Gm-Message-State: AOAM532zNeHDqs9+ItT3r8ajWVlRcFgpnXelMnM20eidWsgXRox+Ojpl
        mMdf57Imx8Mjxbu9G/ib6+keKsK+TUjEzTyFrLM=
X-Google-Smtp-Source: ABdhPJz8swif365bH7WMe3PTZET/PN/Ow7UReQCrmLIY3gnTPr3g/iKUgGO7wsZIv698+1701xq5nOoLJZFirxKPsh4=
X-Received: by 2002:a05:6830:1bf7:: with SMTP id k23mr5836663otb.206.1623951155517;
 Thu, 17 Jun 2021 10:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210615033535.2907295-1-libaokun1@huawei.com> <CAJZ5v0iajoHXbJO-HgOMZkDo1GfRNEgDoNaSmFcOpeJGhgrYdA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iajoHXbJO-HgOMZkDo1GfRNEgDoNaSmFcOpeJGhgrYdA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jun 2021 19:32:24 +0200
Message-ID: <CAJZ5v0g2+far_FMgBSV9OdobJU6kKD6BR3pg5VabavQVYC-uQQ@mail.gmail.com>
Subject: Re: [PATCH -next v2] x86/power: fix doc warnings in cpu.c
To:     Baokun Li <libaokun1@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yue Haibing <yuehaibing@huawei.com>, yangjihong1@huawei.com,
        yu kuai <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 17, 2021 at 2:12 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jun 15, 2021 at 5:26 AM Baokun Li <libaokun1@huawei.com> wrote:
> >
> > Fixes the following W=1 kernel build warning(s):
> >
> >  arch/x86/power/cpu.c:76: warning: Function parameter or
> >   member 'ctxt' not described in '__save_processor_state'
> >  arch/x86/power/cpu.c:192: warning: Function parameter or
> >   member 'ctxt' not described in '__restore_processor_state'
> >
> > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > ---
> > V1->V2:
> >         Fix the formatting of this kerneldoc comment
> >
> >  arch/x86/power/cpu.c | 31 ++++++++++++++++---------------
> >  1 file changed, 16 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> > index 3a070e7cdb8b..54b530db5ed0 100644
> > --- a/arch/x86/power/cpu.c
> > +++ b/arch/x86/power/cpu.c
> > @@ -58,19 +58,20 @@ static void msr_restore_context(struct saved_context *ctxt)
> >  }
> >
> >  /**
> > - *     __save_processor_state - save CPU registers before creating a
> > - *             hibernation image and before restoring the memory state from it
> > - *     @ctxt - structure to store the registers contents in
> > + * __save_processor_statei() - Save CPU registers before creating a
> > + *                             hibernation image and before restoring
> > + *                             the memory state from it
> > + * @ctxt: Structure to store the registers contents in.
> >   *
> > - *     NOTE: If there is a CPU register the modification of which by the
> > - *     boot kernel (ie. the kernel used for loading the hibernation image)
> > - *     might affect the operations of the restored target kernel (ie. the one
> > - *     saved in the hibernation image), then its contents must be saved by this
> > - *     function.  In other words, if kernel A is hibernated and different
> > - *     kernel B is used for loading the hibernation image into memory, the
> > - *     kernel A's __save_processor_state() function must save all registers
> > - *     needed by kernel A, so that it can operate correctly after the resume
> > - *     regardless of what kernel B does in the meantime.
> > + * NOTE: If there is a CPU register the modification of which by the
> > + * boot kernel (ie. the kernel used for loading the hibernation image)
> > + * might affect the operations of the restored target kernel (ie. the one
> > + * saved in the hibernation image), then its contents must be saved by this
> > + * function.  In other words, if kernel A is hibernated and different
> > + * kernel B is used for loading the hibernation image into memory, the
> > + * kernel A's __save_processor_state() function must save all registers
> > + * needed by kernel A, so that it can operate correctly after the resume
> > + * regardless of what kernel B does in the meantime.
> >   */
> >  static void __save_processor_state(struct saved_context *ctxt)
> >  {
> > @@ -181,9 +182,9 @@ static void fix_processor_context(void)
> >  }
> >
> >  /**
> > - * __restore_processor_state - restore the contents of CPU registers saved
> > - *                             by __save_processor_state()
> > - * @ctxt - structure to load the registers contents from
> > + * __restore_processor_state() - Restore the contents of CPU registers saved
> > + *                               by __save_processor_state()
> > + * @ctxt: Structure to load the registers contents from.
> >   *
> >   * The asm code that gets us here will have restored a usable GDT, although
> >   * it will be pointing to the wrong alias.
> > --
>
> Applied as 5.14 material, thanks!

And dropped, because it introduced a build issue.
