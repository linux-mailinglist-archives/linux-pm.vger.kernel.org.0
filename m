Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6126E206E7F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 10:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387786AbgFXIBW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 04:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387650AbgFXIBV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 04:01:21 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD97C061573;
        Wed, 24 Jun 2020 01:01:21 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g18so1307602wrm.2;
        Wed, 24 Jun 2020 01:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ff095JW8oYzVPcA6w3J52BpgeRH7KWoM7ayC0lmndtU=;
        b=tZx5N0RSb6jkzNmNahEEiKJwPzEuT/scDoWx8lSV93588W1idC3T/cFC8g0oUwR+dJ
         SqUv97R3K6VZqs32bMmDkMsqtvLpbxQFvTnHOn1jmHzkoM8tFQI2dMdribE8bDMsqtxe
         zVSWen0pguU8L0jyZ3sb8Vfd0ApMEYEII0noWPOecy8tBdxCLtBKjY3utTraZiAQ/oRb
         FICEPmpsp4a5cJtfO57nA8HeyihnePvJENwzAsJDII0XjQ4IZzsQCNekTatH2Mpb0SKK
         p8zZm9+2ICDJE9L+c77ST3xFMu5/6wI+gmCxzoFjRJTOV5atRuIjxkTB3Y+nk0wtk8lt
         f7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ff095JW8oYzVPcA6w3J52BpgeRH7KWoM7ayC0lmndtU=;
        b=dsEN19bn7J6XHGS476CsTjz/y/6/ZNy7bKNlL8QVHJlB4V2GT+6L19lxo9bTYRPXDP
         vy7y/u0YW/4ksEKdRjkH4/G1AuzP5h1oNW4vIDasWpqwt6kBPHYi4huNxVe0+mBkmPAk
         hHEGhFeqvuqs4FV1yj6hiRL7YYiqrcznSu+4eqtvdIzKMtA6tIJtEnto7aAq8aP4emuZ
         mQ/H38zQNB5WgygV5RJCBEJB2yLkoVCDuAugh34fyKQxa7Xrb/nozKiywXJnsxn4zhUF
         R4RsytPRfRdUWikkVmIpXBCXeSiMVZmvG3s65g8OhM45hEeU1SvRz511yjGRD7fecMdz
         kITQ==
X-Gm-Message-State: AOAM530+KumsGFCrbiRSc3ekkVuLAwrgjoosm4D2KAOvKXOtNohjlkif
        d1Y1iYf0nOfTiJaoEnoKzjLv6SO4
X-Google-Smtp-Source: ABdhPJyXAEGE/s3H+cIQzr4JLHjCH60NZodTnxqdileYvj08Qui4Sanh+mSVawVIq9fLlkUa9yJP3Q==
X-Received: by 2002:a05:6000:1cf:: with SMTP id t15mr14115855wrx.180.1592985679537;
        Wed, 24 Jun 2020 01:01:19 -0700 (PDT)
Received: from macmini.local (181.4.199.77.rev.sfr.net. [77.199.4.181])
        by smtp.gmail.com with ESMTPSA id a10sm26396204wrm.21.2020.06.24.01.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 01:01:18 -0700 (PDT)
Date:   Wed, 24 Jun 2020 10:01:17 +0200
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: brocken devfreq simple_ondemand for Odroid XU3/4?
Message-ID: <20200624080117.fzgowkpgyhs6tbzx@macmini.local>
References: <20200623164733.qbhua7b6cg2umafj@macmini.local>
 <CAJKOXPeLuq81NC2xZh3y32EB-_APbDAchZD4OW_eCgQKKO+p8w@mail.gmail.com>
 <20200623191129.GA4171@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623191129.GA4171@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,
Thanks to look at it.

mem_gov is /sys/class/devfreq/10c20000.memory-controller/governor

Here some numbers after increasing the running time:

Running using simple_ondemand:
Before:
     From  :   To                                                                                     
           : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
* 165000000:         0         0         0         0         0         0         0         4   4528600
  206000000:         5         0         0         0         0         0         0         0     57780
  275000000:         0         5         0         0         0         0         0         0     50060
  413000000:         0         0         5         0         0         0         0         0     46240
  543000000:         0         0         0         5         0         0         0         0     48970
  633000000:         0         0         0         0         5         0         0         0     47330
  728000000:         0         0         0         0         0         0         0         0         0
  825000000:         0         0         0         0         0         5         0         0    331300
Total transition : 34


After:
     From  :   To
           : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
* 165000000:         0         0         0         0         0         0         0         4   5098890
  206000000:         5         0         0         0         0         0         0         0     57780
  275000000:         0         5         0         0         0         0         0         0     50060
  413000000:         0         0         5         0         0         0         0         0     46240
  543000000:         0         0         0         5         0         0         0         0     48970
  633000000:         0         0         0         0         5         0         0         0     47330
  728000000:         0         0         0         0         0         0         0         0         0
  825000000:         0         0         0         0         0         5         0         0    331300
Total transition : 34

With a running time of:
LITTLE => 283.699 s (680.877 c per mem access)
big => 284.47 s (975.327 c per mem access)


And when I set to the performance governor:
Before:
     From  :   To
           : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
  165000000:         0         0         0         0         0         0         0         5   5099040
  206000000:         5         0         0         0         0         0         0         0     57780
  275000000:         0         5         0         0         0         0         0         0     50060
  413000000:         0         0         5         0         0         0         0         0     46240
  543000000:         0         0         0         5         0         0         0         0     48970
  633000000:         0         0         0         0         5         0         0         0     47330
  728000000:         0         0         0         0         0         0         0         0         0
* 825000000:         0         0         0         0         0         5         0         0    331350
Total transition : 35

After:
     From  :   To
           : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
  165000000:         0         0         0         0         0         0         0         5   5099040
  206000000:         5         0         0         0         0         0         0         0     57780
  275000000:         0         5         0         0         0         0         0         0     50060
  413000000:         0         0         5         0         0         0         0         0     46240
  543000000:         0         0         0         5         0         0         0         0     48970
  633000000:         0         0         0         0         5         0         0         0     47330
  728000000:         0         0         0         0         0         0         0         0         0
* 825000000:         0         0         0         0         0         5         0         0    472980
Total transition : 35

With a running time of:
LITTLE: 68.8428 s (165.223 c per mem access)
big: 71.3268 s (244.549 c per mem access)


I see some transition, but not occuring during the benchmark.
I haven't dive into the code, but maybe it is the heuristic behind that is not
well defined? If you know how it's working that would be helpfull before I dive
in it.

I run your test as well, and indeed, it seems to work for large bunch of memory,
and there is some delay before making a transition (seems to be around 10s).
When you kill memtester, it reduces the freq stepwisely every ~10s.

Note that the timing shown above account for the critical path, and the code is
looping on reading only, there is no write in the critical path.
Maybe memtester is doing writes and devfreq heuristic uses only write info?

Cheers,
Willy

On 2020-06-23-21-11-29, Krzysztof Kozlowski wrote:
> On Tue, Jun 23, 2020 at 09:02:38PM +0200, Krzysztof Kozlowski wrote:
> > On Tue, 23 Jun 2020 at 18:47, Willy Wolff <willy.mh.wolff.ml@gmail.com> wrote:
> > >
> > > Hi everybody,
> > >
> > > Is DVFS for memory bus really working on Odroid XU3/4 board?
> > > Using a simple microbenchmark that is doing only memory accesses, memory DVFS
> > > seems to not working properly:
> > >
> > > The microbenchmark is doing pointer chasing by following index in an array.
> > > Indices in the array are set to follow a random pattern (cutting prefetcher),
> > > and forcing RAM access.
> > >
> > > git clone https://github.com/wwilly/benchmark.git \
> > >   && cd benchmark \
> > >   && source env.sh \
> > >   && ./bench_build.sh \
> > >   && bash source/scripts/test_dvfs_mem.sh
> > >
> > > Python 3, cmake and sudo rights are required.
> > >
> > > Results:
> > > DVFS CPU with performance governor
> > > mem_gov = simple_ondemand at 165000000 Hz in idle, should be bumped when the
> > > benchmark is running.
> > > - on the LITTLE cluster it takes 4.74308 s to run (683.004 c per memory access),
> > > - on the big cluster it takes 4.76556 s to run (980.343 c per moemory access).
> > >
> > > While forcing DVFS memory bus to use performance governor,
> > > mem_gov = performance at 825000000 Hz in idle,
> > > - on the LITTLE cluster it takes 1.1451 s to run (164.894 c per memory access),
> > > - on the big cluster it takes 1.18448 s to run (243.664 c per memory access).
> > >
> > > The kernel used is the last 5.7.5 stable with default exynos_defconfig.
> > 
> > Thanks for the report. Few thoughts:
> > 1. What trans_stat are saying? Except DMC driver you can also check
> > all other devfreq devices (e.g. wcore) - maybe the devfreq events
> > (nocp) are not properly assigned?
> > 2. Try running the measurement for ~1 minutes or longer. The counters
> > might have some delay (which would require probably fixing but the
> > point is to narrow the problem).
> > 3. What do you understand by "mem_gov"? Which device is it?
> 
> +Cc Lukasz who was working on this.
> 
> I just run memtester and more-or-less ondemand works (at least ramps
> up):
> 
> Before:
> /sys/class/devfreq/10c20000.memory-controller$ cat trans_stat
>      From  :   To
>            : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
> * 165000000:         0         0         0         0         0         0         0         0   1795950
>   206000000:         1         0         0         0         0         0         0         0      4770
>   275000000:         0         1         0         0         0         0         0         0     15540
>   413000000:         0         0         1         0         0         0         0         0     20780
>   543000000:         0         0         0         1         0         0         0         1     10760
>   633000000:         0         0         0         0         2         0         0         0     10310
>   728000000:         0         0         0         0         0         0         0         0         0
>   825000000:         0         0         0         0         0         2         0         0     25920
> Total transition : 9
> 
> 
> $ sudo memtester 1G
> 
> During memtester:
> /sys/class/devfreq/10c20000.memory-controller$ cat trans_stat
>      From  :   To
>            : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
>   165000000:         0         0         0         0         0         0         0         1   1801490
>   206000000:         1         0         0         0         0         0         0         0      4770
>   275000000:         0         1         0         0         0         0         0         0     15540
>   413000000:         0         0         1         0         0         0         0         0     20780
>   543000000:         0         0         0         1         0         0         0         2     11090
>   633000000:         0         0         0         0         3         0         0         0     17210
>   728000000:         0         0         0         0         0         0         0         0         0
> * 825000000:         0         0         0         0         0         3         0         0    169020
> Total transition : 13
> 
> However after killing memtester it stays at 633 MHz for very long time
> and does not slow down. This is indeed weird...
> 
> Best regards,
> Krzysztof
