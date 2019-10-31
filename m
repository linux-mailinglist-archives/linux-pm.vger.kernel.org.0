Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8E1CEA94F
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 03:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfJaCmL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 22:42:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:24397 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfJaCmL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Oct 2019 22:42:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 19:42:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,249,1569308400"; 
   d="scan'208";a="375093383"
Received: from yle-mobl3.ccr.corp.intel.com ([10.255.28.108])
  by orsmga005.jf.intel.com with ESMTP; 30 Oct 2019 19:42:04 -0700
Message-ID: <4efc55ad929dbb3432e72b96cb27876efa496242.camel@intel.com>
Subject: Re: [PATCH v5 0/6] Initialise thermal framework and cpufreq earlier
 during boot
From:   Zhang Rui <rui.zhang@intel.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org
Date:   Thu, 31 Oct 2019 10:42:03 +0800
In-Reply-To: <cover.1571656014.git.amit.kucheria@linaro.org>
References: <cover.1571656014.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Given that all the patches in this series have got the ACK from the
subsystem maintainers, I suppose we can take all the patches through
thermal tree, right?

thanks,
rui

On Mon, 2019-10-21 at 17:45 +0530, Amit Kucheria wrote:
> Changes since v4:
> - Collect Acks
> - Pick the US spelling for 'initialis^Hze' consistently.
> 
> Changes since v3:
> - Init schedutil governor earlier too
> - Simplified changes to thermal_init() error path
> - Collects Acks
> 
> Changes since v2:
> - Missed one patch when posting v2. Respinning.
> 
> Changes since v1:
> - Completely get rid of netlink support in the thermal framework.
> - This changes the early init patch to a single line - change to
>   core_initcall. Changed authorship of patch since it is nothing like
> the
>   original. Lina, let me know if you feel otherwise.
> - I've tested to make sure that the qcom-cpufreq-hw driver continues
> to
>   work correctly as a module so this won't impact Android's GKI
> plans.
> - Collected Acks
> 
> Device boot needs to be as fast as possible while keeping under the
> thermal
> envelope. Now that thermal framework is built-in to the kernel, we
> can
> initialize it earlier to enable thermal mitigation during boot.
> 
> We also need the cpufreq HW drivers to be initialised earlier to act
> as the
> cooling devices. This series only converts over the qcom-hw driver to
> initialize earlier but can be extended to other platforms as well.
> 
> Amit Kucheria (6):
>   thermal: Remove netlink support
>   thermal: Initialize thermal subsystem earlier
>   cpufreq: Initialize the governors in core_initcall
>   cpufreq: Initialize cpufreq-dt driver earlier
>   clk: qcom: Initialize clock drivers earlier
>   cpufreq: qcom-hw: Move driver initialization earlier
> 
>  .../driver-api/thermal/sysfs-api.rst          |  26 +----
>  drivers/clk/qcom/clk-rpmh.c                   |   2 +-
>  drivers/clk/qcom/gcc-qcs404.c                 |   2 +-
>  drivers/clk/qcom/gcc-sdm845.c                 |   2 +-
>  drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +-
>  drivers/cpufreq/cpufreq_conservative.c        |   2 +-
>  drivers/cpufreq/cpufreq_ondemand.c            |   2 +-
>  drivers/cpufreq/cpufreq_performance.c         |   2 +-
>  drivers/cpufreq/cpufreq_powersave.c           |   2 +-
>  drivers/cpufreq/cpufreq_userspace.c           |   2 +-
>  drivers/cpufreq/qcom-cpufreq-hw.c             |   2 +-
>  drivers/thermal/thermal_core.c                | 103 +---------------
> --
>  include/linux/thermal.h                       |  11 --
>  kernel/sched/cpufreq_schedutil.c              |   2 +-
>  14 files changed, 19 insertions(+), 143 deletions(-)
> 

