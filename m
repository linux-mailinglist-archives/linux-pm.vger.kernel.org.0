Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70769DA935
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 11:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394020AbfJQJu2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 05:50:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389021AbfJQJu1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 05:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uu3/FssGPvc9bsO3GOIGB+VT5qhdtx//Wfg/xU4VhNY=; b=BHV2PXfsUxEKf92uymtT6Ct55
        rC5b6cEA70Y6OcY6aqKoAbvrUDTVWKgJlN8xWEudSTu/B7JNkhvnRLQNSU/Na5Cc7t/ePgAQFa1QN
        q/shrW3+Q8uyF9Olm0ZH7Jvcik3HXjZoKdDAq99CO7e/pwuCkl/S0vYZyi46Tn1Gh6hVbnMSFQpxi
        6Accm0fIpyKtHyOauq0m3CQzJGImmMz6eAhQhUz2cV3BhvVtSbIBf16+Nv/adt+C039ZfbRu/FnuS
        IXqC8Le+TUYE3ZNoE9mewbpcr+GLCZps3FMxhW42HXEcOfP48+zFcfIKaRvhEABQ7Pf4TU9zJWg4K
        3Nn2NqW3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL2QE-0008Ta-KR; Thu, 17 Oct 2019 09:50:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6525130018A;
        Thu, 17 Oct 2019 11:49:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B0A4A200DE9E2; Thu, 17 Oct 2019 11:50:15 +0200 (CEST)
Date:   Thu, 17 Oct 2019 11:50:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
Subject: Re: [RFC PATCH v3 0/6] sched/cpufreq: Make schedutil energy aware
Message-ID: <20191017095015.GI2311@hirez.programming.kicks-ass.net>
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191014145315.GZ2311@hirez.programming.kicks-ass.net>
 <a1ce67d7-62c3-b78b-1d87-23ef4dbc2274@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1ce67d7-62c3-b78b-1d87-23ef4dbc2274@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 14, 2019 at 04:50:24PM +0100, Douglas Raillard wrote:

> I posted some numbers based on a similar experiment on the v2 of that series that
> are still applicable:
> 
> TL;DR the rt-app negative slack is divided by 1.75 by this series, with an
> increase of 3% in total energy consumption. There is a burst every 0.6s, and
> the average power consumption increase is proportional to the average number
> of bursts.
> 
> 
> The workload is an rt-app task ramping up from 5% to 75% util in one big step,
> pinned on a big core. The whole cycle is 0.6s long (0.3s at 5% followed by 0.3s at 75%).
> This cycle is repeated 20 times and the average of boosting is taken.
> 
> The test device is a Google Pixel 3 (Qcom Snapdragon 845) phone.
> It has a lot more OPPs than a hikey 960, so gradations in boosting
> are better reflected on frequency selection.
> 
> avg slack (higher=better):
>     Average time between task sleep and its next periodic activation.
>     See rt-app doc: https://github.com/scheduler-tools/rt-app/blob/9a50d76f726d7c325c82ac8c7ed9ed70e1c97937/doc/tutorial.txt#L631
> 
> avg negative slack (lower in absolute value=better):
>     Same as avg slack, but only taking into account negative values.
>     Negative slack means a task activation did not have enough time to complete before the next
>     periodic activation fired, which is what we want to avoid.
> 
> boost energy overhead (lower=better):
>     Extra power consumption induced by ramp boost, assuming continuous OPP space (infinite number of OPP)
>     and single-CPU policies. In practice, fixed number of OPP decrease this value, and more CPU per policy increases it,
>     since boost(policy) = max(boost(cpu) foreach cpu of policy)).
> 
> Without ramp boost:
> +--------------------+--------------------+
> |avg slack (us)      |avg negative slack  |
> |                    |(us)                |
> +--------------------+--------------------+
> |6598.72             |-10217.13           |
> |6595.49             |-10200.13           |
> |6613.72             |-10401.06           |
> |6600.29             |-9860.872           |
> |6605.53             |-10057.64           |
> |6612.05             |-10267.50           |
> |6599.01             |-9939.60            |
> |6593.79             |-9445.633           |
> |6613.56             |-10276.75           |
> |6595.44             |-9751.770           |
> +--------------------+--------------------+
> |average                                  |
> +--------------------+--------------------+
> |6602.76             |-10041.81           |
> +--------------------+--------------------+
> 
> 
> With ramp boost enabled:
> +--------------------+--------------------+--------------------+
> |boost energy        |avg slack (us)      |avg negative slack  |
> |overhead (%)        |                    |(us)                |
> +--------------------+--------------------+--------------------+
> |3.05                |7148.93             |-5664.26            |
> |3.04                |7144.69             |-5667.77            |
> |3.05                |7149.05             |-5698.31            |
> |2.97                |7126.71             |-6040.23            |
> |3.02                |7140.28             |-5826.78            |
> |3.03                |7135.11             |-5749.62            |
> |3.05                |7140.24             |-5750.0             |
> |3.05                |7144.84             |-5667.04            |
> |3.07                |7157.30             |-5656.65            |
> |3.06                |7154.65             |-5653.76            |
> +--------------------+--------------------+--------------------+
> |average                                                       |
> +--------------------+--------------------+--------------------+
> |3.039000            |7144.18             |-5737.44            |
> +--------------------+--------------------+--------------------+
> 
> 
> The negative slack is due to missed activations while the utilization signals
> increase during the big utilization step. Ramp boost is designed to boost frequency during
> that phase, which materializes in 1.75 less negative slack, for an extra power
> consumption under 3%.

OK, so I think I see what it is doing, and why.

Normally we use (map_util_freq):

	freq = C * max_freq * util / max ; C=1.25

But here, when util is increasing, we effectively increase our C to
allow picking a higher OPP. Because of that higher OPP we finish our
work sooner (avg slack increases) and miss our activation less often
(avg neg slack decreases).

Now, the thing is, we use map_util_freq() in more places, and should we
not reflect this increase in C for all of them? That is, why is this
patch changing get_next_freq() and not map_util_freq().

I don't think that question is answered in the Changelogs.

Exactly because it does change the energy consumption (it must) should
that not also be reflected in the EAS logic?

I'm still thinking about the exact means you're using to raise C; that
is, the 'util - util_est' as cost_margin. It hurts my brain still.
