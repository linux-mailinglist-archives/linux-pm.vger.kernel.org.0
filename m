Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C17D193E73
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 12:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgCZL5d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 07:57:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:4523 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbgCZL5d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Mar 2020 07:57:33 -0400
IronPort-SDR: bYUCKQ4qbd6LGf6gXbnOYnotN5GUAF+WLE/mjPYnKvebd6GxUjY0Xfi/QwKgNwtzzzu36gUha6
 qwcvCeEub/pw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 04:57:32 -0700
IronPort-SDR: l5ysklla5utAkfJSLXF+PFc86rVBXcpUoQpLK4JY4bVk45H6mBBfXALnJFSDCbrpyQ9o7relL5
 A05r9KDZyU3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,308,1580803200"; 
   d="scan'208";a="250760624"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 26 Mar 2020 04:57:28 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jHR8c-00D6tS-PE; Thu, 26 Mar 2020 13:57:30 +0200
Date:   Thu, 26 Mar 2020 13:57:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mark Brown <broonie@kernel.org>, Ferry Toth <fntoth@gmail.com>,
        grant.likely@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
Message-ID: <20200326115730.GQ1922688@smile.fi.intel.com>
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
 <20200325032901.29551-1-saravanak@google.com>
 <20200325125120.GX1922688@smile.fi.intel.com>
 <CAGETcx_TGw24UqX7pXZePyskrao6zwnKTq8mBk9g_7jokqAqkA@mail.gmail.com>
 <CAJZ5v0jB1hqzYK8ezjf1_1yMCudNXNS-CsrUJQcmL4W5mBD6fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jB1hqzYK8ezjf1_1yMCudNXNS-CsrUJQcmL4W5mBD6fQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 26, 2020 at 09:39:40AM +0100, Rafael J. Wysocki wrote:
> On Wed, Mar 25, 2020 at 11:09 PM Saravana Kannan <saravanak@google.com> wrote:
> > On Wed, Mar 25, 2020 at 5:51 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:

> > > Yes, it's (unlikely) possible (*), but it will give one more iteration per such
> > > case. It's definitely better than infinite loop. Do you agree?
> >
> > Sorry I wasn't being clear (I was in a rush). I'm saying this patch
> > can reintroduce the bug where the deferred probe isn't triggered when
> > it should be.
> >
> > Let's take a simple execution flow.
> >
> > probe_okay is at 10.
> >
> > Thread-A
> >   really_probe(Device-A)
> >     local_probe_okay_count = 10
> >     Device-A probe function is running...
> >
> > Thread-B
> >   really_probe(Device-B)
> >     Device-B probes successfully.
> >     probe_okay incremented to 11
> >
> > Thread-C
> >   Device-C (which had bound earlier) is unbound (say module is
> > unloaded or a million other reasons).
> >   probe_okay is decremented to 10.
> >
> > Thread-A continues
> >   Device-A probe function returns -EPROBE_DEFER
> >   driver_deferred_probe_add_trigger() doesn't do anything because
> >     local_probe_okay_count == probe_okay
> >   But Device-A might have deferred probe waiting on Device-B.
> >   Device-A never probes.
> >
> > > *) It means during probe you have _intensive_ removing, of course you may keep
> > > kernel busy with iterations, but it has no practical sense. DoS attacks more
> > > effective in different ways.
> >
> > I wasn't worried about DoS attacks. More of a functional correctness
> > issue what I explained above.
> 
> The code is functionally incorrect as is already AFAICS.
> 
> > Anyway, if your issue and similar issues can be handles in driver core
> > in a clean way without breaking other cases, I don't have any problem
> > with that. Just that, I think the current solution breaks other cases.
> 
> OK, so the situation right now is that commit 58b116bce136 has
> introduced a regression and so it needs to be fixed or reverted.  The
> cases that were previously broken and were unbroken by that commit
> don't matter here, so you cannot argue that they would be "broken".
> 
> It looks to me like the original issue fixed by the commit in question
> needs to be addressed differently, so I would vote for reverting it
> and starting over.

I think Saravana's example is not fully correct as I had responded to his mail.
I would like to hear Grant, but seems he is busy with something and didn't reply.

> > As an alternate solution, assuming "linux,extcon-name" is coming
> > from some firmware, you might want to look into the fw_devlink
> > feature.
> 
> That would be a workaround for a driver core issue, though, wouldn't it?

As I explained to him, this issue is not limited to USB case.

-- 
With Best Regards,
Andy Shevchenko


