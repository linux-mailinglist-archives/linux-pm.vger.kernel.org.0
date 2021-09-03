Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E82F4007F2
	for <lists+linux-pm@lfdr.de>; Sat,  4 Sep 2021 00:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbhICWjU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 18:39:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:24318 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236815AbhICWjU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Sep 2021 18:39:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="283238780"
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="283238780"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 15:38:19 -0700
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="429832665"
Received: from vanchatg-mobl1.gar.corp.intel.com ([10.213.116.178])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 15:38:17 -0700
Message-ID: <ce0360ab6bdfa8e5dd7f18560570727b500ab1f6.camel@linux.intel.com>
Subject: Re: Bug: d0e936adbd22 crashes at boot
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
Date:   Fri, 03 Sep 2021 15:38:13 -0700
In-Reply-To: <a6041178-e7d6-4ad9-b96a-91b4702d0305@kernel.dk>
References: <942f4041-e4e7-1b08-3301-008ab37ff5b8@kernel.dk>
         <c56cde110210bec6537fe69b495334c6c70c814e.camel@linux.intel.com>
         <3ac87893-55ba-f2d4-bb1e-382868f12d4c@kernel.dk>
         <7f115f0476618d34b24ddec772acbbd7c0c4a572.camel@linux.intel.com>
         <767fe00f-bf31-1eb0-09cc-1be91c633bb4@kernel.dk>
         <d6bf08cbfd9f29ddb8cf29f522d68efc5c676624.camel@linux.intel.com>
         <903f2e71-983f-39b8-dd0b-d697616ab63e@kernel.dk>
         <a6041178-e7d6-4ad9-b96a-91b4702d0305@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2021-09-03 at 14:57 -0600, Jens Axboe wrote:
> On 9/3/21 2:41 PM, Jens Axboe wrote:
> > On 9/3/21 12:00 PM, Srinivas Pandruvada wrote:
> > > Hi Axobe,
> > > 
> > > On Fri, 2021-09-03 at 09:00 -0600, Jens Axboe wrote:
> > > > On 9/3/21 8:38 AM, Srinivas Pandruvada wrote:
> > > > > On Fri, 2021-09-03 at 08:15 -0600, Jens Axboe wrote:
> > > > > > On 9/3/21 8:13 AM, Srinivas Pandruvada wrote:
> > > > > > > Hi Axboe,
> > > > > > > 
> > > > > > > Thanks for reporting.
> > > > > > > On Fri, 2021-09-03 at 07:36 -0600, Jens Axboe wrote:
> > > > > > > > Hi,
> > > > > > > > 
> > > > > > > > Booting Linus's tree causes a crash on my laptop, an x1
> > > > > > > > gen9.
> > > > > > > > This
> > > > > > > > was
> > > > > > > > a bit
> > > > > > > > difficult to pin down as it crashes before the display
> > > > > > > > is up,
> > > > > > > > but I
> > > > > > > > managed
> > > > > > > > to narrow it down to:
> > > > > > > > 
> > > > > > > > commit d0e936adbd2250cb03f2e840c6651d18edc22ace
> > > > > > > > Author: Srinivas Pandruvada < 
> > > > > > > > srinivas.pandruvada@linux.intel.com>
> > > > > > > > Date:   Thu Aug 19 19:40:06 2021 -0700
> > > > > > > > 
> > > > > > > >     cpufreq: intel_pstate: Process HWP Guaranteed
> > > > > > > > change
> > > > > > > > notification
> > > > > > > > 
> > > > > > > > which crashes with a NULL pointer deref in
> > > > > > > > notify_hwp_interrupt() -
> > > > > > > > > 
> > > > > > > > queue_delayed_work_on().
> > > > > > > > 
> > > > > > > > Reverting this change makes the laptop boot fine again.
> > > > > > > > 
> > > > > > > Does this change fixes your issue?
> > > > > > 
> > > > > > I would assume so, as it's crashing on cpudata == NULL :-)
> > > > > > 
> > > > > > But why is it NULL? Happy to test patches, but the below
> > > > > > doesn't
> > > > > > look
> > > > > > like
> > > > > > a real fix and more of a work-around.
> > > > > 
> > > 
> > > Please try the attached.
> > 
> > I'll give it a test spin right now. Please do add a Reported-by
> > tag,
> > though. That's always prudent.
> 
> And you can add Tested-by as well, it works for me.

Thanks. I will add both.

-Srinivas
> 


