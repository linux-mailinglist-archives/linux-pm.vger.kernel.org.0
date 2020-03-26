Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5921942F8
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 16:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgCZPX5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 11:23:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:27469 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgCZPX4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Mar 2020 11:23:56 -0400
IronPort-SDR: wESR1uUzQMnz/KMlbY3eqI5kgSPl3Ozj/+8dqfmi9LZ3hQhKgymjnT6GVBLusXpkz79F1afiOn
 Ij0mVxbn5ypA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 08:23:55 -0700
IronPort-SDR: 6j3p0+Fsu9leMINZowswJ1kfdsHH1PPS66qaFwqwpC/2bIqz06C60cEFJM9nJKfOFAQBzVcygt
 CASXhmb7g9Dg==
X-IronPort-AV: E=Sophos;i="5.72,308,1580803200"; 
   d="scan'208";a="447044921"
Received: from dvnguye5-mobl3.amr.corp.intel.com ([10.212.244.78])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 08:23:55 -0700
Message-ID: <7b6491f6dcef0886bf482440ce6fc5eec79dc6ff.camel@linux.intel.com>
Subject: Re: Why do I sometimes "lose" the "psys" RAPL counter?
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Date:   Thu, 26 Mar 2020 08:23:54 -0700
In-Reply-To: <CAJZ5v0iWVhQtTn2tFVXA5mHgzgmK+dGm=GC0=fiqJknP+We6KA@mail.gmail.com>
References: <alpine.DEB.2.21.2003252212220.2971@xps-7390>
         <alpine.DEB.2.21.2003252229520.2971@xps-7390>
         <CAJZ5v0iWVhQtTn2tFVXA5mHgzgmK+dGm=GC0=fiqJknP+We6KA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2020-03-26 at 09:13 +0100, Rafael J. Wysocki wrote:
> +Srinivas
> 
> On Thu, Mar 26, 2020 at 6:46 AM Kenneth R. Crudup <kenny@panix.com>
> wrote:
> > 
> > (Re-sent, as I think I had the wrong mailing list address before)
> > 
> > I'm running Linus' latest master of today (and have seen this for a
> > while
> > now). I've got an IceLake CPU (i7-1065G7 running on a Dell 7390 2-
> > in-1, but
> > I'm pretty sure I've seen issue this on my HP Spectre 13 with a
> > 9th-gen CPU).
> > 
> > Sometimes when I boot, I get 4 RAPL "fixed counters" and sometimes
> > I only
> > get 3, and it's always the "psys" domain that's missing when it
> > does. See
> > attached output from various dmesg runs (and a snippet below).
When you say counters, where is this missing from:
1. /sys/class/powercap/intel-rapl/intel-rapl:1
2. /sys/bus/event_source/devices/power/events/
3. Both of the above folders

Also what do you see?
rdmsr 0x65c
rdmsr 0x64d

Thanks,
Srinivas


> > 
> > Is this a bug?
> > Do you know what may cause this?
> > 
> > If you need more info to help me help you guys with this (if it's
> > truly an
> > issue), please let me know.
> > 
> > Thanks,
> > 
> >         -Kenny
> > 
> > ----
> > Mar 22 05:02:48 xps-7390 kernel: [    0.756890] RAPL PMU: API unit
> > is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
> > Mar 22 05:02:48 xps-7390 kernel: [    0.756892] RAPL PMU: hw unit
> > of domain pp0-core 2^-14 Joules
> > Mar 22 05:02:48 xps-7390 kernel: [    0.756893] RAPL PMU: hw unit
> > of domain package 2^-14 Joules
> > Mar 22 05:02:48 xps-7390 kernel: [    0.756894] RAPL PMU: hw unit
> > of domain pp1-gpu 2^-14 Joules
> > Mar 22 05:02:48 xps-7390 kernel: [    2.178267] intel_rapl_common:
> > Found RAPL domain package
> > Mar 22 05:02:48 xps-7390 kernel: [    3.056499] intel_rapl_common:
> > Found RAPL domain package
> > Mar 22 05:02:48 xps-7390 kernel: [    3.058417] intel_rapl_common:
> > Found RAPL domain core
> > Mar 22 05:02:48 xps-7390 kernel: [    3.062290] intel_rapl_common:
> > Found RAPL domain uncore
> > Mar 22 05:17:50 xps-7390 kernel: [    1.770794] RAPL PMU: API unit
> > is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
> > Mar 22 05:17:50 xps-7390 kernel: [    1.770799] RAPL PMU: hw unit
> > of domain pp0-core 2^-14 Joules
> > Mar 22 05:17:50 xps-7390 kernel: [    1.770802] RAPL PMU: hw unit
> > of domain package 2^-14 Joules
> > Mar 22 05:17:50 xps-7390 kernel: [    1.770814] RAPL PMU: hw unit
> > of domain pp1-gpu 2^-14 Joules
> > Mar 22 05:17:50 xps-7390 kernel: [    3.176324] intel_rapl_common:
> > Found RAPL domain package
> > Mar 22 05:17:50 xps-7390 kernel: [    4.060045] intel_rapl_common:
> > Found RAPL domain package
> > Mar 22 05:17:50 xps-7390 kernel: [    4.061739] intel_rapl_common:
> > Found RAPL domain core
> > Mar 22 05:17:50 xps-7390 kernel: [    4.063129] intel_rapl_common:
> > Found RAPL domain uncore
> > Mar 22 05:28:05 xps-7390 kernel: [    1.770320] RAPL PMU: API unit
> > is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > Mar 22 05:28:05 xps-7390 kernel: [    1.770326] RAPL PMU: hw unit
> > of domain pp0-core 2^-14 Joules
> > Mar 22 05:28:05 xps-7390 kernel: [    1.770329] RAPL PMU: hw unit
> > of domain package 2^-14 Joules
> > Mar 22 05:28:05 xps-7390 kernel: [    1.770332] RAPL PMU: hw unit
> > of domain pp1-gpu 2^-14 Joules
> > Mar 22 05:28:05 xps-7390 kernel: [    1.770335] RAPL PMU: hw unit
> > of domain psys 2^-14 Joules
> > Mar 22 05:28:05 xps-7390 kernel: [    3.148050] intel_rapl_common:
> > Found RAPL domain package
> > Mar 22 05:28:05 xps-7390 kernel: [    4.043621] intel_rapl_common:
> > Found RAPL domain package
> > Mar 22 05:28:05 xps-7390 kernel: [    4.045295] intel_rapl_common:
> > Found RAPL domain core
> > Mar 22 05:28:05 xps-7390 kernel: [    4.046823] intel_rapl_common:
> > Found RAPL domain uncore
> > Mar 22 05:37:11 xps-7390 kernel: [    1.635660] RAPL PMU: API unit
> > is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > Mar 22 05:37:11 xps-7390 kernel: [    1.635667] RAPL PMU: hw unit
> > of domain pp0-core 2^-14 Joules
> > Mar 22 05:37:11 xps-7390 kernel: [    1.635670] RAPL PMU: hw unit
> > of domain package 2^-14 Joules
> > Mar 22 05:37:11 xps-7390 kernel: [    1.635673] RAPL PMU: hw unit
> > of domain pp1-gpu 2^-14 Joules
> > Mar 22 05:37:11 xps-7390 kernel: [    1.635676] RAPL PMU: hw unit
> > of domain psys 2^-14 Joules
> > Mar 22 05:37:11 xps-7390 kernel: [    3.043397] intel_rapl_common:
> > Found RAPL domain package
> > Mar 22 05:37:11 xps-7390 kernel: [    4.043265] intel_rapl_common:
> > Found RAPL domain package
> > Mar 22 05:37:11 xps-7390 kernel: [    4.045524] intel_rapl_common:
> > Found RAPL domain core
> > Mar 22 05:37:11 xps-7390 kernel: [    4.048153] intel_rapl_common:
> > Found RAPL domain uncore
> > ----
> > 
> > 
> > --
> > Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting,
> > Silicon Valley

