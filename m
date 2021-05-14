Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B1D3806EF
	for <lists+linux-pm@lfdr.de>; Fri, 14 May 2021 12:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhENKMY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 May 2021 06:12:24 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:39517 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhENKMX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 May 2021 06:12:23 -0400
Received: by mail-ot1-f41.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so12603464otc.6;
        Fri, 14 May 2021 03:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1frAcle0xk2gR8t85H1l0WPIrvdb4SY2cADbzHYmfYQ=;
        b=LcRipsIafuJiQNxqJvHph4AuwegRi8S1rQaeJRacdoHF1k271EQAhQVfy14mRBQwZd
         WMJQSwUa3OctM5zwDSQNyP1bzZXmjxSrCe+MeVw3vmddQFgSwtgYbaDFMgiqso3NZ+sE
         DiWH/W713EQvQKr0nvGUnrZ9UkXuuqhIulQXqSwgDi3y2QAUldG7EaBlFfTIZYQ9TIf3
         Fn/yIsOA8612VcYT0zE8pjEhpMIMBCFLRCPTsTXidAj9ubgEjTM+f2YyMHTgg30XyRuW
         WU4gCfacd2wJ00UEyURilFfrIdTE6HOd9FC5I7WogbYUAMiCT+pNUXj+wye6G4nk3H9n
         +e6A==
X-Gm-Message-State: AOAM532lPFztg/F4k7VEmbHl1sk7aFnQbftkjXCoKxL5D0EeknJ6Xqhd
        5G9j2opaRUH81XJF8Jy7HiIW3Gt19F76bVQjAuU=
X-Google-Smtp-Source: ABdhPJxHg72RaLNhjFK46jarjDSTDULVNMqGfdmCOB6JuYruvk92QpxBrLk+Pjm02QV0cL7XdV593dXo1/yNndOp91M=
X-Received: by 2002:a9d:3bcb:: with SMTP id k69mr40631462otc.206.1620987072237;
 Fri, 14 May 2021 03:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <8436da08-4812-d383-8f2a-1c07181ebfb8@gmail.com> <YJ4hrrUkKRkKsUtf@gmail.com>
In-Reply-To: <YJ4hrrUkKRkKsUtf@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 May 2021 12:11:00 +0200
Message-ID: <CAJZ5v0h0Z3pfwpL2SsJ53=SfqE2d+7PrG+nt0PXjYrqeAkc27g@mail.gmail.com>
Subject: Re: [PATCH] x86/acpi: Switch to pr_xxx log functions
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 14, 2021 at 9:07 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> > Switching to pr_debug et al has two benefits:
> > - We don't have to add PREFIX to each log statement
> > - Debug output is suppressed except DEBUG is defined or dynamic
> >   debugging is enabled for the respective code piece.
> >
> > In addition ensure that longer messages aren't split to multiple lines
> > in source code, checkpatch complains otherwise.
> >
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > ---
> >  arch/x86/kernel/acpi/boot.c | 118 ++++++++++++++----------------------
> >  1 file changed, 47 insertions(+), 71 deletions(-)
>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>

So I'm going to take this through the ACPI tree if that's OK.
