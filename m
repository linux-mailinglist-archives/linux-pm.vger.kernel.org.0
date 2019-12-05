Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAE0114378
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 16:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfLEPYk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 10:24:40 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37978 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfLEPYk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 10:24:40 -0500
Received: by mail-ua1-f66.google.com with SMTP id z17so1448823uac.5
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2019 07:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q2FMWNFt1zt70/iXYITjo1zth7yHens6Q8x9GtKkI7U=;
        b=BPLCZYCiL3bwts6S4smiewIRilsp2BOsKBmLJc8pz5wrfBZ2a3EOtkPCjLm5/k++6+
         ibzo8W26z8mM9JgfksD4FcsR3sFhZI5NKnoc+GKN3lCWR3rXCgJMn0Wc61We+qxYP/7k
         PcNzrAxOHFlrhnMEcljiJZjT/3Koy7l9dQ9z4DnLol8A1Lgc8N1iZMj2DHxMTCaqfLYF
         rhkqD/CsHa3/oUJ8EqIcKSCMpnlehsmiPIKkBHzfGcMlgI3TBxUhKJ8dFWLYoK0CG156
         Q5LTDt1LEm8OeC9qxldiQsJwLMURKqETJAaATzaniMbQvV+XfowKXxnEyQMkiTH2IoVV
         pYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q2FMWNFt1zt70/iXYITjo1zth7yHens6Q8x9GtKkI7U=;
        b=a7xRW+Q/r1UH7p67EMrLZosCb54Do2dMpTj9HIDyckZMXGB3ey424Rnu/W9XVuNeac
         dfBX58/g1wPlv52G9cBG42JXJoYJ6tNpsZ/FSbJuMjkh/B7vieN0U91eySTgX/vFvkfz
         NVx7g7t7rvCruiUQOH3OPITINEv0VZm3CDL0Na04nygAU01ZdAl8GNkjWBd0hrmJAWhD
         OwY+ghas2JazkHj7+YYO6VIJJwmGDX+n1UdBE+4W9UAFSyNUN2oB1AKx604zChJ37+fs
         xe4O/9j4XxhUgitYb7Nvsz7iCN6Blsq3B69aefVfKTazh1auDUc18ihyMm37OPRnl23N
         8F0A==
X-Gm-Message-State: APjAAAXbSB2K6UA7WPyxdJzoYThBRSIK4X8PX8ltS69lnzdz7nVQQyCu
        o6ijbqjWp/RBzGaR4CqI2o0OLpUw3mmLVLA1CSpKptXagcU=
X-Google-Smtp-Source: APXvYqzM3iLhOfE5wLyMayZyiGOnOx969gmlHmwBQmhxfp3xBcLHf4zaSc0MqMupvKiC/ibckJrJOfoQxIuft1deLE4=
X-Received: by 2002:ab0:5510:: with SMTP id t16mr4362385uaa.15.1575559479138;
 Thu, 05 Dec 2019 07:24:39 -0800 (PST)
MIME-Version: 1.0
References: <20191205115150.18836-1-rui.zhang@intel.com> <CAPDyKFqFswOjqNn0s7Y3BAeYuVr+z2NrX3fbn+yu+O1vgWb8tA@mail.gmail.com>
 <d00ea4a1636cd0cfb8c672ef0edc260e7a4759c3.camel@intel.com>
In-Reply-To: <d00ea4a1636cd0cfb8c672ef0edc260e7a4759c3.camel@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Dec 2019 16:24:03 +0100
Message-ID: <CAPDyKFq1P3RX+KDbfoF_NehHO8WWuQpdDd_orgu6PSWsnr8eRw@mail.gmail.com>
Subject: Re: [PATCH] thermal: Add Daniel Lezcano as the thermal maintainer
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 5 Dec 2019 at 13:19, Zhang Rui <rui.zhang@intel.com> wrote:
>
> On Thu, 2019-12-05 at 13:03 +0100, Ulf Hansson wrote:
> > On Thu, 5 Dec 2019 at 12:52, Zhang Rui <rui.zhang@intel.com> wrote:
> > >
> > > Add Daniel Lezcano as the co-maintainer of thermal subsystem.
> > >
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > >  MAINTAINERS | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index c8abdb50af79..0efadb61fe8b 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -16287,7 +16287,7 @@ F:      drivers/media/radio/radio-
> > > raremono.c
> > >
> > >  THERMAL
> > >  M:     Zhang Rui <rui.zhang@intel.com>
> > > -R:     Daniel Lezcano <daniel.lezcano@linaro.org>
> > > +M:     Daniel Lezcano <daniel.lezcano@linaro.org>
> > >  R:     Amit Kucheria <amit.kucheria@verdurent.com>
> > >  L:     linux-pm@vger.kernel.org
> > >  T:     git
> > > git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
> >
> > Great!
> >
> > Did you guys also agree on how to work with the git tree? There is
> > one
> > common git, maintained by Rui?
>
> we have a shared tree where both Daniel and I are maintaining.
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/

Cool, that definitely makes it easier for contributors!

>
> thermal/linux-next branch contains all the upstream candidate, and it
> is included in linux-next for testing.
> Daniel and I will cherry-pick the patches from thermal/linux-next to
> thermal/fixes or thermal/next branch, where thermal/fixes are materials
> for next -rc and thermal/next are materials for next merge window.

You may also ask Stephen to include your fixes branch into linux-next,
as that is being built separately in his pending-fixes branch.

>
> Daniel and I will sync privately to check who will send the PR.
>
> thanks,
> rui
>
> >
> > Just to let people aware of the workflow...

Thanks a lot for sharing the updates!

Kind regards
Uffe
