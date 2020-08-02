Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E972E2359EF
	for <lists+linux-pm@lfdr.de>; Sun,  2 Aug 2020 20:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgHBSjJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Aug 2020 14:39:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:16182 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbgHBSjJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 2 Aug 2020 14:39:09 -0400
IronPort-SDR: oO+tuAyZCU1x0YSqJlp4owO+BLNTPA8CGqkpyZCOkUawgD5b86WiUpjY/nVSDBtCb8B3LdZTql
 sWDHB43YArjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="151982355"
X-IronPort-AV: E=Sophos;i="5.75,427,1589266800"; 
   d="scan'208";a="151982355"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 11:39:09 -0700
IronPort-SDR: sFpbEWvzBHxVBB2Ys77Fjiu1nULfsafNPVgl4o6gwfpRMaQtuDyVTFR3YTTRLzlBeNBMnjqFZV
 CjzkP/JvmVyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,427,1589266800"; 
   d="scan'208";a="291828968"
Received: from fchen82-mobl1.amr.corp.intel.com ([10.213.183.84])
  by orsmga006.jf.intel.com with ESMTP; 02 Aug 2020 11:39:08 -0700
Message-ID: <24a3011a9004bdbd7a37c029f9c2153f3db61476.camel@linux.intel.com>
Subject: Re: [PATCH v4 0/2] cpufreq: intel_pstate: Implement passive mode
 with HWP enabled
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     'Linux Documentation' <linux-doc@vger.kernel.org>,
        'LKML' <linux-kernel@vger.kernel.org>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Giovanni Gherdovich' <ggherdovich@suse.cz>,
        'Francisco Jerez' <francisco.jerez.plata@intel.com>,
        'Linux PM' <linux-pm@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Date:   Sun, 02 Aug 2020 11:39:08 -0700
In-Reply-To: <000301d668d5$45c10a10$d1431e30$@net>
References: <4981405.3kqTVLv5tO@kreacher> <1709487.Bxjb1zNRZM@kreacher>
         <13207937.r2GEYrEf4f@kreacher>
         <6febe0592d1830dac04aab281f66b47498dda887.camel@linux.intel.com>
         <000301d668d5$45c10a10$d1431e30$@net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 2020-08-02 at 07:00 -0700, Doug Smythies wrote:
> On 2020.08.01 09:40 Srinivas Pandruvada wrote:
> > > On Monday, July 27, 2020 5:13:40 PM CEST Rafael J. Wysocki wrote:
> > > > On Thursday, July 16, 2020 7:37:04 PM CEST Rafael J. Wysocki
> > > > wrote:
> > > > > This really is a v2 of this patch:
> > > > > 
> > > > > https://patchwork.kernel.org/patch/11663271/
> > > > > 
> > > > > with an extra preceding cleanup patch to avoid making
> > > > > unrelated
> > > > > changes in the
> > > > > [2/2].
> > I applied this series along with
> > [PATCH] cpufreq: intel_pstate: Fix EPP setting via sysfs in active
> > mode
> > on 5.8 latest master (On top of raw epp patchset).
> 
> Hi Srinivas,
Hi Doug,

> 
> Would you be kind enough to provide a "git log --oneline" output
> of what you did.

69dd9b2b11cd (HEAD -> 5-9-devel) cpufreq: intel_pstate: Implement
passive mode with HWP enabled
63efaa01b06a cpufreq: intel_pstate: Fix EPP setting via sysfs in active
mode
e11e0a2edf83 cpufreq: intel_pstate: Rearrange the storing of new EPP
values
93c3fd6a315c cpufreq: intel_pstate: Avoid enabling HWP if EPP is not
supported
7cef1dd371c3 cpufreq: intel_pstate: Clean up aperf_mperf_shift
description
a3248d8d3a11 cpufreq: intel_pstate: Supply struct attribute description
for get_aperf_mperf_shift()
f52b6b075b07 cpufreq: intel_pstate: Fix static checker warning for epp
variable
4a59d6be0774 cpufreq: intel_pstate: Allow raw energy performance
preference value
7b34b5acdcc6 cpufreq: intel_pstate: Allow enable/disable energy
efficiency
ac3a0c847296 (origin/master, origin/HEAD, master) Merge
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Thanks,
Srinivas

> 
> I have been trying unsuccessfully to apply the patches,
> so somewhere I obviously missed something.
> 
> > When intel_pstate=passive from kernel command line then it is fine,
> > no
> > crash. But switch dynamically, crashed:
> 
> I'll try to repeat, if I can get an actual kernel.
> 
> > Attached crash.txt. I may need to try your linux-pm tree.
> 
> I also tried the linux-pm tree, same.
> ... Doug
> 
> 

