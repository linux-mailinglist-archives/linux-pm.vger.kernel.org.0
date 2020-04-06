Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4E0919F2FB
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 11:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgDFJxw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 05:53:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:43096 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgDFJxw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 Apr 2020 05:53:52 -0400
IronPort-SDR: w0e4wFoyPMioJjZrg0tdDfu3tmw9jEE9+uGjpS54iO4BcQfUS0+I2FYHqPu2e5RNQmuDxZSXtK
 n2s9GhAWn1jw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 02:53:47 -0700
IronPort-SDR: pSYiNYwup2Dbn4l6x88zHtU0hG4sV0HcYYC+mcCzl6PpV+ybcezEKC5wLH8DMjahWoALGHKG1t
 0XGmDEM9OAjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,350,1580803200"; 
   d="scan'208";a="254067748"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga006.jf.intel.com with ESMTP; 06 Apr 2020 02:53:41 -0700
Date:   Mon, 6 Apr 2020 17:54:15 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH][v3] PM / sleep: Add pm_debug_messages boot command
 control
Message-ID: <20200406095415.GA21720@chenyu-office.sh.intel.com>
References: <20200402075652.13289-1-yu.c.chen@intel.com>
 <CAJZ5v0j2W5MYJnb4hiDn0OgR1xJZwm4TxVm9o-iw+epXPTp82g@mail.gmail.com>
 <20200406091813.GG31120@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406091813.GG31120@duo.ucw.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Pavel,
thanks for review.
On Mon, Apr 06, 2020 at 11:18:13AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index ed73df5f1369..3fb9cbee8d28 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -3720,6 +3720,9 @@
> > >                         Override pmtimer IOPort with a hex value.
> > >                         e.g. pmtmr=0x508
> > >
> > > +       pm_debug_messages       [SUSPEND,KNL]
> > > +                       Enable suspend/resume debug messages during boot up.
> > > +
> > >         pnp.debug=1     [PNP]
> > >                         Enable PNP debug messages (depends on the
> > >                         CONFIG_PNP_DEBUG_MESSAGES option).  Change at run-time
> 
> > Applied (as 5.7-rc material) with modified subject and changelog,
>   thanks!
> 
> Please don't.
> 
> We have pnp.debug, i8042.debug, acpi.debug_*, lsm.debug... It makes
> sense to do pm.debug... we want to have some consistency.
> 
We also have initcall_debug. It looks like the 'dot' indicates
that it is a module(or driver) parameter, and have multiple options
for user to choose from, but it looks like this is not the case for
pm_debug_messages.

Thanks,
Chenyu
> Thanks,
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


