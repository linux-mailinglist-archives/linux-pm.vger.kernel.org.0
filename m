Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A742A6092
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 10:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgKDJdz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 04:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgKDJdz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 04:33:55 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD839C061A4A
        for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2020 01:33:53 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id r10so16093798pgb.10
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2020 01:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dSdpW81nx2ZMYTMRYGVAqF73yA+8yqW5N14k2LtHpUc=;
        b=D4oOw7+5uthMp9z3s3BQWq+es3Ae4LHtVqIhZEWyr7TV5H6KRq06y+Bclo+itLToGX
         x8sVA8tTtSxyKBNmcx13a/i1gnzAXqNTL5RDbeCdkZnNUbMVEBjKm8Ytdzx0/OfNlOF8
         jtn/Y1paB3Xfg1wTD3WWV3Sc2CLHpP7rBfJO9pMgu7F6tfCO/IWYNwnoT1QihnnL1w+l
         ghM9x5DxV1p+ir4gXZnsK647P/7c+66/eaMtTq6OmxGvHvax/zq/gAHjLQfwXeWBrNOO
         9Ku/ejhZepG1x8JmA1rMvnJbD/cJD6hrUSEEZRqXnXQx3T5NvJTOTWJRsVPQjCf5oqGe
         8R9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dSdpW81nx2ZMYTMRYGVAqF73yA+8yqW5N14k2LtHpUc=;
        b=qUo6e16nCaqppcl4NXXrvcudn2wU4iXEggUOyNaTAIPYsoKo5ilX/qL5Urqxpcfhqr
         ghLQQfTbv8un71gYOPq/Jms4XX1sLEblOynf3RSbk+HuRE6TSWvrUGqxexoZHYGyE/Y9
         Ov2z74o7od4aaMVBPSPpvGK0RCv4XMnpJxg5+ydt3xoEprCdpkj1D7b09BmettDtEcDt
         f2A5OAi8wHZAfUdlG1QfCuUTs3y9nyxARNO6hbfmba2xhdaEYxAB/oYKdKV8m1h/mJJk
         Wv7WHXZvKnEf/qbXiWpEO3jhWGeNP+ql4TmzprAtv9ZRPrqAWO+fZ5wi3L5pDV7yWCzl
         F6Og==
X-Gm-Message-State: AOAM533lxmHanN+QKpjDyhdXTTPjoobTtaqV7vpgGLM1ym/pRe+xP6XG
        mHPLNMffesoZZmqzejJ3+5tqEQ==
X-Google-Smtp-Source: ABdhPJw+H0OciOF9vTU0ehM14kCMBvNxPm97H/4MjBFzp9TdrfuLJBSnrldp8t3xaBcQGvXUwaIBuw==
X-Received: by 2002:a05:6a00:1707:b029:18a:a5f1:6809 with SMTP id h7-20020a056a001707b029018aa5f16809mr20859094pfc.77.1604482433232;
        Wed, 04 Nov 2020 01:33:53 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id s19sm1704573pfe.26.2020.11.04.01.33.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2020 01:33:52 -0800 (PST)
Date:   Wed, 4 Nov 2020 15:03:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sumit Gupta <sumitg@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: tegra186: Fix get frequency callback
Message-ID: <20201104093349.l3r3eftwyvaoqjf2@vireshk-i7>
References: <20201103115514.547047-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103115514.547047-1-jonathanh@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-11-20, 11:55, Jon Hunter wrote:
> Commit b89c01c96051 ("cpufreq: tegra186: Fix initial frequency")
> implemented the CPUFREQ 'get' callback to determine the current
> operating frequency for each CPU. This implementation used a simple
> looked up to determine the current operating frequency. The problem
> with this is that frequency table for different Tegra186 devices may
> vary and so the default boot frequency for Tegra186 device may or may
> not be present in the frequency table. If the default boot frequency is
> not present in the frequency table, this causes the function
> tegra186_cpufreq_get() to return 0 and in turn causes cpufreq_online()
> to fail which prevents CPUFREQ from working.
> 
> Fix this by always calculating the CPU frequency based upon the current
> 'ndiv' setting for the CPU. Note that the CPU frequency for Tegra186 is
> calculated by reading the current 'ndiv' setting, multiplying by the
> CPU reference clock and dividing by a constant divisor.
> 
> Fixes: b89c01c96051 ("cpufreq: tegra186: Fix initial frequency")
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/cpufreq/tegra186-cpufreq.c | 33 +++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 12 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Rafael: This needs to go in the next rc and so I am not applying it
in my tree as this is the only fix I have for now.

-- 
viresh
