Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27D423B0A9
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 01:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgHCXFm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 19:05:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:62209 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgHCXFl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Aug 2020 19:05:41 -0400
IronPort-SDR: qdg8klklWczlkcLZql8hQLazshlJhTZv9F2m43tUCewf20IUtsx5+7cISPhZPc9ttSPFfuD6bp
 iEzhOKaG2Vtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="140145307"
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800"; 
   d="scan'208";a="140145307"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 16:05:40 -0700
IronPort-SDR: omar6H3guThDhPd7u5yuLJD4/BHZY6Rz4B9iOvx+ricH30FFPP3T50x64nP83nmWM2nnWOVSEO
 4CEfOK7yv48g==
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800"; 
   d="scan'208";a="324348530"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 16:05:38 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 6ED6920878; Tue,  4 Aug 2020 02:05:36 +0300 (EEST)
Date:   Tue, 4 Aug 2020 02:05:36 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH] PM: runtime: Add kerneldoc comments to multiple helpers
Message-ID: <20200803230536.GB13316@paasikivi.fi.intel.com>
References: <2672940.cHDmkauF2A@kreacher>
 <20200803085347.GV13316@paasikivi.fi.intel.com>
 <CAJZ5v0hRi3DZ69b1b=xes4qz2keq_aGDzX5kKQsR_rkwuFgk0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hRi3DZ69b1b=xes4qz2keq_aGDzX5kKQsR_rkwuFgk0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Mon, Aug 03, 2020 at 01:36:52PM +0200, Rafael J. Wysocki wrote:
> Hi Sakari,
> 
> On Mon, Aug 3, 2020 at 10:53 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > Thanks for the patch.
> >
> > On Fri, Jul 31, 2020 at 07:03:26PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Add kerneldoc comments to multiple PM-runtime helper functions
> > > defined as static inline wrappers around lower-level routines to
> > > provide quick reference decumentation of their behavior.
> >
> > > Some of them are similar to each other with subtle differences only
> > > and the behavior of some of them may appear as counter-intuitive, so
> > > clarify all that to avoid confusion.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  include/linux/pm_runtime.h |  246 +++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 246 insertions(+)
> > >
> > > Index: linux-pm/include/linux/pm_runtime.h
> > > ===================================================================
> > > --- linux-pm.orig/include/linux/pm_runtime.h
> > > +++ linux-pm/include/linux/pm_runtime.h
> > > @@ -60,58 +60,151 @@ extern void pm_runtime_put_suppliers(str
> > >  extern void pm_runtime_new_link(struct device *dev);
> > >  extern void pm_runtime_drop_link(struct device *dev);
> > >
> > > +/**
> > > + * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
> > > + * @dev: Target device.
> > > + *
> > > + * Increment the runtime PM usage counter of @dev if its runtime PM status is
> > > + * %RPM_ACTIVE and its runtime PM usage counter is greater than 0.
> >
> > The implementation of the non-runtime PM variants (used when CONFIG_PM is
> > disabled) isn't here but I think it'd be nice if their behaviour was also
> > documented here. pm_runtime_get_if_in_use() returns -EINVAL if CONFIG_PM is
> > disabled, for instance.
> 
> These kerneldoc comments cover the CONFIG_PM case only.  The behavior
> for !CONFIG_PM needs to be figured out from the code, if it matters.
> 
> I'm not sure why it would matter for pm_runtime_get_if_in_use(), in particular?

Just as an example. It depends on the use case, but there have been bugs
related to these (e.g. commit 4d471563d87b2b83e73b8abffb9273950e6d2e36),
likely at least partly because it's extra manual work to figure out what a
given API function could return when it's not documented.

> 
> > pm_runtime_disable() is defined here but the documentation in corresponding
> > pm_runtime_enable() in drivers/base/power/runtime.c is rather terse. It'd
> > be nice to improve that now (or separately).
> 
> Yes, separately.

Thanks!

-- 
Regards,

Sakari Ailus
