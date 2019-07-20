Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71D346ED23
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jul 2019 03:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbfGTBZ5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 21:25:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:50321 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728662AbfGTBZ5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jul 2019 21:25:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2019 18:25:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,284,1559545200"; 
   d="scan'208";a="343855155"
Received: from jiajial1-mobl1.ccr.corp.intel.com ([10.255.30.115])
  by orsmga005.jf.intel.com with ESMTP; 19 Jul 2019 18:25:54 -0700
Message-ID: <1563585953.2455.7.camel@intel.com>
Subject: Re: [Fwd: Commit 555c45fe0d0 ("int340X/processor_thermal_device:
 add support for MMIO RAPL") boot failure]
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Kenneth R. Crudup" <kenny@panix.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date:   Sat, 20 Jul 2019 09:25:53 +0800
In-Reply-To: <alpine.DEB.2.21.1907191030130.2853@hp-x360>
References: <alpine.DEB.2.21.1907181955330.2769@hp-x360>
          <1563514893.2433.3.camel@intel.com>
          <alpine.DEB.2.21.1907182308321.2769@hp-x360>
          <CAJZ5v0jYdV3esYfj9Yc2NRkdTFNdDvFnuuOe-rTwFQFhFvRH=g@mail.gmail.com>
          <alpine.DEB.2.21.1907190601580.2769@hp-x360>
         <1563550442.2455.1.camel@intel.com>
         <alpine.DEB.2.21.1907191030130.2853@hp-x360>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 五, 2019-07-19 at 10:31 -0700, Kenneth R. Crudup wrote:
> On Fri, 19 Jul 2019, Zhang Rui wrote:
> 
> > 
> > please try the patch below and confirm if it helps or not.
> > 
> > From: Zhang Rui <rui.zhang@intel.com>
> > Date: Fri, 19 Jul 2019 23:25:14 +0800
> > Subject: [PATCH] powercap: adjust init order
> The patch fixes the boot crash, yes.
> 
Hi, Kenny,

thanks for testing.

Rafael,

can we merge this urgent fix before the merge window closed?

thanks,
rui

> ----
> $ dmesg | fgrep -i rapl
> [    0.816376] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters,
> 655360 ms ovfl timer
> [    0.816383] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> [    0.816387] RAPL PMU: hw unit of domain package 2^-14 Joules
> [    0.816390] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [    0.816394] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> [    1.098943] intel_rapl_common: Found RAPL domain package
> [    1.100438] intel_rapl_common: Found RAPL domain dram
> [    1.911092] intel_rapl_common: Found RAPL domain package
> [    1.912577] intel_rapl_common: Found RAPL domain core
> [    1.913989] intel_rapl_common: Found RAPL domain uncore
> [    1.915343] intel_rapl_common: Found RAPL domain dram
> $
> ----
> 
> 	-Kenny
> 
