Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BA244D1BA
	for <lists+linux-pm@lfdr.de>; Thu, 11 Nov 2021 06:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhKKFnn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Nov 2021 00:43:43 -0500
Received: from mga14.intel.com ([192.55.52.115]:20853 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhKKFnm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 11 Nov 2021 00:43:42 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="233099877"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="233099877"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 21:40:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="504287336"
Received: from unknown (HELO localhost) ([10.238.155.175])
  by orsmga008.jf.intel.com with ESMTP; 10 Nov 2021 21:40:52 -0800
Date:   Thu, 11 Nov 2021 12:28:07 +0800
From:   Youquan Song <youquan.song@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Youquan Song <youquan.song@linux.intel.com>,
        linux-pm@vger.kernel.org, youquan.song@intel.com
Subject: Re: [PATCH] PM/QoS: resume latency 0 should be not latency allowed
Message-ID: <20211111042807.GA887@linux-youquan.bj.intel.com>
References: <1635766618-24732-1-git-send-email-youquan.song@intel.com>
 <CAJZ5v0jJ+tthguYtq81EbapZAxLkUkz=B=quDWcMzHQFcWAnrA@mail.gmail.com>
 <BYAPR11MB3205164D85635F784AFA4C429C939@BYAPR11MB3205.namprd11.prod.outlook.com>
 <20211110105833.GA30301@linux-youquan.bj.intel.com>
 <2d01125c-facd-6db6-23d3-b0b1b608c4e8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d01125c-facd-6db6-23d3-b0b1b608c4e8@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 10, 2021 at 08:24:12PM +0100, Rafael J. Wysocki wrote:
> On 11/10/2021 11:58 AM, Youquan Song wrote:
> >>But do you really need to make these changes?  What problem is there with using the interface as currently documented, ie. writing "n/a" to it to get "no latency at all"?
> >I think so. "0" is "latency is not allowed", but "n/a" is "no latency".
> >
> Actually, "0" means "I don't care" and "n/a" means "no latency"
> which means latency tolerance == 0.
So it is not reasonable and need change. "0" is the smallest latency and means "latency not allowed"; if latency_req==0, it will not allow to enter into C-state. "n/a" is largest latency and means "I don't care" the input of latency_req at all. 

