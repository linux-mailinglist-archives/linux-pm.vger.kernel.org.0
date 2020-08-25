Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3872251BD4
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 17:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgHYPGV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 11:06:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:13714 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbgHYPGU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Aug 2020 11:06:20 -0400
IronPort-SDR: iITx/wPJ6QZV2Gb4xyNwAZ9Jy0MraUkbBjKX147zCc8Z9D0a1nEkfXKV5mJvFF0MDjBdf45Qv7
 Zas1iSl/5qQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="240945674"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="240945674"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 08:06:09 -0700
IronPort-SDR: w4csY4NHOUXkNsjcdUPtlwbZVJ3CFpVIfG5/fxJvpmlLFYLZX1/TmW4eiBBf9fHeSM9Qz1nkb4
 QvXEkiLrOpUw==
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="299118305"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.25.243])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 08:06:10 -0700
Message-ID: <1341038e00d965e913ee9f0c7a1e739eadef42f7.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/5] cpufreq: intel_pstate: Always return last EPP
 value from sysfs
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Date:   Tue, 25 Aug 2020 08:06:09 -0700
In-Reply-To: <CAJZ5v0hkmcAuCsnfjCSWTarr4pkQry2VCtk2aWM74fOW2guzmg@mail.gmail.com>
References: <4169555.5IIHXK4Dsd@kreacher> <2064342.aRc67yb0pC@kreacher>
         <61ea43fce7dd8700d94f12236a86ffec6f76a898.camel@gmail.com>
         <CAJZ5v0hkmcAuCsnfjCSWTarr4pkQry2VCtk2aWM74fOW2guzmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-08-25 at 16:51 +0200, Rafael J. Wysocki wrote:
> On Tue, Aug 25, 2020 at 8:20 AM Artem Bityutskiy <dedekind1@gmail.com
> > wrote:
> > On Mon, 2020-08-24 at 19:42 +0200, Rafael J. Wysocki wrote:
> > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > 
> > > Make the energy_performance_preference policy attribute in sysfs
> > > always return the last EPP value written to it instead of the one
> > > currently in the HWP Request MSR to avoid possible confusion when
> > > the performance scaling algorithm is used in the active mode with
> > > HWP enabled (in which case the EPP is forced to 0 regardless of
> > > what value it has been set to via sysfs).
> > 
> > Why is this a good idea, I wonder. If there was a prior discussion,
> > please, point to it.
> > 
> > The general approach to changing settings via sysfs is often like
> > this:
> > 
> > 1. Write new value.
> > 2. Read it back and verify that it is the same. Because there is no
> > better way to verify that the kernel "accepted" the value.
> 
> If the write is successful (ie. no errors returned and the value
> returned is equal to the number of written characters), the kernel
> *has* accepted the written value, but it may not have taken effect.
> These are two different things.
> 
> The written value may take an effect immediately or it may take an
> effect later, depending on the current configuration etc.  If you
> don't see the effect of it immediately, it doesn't matter that there
> was a failure of some sort.
> 
> > Let's say I write 'balanced' to energy_performance_preference. I
> > read
> > it back, and it contains 'balanced', so I am happy, I trust the
> > kernel
> > changed EPP to "balanced".
> > 
> > If the kernel, in fact, uses something else, I want to know about
> > it
> > and have my script fail.
> 
> Why do you want it to fail then?
> 
> > Why caching the value and making my script _think_ it succeeded is
> > a good idea.
> 
> Because when you change the scaling algorithm or the driver's
> operation mode, the value you have written will take effect.
> 
> In this particular case it is explained in the driver documentation
> that the performance scaling algorithm in the active mode overrides
> the sysfs value and that's the only case when it can be overridden.
> So whatever you write to this attribute will not take effect
> immediately anyway, but it may take an effect later.

In some cases without even changing active/passive this is happening
when there was some error previously. For example:

#cat energy_performance_preference 
127
[root@otcpl-perf-test-skx-i9 cpufreq]# rdmsr -p 1 0x774
8000ff00

I think we should show reality. In mode change can be a special case
and use the stored value to restore in new mode.

Thanks,
Srinivas

> > In other words, in my usage scenarios at list, I prefer kernel
> > telling
> > the true EPP value, not some "cached, but not used" value.
> 
> An alternative is to fail writes to energy_performance_preference if
> the driver works in the active mode and the scaling algorithm for the
> scaling CPU is performance and *then* to make reads from it return
> the
> value in the register.
> 
> Accepting a write and returning a different value in a subsequent
> read
> is confusing.
> 
> Thanks!

