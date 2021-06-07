Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE51939D42D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 06:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhFGEuz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 00:50:55 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:46898 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhFGEur (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 00:50:47 -0400
Received: by mail-pj1-f54.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso9581317pjb.5
        for <linux-pm@vger.kernel.org>; Sun, 06 Jun 2021 21:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t83CoRT70i5x93MDZL3zD/Wyg9e/rIbO96dXM25y8Dk=;
        b=q6c3ljZ+B497ioExVAaGV9G8aiqtHkHXitdctjXbOq1Y055WWMWyuGIPwmFD07b1Zh
         k/y+bopMGOtiPBCa/+51Aa1CXzJly49kQkBX4rS4SaU8smnZjgAoOtoYs2Uzr/43lTn8
         adaqlbhLKCS+LtUrRYPZmm8CfgKRmr4FQ/YtKXUtMX9RpJQDyx0m8iog4R8WT/dT8Pwq
         4c8E7cU0jBeQJWthd7eUCeJT8dgPt1vtg6+k/ofPy9ZWkkustUbyz0XGBBIT76LuS1E1
         1nG+bvDfIw+6W9JNIKRJbV6OXbkPLfXTNflQ+awmF/YkwzGi1U3znMBktMlPqnRacSNy
         np1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t83CoRT70i5x93MDZL3zD/Wyg9e/rIbO96dXM25y8Dk=;
        b=LuaAp/l2mqyawIJgh71BYwZdVysTgS9eQ4j0u79ony8UzDt/fjnPftSGBpAklKdsDj
         spLo+sc7cMasU4mhLmPN9TNwT0k6FR2A/STR1SAFHbWcIFM0S8KXVamA8v0WMmdOGQh5
         IxLmE+k95HH75K5LrLyicyFcMwBsbScz4x0HyR6qtpXe0Uf+ggJCejSnkNkC0I9/L1WR
         SNtmUxzaot47KyEPPqOkhQX7ZA1EMBcHWqbT7ZM49WvCIYjKcLLh8dashOYZzydoMUN8
         dsEwf0ykPFr3rp/66ib/sQAYQEWEsU1aD/gOSWhktUlvZtYEZhre8qFO0pzaYnbkBH//
         0caA==
X-Gm-Message-State: AOAM531Ra3g/PYwjDLjbJKQmRDc8fkQ1looujG3zmN5vobbE0PT/yMgw
        XtHQstY5fM1lsFiOQWS8u1CedgXjkkeqjw==
X-Google-Smtp-Source: ABdhPJziRLKNEhluonlkD4YA9qyW5UZ+raMTyKHdMSHJ+m8XjUMk/07yOHATGkQMUA7RljTZ61ct5Q==
X-Received: by 2002:a17:90a:ce02:: with SMTP id f2mr29929553pju.45.1623041262206;
        Sun, 06 Jun 2021 21:47:42 -0700 (PDT)
Received: from localhost ([136.185.169.128])
        by smtp.gmail.com with ESMTPSA id p36sm7505315pgm.74.2021.06.06.21.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 21:47:41 -0700 (PDT)
Date:   Mon, 7 Jun 2021 10:17:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] PM: domains: Drop/restore performance state votes
 for devices at runtime PM
Message-ID: <20210607044738.3aec6o4imq6u3x6e@vireshk-i7>
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
 <20210603093438.138705-4-ulf.hansson@linaro.org>
 <20210603095538.b2t3cq25tq7v7kih@vireshk-i7>
 <CAPDyKFqNNeeMo6+gKgaPtPvgC_NuMxxYKkr+TzyP3vjYoHoDOw@mail.gmail.com>
 <CAPDyKFofsuY_RAMGsRLtKo=JxJ11DgGqOijZEEf1HEANCvomzg@mail.gmail.com>
 <20210604035312.jp2gshfigsodwvcg@vireshk-i7>
 <CAPDyKFq=mGOqYrX5322JOmJXm6Yg-zNh+g66BdaVVfE5JgciAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq=mGOqYrX5322JOmJXm6Yg-zNh+g66BdaVVfE5JgciAQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-06-21, 09:45, Ulf Hansson wrote:
> Starting calls from the subsystem/driver:
> 
> ------
> dev_pm_genpd_set_performance_state(dev, 100);
> "run a use case with device runtime resumed"
> ...
> "use case ends"
> dev_pm_genpd_set_performance_state(dev, 0);
> pm_runtime_put()
>     ->genpd_runtime_suspend()
>     gpd_data->performance_state == 0, -> gpd_data->rpm_pstate = 0;
> ...
> "new use case start"
> dev_pm_genpd_set_performance_state(dev, 100);
> pm_runtime_get_sync()
>     ->genpd_runtime_resume()
>     gpd_data->performance_state == 100, -> gpd_data->rpm_pstate = 0;
> (This is where we need to check for "zero" to not override the value)
> .....
> ------
> 
> I wouldn't say that the above is the way how I see the calls to
> dev_pm_genpd_set_performance_state (or actually
> dev_pm_opp_set_rate|opp()) being deployed. The calls should rather be
> done from the subsystem/driver's ->runtime_suspend|resume() callback,
> then the path above would work in the way you suggest.
> 
> Although, as we currently treat performance states and power states in
> genpd orthogonally, I wanted to make sure we could cope with both
> situations.

I think letting the drivers to call
dev_pm_genpd_set_performance_state(dev, 0) from suspend/resume makes
it really ugly/racy as both depend on the gpd_data->performance_state
for this. It doesn't look nice. And we shouldn't try to protect such
drivers.

Anyway, your call :)

> Did this help? :-)

Yes :)

-- 
viresh
