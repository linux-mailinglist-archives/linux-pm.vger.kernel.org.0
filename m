Return-Path: <linux-pm+bounces-26818-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1040FAAE39F
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 16:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861BC1892303
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 14:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D26C289E0B;
	Wed,  7 May 2025 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU6dTXEI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F20286D7A;
	Wed,  7 May 2025 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629796; cv=none; b=SlAozlG9C2HdRPe+OproKxvceiR59A2P6hBpS0D+RD+yj5Dt3JyWHM3WWC/eiiAX4kKwJF3gMG/X0bwAJqgfRXfV5Fi5XtPfsCJURsnFHWCdRLk/4rH7b9VluS/VBxoeTW5hxEyvpfNuFpqsoOlGzc8jgVoi29PpphC4KVHSiKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629796; c=relaxed/simple;
	bh=iR3+pPyHy41ZeZVnOn5rv4RaR3wxqUlhFY2EECiUbXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7xkyd195SH+W4IbWIBQEvJThPXXSve+j6GaaC+YWoQvg3qQqtm/qaed/X+PL5OBvorqRbNqkgMXjTrIHG9fQy4DNjEOVfDcF8dbupHm9fVgP/TOa+SJ0dDFrnf3lWOU3b0OWGJtl7hvKJKYg2o7qm7XtheKkAyeFA0uP3+uVIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jU6dTXEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEB3C4CEEE;
	Wed,  7 May 2025 14:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746629795;
	bh=iR3+pPyHy41ZeZVnOn5rv4RaR3wxqUlhFY2EECiUbXk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jU6dTXEIQVMc827z7kgqKuav90ToTqf60EvIpnBOzK/Mc9a73bykC1jr+DICq+B2P
	 E62D3RgiUplBrdI73FXc84QgECM0JBQO9Axut+LN2vKQGpbw147sm3CkVqZM80etxo
	 NifP+AwCidiFt5k2ZnLoNs9Dn+UxccgOF8wtKCYX18/2A4fesPpruAvu5ucgMnhXZW
	 Jo7+gNAAjTTmPfsvi81PY2tixj6FZSjs8E9/5siTsF3R44QiEIgu34LNQPbxtpnHlM
	 pJBJAHCmfS/B4OmGHY5x0eyTWyJCGU1hLPm/YUlN95iiyCIu8AmkFWUCBl8uqNGbcP
	 SWADUfed6dGcQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2c2ada8264aso5667323fac.2;
        Wed, 07 May 2025 07:56:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDUcpeQL7RRY2hUHVDaw6nQApnZKx7Rq/6y2NF/6NBBLDZ2MMU7WWsvgXJBCN/PGN285g8Szgaaaj9Rh0=@vger.kernel.org, AJvYcCUPT1LxTu3RJAuKV9RUXOFHGcYWFLVb0Q8kUiBEoHdTnHFwHtTztLHMVicpoXU2iIqphu/FPP/vHs4=@vger.kernel.org, AJvYcCV/6kkRluMfkKfEiMQWYLFzCZB/flSA/GeTF1KzICMVZEOKAXuT6cmXKMeTx+ywrxchBS3YR3F+/auEd0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa3Igk1LgHsvCe5cQU2uzO3AimqjZ4Gnb9C2GQ8oYKzN875UM7
	3MKUcn3LY8Q1T+BmuxRIpTAz+zVuPKL13t2T0tFQh41x+IR5VD1CuH0/jzlxX6Gh5j9vGINjXn8
	sPDTtlHAkChhaYOwMG/qsF8H0df0=
X-Google-Smtp-Source: AGHT+IGudK8BYiwNYGu4ohVqJM5tiVLI5ldUeTtWGQTiAMjmIpjqWC1GYXLvzHMYY9hWCYIOoKyMW5g4wmc2N+ZJ3gg=
X-Received: by 2002:a05:6870:1590:b0:2d4:d9d6:c8d2 with SMTP id
 586e51a60fabf-2db5c16ad18mr2234594fac.35.1746629794947; Wed, 07 May 2025
 07:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10629535.nUPlyArG6x@rjwysocki.net> <22630663.EfDdHjke4D@rjwysocki.net>
 <c6cd714b-b0eb-42fc-b9b5-4f5f396fb4ec@nvidia.com> <CAJZ5v0jWTtaQEcx0p+onU3eujgAJpF_V57wzZCuYv2NVnEb7VQ@mail.gmail.com>
 <7c970b02-7b58-4d15-b5f6-18bbfd883ccd@nvidia.com> <CAJZ5v0jcWQ3QKx=2nzDpnYPyGuYfT4TModwdAreWZu4d0hXmoA@mail.gmail.com>
 <CAJZ5v0jG+54uKiY-uSc6B+8JuA6eU1j8tGM5d=XsrT0EmabMeQ@mail.gmail.com> <563657c5-5529-45fd-96fa-bab68ca992a9@nvidia.com>
In-Reply-To: <563657c5-5529-45fd-96fa-bab68ca992a9@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 16:56:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jVOG_u=F36aOVh=qu4Ef-5QFAmC+5-fmF_mU8NSr_LnA@mail.gmail.com>
X-Gm-Features: ATxdqUEcOF86Nme0hytRK5-B0QGEeP-m3_CkCwqx73YWJM7ZH8pajY7lMxQxKns
Message-ID: <CAJZ5v0jVOG_u=F36aOVh=qu4Ef-5QFAmC+5-fmF_mU8NSr_LnA@mail.gmail.com>
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

On Wed, May 7, 2025 at 4:39=E2=80=AFPM Jon Hunter <jonathanh@nvidia.com> wr=
ote:
>
>
> On 07/05/2025 15:25, Rafael J. Wysocki wrote:
>
> ...
>
> >>>> So are the devices in question "async"?  To check this, please see t=
he
> >>>> "async" attribute in the "power" subdirectory of the sysfs device
> >>>> directory for each of them.
> >>>
> >>> I checked for both the I2C controller and ina3221 and don't see any
> >>> 'async' files ...
> >>>
> >>> $ ls /sys/class/i2c-dev/i2c-2/device/2-0040/power/
> >>> autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
> >>> control               runtime_status
> >>> $ ls /sys/class/i2c-dev/i2c-2/device/2-0041/power/
> >>> autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
> >>> control               runtime_status
> >>> $ ls /sys/class/i2c-dev/i2c-2/power/
> >>> autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
> >>> control               runtime_status
> >>
> >> You need to set CONFIG_PM_ADVANCED_DEBUG to see those (and other debug
> >> attributes).
> >>
> >>>> If they are "async", you can write "disable" to this attribute to tu=
rn
> >>>> them into "sync" devices.  I'd do this and see what happens.
> >>
> >> You may also turn off async suspend altogether:
> >>
> >> # echo 0 > /sys/power/pm_async
> >>
> >> and see if this helps.
>
> This does indeed help!
>
> >>>> Overall, it looks like some dependencies aren't properly represented
> >>>> by device links on this platform.
> >>>
> >>> Yes that would appear to be the case, but at the moment, I don't see
> >>> what it is. The ina3221 devices appear to suspend fine AFAICT, but ha=
ngs
> >>> when suspending I2C controller. Exactly where is still a mystery.
> >
> > I checked in the meantime and found that the i2c subsystem enables
> > async suspend/resume for all devices, clients and controllers, so the
> > devices in question are "async" AFAICS.
>
> So that would make sense given that the above works.
>
> When it fails it appears to hang in dpm_wait_for_subordinate() when
> calling dpm_wait_for_children() from what I can tell.

So apparently one of the children has not been suspended yet when this
happens.  That's fine because it should be suspended at one point and
the parent suspend should be unblocked, so it looks like the child
suspend doesn't complete for some reason.

> I will enable the PM_ADVANCED_DEBUG and confirm that making the I2C
> itself non-async works.

What probably happens is that after the "PM: sleep: Suspend async
parents after suspending children" , the i2c clients are suspended
upfront (because they have no children) and when one of them has
suspended, it triggers a parent suspend.  The parent suspend then
waits for the other client to complete suspending, but that cannot
make progress for some reason.

Before that patch, the i2c clients would have suspended only after all
of the "sync" devices following them in dpm_list had been suspended
(the list is processed in the reverse order during suspend), so it
looks like there is a hidden dependency between one of the i2c clients
and a "sync" device.

If the above supposition is right, flagging the i2c client as "sync"
will make the problem go away.

