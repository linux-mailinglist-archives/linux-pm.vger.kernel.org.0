Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D128A245
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 17:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfHLP2b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 11:28:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33989 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfHLP2b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 11:28:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id x18so2227712ljh.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2019 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hgRkzXbbFmA3Q2Zv0rEz4OjwQ8vdleRxSlP6kVoEu4o=;
        b=RHYO2LRRbZVVHhAAUaNKKEDN8NajKtK8q91SUFV6qIqWj29qigjT4M1fbdwhmfM5uX
         j4XvBExlMzBwRfNH0dzDn63BCDaCszhrSAlVFsoIDxZpwQLm6YNA+tm1lbO8FptnuW2R
         QsxenZ4WyFbmETyx/8FeQzf9SOCMYvUGc1yoRbHPIuUc9QsQCm1OCFKUSo4DSlIKoVHn
         nOoWU2dM5ToC1t4htrb89UsgT1gEVr78xdCQQxjpFa4/uN7TxvKuQKao13Fvl4Luk9ol
         FkywXuApfxFrPiBqCSDOA7NWPn2B7qRP/G3ljLMJx2OT68/eflmymj87HzCKR/RkBiUT
         gTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hgRkzXbbFmA3Q2Zv0rEz4OjwQ8vdleRxSlP6kVoEu4o=;
        b=jex0nsyUsb+JazUUoExGqZV96OoSbPmwmzt2aCf4Q3ydjftZfPTTepStI8+SPCZ1KA
         OiNAKLlVh5hd/icj8vzGHTF3XL9dDpjidwpDR10La55z6gsMcGYTcOLEiqaB2ROPL9p7
         4XF39yIRKKvvHlfCm1plxkALs6pZG6iMPhioV9TFMxvDTn/W2+WNwe0W+psl5bY0IcM3
         EVS2/dMwcW9lHnBruJ72iWTJGArNgpO0ke6X/Dn4hAfYYUhI92iOQ6rumTQB5kohUSXQ
         D5m34vjmPEpOvZ13M4nF/UnLpSKB0TvxXxW8VP5LZKSlP5OTivXPKRIWUTySXiWye+EV
         inYw==
X-Gm-Message-State: APjAAAWnVYnuopAhoHmv0ec1ndVotMwWjJ/CwbeuJFq79heLnxGbq08v
        noDNqWge6X26v7O+NIsmiORY/A==
X-Google-Smtp-Source: APXvYqwUmSGekdM518oHm5YmsPxuO3pZgErv7gZZOAkXmjPQw54dzNZSR7pYytvzTLEDpYt1bR7jwQ==
X-Received: by 2002:a2e:800a:: with SMTP id j10mr5258515ljg.137.1565623709249;
        Mon, 12 Aug 2019 08:28:29 -0700 (PDT)
Received: from centauri (ua-84-219-138-247.bbcust.telenor.se. [84.219.138.247])
        by smtp.gmail.com with ESMTPSA id n187sm19035377lfa.30.2019.08.12.08.28.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 08:28:28 -0700 (PDT)
Date:   Mon, 12 Aug 2019 17:28:26 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, LKML <linux-kernel@vger.kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 00/15] thermal: qcom: tsens: Add interrupt support
Message-ID: <20190812152826.GA7958@centauri>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
 <CAHLCerNay31+RNQvQZyxMMVyb1mLLfN5BoZbz-M+bMqbmbYwtA@mail.gmail.com>
 <20190729090735.GA897@onstation.org>
 <2123341.TWUfUUIiFt@g550jk>
 <CAHLCerNU3oAZd6aGw1pgN-SLOJTebi5usqxaFHbQUd+sC2sc9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerNU3oAZd6aGw1pgN-SLOJTebi5usqxaFHbQUd+sC2sc9g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 29, 2019 at 03:20:11PM +0530, Amit Kucheria wrote:
> On Mon, Jul 29, 2019 at 3:03 PM Luca Weiss <luca@z3ntu.xyz> wrote:
> >
> > On Montag, 29. Juli 2019 11:07:35 CEST Brian Masney wrote:
> > > On Sat, Jul 27, 2019 at 12:58:54PM +0530, Amit Kucheria wrote:
> > > > On Fri, Jul 26, 2019 at 4:59 PM Brian Masney <masneyb@onstation.org> wrote:
> > > > > On Fri, Jul 26, 2019 at 04:40:16PM +0530, Amit Kucheria wrote:
> > > > > > How well does cpufreq work on 8974? I haven't looked at it yet but
> > > > > > we'll need it for thermal throttling.
> > > > >
> > > > > I'm not sure how to tell if the frequency is dynamically changed during
> > > > > runtime on arm. x86-64 shows this information in /proc/cpuinfo. Here's
> > > >
> > > > > the /proc/cpuinfo on the Nexus 5:
> > > > Nah. /proc/cpuinfo won't show what we need.
> > > >
> > > > Try the following:
> > > >
> > > > $ grep "" /sys/devices/system/cpu/cpufreq/policy?/*
> > > >
> > > > More specifically, the following files have the information you need.
> > > > Run watch -n1 on them.
> > > >
> > > > $ grep "" /sys/devices/system/cpu/cpufreq/policy?/scaling_*_freq
> > >
> > > There's no cpufreq directory on msm8974:
> > >
> > >     # ls -1 /sys/devices/system/cpu/
> > >     cpu0
> > >     cpu1
> > >     cpu2
> > >     cpu3
> > >     cpuidle
> > >     hotplug
> > >     isolated
> > >     kernel_max
> > >     modalias
> > >     offline
> > >     online
> > >     possible
> > >     power
> > >     present
> > >     smt
> > >     uevent
> > >
> > > I'm using qcom_defconfig.
> > >
> > > Brian
> >
> > Hi Brian,
> > cpufreq isn't supported on msm8974 yet.
> > I have these patches [0] in my tree but I'm not sure they work correctly, but I haven't tested much with them. Feel free to try them on hammerhead.
> >
> > Luca
> >
> > [0] https://github.com/z3ntu/linux/compare/b0917f53ada0e929896a094b451219cd8091366e...6459ca6aff498c9d12acd35709b4903effc4c3f8
> 
> Niklas is working on refactoring some of the Krait code[1]. I'm not
> sure if he looked at 8974 directly as part of the refactor adding him
> here to get a better sense of the state of cpufreq on 8974.

Hello,

I took and cleaned up Sricharans commit
"cpufreq: qcom: Re-organise kryo cpufreq to use it for other nvmem based qcom socs"
from his Krait cpufreq series.

The commit renames and refactors the Kryo cpufreq driver.

This commit is now in linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=cpufreq/arm/linux-next&id=106b976debd36b0e61847769f8edd71bfea56ed7


I also added Qualcomm A53 support to this driver.

However, Krait CPUs are different from both Kryo and Qualcomm A53,
so you will need to take Sricharans patch series and rebase it
on top of linux-next.

Kind regards,
Niklas

> 
> [1] https://lore.kernel.org/linux-arm-msm/20190726080823.xwhxagv5iuhudmic@vireshk-i7/T/#t
