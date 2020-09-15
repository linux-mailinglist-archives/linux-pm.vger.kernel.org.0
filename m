Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE6B26ACAA
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgIOS4a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 14:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgIOSzg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 14:55:36 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654A9C06174A
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 11:55:35 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m5so4237582lfp.7
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 11:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXsyDbVr5yEsb37wNopfWhpCBZv90Q/bsc2OJ00Cmiw=;
        b=tfc56KAYUnr6MuSg1LOpNOvk677yL0xfXUFKSEWmhSp0iLOCMpKRw24XQ/uXi5WH2z
         OXnjyddTjvT93gML0OPEuCOCD0MFczZlHboO0q7qCzMEeYToXjrOWzuPv0Z677j//Pl5
         0TAJ6WrdOacGo05o/EYFU8VA5o/XhZ6R+NKOjhCK2Yf4h2/4chJMF9OKQIxNcQ5b/xtl
         /ldi1rAWLWHQV+0BJrKusQBj1XBYcXzZYgJBxwKLJ4LODVJAtyCZL9XC6lifrNvBrSMS
         amFM3H5Wj2HpS9oS+Dzsyvd2F68bIP2iBDm3ygR7kI2yHXZe/rDD/AxJc/P5cdq0TLTb
         g4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXsyDbVr5yEsb37wNopfWhpCBZv90Q/bsc2OJ00Cmiw=;
        b=QMnvUgOa8O8ECMeCvvJRD/CAm3w/lQL/jv+LVJp9BmrHP+I+MsK1YkVzuTf5qF6U7h
         srdwcGm8GpmgjJ+bUGH+CRDpwnni4gosJUt0S/UGC/dWEXOXFgSTlcNJvsSETwNexOYX
         pAs3De/wYDr5Xgs/chTXeIEARC0VZ+D16x2M+06kuBomwJWJ0aL9WjMihbHAma/lg6EF
         DdyC+qzzz4+SjZKfOoUFFGHNTTlF9IQZs21MSO/4T2ErokXosPJOt/3tVrtGIOGh8Nr5
         HN85fbdwUL0NiLF5ZomvOsaeZaZHbbXew9H1WSI9nkalrqctfVYDOgkOWHRh10vwSXSc
         I3BA==
X-Gm-Message-State: AOAM533LH6Pe1Hhz+TBu5rrDTIgWlvub8qvbgtWph1Ceem3vyjz68BBB
        Q4t0NP0HVKvFfL5mcYQUQAEEvJY5ZO+6DWtqlACCQw==
X-Google-Smtp-Source: ABdhPJxnBHvldJLq8O5w+u6tqm7YQBEdDP5mMvcqqzs9kVTAw3WbpW8xl0s4LUcUB7FkCx+1GKE8Unf8sXEaYt1KE6Q=
X-Received: by 2002:a19:a41a:: with SMTP id q26mr6357544lfc.121.1600196133555;
 Tue, 15 Sep 2020 11:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200915172658.1432732-1-rkir@google.com> <20200915174643.GT14436@zn.tnic>
 <CAOGAQepp_1QXrNAAXbLpW8qrujfdszfU2rMoh804wKK-Ja66Yw@mail.gmail.com>
 <20200915182730.GW14436@zn.tnic> <CAOGAQeqhKS48Kd8W4y13ATT3m+nJSksF_U1SJ=SBrOZFrDq9Nw@mail.gmail.com>
 <20200915185210.GY14436@zn.tnic>
In-Reply-To: <20200915185210.GY14436@zn.tnic>
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 15 Sep 2020 11:55:22 -0700
Message-ID: <CAOGAQepHV=7Xk4Xw4vw4+56NhDDvEQ+sYrRr-rHYLUbH_oRUmw@mail.gmail.com>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
To:     Borislav Petkov <bp@alien8.de>
Cc:     rjw@rjwysocki.net, pavel@ucw.cz,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alistair Delva <adelva@google.com>,
        Haitao Shan <hshan@google.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 15, 2020 at 11:52 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Sep 15, 2020 at 11:36:13AM -0700, Roman Kiryanov wrote:
> > This is fair. Unfortunately I am not an x86 asm expert. I expect the proper
> > fix should land into arch/x86/kernel/acpi/wakeup_64.S to init %gs
> > (maybe some more registers) before "jmp restore_processor_state".
>
> ... because "LLVM appears to be inlining functions with stack protectors
> into functions compiled with -fno-stack-protector" and now the *kernel*
> needs to init %gs?
>
> How about LLVM stops doing those wrong inlining decisions?

This will remove the issue for a while until clang/gcc/other decides to use
%gs for other purposes before the kernel initializes it.

Regards,
Roman.
