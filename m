Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36ACC14F340
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2020 21:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgAaUlY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jan 2020 15:41:24 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40055 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgAaUlY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jan 2020 15:41:24 -0500
Received: by mail-ed1-f68.google.com with SMTP id p3so9205487edx.7;
        Fri, 31 Jan 2020 12:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QJJQfRq1wZ707JbA7sCfgb7195GzFk0v3Czz3H1LQFM=;
        b=Amo52QxL2tsF50MGTgRZccozNwCZNONEZKXlQ2rwdy1N/QingfkR6eHL8KQ6IkRl7j
         XvE/BsFWYL37SYdr4hNImct5zckkSgIbuReg9noxucXbyRWn4dlQreKdG0IB9FBVaHBF
         T1hMl2FKIJPVa7uORjO3onNAf0fuleESUD9oZ9Bp0MYolEv/5ZRxpcGBWJbEJMTdQdwN
         bbEXL9J7ThfLcSH0XUpVpFQCkITX1yNU20294J7FxVIhydDRikb1MecPL5g5aSby70wq
         QVhekqZfSAlxWA73+5Zr/IWP4L3OsQIZPXRHtZ5YbGVfH94chDEUWJ9bxM/K7R0mlhMc
         rYgg==
X-Gm-Message-State: APjAAAUE0Rb0g8uCpEf1INI+MIdghFpwJl/mGFVhfI3sm70575fBCKDi
        3LRz4ARB+tI8WGz9ZLSBi0k=
X-Google-Smtp-Source: APXvYqzi2OiUv/2SQLW0+RWJMHY1JvZjAFeYrqrQ+tOC0v6TlKYJqCvpe6xewRBkzBF4uoalMMoxOg==
X-Received: by 2002:a05:6402:1a25:: with SMTP id be5mr2197002edb.220.1580503281876;
        Fri, 31 Jan 2020 12:41:21 -0800 (PST)
Received: from kozik-lap ([194.230.155.229])
        by smtp.googlemail.com with ESMTPSA id s16sm558231edy.51.2020.01.31.12.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Jan 2020 12:41:21 -0800 (PST)
Date:   Fri, 31 Jan 2020 21:41:18 +0100
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
Subject: Re: [PATCH 3/3] ARM: exynos_defconfig: Enable Energy Model framework
Message-ID: <20200131204118.GA27284@kozik-lap>
References: <20200127215453.15144-1-lukasz.luba@arm.com>
 <20200127215453.15144-4-lukasz.luba@arm.com>
 <CAJKOXPeA=_3zPx6Aq3CAUi7JsXr9AigWGWCTNWo_jkm=oVWe_g@mail.gmail.com>
 <db3f2554-288d-81ab-2373-1447367ba673@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <db3f2554-288d-81ab-2373-1447367ba673@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 31, 2020 at 05:30:46PM +0000, Lukasz Luba wrote:
 
> > 
> > >                  |-----------------------------------------------|---------------
> > >                  | performance   | SchedUtil     | SchedUtil     | performance
> > >                  | governor      | governor      | governor      | governor
> > >                  |               | w/o EAS       | w/ EAS        |
> > > ----------------|---------------|---------------|---------------|---------------
> > > hackbench w/ PL | 12.7s         | 11.7s         | 12.0s         | 13.0s - 12.2s
> > > hackbench w/o PL| 9.2s          | 8.1s          | 8.2s          | 9.2s - 8.4s
> > 
> > Why does the performance different before and after this patch?
> 
> Probably due to better locality and cache utilization. I can see that
> there is ~700k context switches vs ~450k and ~160k migrations vs ~50k.
> If you need to communicate two threads in different clusters, it will go
> through CCI.

Mhmm... I was not specific - I mean, "performance governor". All this
you mentioned should not differ between performance governor before and
after. However once you have 12.7, then 13.0 - 12.2. Unless multi-core
scheduler affects it... but then these numbers here are not showing
only this change, but also the SCHED_MC effect.  In such case each of
commits should be coming with their own numbers.

> As mentioned in response to patch 1/3. The fist patch would create MC
> domain, something different than Energy Model or EAS. The decisions in
> the scheduler would be different.
> 
> I can merge 1/3 and 3/3 if you like, though.

I understand now that their independent. Still, they are part of one
goal to tune the scheduler for Exynos platform. Splitting these looks
too much, like enabling multiple drivers one after another.

However if you provide numbers for each of cases (before patches, multi
core scheduler, energy model with DTS), then I see benefit of splitting
it.  Each commit would have its own rationale.  I am not sure if it is
worth such investigation - that's just defconfig... distros might ignore
it anyway.

Best regards,
Krzysztof

