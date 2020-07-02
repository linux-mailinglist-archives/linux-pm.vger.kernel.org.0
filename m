Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55155211A36
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 04:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgGBChv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 22:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgGBChu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 22:37:50 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FD1C08C5C1
        for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2020 19:37:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc9so5280325pjb.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2020 19:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E6qbMlZ2Efi0OnOWp1DIBcuwZU3AyV6M/I4efZUFWaQ=;
        b=rd1riGz5u1jk9KczDNJXRDIkj0NTKkAhfsqIiYDHCcSsb8ey6U0F1lFO9QGss6CNbt
         Ip86QpCH2sEZK9SlOx8nKnf+n7jnVHXxm4NDfae5aC7viKXQaHcBWLTHnT6GbUzbeB7Q
         Mt8RBMyjd5iZNseSUs4Hz9hF/NbUBjYL8aSdfWs72ZYYvmAzNw6GXFglngdNHIGl6Jz2
         SMxgCUVkKjoKBbxwdlXXC2OdpN0OV92nz91NjSWmYWmnCZa4dxe/J3mmJBCHoiqT3lhm
         Pvp1PNtK7P8ThpAdcqJDe7TNdWDTx6ealZ829ZRwwmdUPNhjWCw6ivyfs/J10c3DFw7X
         MkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E6qbMlZ2Efi0OnOWp1DIBcuwZU3AyV6M/I4efZUFWaQ=;
        b=unxbhB3uXa4vOV8O+hUmAWSxxYHIZV9m+M1aSgXMXUQ4SuH1E2NHAH6HN0l0rACGBF
         oGYmG6HB77fUAB2PAbdm2DR5I9um8La5ojY2plEAX/Aas0YkgH3RFvHm3l7s8DNSFKjK
         h7t/Zb8D95ZSbwABo2GQLLNnnSaA2KJnuGtaRzskmU2adMSgLR94sje2njcCYg6PeokU
         gaoqx0r8jVCtwFw4p+WFoptIXERmnYibQ8MxG4DIzySqoMaOsUZm0fHAuG5xW1Mon6y6
         gzAv5CDtT1vSCLt6LgjQbd3mjW0S6eiH4oATWgjokIfm+unVVQ2oprqGA0msIdeJBcNt
         g86w==
X-Gm-Message-State: AOAM533KH8M9wJop0eOWO1eUcNrGzRTaisSrnFwZgqd+y+ik2LKdQo4q
        jPB6bAAEa+qe8qHDCwcSAblEig==
X-Google-Smtp-Source: ABdhPJzWA2sCClagfIdhuHoEOvXzH6EhJArvtlPVjv9hibIidWhx1A4wpf9A1PD40eqx9Md3bEahxQ==
X-Received: by 2002:a17:90a:6a03:: with SMTP id t3mr30648268pjj.174.1593657470066;
        Wed, 01 Jul 2020 19:37:50 -0700 (PDT)
Received: from localhost ([223.235.247.110])
        by smtp.gmail.com with ESMTPSA id io3sm235298pjb.22.2020.07.01.19.37.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 19:37:48 -0700 (PDT)
Date:   Thu, 2 Jul 2020 08:07:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Xin Hao <xhao@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] cpufreq: CPPC: simply the code access 'highest_perf'
 value in cppc_perf_caps struct
Message-ID: <20200702023746.li2uf4zl7bwzg62x@vireshk-i7>
References: <20200701042007.13333-1-xhao@linux.alibaba.com>
 <20200701045227.epojzjwuky5kkdzj@vireshk-i7>
 <CAJZ5v0iRW25n9CqvJ=ODbVh2osocx+wJVz62GqaWV9m4sdL12g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iRW25n9CqvJ=ODbVh2osocx+wJVz62GqaWV9m4sdL12g@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-07-20, 14:16, Rafael J. Wysocki wrote:
> On Wed, Jul 1, 2020 at 6:52 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 01-07-20, 12:20, Xin Hao wrote:
> > >  The 'caps' variable has been defined, so there is no need to get
> > >  'highest_perf' value through 'cpu->caps.highest_perf', you can use
> > >  'caps->highest_perf' instead.
> > >
> > > Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> > > ---
> > >  drivers/cpufreq/cppc_cpufreq.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > > index 257d726a4456..051d0e56c67a 100644
> > > --- a/drivers/cpufreq/cppc_cpufreq.c
> > > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > > @@ -161,7 +161,7 @@ static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu,
> > >               if (!max_khz)
> > >                       max_khz = cppc_get_dmi_max_khz();
> > >               mul = max_khz;
> > > -             div = cpu->perf_caps.highest_perf;
> > > +             div = caps->highest_perf;
> > >       }
> > >       return (u64)perf * mul / div;
> > >  }
> > > @@ -184,7 +184,7 @@ static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu,
> > >       } else {
> > >               if (!max_khz)
> > >                       max_khz = cppc_get_dmi_max_khz();
> > > -             mul = cpu->perf_caps.highest_perf;
> > > +             mul = caps->highest_perf;
> > >               div = max_khz;
> > >       }
> >
> > Applied. Thanks.
> 
> I applied the previous cppc_cpufreq patch, hopefully it will not clash
> with this one.
> 
> Are you going to take care of this driver going forward?

I started picking up the patches for this driver as it was mostly ARM
stuff and FWIW, I picked the previous one as well and because it was
sent by me, I never replied with the "Applied" message :)

Will it be possible for you to drop that one? Or should I drop that
now ? There shouldn't be any conflicts for now though.

-- 
viresh
