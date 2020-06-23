Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7FF205B80
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 21:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbgFWTLf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 15:11:35 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:45691 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733248AbgFWTLf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 15:11:35 -0400
Received: by mail-ej1-f41.google.com with SMTP id a1so8698389ejg.12;
        Tue, 23 Jun 2020 12:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S6qzk+OKExXb2YpLZeuh1PmKG+c4jm0lpjuoeWwXFzk=;
        b=r9kTTD97qkKFw+q1SPYr0Wmmq3KWGMmYl1o9LsR0k5H/dgQxF1Fj/AYaVCjMl0Xfhx
         952UvgI6M34fyLhH+gGlkFq+u/PMO6TWDqrp/3vpXe75uggWJLtNzU2smIEt1MrgPRsR
         2LpwPNKlxLPZ1zQAgqJ/O031v3TGNxGQYDFywEUx1p4Axdgl8olSmu3knmuhr9dDI0o/
         XfLw/tjQCoOrBNndsTlkMuVBK1NnExcM8UQxWElMLIF9UZH9+zIgsBYtzyWyiky7jBeU
         neE0PZ46Pqg0pkxQ5aM6CtRFI09dM5dNS9Mk4QCIRoNhymZ54j1MOxuf6kULC3Wwf0RY
         QKzQ==
X-Gm-Message-State: AOAM533o31B/eNTpEmWZdnSOEhqe09EvV7r9zil3N8T3FHhrEPQ6FM96
        290/5Q5+lgkg0SAxtxMMxm0=
X-Google-Smtp-Source: ABdhPJzL8paryXZaLIV+aJhyo9RYBnt+N7daGvK76KL9xSHh8GkcyzPYHf1WG9BUOVfCwW6i7BNwCg==
X-Received: by 2002:a17:906:4cd0:: with SMTP id q16mr13306634ejt.418.1592939492855;
        Tue, 23 Jun 2020 12:11:32 -0700 (PDT)
Received: from kozik-lap ([194.230.155.235])
        by smtp.googlemail.com with ESMTPSA id a2sm4479503ejg.76.2020.06.23.12.11.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jun 2020 12:11:31 -0700 (PDT)
Date:   Tue, 23 Jun 2020 21:11:29 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>
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
Message-ID: <20200623191129.GA4171@kozik-lap>
References: <20200623164733.qbhua7b6cg2umafj@macmini.local>
 <CAJKOXPeLuq81NC2xZh3y32EB-_APbDAchZD4OW_eCgQKKO+p8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJKOXPeLuq81NC2xZh3y32EB-_APbDAchZD4OW_eCgQKKO+p8w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 23, 2020 at 09:02:38PM +0200, Krzysztof Kozlowski wrote:
> On Tue, 23 Jun 2020 at 18:47, Willy Wolff <willy.mh.wolff.ml@gmail.com> wrote:
> >
> > Hi everybody,
> >
> > Is DVFS for memory bus really working on Odroid XU3/4 board?
> > Using a simple microbenchmark that is doing only memory accesses, memory DVFS
> > seems to not working properly:
> >
> > The microbenchmark is doing pointer chasing by following index in an array.
> > Indices in the array are set to follow a random pattern (cutting prefetcher),
> > and forcing RAM access.
> >
> > git clone https://github.com/wwilly/benchmark.git \
> >   && cd benchmark \
> >   && source env.sh \
> >   && ./bench_build.sh \
> >   && bash source/scripts/test_dvfs_mem.sh
> >
> > Python 3, cmake and sudo rights are required.
> >
> > Results:
> > DVFS CPU with performance governor
> > mem_gov = simple_ondemand at 165000000 Hz in idle, should be bumped when the
> > benchmark is running.
> > - on the LITTLE cluster it takes 4.74308 s to run (683.004 c per memory access),
> > - on the big cluster it takes 4.76556 s to run (980.343 c per moemory access).
> >
> > While forcing DVFS memory bus to use performance governor,
> > mem_gov = performance at 825000000 Hz in idle,
> > - on the LITTLE cluster it takes 1.1451 s to run (164.894 c per memory access),
> > - on the big cluster it takes 1.18448 s to run (243.664 c per memory access).
> >
> > The kernel used is the last 5.7.5 stable with default exynos_defconfig.
> 
> Thanks for the report. Few thoughts:
> 1. What trans_stat are saying? Except DMC driver you can also check
> all other devfreq devices (e.g. wcore) - maybe the devfreq events
> (nocp) are not properly assigned?
> 2. Try running the measurement for ~1 minutes or longer. The counters
> might have some delay (which would require probably fixing but the
> point is to narrow the problem).
> 3. What do you understand by "mem_gov"? Which device is it?

+Cc Lukasz who was working on this.

I just run memtester and more-or-less ondemand works (at least ramps
up):

Before:
/sys/class/devfreq/10c20000.memory-controller$ cat trans_stat
     From  :   To
           : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
* 165000000:         0         0         0         0         0         0         0         0   1795950
  206000000:         1         0         0         0         0         0         0         0      4770
  275000000:         0         1         0         0         0         0         0         0     15540
  413000000:         0         0         1         0         0         0         0         0     20780
  543000000:         0         0         0         1         0         0         0         1     10760
  633000000:         0         0         0         0         2         0         0         0     10310
  728000000:         0         0         0         0         0         0         0         0         0
  825000000:         0         0         0         0         0         2         0         0     25920
Total transition : 9


$ sudo memtester 1G

During memtester:
/sys/class/devfreq/10c20000.memory-controller$ cat trans_stat
     From  :   To
           : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
  165000000:         0         0         0         0         0         0         0         1   1801490
  206000000:         1         0         0         0         0         0         0         0      4770
  275000000:         0         1         0         0         0         0         0         0     15540
  413000000:         0         0         1         0         0         0         0         0     20780
  543000000:         0         0         0         1         0         0         0         2     11090
  633000000:         0         0         0         0         3         0         0         0     17210
  728000000:         0         0         0         0         0         0         0         0         0
* 825000000:         0         0         0         0         0         3         0         0    169020
Total transition : 13

However after killing memtester it stays at 633 MHz for very long time
and does not slow down. This is indeed weird...

Best regards,
Krzysztof
