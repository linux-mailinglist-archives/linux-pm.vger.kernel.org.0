Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486F43E5808
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 12:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbhHJKMu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 06:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhHJKMt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Aug 2021 06:12:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35445C061798
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 03:12:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l11so8682701plk.6
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 03:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lb2oLRW+qirgEGtmZTSETxpjUU/FIl6TZgWJI5M3pUc=;
        b=Frz8NOYZ2sDr4nXo6PZVCIBFRX3W07wAF8WRLD5F+/2RxJ/w8QLrvP8EMmgMThdtR5
         7JSuRlz0LdXu0XnFQDf3UKAn5Gk19e5rdE1Kze1nM0Nv7LO1UaW5MMMSQ72te6lLEFSG
         dMg/zWUKPx8QGfHJD9rRfAx5DnNJ4FlUAwwGNZwneX4Ba2FGhgjc7t3YWkxRWvPgot0v
         Br3xyvCuIUoB5GUwIpsRj8wIvt8lUnLI9GjWi7LdIkbhVAlNUDAXdvGGN0R4BMC0qMa3
         RLx6GOrNtI6DEJ2Rz60XTsJgrgl50fjsoVVV1+Bm9zhHq7g5BerAWEvaEqqByMwraXxP
         3weQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lb2oLRW+qirgEGtmZTSETxpjUU/FIl6TZgWJI5M3pUc=;
        b=uikC7ICmkWRksKYQvG/AxscsLgbl8jYrK6Uo/7B+zT7r6/MNhn4zq+4ZOLadiiPOuK
         p1opI7sjLc0MdH2LoAPwaulQ4xVvpfGfBFKDb6S8+ECjUcvQDuFrxy+2DvwffGFzQqNs
         akpFvDANkPhD8xMtdRrfeCzRWwNiyJ343SdDQOTjkECKKdZy2u0HG5XILVDkU4hLMG7V
         GhN9uKX1uLbxeE8Cjq8vl2rNge1v2xeYkSapdmmLE+NXiXHAN02qDC/uNDoLw4DDUlnX
         DCvmdmOh/BUa6IJQkqmUbGv6xGOJSHRM/AzNHC/HAFkrUAzEnhLu+DV9Qbl5yNhikWjt
         x5ng==
X-Gm-Message-State: AOAM533Mh3c5gL7R71PZUkTJm7Zi/R27icEDVgIcl8UNpl7iT4Nndlbh
        DOw5XjMkvRfULfR0ybGhfTGBhqXyhSbrSw==
X-Google-Smtp-Source: ABdhPJxFyVVd1Ae6QHv4GN87hQJdzWmyopNdKZgqpZDm9JyTldYrN4/9fgZpXoBdVQisxHIbmxvL3A==
X-Received: by 2002:aa7:88ca:0:b029:3cd:cc14:9fc9 with SMTP id k10-20020aa788ca0000b02903cdcc149fc9mr3257287pff.80.1628590347677;
        Tue, 10 Aug 2021 03:12:27 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id v10sm2476286pjd.29.2021.08.10.03.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 03:12:27 -0700 (PDT)
Date:   Tue, 10 Aug 2021 15:42:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 8/8] cpufreq: vexpress: Use auto-registration for energy
 model
Message-ID: <20210810101225.hw6co5ymuqpuntnt@vireshk-i7>
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <87fecd84e3f6ff6f153be14b0d53de93c0b04ae6.1628579170.git.viresh.kumar@linaro.org>
 <d3629cc7-d9db-0e54-94e9-278e308b7e8e@arm.com>
 <20210810100652.h473q6hgtc5czfyk@vireshk-i7>
 <2210acb9-2666-7aa9-d36c-346480541f3c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2210acb9-2666-7aa9-d36c-346480541f3c@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-08-21, 11:11, Lukasz Luba wrote:
> 
> 
> On 8/10/21 11:06 AM, Viresh Kumar wrote:
> > On 10-08-21, 11:05, Lukasz Luba wrote:
> > > I can see that this driver calls explicitly the
> > > of_cpufreq_cooling_register()
> > > It does this in the cpufreq_driver->ready() callback
> > > implementation: ve_spc_cpufreq_ready()
> > > 
> > > With that in mind, the new code in the patch 1/8, which
> > > registers the EM, should be called even earlier, above:
> > > ---------------------8<---------------------------------
> > > /* Callback for handling stuff after policy is ready */
> > > 	if (cpufreq_driver->ready)
> > > 		cpufreq_driver->ready(policy);
> > > ------------------->8----------------------------------
> > 
> > Thanks. I will look at this sequencing issue again.
> > 
> > > This also triggered a question:
> > > If this new flag can be set in the cpufreq driver which hasn't set
> > > CPUFREQ_IS_COOLING_DEV
> > > ?
> > 
> > Why not ?
> 
> I thought someone could try to call cpufreq_cooling_register()
> from the cpufreq driver init function, but it's not possible. I have
> just checked that, so should be good with these two flags being
> independent and working fine.

Ahh, I see. Great.

-- 
viresh
