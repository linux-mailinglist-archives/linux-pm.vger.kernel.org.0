Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE35191548
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 16:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgCXPrC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 11:47:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:21508 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727678AbgCXPrC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Mar 2020 11:47:02 -0400
IronPort-SDR: uiF6sACUtv361W6mPKjOmHze75lhDg10tJTIgAWGEdVcLUF/HiAXnvWRSJx6R3CzgQQTmch0hG
 ZRTNO4yFs5Xg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 08:47:01 -0700
IronPort-SDR: 88Vm/iaJ5JzgBwlVh6o6UXLS1iKGkcgdhPzit2FTxm7emrUtmOdXaHAaWP3eB1mkjEFYw+Edl1
 Ux6vl9GIVuNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; 
   d="scan'208";a="447916586"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 24 Mar 2020 08:46:59 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jGlld-00CZUm-Ob; Tue, 24 Mar 2020 17:47:01 +0200
Date:   Tue, 24 Mar 2020 17:47:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 1/3] driver core: Break infinite loop when deferred
 probe can't be satisfied
Message-ID: <20200324154701.GQ1922688@smile.fi.intel.com>
References: <20200324122023.9649-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0hQ2vRE8QAWfxwN1auQd5bQS_ROd6do1bMt8GtLtRypRQ@mail.gmail.com>
 <20200324133903.GK1922688@smile.fi.intel.com>
 <CAJZ5v0gcLkymFNktG=46rxRc=KUGyztxYXmSZ51UxkKM6POnow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gcLkymFNktG=46rxRc=KUGyztxYXmSZ51UxkKM6POnow@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 24, 2020 at 04:36:56PM +0100, Rafael J. Wysocki wrote:
>  On Tue, Mar 24, 2020 at 2:39 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Mar 24, 2020 at 01:52:00PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Mar 24, 2020 at 1:20 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > > +               atomic_dec(&probe_okay);
> > >
> > > Why is this needed?
> >
> > Under successful probe the following is comprehended. When probe of the driver
> > happens it may be discarded (as in above case) as it was initiated by another
> > driver which got deferred.
> >
> > We also discussed this with Peter [1] during his review.
> >
> > [1]: https://lkml.org/lkml/2020/3/12/347
> 
> OK, but I would add a comment explaining that to the code.
> 
> Also it would be good to explain why probe_okay cannot go below zero
> here in the changelog.

Will do, thank you for review!

-- 
With Best Regards,
Andy Shevchenko


