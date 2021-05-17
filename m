Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E5B3836B9
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 17:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243360AbhEQPf0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 11:35:26 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:35496 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244990AbhEQPd2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 11:33:28 -0400
Received: by mail-ot1-f42.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so5896917otg.2;
        Mon, 17 May 2021 08:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLabWeFWWUTFvcwZHvdf6d9/NKDpE7SLOGHOguQ8yP0=;
        b=Rt4gTDxAbTpYvZzySezezBQfpHXfPqz9mHJvkBhwm0HPBIjIGGQCVvOjwx94JEIPc6
         q9Dqh6qhDDqXqDh11PVH0FIkoSTwRtfBfSwGSeYcb6TXpDyOpnYPYq+hKY9aHWqe3/c9
         hhhuMzTmSBQuM9uzz7X2z7c6X3UT39riNzOac4xcgn5jydN/TjZCCEEUJRXTDhWaVzqS
         pcPAoH3tyRE6BPtFm8pScfKKee8nB7Xh8Ybkqx4SlqrJWMBETOg6g3YMH8xZQ/W46UdO
         XnAitpCItgDNOictpmAKzbuRqACnnLTllZ9jwbd08ayQxEEcYyNncTBiv2P/0OunCqsE
         35Hw==
X-Gm-Message-State: AOAM5302jCm//YKof3/U5zBkHj8sQIcM/UXk3h12QXz6MNokEpP1+Oue
        EXOZyickEC0wBVjKrOqyiHe8pS1MNwnLOXW1bjU=
X-Google-Smtp-Source: ABdhPJz8EaCRfO+89bvTzzIpwv9fxsJQPwePYnpt5jdL657j8M4bnnBiEHAfUXlkhLZIIb+awOW8EVF4DZefr8M3qcA=
X-Received: by 2002:a9d:1e1:: with SMTP id e88mr141134ote.260.1621265530975;
 Mon, 17 May 2021 08:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <8436da08-4812-d383-8f2a-1c07181ebfb8@gmail.com>
 <YJ4hrrUkKRkKsUtf@gmail.com> <CAJZ5v0h0Z3pfwpL2SsJ53=SfqE2d+7PrG+nt0PXjYrqeAkc27g@mail.gmail.com>
 <YJ5O5gytKMDOCnFz@gmail.com>
In-Reply-To: <YJ5O5gytKMDOCnFz@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 May 2021 17:31:59 +0200
Message-ID: <CAJZ5v0gE4GC6R=FW39Xp_xiLzc0RgPGu0VJygz4gN-OOBr4YCg@mail.gmail.com>
Subject: Re: [PATCH] x86/acpi: Switch to pr_xxx log functions
To:     Ingo Molnar <mingo@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Fri, May 14, 2021 at 12:20 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> > On Fri, May 14, 2021 at 9:07 AM Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >
> > > * Heiner Kallweit <hkallweit1@gmail.com> wrote:
> > >
> > > > Switching to pr_debug et al has two benefits:
> > > > - We don't have to add PREFIX to each log statement
> > > > - Debug output is suppressed except DEBUG is defined or dynamic
> > > >   debugging is enabled for the respective code piece.
> > > >
> > > > In addition ensure that longer messages aren't split to multiple lines
> > > > in source code, checkpatch complains otherwise.
> > > >
> > > > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > > > ---
> > > >  arch/x86/kernel/acpi/boot.c | 118 ++++++++++++++----------------------
> > > >  1 file changed, 47 insertions(+), 71 deletions(-)
> > >
> > > Reviewed-by: Ingo Molnar <mingo@kernel.org>
> >
> > So I'm going to take this through the ACPI tree if that's OK.
>
> Sure!

So applied as 5.14 material, thanks!
