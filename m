Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0912EBCC0E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 18:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394691AbfIXQE7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 12:04:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49860 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391013AbfIXQE6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 12:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DrA7bFKwIOoag2aduILYVU+ngioLiFeCj1i91CCn1bw=; b=vs2bZZByr1rQHI73Tn81WvTKd
        WJ9Xz2zdf9enGGoCAKuytnpjE/I34yrDv89TQO47IwSobZ3AKx7uFC4SbD1wmFIHineftJxvNx3GH
        V4uUKAXH76Aw0gFP4l8bYqJoMyl/gtSZ8JYmgfe9X8joaklsPbU/4CHkenHHHmK/L/MI4+mZzN/gB
        UaeLq6xIJ7G06579YB/um+lk3Zxt5KYia0A46PeQuVgmlFZSP5yDu4RxsAWXwraPkKoZzbgvoiy0Z
        4PBjQBakOZRgtlSKzDeFlzhzvHWQ+5s8xgd0W3Wb5bWWPvn4acS8lPONw3s1lhgOS0XWVg4A/qDyL
        JX1/hfiUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCnIe-0003af-OH; Tue, 24 Sep 2019 16:04:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7A8C83053E9;
        Tue, 24 Sep 2019 18:03:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 26C8329E510E1; Tue, 24 Sep 2019 18:04:23 +0200 (CEST)
Date:   Tue, 24 Sep 2019 18:04:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@suse.de, lenb@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        matt@codeblueprint.co.uk, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, pjt@google.com, vincent.guittot@linaro.org,
        qperret@qperret.net, dietmar.eggemann@arm.com
Subject: Re: [PATCH 1/2] x86,sched: Add support for frequency invariance
Message-ID: <20190924160423.GN2369@hirez.programming.kicks-ass.net>
References: <20190909024216.5942-1-ggherdovich@suse.cz>
 <20190909024216.5942-2-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909024216.5942-2-ggherdovich@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 09, 2019 at 04:42:15AM +0200, Giovanni Gherdovich wrote:

> +static void intel_set_cpu_max_freq(void)
> +{
> +	/*
> +	 * TODO: add support for:
> +	 *
> +	 * - Xeon Phi (KNM, KNL)
> +	 * - Xeon Gold/Platinum, Atom Goldmont/Goldmont Plus
> +	 * - Atom Silvermont

ISTR I had code for Atom.. what happened with that?

> +	 *
> +	 * which all now get by default arch_max_freq = SCHED_CAPACITY_SCALE
> +	 */
> +	core_set_cpu_max_freq();
> +}
