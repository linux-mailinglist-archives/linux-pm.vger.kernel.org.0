Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4590206F75
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 10:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbgFXIwV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 04:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728732AbgFXIwU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 04:52:20 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B906FC061573;
        Wed, 24 Jun 2020 01:52:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 22so1561016wmg.1;
        Wed, 24 Jun 2020 01:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lVApUt3i/7AFtwyD3Ki0a35tHO53vnjzikpdpWE5FJs=;
        b=nWxfbOrH2lbT0UWHSbjppQTiIjOfKj5zMlQq5Aj3dFFYMGWrUFtYGxKEQpua8lGeG7
         BYPJLI9nLyJZnF+VMvul1Ya9nnO2OoP/E2XxIEpbuVltTlU/2HNK+fTd8aSCIhm1WUUp
         pqLlGJCyzTWO+8AzohbesMgB0/NepympE2oK7EtXXQvbbvqDN2lxSmmpB+WJ0OX1a2sX
         YUBayu9Russ/U2lCKcSAWD9YsC0s4KbOSXDT56uWf+Ib0qDAM84FkEAYLjIXlp7gP42d
         16MIFwwdCOMOFRxGnFaXRs9/rtrTlpi8FlkSdnCz77QGPLLq4RbraWBQPmXu7SA7nKTR
         TRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lVApUt3i/7AFtwyD3Ki0a35tHO53vnjzikpdpWE5FJs=;
        b=s3jfA0OLnaVSJNBSvoOpGEYfJzkmMn4mXCOvizsv9kk34o8h2+75hBXJbFZwyBEs4E
         UH//Umi9osmM3ZNaKvuU5NkuxG9SnE4fRpK+GN50zMQ00Y+HL7+rc0CYGiX0opfdeewN
         x7w0BlVhY0V70dqkB9R6m7cy4z4rwOzJSpG3VVbZOE7nRt/73V9oBTOYWbrpgqKsJ1ay
         5/HO4GPFZBc0BDkEm6Uy5UQAgSf9aLK4AzG1jAbq2LPFqHCMU3ezBNp3x5hXOX9xth+7
         ieUlWiV4PFW96d9/nDL0hCyN6gtX0f1diACTfAVOF9aVncjiFDwb9+DMxjKv3LM3hM97
         9+NA==
X-Gm-Message-State: AOAM531vAbhSRIjnB2dzk5phxWcA+0URhCJsjReqaIATRcpxsipl6WAy
        NvfJsA3Wyb5XxUjOBx9h7bo=
X-Google-Smtp-Source: ABdhPJxEoDCK2NSYlVqZ8jHDnIBfhX/cA9jnzCKLxs1yjbdQAquYvO37dsRjlB2gsrPuj1Ijj4bjoQ==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr1289926wmb.92.1592988739418;
        Wed, 24 Jun 2020 01:52:19 -0700 (PDT)
Received: from macmini.local (181.4.199.77.rev.sfr.net. [77.199.4.181])
        by smtp.gmail.com with ESMTPSA id c20sm22140185wrb.65.2020.06.24.01.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 01:52:18 -0700 (PDT)
Date:   Wed, 24 Jun 2020 10:52:17 +0200
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
Message-ID: <20200624085217.5km2iexitfgclsev@macmini.local>
References: <20200623164733.qbhua7b6cg2umafj@macmini.local>
 <CAJKOXPeLuq81NC2xZh3y32EB-_APbDAchZD4OW_eCgQKKO+p8w@mail.gmail.com>
 <20200623191129.GA4171@kozik-lap>
 <20200624080117.fzgowkpgyhs6tbzx@macmini.local>
 <20200624081438.GA20603@pi3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624081438.GA20603@pi3>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-06-24-10-14-38, Krzysztof Kozlowski wrote:
> On Wed, Jun 24, 2020 at 10:01:17AM +0200, Willy Wolff wrote:
> > Hi Krzysztof,
> > Thanks to look at it.
> > 
> > mem_gov is /sys/class/devfreq/10c20000.memory-controller/governor
> > 
> > Here some numbers after increasing the running time:
> > 
> > Running using simple_ondemand:
> > Before:
> >      From  :   To                                                                                     
> >            : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
> > * 165000000:         0         0         0         0         0         0         0         4   4528600
> >   206000000:         5         0         0         0         0         0         0         0     57780
> >   275000000:         0         5         0         0         0         0         0         0     50060
> >   413000000:         0         0         5         0         0         0         0         0     46240
> >   543000000:         0         0         0         5         0         0         0         0     48970
> >   633000000:         0         0         0         0         5         0         0         0     47330
> >   728000000:         0         0         0         0         0         0         0         0         0
> >   825000000:         0         0         0         0         0         5         0         0    331300
> > Total transition : 34
> > 
> > 
> > After:
> >      From  :   To
> >            : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
> > * 165000000:         0         0         0         0         0         0         0         4   5098890
> >   206000000:         5         0         0         0         0         0         0         0     57780
> >   275000000:         0         5         0         0         0         0         0         0     50060
> >   413000000:         0         0         5         0         0         0         0         0     46240
> >   543000000:         0         0         0         5         0         0         0         0     48970
> >   633000000:         0         0         0         0         5         0         0         0     47330
> >   728000000:         0         0         0         0         0         0         0         0         0
> >   825000000:         0         0         0         0         0         5         0         0    331300
> > Total transition : 34
> > 
> > With a running time of:
> > LITTLE => 283.699 s (680.877 c per mem access)
> > big => 284.47 s (975.327 c per mem access)
> 
> I see there were no transitions during your memory test.
> 
> > 
> > And when I set to the performance governor:
> > Before:
> >      From  :   To
> >            : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
> >   165000000:         0         0         0         0         0         0         0         5   5099040
> >   206000000:         5         0         0         0         0         0         0         0     57780
> >   275000000:         0         5         0         0         0         0         0         0     50060
> >   413000000:         0         0         5         0         0         0         0         0     46240
> >   543000000:         0         0         0         5         0         0         0         0     48970
> >   633000000:         0         0         0         0         5         0         0         0     47330
> >   728000000:         0         0         0         0         0         0         0         0         0
> > * 825000000:         0         0         0         0         0         5         0         0    331350
> > Total transition : 35
> > 
> > After:
> >      From  :   To
> >            : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
> >   165000000:         0         0         0         0         0         0         0         5   5099040
> >   206000000:         5         0         0         0         0         0         0         0     57780
> >   275000000:         0         5         0         0         0         0         0         0     50060
> >   413000000:         0         0         5         0         0         0         0         0     46240
> >   543000000:         0         0         0         5         0         0         0         0     48970
> >   633000000:         0         0         0         0         5         0         0         0     47330
> >   728000000:         0         0         0         0         0         0         0         0         0
> > * 825000000:         0         0         0         0         0         5         0         0    472980
> > Total transition : 35
> > 
> > With a running time of:
> > LITTLE: 68.8428 s (165.223 c per mem access)
> > big: 71.3268 s (244.549 c per mem access)
> > 
> > 
> > I see some transition, but not occuring during the benchmark.
> > I haven't dive into the code, but maybe it is the heuristic behind that is not
> > well defined? If you know how it's working that would be helpfull before I dive
> > in it.
> 
> Sorry, don't know that much. It seems it counts time between overflow of
> DMC perf events and based on this bumps up the frequency.
> 
> Maybe your test does not fit well in current formula? Maybe the formula
> has some drawbacks...

OK, I will read the code then.

> 
> > 
> > I run your test as well, and indeed, it seems to work for large bunch of memory,
> > and there is some delay before making a transition (seems to be around 10s).
> > When you kill memtester, it reduces the freq stepwisely every ~10s.
> > 
> > Note that the timing shown above account for the critical path, and the code is
> > looping on reading only, there is no write in the critical path.
> > Maybe memtester is doing writes and devfreq heuristic uses only write info?
> >
> You mentioned that you want to cut the prefetcher to have direct access
> to RAM. But prefetcher also accesses the RAM. He does not get the
> contents from the air.  Although this is unrelated to the problem
> because your pattern should kick ondemand as well.

Yes obvisouly. I was just describing a bit the microbenchmark and the memory pattern
access. I was suggesting that a random pattern will break the effectiveness of the
prefetcher, and as such we have a worst case situation on the memory bus.

> 
> Best regards,
> Krzysztof
