Return-Path: <linux-pm+bounces-21985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3835DA3311A
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 21:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35273188B281
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 20:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FD4202C3B;
	Wed, 12 Feb 2025 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbrgKPXm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88F81FF5EF
	for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739393712; cv=none; b=hj9TZ3Q0I5SCK+5+IWXHSHdxf1pDQw51XyVkrE1sPDcgua2XstGkASuA11As4RyhKT0BCi1XyKi5rlLGpR6OfA0fQMojJXG4muj71y43WhRNF8v+MOiIK4dgIwSW9bmUiNiT8vf5ilaHuEq5g0af4UTSftcLuo3Ka6OGDHvbxP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739393712; c=relaxed/simple;
	bh=39gu3mTlYdf0v2Eq066/2+uqNCf3JJqMeORR/jt38mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UC5LORwtPTHmQvp2RKG8yl23AZ9+8suFYn0y8ySrplmj649E6O4pyzdt+vygIUxZewhweqY0B2PBgOz26nkOu1/e25WAlXm1rHLbQv2movRxTpv9nFFFr31jxM91M2idRkoKpUUeIBBVCSryXNXp67q0z2+ju4O44MUfmOnPjEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbrgKPXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A209C4CEDF
	for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 20:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739393712;
	bh=39gu3mTlYdf0v2Eq066/2+uqNCf3JJqMeORR/jt38mQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DbrgKPXmSMoPEWlkexKNvUmzO8UEitfnIsPBqglDwLiuxGEX8vqnXG9E2mUyWH6LR
	 a4t3FHSM/Hy8pn/jARf9t9NCJLSbSApeSyMDkleqCmkhafXdN9vKe9zNiRMQ6JC/t9
	 E8xNuOZuwMd340l7WAf24UBIsIPhoVDXF+fEsF/+UYP3hIhIkcz3TgSD17qhUt7YHS
	 +ntQmhAXfogdLwzP7OnK9BJczAKMYmB18jjujlFU1oHOQKphmVkMv5G6gyV3nXmTtW
	 kfDGHTSUdcdC4cT3gTdB2Cmb6Z9B+qcpVjbXvZ+T/grGxF0nuuY7ue5MlUz7Ukh4UY
	 ftfVP+mQb0big==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2b85d1a9091so116576fac.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 12:55:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUsvVletUlnfTPQxSueYG7khoXpmRtiEfgNTtoGHU+yMbvWiC7LBb3LPYfeP2sb/S9zzCqS3ie+MA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnajy6nYLJTkcR++81Cd8J5O4RkdmzbBll/T2CKje+WN9I1mKK
	923GhKGKTpGbPWPpcAMkweh6IE8uqRRnQuSfK0NP3fahODB7WapkrJiQif9LpDOAksBf1fCjasQ
	AC/kzoDV/Bxk9FH1SWqVcS77jo04=
X-Google-Smtp-Source: AGHT+IHAwD1ttfG0K94WAt0e4SFyzmvmei12b3tUpJVQpW2KdKZYMHE1MyIRBpyAa09QT9uoRUo9/N+Db/fvDbHPTzY=
X-Received: by 2002:a05:6871:230c:b0:2a7:d856:94a with SMTP id
 586e51a60fabf-2b8d658f5a6mr2922009fac.22.1739393711449; Wed, 12 Feb 2025
 12:55:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211034423.833783-1-xu.yang_2@nxp.com>
In-Reply-To: <20250211034423.833783-1-xu.yang_2@nxp.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Feb 2025 21:55:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0idzf1QKf8UKp4ttepLbipZD6b1RFHX7QqgQCyJZL8dQg@mail.gmail.com>
X-Gm-Features: AWEUYZmzXzKrtf4Vgah8gs2KBi2oAYO_8oD_R3sVAnvKrRxDR-fQrUwcdBcFTqI
Message-ID: <CAJZ5v0idzf1QKf8UKp4ttepLbipZD6b1RFHX7QqgQCyJZL8dQg@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: core: Set is_prepared to false before checking direct_complete
To: Xu Yang <xu.yang_2@nxp.com>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, stern@rowland.harvard.edu, 
	linux-pm@vger.kernel.org, imx@lists.linux.dev, jun.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 4:43=E2=80=AFAM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> Currently, if power.no_callbacks is true for a device, device_prepare()
> will also set power.direct_complete to true. When device_resume() check
> power.direct_complete, setting power.is_prepared will be skipped if it
> can directly complete. This will cause a warning when add new devices
> during resume() stage.
>
> Although power.is_prepared should be cleared in complete() state, commit
> (f76b168b6f11 PM: Rename dev_pm_info.in_suspend to is_prepared) allow
> clear it in earlier resume() stage. However, we need set is_prepared to
> false before checking direct_complete after including direct complete
> support.
>
> Take USB as example:
> The usb_interface is such a device which setting power.no_callbacks to
> true. Then if the user call usb_set_interface() during resume() stage,
> the kernel will print below warning since the system will create and
> add ep devices.
>
> [  186.461414] usb 1-1: reset high-speed USB device number 3 using ci_hdr=
c
> [  187.102681]  ep_81: PM: parent 1-1:1.1 should not be sleeping
> [  187.105010] PM: resume devices took 0.936 seconds
>
> Fixes: aae4518b3124 ("PM / sleep: Mechanism to avoid resuming runtime-sus=
pended devices unnecessarily")
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  drivers/base/power/main.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 40e1d8d8a589..69d0f9ca7051 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -929,6 +929,12 @@ static void device_resume(struct device *dev, pm_mes=
sage_t state, bool async)
>         if (dev->power.syscore)
>                 goto Complete;
>
> +       /*
> +        * This is a fib.  But we'll allow new children to be added below
> +        * a resumed device, even if the device hasn't been completed yet=
.
> +        */
> +       dev->power.is_prepared =3D false;

Well, not really.

This is to allow new children to be added from a resume callback, but
direct_complete devices are still in suspend at this point.  You can't
make this change for all of them.

You can clear power.is_prepared for devices with power.no_pm_callbacks
set before the dev->power.syscore check, though.

> +
>         if (dev->power.direct_complete) {
>                 /* Match the pm_runtime_disable() in device_suspend(). */
>                 pm_runtime_enable(dev);
> @@ -941,12 +947,6 @@ static void device_resume(struct device *dev, pm_mes=
sage_t state, bool async)
>         dpm_watchdog_set(&wd, dev);
>         device_lock(dev);
>
> -       /*
> -        * This is a fib.  But we'll allow new children to be added below
> -        * a resumed device, even if the device hasn't been completed yet=
.
> -        */
> -       dev->power.is_prepared =3D false;
> -
>         if (!dev->power.is_suspended)
>                 goto Unlock;
>
> --

