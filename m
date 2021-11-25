Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3801D45D75D
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 10:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351266AbhKYJl7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 04:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345522AbhKYJj7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 04:39:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFC5C0613F3;
        Thu, 25 Nov 2021 01:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P1pcydZs6dZBLovcMA7qf5gPH03iCI6G8kSvFerDlv0=; b=CMhXsaaCx/Ca63hdpuIXQf48vF
        CUAc22bJGKl48YoCqg/mclRSFhvEDQDytgoKvA3P163Z9T5VAC2wbGYt52xIADEkTSYGYgjxIctyT
        ffHeg5CVgX9cBJaHc2RNW4nSXh11o2DqzIynwkYIeiWfxf9aXemDOV9tsPZgKDIJLc+OnEWvQifXy
        vEEQNnXJYUakSyJBunMvfPVwMRz8gmrYyCFdTgGai1Su4x3M0Uxmo4cuZosKsinbFM1k6lFPF9lFP
        rmyPZCtcarDICYTdaapQVR8BlynPJIj09SqxiZr9OTJwKjE9vE5uVBgTr8mpY0E3AzXkSvbtShcYK
        rBg0It7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqBA3-005jht-T7; Thu, 25 Nov 2021 09:35:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 88316300093;
        Thu, 25 Nov 2021 10:35:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 606032010E27D; Thu, 25 Nov 2021 10:35:23 +0100 (CET)
Date:   Thu, 25 Nov 2021 10:35:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     bjorn.andersson@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, quic_lsrao@quicinc.com,
        rnayak@codeaurora.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 2/4] sched/core: Export symbols used by cpuidle governors
Message-ID: <YZ9Y2w2xIrw39B/K@hirez.programming.kicks-ass.net>
References: <1637830481-21709-1-git-send-email-quic_mkshah@quicinc.com>
 <1637830481-21709-3-git-send-email-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637830481-21709-3-git-send-email-quic_mkshah@quicinc.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 25, 2021 at 02:24:39PM +0530, Maulik Shah wrote:
> Export symbols that are used by cpuidle menu governor in preparation
> to allow cpuidle governors to be compiled as modules.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> ---
>  kernel/sched/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8cffe31..1d031e0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5047,6 +5047,7 @@ unsigned int nr_iowait_cpu(int cpu)
>  {
>  	return atomic_read(&cpu_rq(cpu)->nr_iowait);
>  }
> +EXPORT_SYMBOL(nr_iowait_cpu);

NACK, that function is batshit insane, exporting it serves nobody.
