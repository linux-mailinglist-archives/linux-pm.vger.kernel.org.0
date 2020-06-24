Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D16206EC3
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 10:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390331AbgFXIOp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 04:14:45 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:38533 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390249AbgFXIOp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 04:14:45 -0400
Received: by mail-ej1-f52.google.com with SMTP id w16so1559139ejj.5;
        Wed, 24 Jun 2020 01:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ibh7qwsVmOM0eKJK6oTaNo8+HhtSr5AxAKMdLvNoMHg=;
        b=Tx9eORMt9WfmS5rqNr50S4SZJw+JylxOQiJp64Vm2I7zAzVRXpFo6fEoHqZaqSxWJK
         i7rnVSp6SAcXQW37ggGYt7ts8t0f+Fo0MgzyQCzJdZh03kQAr4X0/3XW0i7LhNiio0R4
         6GOmng2ODDxncjpaYpu8ZHn9cXDcaD8hPY68F2+08nJeAInKKafte/FAa2wI0UvqnQJi
         0aTU0l+nsweoc0igRz8EbV3FfsBXNUIcYkt6cp0cbE54SJZG0ufm6MWBus+DzfxgxCiy
         suzQIg2/3N2QkIRq6ouQkFdssZrXx2IOzxA6H0Xhf7RaQISPdIT8Til+jAukAbuHjoX1
         gzDQ==
X-Gm-Message-State: AOAM532BNMExjDSwHKWNvmfaVG8LlLNp7/Jlgh0CAxfBUJ0zDfk7USMS
        OewfcYZcl+FLbZzjGRE7Le0=
X-Google-Smtp-Source: ABdhPJwTeuyZfApU34NyzWK0HGsXM4sXOeoUnfsKIw0gNosZtxMfWcYqWxrIgZNdijsZjlpl7dJwjQ==
X-Received: by 2002:a17:907:11db:: with SMTP id va27mr11152068ejb.175.1592986481334;
        Wed, 24 Jun 2020 01:14:41 -0700 (PDT)
Received: from pi3 ([194.230.155.235])
        by smtp.googlemail.com with ESMTPSA id f16sm3512754ejr.0.2020.06.24.01.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 01:14:40 -0700 (PDT)
Date:   Wed, 24 Jun 2020 10:14:38 +0200
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
Message-ID: <20200624081438.GA20603@pi3>
References: <20200623164733.qbhua7b6cg2umafj@macmini.local>
 <CAJKOXPeLuq81NC2xZh3y32EB-_APbDAchZD4OW_eCgQKKO+p8w@mail.gmail.com>
 <20200623191129.GA4171@kozik-lap>
 <20200624080117.fzgowkpgyhs6tbzx@macmini.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200624080117.fzgowkpgyhs6tbzx@macmini.local>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 24, 2020 at 10:01:17AM +0200, Willy Wolff wrote:
> Hi Krzysztof,
> Thanks to look at it.
> 
> mem_gov is /sys/class/devfreq/10c20000.memory-controller/governor
> 
> Here some numbers after increasing the running time:
> 
> Running using simple_ondemand:
> Before:
>      From  :   To                                                                                     
>            : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
> * 165000000:         0         0         0         0         0         0         0         4   4528600
>   206000000:         5         0         0         0         0         0         0         0     57780
>   275000000:         0         5         0         0         0         0         0         0     50060
>   413000000:         0         0         5         0         0         0         0         0     46240
>   543000000:         0         0         0         5         0         0         0         0     48970
>   633000000:         0         0         0         0         5         0         0         0     47330
>   728000000:         0         0         0         0         0         0         0         0         0
>   825000000:         0         0         0         0         0         5         0         0    331300
> Total transition : 34
> 
> 
> After:
>      From  :   To
>            : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
> * 165000000:         0         0         0         0         0         0         0         4   5098890
>   206000000:         5         0         0         0         0         0         0         0     57780
>   275000000:         0         5         0         0         0         0         0         0     50060
>   413000000:         0         0         5         0         0         0         0         0     46240
>   543000000:         0         0         0         5         0         0         0         0     48970
>   633000000:         0         0         0         0         5         0         0         0     47330
>   728000000:         0         0         0         0         0         0         0         0         0
>   825000000:         0         0         0         0         0         5         0         0    331300
> Total transition : 34
> 
> With a running time of:
> LITTLE => 283.699 s (680.877 c per mem access)
> big => 284.47 s (975.327 c per mem access)

I see there were no transitions during your memory test.

> 
> And when I set to the performance governor:
> Before:
>      From  :   To
>            : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
>   165000000:         0         0         0         0         0         0         0         5   5099040
>   206000000:         5         0         0         0         0         0         0         0     57780
>   275000000:         0         5         0         0         0         0         0         0     50060
>   413000000:         0         0         5         0         0         0         0         0     46240
>   543000000:         0         0         0         5         0         0         0         0     48970
>   633000000:         0         0         0         0         5         0         0         0     47330
>   728000000:         0         0         0         0         0         0         0         0         0
> * 825000000:         0         0         0         0         0         5         0         0    331350
> Total transition : 35
> 
> After:
>      From  :   To
>            : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
>   165000000:         0         0         0         0         0         0         0         5   5099040
>   206000000:         5         0         0         0         0         0         0         0     57780
>   275000000:         0         5         0         0         0         0         0         0     50060
>   413000000:         0         0         5         0         0         0         0         0     46240
>   543000000:         0         0         0         5         0         0         0         0     48970
>   633000000:         0         0         0         0         5         0         0         0     47330
>   728000000:         0         0         0         0         0         0         0         0         0
> * 825000000:         0         0         0         0         0         5         0         0    472980
> Total transition : 35
> 
> With a running time of:
> LITTLE: 68.8428 s (165.223 c per mem access)
> big: 71.3268 s (244.549 c per mem access)
> 
> 
> I see some transition, but not occuring during the benchmark.
> I haven't dive into the code, but maybe it is the heuristic behind that is not
> well defined? If you know how it's working that would be helpfull before I dive
> in it.

Sorry, don't know that much. It seems it counts time between overflow of
DMC perf events and based on this bumps up the frequency.

Maybe your test does not fit well in current formula? Maybe the formula
has some drawbacks...

> 
> I run your test as well, and indeed, it seems to work for large bunch of memory,
> and there is some delay before making a transition (seems to be around 10s).
> When you kill memtester, it reduces the freq stepwisely every ~10s.
> 
> Note that the timing shown above account for the critical path, and the code is
> looping on reading only, there is no write in the critical path.
> Maybe memtester is doing writes and devfreq heuristic uses only write info?
>
You mentioned that you want to cut the prefetcher to have direct access
to RAM. But prefetcher also accesses the RAM. He does not get the
contents from the air.  Although this is unrelated to the problem
because your pattern should kick ondemand as well.

Best regards,
Krzysztof
