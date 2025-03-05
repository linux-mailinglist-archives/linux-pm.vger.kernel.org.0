Return-Path: <linux-pm+bounces-23486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF945A5028C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 15:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14B01884748
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 14:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D36024E005;
	Wed,  5 Mar 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATZ2mKXs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B918E2356A8;
	Wed,  5 Mar 2025 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185830; cv=none; b=cAHEn3zetcGFVSsKwxezf7M7j0M3E11KvudGtJVKTse6c1+bpUQg/wr/KZfwkJmI+oEg1K9e5mSxSMgaEXnkZaWvEs3Fanw0N7trI3gxGBzHDfp5wpEW6sKCRvrxreMetzvphe2RhLefDdyQ04oXCCNbxdxCUPZDbHBpHpTO470=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185830; c=relaxed/simple;
	bh=+AqUlKzCTWCV8gJp+rDWglTxdmVYfG/0hrgQCsIkfp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6R/j2Fl5MlO4AumtkSTuMWPL72tgvBj9DE+l85ETSe9ZVcANCT14yaaqXONFVjFv2BhSEz2LWnmhvJzVxCFYqtnlK1dQnVRbhwJlTo/8bzNvjcCGQ3VOskxvMRXpLkMYwyvmjiPdUc1CuyMtNzUXr55Kk6yO0onVXNOeQnrYMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATZ2mKXs; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3911748893aso1521345f8f.3;
        Wed, 05 Mar 2025 06:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741185827; x=1741790627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+czHJw0+drcfBudBMvI20HD9M6Zg630DEJar/Aqg1E=;
        b=ATZ2mKXstbBjV2J2Vv2VTF3crdNJREkUeyXxYqkNmmqOwDd1wQV7Ejs/lzQKMWzVQL
         AdgPSNvyIryryHFfwp0C0II04VfyBCwPhFVg1BVPL9ogmfdXRm0zksqbKzOmSFGOuwGn
         OP6FLBfi3HKNFNSDxzLvJnTL+O+6jsiJMPlk1ENZxVdpjGiUVIapJ5HOFGzpIcuScCdu
         +a3Croxy7YnrViM6gxez4RLIufR6/VC8iNPo8UCrutk+hfzOzio7EEE01JXE3ieYJbO4
         7SL86ead/BuKckxwjaMCBjBH6VLr8LaFI/fRB1Nl2oJSLw4dbuaItCyRSXFkt5RLXNhv
         VfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741185827; x=1741790627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+czHJw0+drcfBudBMvI20HD9M6Zg630DEJar/Aqg1E=;
        b=LPM/kI/DphDJ2/L4xvMbfGmc5rTOniTwhvuqExfJrdbjlllfL2c3iV2DfwbS8ZzWIe
         7bHSFu+u+I/mijgL1v+a6M34jTKXIHGAlKj6p6/8JEJC2LT0UG3c83wx1pGDS+8rCfJv
         XKjMDqC8M5gs9w1zyHcPp1i1Sn3+TLWZ2z6QJdD2gXw51SVIpCV89l+BdHPLfv80PgkV
         RfEKd3zT4ZNL2Sa8ldHEDchB/aBqoNMw9nVVsQyU4SmywufUIzyeFr0sh7a9jYqXXLv4
         C6wRt/5SOKtq+n86xMxf+5sUiqGajo8JU/zkkE3OdeP4koIkLwDFbfcn4qvbblU/kQ+H
         EIcg==
X-Forwarded-Encrypted: i=1; AJvYcCUN5gflP5hVEAoklxiY7SYxESiXY9+jRY8NumzIUe3D1zGJp3NqU71sH2rZnMnDzlUfSnRkKEI18KPb@vger.kernel.org, AJvYcCUphpSLa990SwyrzTOd53YhWcJvbuURGH+I7JbQc+7W/0MeV9OaROMU0MuRDGQb8AWMZq2vh8t1H4rAC9sM@vger.kernel.org
X-Gm-Message-State: AOJu0YxslkVIiM8Zhbw8PPZIHfdJUXmMHIRV+WMP/53qOroqvEQwGjxE
	v61puetGAWjgKzlsUK2V5EDdM06p+qMXHspYeQoh+9QBCQtKNtRT0swl+ivKSMvMcLUmfrNt4/4
	oi6D7d5FH3lqdTrYG5dT7GH/K4eo=
X-Gm-Gg: ASbGncvwbwlMw3+dWX6PydCbu45JFC3SrfbopCTCKJpFy9EFw8fPjIlWkScA7RzePcp
	8ez69TisZgpmasR4KQiZdOzAgEjMrWPBgRDtpNRfmfbBr10AleliffTN7tCOVhN0coRsVDC2WfU
	tTGxxej3qhwiyB8QKLI7gbap7n3g0=
X-Google-Smtp-Source: AGHT+IE0Wg93XW7daRT3+XvEJc5G1E0Ewc2aulgOkHuquQ7ry8l0r3PqMhb4dWbor0wlFwrkNcLUG1zinJ4UztxNR90=
X-Received: by 2002:a05:6000:18a6:b0:391:13f7:92ad with SMTP id
 ffacd0b85a97d-3911f764115mr2516233f8f.27.1741185826776; Wed, 05 Mar 2025
 06:43:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303122151.91557-1-clamor95@gmail.com> <20250303122151.91557-3-clamor95@gmail.com>
 <3bc7c5a5-8fe7-4c4b-a80e-23522922debb@arm.com> <CAPVz0n0yvw4kyYKSve9sSZEvcZrCYZ6RqCjFSO5OCqtvRZSfJg@mail.gmail.com>
 <f56596fe-92e8-481b-b15b-29b531eaec32@arm.com>
In-Reply-To: <f56596fe-92e8-481b-b15b-29b531eaec32@arm.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 5 Mar 2025 16:43:34 +0200
X-Gm-Features: AQ5f1JpUpSPyJFPDEyOWhAfjUiTXaiQV-NWZBlTtwhwrqamQpYjovRQ1ribZIWA
Message-ID: <CAPVz0n164wQw1HZ4XVPXyg1w=cwC4-xtqBpgmmE5uKXJtATKmg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] thermal: thermal-generic-adc: add temperature
 sensor channel
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 5 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 16:37 Lukas=
z Luba <lukasz.luba@arm.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
>
>
> On 3/5/25 10:06, Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 5 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 11:52 L=
ukasz Luba <lukasz.luba@arm.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >>
> >>
> >> On 3/3/25 12:21, Svyatoslav Ryhel wrote:
> >>> To avoid duplicating sensor functionality and conversion tables, this=
 design
> >>> allows converting an ADC IIO channel's output directly into a tempera=
ture IIO
> >>> channel. This is particularly useful for devices where hwmon isn't su=
itable
> >>> or where temperature data must be accessible through IIO.
> >>>
> >>> One such device is, for example, the MAX17040 fuel gauge.
> >>>
> >>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >>> ---
> >>>    drivers/thermal/thermal-generic-adc.c | 54 +++++++++++++++++++++++=
+++-
> >>>    1 file changed, 53 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/=
thermal-generic-adc.c
> > ...
> >>>
> >>> +static const struct iio_chan_spec gadc_thermal_iio_channel[] =3D {
> >>> +     {
> >>> +             .type =3D IIO_TEMP,
> >>> +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
> >>
> >> I would add the IIO_CHAN_INFO_SCALE and say it's in milli-degrees.
> >>
> >
> > I have hit this issue already with als sensor. This should definitely
> > be a IIO_CHAN_INFO_PROCESSED since there is no raw temp data we have,
> > it gets processed into temp data via conversion table. I will add
> > Jonathan Cameron to list if you don't mind, he might give some good
> > advice.
>
> I'm not talking about 'PROCESSED' vs 'RAW'...
> I'm asking if you can add the 'SCALE' case to handle and report
> that this device will report 'processed' temp value in milli-degrees
> of Celsius.
>

Sure, I take this into account.

> >
> >>> +     }
> >>> +};
> >>> +
> >>> +static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
> >>> +                              struct iio_chan_spec const *chan,
> >>> +                              int *temp, int *val2, long mask)
> >>> +{
> >>> +     struct gadc_thermal_info *gtinfo =3D iio_priv(indio_dev);
> >>> +     int ret;
> >>> +
> >>> +     if (mask !=3D IIO_CHAN_INFO_PROCESSED)
> >>> +             return -EINVAL;
> >>
> >> Therefore, here it would need to handle such case as well, when
> >> a client is asking about scale.
> >>
> >>> +
> >>> +     ret =3D gadc_thermal_get_temp(gtinfo->tz_dev, temp);
> >>> +     if (ret < 0)
> >>> +             return ret;
> >>> +
> >>> +     *temp /=3D 1000;
> >>
> >> IMO we shouldn't cut the precision if it's provided.
> >> The user of this would know what to do with the value (when
> >> the proper information about scale is also available).
> >>
> >
> > The it will not fit existing IIO framework and thermal readings will
> > be 1000 off. I have had to adjust this since my battery suddenly got
> > temperature reading of 23200C which obviously was not true. With
> > adjustment temperature will be in 10th of C (yes, odd, I know but it
> > is what it is).
>
> Your battery driver should get and check the 'SCALE' info first, then
> it will know that the value is in higher resolution than it needs.
> Therefore, it can divide the value inside its code.
> Your proposed division here is creating a limitation.
>
> You shouldn't force all other drivers to ignore and drop the
> available information about milli-degC (which is done in this patch).

