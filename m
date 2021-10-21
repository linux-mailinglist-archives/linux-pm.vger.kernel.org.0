Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FE3435F3F
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 12:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhJUKjd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 06:39:33 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:38661 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJUKjc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 06:39:32 -0400
Received: by mail-oi1-f172.google.com with SMTP id t4so314764oie.5;
        Thu, 21 Oct 2021 03:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9sP8cYSneVphlIY9Q+l0jG1RUXEMjCrXXjH5paVkikM=;
        b=uLNXxfDi8GlwRs5bu7vUpBF2+RBByNzpeRMSaHkCHXOZH+MtdxFLNo5ExcJ+1e3iS9
         pKBpoZGvcoFVfRhLAzjujSBqPWYB6ppftWzgYWEP33GIOs0HPN/wTg18cKIOeaZK0Qny
         awa3vGiqCPUqoLeeDnkmHN4SBbEvQFq6+G9GCDpymezmC+gnoLmZ/UfddtV17NfqPszy
         Axth/OcXAbOt/V8jKY2a8k3iEt8pIpw9Uc1TRAytUjZ5HqmcLg7jvLqN1m54B0ejtFaC
         9Ei5H/j+vwtcyqO9O/NYjHbiC/0GGfP+0zVNyu6NztTtcc07exdrUBfqEOI1Jayzkmqa
         k0Pw==
X-Gm-Message-State: AOAM531005WdpGp0llFd7qCYHCNEHqCEb+tW1Xn2a4LfzXMXPnHQ3bdY
        +NlCyKETDgGmy3YEKLSnxV8oyX9iUpueem4FaEKsAq62
X-Google-Smtp-Source: ABdhPJx2NTiizHZdxUBOrJTgW+AGytpO7oTgM0NP303TCN0SrSVfFAttVLjkfMbypuS1mdnqEmTJhUmgOmsboQD2aac=
X-Received: by 2002:a05:6808:1286:: with SMTP id a6mr41002oiw.51.1634812636664;
 Thu, 21 Oct 2021 03:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211005155427.1591196-1-john@metanate.com> <CAJZ5v0gPwUQzGBa2VDeC3xAF9zJVm486BC0eue10-urJ8Xz+iw@mail.gmail.com>
 <20211005181706.66102578.john@metanate.com> <CAJZ5v0iFKYvM+rn68VaAbM4=ZLAQBR_UPzvAuKqVLQuP=ZJPew@mail.gmail.com>
 <20211006191813.0e097b9f.john@metanate.com>
In-Reply-To: <20211006191813.0e097b9f.john@metanate.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Oct 2021 12:37:05 +0200
Message-ID: <CAJZ5v0hD61=MsVWmoGNJ50a6raGrsME_=7ha=E-Y3AgmuvQsjw@mail.gmail.com>
Subject: Re: [RFC PATCH RT] PM: runtime: avoid retry loops on RT
To:     John Keeping <john@metanate.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-rt-users@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 6, 2021 at 8:18 PM John Keeping <john@metanate.com> wrote:
>
> On Wed, 6 Oct 2021 19:05:50 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Tue, Oct 5, 2021 at 7:17 PM John Keeping <john@metanate.com> wrote:
> > >
> > > On Tue, 5 Oct 2021 18:38:27 +0200
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > >
> > > > On Tue, Oct 5, 2021 at 6:14 PM John Keeping <john@metanate.com> wrote:
> > > > >
> > > > > With PREEMPT_RT spin_unlock() is identical to spin_unlock_irq() so there
> > > > > is no reason to have a special case using the former.  Furthermore,
> > > > > spin_unlock() enables preemption meaning that a task in RESUMING or
> > > > > SUSPENDING state may be preempted by a higher priority task running
> > > > > pm_runtime_get_sync() leading to a livelock.
> > > > >
> > > > > Use the non-irq_safe path for all waiting so that the waiting task will
> > > > > block.
> > > > >
> > > > > Note that this changes only the waiting behaviour of irq_safe, other
> > > > > uses are left unchanged so that the parent device always remains active
> > > > > in the same way as !RT.
> > > > >
> > > > > Signed-off-by: John Keeping <john@metanate.com>
> > > >
> > > > So basically, the idea is that the irq_safe flag should have no effect
> > > > when CONFIG_PREEMPT_RT is set, right?
> > > >
> > > > Wouldn't it be cleaner to make it not present at all in that case?
> > >
> > > Yes, just replacing pm_runtime_irq_safe() with an empty function would
> > > also fix it, but I'm not sure if that will have unexpected effects from
> > > the parent device suspending/resuming, especially in terms of latency
> > > for handling interrupts.
> >
> > Well, the code as is doesn't work with CONFIG_PREEMPT_RT set anyway in general.
> >
> > Also this is not just pm_runtime_irq_safe(), but every access to this
> > flag (and there's more  of them than just the ones changed below).
> >
> > What about putting the flag under #ifdef CONFIG_PREEMPT_RT and
> > providing read/write accessor helpers for it that will be empty in
> > RT-enabled kernels?
>
> That's the other approach I considered, but there are really two things
> that irq_safe means here:
>
> 1) Call the suspend/resume hooks with interrupts disabled
>
> 2) Keep the parent device running and make other changes that allow (1)
>    on non-RT systems (for example in amba_pm_runtime_suspend() leave the
>    clock prepared when irq_safe is set, but unprepare it otherwise)
>
> In the approach of leaving the flag unset on PREEMPT_RT we solve the
> primary problem which is that (1) is irrelevant on RT, but that would
> also affect (2) and I'm not sure whether that's desirable or not.
>
> It's quite possible the answer is that the other changes don't matter
> and we should take the simpler approach of just removing irq_safe under
> CONFIG_PREEMPT_RT.  I'm becoming convinced that this is the right
> answer, but I'm not confident that I fully understand the wider
> ramifications.

The initial motivation for adding irq_safe was to allow interrupt
handlers of some devices to use PM-runtime, but in RT kernels that's
possible regardless IIUC, so I don't see a reason for having irq_safe
at all in that case.
