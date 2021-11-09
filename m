Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C999744AFF0
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 16:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhKIPDm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 10:03:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:26047 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234372AbhKIPDl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Nov 2021 10:03:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="232701154"
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="232701154"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 07:00:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="564028871"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga004.fm.intel.com with ESMTP; 09 Nov 2021 07:00:48 -0800
Date:   Tue, 9 Nov 2021 07:00:01 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] thermal: intel: hfi: Enable notification interrupt
Message-ID: <20211109150001.GA20404@ranerica-svr.sc.intel.com>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
 <20211106013312.26698-6-ricardo.neri-calderon@linux.intel.com>
 <YYjnUM/v8LmtnBq3@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYjnUM/v8LmtnBq3@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 08, 2021 at 10:01:04AM +0100, Peter Zijlstra wrote:
> On Fri, Nov 05, 2021 at 06:33:10PM -0700, Ricardo Neri wrote:
> > +	/*
> > +	 * On most systems, all CPUs in the package receive a package-level
> > +	 * thermal interrupt when there is an HFI update. Since they all are
> > +	 * dealing with the same update (as indicated by the update timestamp),
> > +	 * it is sufficient to let a single CPU to acknowledge the update and
> > +	 * schedule work to process it.
> > +	 */
> 
> That's pretty crap hardware behaviour. Is there really no way to steer
> these interrupts?

The HFI is a package-level thermal interrupt. Hence, all CPUs get it.
AFAIK there is no way to steer the interrupts.

Thanks and BR,
Ricardo
