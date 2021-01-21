Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A269C2FED36
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 15:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbhAUOoE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 09:44:04 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:38592 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732125AbhAUOnl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 09:43:41 -0500
Received: by mail-ot1-f53.google.com with SMTP id 34so1785955otd.5
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 06:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sXc33hxdRpwQJGKZjxNyVIcjvQKvzTxYx/3Q/uncr5E=;
        b=LQ7yhYFqyFAd2Kt8vCOnXt5iRDluGCHmdLHna56L/18R5LVHKJ2IpCyd2+EK2BFrSF
         LfwluhtZs7f29mOgWWlFmG5FpdMlXg9orzBcIr+B2h77iNQWQL2un97jqvqfY34vHEzX
         fdveT7AP7PxeHG0rH51cxF73zKi24RQ7JM+grzJV9m8Wsqgqt8xouOx7Ku8mKgsVCpPC
         +QVFVZ4afO1pm3a0qZxkUND8xa2fJYEdZACNWJscqx126wXPTQLvETibhkDYeXNHdrlu
         hAy/U4rU7y35eFnpu1LNlY/Jt2zfp9oUxTB4BjPVxn59hTpSS4h8kfySy8PE81BxgbqA
         8bJA==
X-Gm-Message-State: AOAM530t95sx/h2RUCFCJJLEGNcB8oKY5c/RvqCLQHgcxRraiueUTHzy
        7qXkcER5998oJw3YXaft/iBpe9ulAHdHTQo0HejIR+uS
X-Google-Smtp-Source: ABdhPJxPMAvoP0Dey6wXSHoUWIQQi4nNGO0bp/XQ7Noq3Wi0WUWWAwDvGkd1VDInoBf4Pn0Quw+NpQ5b5WQMeBioCpc=
X-Received: by 2002:a9d:1710:: with SMTP id i16mr10453816ota.260.1611240178606;
 Thu, 21 Jan 2021 06:42:58 -0800 (PST)
MIME-Version: 1.0
References: <20201118185917.GA433776@mwanda> <20210120093015.GE20161@MiWiFi-R3L-srv>
 <CAFgQCTubgqy3ANR_oPH9w_OZ1Mm0a0daWT7SAFhXx3QX+-vHBQ@mail.gmail.com>
In-Reply-To: <CAFgQCTubgqy3ANR_oPH9w_OZ1Mm0a0daWT7SAFhXx3QX+-vHBQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Jan 2021 15:42:46 +0100
Message-ID: <CAJZ5v0jgTyXQxPVQoM4nykk7gcWfNw9bXTQO8856vkYD8TJOCg@mail.gmail.com>
Subject: Re: [bug report] PM / reboot: Eliminate race between reboot and suspend
To:     Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 21, 2021 at 10:14 AM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Wed, Jan 20, 2021 at 5:30 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > Hi,
> >
> > On 11/18/20 at 09:59pm, Dan Carpenter wrote:
> > > Hello Pingfan Liu,
> > >
> > > The patch 55f2503c3b69: "PM / reboot: Eliminate race between reboot
> > > and suspend" from Jul 31, 2018, leads to the following static checker
> > > warning:
> > >
> > >       kernel/power/main.c:27 lock_system_sleep()
> > >       warn: called with lock held.  '&system_transition_mutex'
> >
> > This is a good finding. I think we can simply remove the lock/unlock
> > pair of system_transition_mutex in kernel_kexec() function. The dead
> > lock should be easily triggered, but it hasn't caused any failure report
> > because the feature 'kexec jump' is almost not used by anyone as far as
> > I know. We may need to find out who is using it and where it's used
> > through an inquiry. Before that, we can just remove the lock operation
> > inside CONFIG_KEXEC_JUMP ifdeffery scope. Thanks.
> >
> >
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index 80905e5aa8ae..a0b6780740c8 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -1134,7 +1134,6 @@ int kernel_kexec(void)
> >
> >  #ifdef CONFIG_KEXEC_JUMP
> >         if (kexec_image->preserve_context) {
> > -               lock_system_sleep();
> >                 pm_prepare_console();
> >                 error = freeze_processes();
> >                 if (error) {
> > @@ -1197,7 +1196,6 @@ int kernel_kexec(void)
> >                 thaw_processes();
> >   Restore_console:
> >                 pm_restore_console();
> > -               unlock_system_sleep();
>
> This should work since the only caller syscall_reboot has already
> placed kernel_kexec() under the protection of system_transition_mutex.
>
> Thanks for the fix.
>
> Reviewed-by: Pingfan Liu <kernelfans@gmail.com>

OK, so can anyone please submit that patch formally (Cc linux-pm, please)?
