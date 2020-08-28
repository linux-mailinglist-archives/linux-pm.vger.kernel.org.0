Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D328255495
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 08:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgH1GfQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 02:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgH1GfP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 02:35:15 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA1FC061264
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 23:35:15 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s2so77332pjr.4
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 23:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FQ9m7rOG4pcefSrbBbgAU9ykq2A7WMGzE5Rx/ZaZNLs=;
        b=xCIRThnOhSion0cQo5SnfvpCnaQG5BTb+lcXkAp+x9occ7CJb8PjpxomAr//zInYM1
         BKO77WX4AQJutbPU1/ztPjon47v93xZiJDju4dIqOCXj8C/S8A7dDnG02kXh6NC6aK2A
         7LPN78JgoYB+zUKe72OTgcfYDQ+KyRfAaXSc3W1+qbPFec/jW8w9PXbhVShSNDJ+O4OG
         AhmIZyzWLziG/DpLZGjfKRGYB2pyg7cdeigEm2OjND5rRn8ilmpoozis97CTd6B5gbSr
         KlbekG5rJzNADfl3dTL9R9naRyG3r2pqsmNz+7Nq3A/WKN91dBovrS82d/NLYMm7F6pZ
         WPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FQ9m7rOG4pcefSrbBbgAU9ykq2A7WMGzE5Rx/ZaZNLs=;
        b=kUIDhhIreD6/c5ibIjYgwD2X81gfLwmpGCgXzHxs/vyk65Kqv3yIAI9vQugctUFplz
         2xJZCsJGsBNDWDRau87N8CRoUD2T2uM4FcDjYZaCCwvAb6uCzS9ipaMyzwdy87P3S/lG
         J5Q75ZVs6/XGPablztfA3zti95ET2jRisBce5HDno8tDKN/lB7s42Ftcr18taT53CXsC
         1e8074fNie1QgCVH2tK1PeYE2yO9lrumepx+u9zNicoDhvEkkE6MHARwViOM/zCJdHT7
         Z3p3PrErHkFYjxJi8l7wud4hCVffUugisacTg8WPTKQR6EtApvMHBnL3iLhwWx5Lqb/J
         PgtA==
X-Gm-Message-State: AOAM531EAAcxXML+BZwAc+zc4qBuZbAQbw2WW0I005gEgeRDvHiNi6aS
        zke1fQjEw7qcGFU5EXafp/G9mA==
X-Google-Smtp-Source: ABdhPJw9EzNUIFcdrMBzZ7k++cAXU94s6WolbnROMNHYs4Dk5ewHyG7KWFYqu1Glqd5JUO+EPQfXwQ==
X-Received: by 2002:a17:90a:e7c8:: with SMTP id kb8mr385908pjb.104.1598596514394;
        Thu, 27 Aug 2020 23:35:14 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id f13sm222789pfd.215.2020.08.27.23.35.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 23:35:13 -0700 (PDT)
Date:   Fri, 28 Aug 2020 12:05:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [PATCH v2] opp: Power on (virtual) power domains managed by the
 OPP core
Message-ID: <20200828063511.y47ofywtu5qo57bq@vireshk-i7>
References: <20200826093328.88268-1-stephan@gerhold.net>
 <20200827100104.yuf2nzb6qras7zcw@vireshk-i7>
 <20200827114422.GA1784@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827114422.GA1784@gerhold.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-08-20, 13:44, Stephan Gerhold wrote:
> Hmm. Actually I was using this parameter for initial testing, and forced
> on the power domains from the qcom-cpufreq-nvmem driver. For my v1 patch
> I wanted to enable the power domains in dev_pm_opp_set_rate(), so there
> using the virt_devs parameter was not possible.

Right, as we really do not want to enable it there and leave it for
the real consumers to handle.

> On the other hand, creating the device links would be possible from the
> platform driver by using the parameter.

Right.

> > And so I think again if this patch should be picked instead of letting
> > the platform handle this ?
> 
> It seems like originally the motivation for the parameter was that
> cpufreq consumers do *not* need to power on the power domains:
> 
> Commit 17a8f868ae3e ("opp: Return genpd virtual devices from dev_pm_opp_attach_genpd()"):
>  "The cpufreq drivers don't need to do runtime PM operations on
>   the virtual devices returned by dev_pm_domain_attach_by_name() and so
>   the virtual devices weren't shared with the callers of
>   dev_pm_opp_attach_genpd() earlier.
> 
>   But the IO device drivers would want to do that. This patch updates
>   the prototype of dev_pm_opp_attach_genpd() to accept another argument
>   to return the pointer to the array of genpd virtual devices."

Not just that I believe. There were also arguments that only the real
consumer knows how to handle multiple power domains. For example for a
USB or Camera module which can work in multiple modes, we may want to
enable only one power domain in say slow mode and another power domain
in fast mode. And so these kind of complex behavior/choices better be
left for the end consumer and not try to handle this generically in
the OPP core.

> But the reason why I made this patch is that actually something *should*
> enable the power domains even for the cpufreq case.

Ulf, what do you think about this ? IIRC from our previous discussions
someone asked me not do so.

> If every user of dev_pm_opp_attach_genpd() ends up creating these device
> links we might as well manage those directly from the OPP core.

Sure, I am all in for reducing code duplication, but ...

> I cannot think of any use case where you would not want to manage those
> power domains using device links. And if there is such a use case,
> chances are good that this use case is so special that using the OPP API
> to set the performance states would not work either. In either case,
> this seems like something that should be discussed once there is such a
> use case.

The example I gave earlier shows a common case where we need to handle
this at the end users which still want to use the OPP API.

> At the moment, there are only two users of dev_pm_opp_attach_genpd():
> 
>   - cpufreq (qcom-cpufreq-nvmem)
>   - I/O (venus, recently added in linux-next [1])
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=9a538b83612c8b5848bf840c2ddcd86dda1c8c76
> 
> In fact, venus adds the device link exactly the same way as in my patch.
> So we could move that to the OPP core, simplify the venus code and
> remove the virt_devs parameter. That would be my suggestion.
> 
> I can submit a v3 with that if you agree (or we take this patch as-is
> and remove the parameter separately - I just checked and creating a
> device link twice does not seem to cause any problems...)

I normally tend to agree with the logic that lets only focus on what's
upstream and not think of virtual cases which may never happen. But I
was told that this is too common of a scenario and so it made sense to
do it this way.

Maybe Ulf can again throw some light here :)

-- 
viresh
