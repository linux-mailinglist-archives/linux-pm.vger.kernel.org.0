Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667DE3A01F3
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 21:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbhFHS6S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 14:58:18 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:35675 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbhFHS4P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 14:56:15 -0400
Received: by mail-lf1-f46.google.com with SMTP id i10so33749939lfj.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Jun 2021 11:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XH/3SBzhXEZinQRmZMjAfIGu0JUbJo2MQXLpr1qwFmk=;
        b=CbTtmukjRPYewEoWFqp1sRz6oSiH0zZb4mGBHEa4nRRWAU8+EcBzOal+ROP5WBXR5x
         JrRd3XFOeNYJdFs7j4wwrN51j3iRzmFxuYz5Y1baQLAEhXVcCPWQX8Rh+QNU1CfWheAo
         jkbZ93/skrcSmMajQAsvfoqbVACDfCPcQk525e/YOT9S5Dm+wlyEKqB1/TCSh1y8id4u
         tqTKYJOT5FYnUJfvbq+NQ0qgjjIg6x8rATA+9dLGjJRXbyDKWLEobCF7i6okmarHEaWV
         Y9PRz9VRzMiZPhldY+dBeeogHR4wuISY4reP4T++0Az0qZX/04658c1wUFIQ6+8wys8k
         O1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XH/3SBzhXEZinQRmZMjAfIGu0JUbJo2MQXLpr1qwFmk=;
        b=JGvYfMBoox04InOOS/mA4OLNe6zO4sBhDUZIubBIjpF2jRbyOy5MqxVMgJZ3BQS3xt
         wZIipUuSYTaBWweKOAv37jMOL+9VUNFqQNKbZHDrWDH2JGj3PujKUI7nvZIa3b6Smr1f
         bo4YlA1+IfKbY2yyrjsnZ23Hi/HMWhSuELg97imFatCIJtlmWhVrjxDGCEcT+PU9kWn+
         /Dr7zEEQ9xkKRm0e94YS+I6TFRUh6RBEeMfVsT+BepLvgd1OFifW7xwEkLusAIpSbjew
         4H6PqpsPbp/4OKkLqR5CdMWPOgkZ9F4ZcoiEomaBG9TEt0clzOxpWYu6WE9xoYYP1/Jh
         620w==
X-Gm-Message-State: AOAM532A942H7cPgGTjaEwTWiE3zMlnyshL4S7/8zhEzXV0JxZCwTf1Q
        SNUZVY69AeXMmQg8tluAHjMNhBoTQH+pXf0PRQNo8A==
X-Google-Smtp-Source: ABdhPJwWbRzEQbfxYswo9wdvvhXIaN36rmEXPktIvShQZ1REoqLGro/C4yPvO7BE/TlBKdYNXLz9J+72h5tMkyhMTF8=
X-Received: by 2002:ac2:5cd6:: with SMTP id f22mr17251433lfq.73.1623178399858;
 Tue, 08 Jun 2021 11:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <1623145562-111662-1-git-send-email-yang.lee@linux.alibaba.com>
 <CAKwvOdmyXV09ZxcDqQ6x43f+Eze4h40W2AoKcCmUhGM2gUWsnQ@mail.gmail.com> <6335deba-9e94-61e0-89a1-8905be0e35a1@kernel.org>
In-Reply-To: <6335deba-9e94-61e0-89a1-8905be0e35a1@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Jun 2021 11:53:09 -0700
Message-ID: <CAKwvOdmOOvOBzZ+fNaOxMSDVonkTETmowtD5-4FTFGniNjbObQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: devfreq_cooling: Fix kernel-doc
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 8, 2021 at 11:49 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On 6/8/2021 11:39 AM, Nick Desaulniers wrote:
> > On Tue, Jun 8, 2021 at 2:46 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
> >>
> >> Fix function name in devfreq_cooling.c kernel-doc comment
> >> to remove a warning found by clang(make W=1 LLVM=1).

Ah, good find. In that case I'd be happy to sign off on a V2 that
replaced s/clang(make W=1 LLVM=1)/kernel-doc/.

> >>
> >> drivers/thermal/devfreq_cooling.c:479: warning: expecting prototype for
> >> devfreq_cooling_em_register_power(). Prototype was for
> >> devfreq_cooling_em_register() instead.
> >>
> >> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> >> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> >
> > That compiler warning doesn't come from kernel-doc.  Your diff looks
> > good (the comment was wrong), but the commit message is curious.
>
> No, this is indeed kernel-doc complaining. Clang should not even be
> mentioned in the commit message:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/kernel-doc?h=v5.13-rc5#n1228
>
> The warning could probably be improved to say "definition" instead of
> "prototype" in certain cases but *shrugs*.
>
> This warning is similar to -Wmissing-prototypes from clang but refers to
> the fact that the comment claims it is documenting one function but it
> is really documenting another.
>
> Cheers,
> Nathan
>
> > Usually that warning is from when the function prototype does not
> > exist for a function with extern linkage.  It looks like that's always
> > provided though in include/linux/devfreq_cooling.h.  Can you share a
> > link to the original report?
> >
> >> ---
> >>   drivers/thermal/devfreq_cooling.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> >> index 3a788ac..5a86cff 100644
> >> --- a/drivers/thermal/devfreq_cooling.c
> >> +++ b/drivers/thermal/devfreq_cooling.c
> >> @@ -458,7 +458,7 @@ struct thermal_cooling_device *devfreq_cooling_register(struct devfreq *df)
> >>   EXPORT_SYMBOL_GPL(devfreq_cooling_register);
> >>
> >>   /**
> >> - * devfreq_cooling_em_register_power() - Register devfreq cooling device with
> >> + * devfreq_cooling_em_register() - Register devfreq cooling device with
> >>    *             power information and automatically register Energy Model (EM)
> >>    * @df:                Pointer to devfreq device.
> >>    * @dfc_power: Pointer to devfreq_cooling_power.
> >> --
> >> 1.8.3.1
> >>
> >
> >



-- 
Thanks,
~Nick Desaulniers
