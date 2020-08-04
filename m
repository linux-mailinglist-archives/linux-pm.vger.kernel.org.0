Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06F423B88A
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 12:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgHDKPT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 06:15:19 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37394 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgHDKPS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 06:15:18 -0400
Received: by mail-oi1-f193.google.com with SMTP id e6so15654873oii.4;
        Tue, 04 Aug 2020 03:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TlW4ISopvrR+l+Ym2y7FKbUesDS2yasiRaYWlrf0lQo=;
        b=aOkDe2VCWGm5GIGCyp35BYYI4+DzainqjMcwkGXL4VtK0V/Q41v6K0q7mAI/M0OZaA
         gV1H4radduP/ENxbFlJ2MpvP1XjElDEpQeMJbeb1HoakCy/juzDDe4Nz5mlKNlz02Zxc
         hN+T35PmJbQz6fdaz/2qCZ4G4fPK8r25bqJacU3zzJoW0fSQshoE/VeQb6WO3l8SHCHz
         HqeYr2JmPMIutAThfF0hdwRB9DO6d/5j/6+AbR71pwdyLJcMEfIR3NuNbRraLsWwJr5W
         o5108UXTck+Zxq9c4lRalDy7m/wmAQA3xoPjz0pESkMI6CWFfFQLTaF1dsv4bHTF/9oE
         zFkA==
X-Gm-Message-State: AOAM533XzwUn0uIWrcZVNbzNFWEUBdr5SvUZYREaD6BygmNdjIb79TYD
        yBZdLt6UGBEsx444nvvNE7AndRPYS8Y3Vbu0bDM=
X-Google-Smtp-Source: ABdhPJygiTwKQH9NvQxcL5SmS5pBlVD8QGUhHavpZMZKYe59AsXCOEESxdWezTsDuZw/oSSepnsUk1Tqza9ILhkrn28=
X-Received: by 2002:aca:110a:: with SMTP id 10mr2657330oir.68.1596536117677;
 Tue, 04 Aug 2020 03:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <2672940.cHDmkauF2A@kreacher> <20200803085347.GV13316@paasikivi.fi.intel.com>
 <CAJZ5v0hRi3DZ69b1b=xes4qz2keq_aGDzX5kKQsR_rkwuFgk0w@mail.gmail.com> <20200803230536.GB13316@paasikivi.fi.intel.com>
In-Reply-To: <20200803230536.GB13316@paasikivi.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Aug 2020 12:15:03 +0200
Message-ID: <CAJZ5v0jDpuKYJED90CveWgfYcoA60X5qYY6U6CJmEFd7KDiY-A@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Add kerneldoc comments to multiple helpers
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sakari,

On Tue, Aug 4, 2020 at 1:05 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Mon, Aug 03, 2020 at 01:36:52PM +0200, Rafael J. Wysocki wrote:
> > Hi Sakari,
> >
> > On Mon, Aug 3, 2020 at 10:53 AM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > Thanks for the patch.
> > >
> > > On Fri, Jul 31, 2020 at 07:03:26PM +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Add kerneldoc comments to multiple PM-runtime helper functions
> > > > defined as static inline wrappers around lower-level routines to
> > > > provide quick reference decumentation of their behavior.
> > >
> > > > Some of them are similar to each other with subtle differences only
> > > > and the behavior of some of them may appear as counter-intuitive, so
> > > > clarify all that to avoid confusion.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  include/linux/pm_runtime.h |  246 +++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 246 insertions(+)
> > > >
> > > > Index: linux-pm/include/linux/pm_runtime.h
> > > > ===================================================================
> > > > --- linux-pm.orig/include/linux/pm_runtime.h
> > > > +++ linux-pm/include/linux/pm_runtime.h
> > > > @@ -60,58 +60,151 @@ extern void pm_runtime_put_suppliers(str
> > > >  extern void pm_runtime_new_link(struct device *dev);
> > > >  extern void pm_runtime_drop_link(struct device *dev);
> > > >
> > > > +/**
> > > > + * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
> > > > + * @dev: Target device.
> > > > + *
> > > > + * Increment the runtime PM usage counter of @dev if its runtime PM status is
> > > > + * %RPM_ACTIVE and its runtime PM usage counter is greater than 0.
> > >
> > > The implementation of the non-runtime PM variants (used when CONFIG_PM is
> > > disabled) isn't here but I think it'd be nice if their behaviour was also
> > > documented here. pm_runtime_get_if_in_use() returns -EINVAL if CONFIG_PM is
> > > disabled, for instance.
> >
> > These kerneldoc comments cover the CONFIG_PM case only.  The behavior
> > for !CONFIG_PM needs to be figured out from the code, if it matters.
> >
> > I'm not sure why it would matter for pm_runtime_get_if_in_use(), in particular?
>
> Just as an example. It depends on the use case, but there have been bugs
> related to these (e.g. commit 4d471563d87b2b83e73b8abffb9273950e6d2e36),
> likely at least partly because it's extra manual work to figure out what a
> given API function could return when it's not documented.

If it is a static inline wrapper around another exported function,
whoever uses it should look at the documentation of the function being
wrapped anyway, so IMO it is sufficient to document the return values
in there and also (as stated in another message) this avoids the need
to manually synchronize the kerneldoc comments every time a new return
value is added or removed.

In the particular case above it might be useful to change
pm_runtime_get_if_active() to return bool, make it return "false" if
PM-runtime is disabled for the device and update the callers
accordingly (some of them still appear to be doing the wrong thing).

IOW, it would return "true" only if the usage counter has been
incremented and so it needs to be decremented.

Cheers!
