Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4B61CA5B6
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 10:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgEHII3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 04:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgEHII2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 04:08:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B5AC05BD43;
        Fri,  8 May 2020 01:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4XnbhfMZcDtvX6mBfSYEuzsy9imHuYPuFl0ll76/owE=; b=E1sFodlB22UHxG6gZYvmNEfpcH
        yYpTm7c+rtxqHOHrJKbEg68TrvAj1mv+S90QX6ibNRkuqtBc1CDjqOhVv/H1sFUOOGBI50JVLaBmP
        bRHEn4PljWTA7TPjJMUsx4ACAv9d2WbP0pOHb/IMZExMo+2SAVh3rcz4QtLFTWLRIv80ApUSd7Cv1
        RaaqtbUMXkSRduY2PJ0a2T+VFac5Pzlw/jHDsBlEWTo/iQnswBvgNYbR5V5D8LPwtsUEV61Zew/WC
        Gh8phbr1Qr/2LKOMbAMZmyP2lQ3ZIP+35E7M0Qx/Udji/s7UjYaUEYWIHas4Lgyk22foSjQZpWoli
        EHqf5j9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWy39-0004iv-Bk; Fri, 08 May 2020 08:08:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB86E3010C8;
        Fri,  8 May 2020 10:07:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C67602038FB83; Fri,  8 May 2020 10:07:59 +0200 (CEST)
Date:   Fri, 8 May 2020 10:07:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        fweisbec@gmail.com, tkjos@google.com, kernel-team@android.com
Subject: Re: [PATCH 08/14] sched/core: Export runqueues per-cpu array
Message-ID: <20200508080759.GL5298@hirez.programming.kicks-ass.net>
References: <20200507181012.29791-1-qperret@google.com>
 <20200507181012.29791-9-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507181012.29791-9-qperret@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 07, 2020 at 07:10:06PM +0100, Quentin Perret wrote:
> It will be needed by schedutil once modularized, export it.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
> This is only needed for cpu_rq() -> cpu_bw_dl() in schedutil, so there is
> probably an alternative if exporting this isn't desirable.
> ---
>  kernel/sched/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index dbaf3f63df22..537eb45b4274 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -36,6 +36,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
>  
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> +EXPORT_SYMBOL_GPL(runqueues);

NAK, never going to happen.
