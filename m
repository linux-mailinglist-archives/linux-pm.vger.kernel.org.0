Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3713E57F9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 12:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbhHJKHR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 06:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238628AbhHJKHR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Aug 2021 06:07:17 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950ADC061798
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 03:06:55 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k2so20249395plk.13
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 03:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=86LjhHwH2Y01JTFkrW4LltEIu0xfncQuIXbpof7c38U=;
        b=EPTZS1zs4hk/XgPzFZqbffWZQVnvrLyR3ikBz/nldBEri4wKTNPG02YCMYf3qAitT6
         q+Z4cbOAc+zBcMmq3+5mHoTiue9Oo7xe7e/GL5CVZ04ytybTU4xlb2s2j6jHQjQk62bx
         QF28hlimfhwV5gfNzfpwvrbzhJIZwfbT2HB+x2ZZtC/clMpcdRJQkXr0qth60U2HVJ7e
         667FyQcw0RUlRQ3txtiM1oraHW0alOh+QhDLENmbpQfvclDNkfEEpUTvYhT2R6HaMF8L
         buUhy+OmMCSHsLxF3cVcRztrvwwPRv6uD8LFb+ZoxIzUw9b+Fua3foOHksXpoLVrHKuZ
         VDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=86LjhHwH2Y01JTFkrW4LltEIu0xfncQuIXbpof7c38U=;
        b=IrlCpyVHexZUUIs2Y1/hLpBz0O54gImRHQG9Mq2VsV7uETHQ2qHBsPSgEx8ESpz5DJ
         1V0XcbTShsua+h9oZwshFBT8U+rEu0BuXE0MpboPK+3Zq/aNESai7Wmfa30pfqzpcs9J
         r+Dmi/QOcWZZn/FuMrDwEeCUwOxHhlrKm9LR3aezau1tTGhTvu31dXI/NhNip9XDquQL
         O3/5voFYjl2hwniUY2I6EORjh1RBPJTUc2Ks3F9L3YFfla1meSg40mMfvovm5PSsxM5h
         bbNljIyjEgRXMBpigXAAQ73qXi7CP13UL5GLa5XQCIB9v8hpeRII5mYyf4cAWwws4fCq
         Dmnw==
X-Gm-Message-State: AOAM533HHcWVBIzY9hH4td02Vez8+t9c8B4eTPs94qwO1YOMXh95dq05
        NcPRDgBxw9h2C8L0QW918erAFA==
X-Google-Smtp-Source: ABdhPJya2Sgo4k+tUz0e5kI+ZjaNDAiFasmQ7SRwJDsYaa4PKlQ/HHyqa0QnogcR6+emA0GopdeupQ==
X-Received: by 2002:a17:903:248f:b029:128:d5ea:18a7 with SMTP id p15-20020a170903248fb0290128d5ea18a7mr10803526plw.83.1628590015127;
        Tue, 10 Aug 2021 03:06:55 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id t13sm20302715pjg.25.2021.08.10.03.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 03:06:54 -0700 (PDT)
Date:   Tue, 10 Aug 2021 15:36:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 8/8] cpufreq: vexpress: Use auto-registration for energy
 model
Message-ID: <20210810100652.h473q6hgtc5czfyk@vireshk-i7>
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <87fecd84e3f6ff6f153be14b0d53de93c0b04ae6.1628579170.git.viresh.kumar@linaro.org>
 <d3629cc7-d9db-0e54-94e9-278e308b7e8e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3629cc7-d9db-0e54-94e9-278e308b7e8e@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-08-21, 11:05, Lukasz Luba wrote:
> I can see that this driver calls explicitly the
> of_cpufreq_cooling_register()
> It does this in the cpufreq_driver->ready() callback
> implementation: ve_spc_cpufreq_ready()
> 
> With that in mind, the new code in the patch 1/8, which
> registers the EM, should be called even earlier, above:
> ---------------------8<---------------------------------
> /* Callback for handling stuff after policy is ready */
> 	if (cpufreq_driver->ready)
> 		cpufreq_driver->ready(policy);
> ------------------->8----------------------------------

Thanks. I will look at this sequencing issue again.

> This also triggered a question:
> If this new flag can be set in the cpufreq driver which hasn't set
> CPUFREQ_IS_COOLING_DEV
> ?

Why not ?

> I can only see one driver (this one in the patch) which has such
> configuration.

-- 
viresh
