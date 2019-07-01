Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A32295C357
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 20:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfGAS6d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 14:58:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38649 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfGAS6d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 14:58:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id r12so24799257edo.5;
        Mon, 01 Jul 2019 11:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pHrGNQ49AaGKJ3l+4A7hkHqbH10XRgFjiNEVRByexR0=;
        b=KnI0hNv+Jm46TmYLlPKsmbOgIdkFU9NMS+sxpx73WzhyzihHn8mGQa6KhunsFLfIBp
         5zCQKX5e9B7ggcGBQ0Zy4ZTX7E02YVQs25zw2xE3BhCZOoMWxtB4OEXaclCyDiyF8cio
         9SyP7Sh22xPwcZ9IH1Bv7zEpU1Yq36dPnsqHZaq69dHddDoS3/5CLzEH2vul0Va9kU7h
         28S1oRGwKughSArRM+yc7SXpbYuzxptwaUbrKZlybcH61HEYKYx7xR5S98Aidkd0U4U1
         gcJqV+5YulFaz2eAE/DI58LLwVW7NN1Nv1z1lVNXwcyvTR03LFmrLTVlQ18dtGjOVJ2l
         1bIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pHrGNQ49AaGKJ3l+4A7hkHqbH10XRgFjiNEVRByexR0=;
        b=UsnxbttqtLncS/ZEe1Mhec0jW02EHvBOSVEHgir1+wMsDTPT6CmuYH9ZmQnTZYCZOD
         R5Impga3eIMlg6f15+oLFhEp/LxY1mliW04ijkJg28L47xHtMOJBw/ZZ5cQUoawgC9OE
         YxSrU4ctJiBYoUReeNgH9Q5YnJ00w2scSkURyGZzIvDnqiYDOXxHUQR7hq1pq4yMbYVL
         nA/IVWSuDNRckQIzjwszDnb25BWD1pGa3RQlygfxg4VqW6K2yy1509xw4j5qUOVMNLa4
         nbL6Ha07l6NzpNeJScL1qaj9Az1czPeZ0F39GACIYPjIcTxdBlnpzJ/H8qyKhEfo+jer
         dAAw==
X-Gm-Message-State: APjAAAX3h0TSCzgCknfqU2ozmDsrGvcT6l49cHSF297kcZFsKcv/ZxeD
        3+x1kakmdvB2josJevSLEISqTnqiCDSLxoktHTo=
X-Google-Smtp-Source: APXvYqzhC/tCEZRsc1qoqKg7EL/JrVWW6MNVjwUBvBb2XXRmNeXSLdtLZYZZI/uiz/r5f8hCOEQfk3YI7X84V9/1daE=
X-Received: by 2002:a50:9468:: with SMTP id q37mr30780649eda.163.1562007510992;
 Mon, 01 Jul 2019 11:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190630150230.7878-1-robdclark@gmail.com> <20190630150230.7878-5-robdclark@gmail.com>
 <75a2921d-bf1a-c4c1-6d9a-122474eface4@codeaurora.org>
In-Reply-To: <75a2921d-bf1a-c4c1-6d9a-122474eface4@codeaurora.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 1 Jul 2019 11:58:15 -0700
Message-ID: <CAF6AEGufiSU_sFZFdLH=KT5iCQGwccszURqAQCHd=dhuZafvZg@mail.gmail.com>
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
        Archit Taneja <architt@codeaurora.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 1, 2019 at 11:37 AM Jeffrey Hugo <jhugo@codeaurora.org> wrote:
>
> On 6/30/2019 9:01 AM, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Do an extra enable/disable cycle at init, to get the clks into disabled
> > state in case bootloader left them enabled.
> >
> > In case they were already enabled, the clk_prepare_enable() has no real
> > effect, other than getting the enable_count/prepare_count into the right
> > state so that we can disable clocks in the correct order.  This way we
> > avoid having stuck clocks when we later want to do a modeset and set the
> > clock rates.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/msm/dsi/dsi_host.c         | 18 +++++++++++++++---
> >   drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c |  1 +
> >   2 files changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
> > index aabab6311043..d0172d8db882 100644
> > --- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
> > +++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
> > @@ -354,6 +354,7 @@ static int dsi_pll_10nm_lock_status(struct dsi_pll_10nm *pll)
> >       if (rc)
> >               pr_err("DSI PLL(%d) lock failed, status=0x%08x\n",
> >                      pll->id, status);
> > +rc = 0; // HACK, this will fail if PLL already running..
>
> Umm, why?  Is this intentional?
>

I need to sort out a proper solution for this.. but PLL lock will fail
if the clk is already running (which, in that case, is fine since it
is already running and locked), which will cause the clk_enable to
fail..

I guess there is some way that I can check that clk is already running
and skip this check..

BR,
-R
