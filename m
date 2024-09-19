Return-Path: <linux-pm+bounces-14485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F179697CD20
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 19:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6934C1F24ECF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 17:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF4F1A08B0;
	Thu, 19 Sep 2024 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="NKtbfV2k"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AD3198A33;
	Thu, 19 Sep 2024 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726767414; cv=none; b=JARgzVID+HrhoLJjMsg6aoptljbQ+QVHq3othvNkHi54Qcn4O3NVrzPg7NMcb/JiVQMRmGbmzPabZqqEIB6kL77QLq86DoEZStqt+qiyaxvPcssbvqM+XkI90YbSvaRWJfWlIvZ3g2Dkak6Z26Wl39xvmedJPXYSxPBEPUYjLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726767414; c=relaxed/simple;
	bh=YfZOFvIcXWLUHkvEdJH8MXkt4BbsDKL4o47p1v9LFyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7riRiPqcMutUzJV+uSe1tFLd8Njl+jbnKLtuhbG0NGYDz4vnfU3MPrPE3TVD3X39z05iaassYF+SgDp89utX8J209KfvobzZFG0O4OTjxG937JvAYx0amT8GoSgh+IB0fE4jihZ/i7QlTdX5s4Qc9O6kg+XBtTOsJ0pf8b9Dq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=NKtbfV2k; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 9B60D2E09C22;
	Thu, 19 Sep 2024 20:36:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1726767405;
	bh=1V7eYe7VNVNxXo3maIvrt0DbBepNSvx/knbmHSFqtNo=;
	h=Received:From:Subject:To;
	b=NKtbfV2kvhBbpdzvdQ2onTBxXUlYq6B6GmvJG4SDBU4e0DzPzvkgNul1fX/7ux/Pv
	 saFTcda+1bZt1vxN1Y4y7LVYy2JWsjam42k0A0VIPtD/3Ju3XttcC7zwNLC9ZgrKER
	 nKfsfldaMkyYdlIJ+Co5AZXm5n3DDmSQDyp1qSJ8=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.179) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f179.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-2f74b6e1810so9763981fa.2;
        Thu, 19 Sep 2024 10:36:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVstHuCtsjnEURODmiXR/Eari8aL146OBW2CGXCvEphdEnjZPksC9jbWy4jKWTVnVs6ME5dpgPm85OH0Ob7bNCditsc@vger.kernel.org
X-Gm-Message-State: AOJu0YwUuaK+ri6vcnVeIW0ZK9WW+rXMDrPoxiNx9Lzcc0v/32ckx7jz
	pxbrTVe6qz1UmF6mRT6QkEqvT9iyDaCHR95jSpSFrZkOPDmH8sFa+LCGaSt3bYSFOdlHknAbCwi
	SNBS96DL8ziLGmKQ3eODUvNysNDU=
X-Google-Smtp-Source: 
 AGHT+IH0MX0BgWcbYPictzjYNHEGv06IfRe13L/hScZ3GhZPVpnuAWsphnjEAlRbc/fyAvMdBUnGdwoKZmJvTeaPpNs=
X-Received: by 2002:a2e:a543:0:b0:2f7:4f93:ef8 with SMTP id
 38308e7fff4ca-2f7cb2f9141mr2513111fa.4.1726767403986; Thu, 19 Sep 2024
 10:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919171952.403745-1-lkml@antheas.dev>
 <20240919171952.403745-2-lkml@antheas.dev>
 <0f758a1a-958d-41d6-a572-cf544590450a@amd.com>
In-Reply-To: <0f758a1a-958d-41d6-a572-cf544590450a@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 19 Sep 2024 19:36:32 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwEquttfbzat4ZQbQ3h_7Gi2QZ7qDBr=QgaZBU0MejEQ6Q@mail.gmail.com>
Message-ID: 
 <CAGwozwEquttfbzat4ZQbQ3h_7Gi2QZ7qDBr=QgaZBU0MejEQ6Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] acpi/x86: s2idle: add support for screen off and
 screen on callbacks
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	luke@ljones.dev, me@kylegospodneti.ch
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <172676740494.12056.6323259462321467673@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

As stated in the cover letter, I would like to add you as a co-author.
Just did not (could not?) do it before asking.

I will do it on the next revision. Just tell me which patches you think
it should be on.

(hit reply instead of reply all by mistake, so you have this email twice now)

Best,
Antheas

On Thu, 19 Sept 2024 at 19:29, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 9/19/2024 12:19, Antheas Kapenekakis wrote:
> > The screen off and screen on firmware functions are meant to signify
> > the system entering a state where the user is not actively interacting
> > with it (i.e., in Windows this state is called "Screen Off" and the
> > system enters it once it turns the screen off e.g., due to inactivity).
> >
> > In this state, the kernel and userspace are fully active, and the user
> > might still be interacting with the system somehow (such as with
> > listening to music or having a hotspot). Userspace is supposed to
> > minimize non-essential activities, but this is not required.
> > In addition, there is no requirement of suspending post the screen off
> > call. If the user interacts with the system, the kernel should call
> > screen on and resume normal operation.
> >
> > This patch adds a set of callbacks to allow calling the screen on/off
> > callbacks outside of the suspend/resume path. It is based on
> > Mario Limonciello's patch on the superm1/dsm-screen-on-off branch.
>
> Based on?  It's nearly an identical patch [1].  The screen_off/screen_on
> lines in struct platform_s2idle_ops are just placed in a different location.
>
> IMO there should be more attribution here, either a Co-developed-by tag
> or sending my patch directly and adding your S-o-b to it.
>
> Link:
> https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/commit/?h=superm1/dsm-screen-on-off&id=7b80581428315f973410dccf0402a86266fb0d9a
> [1]
>
> > However, the intent here is completely different.
> >
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >   include/linux/suspend.h |  5 +++++
> >   kernel/power/suspend.c  | 12 ++++++++++++
> >   2 files changed, 17 insertions(+)
> >
> > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > index da6ebca3ff77..96ceaad07839 100644
> > --- a/include/linux/suspend.h
> > +++ b/include/linux/suspend.h
> > @@ -132,6 +132,7 @@ struct platform_suspend_ops {
> >   };
> >
> >   struct platform_s2idle_ops {
> > +     int (*screen_off)(void);
> >       int (*begin)(void);
> >       int (*prepare)(void);
> >       int (*prepare_late)(void);
> > @@ -140,6 +141,7 @@ struct platform_s2idle_ops {
> >       void (*restore_early)(void);
> >       void (*restore)(void);
> >       void (*end)(void);
> > +     int (*screen_on)(void);
> >   };
> >
> >   #ifdef CONFIG_SUSPEND
> > @@ -160,6 +162,9 @@ extern unsigned int pm_suspend_global_flags;
> >   #define PM_SUSPEND_FLAG_FW_RESUME   BIT(1)
> >   #define PM_SUSPEND_FLAG_NO_PLATFORM BIT(2)
> >
> > +int platform_suspend_screen_off(void);
> > +int platform_suspend_screen_on(void);
> > +
> >   static inline void pm_suspend_clear_flags(void)
> >   {
> >       pm_suspend_global_flags = 0;
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index 09f8397bae15..19734b297527 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -254,6 +254,18 @@ static bool sleep_state_supported(suspend_state_t state)
> >              (valid_state(state) && !cxl_mem_active());
> >   }
> >
> > +int platform_suspend_screen_off(void)
> > +{
> > +     return s2idle_ops && s2idle_ops->screen_off ? s2idle_ops->screen_off() : 0;
> > +}
> > +EXPORT_SYMBOL_GPL(platform_suspend_screen_off);
> > +
> > +int platform_suspend_screen_on(void)
> > +{
> > +     return s2idle_ops && s2idle_ops->screen_on ? s2idle_ops->screen_on() : 0;
> > +}
> > +EXPORT_SYMBOL_GPL(platform_suspend_screen_on);
> > +
> >   static int platform_suspend_prepare(suspend_state_t state)
> >   {
> >       return state != PM_SUSPEND_TO_IDLE && suspend_ops->prepare ?
>

