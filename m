Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1165445A09
	for <lists+linux-pm@lfdr.de>; Thu,  4 Nov 2021 19:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbhKDSyL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 14:54:11 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:45804 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbhKDSyK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Nov 2021 14:54:10 -0400
Received: by mail-ot1-f46.google.com with SMTP id l7-20020a0568302b0700b0055ae988dcc8so6423819otv.12;
        Thu, 04 Nov 2021 11:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QfXq88iqQoCwEsC+U65lUOBtDnuL5rqv31DWfmQRFAQ=;
        b=m3IVlr6011iucfOjTPSMx244nq3tFU093RvzlHNDg56dzNEJr8KHGqeE/y4qsEoD1R
         Y3/UiIE+95g6U8vbynkG6VcQBNX7wEzFiypSPx7lmF/B61Mq7DPfzjo2h/1bDdgC73AN
         ogxo5hH51Fn+wCN7JCVlB/T0A0VHjwlLkMW0sZd1+sxRkYwymHQxrMl1gAbpJrkk1Lpt
         U9SCluRMpaxqXPwTBk2hKgNCa6vZnhahpc8GGEV8aOGomHYr+1Qe8jXrxCocJ3WHcn+a
         2SzRlt/uPxAXZlj7BVKLX89ZT4EzQ3mzGRjDmIyBCDt8gOnp1loGRzS0XDze0IQWo24I
         DBdA==
X-Gm-Message-State: AOAM533+pvD29iefngTD0aFDyEaz3+het+wDAToRUUb2xfau+QTte1oT
        Q0Rx2Ox/GVttBMhx7FcE2/2sdR/OdxIYre2b5ls=
X-Google-Smtp-Source: ABdhPJxnMfhqPsepZ8zu304lrWgB+y1h040iQ6GbER2FIJGYCXtMLpgs9HVqJLgFeRdK+PRyWwHLAIQxHp/cq8d2P7A=
X-Received: by 2002:a9d:a64:: with SMTP id 91mr33140225otg.198.1636051892077;
 Thu, 04 Nov 2021 11:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211104051925.119941-1-srinivas.pandruvada@linux.intel.com>
 <20211104093019.60c0e157@gandalf.local.home> <a6ed700a76a03eefceca0ce735ab6fd3cab19841.camel@linux.intel.com>
In-Reply-To: <a6ed700a76a03eefceca0ce735ab6fd3cab19841.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Nov 2021 19:51:21 +0100
Message-ID: <CAJZ5v0jxw3xXboL9oC56ZM63DBdRKhUFFzuwbQrgfEp4bLYOFA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix unchecked MSR 0x773 access
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 4, 2021 at 3:17 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Thu, 2021-11-04 at 09:30 -0400, Steven Rostedt wrote:
> > On Wed,  3 Nov 2021 22:19:25 -0700
> > Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> >
> > > It is possible that on some platforms HWP interrupts are disabled.
> > > In
> > > that case accessing MSR 0x773 will result in warning.
> > >
> > > So check X86_FEATURE_HWP_NOTIFY feature to access MSR 0x773. The
> > > other
> > > places in code where this MSR is accessed, already checks this
> > > feature
> > > except during disable path called during cpufreq offline and
> > > suspend
> > > callbacks.
> > >
> > > Fixes: 57577c996d73 ("cpufreq: intel_pstate: Process HWP Guaranteed
> > > change notification")
> > > Reported-by: Steven Rostedt <rostedt@goodmis.org>
> >
> > I added this patch on top of the above commit and I verified that the
> > issue
> > goes away. And just to confirm, I removed the patch, and the issue
> > reappeared.
> >
> > Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >
> Thanks for the test.
> Sorry again for the mess up.
>
> -Srinivas
>
> > -- Steve
> >
> >
> > > Signed-off-by: Srinivas Pandruvada <
> > > srinivas.pandruvada@linux.intel.com>
> > > ---
> > >  drivers/cpufreq/intel_pstate.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > b/drivers/cpufreq/intel_pstate.c
> > > index 349ddbaef796..1e6898dc76b6 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -1620,6 +1620,9 @@ static void
> > > intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
> > >  {
> > >         unsigned long flags;
> > >
> > > +       if (!boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
> > > +               return;
> > > +
> > >         /* wrmsrl_on_cpu has to be outside spinlock as this can
> > > result in IPC */
> > >         wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
> > >

Applied as 5.16-rc material, thanks!
