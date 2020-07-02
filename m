Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D1E2121BA
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 13:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgGBLGm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 07:06:42 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46367 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgGBLGm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 07:06:42 -0400
Received: by mail-oi1-f195.google.com with SMTP id l63so21899799oih.13;
        Thu, 02 Jul 2020 04:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mk2LAIHGGpKqNwJUJPoO04wxdPnLESxVTBpWLnTWEx8=;
        b=kWwrKwzPDAE5jEVO4AV7ty3PfvoElGVkRiuxO/CKrbHEFrGYwcRXNFszCtVVUExDPl
         381INC9dJBZVCjGET3KOyItjNMCJIN7TznirqwwvxIsFx2QQIE4JrJ6N/fDvIghvzs33
         EYxmAfjK00AcEQozgkNcGfr9VVJYgkq9y3WMKIAEfDzwGOJK4FZPOCuz0xei6vKwBz0p
         hVFx+psm3bIEjbe38ns1ugTcjEY27p1FQ8zYzJIirq+PQpTo0qSIJXKBa+9ZbIb4MPnF
         0+d+N/BkvEhYkYi7G1i1Qi+yyWZ1ZwY32hiCvPPkqQEutxTUO29XVqeHpztv+FQLGafG
         eFwQ==
X-Gm-Message-State: AOAM531MKWhkfGgz3wXdcqyl5zZ1EOgwnRJ/hqW9V8HwgmiskkcGArBl
        icEbAMpzAPzuAvA+GWsHv60PQapjMX3rzdxejFk=
X-Google-Smtp-Source: ABdhPJy2Imxm3S4iN13OtdrOo/s1d+kV62jw/R6SxO0ppeA29ZbnDSlHB9LJq+Y5TgGQWcM3ofog32Om4Wbrr7aHHao=
X-Received: by 2002:aca:f58a:: with SMTP id t132mr17454561oih.68.1593688001042;
 Thu, 02 Jul 2020 04:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200701042007.13333-1-xhao@linux.alibaba.com>
 <20200701045227.epojzjwuky5kkdzj@vireshk-i7> <CAJZ5v0iRW25n9CqvJ=ODbVh2osocx+wJVz62GqaWV9m4sdL12g@mail.gmail.com>
 <20200702023746.li2uf4zl7bwzg62x@vireshk-i7>
In-Reply-To: <20200702023746.li2uf4zl7bwzg62x@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Jul 2020 13:06:28 +0200
Message-ID: <CAJZ5v0jbsinLBZqNiCPH0NFk0b8H4Uxuf8U5y0R5nkxUH8tX8g@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: CPPC: simply the code access 'highest_perf'
 value in cppc_perf_caps struct
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Xin Hao <xhao@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 2, 2020 at 4:37 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 01-07-20, 14:16, Rafael J. Wysocki wrote:
> > On Wed, Jul 1, 2020 at 6:52 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 01-07-20, 12:20, Xin Hao wrote:
> > > >  The 'caps' variable has been defined, so there is no need to get
> > > >  'highest_perf' value through 'cpu->caps.highest_perf', you can use
> > > >  'caps->highest_perf' instead.
> > > >
> > > > Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> > > > ---
> > > >  drivers/cpufreq/cppc_cpufreq.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > > > index 257d726a4456..051d0e56c67a 100644
> > > > --- a/drivers/cpufreq/cppc_cpufreq.c
> > > > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > > > @@ -161,7 +161,7 @@ static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu,
> > > >               if (!max_khz)
> > > >                       max_khz = cppc_get_dmi_max_khz();
> > > >               mul = max_khz;
> > > > -             div = cpu->perf_caps.highest_perf;
> > > > +             div = caps->highest_perf;
> > > >       }
> > > >       return (u64)perf * mul / div;
> > > >  }
> > > > @@ -184,7 +184,7 @@ static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu,
> > > >       } else {
> > > >               if (!max_khz)
> > > >                       max_khz = cppc_get_dmi_max_khz();
> > > > -             mul = cpu->perf_caps.highest_perf;
> > > > +             mul = caps->highest_perf;
> > > >               div = max_khz;
> > > >       }
> > >
> > > Applied. Thanks.
> >
> > I applied the previous cppc_cpufreq patch, hopefully it will not clash
> > with this one.
> >
> > Are you going to take care of this driver going forward?
>
> I started picking up the patches for this driver as it was mostly ARM
> stuff and FWIW, I picked the previous one as well and because it was
> sent by me, I never replied with the "Applied" message :)

But you could respond to the "applied" message from me. :-)

> Will it be possible for you to drop that one?

Dropped now and I will be assuming that you will pick up cppc_cpufreq
patches from now on.

Thanks!
