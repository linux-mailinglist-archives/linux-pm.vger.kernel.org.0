Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F95D296CF5
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 12:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461853AbgJWKh0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 06:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460872AbgJWKh0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 06:37:26 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49268C0613CE;
        Fri, 23 Oct 2020 03:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uifDgOFT+ovFqMdHJqFiOFvQ6rRjqzTBjl7A2ngyOZE=; b=U+KLDS67IR6sUenKJO2Hpvby04
        v4H68xvDSBdlDKCMYr/9xY8zpMGwM5bJuXiRfgIAbA5erYiAOG462xdnXPu26eCv+VwRGduN+CTHc
        w1DbURYhKqa7xvh43zfdFs8yqSnJsXHm5k+m+HPf6uq6SS9v0a3o9l9v+NPQyRL+5a8FiSLSl7q0F
        mTxA1XGNl21q/MbliOsDfBiMovd8ia/95v0rLDvlgBuBp6QTa4vh19WMpl9jX3CWBAMW8vKZbYnfC
        wI5eFJJqzek5/UDSFW1L/E3FCS0Lf9rPHHrEs6fHcgOuJCh/VQeZsTE+T7zSxDiOujsqHYQr0XVpQ
        7yDyvXLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVuRe-00040e-DT; Fri, 23 Oct 2020 10:37:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 025E2302753;
        Fri, 23 Oct 2020 12:37:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4DC0203D09CC; Fri, 23 Oct 2020 12:37:12 +0200 (CEST)
Date:   Fri, 23 Oct 2020 12:37:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 2/2] thermal: cpufreq_cooling: Reuse sched_cpu_util()
Message-ID: <20201023103712.GL2594@hirez.programming.kicks-ass.net>
References: <cover.1603448113.git.viresh.kumar@linaro.org>
 <11e7c7dcb07ae258fa02e187c9697252f3835466.1603448113.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11e7c7dcb07ae258fa02e187c9697252f3835466.1603448113.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 23, 2020 at 03:50:21PM +0530, Viresh Kumar wrote:
> Several parts of the kernel are already using the effective CPU
> utilization (as seen by the scheduler) to get the current load on the
> CPU, do the same here instead of depending on the idle time of the CPU,
> which isn't that accurate comparatively.
> 
> Note that, this (and CPU frequency scaling in general) doesn't work that
> well with idle injection as that is done from rt threads and is counted
> as load while it tries to do quite the opposite. That should be solved
> separately though.

Actual numbers that show the goodness would be nice ;-) Because clearly
we're doing this make it better.
