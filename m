Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 308415D109
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2019 15:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfGBNxX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 09:53:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38410 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGBNxX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 09:53:23 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so27372828edo.5;
        Tue, 02 Jul 2019 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AoEb1XK5dWnAb/XBdu/lZ2XdsXhNA2v9oOFATUDjbD0=;
        b=rRQSPxyTMuRnQn9dQ6uPjqvkwKpDvf2xgxGrMy0XuEWVzfk3IEvNkguAVRY9nRJYfo
         gZah0iQhsaCPAwpjLSCemmq8gLLTpII+ti5c6I6TUMrtAzYuZhTP0K1rp+4RCDDgpWzE
         bZc0osHIzLMqxhMLGZhWF899HZ4WnRIySFcnFDj5Ms0T0D+3dNcKCDkMzSF5SWga0uyP
         VpYLcBDsXv2y3SSGlYyIshk4eC28J6M+XEqfASKd8VFtHF2FBaPTuCruVMppchbac3Ax
         AEP45WNtQ+9COLmubIsqWyYzl1QLchUtPfD4LccbjDoAwgxuqOVjD3OBBIag2Lf/5D08
         PWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AoEb1XK5dWnAb/XBdu/lZ2XdsXhNA2v9oOFATUDjbD0=;
        b=HqrLaYe8Yucz1MVcz6FqmiXKITW1gpkazj/Zj7QCXeT6Nhv7o6rRwjrNauI29r5Raf
         3ELw65cDmgqOrA5m1D2nxitsTjz8OfpDWgTjeeh7n3mvzgQhZv+hap4QbeevCNFK1w4G
         +Nu9zY6C0NRUPa1/0Gf7Q2z5B59KvYihJbiKr8yOPJrr/NH6zpGwn0M7VWhLqACcBwHF
         hoEmJQ7XOKQZgSC8JXKVpJe/ePKKoYGAuvINMLiegbQhpraMSv7I1r6U/b+u4bjb7veI
         vLsiJ9jh+l2VJWILap7NIW4SMWrbbG4YYCK28nelql0Q/eiwyGX/J6tktG61CeJlU94G
         bD3Q==
X-Gm-Message-State: APjAAAWFnA3qXjxhrPd2Jvdmwi/EZU52fg/09EfKIl2+KR9ugKwt2O3+
        2nQDsiFuPeUU/qiv0tSOn0JG1GanxQCiIBMvuvbkDf9ZdWc=
X-Google-Smtp-Source: APXvYqyI5MP1Q8XIiLRjo4pLVTzxgZBBN8zypGreqic/xheUF0/IxxIdEzjsWYjgmlEDl7MpPt0LDnPWwQX2r7zymnI=
X-Received: by 2002:a17:906:3f87:: with SMTP id b7mr28163648ejj.164.1562075600813;
 Tue, 02 Jul 2019 06:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190630150230.7878-1-robdclark@gmail.com> <20190630150230.7878-5-robdclark@gmail.com>
 <75a2921d-bf1a-c4c1-6d9a-122474eface4@codeaurora.org> <CAF6AEGufiSU_sFZFdLH=KT5iCQGwccszURqAQCHd=dhuZafvZg@mail.gmail.com>
 <9fbf9226-578a-90aa-693d-9ea4fcda8281@codeaurora.org>
In-Reply-To: <9fbf9226-578a-90aa-693d-9ea4fcda8281@codeaurora.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 2 Jul 2019 06:53:05 -0700
Message-ID: <CAF6AEGuze-mnUQy36UvB-JCp3KUASgTa+0dh4i_AFdmYX0tzuw@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/msm/dsi: get the clocks into OFF state at init
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        aarch64-laptops@lists.linaro.org,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 1, 2019 at 12:07 PM Jeffrey Hugo <jhugo@codeaurora.org> wrote:
>
> On 7/1/2019 12:58 PM, Rob Clark wrote:
> > On Mon, Jul 1, 2019 at 11:37 AM Jeffrey Hugo <jhugo@codeaurora.org> wrote:
> >>
> >> On 6/30/2019 9:01 AM, Rob Clark wrote:
> >>> From: Rob Clark <robdclark@chromium.org>
> >>>
> >>> Do an extra enable/disable cycle at init, to get the clks into disabled
> >>> state in case bootloader left them enabled.
> >>>
> >>> In case they were already enabled, the clk_prepare_enable() has no real
> >>> effect, other than getting the enable_count/prepare_count into the right
> >>> state so that we can disable clocks in the correct order.  This way we
> >>> avoid having stuck clocks when we later want to do a modeset and set the
> >>> clock rates.
> >>>
> >>> Signed-off-by: Rob Clark <robdclark@chromium.org>
> >>> ---
> >>>    drivers/gpu/drm/msm/dsi/dsi_host.c         | 18 +++++++++++++++---
> >>>    drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c |  1 +
> >>>    2 files changed, 16 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
> >>> index aabab6311043..d0172d8db882 100644
> >>> --- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
> >>> +++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
> >>> @@ -354,6 +354,7 @@ static int dsi_pll_10nm_lock_status(struct dsi_pll_10nm *pll)
> >>>        if (rc)
> >>>                pr_err("DSI PLL(%d) lock failed, status=0x%08x\n",
> >>>                       pll->id, status);
> >>> +rc = 0; // HACK, this will fail if PLL already running..
> >>
> >> Umm, why?  Is this intentional?
> >>
> >
> > I need to sort out a proper solution for this.. but PLL lock will fail
> > if the clk is already running (which, in that case, is fine since it
> > is already running and locked), which will cause the clk_enable to
> > fail..
> >
> > I guess there is some way that I can check that clk is already running
> > and skip this check..
>
>
> I'm sorry, but this makes no sense to me.  What clock are we talking
> about here?
>
> If the pll is locked, the the lock check should just drop through.  If
> the pll cannot lock, you have an issue.  I'm confused as to how any of
> the downstream clocks can actually be running if the pll isn't locked.
>
> I feel like we are not yet on the same page about what situation you
> seem to be in.  Can you describe in exacting detail?
>

So, I went back to check some of the kernel logs, and actually the
case where we were hitting the PLL lock fail was -EPROBE_DEFER cases,
so what was happening is the enable/disable cycle would succeed the
first time, but then we'd -EPROBE_DEFER.  Then after a suspend/resume
cycle, we'd try again, but this time pll's were reset to power on
state, and we weren't setting rate.

With the other patchset[1] I sent over the weekend, this should no
longer be a problem so I can drop the hack.

BR,
-R

[1] https://patchwork.freedesktop.org/series/63000/
