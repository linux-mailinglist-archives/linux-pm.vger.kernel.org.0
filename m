Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F78E61DAA
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 13:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbfGHLIt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 07:08:49 -0400
Received: from foss.arm.com ([217.140.110.172]:44916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730358AbfGHLIs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jul 2019 07:08:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2412360;
        Mon,  8 Jul 2019 04:08:47 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7F2E3F738;
        Mon,  8 Jul 2019 04:08:45 -0700 (PDT)
Date:   Mon, 8 Jul 2019 12:08:41 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: Re: [PATCH v11 1/5] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190708110838.4ohd7pqx5ngkzcsu@queper01-lin>
References: <20190708084357.12944-1-patrick.bellasi@arm.com>
 <20190708084357.12944-2-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708084357.12944-2-patrick.bellasi@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Patrick,

On Monday 08 Jul 2019 at 09:43:53 (+0100), Patrick Bellasi wrote:
> +static inline int uclamp_scale_from_percent(char *buf, u64 *value)
> +{
> +	*value = SCHED_CAPACITY_SCALE;
> +
> +	buf = strim(buf);
> +	if (strncmp("max", buf, 4)) {
> +		s64 percent;
> +		int ret;
> +
> +		ret = cgroup_parse_float(buf, 2, &percent);
> +		if (ret)
> +			return ret;
> +
> +		percent <<= SCHED_CAPACITY_SHIFT;
> +		*value = DIV_ROUND_CLOSEST_ULL(percent, 10000);
> +	}
> +
> +	return 0;
> +}
> +
> +static inline u64 uclamp_percent_from_scale(u64 value)
> +{
> +	return DIV_ROUND_CLOSEST_ULL(value * 10000, SCHED_CAPACITY_SCALE);
> +}

FWIW, I tried the patches and realized these conversions result in a
'funny' behaviour from a user's perspective. Things like this happen:

   $ echo 20 > cpu.uclamp.min
   $ cat cpu.uclamp.min
   20.2
   $ echo 20.2 > cpu.uclamp.min
   $ cat cpu.uclamp.min
   20.21

Having looked at the code, I get why this is happening, but I'm not sure
if a random user will. It's not an issue per se, but it's just a bit
weird.

I guess one way to fix this would be to revert back to having a
1024-scale for the cgroup interface too ... Though I understand Tejun
wanted % for consistency with other things.

So, I'm not sure if this is still up for discussion, but in any case I
wanted to say I support your original idea of using a 1024-scale for the
cgroups interface, since that would solve the 'issue' above and keeps
things consistent with the per-task API too.

Thanks,
Quentin
