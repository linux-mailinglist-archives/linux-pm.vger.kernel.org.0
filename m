Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5162D402095
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 22:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244008AbhIFT6H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 15:58:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:49114 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231432AbhIFT6F (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 Sep 2021 15:58:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="219723931"
X-IronPort-AV: E=Sophos;i="5.85,273,1624345200"; 
   d="scan'208";a="219723931"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 12:57:00 -0700
X-IronPort-AV: E=Sophos;i="5.85,273,1624345200"; 
   d="scan'208";a="579729714"
Received: from ibelagox-mobl1.gar.corp.intel.com ([10.213.76.130])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 12:56:56 -0700
Message-ID: <980bc41a8bedbd81c199a78ce9f2ab2ef7b9341f.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix for HWP interrupt before
 driver is ready
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 06 Sep 2021 12:56:53 -0700
In-Reply-To: <CAJZ5v0iH3TacxX3gzBS5cah7SnmDWbmHz=WCujQJpmEggGhLhg@mail.gmail.com>
References: <20210904053703.581297-1-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0hQp8Hxf__tL22s0oOcTym5mx9tND34ijufTDE3_NSW6A@mail.gmail.com>
         <926ac4b9-1bb5-e96e-ded3-6461f7a215b7@kernel.dk>
         <b1d5b6daacef349eb6fcc23ce7264e4786d1d9f4.camel@linux.intel.com>
         <CAJZ5v0jaXnw0zjpnsb81Hauy4-ApuULfQaaLG10qqL67H-YTNA@mail.gmail.com>
         <8dc57921f157b154e4af2dba26ce697dc4d4fcc2.camel@linux.intel.com>
         <CAJZ5v0jLmziZZEqEk-D+b6jD7UUPmeb7MQW1ZptdHTk-2c9nMg@mail.gmail.com>
         <584a4fad09048e3ea0dbc3515b2e909b745177dd.camel@linux.intel.com>
         <CAJZ5v0iH3TacxX3gzBS5cah7SnmDWbmHz=WCujQJpmEggGhLhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2021-09-06 at 20:25 +0200, Rafael J. Wysocki wrote:
> On Mon, Sep 6, 2021 at 8:14 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > On Mon, 2021-09-06 at 19:54 +0200, Rafael J. Wysocki wrote:
> > > 
[...]

> > > 
> > We are handling offline for other thermal interrupt sources from
> > same
> > interrupt in therm-throt.c, where we do similar in offline path (by
> > TGLX). If cpufreq offline can cause such issue of changing CPU,
> 
> This is not cpufreq offline, but intel_pstate_update_status() which
> may be triggered via sysfs.  And again, the theoretically problematic
> thing is dereferencing cpudata (which may be cleared by a remote CPU)
> from the interrupt handler without protection.

This will be a problem.

> 
> > I can call intel_pstate_disable_hwp_interrupt() via override from
> > https://elixir.bootlin.com/linux/latest/C/ident/thermal_throttle_offline
> > after masking APIC interrupt.
> 
> But why would using RCU be harder than this?
I think, this will require all_cpu_data and cpu_data to be rcu
protected. This needs to be well tested.

I think better to revert the patch for the next release.

Thanks,
Srinivas

> 
> Also please note that on RT kernels interrupt handlers are run in
> threads.


