Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169BE2FE60A
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 10:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbhAUJOV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 04:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbhAUJLI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 04:11:08 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79040C0613CF
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 01:10:27 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id z22so2570972ioh.9
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 01:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1UC4Vr1q+5J2Uy7mwHTSdaridk3Fe0PBXsEt6dmNRU=;
        b=ree/DxaNIueL4Wb6kkZs6kJ5zXE+SH4zAcjPqL1/hsWXn2ZqU/vGDNBHSWvnFijNrD
         Fl230aS/YBgutE6QbjwGnkpfHi4+FAkw1KwALSs7YUSqoOFCQVHchqoAt6MVj/YkCtAi
         wr9mE18EhUO96pxIFH3NHQBY37F1DspLqenv/q3p47KerzEwgCFjMQ3Mc9WsLsLhgkY3
         YombjHiUlU4/GFdfCmpLlKYGOEESP7oaBk+yMFEM6XyxOFStruaxddt48Idt5XBTmHDL
         TBlt8VvaLZmOHDUMMKw1Wf/BRLB1DuOtKqPTgpAgJqH48fjb5teqbnheJ+0CbTN95dkY
         ckJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1UC4Vr1q+5J2Uy7mwHTSdaridk3Fe0PBXsEt6dmNRU=;
        b=qlIAz9MoOyE8IWYRQhgGuEZbeqI03BmSUqBQKtB9PlXgJYsoemyykvgIawHk8BqxZr
         yNsqeUcLUZzlZ/fYGt6kIZjQDXc4+XIiRg213kx4gqn3ezc9XAE3a+xJxLatR9MtdhDZ
         e+nBejSKi5Kx61e5yGDZlJH+z5c0/UHYlMHiSqRELaGhAy15PE0V9RQIbhVw/xAh9kTc
         4vq2WrmsS17rBVYgCY6HD4ck9iWnxrk2g02CT6cqcLNOhQ5Inh/cMVZBLOzTuVX6NhXp
         CBNrq0Px38OxZYHfXy4g+NlzGEHYHMgtAUTezDpLYgWogW2OeYSMwO8WFpvlLXcs+36S
         8Ydw==
X-Gm-Message-State: AOAM530bYnrpuX5We+UcV965kvYGmpq9voJEXqgaq3mqFka5H1MaoLSe
        A7lu0IhKjmJ124UnUMXDUuOKrnXCTzgmlVOHWw==
X-Google-Smtp-Source: ABdhPJyuv0Xn3ESQa+f0IRWD8fUFWmSY5VE2sBAv9nK2AX1huYa+6L4x3oUBZ8RxJqj26SwtzfXq10hEn0qLFiflMBY=
X-Received: by 2002:a92:d107:: with SMTP id a7mr4101095ilb.45.1611220226882;
 Thu, 21 Jan 2021 01:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20201118185917.GA433776@mwanda> <20210120093015.GE20161@MiWiFi-R3L-srv>
In-Reply-To: <20210120093015.GE20161@MiWiFi-R3L-srv>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 21 Jan 2021 17:10:15 +0800
Message-ID: <CAFgQCTubgqy3ANR_oPH9w_OZ1Mm0a0daWT7SAFhXx3QX+-vHBQ@mail.gmail.com>
Subject: Re: [bug report] PM / reboot: Eliminate race between reboot and suspend
To:     Baoquan He <bhe@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        linux-pm@vger.kernel.org, Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 20, 2021 at 5:30 PM Baoquan He <bhe@redhat.com> wrote:
>
> Hi,
>
> On 11/18/20 at 09:59pm, Dan Carpenter wrote:
> > Hello Pingfan Liu,
> >
> > The patch 55f2503c3b69: "PM / reboot: Eliminate race between reboot
> > and suspend" from Jul 31, 2018, leads to the following static checker
> > warning:
> >
> >       kernel/power/main.c:27 lock_system_sleep()
> >       warn: called with lock held.  '&system_transition_mutex'
>
> This is a good finding. I think we can simply remove the lock/unlock
> pair of system_transition_mutex in kernel_kexec() function. The dead
> lock should be easily triggered, but it hasn't caused any failure report
> because the feature 'kexec jump' is almost not used by anyone as far as
> I know. We may need to find out who is using it and where it's used
> through an inquiry. Before that, we can just remove the lock operation
> inside CONFIG_KEXEC_JUMP ifdeffery scope. Thanks.
>
>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 80905e5aa8ae..a0b6780740c8 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1134,7 +1134,6 @@ int kernel_kexec(void)
>
>  #ifdef CONFIG_KEXEC_JUMP
>         if (kexec_image->preserve_context) {
> -               lock_system_sleep();
>                 pm_prepare_console();
>                 error = freeze_processes();
>                 if (error) {
> @@ -1197,7 +1196,6 @@ int kernel_kexec(void)
>                 thaw_processes();
>   Restore_console:
>                 pm_restore_console();
> -               unlock_system_sleep();

This should work since the only caller syscall_reboot has already
placed kernel_kexec() under the protection of system_transition_mutex.

Thanks for the fix.

Reviewed-by: Pingfan Liu <kernelfans@gmail.com>
