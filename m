Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C49F3194137
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 15:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgCZOXw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 10:23:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:20673 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727869AbgCZOXw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Mar 2020 10:23:52 -0400
IronPort-SDR: V0OKcmgpwP/pm9ybSEtswjlXlaHLMcFnWJ9I/r1d98RDV0rInFcCc8x8pwCSd7tSOVNYBBbVHe
 LJ1LkCADYgdQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 07:23:52 -0700
IronPort-SDR: DimBgg8sUOWeCGBgqUZj9R2clPDodmlm9rZiNKMrLL1pxw1LeFXbUuozHmbhQTCfV3CMJHQYBN
 K49CAPxNv3hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,308,1580803200"; 
   d="scan'208";a="265882920"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 26 Mar 2020 07:23:48 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jHTQE-00D99J-Dv; Thu, 26 Mar 2020 16:23:50 +0200
Date:   Thu, 26 Mar 2020 16:23:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Grant Likely <grant.likely@arm.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mark Brown <broonie@kernel.org>, Ferry Toth <fntoth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
Message-ID: <20200326142350.GW1922688@smile.fi.intel.com>
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
 <20200325032901.29551-1-saravanak@google.com>
 <20200325125120.GX1922688@smile.fi.intel.com>
 <CAGETcx_TGw24UqX7pXZePyskrao6zwnKTq8mBk9g_7jokqAqkA@mail.gmail.com>
 <CAJZ5v0jB1hqzYK8ezjf1_1yMCudNXNS-CsrUJQcmL4W5mBD6fQ@mail.gmail.com>
 <ca661616-f5bf-d92f-9173-172792797b16@ti.com>
 <20200326120323.GR1922688@smile.fi.intel.com>
 <6c04af00-adc8-6be2-b7fd-b4a875524563@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c04af00-adc8-6be2-b7fd-b4a875524563@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 26, 2020 at 01:45:50PM +0000, Grant Likely wrote:
> On 26/03/2020 12:03, Andy Shevchenko wrote:
> > On Thu, Mar 26, 2020 at 11:45:18AM +0200, Peter Ujfalusi wrote:
> > > On 26/03/2020 10.39, Rafael J. Wysocki wrote:
> > > > On Wed, Mar 25, 2020 at 11:09 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > > On Wed, Mar 25, 2020 at 5:51 AM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > ...
> > 
> > > > OK, so the situation right now is that commit 58b116bce136 has
> > > > introduced a regression and so it needs to be fixed or reverted.  The
> > > > cases that were previously broken and were unbroken by that commit
> > > > don't matter here, so you cannot argue that they would be "broken".
> > > 
> > > commit 58b116bce136 is from 2014 and the whole ULPI support for dwc3
> > > came in a year later.
> > > While I agree that 58b116bce136 fail to handle came a year later, but
> > > technically it did not introduced a regression.
> > > 
> > > The revert on the other hand is going to introduce a regression as
> > > things were working fine since 2014. Not sure why the dwc3 issue got
> > > this long to be noticed as the 58b116bce136 was already in kernel when
> > > the ULPI support was added...
> > 
> > I dare to say that is luck based on people's laziness to figure out the root
> > cause. As I pointed out in email to Saravana the issue is not limited to USB
> > case and, if my memory doesn't trick me out, I suffered from it approximately
> > in ~2014-2015 with pin control tables.
> 
> I've not been involved in this for a very long time, but from our past
> conversations and the description that is given here I still feel that this
> problem is a design bug on the dwc3 driver dependencies rather than a
> failure with driver core. dwc3 is doing something rather convoluted and it
> would be worth reevaluating how probe failures are unwound on that
> particular driver stack.

I disagree. Have you chance to look into another example I gave to Saravana?

The unbalanced increment is fragile per se, because you can't guarantee that
it will be no unsynchronization between probed successfully (unrelated!) and
deferred drivers.

-- 
With Best Regards,
Andy Shevchenko


