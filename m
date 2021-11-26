Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D93945F259
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 17:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378433AbhKZQtr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 11:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbhKZQrq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 11:47:46 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFF6C0613ED;
        Fri, 26 Nov 2021 08:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uneliOWtZMP7i1QI58GzHZvDj/yxdUW4ods64b/KyKg=; b=IxgNGZpqAKx4V9m5NpisDuE2xs
        MuCMQXIGt9saJvZ9v9Q8jDFpMIuS7hz8Ju4/CapgBbXI76fEq0OaO2oV9piTp9CLUwGoPu3cou4iI
        4XzNzTEo/jV/yFkpwH6SUcPR3Rjkj/bIelf8NS4reu0mEwTkzM2CJHv3knoOBQMdhD/+VRG7Hib6p
        BcG1xSzqHKdV9tLvsDT9u11bb8229O3ltdlbqeUwG0eYyh05Xiw2dw/2wvFjs/Rai7xLgN9fPIT/N
        QttLihlR1jj/MRpPE5YLGfDsKfnKcaLiZCdvFJMPvZ9zzwvWyYqRpvGAD/DOQ9oVCgEmCXauIOqlg
        jle0Vhcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqeAo-000k2v-Bg; Fri, 26 Nov 2021 16:34:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1F78D300230;
        Fri, 26 Nov 2021 17:34:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC5762DC57755; Fri, 26 Nov 2021 17:34:04 +0100 (CET)
Date:   Fri, 26 Nov 2021 17:34:04 +0100
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
Message-ID: <YaEMfIqBxv350Wjx@hirez.programming.kicks-ass.net>
References: <1637830481-21709-1-git-send-email-quic_mkshah@quicinc.com>
 <1637830481-21709-3-git-send-email-quic_mkshah@quicinc.com>
 <YZ9Y2w2xIrw39B/K@hirez.programming.kicks-ass.net>
 <f7a1c6de-ae1d-1615-1212-bdb9bdcdbcbc@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7a1c6de-ae1d-1615-1212-bdb9bdcdbcbc@quicinc.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 25, 2021 at 07:01:44PM +0530, Maulik Shah wrote:
> Hi Peter,
> 
> On 11/25/2021 3:05 PM, Peter Zijlstra wrote:
> > On Thu, Nov 25, 2021 at 02:24:39PM +0530, Maulik Shah wrote:
> > > Export symbols that are used by cpuidle menu governor in preparation
> > > to allow cpuidle governors to be compiled as modules.
> > > 
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Juri Lelli <juri.lelli@redhat.com>
> > > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > > Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> > > ---
> > >   kernel/sched/core.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 8cffe31..1d031e0 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -5047,6 +5047,7 @@ unsigned int nr_iowait_cpu(int cpu)
> > >   {
> > >   	return atomic_read(&cpu_rq(cpu)->nr_iowait);
> > >   }
> > > +EXPORT_SYMBOL(nr_iowait_cpu);
> > NACK, that function is batshit insane, exporting it serves nobody.
> Thanks for the review.
> Exporting is to serve cpuidle menu governor when its compiled as module
> (last patch in this series).
> 
> otherwise we get below error during compilation,
> ERROR: modpost: "nr_iowait_cpu" [drivers/cpuidle/governors/menu.ko]
> undefined!
> 
> Do you suggest to use something else instead of this?

Yeah, schedutil :-)
