Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2842278B15
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgIYOmI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 10:42:08 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40084 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgIYOmH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 10:42:07 -0400
Received: by mail-oi1-f195.google.com with SMTP id t76so3002924oif.7;
        Fri, 25 Sep 2020 07:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YG0gNwPh92HOAhHCe1SetMmUyiG3vhJKCYpc+sgtuns=;
        b=AaCMKmypEAR0oxhZ87tbPAdEbGxbds21QwSmF9S9d/2nuDLX/xh+eKdUFiypbEZ2Y6
         Fq1wfpXeL3aPOx75BOg5aOK5Wrb0J5xQabnB7AJD8CXxeMj7SKnPA5wCkgyaeuHi011Q
         Ii6VQ6BOj4U5HCYhKzTas0h9JZYaoVw1dkbG0P8UzHbLy1uvKoIR4/2KElZAYHpLiUS2
         9s/txLVz43H6722a3FctMuPslPmeD5pJFegi+QEjLFSHG/13CHXoBOEeeRAR3MNjTJKH
         CQ0ZZYhfjSNn9Ruc/t8ca3JlgBzwtphZdROBO/KAUvdBaCJ5GKn/1slQ4xxETA9P5dUZ
         srhQ==
X-Gm-Message-State: AOAM532olw1F1GPCWyif6EwclGPDfXrZ1bchT4F16BL/kjp+FEbWjUNK
        EG9ECsKdezmgX5+56IDIo8IY9NFovUIF3uHTSvQ=
X-Google-Smtp-Source: ABdhPJxU3jxuaLiKzG8zDH/2eFePJxoIPj8oFAp0fMhiapBAoCnj7xHlIj1YPh+i5qJ+MBniXk6wyRx8+xYVyP9+4pI=
X-Received: by 2002:a05:6808:491:: with SMTP id z17mr463820oid.110.1601044926846;
 Fri, 25 Sep 2020 07:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200924080041.2740-1-zhuguangqing83@gmail.com>
In-Reply-To: <20200924080041.2740-1-zhuguangqing83@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 16:41:56 +0200
Message-ID: <CAJZ5v0ipTw3nwcWp2yYQ7SEpp0jeC8gQRK4nr8T95_UuXmP+HQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: change #ifdef for the declaration of cpuidle_enter_s2idle()
To:     zhuguangqing83@gmail.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zhuguangqing <zhuguangqing@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 24, 2020 at 10:01 AM <zhuguangqing83@gmail.com> wrote:
>
> From: zhuguangqing <zhuguangqing@xiaomi.com>
>
> Currently, if CONFIG_SUSPEND=n and CONFIG_CPU_IDLE=y, the function
> cpuidle_enter_s2idle() is declared but not defined, it may cause error
> when cpuidle_enter_s2idle() is called.
>
> If CONFIG_SUSPEND=y and CONFIG_CPU_IDLE=n, the function
> cpuidle_enter_s2idle() is defined as "return -ENODEV;" which is not
> supposed to be.
>
> Change #ifdef CONFIG_CPU_IDLE to #ifdef CONFIG_SUSPEND for
> cpuidle_enter_s2idle() in cpuidle.h, which is consistent with its
> defination in cpuidle.c.

Well, what about the case when CONFIG_SUSPEND is set, but CONFIG_CPU_IDLE isn't?

>
> Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
> ---
>  include/linux/cpuidle.h | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 6175c77bf25e..2aa8cead1727 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -216,22 +216,26 @@ static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL; }
>  extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>                                       struct cpuidle_device *dev,
>                                       u64 latency_limit_ns);
> -extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
> -                               struct cpuidle_device *dev);
>  extern void cpuidle_use_deepest_state(u64 latency_limit_ns);
>  #else
>  static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>                                              struct cpuidle_device *dev,
>                                              u64 latency_limit_ns)
>  {return -ENODEV; }
> -static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
> -                                      struct cpuidle_device *dev)
> -{return -ENODEV; }
>  static inline void cpuidle_use_deepest_state(u64 latency_limit_ns)
>  {
>  }
>  #endif
>
> +#ifdef CONFIG_SUSPEND
> +extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
> +                               struct cpuidle_device *dev);
> +#else
> +static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
> +                                      struct cpuidle_device *dev)
> +{return -ENODEV; }
> +#endif
> +
>  /* kernel/sched/idle.c */
>  extern void sched_idle_set_state(struct cpuidle_state *idle_state);
>  extern void default_idle_call(void);
> --
> 2.17.1
>
