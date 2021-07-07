Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176733BE363
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 09:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhGGHKq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 03:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhGGHKq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 03:10:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506C8C061574;
        Wed,  7 Jul 2021 00:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s8rVR9M3vcnaDY4PlseTVYV4+Ogv/2ggCpK5ORyEo80=; b=HzC/sqTjr4iGKKcp1yDYNXMb2P
        FBxB/RSaP2Lj5Cgu+UtBhJItcEbxrc8T8ZBTZDo+2HtQBC3lmCzW44DOPeyj21x28WERLjXr132P+
        E/VNc5s1UNpp1aLAr4qoTmcRw1tZ9tNj32ES2qP1AaDD5PxdCnoEskqpPzbl+dCt2dkYtAFGDDCAR
        eOqHGfn3oqN7d1idP8fXNTSMAQoVAjAeV/8SSisMCsapCS4PrwZlPXoKh+spIZwg0zA3Mxl7A9YcI
        dj2V49HlLwSc2LEWmiXm+hn1kHTs8in/MUXK0+XxqN1PqXbvX5BSHyHTbMr1XQrIwob7IhchTyOc5
        FXq68DLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m11en-00FHbF-0m; Wed, 07 Jul 2021 07:07:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC53730021A;
        Wed,  7 Jul 2021 09:07:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A56D4200C6555; Wed,  7 Jul 2021 09:07:39 +0200 (CEST)
Date:   Wed, 7 Jul 2021 09:07:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, Chris.Redpath@arm.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, vincent.guittot@linaro.org,
        mingo@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org,
        segall@google.com, mgorman@suse.de, bristot@redhat.com,
        CCj.Yeh@mediatek.com
Subject: Re: [PATCH 2/3] PM: EM: Make em_cpu_energy() able to return bigger
 values
Message-ID: <YOVSu08LpHX5cx/+@hirez.programming.kicks-ass.net>
References: <20210625152603.25960-1-lukasz.luba@arm.com>
 <20210625152603.25960-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625152603.25960-3-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 25, 2021 at 04:26:02PM +0100, Lukasz Luba wrote:
> The Energy Model (EM) em_cpu_energy() is responsible for providing good
> estimation regarding CPUs energy. It contains proper data structures which
> are then used during calculation. The values stored in there are in
> milli-Watts precision (or in abstract scale) smaller that 0xffff, which use
> sufficient unsigned long even on 32-bit machines. There are scenarios where
> we would like to provide calculated estimations in a better precision and
> the values might be 1000 times bigger. This patch makes possible to use
> quite big values for also 32-bit machines.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/linux/energy_model.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 3f221dbf5f95..2016f5a706e0 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -101,7 +101,7 @@ void em_dev_unregister_perf_domain(struct device *dev);
>   * Return: the sum of the energy consumed by the CPUs of the domain assuming
>   * a capacity state satisfying the max utilization of the domain.
>   */
> -static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
> +static inline u64 em_cpu_energy(struct em_perf_domain *pd,
>  				unsigned long max_util, unsigned long sum_util,
>  				unsigned long allowed_cpu_cap)
>  {
> @@ -180,7 +180,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>  	 *   pd_nrg = ------------------------                       (4)
>  	 *                  scale_cpu
>  	 */
> -	return ps->cost * sum_util / scale_cpu;
> +	return div_u64((u64)ps->cost * sum_util, scale_cpu);

So these patches are all rather straight forward, however.. the above is
pretty horrific on a 32bit box, and we do quite a few of them per
wakeup. Is this really worth the performance penalty on 32bit CPUs?

Do you really still care about 32bit CPUs, or is this mostly an artifact
of wanting to unconditionally increase the precision?
