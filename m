Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 219D6C90D7
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 20:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfJBS2S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 14:28:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBS2S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 14:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=96la58gVKcd/IPrCDjANz2T8kDNFpSL3xM8lpSJtFpc=; b=CCOLZ4SE23QMLmce5D5G1Ec6b
        sM7VLGa+SfcWpro867kEc183BRJNvnqD4Dal4s7ZKfjkaL/TmTAR2HOONTkks3Npmfz8qVfDmmqfd
        /0q4P2NjX5W5feBpmQbkwpFLSGaKJp/6sKg68+74i/1VuB+LlMuJY1CfLMwhTvzr1Ai2j4O8joZjg
        Im+OuW19A6Iji79yUvmcDoeET/1EwIM+5HnYEFFPrEOUedrIOJYRaetluxZ6OZRgsB4LJwuz6mROp
        bsFjXSNK61Ejnd2bMDynY9xtdQb802h9WJ4ZZaWxVJDn5A6gXOQ2ua/xOgY1JZemuB/nJIXTMyZN2
        WBPG0qD3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFjLx-0004hA-2I; Wed, 02 Oct 2019 18:27:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E9979802BF; Wed,  2 Oct 2019 20:27:55 +0200 (CEST)
Date:   Wed, 2 Oct 2019 20:27:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [PATCH v2 1/2] x86,sched: Add support for frequency invariance
Message-ID: <20191002182754.GD4643@worktop.programming.kicks-ass.net>
References: <20191002122926.385-1-ggherdovich@suse.cz>
 <20191002122926.385-2-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002122926.385-2-ggherdovich@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 02, 2019 at 02:29:25PM +0200, Giovanni Gherdovich wrote:
> +void x86_arch_scale_freq_tick_enable(void)
> +{
> +	tick_disable = false;
> +}
> +
> +static void reset_scale_freq(void *arg)
> +{
> +	this_cpu_write(arch_cpu_freq, SCHED_CAPACITY_SCALE);
> +}
> +
> +void x86_arch_scale_freq_tick_disable(void)
> +{
> +	on_each_cpu(reset_scale_freq, NULL, 1);
> +	tick_disable = true;

I'm thikning this ought to be the other way around, otherwise we can get
a tick loosing the 1024 we just wrote in arch_cpu_freq.

> +}

You've lost the prev_{a,m}perf update, so the first tick after enable
will see 'funny' values.
