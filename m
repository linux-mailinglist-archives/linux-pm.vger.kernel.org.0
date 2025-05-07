Return-Path: <linux-pm+bounces-26813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CACAAE302
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 16:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9BB4540E28
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 14:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A573289834;
	Wed,  7 May 2025 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ipc/rqs8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5F225DCF3;
	Wed,  7 May 2025 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627922; cv=none; b=rfZnHlBxlH5GA9yIEq3erbDRg4e7UU35INzAOGpS53kLLYjuwuww+zfQHUpEaiDqIwh8Sd6/Ez5/qt1QkNZWxNF7Jqs9bUqjOTiNgTB5mdE0xMQeOHX1yL27f7+pECJVyCT5WTKzZ9C80AgPf/00xZU8XiWKwsqIxt32a0LWdLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627922; c=relaxed/simple;
	bh=gJZdQvzS4SU1QU3a2PIjJsD+hAr3oKVlr3lQTMmb2vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7sPH/V45c4D0tjwAvHiHyEsUJ/HX10oRkyJ1tkcA/GJte3x22MvUrO58qQ9L6+TJ9vFpeiFg/fasx0InZzNoOfBChDC/w93Zc0wLurXwMEDpEb33cq5J7QDYxagkAl64SJ30XAempP4hdNNeLojqnzXP48IwKAGTc+eQ1UnpWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ipc/rqs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6C3C4AF09;
	Wed,  7 May 2025 14:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746627920;
	bh=gJZdQvzS4SU1QU3a2PIjJsD+hAr3oKVlr3lQTMmb2vU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ipc/rqs8LDlVWYx+w8U5U4qvc3DQSlqeOpZETfsiE0hE/14Vriq9GokoZD+PAbeuk
	 mYzJIEFoJHpQE2fWhL8a55s80W9/2qh8rpn+qpQ+s2OxNo8VL+TKX/OdEpnRiivZhy
	 GrhOq3Jcg/KR7cbGFSuTEwKEh/17jHR3c1SUOnucZHPAyP2BN/bVwixYN4erwFbXF/
	 zlkGQZ34Y0xbUhTGa6WtPzuVJrrSml798muRoufBSLthpXS9jtz3N8az2AbNHu5+BP
	 6iYKGyyKLRDnH98uMiGhTcJFgATlRhjeQT4gq8N2dhRm/9vN3+uss+2bTB8zlaDlnt
	 jkuowcTwvR0tA==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so623285fac.0;
        Wed, 07 May 2025 07:25:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQHfkEDrpdSPMAlhqiVtbP+Yz6xwDDiJLtRAEKY5fjL6SS5vBfOL5FTwafNuP8F2ZEaCQIiT59Pec=@vger.kernel.org, AJvYcCWg+TeindeLir4nEYiOEYa0+GdS2YnOoTnAK9kRcaBG+JXM7C4J7JwDrJBTTp5cUQU4C2MCTkMSIQVswgI=@vger.kernel.org, AJvYcCX+arTMps4qzbKi+xxeIi0ADvBAEYPtyjkGp2TyXeGVL6eTpN/3lWcQkELI66Dm30TXFe1CMvRhVRRufLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf4AXrnVNSf0Tb5UmA+GsaHQmMku+wQQ5TAwe76LAiUsH4TGQX
	7yT0z8LpZolhLe2+rllm6/I/xhMItmIBCbURJp27e5VsYLZE0kcOXSJZPKF1F+a0tqkfS7EhNoE
	qe0lrVfovFQfQ+lRFjrnywulL4i8=
X-Google-Smtp-Source: AGHT+IFxzjdHcjmjtJ0voOxBO0pyrnNw2bCHb6XDngV1HI3XDBWnyxWFc5cquRzh1nYS2t5L1/a0Eedt6VG216jOr28=
X-Received: by 2002:a05:6871:898c:b0:2d5:714b:f07c with SMTP id
 586e51a60fabf-2db5899c6fcmr2393279fac.5.1746627919916; Wed, 07 May 2025
 07:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10629535.nUPlyArG6x@rjwysocki.net> <22630663.EfDdHjke4D@rjwysocki.net>
 <c6cd714b-b0eb-42fc-b9b5-4f5f396fb4ec@nvidia.com> <CAJZ5v0jWTtaQEcx0p+onU3eujgAJpF_V57wzZCuYv2NVnEb7VQ@mail.gmail.com>
 <7c970b02-7b58-4d15-b5f6-18bbfd883ccd@nvidia.com> <CAJZ5v0jcWQ3QKx=2nzDpnYPyGuYfT4TModwdAreWZu4d0hXmoA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jcWQ3QKx=2nzDpnYPyGuYfT4TModwdAreWZu4d0hXmoA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 16:25:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jG+54uKiY-uSc6B+8JuA6eU1j8tGM5d=XsrT0EmabMeQ@mail.gmail.com>
X-Gm-Features: ATxdqUH6SmTlcmj70wH_ENjAmkR43q8nA_jxT3Y1YVB3WN3AGualY-w37gRS4YI
Message-ID: <CAJZ5v0jG+54uKiY-uSc6B+8JuA6eU1j8tGM5d=XsrT0EmabMeQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] PM: sleep: Resume children after resuming the parent
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 3:39=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> Hi Jon,
>
> On Wed, May 7, 2025 at 3:21=E2=80=AFPM Jon Hunter <jonathanh@nvidia.com> =
wrote:
> >
> > Hi Rafael,
> >
> > On 02/05/2025 21:33, Rafael J. Wysocki wrote:
> >
> > ...
> >
> > >> I have noticed a suspend regression with -next on a couple of our Te=
gra
> > >> boards. Bisect was pointing to the following merge commit ...
> > >>
> > >> # first bad commit: [218a7bbf861f83398ac9767620e91983e36eac05] Merge
> > >> branch 'pm-sleep' into linux-next
> > >>
> > >> On top of next-20250429 I found that by reverting the following chan=
ges
> > >> that suspend is working again ...
> > >>
> > >> Revert "PM: sleep: Resume children after resuming the parent"
> > >> Revert "PM: sleep: Suspend async parents after suspending children"
> > >> Revert "PM: sleep: Make suspend of devices more asynchronous"
> > >
> > > I see.
> > >
> > > Do all three commits need to be reverted to make things work again?
> > > The first one only touches the resume path, so it would be surprising
> > > if it caused a suspend regression to occur.
> >
> > I had to revert the other 2 patches for the kernel to build. I tried to
> > only revery this patch, and fix the build issue by defining the missing
> > function and mutex, but that did not seem to work. The build worked, bu=
t
> > suspend still failed. I am not sure if that is conclusive though.
>
> The "PM: sleep: Resume children after resuming the parent" patch is
> unlikely to introduce the issue, so you should not need to revert it.
>
> The issue is probably introduced by "PM: sleep: Suspend async parents
> after suspending children".
>
> > >
> > > The most likely commit to cause this issue to happen is the second on=
e
> > > because it effectively changes the suspend ordering for "async"
> > > devices.
> > >
> > >> I have been looking into this a bit more to see what device is faili=
ng
> > >> and by adding a bit of debug I found that entry to suspend was faili=
ng
> > >> on the Tegra194 Jetson AGX Xavier (tegra194-p2972-0000.dts) platform
> > >> when one of the I2C controllers (i2c@c240000) was being suspended.
> > >>
> > >> I found that if I disable only this I2C controller in device-tree
> > >> suspend worked again on top of -next. This I2C controller has 3 devi=
ces
> > >> on the platform; two ina3221 devices and one Cypress Type-C controll=
er.
> > >> I then found that removing only the two ina3221 devices (in
> > >> tegra194-p2888.dtsi) also allows suspend to work.
> > >>
> > >> At this point, I am still unclear why this is now failing.  If you h=
ave
> > >> any thoughts or things I can try please let me know.
> > >
> > > So are the devices in question "async"?  To check this, please see th=
e
> > > "async" attribute in the "power" subdirectory of the sysfs device
> > > directory for each of them.
> >
> > I checked for both the I2C controller and ina3221 and don't see any
> > 'async' files ...
> >
> > $ ls /sys/class/i2c-dev/i2c-2/device/2-0040/power/
> > autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
> > control               runtime_status
> > $ ls /sys/class/i2c-dev/i2c-2/device/2-0041/power/
> > autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
> > control               runtime_status
> > $ ls /sys/class/i2c-dev/i2c-2/power/
> > autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
> > control               runtime_status
>
> You need to set CONFIG_PM_ADVANCED_DEBUG to see those (and other debug
> attributes).
>
> > > If they are "async", you can write "disable" to this attribute to tur=
n
> > > them into "sync" devices.  I'd do this and see what happens.
>
> You may also turn off async suspend altogether:
>
> # echo 0 > /sys/power/pm_async
>
> and see if this helps.
>
> > >
> > > Overall, it looks like some dependencies aren't properly represented
> > > by device links on this platform.
> >
> > Yes that would appear to be the case, but at the moment, I don't see
> > what it is. The ina3221 devices appear to suspend fine AFAICT, but hang=
s
> > when suspending I2C controller. Exactly where is still a mystery.

I checked in the meantime and found that the i2c subsystem enables
async suspend/resume for all devices, clients and controllers, so the
devices in question are "async" AFAICS.

