Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE20235A36
	for <lists+linux-pm@lfdr.de>; Sun,  2 Aug 2020 21:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgHBTUv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Aug 2020 15:20:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:16746 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbgHBTUv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 2 Aug 2020 15:20:51 -0400
IronPort-SDR: l/C9dA4VmAO4SUFNJLk3JVZDA+6kw7BVZqpQi7JfgZCOmgd2x0tibUXqGanCmC3on7ziAzqYMq
 cpbLR8BtlTsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="151220768"
X-IronPort-AV: E=Sophos;i="5.75,427,1589266800"; 
   d="scan'208";a="151220768"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 12:20:51 -0700
IronPort-SDR: lUYFcHpjSwwOrsYxYKOHDQhgXYucFeivizTeZssL6+m3tiVYYubGDUcL/eP+qWdPsbEIG6xkaR
 VKeSe/nJEZ9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,427,1589266800"; 
   d="scan'208";a="491592693"
Received: from fchen82-mobl1.amr.corp.intel.com ([10.213.183.84])
  by fmsmga006.fm.intel.com with ESMTP; 02 Aug 2020 12:20:50 -0700
Message-ID: <ca5c830bdba3c27ca7c2a735b9cbfc09a929091b.camel@linux.intel.com>
Subject: Re: [PATCH v4 2/2] cpufreq: intel_pstate: Implement passive mode
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
Date:   Sun, 02 Aug 2020 12:20:50 -0700
In-Reply-To: <000401d668d7$426d8760$c7489620$@net>
References: <4981405.3kqTVLv5tO@kreacher> <1709487.Bxjb1zNRZM@kreacher>
         <13207937.r2GEYrEf4f@kreacher> <4684795.LlGW2geaUc@kreacher>
         <0fad4951dbd0143b43d4ec7b0dcab6787e0c7a97.camel@linux.intel.com>
         <000401d668d7$426d8760$c7489620$@net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 2020-08-02 at 07:14 -0700, Doug Smythies wrote:
> On 2020.08.01 16:41 Srinivas Pandruvada wrote:
> > On Tue, 2020-07-28 at 17:13 +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > Allow intel_pstate to work in the passive mode with HWP enabled
> > > and
> > > make it set the HWP minimum performance limit (HWP floor) to the
> > > P-state value given by the target frequency supplied by the
> > > cpufreq
> > > governor, so as to prevent the HWP algorithm and the CPU
> > > scheduler
> > > from working against each other, at least when the schedutil
> > > governor
> > > is in use, and update the intel_pstate documentation accordingly.
> > > 
> > > Among other things, this allows utilization clamps to be taken
> > > into account, at least to a certain extent, when intel_pstate is
> > > in use and makes it more likely that sufficient capacity for
> > > deadline tasks will be provided.
> > > 
> > > After this change, the resulting behavior of an HWP system with
> > > intel_pstate in the passive mode should be close to the behavior
> > > of the analogous non-HWP system with intel_pstate in the passive
> > > mode, except that in the frequency range below the base frequency
> > > (ie. the frequency retured by the base_frequency cpufreq
> > > attribute
> > > in sysfs on HWP systems) the HWP algorithm is allowed to go above
> > > the floor P-state set by intel_pstate with or without hardware
> > > coordination of P-states among CPUs in the same package.
> > > 
> > Do you mean HWP.req.min will be below base_freq (unless user
> > overrides
> > it)?
> 
> No.
Correct. I was just thinking about base_freq relation.
I can set floor above or below base_freq, HWP will reach upto ceiling/
max.

For example:

Floor above base of 0x0d

Busy%	Bzy_MHz	TSC_MHz	            M0X774
51.33	3500	1498	0x0000000000000000
99.70	3500	1498	0x00000
0008000270e
2.74	3500	1498	0x000000008000270e
2.92	3500	1498	
0x000000008000270e
99.77	3500	1498	0x000000008000270e
99.78	3500	
1498	0x000000008000270e
2.98	3500	1498	0x000000008000270e
99.75
	3500	1498	0x000000008000270e
3.01	3500	1498	0x00000
0008000270e

Floor Below base of 0x0d

Busy%	Bzy_MHz	TSC_MHz	            M0X774
51.33	3500	1498	0x0000000000000000
3.08	3500	1498	0x000000008000270c
99.77	3500	1498	0x000000008000270c
2.87	3500	1498	0x000000008000270c
99.75	3500	1498	0x000000008000270c
2.81	3500	1498	0x000000008000270c
99.76	3500	1498	0x000000008000270c
99.78	3500	1498	0x000000008000270c
2.82	3500	1498	0x000000008000270c


Thanks,
Srinivas

> > With busy workload I see HWP req.min = HWP req.max.
> > The base freq: 1.3GHz (ratio 0x0d), MAX 1C turbo: 3.9GHz (ratio:
> > 0x27)
> > When I monitor MSR 0x774 (HWP_REQ), I see
> > 0x80002727
> 
> Yes, that is what I expect to see.
> 
> > Normally msr 0x774
> > 0x80002704
> 
> That would be "active" mode and the powersave governor, correct?.
> And yes that is what I expect for your processor.
> For mine, load or no load, decoded:
> 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
>     raw: 80002E08 : 80002E08 : 80002E08 : 80002E08 : 80002E08 :
> 80002E08 :
>     min:        8 :        8 :        8 :        8 :        8
> :        8 :
>     max:       46 :       46 :       46 :       46 :       46
> :       46 :
>     des:        0 :        0 :        0 :        0 :        0
> :        0 :
>     epp:      128 :      128 :      128 :      128 :      128
> :      128 :
>     act:        0 :        0 :        0 :        0 :        0
> :        0 :
> 
> This thread is about passive mode, and myself, I do not expect the
> last byte to be
> 4 (8 for mine) under load.
> 
> ... Doug
> 
> 

