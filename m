Return-Path: <linux-pm+bounces-26983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AB1AB23A0
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 13:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2B14C14BF
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 11:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734E02561A8;
	Sat, 10 May 2025 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYU85P2B"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430302561A1;
	Sat, 10 May 2025 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746877187; cv=none; b=AOpJi226wRb/UF4y67vpk5U3i1YgR3JLZS0+t4M2Mj9bDKekv4Bw3QynzD3c66IPbL6jcTsM4MOw1UbsBO+fVDIyclXr+pJvrVxCUZsxUMYivhm6LXUJ1oyPqlDF026Nz++5N1tUbQxocwfmsvqPunky9aRYTNvIIVPWqMgM00E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746877187; c=relaxed/simple;
	bh=QpZwWj9tYtN0sZvHD3Qwn0gNE6Td9jqHZ++5XShWvPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NI7y3Psp8OTOIE1MFqJBRcfIf7oZZSr/Nz+Uh2DckqlXr67LmUsGW5FVtgE9D0BJ6tDcyUddg8uAqCQ+dbFFx4nZATE3eAuJUEQPIbWnuujTSpoYkZWnvAVJa2tm64tVOWc7H+95Cl5UyiPUxceKauZ+uRMZCst/pxwkqgVtuFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYU85P2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D94C4CEF2;
	Sat, 10 May 2025 11:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746877186;
	bh=QpZwWj9tYtN0sZvHD3Qwn0gNE6Td9jqHZ++5XShWvPo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tYU85P2BKhm3w/zvJv9+YfLrhMSJeqPPi2uV5dB1s/9bUlrSZG8z7IopglMX9s/jl
	 GeS+hpCzl3n0ABGlM0oFTwrXhc7VF1IPt9+d6q+sf1rFoqDnhIuerABiMGPoV1MBli
	 oKbAKYMyaX2SP1aME6EtmbyI/haj1/+sgjA6V6WfJ5jCUn0hlhdLp/WXxdf5AcmaAs
	 /uJ1f8jATS6RvfMio3inxQxDwAEtdINqriqkjcDzDLbrcMruBElsF9158IfG2xdERp
	 ltFdaqa1u/7vUQcbq4nZp4JYHr5Fz6Z5a4FP8Uf0zL7RJ8c6ETrG0i7Li90A+2rKJD
	 jlSsYueM559gg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-60658e1fedfso1435863eaf.2;
        Sat, 10 May 2025 04:39:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVx4qA/Rs9erQuMvU1pT8OMVYupKQUCWMKF7Lnu0wGKYZMVCAYuXmb1QVGYHry9lSSJdmSD5JQ9mT1la5A=@vger.kernel.org, AJvYcCWsl1AaYz5xUjl0HJI1FCo+nRAtvAUspXXOu3F6D2Ngk5bKx9+22ln1gQ8uZ+BXxhHh0hWeT9Ml0EgtSsY=@vger.kernel.org, AJvYcCXnoRB0ejb3xqy0jbhs5dgcd5+4EgVPnlazWp8bFlsicMaSuAr7wIHI2Mb6KkhhNrJE6HLy55TJM28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw91eVMaWYTHmgVxgE75exRDUuyQGle/P2xXnhplxzTmZO5UdvE
	o8UqjC2+IPLjZ/n6jTgVeL2C12ujAFbSv0PHK991ukfKn+4qsZnj7OXxec8TQ84+mmWBdJQbMma
	hOXnheslTrgJDGLL9gxubN0n4LN8=
X-Google-Smtp-Source: AGHT+IFowrQSFUqwp7UlZesLCMrc8FdmdGffCkX0MR/ANVEEOUjlkkioOdme8ITOHZ1VKxz9p8uxuaPC8rzs+bm6zWk=
X-Received: by 2002:a05:6820:2013:b0:606:361b:52ad with SMTP id
 006d021491bc7-6084b6556d9mr4089022eaf.3.1746877185955; Sat, 10 May 2025
 04:39:45 -0700 (PDT)
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
Date: Sat, 10 May 2025 13:39:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iv-+5Spz8hBn6dNTdmij6XULp+M=oc0kLM96aX+bSwBw@mail.gmail.com>
X-Gm-Features: AX0GCFudp9POWsRB88Wt7e9U_46zIjMRMXgMeZsoILl_pqvxo6k7zrNd9XHF_yM
Message-ID: <CAJZ5v0iv-+5Spz8hBn6dNTdmij6XULp+M=oc0kLM96aX+bSwBw@mail.gmail.com>
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
>
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

I'm going to pick up this patch for 6.16 and add a changelog to it, so
please consider providing a Signed-off-by: tag for this change.

