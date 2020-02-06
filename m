Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 441CF1540A1
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2020 09:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgBFIqO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Feb 2020 03:46:14 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40171 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgBFIqN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Feb 2020 03:46:13 -0500
Received: by mail-vk1-f194.google.com with SMTP id c129so1391005vkh.7
        for <linux-pm@vger.kernel.org>; Thu, 06 Feb 2020 00:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8SHAgobSEb546iBt5cNLjHLEI9u6dAs7lm7+/SJg7Jk=;
        b=pbRhghe/7yBE+QvA+2niPDdMyXYY6Uxi+o3Wd1l4gPLoxZLbexr+qrjM5w3ZoBCt71
         uNDS8Nkfc/dCOTAbqlK5ZmkYXagP5tP0mwoqBLCpzy5mw3Zrd6Yszfho47x35dVGJIMF
         T7lfuzUC2HyXaoiJSSCiTovaSnpG0sTVbJUOkRbDo6wjoeJTjoRdEv6O4dISSBEqm4k/
         7eaw08U4iH2SVIe8cr/3jE7QnA7VEoatzdj2wy7igjBZ0nMLOHbzwuwkmSJR/pev96bN
         UTINzh3dw4ubVF2YD3m7ZZecM9W0CbXKJHw3zXH5OC5JyhUNglK1iD7WsOafjQms2sux
         jR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8SHAgobSEb546iBt5cNLjHLEI9u6dAs7lm7+/SJg7Jk=;
        b=QeoLRr6TbLur2GDBFVwE2R64QwAlwVK46DZjgwrcx+Yy7vdBcfv4cyH+W5CVqi6W+S
         rYhEu3L4cUtW3vYOLqe/W4jisZ0vyGyKQQuaAZ2p+x3QkbOSfeIC7YvZ/yIWInvUYKIb
         WuY5SB+el4y1EA8ayj6d4H/YSI5jNieZFihdV48+ezTdbJmD6J3SEb0vLUlIunoPkdHJ
         pOPjs0TTe1DTrPXnxMr8QADENKY8hKEPQEP3qO/lBJ2V+aK0aHZyOJUVY86Y1Azoumre
         YE4tReLpibFTbpDuSJ2/bQH6crRWEY61kkMrI3TBNm/d5CLPd/KsegOekeGT+oojBZOx
         Ty6w==
X-Gm-Message-State: APjAAAU8KIrV6aSn+JUanqRv77N88nEjNWIHBfZyxLS5HyBDUvUQe6G5
        fJFymhg60y/Xt4beeERJEnvGt0ZzAaTXFzhN+rq6yg==
X-Google-Smtp-Source: APXvYqyhaBupFPdxR9GuF8DCLqL3bWPkA59GP7Uflc2DvigCdd8wZzZQzSTTp4q1qRVGG3M64NLke2IWZ0RBxoBZK38=
X-Received: by 2002:ac5:c844:: with SMTP id g4mr1195612vkm.25.1580978770270;
 Thu, 06 Feb 2020 00:46:10 -0800 (PST)
MIME-Version: 1.0
References: <1580736940-6985-1-git-send-email-mkshah@codeaurora.org>
 <1580736940-6985-6-git-send-email-mkshah@codeaurora.org> <20200203170832.GA38466@bogus>
 <0d7f7ade-3a1e-5428-d851-f1a886f58712@codeaurora.org> <20200204152132.GA44858@bogus>
 <6ff7c82d-4204-a339-4070-0154ab4515f1@codeaurora.org> <20200205140603.GB38466@bogus>
 <CAPDyKFoyepN2VX4COMomp1e9dXPozzrgCdcy0paee2jp8Wm3YA@mail.gmail.com> <20200205161816.GD38466@bogus>
In-Reply-To: <20200205161816.GD38466@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 6 Feb 2020 09:45:34 +0100
Message-ID: <CAPDyKFqaA7oN2+oLS=Puw+jQXke_ErGQAWYuTuU-6PS7mo5YbQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] drivers: firmware: psci: Add hierarchical domain
 idle states converter
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 5 Feb 2020 at 17:18, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Feb 05, 2020 at 04:55:17PM +0100, Ulf Hansson wrote:
> > On Wed, 5 Feb 2020 at 15:06, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Wed, Feb 05, 2020 at 05:53:00PM +0530, Maulik Shah wrote:
> > > >
> > > > On 2/4/2020 8:51 PM, Sudeep Holla wrote:
> > > > > On Tue, Feb 04, 2020 at 10:22:42AM +0530, Maulik Shah wrote:
> > > > > > On 2/3/2020 10:38 PM, Sudeep Holla wrote:
> > > > > > > On Mon, Feb 03, 2020 at 07:05:38PM +0530, Maulik Shah wrote:
> > > > > > > > From: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > > >
> > > > > > > > If the hierarchical CPU topology is used, but the OS initiated mode isn't
> > > > > > > > supported, we need to rely solely on the regular cpuidle framework to
> > > > > > > > manage the idle state selection, rather than using genpd and its
> > > > > > > > governor.
> > > > > > > >
> > > > > > > > For this reason, introduce a new PSCI DT helper function,
> > > > > > > > psci_dt_pm_domains_parse_states(), which parses and converts the
> > > > > > > > hierarchically described domain idle states from DT, into regular flattened
> > > > > > > > cpuidle states. The converted states are added to the existing cpuidle
> > > > > > > > driver's array of idle states, which make them available for cpuidle.
> > > > > > > >
> > > > > > > And what's the main motivation for this if OSI is not supported in the
> > > > > > > firmware ?
> > > > > > Hi Sudeep,
> > > > > >
> > > > > > Main motivation is to do last-man activities before the CPU cluster can
> > > > > > enter a deep idle state.
> > > > > >
> > > > > Details on those last-man activities will help the discussion. Basically
> > > > > I am wondering what they are and why they need to done in OSPM ?
> > > >
> > > > Hi Sudeep,
> > > >
> > > > there are cases like,
> > > >
> > > > Last cpu going to deepest idle mode need to lower various resoruce
> > > > requirements (for eg DDR freq).
> > > >
> > >
> > > In PC mode, only PSCI implementation knows the last man and there shouldn't
> > > be any notion of it in OS. If you need it, you may need OSI. You are still
> > > mixing up the things. NACK for any such approach, sorry.
> >
> > Sudeep, I don't quite agree with your NACK to this. At least not yet. :-)
> >
>
> OK, I am not surprised :-)

Apologize for troubling you again. :-)

>
> > I do agree that the best suited solution seems to be OSI, as to
> > support this kind of SoC requirements.
> >
>
> That's the main point. We need to draw some line as what we want to do
> with PC and OSI mode. If we plan to take up all last man responsibility
> in the kernel, what's the point in not supporting OSI in the firmware
> then ? I can't buy it yet.
>
> > However, if for some reason the PC mode is being used, we could still
> > allow Linux to control "last-man activities" as it knows what each CPU
> > has voted for when going idle. Yes, the PSCI FW decides in the end,
> > but that doesn't really matter. Or is there another technical reason
> > to why you object?
> >
>
> Precisely, FW decides and let it. Just because we can do in the kernel
> doesn't mean we must do it. It's clear in the spec and doing it in the
> kernel will be sub-optimal if PSCI f/w aborted entering the deeper
> state that required some action in the first place.

Yes, it may be suboptimal for PC-mode.

On the other hand, we already fire CPU PM notifiers while exit/enter
idle states (except for WFI). Those may also be suboptimal for kind of
the similar reasons.

Maybe it's not the best argument, but it sounds like allowing us to
control cluster power on/off notifications for last-man activities,
would just conform to the similar behaviour we already have. No?

>
> > As a matter of fact, if we allow support for PC mode with
> > "last-man-activities", it would allow us to make a fair
> > performance/energy comparison between the two PSCI CPU suspend modes,
> > for the same SoC. I would be thrilled about looking into doing such
> > tests, I bet you are as well!?
> >
>
> I was, but not anymore, especially if we want such changes in the kernel
> to do so.
>
> Just use OSI as that was the point of adding all these after years of
> discussion claiming it's more optimal compared to PC. Now telling that
> you need more changes to compare it with PC just doesn't make any sense
> at all to me.

Fair enough.

I was just pondering over if there are other reasons to why we may want this.

One other thing that could be problematic to support, is when are
other resources, I/O controllers for example, sharing the same power
rail as a cluster. When such controller is in use, idle states of the
cluster must be prevented. Without using genpd to model the CPU
topology, it may be difficult to deal with this.

Of course, using PC mode when trying to deal with this
platform/board-requirement would also be suboptimal. In other words,
your argument about when using OSI vs PC mode, still stands.

Kind regards
Uffe
