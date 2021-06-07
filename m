Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400D739E12B
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 17:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFGPuU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 11:50:20 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:34459 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhFGPuU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 11:50:20 -0400
Received: by mail-oi1-f178.google.com with SMTP id u11so18518258oiv.1;
        Mon, 07 Jun 2021 08:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPvwNDXxveM7WvcIICOfOWncBvlog3gstf62jTYMMds=;
        b=jeF5Ma6BQ5C7npYESN0TWwnoLR4CXxiYmvbqUxEihZ3z7NIi44qRp4iC0rjdj3ItPd
         M642fzX5xjznfZduL3GkgtQ0APAc6IcnG6PPBgAGoxwi2KlkEeaGPTjF+0zqFDJBpe+4
         qmKDmrBRdDyOi7b4P4kOMECoMK5tvQJUNxQG150eYPfFP8r0JaNTR2JiCURnVwwNd4wH
         ZAlF5fTA/ggopX5glMOpVZ13cSrMAHk8fBfjO0fegi9Cr3ONFRGOAJSfOwqnKh/TrFJj
         UUZ3flQ1VqCahZ6fJRwrCqHlGJ3/kk8WvNP3d5PApS3NKMnFiNbYgc1RDuYitLvGEVTx
         pyDw==
X-Gm-Message-State: AOAM530h3PA+Y9w0ToDpef48D8R7gYMU2/6IpQ6wFIle4Ls+Cm5pPtNQ
        iW5Ai57GYM0xr6aUKAaqKvIM7S9MZ7ZeLWqvZRc=
X-Google-Smtp-Source: ABdhPJxP16Qu0fj4N3ExB40QCYrAreA9thdjxDCBWKRQdvwtM+7ghjwsMC2iFuaRODH9D8ePpEZkxHB7o+tA4bkXwJs=
X-Received: by 2002:aca:b406:: with SMTP id d6mr11781753oif.71.1623080897693;
 Mon, 07 Jun 2021 08:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210603135752.30162-1-liuhailongg6@163.com> <20210604034709.kxqy6vcfvtxf5rje@vireshk-i7>
In-Reply-To: <20210604034709.kxqy6vcfvtxf5rje@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 17:48:06 +0200
Message-ID: <CAJZ5v0he09ttX-EnXukHcqk4okdp1ag7dEH3BQQ_AsPOMMOBpg@mail.gmail.com>
Subject: Re: [PATCH] CPUFREQ: loongson2: Remove unused linux/sched.h headers
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Hailong Liu <liuhailongg6@163.com>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-mips@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hailong Liu <liu.hailong6@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 4, 2021 at 5:48 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 03-06-21, 21:57, Hailong Liu wrote:
> > From: Hailong Liu <liu.hailong6@zte.com.cn>
> >
> > Since commit 759f534e93ac(CPUFREQ: Loongson2: drop set_cpus_allowed_ptr()),
> > the header <linux/sched.h> is useless in oongson2_cpufreq.c, so remove it.
> >
> > Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
> > ---
> >  drivers/cpufreq/loongson2_cpufreq.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
> > index d05e761d9572..afc59b292153 100644
> > --- a/drivers/cpufreq/loongson2_cpufreq.c
> > +++ b/drivers/cpufreq/loongson2_cpufreq.c
> > @@ -16,7 +16,6 @@
> >  #include <linux/cpufreq.h>
> >  #include <linux/module.h>
> >  #include <linux/err.h>
> > -#include <linux/sched.h>     /* set_cpus_allowed() */
> >  #include <linux/delay.h>
> >  #include <linux/platform_device.h>
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 5.14 material, thanks!
