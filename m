Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DF4230E31
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 17:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbgG1Plq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jul 2020 11:41:46 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59548 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731019AbgG1Plp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2020 11:41:45 -0400
Received: from 89-64-88-69.dynamic.chello.pl (89.64.88.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id a18b10c115136856; Tue, 28 Jul 2020 17:41:43 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Implement passive mode with HWP enabled
Date:   Tue, 28 Jul 2020 17:41:42 +0200
Message-ID: <1884886.tmXHBG24oC@kreacher>
In-Reply-To: <87mu3thiz5.fsf@riseup.net>
References: <3955470.QvD6XneCf3@kreacher> <CAJZ5v0g2U+1wD5rUQwJ4_x9sQyvGyGiBiLFs7MA-xdhRBX9zBQ@mail.gmail.com> <87mu3thiz5.fsf@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, July 21, 2020 1:20:14 AM CEST Francisco Jerez wrote:
> 

[cut]

> > If there is a bug, then what exactly is it, from the users' perspective?
> >
> 
> It can be reproduced easily as follows:
> 
> | echo 1 > /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost
> | for p in /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference; do echo performance > $p; done
> 
> Let's make sure that the EPP updates landed on the turbostat output:
> 
> |[..]
> | Core    CPU     Avg_MHz Busy%   Bzy_MHz            HWP_REQ
> | -       -       1       0.05    2396    0x0000000000000000
> | 0       0       1       0.05    2153    0x0000000000002704
> | 0       4       1       0.04    2062    0x0000000000002704
> | 1       1       1       0.02    2938    0x0000000000002704
> | 1       5       2       0.09    2609    0x0000000000002704
> | 2       2       1       0.04    1857    0x0000000000002704
> | 2       6       1       0.05    2561    0x0000000000002704
> | 3       3       0       0.01    1883    0x0000000000002704
> | 3       7       2       0.07    2703    0x0000000000002704
> |[..]
> 
> Now let's do some non-trivial IO activity in order to trigger HWP
> dynamic boost, and watch while random CPUs start losing their EPP
> setting requested via sysfs:
> 
> |[..]
> | Core    CPU     Avg_MHz Busy%   Bzy_MHz            HWP_REQ
> | -       -       16      0.81    2023    0x0000000000000000
> | 0       0       7       0.66    1069    0x0000000080002704
>                                                     ^^
> | 0       4       24      2.19    1116    0x0000000080002704
>                                                     ^^
> | 1       1       18      0.68    2618    0x0000000000002704
> | 1       5       1       0.03    2005    0x0000000000002704
> | 2       2       2       0.07    2512    0x0000000000002704
> | 2       6       33      1.35    2402    0x0000000000002704
> | 3       3       1       0.04    2470    0x0000000000002704
> | 3       7       45      1.42    3185    0x0000000080002704
>                                                     ^^

Actually, that's because intel_pstate_hwp_boost_up() and
intel_pstate_hwp_boost_down() use the hwp_req_cached value
for updating the HWP Request MSR and that is only written to
by intel_pstate_hwp_set() which is only invoked on policy changes,
so the MSR writes from intel_pstate_set_energy_pref_index()
basically get discarded.

So this is a matter of synchronizing intel_pstate_set_policy() with
intel_pstate_set_energy_pref_index() and they both acquire
intel_pstate_limits_lock already, so this shouldn't be too difficult to fix.

Let me cut a patch for that.



