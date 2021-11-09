Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFF344AF47
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 15:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbhKIOSX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 09:18:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:15330 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237897AbhKIOSV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Nov 2021 09:18:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="229912488"
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="229912488"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 06:15:35 -0800
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="491668788"
Received: from na1-mobl.gar.corp.intel.com ([10.213.108.242])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 06:15:29 -0800
Message-ID: <94ddfd1177c3f119de2794d9fb659a6578f560c6.camel@linux.intel.com>
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
Date:   Tue, 09 Nov 2021 06:15:25 -0800
In-Reply-To: <5e4d7661-1e91-0c72-ae02-b2c60c2ad95e@arm.com>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
         <20211106013312.26698-7-ricardo.neri-calderon@linux.intel.com>
         <2160a0b8-59ec-03a1-1fd5-a3f98085be07@arm.com>
         <e244e3aa9fc323973d7da8d3ebc3e1fad1fdb731.camel@linux.intel.com>
         <5e4d7661-1e91-0c72-ae02-b2c60c2ad95e@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2021-11-09 at 13:53 +0000, Lukasz Luba wrote:
> Hi Srinivas,
> 
> On 11/9/21 1:23 PM, Srinivas Pandruvada wrote:
> > Hi Lukasz,
> > 
> > On Tue, 2021-11-09 at 12:39 +0000, Lukasz Luba wrote:
> > > Hi Ricardo,
> > > 
> > > 
> > > On 11/6/21 1:33 AM, Ricardo Neri wrote:
> > > > From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > 
> > > > Add a new netlink event to notify change in CPU capabilities in
> > > > terms of
> > > > performance and efficiency.
> > > 
> > > Is this going to be handled by some 'generic' tools? If yes,
> > > maybe
> > > the values for 'performance' might be aligned with capacity
> > > [0,1024] ? Or are they completely not related so the mapping is
> > > simply impossible?
> > > 
> > 
> > That would have been very useful.
> > 
> > The problem is that we may not know the maximum performance as
> > system
> > may be booting with few CPUs (using maxcpus kernel command line)
> > and
> > then user hot adding them. So we may need to rescale when we get a
> > new
> > maximum performance CPU and send to user space.
> > 
> > We can't just use max from HFI table at in instance as it is not
> > necessary that HFI table contains data for all CPUs.
> > 
> > If HFI max performance value of 255 is a scaled value to max
> > performance CPU value in the system, then this conversion would
> > have
> > been easy. But that is not.
> 
> I see. I was asking because I'm working on similar interface and
> just wanted to understand your approach better. In my case we
> would probably simply use 'capacity' scale, or more
> precisely available capacity after subtracting 'thermal pressure'
> value.
> That might confuse a generic tool which listens to these socket
> messages, though. So probably I would have to add a new
> THERMAL_GENL_ATTR_CPU_CAPABILITY_* id
> to handle this different normalized across CPUs scale.
I can add a field capacity_scale. In HFI case it will always be 255. In
your cases it will 1024.


