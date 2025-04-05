Return-Path: <linux-pm+bounces-24845-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674BEA7C9D1
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 17:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3845B173064
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 15:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C9613B2BB;
	Sat,  5 Apr 2025 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soXIQXuo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5533135957;
	Sat,  5 Apr 2025 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743866113; cv=none; b=UzSOpo7XD1kIUH1W0B53XjjKMklFbWaUZO7x8T/p/jGZDSmGtuXqh2MBY9YCDyuLuMIu4M1FH4Tx5Yd2O+DySRsB7xZQv700EFBBJ0stNJYXfgMsSI5DY7CjMuwLRN+nP0TlcQUeRXmkIvAoMvGCMB5cjex3EeXvVe6otam0HBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743866113; c=relaxed/simple;
	bh=yARVkcdohPfQmnXkIQCzfyOpcF1SCB0AE+9reKP2B20=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXtYHgPvG90sms7ZCJKt2CmI+1BUaRF9UNZHk2nhTERNAQI4tCpcLWo5h8QRuy0A0TqWYKA/RaO/UGaUK9dvBMDAxsFIM1xUR5V9DURSSEdAQh0qMFU59IgafLVu1sIASflhQm5vQHX/tlvA17bm7CwQjhp0hiqqIB0uCW5/C0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soXIQXuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAD4C4CEE4;
	Sat,  5 Apr 2025 15:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743866112;
	bh=yARVkcdohPfQmnXkIQCzfyOpcF1SCB0AE+9reKP2B20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=soXIQXuo0bkqepraJrNrC5lVOcZrYCHP3zd0g0pscbfmxxhg9tHbeBStQkX1s8zjc
	 56glFahxiGSfR3h/lmlmrCP2seJ6RL5uj62tJEaIp7KNEqcqv3Fj5ZThpxiniVUC6b
	 bjqjgt7zdGgkwpchrhqCZ19RSVgmmNbKy3EV6TwicdlBMM+kWjYG1mT5CUQB32P4co
	 gELjnHIk0I0Kx3In7IGlaiiRfRES0YCTZ8uFA9tcbc1svHxQZDJEmH8j1A/NRl2dg/
	 YykIHc9DAc1aYrRadMU/5RBBk/FvuonFyO+WIqRGTp3W2jKpa9qw7+X4a5bmYMeNNy
	 o3mtDAeTe5d3A==
Date: Sat, 5 Apr 2025 16:15:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>, Conor
 Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob
 Herring <robh@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, "Rafael J.
 Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 2/2] thermal: thermal-generic-adc: add temperature
 sensor channel
Message-ID: <20250405161504.6d2cc27d@jic23-huawei>
In-Reply-To: <67659d9d-f228-42ac-b096-01020bf66b7f@arm.com>
References: <20250303122151.91557-1-clamor95@gmail.com>
	<20250303122151.91557-3-clamor95@gmail.com>
	<3bc7c5a5-8fe7-4c4b-a80e-23522922debb@arm.com>
	<CAPVz0n0yvw4kyYKSve9sSZEvcZrCYZ6RqCjFSO5OCqtvRZSfJg@mail.gmail.com>
	<f56596fe-92e8-481b-b15b-29b531eaec32@arm.com>
	<CAPVz0n2ywjm+nLQ+ZAYbR1P6yCr8FQgOMeDT07s_YHZ7xA_6uA@mail.gmail.com>
	<67659d9d-f228-42ac-b096-01020bf66b7f@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Mar 2025 10:04:01 +0000
Lukasz Luba <lukasz.luba@arm.com> wrote:

> On 3/6/25 09:49, Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 5 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 16:37 L=
ukasz Luba <lukasz.luba@arm.com> =D0=BF=D0=B8=D1=88=D0=B5: =20
> >>
> >>
> >>
> >> On 3/5/25 10:06, Svyatoslav Ryhel wrote: =20
> >>> =D1=81=D1=80, 5 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 11:52=
 Lukasz Luba <lukasz.luba@arm.com> =D0=BF=D0=B8=D1=88=D0=B5: =20
> >>>>
> >>>>
> >>>>
> >>>> On 3/3/25 12:21, Svyatoslav Ryhel wrote: =20
> >>>>> To avoid duplicating sensor functionality and conversion tables, th=
is design
> >>>>> allows converting an ADC IIO channel's output directly into a tempe=
rature IIO
> >>>>> channel. This is particularly useful for devices where hwmon isn't =
suitable
> >>>>> or where temperature data must be accessible through IIO.
> >>>>>
> >>>>> One such device is, for example, the MAX17040 fuel gauge.
> >>>>>
> >>>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >>>>> ---
> >>>>>     drivers/thermal/thermal-generic-adc.c | 54 ++++++++++++++++++++=
++++++-
> >>>>>     1 file changed, 53 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/therma=
l/thermal-generic-adc.c =20
> >>> ... =20
> >>>>>
> >>>>> +static const struct iio_chan_spec gadc_thermal_iio_channel[] =3D {
> >>>>> +     {
> >>>>> +             .type =3D IIO_TEMP,
> >>>>> +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),=
 =20
> >>>>
> >>>> I would add the IIO_CHAN_INFO_SCALE and say it's in milli-degrees.
> >>>> =20
> >>>
> >>> I have hit this issue already with als sensor. This should definitely
> >>> be a IIO_CHAN_INFO_PROCESSED since there is no raw temp data we have,
> >>> it gets processed into temp data via conversion table. I will add
> >>> Jonathan Cameron to list if you don't mind, he might give some good
> >>> advice. =20
> >>
> >> I'm not talking about 'PROCESSED' vs 'RAW'...
> >> I'm asking if you can add the 'SCALE' case to handle and report
> >> that this device will report 'processed' temp value in milli-degrees
> >> of Celsius.
> >> =20
> >=20
> > It seems that SCALE is not applied to PROCESSED channel. I can use RAW
> > which would work as intended and I will add a note in commit
> > description why I used RAW. Would that be acceptable?

Indeed. SCALE is only about RAW channels because if they are processed
you have already applied the scale (typically because it wasn't linear)

> >  =20
>=20
> In that case, yes that would be the preferred solution.

I nearly missed this entirely as it was buried in my unfiltered email.
Thanks for the +CC.

Given this is a IIO driver (be it in thermal)
please +CC linux-iio@vger.kernel.org to get review of that part of it.

Note, in general if you do a driver out of subsystem (and there
are good reasons to do that!) please +CC the other subsystem and
maintainers as well. We do that for IIO drivers that have a gpio
chip for instance. I specifically check they are +CC and wait for
an Ack before merging such drivers.

Thanks,

Jonathan


