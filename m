Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6747025E82
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2019 09:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbfEVHGS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 May 2019 03:06:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43099 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfEVHGR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 May 2019 03:06:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id gn7so598483plb.10
        for <linux-pm@vger.kernel.org>; Wed, 22 May 2019 00:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=euUzaUZjQQvHcCyny1Ihtmol+djSm2u5xzcf8kf/Thc=;
        b=NCT1LOIdOIFdV4B/JKCZSXABGZ7P568wX1X+hR6On5h2/CzYjEkP5bRCZTGjG+7J0v
         kj5vOZBLqMQdFjseIA3ssc82FrOkVmnDptR0dvDmsb5t6Z/pGLquiYYkxK5e/UUitM38
         4QNGjYb+zctwCs69ItfvyUrEPcJBAJiBRtJGXPj1+egezpBWt+TkX5MXkd4LTHdrqs3V
         uIDD6xN0rfjaGMMjowsLtkgaHHaRyZcJgHHfEnTEE0aFIDZbkIqMKXcmZ8HVS5td4cCs
         94cDip9FK/cDNo9VMYgPajmCjXn93aYAj7HXxZ1mbHlrs2kJMzaxxipouNzL9QTeDC7l
         WLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=euUzaUZjQQvHcCyny1Ihtmol+djSm2u5xzcf8kf/Thc=;
        b=RagnKRt4BXO12xrWPLsUlnZfMQPiXz0OFZj6olsMekzULb6OgXCPy9XS1tWcznZrE8
         nzeYL21W9FJT3rOV/OEvk1BikwCfGPpf3mV0SE/VOY278yQPfeUh3gdnRkAXg6OQ0gDp
         UlnTvTS9YdCU6IPQMF4O1Ld7/KrI+Tmw9DXZP+aUUiOTsuhGI2GGt3RWuhpDLiJaThx3
         rtdWfShZwWE48oVYVGmTbhldyjk1t0GkqGPf+Ddwp8q5lt7otx5VM8wFSW55A3xD75me
         8MKTxIR0ReKOaVJpzp0QMOZqSQgZTx0tGfbW5PI9QMjxTFq25mnVa6GyTANYLPDabX4T
         xdqA==
X-Gm-Message-State: APjAAAXaJ9uhNVoC02QFXmDYyfpDmrQCAooSWqFcoLNJfPI4tbys5qWq
        Bziv/z++xGoIQBDy5VAPx78NnSpjBpw=
X-Google-Smtp-Source: APXvYqy30S3S5HqOpyNRhQG/1HfYb5UoEd/36HJBYTVpPN+mzh/G8thtMqdbxlhFpcEWj6R0+Jk4mg==
X-Received: by 2002:a17:902:b584:: with SMTP id a4mr52232229pls.333.1558508777113;
        Wed, 22 May 2019 00:06:17 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id p16sm56975123pfq.153.2019.05.22.00.06.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 00:06:16 -0700 (PDT)
Date:   Wed, 22 May 2019 12:36:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Christian Neubert <christian.neubert.86@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] clk: mvebu: armada-37xx-periph: Fix initialization for
 cpu clocks
Message-ID: <20190522070614.jhpo7nqrxinmlbcs@vireshk-i7>
References: <CAC5LXJcCs4nr-qFOWzUJpUBAJ9ngG-cgeTCVCFBKFc1SPzHMuQ@mail.gmail.com>
 <20190314134428.GA24768@apalos>
 <874l85v8p6.fsf@FE-laptop>
 <20190318112844.GA1708@apalos>
 <87h8c0s955.fsf@FE-laptop>
 <20190318122113.GA4834@apalos>
 <20190424093015.rcr5auamfccxf6ei@vireshk-i7>
 <20190425123303.GA12659@apalos>
 <20190520112042.mpamnabxpwciih5m@vireshk-i7>
 <20190522070341.GA32613@apalos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522070341.GA32613@apalos>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-05-19, 10:03, Ilias Apalodimas wrote:
> Hi Viresh, Gregory
> On Mon, May 20, 2019 at 04:50:42PM +0530, Viresh Kumar wrote:
> > On 25-04-19, 15:33, Ilias Apalodimas wrote:
> > > Hi Viresh,
> > > 
> > > > > > Also, during this week-end, Christian suggested that the issue might
> > > > > > come from the AVS support.
> > > > > > 
> > > > > > Could you disable it and check you still have the issue?
> > > > > > 
> > > > > > For this, you just have to remove the avs node in
> > > > > > arch/arm64/boot/dts/marvell/armada-37xx.dtsi and rebuild the dtb.
> > > > > Sure. You'll have to wait for a week though. Currently on a trip. I'll run that
> > > > >  once i return
> > > > 
> > > > @Ilias: Can you please try this now and confirm to Gregory ?
> > > I am more overloaded than usual and totally forgot about this. Apologies.
> > > I'll try finding some time and do this.
> > 
> > Ping Ilias.
> Sorry for the huge delay. 
> Applying this patch and removing tha 'avs' node from
> arch/arm64/boot/dts/marvell/armada-37xx.dtsi seems to work.
> Changing between governors does not freeze the board any more. I haven't checked
> the actual impact on the CPU speed but the values on 
> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor are correct

Thanks for testing it out. Lets see what Gregory has to say now.

-- 
viresh
