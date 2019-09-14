Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B3AB2B1A
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2019 13:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbfINLet (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Sep 2019 07:34:49 -0400
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:34552 "EHLO
        1.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729901AbfINLet (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Sep 2019 07:34:49 -0400
X-Greylist: delayed 1796 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Sep 2019 07:34:48 EDT
Received: from player762.ha.ovh.net (unknown [10.108.54.141])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id B1A4711917C
        for <linux-pm@vger.kernel.org>; Sat, 14 Sep 2019 12:57:34 +0200 (CEST)
Received: from qperret.net (115.ip-51-255-42.eu [51.255.42.115])
        (Authenticated sender: qperret@qperret.net)
        by player762.ha.ovh.net (Postfix) with ESMTPSA id 8F3539D07C50;
        Sat, 14 Sep 2019 10:57:14 +0000 (UTC)
Date:   Sat, 14 Sep 2019 12:57:08 +0200
From:   Quentin Perret <qperret@qperret.net>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, bp@suse.de,
        lenb@kernel.org, rjw@rjwysocki.net, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, matt@codeblueprint.co.uk,
        viresh.kumar@linaro.org, juri.lelli@redhat.com, pjt@google.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH 1/2] x86,sched: Add support for frequency invariance
Message-ID: <20190914105708.GA12877@qperret.net>
References: <20190909024216.5942-1-ggherdovich@suse.cz>
 <20190909024216.5942-2-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909024216.5942-2-ggherdovich@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Ovh-Tracer-Id: 14383934262635617173
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtdelgdefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Giovanni

On Monday 09 Sep 2019 at 04:42:15 (+0200), Giovanni Gherdovich wrote:
> +static inline long arch_scale_freq_capacity(int cpu)
> +{
> +	if (static_cpu_has(X86_FEATURE_APERFMPERF))
> +		return per_cpu(arch_cpu_freq, cpu);

So, if this is conditional, perhaps you could also add this check in an
x86-specific implementation of arch_scale_freq_invariant() ? That would
guide sugov in the right path (see get_next_freq()) if APERF/MPERF are
unavailable.

> +	return 1024 /* SCHED_CAPACITY_SCALE */;
> +}

Thanks,
Quentin
