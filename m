Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C625F2736A5
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 01:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgIUX3L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Sep 2020 19:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUX3L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2020 19:29:11 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BE7C061755
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2020 16:29:10 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u8so15972111lff.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2020 16:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhpvAZ3QErKtUDQl7kJDzrjuCD9QQ90HcO/B4IQrDrI=;
        b=ErhlL2wMGJFM/QNL+KbYCiAAKOWrQijX/gN+f1xx8U0cagqtSYaVr8wYsg00BjLzxx
         0YyOVt54yWPhwFYFRtg/y+Lks95cV6JY8ef4GlavUbMApcs27uC9Y+boxrw7GnYuQJW4
         2/tQBuwZ0oEVjyUMGe8bqInifFd6VJaenyM5Sgy3gPJpJAibgLScsMthO2Zw0pu0M7du
         LLdAAxsFU+qvcTGzrChilGjTiH08PMt1RvPiv0jsy/p6XhqTamaqVKlB6cQ6N9C5XNV6
         1oa6Hs9NiIPq8rAWnNciqvdmgCw5g1TUmazAjrMyWxv8SeqaZiBSHnKy33HLU5dxzv1u
         reYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhpvAZ3QErKtUDQl7kJDzrjuCD9QQ90HcO/B4IQrDrI=;
        b=AZDj0cygv2tGX/4/esKAEMISsitKzVRli80mES3OK6rqh3d0hPM7mV6d/LHaMC3VDC
         FhB3cumEkruJcqod+ho3t3yzPEcwl8zeZbOYI2ldekU8ix49Cz9q1im5z9bbDgzARHQD
         CNGf5VZFVZ/i94ySyHBhgs9zG8XEmYIWBmfi+GlIOG7tsaOOYilDsa22GTW60gzh0w38
         SDgVXYMLRSvl+NJnOY61Zl6YxQZzDFPKzCuJvwmYoBd3fFK49o+Mj9ejnLfvSgwRuev8
         0tEcVnjRUVYtsZ1xXeagVjp1vBHRrnPvJeGSrbOMLLdPDNtsT+ypq22CrRx+tJ69JASy
         3BHw==
X-Gm-Message-State: AOAM533HD7oS7VNe3uX6Pt9bT/8oUZJRTwdo0Nz7h4gs0UsuSVCeEqoH
        Grww/jh97/6LBwufKmm2WOEZlyo3VrvUl3dk4tw92w==
X-Google-Smtp-Source: ABdhPJz4YutrmrjOwYZG2RGNgLOZ0aUYNOGbqakuENM0brWNTF2tMcddEnlheCzTQcWh6UftGJr12yvyrGh7Jya1nQk=
X-Received: by 2002:a19:dc13:: with SMTP id t19mr617798lfg.350.1600730948713;
 Mon, 21 Sep 2020 16:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200915172658.1432732-1-rkir@google.com> <20200915174643.GT14436@zn.tnic>
 <CAOGAQepp_1QXrNAAXbLpW8qrujfdszfU2rMoh804wKK-Ja66Yw@mail.gmail.com>
 <20200915182730.GW14436@zn.tnic> <CAOGAQeqhKS48Kd8W4y13ATT3m+nJSksF_U1SJ=SBrOZFrDq9Nw@mail.gmail.com>
 <20200918222531.GD7443@duo.ucw.cz>
In-Reply-To: <20200918222531.GD7443@duo.ucw.cz>
From:   Roman Kiryanov <rkir@google.com>
Date:   Mon, 21 Sep 2020 16:28:57 -0700
Message-ID: <CAOGAQepVWwMvA_m_kZpwQ4UN+ziR+=w2auiL1euFyuGvyCU7SQ@mail.gmail.com>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
To:     Pavel Machek <pavel@denx.de>
Cc:     Borislav Petkov <bp@alien8.de>, rjw@rjwysocki.net,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alistair Delva <adelva@google.com>,
        Haitao Shan <hshan@google.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 18, 2020 at 3:25 PM Pavel Machek <pavel@denx.de> wrote:
>
> On Tue 2020-09-15 11:36:13, Roman Kiryanov wrote:
> > On Tue, Sep 15, 2020 at 11:27 AM Borislav Petkov <bp@alien8.de> wrote:
> > > > I believe the kernel makes a questionable assumption on how clang
> > > > uses registers (gs will not be used if stack protection is disabled).
> > > > Both kernel and clang behaves unfortunate here.
> > >
> > > If the kernel is at fault here and this same thing happens with GCC,
> > > sure, but this is a clang-specific fix.
> >
> > This is fair. Unfortunately I am not an x86 asm expert. I expect the proper
> > fix should land into arch/x86/kernel/acpi/wakeup_64.S to init %gs
> > (maybe some more registers) before "jmp restore_processor_state".
>
> That would certainly be nicer / more acceptable solution than patch
> being proposed here.
>
> Code was written with assumption compiler random C code would not use
> %gs. If that's no longer true, fixing it in wakeup_64.S _with comments
> explaining what goes on_ might be solution.

I looked and restore_processor_state is referenced in several places,
so changing
wakeup_64.S is not enough. Is moving the beginning of restore_processor_state
to an .S file ok? I see restore_processor_state initializes CR registers first,
do you know if there is a reason to do so (can I init segment
registers before CR ones)?

Regards,
Roman.
