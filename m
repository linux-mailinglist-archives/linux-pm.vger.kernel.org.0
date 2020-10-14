Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A446628E8DF
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 00:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgJNWpp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 18:45:45 -0400
Received: from outbound-smtp21.blacknight.com ([81.17.249.41]:40042 "EHLO
        outbound-smtp21.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727387AbgJNWpp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2020 18:45:45 -0400
X-Greylist: delayed 518 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2020 18:45:43 EDT
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp21.blacknight.com (Postfix) with ESMTPS id E9A7DCCAA0
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2020 23:37:04 +0100 (IST)
Received: (qmail 31767 invoked from network); 14 Oct 2020 22:37:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Oct 2020 22:37:04 -0000
Date:   Wed, 14 Oct 2020 23:37:03 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: ACPI _CST introduced performance regresions on Haswll
Message-ID: <20201014223703.GT3227@techsingularity.net>
References: <20201006083639.GJ3227@techsingularity.net>
 <c3566d2b-3da1-917b-2df6-f7dcfb33c8ed@intel.com>
 <20201006190322.GL3227@techsingularity.net>
 <25f31d3e-7a67-935f-93ba-32216a5084e2@intel.com>
 <20201006211820.GN3227@techsingularity.net>
 <2382d796-7c2f-665e-9169-5cdc437bf34c@intel.com>
 <20201008090909.GP3227@techsingularity.net>
 <dcf4266a-5769-8a6b-d8e1-e77553126861@intel.com>
 <20201008173436.GQ3227@techsingularity.net>
 <f6b04376-4214-ff5d-1069-890449a923e2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6b04376-4214-ff5d-1069-890449a923e2@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 13, 2020 at 08:55:26PM +0200, Rafael J. Wysocki wrote:
> > > With C6 enabled, that state is used at
> > > least sometimes (so C1E is used less often), but PC6 doesn't seem to be
> > > really used - it looks like core C6 only is entered and which may be why C6
> > > adds less latency than C1E (and analogously for C3).
> > > 
> > At the moment, I'm happy with either solution but mostly because I can't
> > tell what other trade-offs should be considered :/
> > 
>
> I talked to Len and Srinivas about this and my theory above didn't survive.
> 
> The most likely reason why you see a performance drop after enabling the
> ACPI support (which effectively causes C3 and C6 to be disabled by default
> on the affected machines) is because the benchmarks in question require
> sufficiently high one-CPU performance and the CPUs cannot reach high enough
> one-core turbo P-states without the other CPUs going into C6.
> 

That makes sense. It also can explain anomalies like server/clients being
split across NUMA nodes with no other activity can sometimes be better
because of turbo states being more important than memory locality for
some benchmarks.

> Inspection of the ACPI tables you sent me indicates that there is a BIOS
> switch in that system allowing C6 to be enabled.  Would it be possible to
> check whether or not there is a BIOS setup option to change that setting?
> 

Yes, it's well hidden but it's there. If the profile is made custom, then
the p-states can be selected and "custom" default enables C6 but not C3
(there is a note saying that it's not recommended for that CPU). If I
then switch it back to the normal profile, the c-states are not restored
so this is a one-way trip even if you disable the c-state in custom,
reboot, switch back, reboot. Same if the machine is reset to "optimal
default settings". Yey for BIOS developers.

This means I have a limited number of attempts to do something about
this. 2 machines can no longer reproduce the problem reliably.

However, that also says a "solution" is to enable the state on each of
these machines, discard the historical results and carry on. In practice,
if reports are received either upstream or in distros about strange
behaviour on old machines when upgrading then first check the c-states
and the CPU generation. Given long enough, the machines with that specific
CPU and a crappy BIOS will phase out :/

> Also, I need to know what happens if that system is started with intel_idle
> disabled.  That is, what idle states are visible in sysfs in that
> configuration (what their names and descriptions are in particular) and
> whether or not the issue is still present then.
> 

Kernel name		c-state	  exit latency	 disabled?  default?
-----------             ------    ------------   ---------  --------
5.9-vanilla              POLL     latency:0      disabled:0 default:enabled
5.9-vanilla              C1       latency:2      disabled:0 default:enabled
5.9-vanilla              C1E      latency:10     disabled:0 default:enabled
5.9-vanilla              C3       latency:33     disabled:1 default:disabled
5.9-vanilla              C6       latency:133    disabled:0 default:enabled
5.9-intel_idle-disabled  POLL     latency:0      disabled:0 default:enabled
5.9-intel_idle-disabled  C1       latency:1      disabled:0 default:enabled
5.9-intel_idle-disabled  C2       latency:41     disabled:0 default:enabled
5.9-acpi-disable         POLL     latency:0      disabled:0 default:enabled
5.9-acpi-disable         C1       latency:2      disabled:0 default:enabled
5.9-acpi-disable         C1E      latency:10     disabled:0 default:enabled
5.9-acpi-disable         C3       latency:33     disabled:0 default:enabled
5.9-acpi-disable         C6       latency:133    disabled:0 default:enabled
5.9-custom-powerprofile  POLL     latency:0      disabled:0 default:enabled
5.9-custom-powerprofile  C1       latency:2      disabled:0 default:enabled
5.9-custom-powerprofile  C1E      latency:10     disabled:0 default:enabled
5.9-custom-powerprofile  C3       latency:33     disabled:1 default:disabled
5.9-custom-powerprofile  C6       latency:133    disabled:0 default:enabled

In this case, the test results are similar. I vaguely recall the bios
was reconfigured on the second machine for unrelated reasons and it's no
longer able to reproduce the problem properly. As the results show little
difference in this case, I didn't include the turbostat figures. The
summary from mmtests showed this

                      5.9         5.9         5.9         5.9
                  vanillaintel_idle-disabledacpi-disablecustom-powerprofile
Hmean Avg_MHz        8.31        8.29        8.35        8.26
Hmean Busy%          0.58        0.56        0.58        0.57
Hmean CPU%c1         3.19       40.81        3.14        3.18
Hmean CPU%c3         0.00        0.00        0.00        0.00
Hmean CPU%c6        92.24        0.00       92.21       92.20
Hmean CPU%c7         0.00        0.00        0.00        0.00
Hmean PkgWatt       47.98        0.00       47.95       47.68

i.e. The average time on c6 was high on the vanilla kernel where as it
would not have been when the problem was originally reproduced (I
clearly broke this test machine in a way I can't "fix"). Disabling
intel_idle kept it mostly in C1 state.

I'll try a third machine tomorrow but even if I reproduce the problem,
I won't be able to do it again because ... yey bios developers.

-- 
Mel Gorman
SUSE Labs
