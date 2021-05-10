Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F05E37953A
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 19:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhEJRRy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 13:17:54 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:43668 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhEJRRu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 13:17:50 -0400
Received: by mail-ot1-f51.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso14315753ots.10;
        Mon, 10 May 2021 10:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gG7hfB2vVZ7OG+xhLTqWlPKvaFrqE39DwlHQnd7uMKE=;
        b=tgE5OsG7sYGgAIoYMtAXZIc2vxHeYAkmw5NASP8CRKzMotinaQry8VKZFGJEVOonIN
         38lJY6LVyl7fdMDAoRhYYfPzgqL6UPyhEYrrQgLTFPcqbddCM7KLrHRjLgbQz2w/v8Hp
         bPo5NoiLqpdn6ys9ltwiNlsZFGerYLWHIChIqGdGr8Osbna2+Vw/8CLNjb9eLjWWiG+k
         4qR3BVG0AMtU8yjYqSfyTVfJ9HzDKakO5+P9hZi0so7X4X5+fn75NjHGRVUjiIu1OWdY
         ClPviT0H/PB62TwksMZ4ToHyUXc3Uh8/cZlXTmc1V6APAqRq+7pwk+eSsxHIFHaxeSP0
         glvg==
X-Gm-Message-State: AOAM53298k/oICmZhFYQrWIP5c1gceujJf7lGdQBg42PbUCbbwi94B6f
        DUZiW4sZiw44ppozFYhNxECP3RpJMYpDuCbl6YE=
X-Google-Smtp-Source: ABdhPJxXneyvZQMnR5WHtv+KUUyxzk46bu7v4N3/i6X+qg6ArHynkUDqdjc1NCz5e66rCjf4SHPIjzY/tCJRD2elPlw=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr21982201otb.260.1620667004931;
 Mon, 10 May 2021 10:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210505110915.6861-1-tony@atomide.com> <CAPDyKFp36huF2Gu19T+KvUm90xSsd97VDCxst1KT+Qf0F5Vm5g@mail.gmail.com>
In-Reply-To: <CAPDyKFp36huF2Gu19T+KvUm90xSsd97VDCxst1KT+Qf0F5Vm5g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 May 2021 19:16:33 +0200
Message-ID: <CAJZ5v0iGZ+zk2MEzejGFz2sO07ywwZouP1W8O_C7nfiSTbGXuw@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Fix unpaired parent child_count for force_resume
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 7, 2021 at 2:04 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 5 May 2021 at 13:09, Tony Lindgren <tony@atomide.com> wrote:
> >
> > As pm_runtime_need_not_resume() relies also on usage_count, it can return
> > a different value in pm_runtime_force_suspend() compared to when called in
> > pm_runtime_force_resume(). Different return values can happen if anything
> > calls PM runtime functions in between, and causes the parent child_count
> > to increase on every resume.
> >
> > So far I've seen the issue only for omapdrm that does complicated things
> > with PM runtime calls during system suspend for legacy reasons:
> >
> > omap_atomic_commit_tail() for omapdrm.0
> >  dispc_runtime_get()
> >   wakes up 58000000.dss as it's the dispc parent
> >    dispc_runtime_resume()
> >     rpm_resume() increases parent child_count
> >  dispc_runtime_put() won't idle, PM runtime suspend blocked
> > pm_runtime_force_suspend() for 58000000.dss, !pm_runtime_need_not_resume()
> >  __update_runtime_status()
> > system suspended
> > pm_runtime_force_resume() for 58000000.dss, pm_runtime_need_not_resume()
> >  pm_runtime_enable() only called because of pm_runtime_need_not_resume()
> > omap_atomic_commit_tail() for omapdrm.0
> >  dispc_runtime_get()
> >   wakes up 58000000.dss as it's the dispc parent
> >    dispc_runtime_resume()
> >     rpm_resume() increases parent child_count
> >  dispc_runtime_put() won't idle, PM runtime suspend blocked
> > ...
> > rpm_suspend for 58000000.dss but parent child_count is now unbalanced
> >
> > Let's fix the issue by adding a flag for needs_force_resume and use it in
> > pm_runtime_force_resume() instead of pm_runtime_need_not_resume().
>
> Thanks for sharing the details, much appreciated.
>
> >
> > Additionally omapdrm system suspend could be simplified later on to avoid
> > lots of unnecessary PM runtime calls and the complexity it adds. The
> > driver can just use internal functions that are shared between the PM
> > runtime and system suspend related functions.
> >
> > Fixes: 4918e1f87c5f ("PM / runtime: Rework pm_runtime_force_suspend/resume()")
>
> Actually, I think the problem has been there from the beginning
> (unless I am mistaken), when we introduced the functions. So maybe the
> fixes tag isn't entirely correct.

It kind of make sense to point to the last commit that touched this
code and didn't address the issue.

> Although, I certainly think we should tag this for stable kernels.
>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied as 5.13-rc material, thanks!

> > ---
> >  drivers/base/power/runtime.c | 10 +++++++---
> >  include/linux/pm.h           |  1 +
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -1637,6 +1637,7 @@ void pm_runtime_init(struct device *dev)
> >         dev->power.request_pending = false;
> >         dev->power.request = RPM_REQ_NONE;
> >         dev->power.deferred_resume = false;
> > +       dev->power.needs_force_resume = 0;
> >         INIT_WORK(&dev->power.work, pm_runtime_work);
> >
> >         dev->power.timer_expires = 0;
> > @@ -1804,10 +1805,12 @@ int pm_runtime_force_suspend(struct device *dev)
> >          * its parent, but set its status to RPM_SUSPENDED anyway in case this
> >          * function will be called again for it in the meantime.
> >          */
> > -       if (pm_runtime_need_not_resume(dev))
> > +       if (pm_runtime_need_not_resume(dev)) {
> >                 pm_runtime_set_suspended(dev);
> > -       else
> > +       } else {
> >                 __update_runtime_status(dev, RPM_SUSPENDED);
> > +               dev->power.needs_force_resume = 1;
> > +       }
> >
> >         return 0;
> >
> > @@ -1834,7 +1837,7 @@ int pm_runtime_force_resume(struct device *dev)
> >         int (*callback)(struct device *);
> >         int ret = 0;
> >
> > -       if (!pm_runtime_status_suspended(dev) || pm_runtime_need_not_resume(dev))
> > +       if (!pm_runtime_status_suspended(dev) || !dev->power.needs_force_resume)
> >                 goto out;
> >
> >         /*
> > @@ -1853,6 +1856,7 @@ int pm_runtime_force_resume(struct device *dev)
> >
> >         pm_runtime_mark_last_busy(dev);
> >  out:
> > +       dev->power.needs_force_resume = 0;
> >         pm_runtime_enable(dev);
> >         return ret;
> >  }
> > diff --git a/include/linux/pm.h b/include/linux/pm.h
> > --- a/include/linux/pm.h
> > +++ b/include/linux/pm.h
> > @@ -602,6 +602,7 @@ struct dev_pm_info {
> >         unsigned int            idle_notification:1;
> >         unsigned int            request_pending:1;
> >         unsigned int            deferred_resume:1;
> > +       unsigned int            needs_force_resume:1;
> >         unsigned int            runtime_auto:1;
> >         bool                    ignore_children:1;
> >         unsigned int            no_callbacks:1;
> > --
> > 2.31.1
