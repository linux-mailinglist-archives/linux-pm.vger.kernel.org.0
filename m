Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25997BCC79
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 18:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbfIXQbH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 12:31:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37500 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfIXQbH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 12:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e03yNyv18XQT6RapoohQLWLNNMNXH+8qzkaYvbpna9s=; b=Mu5tZKXMT230E8UcbicuHBk8V
        TMOZ1VXzRMyj82Mq4O5cJPw1Lr/+IGVzX1KwbpBN2C0sulagcr2VjWT3iAsmEfKaeIZ+lO8oOKWyt
        BysdR2FNFLN20ai8HYIGNuEKmE5qQ+AEg0nxYx4VxEubfkKodOpnQP4wsW6dojq4UlAAa8V/zcr8M
        ddIcBiK3bz0njiFVIHrJyPWtdSMm9+LV6aj5zyJljPBwoy/9IJmGF9nxbpQGSiCnMGVVRDiKVXlQG
        D9udQZpecHq8ydfI/89R/j3OzopBSXLqVEa5CtA3OrMSsBVdCRxXPgHv4T8tEJ+qoMvgEqTt3994A
        F3NgNKpRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCniJ-0000yZ-JQ; Tue, 24 Sep 2019 16:30:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 48300301A7A;
        Tue, 24 Sep 2019 18:30:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E29E1200A1239; Tue, 24 Sep 2019 18:30:53 +0200 (CEST)
Date:   Tue, 24 Sep 2019 18:30:53 +0200
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
Message-ID: <20190924163053.GA4519@hirez.programming.kicks-ass.net>
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
> +static const struct x86_cpu_id has_turbo_ratio_group_limits[] = {
> +	ICPU(INTEL_FAM6_ATOM_GOLDMONT),
> +	ICPU(INTEL_FAM6_ATOM_GOLDMONT_X),

That's GOLDMONT_D in recent tip kernels.

> +	ICPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS),
> +	ICPU(INTEL_FAM6_SKYLAKE_X),

What about KABYLAKE_X and ICELAKE_X ?

> +	{}
> +};
