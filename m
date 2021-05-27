Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B216392F0A
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 15:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbhE0NG5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 09:06:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:18022 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236306AbhE0NG4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 May 2021 09:06:56 -0400
IronPort-SDR: mw/BX1tdDjYHYjSXj864qN9MhQEWzPaNeQhlRnBKgmxMjjzRJEwjHZ2JbWXn7IC7sC+LJtqco6
 WRULaHxnRaxQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="190097996"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="190097996"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 06:05:22 -0700
IronPort-SDR: +faRF/ZGJz2QiCoyGPXm3UW/Fv/IXpLvFWvQ7y0UbDH6bjXqVpHJq1fOT2wCDxsm6iHXDVfHpO
 k/TfBLzNU4NQ==
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="477476407"
Received: from tirizk-mobl.amr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.170.232])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 06:05:19 -0700
Date:   Thu, 27 May 2021 21:05:14 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] intel_idle: Adjust the SKX C6 latency and residency if
 PC6 is disabled
Message-ID: <20210527130514.GA13361@chenyu5-mobl1>
References: <20210527045647.3599-1-yu.c.chen@intel.com>
 <f5975692426cb27efd5779e7987a7def2a08728d.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5975692426cb27efd5779e7987a7def2a08728d.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 27, 2021 at 11:25:18AM +0300, Artem Bityutskiy wrote:
> On Thu, 2021-05-27 at 12:56 +0800, Chen Yu wrote:
> 
> ... snip ...
> 
> > Exit latency:
> > The C6 exit latency is measured when woken up from CC6/PC6. In the past,
> > if PC6 is disabled, CPU would be demoted to CC6/PC3, which is close to
> > the latency from CC6/PC6 and there is no need to update the C6 exit latency.
> > However on newer platform there is no CC3/PC3 anymore, then the C6 exit
> > latency with PC6 disabled should be CC6/PC0.
> > 
> > Target residency:
> > With PC6 disabled and C3/PC3 supported, the OS requests C3 if idle
> > duration is within [CC6, PC6) target_residency. On new CPU generations
> > with C3/PC3 deprecated, the OS would request C1E. This would cause
> > low energy-efficiency. In summary, the question is, should we lower
> > the bar to request C6 when PC6 is disabled? The answer is yes.
> ... snip ...
> 
> Hi Yu,
>
Hi Artem, 
> Thanks for this patch, it is very actual and helpful.
> 
> Comments about the commit message below.
> 
> This patch is specifically about SKX. It also covers CLX and CPX,
> because they have the same ID.
> 
> Now, this platforms do not have C3 and PC3. So I would avoid talking
> about these states
> in the commit message. Why making a simple thing more complex?
> 
I agree, in theory this issue is irrelevant of the C3/PC3, however I was
thinking the issue would become more significant to user on platform without
C3/PC3, and this increase the necessity of this patch. But let me
refine the commit log to only mention C3 a little just for future reference.
> Here are all the SKX C-states.
> 
> 1. Linux-level C-states (linux can ask for): C1, C1E, C6.
> 2. HW-level C-states (HW supports under the hood): C1, C1E, CC6, PC2,
> PC6.
> 
And PC0?
> Here is the story of this patch in my understanding.
> 
> 1. C6 maps to CC6 and PC6.
> 2. CC6 is "shallower" than PC6.
> 3. Linux assumes worst case - PC6.
> 4. Many datacenters and users disable PC6.
> 5. We can optimize intel_idle in this case: adjust C6 latency and
> target residency to match (faster) CC6.
> 
> That's it.
> 
Okay.
> Then may be it is worth mentioning that CC6 vs PC2 difference is not
> really measurable, so
> the adjustment is only for PC6.
> 
Okay.

thanks,
Chenyu
> Artem.
> 
