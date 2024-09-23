Return-Path: <linux-pm+bounces-14550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D413397E5CD
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 07:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551F41F21080
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 05:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C275D17543;
	Mon, 23 Sep 2024 05:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="IuNktr06"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94EB747F
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 05:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727071066; cv=none; b=G4geDGhM+Bz19PMfBLByEaKzTOk9IrQBXKLa4sejvjvkB9oZHiYQH3CHwqNbv+3ICHca2YRUUiAdu8FeULMSFCO3QVFIx3LGZNYl3WLfpogRmU/BBcHbxXG8OUugQ0OFx/yAmK2AEzW7XlcJW5Dk9Q1l3Fixy0Kvwd/6ous0zeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727071066; c=relaxed/simple;
	bh=Ar21FYPF7WFIbLHKSGNIn5ZsVF38vd0Rtapd9mViFQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNpoXa8LmScQe+ZV09Ir+vZmKZra8INL9GYCc/7ImlV92c+taiQQrnFs0G5GBKgibZeslXIq7phfBgX/23fHwfvEbRPbn8Yj8KzcCBQWwcpoz1cdBtdMKPRTTH50wAEMbGlswkojsHXke9wGbIiND+H3OSW7AzV9MmXQZXc8x2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=IuNktr06; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id AFBD12E04650
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 08:57:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727071059;
	bh=Ar21FYPF7WFIbLHKSGNIn5ZsVF38vd0Rtapd9mViFQw=;
	h=Received:From:Subject:To;
	b=IuNktr06u2ApFX5sxErxI+3LScQolRIvaz4kMwABZHBTKM+D4/8oyVSeGJncDipX5
	 NE50qhFYHgjxb9SMFk/mLaTcOyYHFXL2IMZHlh0nzCpa41jQ6TyUMLqiOQEWLrbKrs
	 BW9B/dUfq279wb+kJk3SYDABPQoILxagHp8xx/KM=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.170) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f170.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-2f7657f9f62so42507391fa.3
        for <linux-pm@vger.kernel.org>; Sun, 22 Sep 2024 22:57:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU4o6mnt0S94V9milZ6IUISS7dWqBjE/4+q13Q5WUs/zf/zW4KJgr2aInTLnqKiVPpQ81mDJ9/AtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0HH33DujH4eROUZoWWmO9/H7vFmP9KD6/ARHsHXjKoTW9J+jq
	3eqYIjkxbH3rTRM5WsRz9CvfOXWYDz989mOVYHco7e0dZk4IE6BmPMTDyyV65TIrYeUp+fOseQK
	IUQaKx3aQWN0VlTN8WdwhMS6Q9kg=
X-Google-Smtp-Source: 
 AGHT+IFv2YSDzZvxOinmkIRqzEUv6+cO9JXtFcvefYFV3Hz3VsTDU5lcBVw1kkCmxKmjg7iAhjrFBaGurjanExAyOaU=
X-Received: by 2002:a2e:8905:0:b0:2f7:9d1b:da59 with SMTP id
 38308e7fff4ca-2f7cc388652mr40841991fa.26.1727071057942; Sun, 22 Sep 2024
 22:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: 
 <CAGwozwHqHbHNi53T87m36-OZ8suCEo1wgJ9fPPgPdcLnt_+S4g@mail.gmail.com>
 <20240923013657.7464-1-derekjohn.clark@gmail.com>
In-Reply-To: <20240923013657.7464-1-derekjohn.clark@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 23 Sep 2024 07:57:25 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHmS-XjhzYayNvT07vesw4eOBh+ZjWi_NDa4xsOangYDQ@mail.gmail.com>
Message-ID: 
 <CAGwozwHmS-XjhzYayNvT07vesw4eOBh+ZjWi_NDa4xsOangYDQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls
 outside suspend (fixes ROG Ally suspend)
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Luke Jones <luke@ljones.dev>, me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <172707105909.26170.2524818982249126860@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi Derek,

> I'm going to be somewhat brief here as I don't like repeating myself, you are
> working from incomplete information and from that you are inferring incorrect
> assertions. Due to NDA the full slate of information that would clarify this
> cannot be released here, but I will be clear: I am not sharing my opinion, I
> am stating facts. What you have described here is a missinterpretation of the
> symptoms and is not correct. The _DSM call is not relevant to the proper fix,
> the sequencing you observe is not applicable to Linux, and the sensitivity of
> the controller is another symptom of the Windows quirk behaving badly in Linux.
> Furthermore, the RGB "flourish" as you call it works as intended with the new
> firmware and no kernel changes required.

Only thing I am seeing here is a bit of heresay. Please get in touch
with Asus, cross your t's and dot your i's, and share what you found
with the rest of the class.

I am in no rush to see this merge, and as all gaming distributions
carry custom kernels that update on a weekly cadence and 90% of users
are on those kernels with the rest being able to figure it out, there
is no practical reason for this to merge quickly. Ubuntu (+variant)
users will get this fix after they've thrown their ally away anyway.

> What I can provide is information on a test we did that should hopefully
> elucidate the issue more clearly for you. We included a patch that allowed us
> to alter the delay in asus-wmi on the fly by writing to an attribute in sysfs.
> In addition, we pushed the _DSM calls as early as possible in the suspend
> sequence. We were unable to find a timing for this that would work consistently
> on different configurations. The same issue exists in your patch set and the
> testing bears this out with Denis still getting spurious wakes when using it.
> The problem with your approach is that you aren't listening to us despite our
> much broader understanding of the issue at hand. If this worked we would have
> submitted it ourselves nearly three weeks ago.

Here you assume I did not do the same. Yes, I did. The asus-wmi quirk
is subject to racing conditions that mean it will never work correctly
(well; without newer firmware maybe perhaps). This series is not, as
the calls happen before suspend starts.

Yes, my V1 of the patch did not include a delay at all. Since the
original Ally is XInput, one of the MCUs was left on, which caused
what Denis experienced. It also triggered a restart of the MCU on the
Ally X after resume. V2 fixes this restart on the Ally X and makes it
behave completely properly.

In fact, after being included in bazzite-testing yesterday, my Ally X
unit went on a deep slumber tonight with powersave on, and then woke
up today beautifully, having only lost 1% of battery.

It is not clear if the issue still exists on the original Ally, I
could not get a clear signal from Denis but do not worry, one of our
contributors is on it.

> *Our solution doesn't require any kernel changes for newer firmware*, as I
> already stated the solution from ASUS fixes the root cause of the problem. Your
> attempt at a solution attempts to outrace the symptoms of it. Please don't
> mischaracterize my statements.

I would hope that is not true and your solution completely removes the
quirk from asus-wmi for newer firmware, as it prolongs the suspend and
resume sequences noticeably. However, given my and Denis' limited
testing, I doubt the controller is able to suspend quickly enough even
with new firmware (you can see the RGB cut before it's able to fade).

In any case, this patch series is not expected to conflict with Asus'
newer firmware and is in fact complementary with it. Both fix the same
issue in a different way, which means our users will have a great
experience, squared. This series also greatly improves resume behavior
on the Ally, which, let me tell you, is blazing fast now.

Antheas

