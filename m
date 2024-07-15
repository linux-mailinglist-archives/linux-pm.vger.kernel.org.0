Return-Path: <linux-pm+bounces-11098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9B79312F7
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 13:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996231F20FFD
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 11:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCFD16E877;
	Mon, 15 Jul 2024 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+hffJTs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4343227442;
	Mon, 15 Jul 2024 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042483; cv=none; b=tHJbQU7Eo2jIoGCiVnKj6CLP5W1vaAD14dRdGOkunzDyGRFpi0wDlelFj69JmYHubjoMZ5r7ghApfn0SIw2rsomltiJL14duiuAr+3buhO6QIx9/xlinushfyVOBomaoZr/Glpw93WfzhENdCQWa1uXHV0m6xwdXTUY9WjrPjLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042483; c=relaxed/simple;
	bh=xSPxuQs3YCL7Fk/LevmqfVSN52LSdVUw1qan0QLmPco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTEqC7eCPyfXkuK7W12CXLT3eQIE+vu28UrXC+Rb84fbwNnhAOsNL0pGZuI9rHPwnOhZtTau1AlBahKaqTb9VTspThtqaAMNu/8rgkCr6l9nBxExBdtfBM28IqpYH2GtDygujscE7suNAV55TfRQbaOePlTJb2bajbKg8bksLos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+hffJTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FF3C4AF0F;
	Mon, 15 Jul 2024 11:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721042483;
	bh=xSPxuQs3YCL7Fk/LevmqfVSN52LSdVUw1qan0QLmPco=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K+hffJTsUblKYtgrbnQGoRm7fycgwx9x8tdnufv0A2AnHO29o7ltvA+nyqrXV4yEV
	 wcs0mIEjXApwBbEcSdg4ee90U5CLe+UnAR0parU5PXa/Ae2/fxPm4DnXgO39lDuByc
	 8dYlofq/Hb9vWkGMswmEkizzYtvNXnXpP8QKB9zcgseKEnH5Jinn2xP+AMmxQ5He6f
	 1rWYwGMqqW+cluGVgDZyeyrYPLSsoYmgnwBTjBqHkVN/gtLWt4Kzgc8TSv1zAWw7Zz
	 DtTvjh1sG44jyVPJaMDqzPfbgAkT3LNyuD6AqkUH52kkAHZattmsNwFVsDxuU+3oxZ
	 /xYaFoJwi5hAw==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d9dd8bc70dso396895b6e.2;
        Mon, 15 Jul 2024 04:21:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXaWizu1jQlA/qgO6cU70KbeIIWkzSpQn8AEI7VCgKS6BgO/xq+YSnd4FoqH+zKFJ64R1SKvAjXvUPigsMr3rD4VHxfcEgDL8A9IjeP6JtrUV9qE/sGLHqKxUYJlDqAefrwvKDxJ2E=
X-Gm-Message-State: AOJu0YxEzv2ZLhdNH/pT/MYie4kevrFRJEM6ZDMb3naqzlLXlYbsSxlY
	E6HPtAT5Ex22yahX8gMiFEl29Eus16hAsWq6WpcdykSkeglLXm2JGqtluI4y2VeQd+aUJiGAgOe
	H2iXMR8Jctd4LqsSqBnc4LUiHI5k=
X-Google-Smtp-Source: AGHT+IGGFyx0gkRYa/1bS2DCMCLQn+4THVLOBxOkP1F1xPABGb6t61BRJGSdhtuHZO9jXlany+YE8DBzGpoMUpyvWy0=
X-Received: by 2002:a05:6871:5d1:b0:259:f03c:4e90 with SMTP id
 586e51a60fabf-25eaec7b6a5mr17293569fac.4.1721042482401; Mon, 15 Jul 2024
 04:21:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6064157.lOV4Wx5bFT@rjwysocki.net> <20240715044527.GA1544@sol.localdomain>
 <4d7e11a7-b352-4ced-acee-b5f64e3cd0b6@linaro.org>
In-Reply-To: <4d7e11a7-b352-4ced-acee-b5f64e3cd0b6@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Jul 2024 13:21:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gx6GyKBYt7YMFwmUQ4OCG49d9k2H=P-4Awr-mJ=eFHKw@mail.gmail.com>
Message-ID: <CAJZ5v0gx6GyKBYt7YMFwmUQ4OCG49d9k2H=P-4Awr-mJ=eFHKw@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eric Biggers <ebiggers@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Stefan Lippers-Hollmann <s.l-h@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 11:09=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 15/07/2024 06:45, Eric Biggers wrote:
> > Hello,
> >
> > On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael J. Wysocki wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> Commit 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip()
> >> if zone temperature is invalid") caused __thermal_zone_device_update()
> >> to return early if the current thermal zone temperature was invalid.
> >>
> >> This was done to avoid running handle_thermal_trip() and governor
> >> callbacks in that case which led to confusion.  However, it went too
> >> far because monitor_thermal_zone() still needs to be called even when
> >> the zone temperature is invalid to ensure that it will be updated
> >> eventually in case thermal polling is enabled and the driver has no
> >> other means to notify the core of zone temperature changes (for exampl=
e,
> >> it does not register an interrupt handler or ACPI notifier).
> >>
> >> Also if the .set_trips() zone callback is expected to set up monitorin=
g
> >> interrupts for a thermal zone, it needs to be provided with valid
> >> boundaries and that can only be done if the zone temperature is known.
> >>
> >> Accordingly, to ensure that __thermal_zone_device_update() will
> >> run again after a failing zone temperature check, make it call
> >> monitor_thermal_zone() regardless of whether or not the zone
> >> temperature is valid and make the latter schedule a thermal zone
> >> temperature update if the zone temperature is invalid even if
> >> polling is not enabled for the thermal zone (however, if this
> >> continues to fail, give up after some time).
> >>
> >> Fixes: 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip()=
 if zone temperature is invalid")
> >> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> Link: https://lore.kernel.org/linux-pm/dc1e6cba-352b-4c78-93b5-94dd033=
fca16@linaro.org
> >> Link: https://lore.kernel.org/linux-pm/2764814.mvXUDI8C0e@rjwysocki.ne=
t
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > On v6.10 I'm seeing the following messages spammed to the kernel log en=
dlessly,
> > and reverting this commit fixes it.
> >
> >      [  156.410567] thermal thermal_zone0: failed to read out thermal z=
one (-61)
> >      [  156.666583] thermal thermal_zone0: failed to read out thermal z=
one (-61)
> >      [  156.922598] thermal thermal_zone0: failed to read out thermal z=
one (-61)
> >      [  157.178613] thermal thermal_zone0: failed to read out thermal z=
one (-61)
> >      [  157.434636] thermal thermal_zone0: failed to read out thermal z=
one (-61)
> >      [  157.690774] thermal thermal_zone0: failed to read out thermal z=
one (-61)
> >      [  157.946659] thermal thermal_zone0: failed to read out thermal z=
one (-61)
> >      [  158.202717] thermal thermal_zone0: failed to read out thermal z=
one (-61)
> >      [  158.458697] thermal thermal_zone0: failed to read out thermal z=
one (-61)
> >
> > /sys/class/thermal/thermal_zone0/type contains "iwlwifi_1".
>
> Does the following change fixes the messages  ?
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> index 61a4638d1be2..b519db76d402 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> @@ -622,7 +622,7 @@ static int iwl_mvm_tzone_get_temp(struct
> thermal_zone_device *device,
>
>         if (!iwl_mvm_firmware_running(mvm) ||
>             mvm->fwrt.cur_fw_img !=3D IWL_UCODE_REGULAR) {
> -               ret =3D -ENODATA;
> +               ret =3D -EAGAIN;
>                 goto out;
>         }
>
>
> --

It would make the message go away, but it wouldn't stop the useless
polling of the dead thermal zone.

I think that two things need to be done:

(1) Add backoff to the thermal core as proposed previously.
(2) Make iwlwifi enable the thermal zone only if the firmware is running.

