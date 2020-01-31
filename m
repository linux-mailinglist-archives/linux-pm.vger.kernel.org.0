Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31DD414F336
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2020 21:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgAaUda (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jan 2020 15:33:30 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37178 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgAaUda (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jan 2020 15:33:30 -0500
Received: by mail-ed1-f66.google.com with SMTP id cy15so9200808edb.4;
        Fri, 31 Jan 2020 12:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vm34AiZw5tCki8C0c1qoxvq76BQ0W8VtlZxc0vtOTH0=;
        b=VdfZ99Zy05WREBkYa00GkzNjqC2C2E2XaZRx0UyWFEPg8QV1bPd9C+6Lg704CetnpS
         OO1IcV19CbicT0H2icmJ2xGSKIjrMSe+zSKT6bw+lzvAU+C7eVR9/vG35bPqCsHUXefu
         Mq35QW3LrRyeHJZzOCexcm7RTPftcxU0bXL7M4wifxdNYot7Cy81/rUrz+IQwvZqKqZQ
         q0iXWx0aclNo8ILBOyR2MKVivjoOr1bHpUFaDsrFB2scAxKdJWv2icPXYAVtykUxbC0X
         B1M0EUd7Cf5Ke7HEu0SkquLHh/UzI25wp6kxm3R2H90vnMLcANjnDIqqeT9nQnje1qiO
         Wimg==
X-Gm-Message-State: APjAAAUY13UTHG1ph3HhIDi+zFOwbA9W1vJOIzOUvTLXdtoqflb6ETjD
        EuQey0MeUG6/cdjXsRs4c4w=
X-Google-Smtp-Source: APXvYqzv6M4GBZtTnnXC472c44tOGVPioARY22z+lobm6CZoDXuGFlo7P3GwK8JnhnshAtlVrV+7Uw==
X-Received: by 2002:a17:907:104e:: with SMTP id oy14mr10544242ejb.82.1580502808030;
        Fri, 31 Jan 2020 12:33:28 -0800 (PST)
Received: from kozik-lap ([194.230.155.229])
        by smtp.googlemail.com with ESMTPSA id g9sm651960ejd.66.2020.01.31.12.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Jan 2020 12:33:27 -0800 (PST)
Date:   Fri, 31 Jan 2020 21:33:24 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     kgene@kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Chanwoo Choi <cw00.choi@samsung.com>, robh+dt@kernel.org,
        mark.rutland@arm.com,
        =?utf-8?Q?Bart=C5=82omiej_=C5=BBo=C5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, dietmar.eggemann@arm.com
Subject: Re: [PATCH 1/3] ARM: exynos_defconfig: Enable SCHED_MC
Message-ID: <20200131203324.GA27510@kozik-lap>
References: <20200127215453.15144-1-lukasz.luba@arm.com>
 <20200127215453.15144-2-lukasz.luba@arm.com>
 <CAJKOXPedRc3ag6DDUAXSbHk8JcAZbug5HSss9wb8YyLkP7MLaw@mail.gmail.com>
 <ae021317-8fda-2bb2-2080-1304fda1420c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae021317-8fda-2bb2-2080-1304fda1420c@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 31, 2020 at 03:59:30PM +0000, Lukasz Luba wrote:
> Hi Krzysztof,
> 
> Thank you for your review, please see my comments below.
> 
> On 1/31/20 12:47 PM, Krzysztof Kozlowski wrote:
> > On Mon, 27 Jan 2020 at 22:55, <lukasz.luba@arm.com> wrote:
> > > 
> > > From: Lukasz Luba <lukasz.luba@arm.com>
> > > 
> > > Since the 'capacities-dmips-mhz' are present in the CPU nodes, make use of
> > > this knowledge in smarter decisions during scheduling.
> > > 
> > > The values in 'capacities-dmips-mhz' are normilized, this means that i.e.
> > > when CPU0's capacities-dmips-mhz=100 and CPU1's 'capacities-dmips-mhz'=50,
> > > cpu0 is twice fast as CPU1, at the same frequency. The proper hirarchy
> > > in sched_domain topology could exploit the SoC architecture advantages
> > > like big.LITTLE.
> > 
> > I do not quite get how this is related to rationale behind changing defconfig...
> 
> It is not strictly about EAS, it is useful in general for big.LITTLE
> platform with clusters.
> 
> > 
> > > Enabling the SCHED_MC will create two levels in
> > > sched_domain hierarchy, which might be observed in:
> > 
> > This is looks more convincing... but still what is the need? To work with EAS?
> 
> It is not only for EAS, but in general for the scheduler (load balance,
> task's wake-up path, etc). The scheduler algorithms iterate CPUs in the
> sched groups. To make better decisions, the information about MC domain
> is needed. More about the scheduler domains and i.e. load_balance()
> you can find here:
> 
> https://www.kernel.org/doc/html/latest/scheduler/sched-domains.html

Ahhh, I see, it's independent of later patches. Somehow I had impression
it is a prerequisite...

> 
> > 
> > > grep . /proc/sys/kernel/sched_domain/cpu*/domain*/{name,flags}
> > > /proc/sys/kernel/sched_domain/cpu0/domain0/name:MC
> > > /proc/sys/kernel/sched_domain/cpu0/domain1/name:DIE
> > > ...
> > > /proc/sys/kernel/sched_domain/cpu0/domain0/flags:575
> > > /proc/sys/kernel/sched_domain/cpu0/domain1/flags:4223
> > 
> > Not related to defconfig change and not visible after this commit.
> 
> Without this patch there is only one domain: 'domain0' -> 'DIE'
> cat /proc/sys/kernel/sched_domain/cpu0/domain0/name
> DIE
> 
> When you apply this patch you will get two: 'domain0, 'domain1'
> grep . /proc/sys/kernel/sched_domain/cpu0/domain?/name
> 
> /proc/sys/kernel/sched_domain/cpu0/domain0/name:MC
> /proc/sys/kernel/sched_domain/cpu0/domain1/name:DIE
> 
> I can remove it this information, but it is the most important
> to spot this difference out.
> 
> This is also the main reason I haven't merge the patch 1 + 3.

Indeed. I thought that these will pop up at the end of the patchset, my
bad.

I do not see big benefits of adding these outputs as proofs of working
SCHED_MC because they are kind of obvious. It is not a measurement but
report of current system state. However they don't harm neither, so I am
fine with it.

However please us in commit msg also the name of turned on option, next
or instead of SCHED_MC.  The options might be sometimes cryptic or too
vague and the name actually easily expresses what you want enable.

