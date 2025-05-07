Return-Path: <linux-pm+bounces-26831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD607AAE70A
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 18:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB584984B73
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 16:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B0C28C001;
	Wed,  7 May 2025 16:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIbcr997"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C658528A73F;
	Wed,  7 May 2025 16:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746636241; cv=none; b=VowR3TzjAESxNPA4wi8ci/KXtUW8IkG7drgSqBj6HZN1FurSqMTuCCdtDejOrnkDejn3oSK4Dx0dqVpyDl6IcndF0REj0pypISlkqO7oEGPSUM9lihKy3UbEW2n+cAhj7v9M6NRJ2Z52p97DNHmQAzDbHJjX6I3ShonuRN32aVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746636241; c=relaxed/simple;
	bh=hQayM/3arps8OFZndyBTuetjeSGm4oWLGN3OaacHzsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEu/bz0Iah2AfsAVzEk3VrPsVQkPreE29GHCIe84m0/EUArlQ3xJ/sH+j/DeqkAu26CVhRILjQAHB+JJvWsdKSM7kKIw8qa/y1NWVshsBY6cYzRvWD6FNpNFE2SUcgXUet5GJYVB61IKEin5l3qGJJABW/0u9TOo5wvFCXbXIzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIbcr997; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426ADC4CEEE;
	Wed,  7 May 2025 16:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746636241;
	bh=hQayM/3arps8OFZndyBTuetjeSGm4oWLGN3OaacHzsg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vIbcr997NOxUaZzL3r2fMNgRrtu2SmLAU9bbqyVU486LyAF5Vt9aVtE3BemAeBamU
	 WrZcms3djb9b2UlZI44jubC4KqhqUg1VZw6EDqptHZIXIpvAiERy2ZPKKriidV3PJy
	 WH9ElbwPya46W3BbS8l/q9/E8QnQ9Mpbx/UYL5gdItSS7T6QZvRbcIMtiScKGa4tp9
	 2fEkm9+AqULcPj8wma3EzIjKEF2zvM+JxOf29hxBpZWaOYY9RqcJmHd6oaqpnC+hTa
	 PiLms8uFQgopUs+FQKvMDykBNz418QpOV3V0FWecLAOMo3DNFYaNen0ZKimuW9xm9J
	 HYdAwUqpXTBeQ==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72bb9725de1so1550a34.2;
        Wed, 07 May 2025 09:44:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURm0lA2HKjSy4pZyPDuO2gv6QYcCs1gK6rIX9uVmK+AUTK/D1hWiRvOaUbiBdJNIUbT4wkVhTeWtfubGk=@vger.kernel.org, AJvYcCVYllRB6/Q9p6jdF6T7OMMy0H3I71WsqHBfK+74z2o1ydoedRRV3VTFiRuTtlMxIhpa62O5+rjEiXQ=@vger.kernel.org, AJvYcCVy5o30bp+UFreaNzKd1vhu2BYox3tkKJF0cdEXMBOl8W6l6MGTpAX5APirO707Sh05iw9HcBwtdHwCVbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUKXIm6YLNGrMH8+lfFiNsYaQP7pHth8BFqSvSbawGYcCIcx3U
	JL4okSQFqQdCvjp86hH9IUVHlghO/o6iusplagKTJxu8OHtQuwBqvwioHYIeXcbZtPpUJuu0PRw
	Sf80nxfa08heY1CpHxgx0UobGh1A=
X-Google-Smtp-Source: AGHT+IFv7dFSClT0jdc6VOWslTKeyKhH3JKufUFe3bCrITU8x7axmPcp1qmueKPbC5uFgkESjDAakCXCiyVjl5rNZQg=
X-Received: by 2002:a05:6871:205:b0:2d5:b914:fe38 with SMTP id
 586e51a60fabf-2db5c11d7e7mr2370060fac.37.1746636240503; Wed, 07 May 2025
 09:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10629535.nUPlyArG6x@rjwysocki.net> <22630663.EfDdHjke4D@rjwysocki.net>
 <c6cd714b-b0eb-42fc-b9b5-4f5f396fb4ec@nvidia.com> <CAJZ5v0jWTtaQEcx0p+onU3eujgAJpF_V57wzZCuYv2NVnEb7VQ@mail.gmail.com>
 <7c970b02-7b58-4d15-b5f6-18bbfd883ccd@nvidia.com> <CAJZ5v0jcWQ3QKx=2nzDpnYPyGuYfT4TModwdAreWZu4d0hXmoA@mail.gmail.com>
 <CAJZ5v0jG+54uKiY-uSc6B+8JuA6eU1j8tGM5d=XsrT0EmabMeQ@mail.gmail.com>
 <563657c5-5529-45fd-96fa-bab68ca992a9@nvidia.com> <CAJZ5v0jVOG_u=F36aOVh=qu4Ef-5QFAmC+5-fmF_mU8NSr_LnA@mail.gmail.com>
 <b17469ee-0d8c-49ff-8fc8-a3c3cc9964dd@nvidia.com>
In-Reply-To: <b17469ee-0d8c-49ff-8fc8-a3c3cc9964dd@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 18:43:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gMHU71drwOYatFhUcDFKXb9=vTo=JFFYfDabYBdrqWLg@mail.gmail.com>
X-Gm-Features: ATxdqUG3YSgjduoRS5tg6-CwVJusQIah1Hu7j7oHKayAfeUOOTwGp8SzAuKTnLQ
Message-ID: <CAJZ5v0gMHU71drwOYatFhUcDFKXb9=vTo=JFFYfDabYBdrqWLg@mail.gmail.com>
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

On Wed, May 7, 2025 at 5:40=E2=80=AFPM Jon Hunter <jonathanh@nvidia.com> wr=
ote:
>
>
>
> On 07/05/2025 15:56, Rafael J. Wysocki wrote:
>
> ...
>
> > So apparently one of the children has not been suspended yet when this
> > happens.  That's fine because it should be suspended at one point and
> > the parent suspend should be unblocked, so it looks like the child
> > suspend doesn't complete for some reason.
> >
> >> I will enable the PM_ADVANCED_DEBUG and confirm that making the I2C
> >> itself non-async works.
> >
> > What probably happens is that after the "PM: sleep: Suspend async
> > parents after suspending children" , the i2c clients are suspended
> > upfront (because they have no children) and when one of them has
> > suspended, it triggers a parent suspend.  The parent suspend then
> > waits for the other client to complete suspending, but that cannot
> > make progress for some reason.
> >
> > Before that patch, the i2c clients would have suspended only after all
> > of the "sync" devices following them in dpm_list had been suspended
> > (the list is processed in the reverse order during suspend), so it
> > looks like there is a hidden dependency between one of the i2c clients
> > and a "sync" device.
> >
> > If the above supposition is right, flagging the i2c client as "sync"
> > will make the problem go away.
>
> So all the I2C controllers are 'sync' devices ...
>
> $ cat /sys/class/i2c-dev/i2c-*/power/async
> disabled
> disabled
> disabled
> disabled
> disabled
> disabled
> disabled
>
> The I2C clients on the problematic I2C controller are all 'async'
> devices ...
>
> $ cat /sys/class/i2c-dev/i2c-2/device/2-*/power/async
> enabled
> enabled
> enabled
>
> Setting all these to 'disabled' fixes the problem. However, also just
> setting the 'cypd4226' device to 'sync' fixes the problem (the ina3221
> devices seem to be fine being async). The 'cypd4226' device is
> interesting, because this one is a USB Type-C controller and there is a
> circular dependency between the Type-C and USB PHY (see
> arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts).

Circular dependencies are problematic for suspend/resume in general.
I wonder if fw_devlink can resolve this?

> If I make the following change then this does fix it ...
>
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c
> b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index f01e4ef6619d..e9a9df1431af 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -1483,6 +1483,8 @@ static int ucsi_ccg_probe(struct i2c_client *client=
)
>
>          i2c_set_clientdata(client, uc);
>
> +       device_disable_async_suspend(uc->dev);
> +
>          pm_runtime_set_active(uc->dev);
>          pm_runtime_enable(uc->dev);
>          pm_runtime_use_autosuspend(uc->dev);
>
> Is this the right fix for this?

At least as a stop-gap, yes.

In order to enable async suspend for a device, one needs to at least
assume with sufficiently high confidence that it will be safe to
reorder it with respect to any other device in the system except for
the devices having known dependencies on the device in question.
Those known dependencies either are parent-child connections or they
need to be represented by device links.

In this particular case, it is painfully clear that the suspend of the
device in question cannot be reordered with respect to at least one
other device where the dependency is not known in the above sense.

Thus the device in question should not be allowed to suspend asynchronously=
.

Would it be better to represent the dependency in question via a
device link?  Yes, it would, but until that happens, disabling async
suspend is the right thing to do IMV.

