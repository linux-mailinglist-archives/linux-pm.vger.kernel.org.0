Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209CC2A03EF
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 12:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgJ3LR4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 07:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgJ3LR4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 07:17:56 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682B7C0613D4
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 04:17:55 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r186so4950375pgr.0
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 04:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8tZSXCuai/EqS9pNCPlUSIinPcL9GxCzYC4l1okgVPQ=;
        b=wUWz7M4hpuamhegnqQDtZQqVCiH11prS5lFKiBuxhAhajPr82ZFNHxtRnrIbtg1ixw
         XwerjBJvQVH6OpV9k+ShbAJAjrkcwGO1a3VNFkhoHd3FvFrZOYhwXEV4kxsvkd1/nhd+
         0lrOyoWeCzLk9RWSUMu2xmtOIqHATk1MEwyDPlD38QTnZRs3DXCda/mLpRVnaILdVj47
         p6XLrV1Vv2PHmEPP4TPB0dLpDI3wEhV2ZddFOAUAfGzZO/9VdCSKC/8vG3xWlVtp2y2U
         O8j8VZrH1rLduK4Lr0ha0J0R9hPOHULxSe/cv2sa9NIVU4NTcKpItFGqmjh6eOkq/2Lg
         dFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8tZSXCuai/EqS9pNCPlUSIinPcL9GxCzYC4l1okgVPQ=;
        b=THBbD4xGpF8LTvbehMO4eogYW6uh3D7pEIkWHl9Dt0zhw5kGp9554LYFCrWk/J71PW
         mLxSMkAVNbc+thjAUHNZjrKKoCxGJj8CwM77w0Jx46cXVGuxh7K+v0nomIHpBqETk77n
         v88b355jFG9qHKTVuA3qDm8+L8MnEPyTEk7jJuS4gL1kUHqyezfNqHOcd84SN1V94HBD
         71NLeEo1qKMSczERKEjCi+gQ+17emDbBIPbDuj5BaIFcPzza+ZdS2g5Yek/cl10om+ua
         hmPFY6z7cT528KoXr2/18rS6GuHjgqVacBzWPJTIZyutxKv1rn7CW9rRc8q8SJpfhCk+
         PogA==
X-Gm-Message-State: AOAM532mvMxFAL0cKRWjBj5kedjVvUl3u/7GJ91YjwBtpPKqXt0KOQzA
        VzpDm4uGROL1/JCuYN8ulh5aMw==
X-Google-Smtp-Source: ABdhPJxROwE5uyWNQcOF0en2iekQlGHuODh+GSES+JiJXkHRHavcgpIqGWLTojNoc4qG9KYuzZ55WA==
X-Received: by 2002:a63:ee02:: with SMTP id e2mr1653806pgi.287.1604056674886;
        Fri, 30 Oct 2020 04:17:54 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id ca5sm3198225pjb.27.2020.10.30.04.17.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2020 04:17:54 -0700 (PDT)
Date:   Fri, 30 Oct 2020 16:47:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com, rafael@kernel.org,
        sudeep.holla@arm.com, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com
Subject: Re: [PATCH 0/4] Add sustainable OPP concept
Message-ID: <20201030111751.i7zdsi7ruzmnyxk6@vireshk-i7>
References: <20201028140847.1018-1-lukasz.luba@arm.com>
 <20201029074057.6ugmwyzna52x3oli@vireshk-i7>
 <20201029075356.rruej6jlerhfa4oy@vireshk-i7>
 <228fa1b3-bbd3-6941-fd4b-06581016d839@arm.com>
 <20201030082937.xgjmko2ohwhkt6f5@vireshk-i7>
 <a0a6db69-fc3e-c39f-7586-5ac3227b746e@arm.com>
 <20201030095248.abej6h5wphud2ihb@vireshk-i7>
 <757fe3b1-745f-2656-fe21-c7b39f123a25@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <757fe3b1-745f-2656-fe21-c7b39f123a25@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-10-20, 10:56, Lukasz Luba wrote:
> IPA tries to do that, even dynamically when e.g. GPU is supper busy
> in 3D games (~2000W) or almost idle showing 2D home screen.
> It tries to find highest 'sustainable' frequencies for the devices,
> at that various workloads and temp. But it needs some coefficients to
> start, which have big impact on the algorithm. It could slow down IPA a
> lot, when those coefficients are calculated based on lowest OPPs.

I see. So when you say it slows down IPA, what does that really mean ?
IPA isn't performing that accurately during the initial period of
booting (any time estimate here) ? Does it work fine after a time
duration? Or will it suffer for ever ?

And maybe you shouldn't start with the lowest OPPs while you calculate
these coefficients dynamically ? Maybe start from the middle ? As the
sustainable OPP would be something there only or maybe a bit higher
only. But yeah, I don't have any idea about how those coefficients are
calculated so this idea can be simply ignored as well :)

> My backup plan was to add a flag into EM em_perf_state, extend SCMI perf
> exposing the 'sustained_freq_khz' to scmi-cpufreq, which would set that
> field after registering EM. IPA depends on EM, so should be OK.

I think at this point (considering the limited number of users (only
IPA) and providers (only SCMI)), it would be better that way only
instead of updating the OPP framework. Of course we can revisit that
if we ever feel that we need a better placeholder for it.

> > So only SCMI based platforms will be able to use this stuff ? That's
> > very limited, isn't it ? I think we should still try to make it better
> > for everyone by making the software smarter. It has so much data, the
> > OPPs, the power it will consume (based on microvolt property?), the
> > heat we produce from that (from thermal framework), etc. Perhaps
> > building this information continuously at runtime based on when and
> > how we hit the trip points ? So we know which is the right frequency
> > where we can refrain from hitting the trip points.
> 
> IPA works in this way.

Nice, that's what I thought as well but then got a bit confused with
your patchset.

> > But may be I am asking too much :(
> > 
> 
> When you asked for user of this, I gave you instantly. This is one is
> more difficult. I am still not there with IPA tests in LISA. I have some
> out-of-tree kernel driver for testing, which also need polishing before
> can be used with LISA. Then proper workloads with results processing.
> EM for devfreq cooling devices. Then decent 'hot' board running
> preferably mainline kernel.
> What you requested is on my list, but it needs more work, which
> won't be ready over night.

I can understand what you are trying to do here. And this surely
requires a lot of effort.

-- 
viresh
