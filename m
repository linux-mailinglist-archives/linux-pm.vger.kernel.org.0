Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F60E22EBC9
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 14:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgG0MNT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 08:13:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:25624 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgG0MNS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Jul 2020 08:13:18 -0400
IronPort-SDR: P+RGjj4I8Y2s8QpLCHAdOlVb5Pc4XgF0kRaUOjaoh49RagdQEKBrM3p5cegyWVA7w29p/wAwy4
 hXq42LU1ofmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="150177663"
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="150177663"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 05:13:18 -0700
IronPort-SDR: 4rhKyOccZG7f3Osp8B2R1dpFXV82fbIvjIHuUtW5LkSAl+un3SSdjkACSt63iM/ROhSpQgugB6
 u+6HuKtICUMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="321779377"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jul 2020 05:13:16 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1k020K-004Gud-OH; Mon, 27 Jul 2020 15:13:16 +0300
Date:   Mon, 27 Jul 2020 15:13:16 +0300
From:   "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] powercap: Add Power Limit4 support
Message-ID: <20200727121316.GS3703480@smile.fi.intel.com>
References: <1594921495-519-1-git-send-email-sumeet.r.pawnikar@intel.com>
 <CAJZ5v0jQp2sHyzFKZu4ZL2HyN+kVax960+n2epTxBZbbZuZo8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jQp2sHyzFKZu4ZL2HyN+kVax960+n2epTxBZbbZuZo8Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 27, 2020 at 01:46:12PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 16, 2020 at 7:38 PM Sumeet Pawnikar
> <sumeet.r.pawnikar@intel.com> wrote:
> >
> > Modern Intel Mobile platforms support power limit4 (PL4), which is
> > the SoC package level maximum power limit (in Watts). It can be used
> > to preemptively limits potential SoC power to prevent power spikes
> > from tripping the power adapter and battery over-current protection.
> > This patch enables this feature by exposing package level peak power
> > capping control to userspace via RAPL sysfs interface. With this,
> > application like DTPF can modify PL4 power limit, the similar way
> > of other package power limit (PL1).
> > As this feature is not tested on previous generations, here it is
> > enabled only for the platform that has been verified to work,
> > for safety concerns.
> 
> Queued up as 5.9 material ->
> 
> > Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> > Co-developed-by: Zhang Rui <rui.zhang@intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> 
> -> with this tag removed, because the only case in which you can
> include an S-o-b from someone else is when you also add a From:
> pointing to that person.  IOW, you add a From: with a matching S-o-b
> from someone else and you can add your own S-o-b to that.
> 
> In this particular case, the C-d-b tag is sufficient to make a record
> of somebody else's contribution to a patch carrying a From: header
> that points to you (ie. your patch).

Rafael, it looks like it contradicts documentation. I mean your amendment.
SoB is specifically required to be coupled with Co-developed-by. That said,
both or none are acceptable. (I don't consider the chain of SoB when it goes
thru maintainers)

-- 
With Best Regards,
Andy Shevchenko


