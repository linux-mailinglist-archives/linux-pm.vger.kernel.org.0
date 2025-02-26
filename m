Return-Path: <linux-pm+bounces-23015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8349CA4677A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 18:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0839C175D72
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 16:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEE8221DA0;
	Wed, 26 Feb 2025 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyWLVNOg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87F421E082
	for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588973; cv=none; b=hEiX65h9f7y7Qq4T40xcOEsdhXTKgmxwqyVNEvujEj+NF01ANndigemDzynJ8YERBL17GJhgViaKO16D1ll+ul27S/od48WOu1Jwjby26Tx55rHHqNrJyViq7G9UHZhwedhx6GMra83r1kN/d/hYKixdU+pFd1T23rC7oN+kCVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588973; c=relaxed/simple;
	bh=e/e6uDD2H1sZumsUBc8WfzpCmedKf1Cjo2LfktnMCRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbhCOW+PyxwzaIWD4c7mcen3WSsabStaQ9dot4/Fhn2W2JTTbUTbqU5/mN64y9I2Sn7A1TthTXMgTxyLaSV5JDcGZSiMEvGMtMW2EPCzLCKyDItaKCmzsc4vePy3H4VPVQuPjlbr1LuvxySMWLoz4ClUNOyWBkzKQszlCEjN2xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyWLVNOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607B0C4CEEB
	for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 16:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740588973;
	bh=e/e6uDD2H1sZumsUBc8WfzpCmedKf1Cjo2LfktnMCRA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VyWLVNOgXqfOFWRVBDYGVyG6AHQcqYYt+vShgQQEJOb98YnI4l363YHrG6+2oaExi
	 Ly1cg3TSEVcJaGExC4xfDxDqfMlix1ytwNl3y9s3JfbhLH3TpphUvNcEEquVUcGlE2
	 +rcKFFtfb80KzDo6rJwKOoZexU0dG3JuvCOM423ZMb5iuH7+rnv+h+sy0Sqjel4Esr
	 vwab6mVIYN/ohltRch9rzVz/qYXmWUehwbSiyK4ilhCTvyt2wGwiHtPgewmXesfDw+
	 FVGbOdwDEthRq5Uw/g2FuOz8DnzkRAadf1xZcHNtAd8SIsbhrbFDehKF6ti4XGvvU6
	 iLyuEgtHv29ZA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2bca6017608so58814fac.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 08:56:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXSguxgPSl803HFny7D53nyCUYeA7NKYcnj95qY7tljEM8GJ7N6Svn3dHc919wZLnKLHUoJlsjaqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUTSmwp8uwV+ST9QcAx/WTSQvt2tfWQDBbpFbHy5Ea01irSvkv
	P7Rt3kSyGMya42os2iEH8cSee6vuqwol5QcY+OFqn8FIxTsGVNEoYi3vxz4sUVBmfIDmn3bW9AO
	3mW0sA93tkp/Ah/ntBZnUJEDQHU8=
X-Google-Smtp-Source: AGHT+IF8FVsLXXUPxrruZDj/6g3EXfBpP3hVZ7yd8KRhKSwXfZSR7MfVe1OoSJUCVlzqKz497AUQLbP+08IJXDTtt6s=
X-Received: by 2002:a05:6870:ff8a:b0:29e:569a:f90d with SMTP id
 586e51a60fabf-2c13079f269mr2549885fac.32.1740588972588; Wed, 26 Feb 2025
 08:56:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224070049.3338646-1-xu.yang_2@nxp.com>
In-Reply-To: <20250224070049.3338646-1-xu.yang_2@nxp.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Feb 2025 17:56:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g1xMRk6B=C9QnFDMFwHgBABkNmr09USBFfHSo1HjyA1Q@mail.gmail.com>
X-Gm-Features: AQ5f1Jo5mT_bF083RcgF_jcoM9zxH-ADxDFNC7YVSguWdIL3Mwl7v1iWSw68ZPs
Message-ID: <CAJZ5v0g1xMRk6B=C9QnFDMFwHgBABkNmr09USBFfHSo1HjyA1Q@mail.gmail.com>
Subject: Re: [PATCH v3] PM: sleep: core: Clear is_prepared if both
 no_pm_callbacks and direct_complete is set
To: Xu Yang <xu.yang_2@nxp.com>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, stern@rowland.harvard.edu, 
	linux-pm@vger.kernel.org, imx@lists.linux.dev, jun.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 7:59=E2=80=AFAM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> Currently, if power.no_callbacks is true for a device, device_prepare()
> will also set power.direct_complete to true. When device_resume() check
> power.direct_complete, setting power.is_prepared will be skipped if it
> can directly complete. This will cause a warning when add new devices
> during resume() stage.
>
> Although power.is_prepared should be cleared in complete() state, commit
> (f76b168b6f11 PM: Rename dev_pm_info.in_suspend to is_prepared) allow
> clear it in earlier resume() stage. However, we need also set is_prepared
> to false if both power.no_callbacks and power.direct_complete are true.
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
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
>
> ---
> v3: combined checking no_pm_callbacks and direct_complete
> v2: clear is_prepared before check syscore as suggested by Rafael
> ---
>  drivers/base/power/main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index dffa2aa1ba7d..b9b1fd43427d 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -930,6 +930,13 @@ static void device_resume(struct device *dev, pm_mes=
sage_t state, bool async)
>                 goto Complete;
>
>         if (dev->power.direct_complete) {
> +               /*
> +                * Allow new children to be added in the resume stage for
> +                * devices with no PM callbacks and can be completed dire=
ctly.
> +                */
> +               if (dev->power.no_pm_callbacks)
> +                       dev->power.is_prepared =3D false;
> +
>                 /* Match the pm_runtime_disable() in device_suspend(). */
>                 pm_runtime_enable(dev);
>                 goto Complete;
> --

Applied as 6.15 material under a new subject and with edits in the changelo=
g.

Thanks!

