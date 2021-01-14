Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC422F5A42
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 06:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbhANFV4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 00:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbhANFV4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 00:21:56 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37322C061575
        for <linux-pm@vger.kernel.org>; Wed, 13 Jan 2021 21:21:16 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id v19so1116470ooj.7
        for <linux-pm@vger.kernel.org>; Wed, 13 Jan 2021 21:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ksROnwGHC5NAnw5vdhU0mbzzwebgGOqiiIXnsbFMwK4=;
        b=MIW58rMm5V9ubGn/GTlbsaNEP7/uLl6WVr0HY7iORL/GICl6T+A2AnzFZs1E4EVgI0
         P8hFZRBMakDXeXvsKw1XP96gtiBDOGdDCaaHSFB5u9YFcfPF/ci6+tQGAQZoPEndlm3J
         +SeuIqoBYjbBFL+EPqnSJ9UgyGHnjCOeIIxDGDuf9/WaGgvFrEPgJbi4kRS3EqcahMrZ
         iqbv3GaD/eWL6oi/TBuIL0eqFQD6SIl3YLxd//wRSMcqNOINYSwulNhKzczgfdCSxg0i
         2TOTYzI1hGBH1QUSqgSR0sjwfr1eF4jREnWPwRhwfjwFiNkmk9mPEjkOQNUjsMyZy4uM
         qzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ksROnwGHC5NAnw5vdhU0mbzzwebgGOqiiIXnsbFMwK4=;
        b=hxqLvFicjZ5A8XavFD+8YGElMprKQwC+eILqgafwNeSckEZ8opetvO9E0wQKAO3TSG
         WqC/HtSR02qym/rno+7L+n8nycY+Pv8yWU/b+K3wKD5AWBEgCIw5RRjyWsQpR5XmF+ej
         75zSHwH47wrposuxFzxrsHoBj61d2bvqQf5/C2ID/O7WjFzru8CocPiM/0faEfnMp/QP
         /A1dEK6gGekZ7OOCIJqtI1SVLqPOEBT9+e9JKNws86qSjZvSgtYAb9u5uxUhzxiqJ8Pu
         URI4r2aNEo6U9rm7GZx8TSVxtH8Fkbq0MxPIpxUwNzQKhLwoXznH0JTsytiopEWK6axG
         WVOg==
X-Gm-Message-State: AOAM532FpE5QdMonTxktoct9gAF80WarWZOUUmrZCPAnVOe6LLxqcNPK
        IqOfPTzzsyrHpL/fSxn/E2mylg==
X-Google-Smtp-Source: ABdhPJwE9SFggZ7ipfMQpZ43cmP0uFybWtW1J3JtrA617E4kimtiAHBb22LV/iAn+9DaavJbk9/UYA==
X-Received: by 2002:a05:6820:34b:: with SMTP id m11mr3701921ooe.74.1610601675636;
        Wed, 13 Jan 2021 21:21:15 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t26sm884857otm.17.2021.01.13.21.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 21:21:14 -0800 (PST)
Date:   Wed, 13 Jan 2021 23:21:13 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: add missing devm_release_mem_region()
 call
Message-ID: <X//UyenFTDwoD0C5@builder.lan>
References: <20210112095236.20515-1-shawn.guo@linaro.org>
 <X/210llTiuNt3haG@builder.lan>
 <20210113043143.y45mmnw3e2kjkxnl@vireshk-i7>
 <X/5+GbueKg66DoEE@builder.lan>
 <20210113050651.q2txref3d6bifrf3@vireshk-i7>
 <cbd4fb28-24b8-9aa7-fe5f-24571ef6258d@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbd4fb28-24b8-9aa7-fe5f-24571ef6258d@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed 13 Jan 16:12 CST 2021, AngeloGioacchino Del Regno wrote:

> Il 13/01/21 06:06, Viresh Kumar ha scritto:
> > On 12-01-21, 22:59, Bjorn Andersson wrote:
> > > But that said, why are the ioremap done at init and not at probe time?
> > 
> > These are some hardware registers per cpufreq policy I believe, and so
> > they did it from policy init instead.
> > 
> > And yes I agree that we shouldn't use devm_ from init() for the cases
> > where we need to put the resources in exit() as well. But things like
> > devm_kzalloc() are fine there.
> > 
> > Ionela, since you were the first one to post a patch about this, can
> > you send a fix for this by dropping the devm_ thing altogether for the
> > ioremap thing ? Mark it suggested by Bjorn. Thanks.
> > 
> 
> Sorry, are you sure that the eventual fix shouldn't be rebased on top of my
> change (12014503) [1] that is enabling CPU scaling for all of the platforms
> that aren't getting the OSM set-up entirely by the TZ/bootloader?
> It's a pretty big series, that I've rebased 3 times already...
> 

I hear you and I love the work you're doing, so I am definitely trying
to find time to review your patches properly.

Regarding the size of the series, my suggestion is that you have shown
the whole picture, so going forward it's better to split it up in
individual series based on how they will be merged by different
maintainers.

Thank you,
Bjorn

> [1]: https://patchwork.kernel.org/project/linux-arm-msm/patch/20210112182052.481888-15-angelogioacchino.delregno@somainline.org/
