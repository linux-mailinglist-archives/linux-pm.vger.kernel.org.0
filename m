Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73C97A3255
	for <lists+linux-pm@lfdr.de>; Sat, 16 Sep 2023 21:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbjIPTww (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Sep 2023 15:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbjIPTwc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Sep 2023 15:52:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3EEA0
        for <linux-pm@vger.kernel.org>; Sat, 16 Sep 2023 12:52:26 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-404573e6c8fso31701425e9.1
        for <linux-pm@vger.kernel.org>; Sat, 16 Sep 2023 12:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694893945; x=1695498745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IhNW/yAMRmrajZxMDdyBHgnGcZcH1b5AIBqQBBveog8=;
        b=EhnYTsEmVqVwCDknpMfvS1vZLsp85/guPMXpKHB8+c27aENqAlxbexqqfTIUiU9rvQ
         BUk4yVLtIejPjsSxgl1Oft5lLNQ8La7P9SBikKa0na+oTgaFl89Qi5L7FYuRRorLvaz4
         iHMNMYb6NPGQ3c/rHokcOyTK+JDSlJcLe69iYpLXI9XzvuE2Vdnq63Mrwr43nw/bmN8j
         3smgW8zFQU2iDUB1WhMpUss9rSRwPHrNsTYVEL5O/uK9p+5omSGvNmYyP8lUwamdYzzf
         kVTIrREeBwaFwAI3TPR1albof/RQYhGfgJySIThWhl9uaKm50R3vyeEr63kWs2HRa1XV
         ALVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694893945; x=1695498745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhNW/yAMRmrajZxMDdyBHgnGcZcH1b5AIBqQBBveog8=;
        b=vMYN9kCqPCIYha6leMC4Fw1qmWnZz2MDyBMuYUIpxSTI6jv57tWWLplQ4KSijPGBuD
         3r5Okmp3lGFepNWBxvIpZbcV7/ccl+ATTUsYxLv4/D5joR0imSd49O4j6qMzuX9FoOx7
         cgM4ysuah/8+6JeyiRiJDCfbPPtx7WW9jYpilIbjQKMAjj6RRlecPJYBAfWNyqyBQfv4
         uNOO+nKd5Rlc/fhJhMf2fqisGHg3SujiRpqFXHBj74KwjtzBCaafgs2ATuJ6EMoP1tsU
         iywV4URtIyXOhBn3PxD4u7v1sBktfTbnBCB/KTZmwGw/Eo8P8MJT/0AmczwwK6GQXlP7
         eC2A==
X-Gm-Message-State: AOJu0YyGUzWvDz5LX/zist16wTIMh7W1lhBQRUv55ftFd4WQ04LBbAXH
        J8E3ViKDDzQNT6EJiHZacDqy/Q==
X-Google-Smtp-Source: AGHT+IEPl7zpsrxRzqGUH6rPlbUPIm6K6592kKKgJabpdNB67Jb359IWfTlEiw6otS8taVCsGaOFnw==
X-Received: by 2002:a05:600c:152:b0:401:bcb4:f119 with SMTP id w18-20020a05600c015200b00401bcb4f119mr5215423wmm.3.1694893945217;
        Sat, 16 Sep 2023 12:52:25 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id h16-20020a5d5490000000b0031773a8e5c4sm7811865wrv.37.2023.09.16.12.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 12:52:24 -0700 (PDT)
Date:   Sat, 16 Sep 2023 20:52:23 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 1/7] sched/pelt: Add a new function to approximate
 the future util_avg value
Message-ID: <20230916195223.mbio65o5aioscd5l@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230827233203.1315953-2-qyousef@layalina.io>
 <8f63efa6-f9d1-9b1c-7737-4094f6acfc62@arm.com>
 <20230906211936.yqejc25czc6tddm6@airbuntu>
 <47a11e4e-d349-7d98-7006-4bf08a53c0cf@arm.com>
 <20230910195832.pncjsqmkepichly6@airbuntu>
 <45548b21-280e-7f94-0b53-f2dcab6ccb5e@arm.com>
 <20230916194923.4sijts6a56jxbava@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230916194923.4sijts6a56jxbava@airbuntu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/16/23 20:49, Qais Yousef wrote:
> On 09/13/23 19:22, Dietmar Eggemann wrote:
> > On 10/09/2023 21:58, Qais Yousef wrote:
> > > On 09/07/23 13:12, Dietmar Eggemann wrote:
> > >> On 06/09/2023 23:19, Qais Yousef wrote:
> > >>> On 09/06/23 14:56, Dietmar Eggemann wrote:
> > >>>> On 28/08/2023 01:31, Qais Yousef wrote:
> > 
> > [...]
> > 
> > >> Another thing ... I guess if you call accumulate_sum with delta the PELT
> > >> machinery assumes `delta = now - sa->last_update_time` which means you
> > >> would have to use `clock_pelt + TICK_USEC` as delta.
> > > 
> > > Right.
> > > 
> > > The way I understood it is that at TICK we should do update_load_avg() which
> > > would call __update_load_sum() which uses
> > > 
> > > 	delta = now - sa->last_update_time
> > > 
> > > which passes this delta to accumulate_sum()
> > > 
> > > I can see we are not very accurate since there will be a small additional time
> > > besides TICK_USEC that we are not accounting for. But I can't see how this can
> > > cause a big error.
> > > 
> > > 	predicted (assumed) tick time/delta
> > > 
> > > 		sa->last_update_time = now
> > > 		tick_time = TICK_USEC + now
> > > 
> > > 		delta = tick_time - sa->last_update_time
> > > 		delta = TICK_USEC + now - now
> > > 		delta = TICK_USEC
> > > 
> > > 	but actual tick time/delta
> > > 
> > > 		sa->last_update_time = now - x
> > > 		tick_time = TICK_USEC + now
> > > 
> > > 		delta = tick_time - sa->last_update_time
> > > 		delta = TICK_USEC + now - (now - x)
> > > 		delta = TICK_USEC + x
> > > 
> > > So the delta I am using might be slightly shorter than it should be.
> > > 
> > > IIUC, what you're saying that the `x` in my equation above is clock_pelt,
> > > right?
> > 
> > No, I was wrong here. Calling accumulate_sum with `delta = TICK_USEC` is
> > fine.
> > 
> > accumulate_sum() will accrue `sa->util.sum` and ___update_load_avg()
> > will then adjust `sa->util_avg` accordingly.
> > 
> > delta should be 4000 on Arm64 boards so you will cross period
> > boundaries. In case `delta < 1024` you might want to not call
> > ___update_load_avg() to be in pair with __update_load_avg_cfs_rq().
> 
> You mean *not* call, or actually *do* call ___update_load_avg() if delta
> < 1024? I am certainly not calling it now and I think you're suggesting to
> actually call it when period is less than 1024.

Oops my bad, I got confused. I am calling it. Ignore me!


Cheers

--
Qais Yousef
