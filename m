Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7D341F529
	for <lists+linux-pm@lfdr.de>; Fri,  1 Oct 2021 20:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354717AbhJASsS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Oct 2021 14:48:18 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:37663 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354962AbhJASsO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Oct 2021 14:48:14 -0400
Received: by mail-ot1-f44.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so12663185otv.4;
        Fri, 01 Oct 2021 11:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7yRXWQ17PDq/9rpsrXk8SpeM8Jg41VijPQ+igXLEZY=;
        b=eWfyI3OwhWiIIz9AnEjPp9l0Q6Kd1u2YqPSRAmQE6NpCz+NihGNquCPK2XkZalp60k
         cDRQXAf62w3kYPnFJbTWxU7k/4XX95fHjfRTQNCsoXfH4ouq1cvbJ2k0vJ6QnlcaNcdi
         nCZ/12dO8HXFvspVOKNNfV4uiV5bDM080t22/Udo3wa/2t0PWB0Ss5YdJtCs3tMskVHv
         rZfBtAs6wWowsLHL9pCFgr0QnQisM7ZGZASMlsfhciE36UP7ovopN3/O6XZlwGrGWK/R
         ndUR5hBk+m15m98Ix41VhIF2zAY5lZGuyoPYqjXd3oGAZJia7mW2lNyGuBYKMvQH1lVO
         yj0g==
X-Gm-Message-State: AOAM532wl+B6a7eR3HoYbBDoRCS13Q43i2HNEJEImdO5L/E/EBHIUS55
        mJA2zExEpuFF4opVpc+QBG7JucOlsXPf8RB2dz0=
X-Google-Smtp-Source: ABdhPJyol4d3jfaTbc8PSMSgHqn09rTnci+qMmEOpu+G4rjB+PFKBntee5u3Cniw/RH3F0AN7PAIr9Hl2nFXT2Ijb2M=
X-Received: by 2002:a05:6830:82b:: with SMTP id t11mr11506879ots.319.1633113988759;
 Fri, 01 Oct 2021 11:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210924061205.5523-1-deepak.sharma@amd.com> <CAJZ5v0iS+TnkoqCxLa92Na=By53PXY-qW=k4utr_84KYaw+sVQ@mail.gmail.com>
 <87wnn3bcas.ffs@tglx>
In-Reply-To: <87wnn3bcas.ffs@tglx>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Oct 2021 20:46:17 +0200
Message-ID: <CAJZ5v0ggnbFvpcmKpemF9Kt9hTGNEDHr+zeXhW+yNqz9KSeZsg@mail.gmail.com>
Subject: Re: [RESEND PATCH] x86: ACPI: cstate: Optimize C3 entry on AMD CPUs
To:     Thomas Gleixner <tglx@linutronix.de>,
        Deepak Sharma <deepak.sharma@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Sep 26, 2021 at 5:13 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, Sep 24 2021 at 18:48, Rafael J. Wysocki wrote:
>
> > On Fri, Sep 24, 2021 at 8:12 AM Deepak Sharma <deepak.sharma@amd.com> wrote:
> >>
> >> All Zen or newer CPU which support C3 shares cache. Its not necessary to
> >> flush the caches in software before entering C3. This will cause drop in
> >> performance for the cores which share some caches. ARB_DIS is not used
> >> with current AMD C state implementation. So set related flags correctly.
> >>
> >> Signed-off-by: Deepak Sharma <deepak.sharma@amd.com>
> >
> > I'm planning to take this one unless the x86 maintainers have concerns, thanks.
>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

Thanks!

Applied as 5.16 material, thanks!
