Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645582F5A1B
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 06:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbhANE7J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jan 2021 23:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbhANE7I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2021 23:59:08 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4F4C061575
        for <linux-pm@vger.kernel.org>; Wed, 13 Jan 2021 20:58:22 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 11so2662634pfu.4
        for <linux-pm@vger.kernel.org>; Wed, 13 Jan 2021 20:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pj7+cBEgJXtMaQZzh3Z5M/qdd4smvWQjfRymnLpNJDE=;
        b=OTqEl53tlZIfTcY6c6ogIn6A/A5YR8Y1PMMhxyNO6pYF+mFBSkEX2+xbZRn040Dnha
         YZMStQBY1cay6decowTVBFjzhaa4nNnFmONpXeJ3Ip7ncrbp7LqbM3jeyHjIQVBcCURH
         OTqIIKehZ/Ivd8qs8NHFXrH54BP6+waVyWJ6kn9A7lTofRaC9zUg/HSUgmGOr1dYyHlb
         NreRWe8fjyutBWpLl3WcJNXPRvY6XF/afU4c27IJ1nTmnZFKMfTu7Eza4xYhqPAxRpwQ
         gsepjva9wc78cBOzpEb5yVFypgb6hze0/4zqD3QxWWlJLTs3l7WgDGLfKuxa+LnN3I/q
         72xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pj7+cBEgJXtMaQZzh3Z5M/qdd4smvWQjfRymnLpNJDE=;
        b=JtVelK8ncKulRdxTDbDj5S11YSR2PDZFJSlOaNpTKsgvDp/dPSX1h6RDs1HpQhIJx5
         LRMJyx/UE7sMgmuk6P/xebTDdaotA8DJUzNUGJrbPW95DE2nj8ebFC/iU8YD3GfeZhgU
         JXy0BJ+wHoz/NsxcFxxoazmLU4SunFEeOA/GXUDR3B5uupZNsLBn6y9Pf8VdnNMoiBEV
         zfyU+Rho3r6zgU0WUddkE0UuuVlY1lbSPC9MluiqVnBkBX1S0jkxO/mDRmPakyb1Ii2q
         5hAYI/WZXtjvHc4L+zA1GWIavOseJlX1D9btEK0IuHIZJ1L+eOfVaPejUn/TqwqkfL9v
         b3iA==
X-Gm-Message-State: AOAM530btYQwfo60QpseYtuRGFLD6pHDYbm991Z8aTWxaKip9amKBcE4
        qiFb0gzE538xNvToIzjvoWzKog==
X-Google-Smtp-Source: ABdhPJwCm/dwbUIScsf1C9L4ZGYnnv2zRUj6lm0DFn9Y/Pv2L3hwsFwVrHcrgxReyH107F0pQ3jFTQ==
X-Received: by 2002:a63:c501:: with SMTP id f1mr5563244pgd.1.1610600301891;
        Wed, 13 Jan 2021 20:58:21 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id f24sm4109293pjj.5.2021.01.13.20.58.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jan 2021 20:58:20 -0800 (PST)
Date:   Thu, 14 Jan 2021 10:28:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: add missing devm_release_mem_region()
 call
Message-ID: <20210114045818.d3qu6jpekjol7ch2@vireshk-i7>
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
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-01-21, 23:12, AngeloGioacchino Del Regno wrote:
> Sorry, are you sure that the eventual fix shouldn't be rebased on top of my
> change (12014503) [1] that is enabling CPU scaling for all of the platforms
> that aren't getting the OSM set-up entirely by the TZ/bootloader?
> It's a pretty big series, that I've rebased 3 times already...
> 
> [1]: https://patchwork.kernel.org/project/linux-arm-msm/patch/20210112182052.481888-15-angelogioacchino.delregno@somainline.org/

I am waiting for someone from Qcom background to review the stuff, perhaps Bjorn
or someone else as it is a big change.

Second, the fixes never get rebased on new stuff as they also need to make it to
stable kernels and current Linux release instead of the next one.

So, this fix will go first irrespective of the timeframe when it was posted.

Thanks Angelo.

-- 
viresh
