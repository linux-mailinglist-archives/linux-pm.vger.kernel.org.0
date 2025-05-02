Return-Path: <linux-pm+bounces-26600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B397AA7AE2
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 22:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F17981BC6
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 20:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7B91F7092;
	Fri,  2 May 2025 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkH/ix8e"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B14F1D6DBC;
	Fri,  2 May 2025 20:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746218005; cv=none; b=aP+9YNHpua72PsVJ9TpQY86E8ZK1hxiJ5n27+KtVfx6aSdFXbBAW+1fh5HNetoyjLM4OyLh3RoRCHGo7aKiUH+d/xbWkY+oc7ViomRiCslzObVx9uSmfqVqAYl72gfQR4dhfwOt7JREOpijo9oPaws37fm029xNGvOQZgGE8fxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746218005; c=relaxed/simple;
	bh=eQpPThGYqXJRVg1cJBD6NhPKcv8CfiVLMcrOd0iMaKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DipUT1eUhduXd1WhneGdq9RPL3Oq0Ow3yE7HeZ7LxMU1wv6S0TkHCnQfqstGga6xfUKCOFOt1nWTHfOnNKCnoASlnKMPd4ZDcMNb2O9Hki35nQvXRq0APVf+FkdvNRmk3yv0VrWE0AAS4Ony/cLlPta3PazeyPx0pdGP9t2XRcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkH/ix8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0CEC4CEEF;
	Fri,  2 May 2025 20:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746218004;
	bh=eQpPThGYqXJRVg1cJBD6NhPKcv8CfiVLMcrOd0iMaKU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LkH/ix8eRlN6Y0c0oKhTaKSTPGgY9N23Pj1ddgDD+5yZaWnWJIAiQM2ptXkfGTP4C
	 7+9TcCJAEyTU+L9ZiKBurfiJ2Pfpu5dr9TmYoC4/8tX0UokT44/tg/M3Yd9DM9ye2S
	 YQSqmr1HcdkNhGIPO9csXUTYpI3HqIUmBa6zbT814HDozm4+ZcTt2T/Zz/ndzE3jR4
	 C2YvSHwLUW7kqwOiwrtRJED46fEmzVwQPZVe/XQjf3aalChU+ixfCkMNc2+Xtqrr+A
	 NCmHgPbuYokTGFzlPmSitkFD4huqqarulMLGe3Fy29Bd0qIs6uFC+45R2e1xp7aSVN
	 u8dZU2VGKznmg==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2cc57330163so1611082fac.2;
        Fri, 02 May 2025 13:33:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUncAM1h1Kgvgnww9MhrZiVxwvaE8XkX58CuUkbO7OdCS1kCVbAi4BK/YZIUX+ATGS2Aw4MpDp0UPQ=@vger.kernel.org, AJvYcCW2A9ylygLQTPV7kaWWPwfCFbn/+vSIrcdQ7KAswbyaos0/CDdbryBWpxhhf1xLegS+kdx9ybGFauPwvW8=@vger.kernel.org, AJvYcCXpLhXMuFs62q/w3SPpfCgl6v9BH8TTP113mhCr5pV9UIYn/QdLw86zBZMPSf59BtCQb+he6/IVZMakZX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysbK88LUQ9EKp+gvswjo+VSAzIXMDIavEwCyJMGg5/oDK3at4I
	tj0cdVrdMo4DXUX5itvmoqyeauBQwWUEBg/2HUV+d1jJBkDUzViGgyiTx45vqicHzJLsvpEs+ID
	vCF0tdbeN233ReThvIMgBJ4wRc5Q=
X-Google-Smtp-Source: AGHT+IEW5MPykyB7DblG9VdsAylYs04/gOlOoePxUKgxqXrheHVFXIzMetPRzrJbAUzi6p6p+9yRpLrYq8JRplfSSJY=
X-Received: by 2002:a05:6870:82a4:b0:2d4:d07c:7cb6 with SMTP id
 586e51a60fabf-2dab2f5203amr2247004fac.1.1746218003811; Fri, 02 May 2025
 13:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10629535.nUPlyArG6x@rjwysocki.net> <22630663.EfDdHjke4D@rjwysocki.net>
 <c6cd714b-b0eb-42fc-b9b5-4f5f396fb4ec@nvidia.com>
In-Reply-To: <c6cd714b-b0eb-42fc-b9b5-4f5f396fb4ec@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 May 2025 22:33:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jWTtaQEcx0p+onU3eujgAJpF_V57wzZCuYv2NVnEb7VQ@mail.gmail.com>
X-Gm-Features: ATxdqUE5iv8R1HouAoR17904_EO8U54r-IoWclkxHnMpERA0eCldJYj2Oa7ePFY
Message-ID: <CAJZ5v0jWTtaQEcx0p+onU3eujgAJpF_V57wzZCuYv2NVnEb7VQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] PM: sleep: Resume children after resuming the parent
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jon,

On Thu, May 1, 2025 at 11:51=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
> Hi Rafael,
>
> On 14/03/2025 12:50, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > According to [1], the handling of device suspend and resume, and
> > particularly the latter, involves unnecessary overhead related to
> > starting new async work items for devices that cannot make progress
> > right away because they have to wait for other devices.
> >
> > To reduce this problem in the resume path, use the observation that
> > starting the async resume of the children of a device after resuming
> > the parent is likely to produce less scheduling and memory management
> > noise than starting it upfront while at the same time it should not
> > increase the resume duration substantially.
> >
> > Accordingly, modify the code to start the async resume of the device's
> > children when the processing of the parent has been completed in each
> > stage of device resume and only start async resume upfront for devices
> > without parents.
> >
> > Also make it check if a given device can be resumed asynchronously
> > before starting the synchronous resume of it in case it will have to
> > wait for another that is already resuming asynchronously.
> >
> > In addition to making the async resume of devices more friendly to
> > systems with relatively less computing resources, this change is also
> > preliminary for analogous changes in the suspend path.
> >
> > On the systems where it has been tested, this change by itself does
> > not affect the overall system resume duration in a measurable way.
> >
> > Link: https://lore.kernel.org/linux-pm/20241114220921.2529905-1-saravan=
ak@google.com/ [1]
> > Suggested-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
>
> I have noticed a suspend regression with -next on a couple of our Tegra
> boards. Bisect was pointing to the following merge commit ...
>
> # first bad commit: [218a7bbf861f83398ac9767620e91983e36eac05] Merge
> branch 'pm-sleep' into linux-next
>
> On top of next-20250429 I found that by reverting the following changes
> that suspend is working again ...
>
> Revert "PM: sleep: Resume children after resuming the parent"
> Revert "PM: sleep: Suspend async parents after suspending children"
> Revert "PM: sleep: Make suspend of devices more asynchronous"

I see.

Do all three commits need to be reverted to make things work again?
The first one only touches the resume path, so it would be surprising
if it caused a suspend regression to occur.

The most likely commit to cause this issue to happen is the second one
because it effectively changes the suspend ordering for "async"
devices.

> I have been looking into this a bit more to see what device is failing
> and by adding a bit of debug I found that entry to suspend was failing
> on the Tegra194 Jetson AGX Xavier (tegra194-p2972-0000.dts) platform
> when one of the I2C controllers (i2c@c240000) was being suspended.
>
> I found that if I disable only this I2C controller in device-tree
> suspend worked again on top of -next. This I2C controller has 3 devices
> on the platform; two ina3221 devices and one Cypress Type-C controller.
> I then found that removing only the two ina3221 devices (in
> tegra194-p2888.dtsi) also allows suspend to work.
>
> At this point, I am still unclear why this is now failing.  If you have
> any thoughts or things I can try please let me know.

So are the devices in question "async"?  To check this, please see the
"async" attribute in the "power" subdirectory of the sysfs device
directory for each of them.

If they are "async", you can write "disable" to this attribute to turn
them into "sync" devices.  I'd do this and see what happens.

Overall, it looks like some dependencies aren't properly represented
by device links on this platform.

Thanks, Rafael

