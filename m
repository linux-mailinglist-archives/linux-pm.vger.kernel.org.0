Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7432E210AE6
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 14:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbgGAMQp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 08:16:45 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36252 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730503AbgGAMQn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 08:16:43 -0400
Received: by mail-oi1-f196.google.com with SMTP id h17so20417454oie.3;
        Wed, 01 Jul 2020 05:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+LLXM4KPjeviTd5XtfNEKoIrALguf5kvnK4UkyGpcs=;
        b=qwD3m6CJQdUEnwzgo1iD0jW//YNcR7k8o/CfzRTZ6lPO3zpV67/CT+Cx9GY5NFDXms
         FARslZFp16GpssSowEAxl5JRYrRATkEEo+MxkZojhwxNCi0TThG0qG0hvBM7lsncP8dA
         NNQ9IDck+OakDxIIPjdqgCkvySNTROW109sUmwgYhqQV/WaQTwwjvG1RT3vvdEO1O1hd
         hgqCn2iZ3JpW+viE/zDYQYIZJmEYqLGZeq4pw2aziFnf0yHZDQGy3u9QzdvyIG2P1LaW
         gZ1A3eLNl+2117kuOCfuzwaI5Dmg4WCVnDjC98ofGKtxP7iYI6s6cwLTvQte3aSkW0+U
         LW+A==
X-Gm-Message-State: AOAM533lORPswViq2V2BYWTKe6GbNN+Ve0ujMy6I4zT0IlJSLN1uvxBg
        pPLPedrbEdyT/UubSn4I5uQX0Q8pX5DtC9wASnk=
X-Google-Smtp-Source: ABdhPJxfK1QzCckGAcRzG9ecCejOkFhWuBlSjsQ1HLhnJBkm7BrR3F15SSxW88Iu0/deoTngBDpAiGj4ujZO75q5pBE=
X-Received: by 2002:aca:4a89:: with SMTP id x131mr20755870oia.103.1593605802721;
 Wed, 01 Jul 2020 05:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200701042007.13333-1-xhao@linux.alibaba.com> <20200701045227.epojzjwuky5kkdzj@vireshk-i7>
In-Reply-To: <20200701045227.epojzjwuky5kkdzj@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Jul 2020 14:16:31 +0200
Message-ID: <CAJZ5v0iRW25n9CqvJ=ODbVh2osocx+wJVz62GqaWV9m4sdL12g@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: CPPC: simply the code access 'highest_perf'
 value in cppc_perf_caps struct
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Xin Hao <xhao@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 1, 2020 at 6:52 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 01-07-20, 12:20, Xin Hao wrote:
> >  The 'caps' variable has been defined, so there is no need to get
> >  'highest_perf' value through 'cpu->caps.highest_perf', you can use
> >  'caps->highest_perf' instead.
> >
> > Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> > ---
> >  drivers/cpufreq/cppc_cpufreq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index 257d726a4456..051d0e56c67a 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -161,7 +161,7 @@ static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu,
> >               if (!max_khz)
> >                       max_khz = cppc_get_dmi_max_khz();
> >               mul = max_khz;
> > -             div = cpu->perf_caps.highest_perf;
> > +             div = caps->highest_perf;
> >       }
> >       return (u64)perf * mul / div;
> >  }
> > @@ -184,7 +184,7 @@ static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu,
> >       } else {
> >               if (!max_khz)
> >                       max_khz = cppc_get_dmi_max_khz();
> > -             mul = cpu->perf_caps.highest_perf;
> > +             mul = caps->highest_perf;
> >               div = max_khz;
> >       }
>
> Applied. Thanks.

I applied the previous cppc_cpufreq patch, hopefully it will not clash
with this one.

Are you going to take care of this driver going forward?
