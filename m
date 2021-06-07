Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD3E39E127
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 17:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhFGPtS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 11:49:18 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:38477 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhFGPtS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 11:49:18 -0400
Received: by mail-ot1-f51.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so3559170otk.5;
        Mon, 07 Jun 2021 08:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HVJhd+u7GmSPZQlKGUKfiKFOtV7NI/wtWT9eN5SSaGI=;
        b=LaR5N/dYn60sbowkQFIRRaS9XpOggHTdVtA3bsHjNFqbT21UX9k6mHsdESty0/N7Zv
         Tw7R0AeFzdx0HZLiMfgtBSi+/Alvdbm2asMo6ul8IBC4tAXUYyWlG1MwYw8F7aczcczk
         2mGon7Riuj109naMkbh2PM3lVDNQ3CdkluYP810Wnd/JnA6wNvJylZ4MhJvLDchVW2Eg
         4zQqb9Ek37lUUUQ02axiKR/9NAIbm/1yvYxni78dSUHPoLomEaEF1JQ2M2V75pLcipju
         J98YncfJN+po9do/UP7G2SQTi/4IA1WvTE73jUMA5bxhSs73CI1le/vANmVlUviiF0ak
         a2dQ==
X-Gm-Message-State: AOAM531fQh0G/OM2DdVKsnzFXxW66n4RMihbaoJCa77W9MAwQr8Cn2vT
        0zuZv+p8NJ43kVhPQs6eKBWpOYxlWeHefCeQJe5Q86sF
X-Google-Smtp-Source: ABdhPJzzxMbMUs+hYRb9oWPT+tkkivNnJEMnG+1ac2FghMDYJe7smOyj2wbrwyRFPYv7cEZz923eTvTboHHm6v4O+Ww=
X-Received: by 2002:a9d:63cd:: with SMTP id e13mr14859434otl.206.1623080846492;
 Mon, 07 Jun 2021 08:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210606115828.27020-1-liuhailongg6@163.com> <20210607032726.rolhnshkctluepw2@vireshk-i7>
In-Reply-To: <20210607032726.rolhnshkctluepw2@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 17:47:15 +0200
Message-ID: <CAJZ5v0itSWZQX4dVYGDq2pg6S+eeOYwh8U+3B2D1fq5qUqrZHQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: sh: Remove unused linux/sched.h headers
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Hailong Liu <liuhailongg6@163.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hailong Liu <liu.hailong6@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 7, 2021 at 5:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 06-06-21, 19:58, Hailong Liu wrote:
> > From: Hailong Liu <liu.hailong6@zte.com.cn>
> >
> > Since commit '205dcc1ecbc5(cpufreq/sh: Replace racy task affinity logic)'
> > the header <linux/sched.h> is useless in sh-cpufreq.c, so remove it.
> >
> > Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
> > ---
> >  drivers/cpufreq/sh-cpufreq.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
> > index 0ac265d47ef0..1a251e635ebd 100644
> > --- a/drivers/cpufreq/sh-cpufreq.c
> > +++ b/drivers/cpufreq/sh-cpufreq.c
> > @@ -23,7 +23,6 @@
> >  #include <linux/cpumask.h>
> >  #include <linux/cpu.h>
> >  #include <linux/smp.h>
> > -#include <linux/sched.h>     /* set_cpus_allowed() */
> >  #include <linux/clk.h>
> >  #include <linux/percpu.h>
> >  #include <linux/sh_clk.h>
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 5.14 material, thanks!
