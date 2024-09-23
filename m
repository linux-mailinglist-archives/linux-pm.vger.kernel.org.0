Return-Path: <linux-pm+bounces-14590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AE197EFC4
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 19:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54BC1F21F01
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 17:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC8E19F129;
	Mon, 23 Sep 2024 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="D6uI2DE+"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE4619E969;
	Mon, 23 Sep 2024 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727111653; cv=none; b=i+rRIg8bWFVYWtpfPs7iQQV501RMBWMNj1XpumxwTs8tK07QPzRN4qzdWzuLljhFk6P9a2Sib8wmQQ52HQ3Z4rv81ROU0hdqWrEHnJjS4flkAtr1bHUgjkd9AoUElyhJfuFk5cMsRy52qbcawaFDaTbJsrPxQmefvmBPfWzp82c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727111653; c=relaxed/simple;
	bh=RF1/zW6fQ6Nadte0vfpQA1bTZYBMiuFBGhGGsSlKCuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjXtSPHpMQDKvmOUcXI5bZ+c+IkZ10oBgUk3utElD6POeBfMt40gEJbzrZQHJCvtVgbM7KPTwX1lm8cIo8yj5lCKk3WCJB/GnWS1RdEnC9BGRiN0ZSqG4cwl5Lr2+o9BZlLklE59dkdRpqIN5lR/vSft6faJw/eLQOjwO/KKYIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=D6uI2DE+; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id D72662E03520;
	Mon, 23 Sep 2024 20:14:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727111648;
	bh=G5CJapiIRgU4Gi3JxjgGLAHs4v5juDD+qPj/aXVRY6Y=;
	h=Received:From:Subject:To;
	b=D6uI2DE+NdxcX1BfFUcae3HhrpeFSFc5dcMbx/jKtNk6flJhoAs6/PGfUoR9Bi5ut
	 abjQ4fMq4xwzVfC/AxjTTCj3F+gh+ah3Z7TgIt8nS9gQo48PQ0oym7hrARH9n1BCjH
	 0rpl8DTtB4GwEmoTgI9QhmRfmAjpfCTRBnDzVUFY=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.175) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f175.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-2f75e5f3debso42170871fa.1;
        Mon, 23 Sep 2024 10:14:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWkMp5hwG2+bXfShjPX1ljC702BaoBddMRkSBjn0FPI8Ihw+DXAAvk17ZMtntnsF4mNcTApkZnjnj6W3enSzeC4DG9l@vger.kernel.org
X-Gm-Message-State: AOJu0YzpykjTXlUkF9qN+/miz9USPC24ElxvUd+X7odtKC8zsXod/qgp
	w6mwxVyP224CPbGRZ+/RLiSkgFjT3koQK/Ltz7rC4ry3VApjddMN+la+iasVlAvxtORaFgiKnym
	4wNRu8N7UORVW4UxivDn84KSov1w=
X-Google-Smtp-Source: 
 AGHT+IHmVGM03MWHtNEV9zJflGGecuDgpEvuGeiaUv4TFE7F9ptny1oI2SKgECTPL07QYUlCERNi3/q/dqb+EWDzO2k=
X-Received: by 2002:a2e:510a:0:b0:2f7:7d25:a6f8 with SMTP id
 38308e7fff4ca-2f7cb2f9b7bmr45422991fa.24.1727111647010; Mon, 23 Sep 2024
 10:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922172258.48435-1-lkml@antheas.dev>
 <20240922172258.48435-3-lkml@antheas.dev>
 <1a9b611c-51f0-4c3d-8bc2-62c6b6104fd2@amd.com>
 <CAGwozwFwU=KMgDUmKsYRu323dsuUfQYa8e-aXV3JGGSkgF-RkQ@mail.gmail.com>
 <1eff4036-b785-4737-b919-d67c52efea65@amd.com>
 <CAGwozwHbt8+hVDpyz8GM=Lwg8o=oLZDgCJ9JZN_HRzHLuwuknA@mail.gmail.com>
 <257cf784-f038-494f-bd45-016172fcd639@amd.com>
In-Reply-To: <257cf784-f038-494f-bd45-016172fcd639@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 23 Sep 2024 19:13:55 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwH=wk3kTK8XnpN4KAQP-cmZ5q-A0z1JMFCnpd2fdoJwqQ@mail.gmail.com>
Message-ID: 
 <CAGwozwH=wk3kTK8XnpN4KAQP-cmZ5q-A0z1JMFCnpd2fdoJwqQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] acpi/x86: s2idle: handle Display On/Off calls
 outside of suspend sequence
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	luke@ljones.dev, me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: <172711164828.7647.361138166430391036@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Did not mean how it is called as who will call it. But as in the way
it is called does not match the desired behavior.

In any case, as I said, I am happy to work in a downstream POC. My
target usecase is very simple and I do not need/want to tie Display
Off to CRTC.

ie, I will do 2 and 4. I am already familiar with gamescope (including
having two sockets open to it at any given time). Then if we get
interesting results, we move on from there.

As I said I also want to catch the Sleep _DSMs. I do not care about
Display On/Off other than calling it properly (where properly = as in
Windows + a lot of debouncing) so that these handhelds do not get
confused.

Antheas

On Mon, 23 Sept 2024 at 19:05, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 9/23/2024 11:43, Antheas Kapenekakis wrote:
> >
> > If it were me, yes, systemd would switch the system to the inactive
> > "Screen Off" state 5 seconds after the system displays are off due to
> > inactivity. If we are talking about implementing something Modern
> > Standby-like, then pressing the powerbutton would no longer suspend
> > the device. Instead systemd would use two tiers of activators like
> > windows (first tier for "Screen Off", second tier for "Sleep"; right
> > now there is only one tier that mirrors screen off) and once all those
> > activators are released, suspend the kernel.
> >
> > Then it would handle the transition from "Active" to "Screen Off" to
> > "Sleep" through a sysfs endpoint, with the platform responding by
> > e.g., lowering TDP and using a different fan curve.
> >
> > If the kernel is asked to suspend outside of the Sleep state, then it
> > does the transitions to reach that state and references the quirk
> > table to avoid racing conditions in manufacturer firmware (not with
> > the kernel), before it suspends.
> >
> >> Important to note; it DOESN'T explicitly turn off displays.  If you
> >> configured it to suspend then displays get turned off as part of the
> >> kernel suspend sequence (drm_atomic_helper_disable_all).
> >>
> >> If it is configured to trigger a lockscreen then the compositor will
> >> turn off displays after whatever the DPMS configuration is set to.
> >
> > The problem with a DRM atomic helper is that we cannot control how it
> > is called and do debouncing. WIndows does debouncing (part of that is
> > waiting for 5 seconds so that if you move the mouse the call is
> > skipped). You could have edge conditions that spam the calls.
> >
> > Antheas
>
> I'm not meaning that anything in userspace SHOULD be calling
> `drm_atomic_helper_disable_all`, my point was that this is how it's
> normally called in the suspend sequence.  Folks who work on the
> compositors don't like anyone other than the kernel touching their
> configuration at runtime.
>
> I think a lot of what you're looking for is the concept of a systemwide
> "userspace only" suspend sequence.  A lot of devices already support
> runtime PM and will already go into the low power state when not in use.
>   For example USB4 routers you'll see in D3 until you plug something
> into the USB4 port.
>
> IMO your proposal needs to cross at least 3 projects.  Here's my
> thoughts on it.
>
> 1) systemd
>     * To be able to handle behaviors associates with a dark screen only
>       suspend/resume.  I did start a discussion on dark resume some time
>       back but it went nowhere. [1]
>
>     * Make sure that all devices have been put into runtime PM.
>     * Notify compositor that screens should be turned off.
>     * Manage transitions from dark screen to full suspend and vice versa.
>
> 2) Kernel
>    A. To be able to notify the _DSM at the right time that all CRTCs have
>       been turned off).
>    B. To be able to notify the _DSM at the right time that at least one
>       CRTC is now on.
>
> 3) Wayland protocols
>     Introduce a new protocol for requesting userspace suspend.
>     To notify that dark screen only suspend is being triggered.
> 4) Compositor use.
>     All the popular compositors would need to add support for the new
>     protocol.  IE Gamescope, mutter, kwin.
>
> This isn't a trivial effort, there are a lot of people to convince.  I
> think the lowest effort is to start with kernel.  IE having DRM core
> call the _DSM when the CRTCs are off.  If you get that far, you can at
> least get this power saving behavior when DPMS is enacted.  Then you can
> work with systemd and wayland protocol folks.
>
>
> [1] https://github.com/systemd/systemd/issues/27077

