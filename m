Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094AC2F26A7
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 04:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbhALD0Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 22:26:24 -0500
Received: from mga01.intel.com ([192.55.52.88]:10196 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbhALD0X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Jan 2021 22:26:23 -0500
IronPort-SDR: D90M404xAA2QrWBunVTaMky0fezNkvhUAUJCFv4GNlaFKm6VDiXd6rkDaa8LXPZLivUZVw6LLF
 FDuLSMiOy/Xw==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="196592119"
X-IronPort-AV: E=Sophos;i="5.79,340,1602572400"; 
   d="scan'208";a="196592119"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 19:25:42 -0800
IronPort-SDR: 3s1r7R1yZdsCv6iY1gJjdsJ7OI+cHHI9ESWWeIfl8QBrVeSC2sFW7fTmE8bsRHfTQH8Ctz9v+C
 LC4nnNviKf3A==
X-IronPort-AV: E=Sophos;i="5.79,340,1602572400"; 
   d="scan'208";a="571573980"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 19:25:40 -0800
Date:   Tue, 12 Jan 2021 11:29:02 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wendy Wang <wendy.wang@intel.com>
Subject: Re: [PATCH 1/2][v2] cpufreq: intel_pstate: Add parameter to get
 guarantee frequency
Message-ID: <20210112032902.GB28619@chenyu-office.sh.intel.com>
References: <cover.1610338353.git.yu.c.chen@intel.com>
 <f03c683e06109a00ef3e3ecdd068759dfb4ac0b7.1610338353.git.yu.c.chen@intel.com>
 <CAJZ5v0i5F3kFOxzAax1RS9etrLtzLBuPRoqvbQM=NwuonFZDVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i5F3kFOxzAax1RS9etrLtzLBuPRoqvbQM=NwuonFZDVw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 11, 2021 at 01:44:09PM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 11, 2021 at 8:40 AM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > Add input parameter to receive guarantee pstate from intel_pstate_get_hwp_max()
> > for later use.
> 
> I'm not a fan of this change, because the new argument will only be
> needed in one place where intel_pstate_get_hwp_max() and it requires
> adding redundant local vars and pointless updates elsewhere.
> 
> Besides, in intel_pstate_get_cpu_pstates() you can do something like
> this after calling intel_pstate_get_hwp_max():
> 
> cpu->pstate.max_pstate = HWP_GUARANTEED_PERF(READ_ONCE(cpu->hwp_cap_cached));
> cpu->pstate.max_freq = cpu->pstate.max_pstate * cpu->pstate.scaling;
Okay, will do in next version.

Thanks,
Chenyu
