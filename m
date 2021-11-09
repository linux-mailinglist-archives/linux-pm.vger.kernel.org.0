Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C31C44B49E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 22:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239527AbhKIV2s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 16:28:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:52883 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236380AbhKIV2s (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Nov 2021 16:28:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="212575271"
X-IronPort-AV: E=Sophos;i="5.87,221,1631602800"; 
   d="scan'208";a="212575271"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 13:25:52 -0800
X-IronPort-AV: E=Sophos;i="5.87,221,1631602800"; 
   d="scan'208";a="503677118"
Received: from siddaraj-mobl1.gar.corp.intel.com ([10.213.89.120])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 13:25:46 -0800
Message-ID: <9213e3f8fbe53329aacff1152ca3e20b6cffbbdb.camel@linux.intel.com>
Subject: Re: [PATCH 6/7] thermal: netlink: Add a new event to notify CPU
 capabilities change
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 09 Nov 2021 13:25:42 -0800
In-Reply-To: <a2389c0f-c42d-0198-a625-0eb2a97628f0@arm.com>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
         <20211106013312.26698-7-ricardo.neri-calderon@linux.intel.com>
         <2160a0b8-59ec-03a1-1fd5-a3f98085be07@arm.com>
         <e244e3aa9fc323973d7da8d3ebc3e1fad1fdb731.camel@linux.intel.com>
         <5e4d7661-1e91-0c72-ae02-b2c60c2ad95e@arm.com>
         <94ddfd1177c3f119de2794d9fb659a6578f560c6.camel@linux.intel.com>
         <a2389c0f-c42d-0198-a625-0eb2a97628f0@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2021-11-09 at 17:51 +0000, Lukasz Luba wrote:
> 
> 
> On 11/9/21 2:15 PM, Srinivas Pandruvada wrote:
> > On Tue, 2021-11-09 at 13:53 +0000, Lukasz Luba wrote:
> > > Hi Srinivas,
> > > 
> > > On 11/9/21 1:23 PM, Srinivas Pandruvada wrote:
> > > > Hi Lukasz,
> > > > 
> > > > On Tue, 2021-11-09 at 12:39 +0000, Lukasz Luba wrote:
> > > > > Hi Ricardo,
> > > > > 
> > > > > 
> > > > > On 11/6/21 1:33 AM, Ricardo Neri wrote:
> > > > > > From: Srinivas Pandruvada < 
> > > > > > srinivas.pandruvada@linux.intel.com>
> > > > > > 
> > > > > > Add a new netlink event to notify change in CPU capabilities
> > > > > > in
> > > > > > terms of
> > > > > > performance and efficiency.
> > > > > 
> > > > > Is this going to be handled by some 'generic' tools? If yes,
> > > > > maybe
> > > > > the values for 'performance' might be aligned with capacity
> > > > > [0,1024] ? Or are they completely not related so the mapping is
> > > > > simply impossible?
> > > > > 
> > > > 
> > > > That would have been very useful.
> > > > 
> > > > The problem is that we may not know the maximum performance as
> > > > system
> > > > may be booting with few CPUs (using maxcpus kernel command line)
> > > > and
> > > > then user hot adding them. So we may need to rescale when we get
> > > > a
> > > > new
> > > > maximum performance CPU and send to user space.
> > > > 
> > > > We can't just use max from HFI table at in instance as it is not
> > > > necessary that HFI table contains data for all CPUs.
> > > > 
> > > > If HFI max performance value of 255 is a scaled value to max
> > > > performance CPU value in the system, then this conversion would
> > > > have
> > > > been easy. But that is not.
> > > 
> > > I see. I was asking because I'm working on similar interface and
> > > just wanted to understand your approach better. In my case we
> > > would probably simply use 'capacity' scale, or more
> > > precisely available capacity after subtracting 'thermal pressure'
> > > value.
> > > That might confuse a generic tool which listens to these socket
> > > messages, though. So probably I would have to add a new
> > > THERMAL_GENL_ATTR_CPU_CAPABILITY_* id
> > > to handle this different normalized across CPUs scale.
> > I can add a field capacity_scale. In HFI case it will always be 255.
> > In
> > your cases it will 1024.
> > 
> > 
> 
> Sounds good, with that upper limit those tools would not build
> up assumptions (they would have to parse that scale value).
> Although, I would prefer to call it 'performance_scale' if you don't
> mind.
Sure.

Thanks,
Srinivas

> I've done similar renaming  s/capacity/performance/ in the Energy Model
> (EM) some time ago [1]. Some reasons:
> - in the scheduler we have 'Performance Domains (PDs)'
> - for GPUs we talk about 'performance', because 'capacity' sounds odd
>    in that case
> 
> [1] 
> https://lore.kernel.org/linux-pm/20200527095854.21714-2-lukasz.luba@arm.com/


