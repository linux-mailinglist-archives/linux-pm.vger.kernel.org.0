Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A6B2072D3
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 14:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388763AbgFXMHA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 24 Jun 2020 08:07:00 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:34566 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388522AbgFXMG7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 08:06:59 -0400
Received: by mail-ej1-f44.google.com with SMTP id y10so2221689eje.1;
        Wed, 24 Jun 2020 05:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DIWUKwC5j7zR6xCRsdwY2boMvp3E8i9Nf4eBjr5JHPY=;
        b=VyzvRJ92l84AlOQmqf/tStZfCbdlYQGJJPXdEeyJV6q+spGaEYp9D1zfig7MIwtOrW
         kkEYSiCbH+7h/Om4mG1ql4HOmqCjkf1eP78IfU8IGvBtQZZ4KBs9hIbdXXVO1b4cqPpk
         Bh1YDptkRZSjeTITcF53u4BCrDHlKnJkNuqdyD2308rlk4nEDj7qzN1ESVO7XJY3k/zU
         WPCFC5A9h4+lX3Y5HZsF5rd+vNgrMvyKMW/C/D/u/HOUaeEfpzIjceIZHSvHsXg0gzsg
         LR8dyJRs4fI5sMQa+wTZUjKWqNjv/yZSwZEdz9rtCc/QcD4wJg5BKHd/GHWdXOVM4lH+
         lrdA==
X-Gm-Message-State: AOAM532boGHg4tFvN5+HI4xEUzDxN/4uj9PozyWeDug9WwU47MrrwXc8
        RXb8vVUzQ4v7zIa31TzwOJI=
X-Google-Smtp-Source: ABdhPJzw7dT7DuLroeMpi/tOn6HV4dIL8x9Vwikz8xM5kRlyFgOqcL6z4RnjLqHE3ANNvd+Td26jsg==
X-Received: by 2002:a17:906:1b45:: with SMTP id p5mr11645122ejg.51.1593000414538;
        Wed, 24 Jun 2020 05:06:54 -0700 (PDT)
Received: from pi3 ([194.230.155.235])
        by smtp.googlemail.com with ESMTPSA id b98sm5452294edf.24.2020.06.24.05.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 05:06:53 -0700 (PDT)
Date:   Wed, 24 Jun 2020 14:06:51 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: brocken devfreq simple_ondemand for Odroid XU3/4?
Message-ID: <20200624120651.GA20813@pi3>
References: <20200623164733.qbhua7b6cg2umafj@macmini.local>
 <CAJKOXPeLuq81NC2xZh3y32EB-_APbDAchZD4OW_eCgQKKO+p8w@mail.gmail.com>
 <20200623191129.GA4171@kozik-lap>
 <CGME20200624103308eucas1p29c8572979809b129ff8ac729c6c728e2@eucas1p2.samsung.com>
 <85f5a8c0-7d48-f2cd-3385-c56d662f2c88@arm.com>
 <828b0d63-4d01-48d6-5971-64855adebed2@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <828b0d63-4d01-48d6-5971-64855adebed2@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 24, 2020 at 01:18:42PM +0200, Kamil Konieczny wrote:
> Hi,
> 
> On 24.06.2020 12:32, Lukasz Luba wrote:
> > Hi Krzysztof and Willy
> > 
> > On 6/23/20 8:11 PM, Krzysztof Kozlowski wrote:
> >> On Tue, Jun 23, 2020 at 09:02:38PM +0200, Krzysztof Kozlowski wrote:
> >>> On Tue, 23 Jun 2020 at 18:47, Willy Wolff <willy.mh.wolff.ml@gmail.com> wrote:
> >>>>
> >>>> Hi everybody,
> >>>>
> >>>> Is DVFS for memory bus really working on Odroid XU3/4 board?
> >>>> Using a simple microbenchmark that is doing only memory accesses, memory DVFS
> >>>> seems to not working properly:
> >>>>
> >>>> The microbenchmark is doing pointer chasing by following index in an array.
> >>>> Indices in the array are set to follow a random pattern (cutting prefetcher),
> >>>> and forcing RAM access.
> >>>>
> >>>> git clone https://protect2.fireeye.com/url?k=c364e88a-9eb6fe2f-c36563c5-0cc47a31bee8-631885f0a63a11a0&q=1&u=https%3A%2F%2Fgithub.com%2Fwwilly%2Fbenchmark.git \
> >>>>    && cd benchmark \
> >>>>    && source env.sh \
> >>>>    && ./bench_build.sh \
> >>>>    && bash source/scripts/test_dvfs_mem.sh
> >>>>
> >>>> Python 3, cmake and sudo rights are required.
> >>>>
> >>>> Results:
> >>>> DVFS CPU with performance governor
> >>>> mem_gov = simple_ondemand at 165000000 Hz in idle, should be bumped when the
> >>>> benchmark is running.
> >>>> - on the LITTLE cluster it takes 4.74308 s to run (683.004 c per memory access),
> >>>> - on the big cluster it takes 4.76556 s to run (980.343 c per moemory access).
> >>>>
> >>>> While forcing DVFS memory bus to use performance governor,
> >>>> mem_gov = performance at 825000000 Hz in idle,
> >>>> - on the LITTLE cluster it takes 1.1451 s to run (164.894 c per memory access),
> >>>> - on the big cluster it takes 1.18448 s to run (243.664 c per memory access).
> >>>>
> >>>> The kernel used is the last 5.7.5 stable with default exynos_defconfig.
> >>>
> >>> Thanks for the report. Few thoughts:
> >>> 1. What trans_stat are saying? Except DMC driver you can also check
> >>> all other devfreq devices (e.g. wcore) - maybe the devfreq events
> >>> (nocp) are not properly assigned?
> >>> 2. Try running the measurement for ~1 minutes or longer. The counters
> >>> might have some delay (which would require probably fixing but the
> >>> point is to narrow the problem).
> >>> 3. What do you understand by "mem_gov"? Which device is it?
> >>
> >> +Cc Lukasz who was working on this.
> > 
> > Thanks Krzysztof for adding me here.
> > 
> >>
> >> I just run memtester and more-or-less ondemand works (at least ramps
> >> up):
> >>
> >> Before:
> >> /sys/class/devfreq/10c20000.memory-controller$ cat trans_stat
> >>       From  :   To
> >>             : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
> >> * 165000000:         0         0         0         0         0         0         0         0   1795950
> >>    206000000:         1         0         0         0         0         0         0         0      4770
> >>    275000000:         0         1         0         0         0         0         0         0     15540
> >>    413000000:         0         0         1         0         0         0         0         0     20780
> >>    543000000:         0         0         0         1         0         0         0         1     10760
> >>    633000000:         0         0         0         0         2         0         0         0     10310
> >>    728000000:         0         0         0         0         0         0         0         0         0
> >>    825000000:         0         0         0         0         0         2         0         0     25920
> >> Total transition : 9
> >>
> >>
> >> $ sudo memtester 1G
> >>
> >> During memtester:
> >> /sys/class/devfreq/10c20000.memory-controller$ cat trans_stat
> >>       From  :   To
> >>             : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
> >>    165000000:         0         0         0         0         0         0         0         1   1801490
> >>    206000000:         1         0         0         0         0         0         0         0      4770
> >>    275000000:         0         1         0         0         0         0         0         0     15540
> >>    413000000:         0         0         1         0         0         0         0         0     20780
> >>    543000000:         0         0         0         1         0         0         0         2     11090
> >>    633000000:         0         0         0         0         3         0         0         0     17210
> >>    728000000:         0         0         0         0         0         0         0         0         0
> >> * 825000000:         0         0         0         0         0         3         0         0    169020
> >> Total transition : 13
> >>
> >> However after killing memtester it stays at 633 MHz for very long time
> >> and does not slow down. This is indeed weird...
> > 
> > I had issues with devfreq governor which wasn't called by devfreq
> > workqueue. The old DELAYED vs DEFERRED work discussions and my patches
> > for it [1]. If the CPU which scheduled the next work went idle, the
> > devfreq workqueue will not be kicked and devfreq governor won't check
> > DMC status and will not decide to decrease the frequency based on low
> > busy_time.
> > The same applies for going up with the frequency. They both are
> > done by the governor but the workqueue must be scheduled periodically.
> > 
> > I couldn't do much with this back then. I have given the example that
> > this is causing issues with the DMC [2]. There is also a description
> > of your situation staying at 633MHz for long time:
> > ' When it is missing opportunity
> > to change the frequency, it can either harm the performance or power
> > consumption, depending of the frequency the device stuck on.'
> > 
> > The patches were not accepted because it will cause CPU wake-up from
> > idle, which increases the energy consumption. I know that there were
> > some other attempts, but I don't know the status.
> > 
> > I had also this devfreq workqueue issue when I have been working on
> > thermal cooling for devfreq. The device status was not updated, because
> > the devfreq workqueue didn't check the device [3].
> > 
> > Let me investigate if that is the case.
> > 
> > Regards,
> > Lukasz
> > 
> > [1] https%3A%2F%2Flkml.org%2Flkml%2F2019%2F2%2F11%2F1146
> > [2] https%3A%2F%2Flkml.org%2Flkml%2F2019%2F2%2F12%2F383
> > [3] https%3A%2F%2Flwn.net%2Fml%2Flinux-kernel%2F20200511111912.3001-11-lukasz.luba%40arm.com%2F
> 
> and here was another try to fix wq: "PM / devfreq: add possibility for delayed work"
> 
> https://lkml.org/lkml/2019/12/9/486

My case was clearly showing wrong behavior. System was idle but not
sleeping - network working, SSH connection ongoing.  Therefore at least
one CPU was not idle and could adjust the devfreq/DMC... but this did not
happen. The system stayed for like a minute in 633 MHz OPP.

Not-waking up idle processors - ok... so why not using power efficient
workqueue? It is exactly for this purpose - wake up from time to time on
whatever CPU to do the necessary job.

Best regards,
Krzysztof

