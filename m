Return-Path: <linux-pm+bounces-26899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8AAAB0223
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 20:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38DD4607FC
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 18:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0502253E0;
	Thu,  8 May 2025 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LM6VZUEW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF5038384;
	Thu,  8 May 2025 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727605; cv=none; b=pe05krgheRuRky32vZNVm/x4gTjTJhh1Z+jQJaUUrSk1pA5jgOGZDO/U0M6k4zpf6opTvp7nQp3Cbh/299Q/j2JlJ7ORoQqd1M852bC5oydt4xZbErek1/GMGEaFd2BgUr7iXWVNLnWnv9Bv3qmX7AwyXD5K7rrNgLRqTxK7PeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727605; c=relaxed/simple;
	bh=AT673/beXh1Iw+NWSwcYovpba3fg3Uqn/BBz/hPfvEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4CMU4CNkUwJyXsKYkWBerzjqTAuWWT6h+fm3GZdZvxgzfqomCSHdmdaXT8DLxWPc7BVwVDiYMiV4Ahq0OzcnG/FsNLPWyWHKfnYteUsHrQr4L4EJRyyBppYcEffocI83Rp4TiVMAekfJUbsdRMygOT0lAaWxGtKOCWogxbra60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LM6VZUEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C5AC4CEF0;
	Thu,  8 May 2025 18:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746727603;
	bh=AT673/beXh1Iw+NWSwcYovpba3fg3Uqn/BBz/hPfvEY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LM6VZUEWarLOmvN11dUkHIZAVIRR/0lBT50i3B1BtVuiDSmPm1OT9Rabd6WeQ4+9c
	 9QPtezlfycYZ9n+i7REbZT1XkgVLcGk/GmkUeg5tT5vOQ+B+TG0axzlz6pTBvzzNTx
	 ekxvjrSzTLcjJZRJxZ5MP06aoKfcpdnB92Sd8X9kmlwF1giUYCf4PU46za9CZ7XA9d
	 aDcumzZReTpJ34Sj6yh5SePTPm8PYXTKYc03PmovpyzcGuAMeXLQlpH88MrmtKvLYd
	 dxXGpgwlgR5SqqpfTpHTlV99XUuC0uLInnDbAlc/Tegij5Hjeeyiz0sN8bkxci92Ze
	 Azgy5tcKacFsQ==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72ecc30903cso732473a34.0;
        Thu, 08 May 2025 11:06:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUX/41teIuvMQM3gTa2C9f2DSgRXtABUMYk1NsAt/9/3nhmt9o0i05mJuELmN0aTgtR685HdmF07pQ=@vger.kernel.org, AJvYcCUfGGbPtt66lkqcZxRItBU394iNuxA1KWVvaMUknai6AdDV6RnLZRWAahdEq0OebAcZ+u+g6jjGBdu0CLU=@vger.kernel.org, AJvYcCWFuQYY27zMonAGqF1/am1c3megWxNVN80uRrlw8dZdDBZBtBJNNLp/Zbne4pQ3VLWn7F26K5Ue/3hkqko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJKEzZ2Vf1aU1oo3hod8W1rAYkgEm0cvET0RGN7F7CIycO4+Zd
	zfVY9z9J6EvZnZpNJRoqDuVzp4UZTUdjjaoASR2ANTwtyBQYGIe9I/GQbPipvnLTvGQLaRhGRDq
	IBWxeJ97ikkrvsFqyJZibGCltRKo=
X-Google-Smtp-Source: AGHT+IGzS7QNq7+HaeTooVtJmyLUF32qMz67Rfq0dA/F8YUy3BlapHyOdQ18btj/Rts/39j11fm208hRejH3SNsO2F0=
X-Received: by 2002:a05:6870:e243:b0:2bc:716c:4622 with SMTP id
 586e51a60fabf-2dba455ac8bmr279543fac.38.1746727602527; Thu, 08 May 2025
 11:06:42 -0700 (PDT)
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
 <b17469ee-0d8c-49ff-8fc8-a3c3cc9964dd@nvidia.com> <CAJZ5v0gMHU71drwOYatFhUcDFKXb9=vTo=JFFYfDabYBdrqWLg@mail.gmail.com>
 <0f7a3738-0b94-4361-a277-c3a90d87aebc@nvidia.com>
In-Reply-To: <0f7a3738-0b94-4361-a277-c3a90d87aebc@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 8 May 2025 20:06:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jSr1t=bEkOO9HJKmxFVf4oY+ij77aHsBeKgL+NpDfmnQ@mail.gmail.com>
X-Gm-Features: ATxdqUHZQwekIOa610qRcHGjQBASmlDhweBXeumeyI6_7h0NqIavIVDj9frv7O8
Message-ID: <CAJZ5v0jSr1t=bEkOO9HJKmxFVf4oY+ij77aHsBeKgL+NpDfmnQ@mail.gmail.com>
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

On Thu, May 8, 2025 at 3:38=E2=80=AFPM Jon Hunter <jonathanh@nvidia.com> wr=
ote:
>
>
> On 07/05/2025 17:43, Rafael J. Wysocki wrote:
>
> ...
>
> >> Setting all these to 'disabled' fixes the problem. However, also just
> >> setting the 'cypd4226' device to 'sync' fixes the problem (the ina3221
> >> devices seem to be fine being async). The 'cypd4226' device is
> >> interesting, because this one is a USB Type-C controller and there is =
a
> >> circular dependency between the Type-C and USB PHY (see
> >> arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts).
> >
> > Circular dependencies are problematic for suspend/resume in general.
> > I wonder if fw_devlink can resolve this?
>
> I booted with fw_devlink=3Don, but this did not resolve the problem :-(

I see, but thanks for checking.

> >> If I make the following change then this does fix it ...
> >>
> >> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c
> >> b/drivers/usb/typec/ucsi/ucsi_ccg.c
> >> index f01e4ef6619d..e9a9df1431af 100644
> >> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> >> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> >> @@ -1483,6 +1483,8 @@ static int ucsi_ccg_probe(struct i2c_client *cli=
ent)
> >>
> >>           i2c_set_clientdata(client, uc);
> >>
> >> +       device_disable_async_suspend(uc->dev);
> >> +
> >>           pm_runtime_set_active(uc->dev);
> >>           pm_runtime_enable(uc->dev);
> >>           pm_runtime_use_autosuspend(uc->dev);
> >>
> >> Is this the right fix for this?
> >
> > At least as a stop-gap, yes.
> >
> > In order to enable async suspend for a device, one needs to at least
> > assume with sufficiently high confidence that it will be safe to
> > reorder it with respect to any other device in the system except for
> > the devices having known dependencies on the device in question.
> > Those known dependencies either are parent-child connections or they
> > need to be represented by device links.
> >
> > In this particular case, it is painfully clear that the suspend of the
> > device in question cannot be reordered with respect to at least one
> > other device where the dependency is not known in the above sense.
> >
> > Thus the device in question should not be allowed to suspend asynchrono=
usly.
> >
> > Would it be better to represent the dependency in question via a
> > device link?  Yes, it would, but until that happens, disabling async
> > suspend is the right thing to do IMV.
>
> OK so it is not clear to me if the PM core should be handling this for
> us.

No, it can't because dependency information is missing.

> Is that what you are implying/suggesting?

No.

Async suspend needs to be disabled for this device for now I'm afraid
and I don't think that it will make suspend/resume take much more
time.

Thanks!

