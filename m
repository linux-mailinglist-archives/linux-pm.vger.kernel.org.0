Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2741A11D2A8
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 17:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbfLLQs1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 11:48:27 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41137 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729874AbfLLQs1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2019 11:48:27 -0500
Received: by mail-oi1-f193.google.com with SMTP id i1so24871oie.8;
        Thu, 12 Dec 2019 08:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wjt4lItRqFacWsQt7v1P7M8uY8SdNlW1FI4JcWAB9cg=;
        b=W25SuvyzASkf1N/Nqhj4V8tCx8oys9boPdvQC3lJVdqlqCggoLAOCkLx0qzemhIhVG
         AM6Y0OJLUHK2Gr5FG0MFwXj+Sfh/fjVjPWQOWEeuNtaRh98FZSwwTVFDhGNuOiGhMhur
         puUj1UNTPga0I+ygiqzEGpPD9ohsF2HSZR/Dyw3gUlx41PvCjDonndUN7UJuiQrPAFAj
         wgpKtcRWel1VMrc8dDuTvi3hAYTps/UCByOhexLy7q+iNkxJfruc6VFxski2nAPcFp0v
         upv30g6UPfTCJdHSqS9d5Pr5agv+5kqCE4xdxbWxOeR3Qt5hR7UQCe/2OOOYUDbx2C4x
         4MeA==
X-Gm-Message-State: APjAAAWCkHeXFjt0juM7tKnJTCaSVaZOwFf55uXdLNmcz5gC9bB55JyU
        CTsRv2sFqoRBfva10siu3p3593FE93Scs1RyMkA=
X-Google-Smtp-Source: APXvYqzhLuqtxFrHpTXnVzGWfbF0p1GWuNhl8OxvrrmXH4N5/NFgSppxHw5/WLukxvz2bdzYziU7WSw55RG2N9rHWPQ=
X-Received: by 2002:a05:6808:b38:: with SMTP id t24mr5721539oij.110.1576169306476;
 Thu, 12 Dec 2019 08:48:26 -0800 (PST)
MIME-Version: 1.0
References: <20191209130336.2257506-1-thierry.reding@gmail.com>
 <20191209130336.2257506-2-thierry.reding@gmail.com> <CAPDyKFp6cnpn4yFaEBDPBdHc1siQvJbmwedbhRNCdDBVAc2qUA@mail.gmail.com>
 <20191212123352.GA3322354@ulmo> <CAPDyKFodOjta0JnEEMrC0j5=XeB-wLjTNvPFtmDtUBZBMTJvQg@mail.gmail.com>
In-Reply-To: <CAPDyKFodOjta0JnEEMrC0j5=XeB-wLjTNvPFtmDtUBZBMTJvQg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Dec 2019 17:48:15 +0100
Message-ID: <CAJZ5v0hA6mz7r93_HVpfP-=72wARf9=NN1jNG3KHtzM_+oT9LA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/tegra: Do not implement runtime PM
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 12, 2019 at 2:32 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 12 Dec 2019 at 13:33, Thierry Reding <thierry.reding@gmail.com> wrote:
> >
> > On Thu, Dec 12, 2019 at 09:52:22AM +0100, Ulf Hansson wrote:
> > > On Mon, 9 Dec 2019 at 14:03, Thierry Reding <thierry.reding@gmail.com> wrote:
> > > >
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >
> > > > The Tegra DRM driver heavily relies on the implementations for runtime
> > > > suspend/resume to be called at specific times. Unfortunately, there are
> > > > some cases where that doesn't work. One example is if the user disables
> > > > runtime PM for a given subdevice. Another example is that the PM core
> > > > acquires a reference to runtime PM during system sleep, effectively
> > > > preventing devices from going into low power modes. This is intentional
> > > > to avoid nasty race conditions, but it also causes system sleep to not
> > > > function properly on all Tegra systems.
> > >
> > > Are the problems you refer to above, solely for system suspend/resume?
> >
> > No, this patch also fixes potential issues with regular operation of the
> > display driver. The problem is that parts of the driver rely on being
> > able to shut down the hardware during runtime operations, such as
> > disabling an output. Under some circumstances part of this shutdown will
> > imply a reset and, at least on some platforms, we rely on that reset to
> > put the device into a known good state.
> >
> > So if a user decides to prevent the device from runtime suspending, we
> > can potentially run into a situation where we can't properly set a
> > display mode at runtime since we weren't allowed to reset the device.
>
> Thanks for clarifying!
>
> We have very similar issues for SDIO functional drivers (WiFi
> drivers). Typically, at some point there needs to be a guarantee that
> the power has been cut in between a "put" and "get", as to be able to
> re-program a FW.
>
> My worry in regards to this, is that we may reinvent the wheel over
> and over again, just because runtime PM today isn't a good fit.
>
> In principle, if you could, somehow forbid user-space from preventing
> the device from being runtime suspended, that would do the trick,
> wouldn't it?

Treating pm_runtime_suspend() and pm_runtime_resume() as the low-level
device power off and power on routines for the given platform is a
mistake.  It has always been a mistake and I'm not going to accept
changes trying to make it look like it isn't a mistake.

If any generic power off and power on helpers for DT-based platforms
are needed, add them and make PM-runtime use them.  That should be
straightforward enough.

Thanks!
