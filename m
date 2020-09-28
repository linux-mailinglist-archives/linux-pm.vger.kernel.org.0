Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3D627AFB6
	for <lists+linux-pm@lfdr.de>; Mon, 28 Sep 2020 16:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgI1OKx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Sep 2020 10:10:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40970 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgI1OKw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2020 10:10:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id q21so1017284ota.8;
        Mon, 28 Sep 2020 07:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2sM12ZeK0z1tSNxQRVSSWCLi5jDZGPNS8m7K+6sRVao=;
        b=OWD79MGyqIOE5fHO53MPeWlK4vPkk4Sde63QKpjGUi5buaCLiK3o4ADnWoLfbCcGI1
         nTV5Y6P28Dokqh+zsl6pzna8PWT9omN6xW4+cN6ITInWUq9wkSA3Nx9gqrUjAJZTiHbq
         tT7qhPqzPoM/AOMZtueM4wV/13e9fZewU1w8Nr/Kf4sBAzrHaNbeI+PxOex69xg8h6cU
         wMrhCXwX9HzkxyaAMzmnkgBWbkTHT3490jBDVh6D0z8aSsEYTgqzffeAyfN1Wt04sLTM
         MwNgB8vZNzsBJqmekw3+JZWsjiTTYmjGfIBxKRWG9CcNs2hBooJag2/Pj/FAkEcd9vyE
         //2Q==
X-Gm-Message-State: AOAM532xhvlTNYMebyj/BEoFqJqzthMjBkDz7NHp5K37KeaI7NsBqJf9
        JuPgTKCxVRVVbmaGew0OnAKul9LR/l03wN0ogUo=
X-Google-Smtp-Source: ABdhPJzoRcZtx0KR+JiVPrhbYB+WXxT604oAjCIQ0JUATh9EyZHxwpAfE2Rm0/6BIsROa8t6jNpV1RiZbkd6WDpqdb8=
X-Received: by 2002:a9d:718a:: with SMTP id o10mr1097527otj.262.1601302251909;
 Mon, 28 Sep 2020 07:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <00d901d693a4$93195980$b94c0c80$@gmail.com>
In-Reply-To: <00d901d693a4$93195980$b94c0c80$@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 28 Sep 2020 16:10:36 +0200
Message-ID: <CAJZ5v0ivZnvVbY4WyM1SQO1TY=G8yb4=C0kWkVQPas5=NX1Sog@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: change #ifdef for the declaration of cpuidle_enter_s2idle()
To:     zhuguangqing83 <zhuguangqing83@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zhuguangqing <zhuguangqing@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Sep 26, 2020 at 3:30 AM zhuguangqing83 <zhuguangqing83@gmail.com> wrote:
>
>
> > On Thu, Sep 24, 2020 at 10:01 AM <zhuguangqing83@gmail.com> wrote:
> > >
> > > From: zhuguangqing <zhuguangqing@xiaomi.com>
> > >
> > > Currently, if CONFIG_SUSPEND=n and CONFIG_CPU_IDLE=y, the function
> > > cpuidle_enter_s2idle() is declared but not defined, it may cause error
> > > when cpuidle_enter_s2idle() is called.
> > >
> > > If CONFIG_SUSPEND=y and CONFIG_CPU_IDLE=n, the function
> > > cpuidle_enter_s2idle() is defined as "return -ENODEV;" which is not
> > > supposed to be.
> > >
> > > Change #ifdef CONFIG_CPU_IDLE to #ifdef CONFIG_SUSPEND for
> > > cpuidle_enter_s2idle() in cpuidle.h, which is consistent with its
> > > defination in cpuidle.c.
> >
> > Well, what about the case when CONFIG_SUSPEND is set, but CONFIG_CPU_IDLE
> > isn't?
> >
>
> When CONFIG_SUSPEND is set, but CONFIG_CPU_IDLE isn't, the function
> cpuidle_enter_s2idle() is defined in cpuidle.c, but the defination in
> cpuidle.c is not used actually because CONFIG_CPU_IDLE isn't set, we
> only use its defination as "return -ENODEV;" in cpuidle.h.

Actually, if CONFIG_CPU_IDLE is not set, cpuidle.c is not compiled at
all AFAICS, but after the $subject patch the compiler will be looking
for cpuidle_enter_s2idle() in that case, won't it? [The static inline
stub is only present for CONFIG_SUSPEND unset.]

> > > Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
> > > ---
> > >  include/linux/cpuidle.h | 14 +++++++++-----
> > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> > > index 6175c77bf25e..2aa8cead1727 100644
> > > --- a/include/linux/cpuidle.h
> > > +++ b/include/linux/cpuidle.h
> > > @@ -216,22 +216,26 @@ static inline struct cpuidle_device
> > *cpuidle_get_device(void) {return NULL; }
> > >  extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> > >                                       struct cpuidle_device *dev,
> > >                                       u64 latency_limit_ns);
> > > -extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
> > > -                               struct cpuidle_device *dev);
> > >  extern void cpuidle_use_deepest_state(u64 latency_limit_ns);
> > >  #else
> > >  static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> > >                                              struct cpuidle_device *dev,
> > >                                              u64 latency_limit_ns)
> > >  {return -ENODEV; }
> > > -static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
> > > -                                      struct cpuidle_device *dev)
> > > -{return -ENODEV; }
> > >  static inline void cpuidle_use_deepest_state(u64 latency_limit_ns)
> > >  {
> > >  }
> > >  #endif
> > >
> > > +#ifdef CONFIG_SUSPEND
> > > +extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
> > > +                               struct cpuidle_device *dev);
> > > +#else
> > > +static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
> > > +                                      struct cpuidle_device *dev)
> > > +{return -ENODEV; }
> > > +#endif
> > > +
> > >  /* kernel/sched/idle.c */
> > >  extern void sched_idle_set_state(struct cpuidle_state *idle_state);
> > >  extern void default_idle_call(void);
> > > --
> > > 2.17.1
> > >
>
