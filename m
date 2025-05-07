Return-Path: <linux-pm+bounces-26809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C431AAE0E1
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 15:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686979A68A7
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D6625E816;
	Wed,  7 May 2025 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4PNJkEs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3556B186E2E;
	Wed,  7 May 2025 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625208; cv=none; b=dwsFO5As5tT8lnXNU5v+fFfvwik1QrD+ystYb0AK3ofzkBFba+icimMLzmtjsKuVUKvJUWIO6CrGMJ67Yy6YyPwws7Gx5rRq00Br4gZVabFUaWxgdapkv9fkVr/BChQQhLV5CaOfYMP+VssQPxETGVblznmvRLf8giM/hGPHbU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625208; c=relaxed/simple;
	bh=e7lyHg4AVIB+IcywSgYYXzTdOPtdVCZa9mRvrWzmUn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGJ7ch38uh+5iDqK2hNEif47SgOWFjLxKSlYM8QWe+tqQNEcngqECuTjXEE2/U8CCbqxQR1T8CIDvEXdjrIbZqXmp3IOwzM68pCh1T8Z2tVkXdoyT+WhqqaRD9bH5uKtz12T6hr48VApClQqLlL7M4TKWYOR7dP+cojM1Ls1VfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4PNJkEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DC0C4CEF0;
	Wed,  7 May 2025 13:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746625207;
	bh=e7lyHg4AVIB+IcywSgYYXzTdOPtdVCZa9mRvrWzmUn4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f4PNJkEsS3RqtJ/rbEikh+pYESFxAEjj+6P8S1I7Jw3G7A7RzTlN/GerQ402CSGo6
	 usxHmanqKqYEiGzORgW9wss5L8X8VWWV2LzqiNyrGRxbmUP8lDVGD7ID/AzSt5KU26
	 oWKCUsWdVb8r5xiHShkTObFVTRAlb38+6R6uOoYPCZ0JMkYjzW7wEp9GOow5LPzA4p
	 sGWWkB7ZuOrKGl5HMynNukT1gGXD/YJnJUp4TVqm1lqnyY7GdN4xj1ZppjZ+iQln+F
	 2WLWIZblV1g5WA+DUD1bTJxYq5nOMxw8xxCJREYE+GR3+dyN9OO23xnC/0aklfzhA4
	 Sk0B3In93nKbQ==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2c12b7af278so693736fac.0;
        Wed, 07 May 2025 06:40:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOeidAGia9OI0z3lENesQxFvBKEy/ckXGg9wIakudDNAdicj8B9Eh6zLlj/CjwvsAornjadS16XfilUnk=@vger.kernel.org, AJvYcCUvJh5G1HH/bYjLM+fMtN5Orm78C+1AjSeeOHkol+iyXL+JX+g3WOlKJC9dkmYJ2Nvr+pQ4+NngM5s=@vger.kernel.org, AJvYcCX/QeWgqiHE2vWPBj7IljTQJK87UZccQb6VrG3xblieKe1h6nIZvjO3nDoVjUurn+E+kfroUstFw18CjPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy863cM+ZnaT8bBStQaS9cMrqWWETv1/7zPAL9CNf85BZ5aoNK4
	TIIHNgzGwV0L81uxyFglFU8HLUvCtcQYVgl0vj+IepyElyWAbAxhJwYHNHS4gJ+ecF0grM9qAId
	YtpjD6u/0py1QJ4+sRaw4hHopiwI=
X-Google-Smtp-Source: AGHT+IGCPG8J0UWIKoecFHsxEMYoFgrcqHQ2a+A/tlazF/8xtNMkpwgmLeVDd4dbnwNhSh5/Q2wzc8LRIoco2mJKgZU=
X-Received: by 2002:a05:6870:a786:b0:2c1:4827:c0e1 with SMTP id
 586e51a60fabf-2db5d0c4e51mr1708339fac.17.1746625206835; Wed, 07 May 2025
 06:40:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10629535.nUPlyArG6x@rjwysocki.net> <22630663.EfDdHjke4D@rjwysocki.net>
 <c6cd714b-b0eb-42fc-b9b5-4f5f396fb4ec@nvidia.com> <CAJZ5v0jWTtaQEcx0p+onU3eujgAJpF_V57wzZCuYv2NVnEb7VQ@mail.gmail.com>
 <7c970b02-7b58-4d15-b5f6-18bbfd883ccd@nvidia.com>
In-Reply-To: <7c970b02-7b58-4d15-b5f6-18bbfd883ccd@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 15:39:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jcWQ3QKx=2nzDpnYPyGuYfT4TModwdAreWZu4d0hXmoA@mail.gmail.com>
X-Gm-Features: ATxdqUHi4edRYTYsGww1_00MyuihNNseQMhDCMUYrbqMTVsu7cE5xfoQD4ovv7E
Message-ID: <CAJZ5v0jcWQ3QKx=2nzDpnYPyGuYfT4TModwdAreWZu4d0hXmoA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] PM: sleep: Resume children after resuming the parent
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Saravana Kannan <saravanak@google.com>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jon,

On Wed, May 7, 2025 at 3:21=E2=80=AFPM Jon Hunter <jonathanh@nvidia.com> wr=
ote:
>
> Hi Rafael,
>
> On 02/05/2025 21:33, Rafael J. Wysocki wrote:
>
> ...
>
> >> I have noticed a suspend regression with -next on a couple of our Tegr=
a
> >> boards. Bisect was pointing to the following merge commit ...
> >>
> >> # first bad commit: [218a7bbf861f83398ac9767620e91983e36eac05] Merge
> >> branch 'pm-sleep' into linux-next
> >>
> >> On top of next-20250429 I found that by reverting the following change=
s
> >> that suspend is working again ...
> >>
> >> Revert "PM: sleep: Resume children after resuming the parent"
> >> Revert "PM: sleep: Suspend async parents after suspending children"
> >> Revert "PM: sleep: Make suspend of devices more asynchronous"
> >
> > I see.
> >
> > Do all three commits need to be reverted to make things work again?
> > The first one only touches the resume path, so it would be surprising
> > if it caused a suspend regression to occur.
>
> I had to revert the other 2 patches for the kernel to build. I tried to
> only revery this patch, and fix the build issue by defining the missing
> function and mutex, but that did not seem to work. The build worked, but
> suspend still failed. I am not sure if that is conclusive though.

The "PM: sleep: Resume children after resuming the parent" patch is
unlikely to introduce the issue, so you should not need to revert it.

The issue is probably introduced by "PM: sleep: Suspend async parents
after suspending children".

> >
> > The most likely commit to cause this issue to happen is the second one
> > because it effectively changes the suspend ordering for "async"
> > devices.
> >
> >> I have been looking into this a bit more to see what device is failing
> >> and by adding a bit of debug I found that entry to suspend was failing
> >> on the Tegra194 Jetson AGX Xavier (tegra194-p2972-0000.dts) platform
> >> when one of the I2C controllers (i2c@c240000) was being suspended.
> >>
> >> I found that if I disable only this I2C controller in device-tree
> >> suspend worked again on top of -next. This I2C controller has 3 device=
s
> >> on the platform; two ina3221 devices and one Cypress Type-C controller=
.
> >> I then found that removing only the two ina3221 devices (in
> >> tegra194-p2888.dtsi) also allows suspend to work.
> >>
> >> At this point, I am still unclear why this is now failing.  If you hav=
e
> >> any thoughts or things I can try please let me know.
> >
> > So are the devices in question "async"?  To check this, please see the
> > "async" attribute in the "power" subdirectory of the sysfs device
> > directory for each of them.
>
> I checked for both the I2C controller and ina3221 and don't see any
> 'async' files ...
>
> $ ls /sys/class/i2c-dev/i2c-2/device/2-0040/power/
> autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
> control               runtime_status
> $ ls /sys/class/i2c-dev/i2c-2/device/2-0041/power/
> autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
> control               runtime_status
> $ ls /sys/class/i2c-dev/i2c-2/power/
> autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
> control               runtime_status

You need to set CONFIG_PM_ADVANCED_DEBUG to see those (and other debug
attributes).

> > If they are "async", you can write "disable" to this attribute to turn
> > them into "sync" devices.  I'd do this and see what happens.

You may also turn off async suspend altogether:

# echo 0 > /sys/power/pm_async

and see if this helps.

> >
> > Overall, it looks like some dependencies aren't properly represented
> > by device links on this platform.
>
> Yes that would appear to be the case, but at the moment, I don't see
> what it is. The ina3221 devices appear to suspend fine AFAICT, but hangs
> when suspending I2C controller. Exactly where is still a mystery.

So if it works with async suspend disabled, I would check the ordering
in which devices are suspended in that case (probably requires running
with initcall_debug in the kernel command line and echoing 1 to
/sys/power/pm_debug_messages).

Then compare it to the ordering in which devices are suspended with
async suspend enabled (for that, I would hack the I2C controller
suspend return an error early to avoid having to reboot the board
after it hangs).  All of the differences would be suspicious.

