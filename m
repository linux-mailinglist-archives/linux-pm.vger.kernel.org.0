Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A887123CC8A
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 18:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgHEQvx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 12:51:53 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54724 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgHEQtr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2020 12:49:47 -0400
Received: from 89-64-88-23.dynamic.chello.pl (89.64.88.23) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 685fe47108670c4b; Wed, 5 Aug 2020 18:49:42 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH] PM: runtime: Add kerneldoc comments to multiple helpers
Date:   Wed, 05 Aug 2020 18:49:41 +0200
Message-ID: <2587608.ek5DdOIzB0@kreacher>
In-Reply-To: <20200805084928.GK13316@paasikivi.fi.intel.com>
References: <2672940.cHDmkauF2A@kreacher> <CAJZ5v0jDpuKYJED90CveWgfYcoA60X5qYY6U6CJmEFd7KDiY-A@mail.gmail.com> <20200805084928.GK13316@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, August 5, 2020 10:49:28 AM CEST Sakari Ailus wrote:
> Hi Rafael,
> 
> On Tue, Aug 04, 2020 at 12:15:03PM +0200, Rafael J. Wysocki wrote:
> > Hi Sakari,
> > 
> > On Tue, Aug 4, 2020 at 1:05 AM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On Mon, Aug 03, 2020 at 01:36:52PM +0200, Rafael J. Wysocki wrote:
> > > > Hi Sakari,
> > > >
> > > > On Mon, Aug 3, 2020 at 10:53 AM Sakari Ailus
> > > > <sakari.ailus@linux.intel.com> wrote:
> > > > >
> > > > > Hi Rafael,
> > > > >
> > > > > Thanks for the patch.
> > > > >
> > > > > On Fri, Jul 31, 2020 at 07:03:26PM +0200, Rafael J. Wysocki wrote:
> > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > >
> > > > > > Add kerneldoc comments to multiple PM-runtime helper functions
> > > > > > defined as static inline wrappers around lower-level routines to
> > > > > > provide quick reference decumentation of their behavior.
> > > > >
> > > > > > Some of them are similar to each other with subtle differences only
> > > > > > and the behavior of some of them may appear as counter-intuitive, so
> > > > > > clarify all that to avoid confusion.
> > > > > >
> > > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > ---
> > > > > >  include/linux/pm_runtime.h |  246 +++++++++++++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 246 insertions(+)
> > > > > >
> > > > > > Index: linux-pm/include/linux/pm_runtime.h
> > > > > > ===================================================================
> > > > > > --- linux-pm.orig/include/linux/pm_runtime.h
> > > > > > +++ linux-pm/include/linux/pm_runtime.h
> > > > > > @@ -60,58 +60,151 @@ extern void pm_runtime_put_suppliers(str
> > > > > >  extern void pm_runtime_new_link(struct device *dev);
> > > > > >  extern void pm_runtime_drop_link(struct device *dev);
> > > > > >
> > > > > > +/**
> > > > > > + * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
> > > > > > + * @dev: Target device.
> > > > > > + *
> > > > > > + * Increment the runtime PM usage counter of @dev if its runtime PM status is
> > > > > > + * %RPM_ACTIVE and its runtime PM usage counter is greater than 0.
> > > > >
> > > > > The implementation of the non-runtime PM variants (used when CONFIG_PM is
> > > > > disabled) isn't here but I think it'd be nice if their behaviour was also
> > > > > documented here. pm_runtime_get_if_in_use() returns -EINVAL if CONFIG_PM is
> > > > > disabled, for instance.
> > > >
> > > > These kerneldoc comments cover the CONFIG_PM case only.  The behavior
> > > > for !CONFIG_PM needs to be figured out from the code, if it matters.
> > > >
> > > > I'm not sure why it would matter for pm_runtime_get_if_in_use(), in particular?
> > >
> > > Just as an example. It depends on the use case, but there have been bugs
> > > related to these (e.g. commit 4d471563d87b2b83e73b8abffb9273950e6d2e36),
> > > likely at least partly because it's extra manual work to figure out what a
> > > given API function could return when it's not documented.
> > 
> > If it is a static inline wrapper around another exported function,
> > whoever uses it should look at the documentation of the function being
> > wrapped anyway, so IMO it is sufficient to document the return values
> > in there and also (as stated in another message) this avoids the need
> > to manually synchronize the kerneldoc comments every time a new return
> > value is added or removed.
> > 
> > In the particular case above it might be useful to change
> > pm_runtime_get_if_active() to return bool, make it return "false" if
> > PM-runtime is disabled for the device and update the callers
> > accordingly (some of them still appear to be doing the wrong thing).
> > 
> > IOW, it would return "true" only if the usage counter has been
> > incremented and so it needs to be decremented.
> 
> In the case of above commit, the driver is interested in knowing whether
> the device is powered on, and so accessible. That's the case if PM is
> disabled, so it should return true. Then we do lose the information whether
> the counter was touched. I guess we should keep it as-is.

Fair enough.



