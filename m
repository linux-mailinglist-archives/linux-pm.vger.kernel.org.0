Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1951E193E86
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 13:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgCZMD0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 08:03:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:26764 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbgCZMDZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Mar 2020 08:03:25 -0400
IronPort-SDR: GlmTAE/R0+1phTpNdWPJyZjfDeErfT9k0JmRuEQDn3wUzWAcheNigLCoSwVaQbmVg3pAAwkHSt
 +SVaTND35Z3A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 05:03:25 -0700
IronPort-SDR: 1ZJ4EORQxCkoT3ZSs5x1mOpeth8srErLVF3TqCGJGWpnCWMMeoDRPepsNMJTyyavBRQQWPc1xE
 raRstNqCwxAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,308,1580803200"; 
   d="scan'208";a="326543337"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 26 Mar 2020 05:03:21 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jHREJ-00D70Q-N2; Thu, 26 Mar 2020 14:03:23 +0200
Date:   Thu, 26 Mar 2020 14:03:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mark Brown <broonie@kernel.org>, Ferry Toth <fntoth@gmail.com>,
        grant.likely@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
Message-ID: <20200326120323.GR1922688@smile.fi.intel.com>
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
 <20200325032901.29551-1-saravanak@google.com>
 <20200325125120.GX1922688@smile.fi.intel.com>
 <CAGETcx_TGw24UqX7pXZePyskrao6zwnKTq8mBk9g_7jokqAqkA@mail.gmail.com>
 <CAJZ5v0jB1hqzYK8ezjf1_1yMCudNXNS-CsrUJQcmL4W5mBD6fQ@mail.gmail.com>
 <ca661616-f5bf-d92f-9173-172792797b16@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca661616-f5bf-d92f-9173-172792797b16@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 26, 2020 at 11:45:18AM +0200, Peter Ujfalusi wrote:
> On 26/03/2020 10.39, Rafael J. Wysocki wrote:
> > On Wed, Mar 25, 2020 at 11:09 PM Saravana Kannan <saravanak@google.com> wrote:
> >> On Wed, Mar 25, 2020 at 5:51 AM Andy Shevchenko
> >> <andriy.shevchenko@linux.intel.com> wrote:

...

> > OK, so the situation right now is that commit 58b116bce136 has
> > introduced a regression and so it needs to be fixed or reverted.  The
> > cases that were previously broken and were unbroken by that commit
> > don't matter here, so you cannot argue that they would be "broken".
> 
> commit 58b116bce136 is from 2014 and the whole ULPI support for dwc3
> came in a year later.
> While I agree that 58b116bce136 fail to handle came a year later, but
> technically it did not introduced a regression.
> 
> The revert on the other hand is going to introduce a regression as
> things were working fine since 2014. Not sure why the dwc3 issue got
> this long to be noticed as the 58b116bce136 was already in kernel when
> the ULPI support was added...

I dare to say that is luck based on people's laziness to figure out the root
cause. As I pointed out in email to Saravana the issue is not limited to USB
case and, if my memory doesn't trick me out, I suffered from it approximately
in ~2014-2015 with pin control tables.

> > It looks to me like the original issue fixed by the commit in question
> > needs to be addressed differently, so I would vote for reverting it
> > and starting over.
> 
> Fwiw my original approach was a bit different:
> https://lore.kernel.org/patchwork/patch/454800/

Can you apply above scenario to your patch and see if it solves the issue?
On the other hand to you possess the hardware you can test the original
scenario with my patch applied?

> Greg changed it to what ended up in the kernel:
> https://lore.kernel.org/patchwork/cover/454799/

-- 
With Best Regards,
Andy Shevchenko


