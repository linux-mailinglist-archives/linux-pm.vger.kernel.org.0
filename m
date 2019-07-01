Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 660C75C3B0
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 21:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfGATeo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 15:34:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38146 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfGATeo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 15:34:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so24912371edo.5;
        Mon, 01 Jul 2019 12:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dH5otBSqw0uMng1APE66eD1anh4AuRLCKS7/pcECOGs=;
        b=u7jbcH+p2X/tuzpDREWK/E3T+1TETi5H4y9z15tTyth0yWW8unULF7SDv5GKf3DXu/
         iKw7O+9OOt+LVWTreNgtYn6G1fnh0saB/4NfUK3j5hdjCeNYneqIY75sSwgyrvjasHg6
         h2cei3CapWFLk5ZciJnKCkVHXP9xry8BglnSjQiB2VZBFVX1C/0BPsSp9wgQsuI4ZnYi
         pU2qxJByqB0lSFIV+06rZQIsmOCfK9NORvwIUQeB06OihVkVQ/HAsH5ljUoUczHA3QJr
         vHqtyckhkailRVUQCShN2cEVVY1zOQ5fC4mk2zqIMVv0ZpmH27vwVTt/T+LlrtykT4s4
         ZV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dH5otBSqw0uMng1APE66eD1anh4AuRLCKS7/pcECOGs=;
        b=fZO5KOQvI1cVcuOqg3E2B6Q456Fd9xaoG9NwJPt86bJeTGA4IFEzyoXeKsANih+/uq
         4xBoBGBK3/zTVEggXQlf8biCrKeFF0S3yoC7xBAFZ915+Ly7Xgquqd0FpG94oGIxduiI
         mqHBNdXoY4u69fBHJJKPjyc4vBq9vVLvBvbBC0xP2CfVSaTUx3+8Vvrn+0CqBLFYyOfG
         oaC2ORsSZPHkSqGTyYGygweVlifkLwjaejzuzuxN72Gq19xaqVpRLqwqNCu4YIB6pi8r
         8ss/3WvMEEtFMxk8vmm48uC3O3K2lrTmmNstUIxkFYAvk8m0U8b/TmcbF8yVUvX9Fa0A
         6zBg==
X-Gm-Message-State: APjAAAWzplExREbVdm60zxgeAE/IPoKRlA8YG4IfJ8HiYTRB+4TrBdtT
        BCx9e+hKIiFBUKL1SQzb/tMJB222RKos1SiKgzg=
X-Google-Smtp-Source: APXvYqysxgbCV5yDkdPFITNx3D9f1KGE0bjCekTf0dCIujzKvdxbtbeNQl49lrfoNKh2HZcftMIfUkLE0X4i8q1MDys=
X-Received: by 2002:a50:9203:: with SMTP id i3mr31774148eda.302.1562009681812;
 Mon, 01 Jul 2019 12:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190630150230.7878-1-robdclark@gmail.com> <20190630150230.7878-5-robdclark@gmail.com>
 <75a2921d-bf1a-c4c1-6d9a-122474eface4@codeaurora.org> <CAF6AEGufiSU_sFZFdLH=KT5iCQGwccszURqAQCHd=dhuZafvZg@mail.gmail.com>
 <9fbf9226-578a-90aa-693d-9ea4fcda8281@codeaurora.org>
In-Reply-To: <9fbf9226-578a-90aa-693d-9ea4fcda8281@codeaurora.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 1 Jul 2019 12:34:25 -0700
Message-ID: <CAF6AEGtcyvhpAwsD+ykn5HYhBeHtW2kSgE6OA+d142O9AKx+CQ@mail.gmail.com>
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

yeah, I'd expect the lock bit to still be set (since the display is
obviously running at that point)..  but I didn't really debug it yet,
I just hacked that in so the clk_enable didn't fail, so that we could
get correct enable/prepare_counts in order to do the
clk_disable_unprepare()..

BR,
-R
