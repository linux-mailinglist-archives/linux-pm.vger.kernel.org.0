Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 289975D337
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2019 17:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfGBPob (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 11:44:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGBPob (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 11:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yNPjqLdRTJCzgCZVeC3z+YefMIDSKzflp7zcy3fLwqs=; b=T127DeqEzG8CkEzFsFjGbAebE
        motUh25iUQewOFQHvknqYG2eDCh0zjdY7q0TCfFwAExGnZPD2C9Qquo0AZgieACMJQRZMVp6246L5
        sA23h3NrnMxHZTijEXwt/v9JYgGVCR4B40Xflz5mJeU7nQhuaEja8z63y9Gb9PS3GAHAZccaY+cht
        OYqBCWn40sLRWSVCweGwfZOQdFebYwoUSzKai0IjbTNb54SFw3gjA4Z+GKCOfYXf3Kmrx1xAHl7tV
        tu4p+fVRKxwAdSY4bWQi6zNb+bowRFQbmDv9VdGxpOekg29NE7yf07YVDhzyswriLKM8dUIuvmf+y
        Bg4kihsaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiKxE-0007gr-E5; Tue, 02 Jul 2019 15:44:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23DB92013A3B6; Tue,  2 Jul 2019 17:44:22 +0200 (CEST)
Date:   Tue, 2 Jul 2019 17:44:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        quentin.perret@arm.com, patrick.bellasi@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH v2 0/5] sched/cpufreq: Make schedutil energy aware
Message-ID: <20190702154422.GV3436@hirez.programming.kicks-ass.net>
References: <20190627171603.14767-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627171603.14767-1-douglas.raillard@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 27, 2019 at 06:15:58PM +0100, Douglas RAILLARD wrote:
> Make schedutil cpufreq governor energy-aware.
> 
> - patch 1 introduces a function to retrieve a frequency given a base
>   frequency and an energy cost margin.
> - patch 2 links Energy Model perf_domain to sugov_policy.
> - patch 3 updates get_next_freq() to make use of the Energy Model.

> 
> 1) Selecting the highest possible frequency for a given cost. Some
>    platforms can have lower frequencies that are less efficient than
>    higher ones, in which case they should be skipped for most purposes.
>    They can still be useful to give more freedom to thermal throttling
>    mechanisms, but not under normal circumstances.
>    note: the EM framework will warn about such OPPs "hertz/watts ratio
>    non-monotonically decreasing"

Humm, for some reason I was thinking we explicitly skipped those OPPs
and they already weren't used.

This isn't in fact so, and these first few patches make it so?
