Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41B80165B3A
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 11:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgBTKMa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 05:12:30 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:33322 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgBTKMa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 05:12:30 -0500
Received: by mail-ot1-f48.google.com with SMTP id w6so3162493otk.0;
        Thu, 20 Feb 2020 02:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=atbLNfB8xffrjjqL/ucnkxeJEJuBIPdca68FUgtNQMk=;
        b=SqasnrST3n+jX0FPziWcQVzVB4/hhmq2VLS3t3+0fQB8bTcd27NaB/PFyJSvlhgGSN
         lExGrPh6BMlzZ3JWdorgEDK9ZaJqVRAAzLtq88y3JDSAKsJbsnH42m+pxwOtfuAHgcuv
         WwBFaoN1JO8PNj277IKlT3woka7kbkVMBYfE+14sBKeJKzHfSYya58z5Ay3nN2Eeso9s
         wt51XewSaNJxatJvbVj6mu+toPUlNIPhqlIcv9uWC7jd842Y7JQvT6mIahh/5ozwJNmG
         PJXPfQt7k8BwZuWW2ObTy7ONxrftozWgzACJz9mX4iufERksD23iD2WFoo2sklIfcVO6
         K69w==
X-Gm-Message-State: APjAAAXaGu0AYewYyVjqMbygxRe+Lhmu9fWEOrFY+POkFh8CmUlDK9RL
        5YV2WFclGkG4Jprlt69Fb88IMhumsmAlHiGt2rQ=
X-Google-Smtp-Source: APXvYqy3Lp8uHjhvoeSvWG/0ZPoL7miqjtkSwXlVVq4jK3/MToh1rTxX+T/UAWNlCujO8eBtqs+s/LYv38RBeaN/s98=
X-Received: by 2002:a05:6830:1651:: with SMTP id h17mr21715032otr.167.1582193549689;
 Thu, 20 Feb 2020 02:12:29 -0800 (PST)
MIME-Version: 1.0
References: <0955D72C-D24D-402E-884F-C706578BF477@canonical.com>
 <a9fd25cd0a151d20e975ce79ab70197e39ef01e1.camel@linux.intel.com> <235CF4F8-19BF-4B00-8C92-E59CB2D476A7@canonical.com>
In-Reply-To: <235CF4F8-19BF-4B00-8C92-E59CB2D476A7@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Feb 2020 11:12:18 +0100
Message-ID: <CAJZ5v0jXvo0ceNMp=kstTi24Ne7F-ZGMcD0T0TSMpcZZWsJsUA@mail.gmail.com>
Subject: Re: Hard Disk consumes lots of power in s2idle
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kent Lin <kent.lin@canonical.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 20, 2020 at 9:08 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Srinivas,
>
> > On Feb 20, 2020, at 02:36, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> >
> > Hi Kai,
> >
> > On Wed, 2020-02-19 at 22:22 +0800, Kai-Heng Feng wrote:
> >> Hi Srinivas,
> >>
> >> Your previous work to support DEVSLP works well on SATA SSDs, so I am
> >> asking you the issue I am facing:
> >> Once a laptop has a HDD installed, the power consumption during
> >> S2Idle increases ~0.4W, which is quite a lot.
> >> However, HDDs don't seem to support DEVSLP, so I wonder if you know
> >> to do proper power management for HDDs?
> > What is the default here
> > cat /sys/power/mem_sleep
> > s2idle or deep?
>
> It defaults to s2idle.
>
> >
> > Please follow debug steps here:
> > https://01.org/blogs/qwang59/2018/how-achieve-s0ix-states-linux
> >
> > We need to check whether you get any PC10 residency or not.
>
> Yes it reaches PC10. It doesn't reach SLP_S0 though.
> The real number on S2Idle power consumption:
> No HDD: ~1.4W
> One HDD: ~1.8W
>
> If the SoC doesn't hit PC10 the number should be significantly higher.
> That's why I think the issue is the power management on HDD itself.

I'm assuming that you mean a non-SSD device here.

That would be handled via ata_port_suspend() I gather and whatever
that does should do the right thing.

Do you think that the disk doesn't spin down or it spins down, but the
logic stays on?
