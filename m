Return-Path: <linux-pm+bounces-22694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB5BA40154
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 21:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C21420197
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 20:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4822253B47;
	Fri, 21 Feb 2025 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcC9U5jp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05F025332E
	for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740170963; cv=none; b=HUeITzGb1vHM/BcGPAEoch6tG+hhgEVFfMppu6eRdZoxSK/4VNXS/n8xtIzHnmCm8GHlNAicjfdA/7LAE7HZc51Qq9zAsY5IidFlZoqFFSg0sCEw5+a+68QF/NcOrU15MUAjiIEXf9wR7h8FMjCD3Y71QTkrp4+fB4yt2ste+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740170963; c=relaxed/simple;
	bh=Wo8UvafsPfVP+70kddEcPXJfAnwRI01xbfxVoF4Jkg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wp9YeWLLOIWq5MFjt1oVnYwt9s9SS+sFZqfcSSNEmFmh9vA8yqTUPXZy/x93fAIKMeBUNOYQZyUJdyMgG1bV7jJcYWhODcY7Cr29ayNRHJXf8ua+MxltHuI1hCaEWnwACSINl2Qi/SiRr1jl4YgmsWulsf6LwvK36ulTlAQhECw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcC9U5jp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DA8C4CEE4
	for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 20:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740170963;
	bh=Wo8UvafsPfVP+70kddEcPXJfAnwRI01xbfxVoF4Jkg4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AcC9U5jpJlZl051PUUS4U98OBkdobT00uIGlByrVmz9svucYxZrhxbnU2iuljsv+x
	 ZwGPs3QPoWJJxO6KReROLOIiWR9fnVaQKhICj5oFIoNNIuBybfcY8gWfWS8s/V7MSv
	 wW/CukIAJL2vLiBd7SGA0tw/Bg94BEVJOPQ2W/Cp6n320LaBBH+fA/n79TvA4/sEwh
	 1Obs8N8zNoUlmymivYvLKU7+UFOo1/Bls0UP+HuvGCx/ap0eFCdkL72vdubJly6OXX
	 aop9TdDoBcJOyY+lQ10GavR34PN+hAYSuP4B4d8LcPtsPhi7YQ3/S7oS5PlkByXeek
	 Gr0bS0Ukgy/2g==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2b199bb8af9so2193428fac.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 12:49:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7/V2AetQY/2/j+f0dV/5MlfEjx/qPbkktPW85llvZAwyY6D+QbIgpWSFCAjw/w+hvtA7XU5aXiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvOLtiLQRTWs3HdJQBVdgK3OG9KQ72vbNblm/yMgZA4MszEa3D
	RFPj1Oa6BQcF5VTc9LXlVVgYQ0S1i2mne0WPLrTTm76HxURD598wGoO0ojJJGcbNH6R7R46uvMd
	gcCQjfOYrLFJ7s0qQLhPcP6I/7yo=
X-Google-Smtp-Source: AGHT+IFnjJasbAZclX0MucvWHtKX5Dtik3kNXbM4sE7gRLe7jH3i4CLdz+s1l4RyT0hSZDY/D6TClLQDyS4wqnyM7n0=
X-Received: by 2002:a05:6871:108:b0:2b8:eb06:57e2 with SMTP id
 586e51a60fabf-2bd2faa67a0mr6713837fac.1.1740170962551; Fri, 21 Feb 2025
 12:49:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213105840.2864654-1-xu.yang_2@nxp.com> <CAJZ5v0gGO95FvSVg1xrG+5B8rbDCXbVyfBm8jDgiKUXieTfVPA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gGO95FvSVg1xrG+5B8rbDCXbVyfBm8jDgiKUXieTfVPA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Feb 2025 21:49:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g40qBahsytn9AUn_dPLG-1E+UCQSucA=8kCGdi3bzq8A@mail.gmail.com>
X-Gm-Features: AWEUYZmZ8CDcKQcLF7_t7C30IP6GKl-bEOsa2TPy_Yc1E3nE4D-9gBtWPrcffrQ
Message-ID: <CAJZ5v0g40qBahsytn9AUn_dPLG-1E+UCQSucA=8kCGdi3bzq8A@mail.gmail.com>
Subject: Re: [PATCH v2] PM: sleep: core: Clear is_prepared if no_pm_callbacks
 is true before checking power.syscore
To: Xu Yang <xu.yang_2@nxp.com>
Cc: len.brown@intel.com, pavel@kernel.org, gregkh@linuxfoundation.org, 
	dakr@kernel.org, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, jun.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 10:33=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Thu, Feb 13, 2025 at 11:58=E2=80=AFAM Xu Yang <xu.yang_2@nxp.com> wrot=
e:
> >
> > Currently, if power.no_callbacks is true for a device, device_prepare()
> > will also set power.direct_complete to true. When device_resume() check
> > power.direct_complete, setting power.is_prepared will be skipped if it
> > can directly complete. This will cause a warning when add new devices
> > during resume() stage.
> >
> > Although power.is_prepared should be cleared in complete() state, commi=
t
> > (f76b168b6f11 PM: Rename dev_pm_info.in_suspend to is_prepared) allow
> > clear it in earlier resume() stage. However, we need also set is_prepar=
ed
> > to false before checking syscore if the device has no pm callbacks.
> >
> > Take USB as example:
> > The usb_interface is such a device which setting power.no_callbacks to
> > true. Then if the user call usb_set_interface() during resume() stage,
> > the kernel will print below warning since the system will create and
> > add ep devices.
> >
> > [  186.461414] usb 1-1: reset high-speed USB device number 3 using ci_h=
drc
> > [  187.102681]  ep_81: PM: parent 1-1:1.1 should not be sleeping
> > [  187.105010] PM: resume devices took 0.936 seconds
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> >
> > ---
> > v2: clear is_prepared before check syscore as suggested by Rafael
> > ---
> >  drivers/base/power/main.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 40e1d8d8a589..5e69cfaec661 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -926,6 +926,9 @@ static void device_resume(struct device *dev, pm_me=
ssage_t state, bool async)
> >         TRACE_DEVICE(dev);
> >         TRACE_RESUME(0);
> >
> > +       if (dev->power.no_pm_callbacks)
> > +               dev->power.is_prepared =3D false;
> > +
> >         if (dev->power.syscore)
> >                 goto Complete;
> >
> > --
>
> As I've already said in the other thread, my initial feedback was
> based on an oversimplified view of this code, and the problem will
> need to be addressed differently.
>
> Sorry about that.

Unfortunately, I don't think that this can cover all of the corner
cases.  Something is going to escape, this way or another.

To minimize the number of things that may escape, I would first treat
direct_complete as a special case, so only clear power.is_prepared
early if direct_complete is set.

Then, clear it only for devices with power.no_pm_callbacks set, that is

    if (dev->power.direct_complete) {
        /* Add explanatory comment here */
        if (dev->power.no_pm_callbacks)
            dev->power.is_prepared =3D false;

        /* Match the pm_runtime_disable() in device_suspend(). */
        pm_runtime_enable(dev);
        goto Complete;
    }

This is not perfect because ideally the device with no callbacks
should wait for its parent and suppliers (if any) to resume before new
children can be added under it safely (in case the children depend on
the devices that it depends on) and is_prepared may be cleared before
that happens, but those new children may be added by the parent's
resume callback and they won't appear if the parent is not ready
anyway.

