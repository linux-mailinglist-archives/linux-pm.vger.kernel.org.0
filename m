Return-Path: <linux-pm+bounces-4108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BBB85BA21
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 12:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4912835AD
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 11:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1F0664BB;
	Tue, 20 Feb 2024 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iDGtm6aD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BACE664B0
	for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427785; cv=none; b=YWQwbd1/11mEvp2sVLuLxf7i960oi193Ve2RrEYwNgXWWaKgpu8FDh/pJksiJJ+3ZSFyjB2xQRwtCdeuQ/iglazLLUSdrFcJVU8LiYc4X/ZCafCsOu232ZGHL+f7NAARWm3dMcKlhhPXd9a5iV+S5RlXMI68qmF30dVQQ55QtGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427785; c=relaxed/simple;
	bh=0XEVX7reUloJJ0HXCmKNanytjESGdOW7twiOSY0z6jI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOLkw6HtGMebscwzl+/1lDWqTrfcV+el+eHy/er/MeqaKW7qb8Eff318YHVyOoO4TxFxtYF6tVOvVoiihIa7ltDlHiwl7FDvBT8ivg8mNAFQYYf+HtUvR4ICMjQGdr8LaZRt3HhzYOPx6Q8JWIwuchlg4uBHOhYUGJM4M8eTsl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=iDGtm6aD; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7d5fce59261so3488251241.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 03:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708427782; x=1709032582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TGQQf9QVaNxe+P/ET43bTj+OwzYLCPf9zjW80RckT8=;
        b=iDGtm6aDQFMcDmVljb+fXB1UkYRGIUzBmDrTWX9JQOVFyeXsgoLl4wS9utqR9RV71f
         T+8WHTK/iwqEgTvdFhQudDhLfT4UzAX9vI/v8NGmdEsUnUPLq2PxHkN3IvBa2OGOPVGy
         LLNkNuWZEubob9k5MyrOgCf2GRn6NzxhmvgqGcfhyV5jQlXdpXjJroxrzwveUbhdM2Ay
         otnH9ivwaAR4c8tL84tYyfYHWLmNTDYIFluzKDDitHIJ8viijOpjl5JUOLopdC4YTshI
         RfL7ZXx7mldMdMT3nwydmjVrhK0J1aVXrd/e25JWwSUdFclB4zHERRvw/ru6KwedJ/Ig
         scfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708427782; x=1709032582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TGQQf9QVaNxe+P/ET43bTj+OwzYLCPf9zjW80RckT8=;
        b=WjPSMCGv3YEvh8y514JX6O3WysqaRuJaQiQQfFsjaBlheDsm5XGbbS3EDR/f8a61pQ
         pjZhocPgJ715qY4shGq6pFK/QLfJI+NSt5orJ7st96tnTUnFv+3YCWAZ0MWNVb2oOT8x
         UzzoG570+Wzl/ubBqKGpV0XH9NxzKHcKwRzkvIvTKfJGQBvfFGRajWZP6R1ziy0TgMAO
         iRgu6tARQzQPfn6chbvBIrXQugkUNFCAltKzx5GghsySGadYCKNYWk7YFL+wUVPQly//
         hNhbMFJUSVb42AsJARENB1jsNtqWFBfbXiInnPY5wzp3YXbJK/KjcKh/vtYCZ4aOxGAz
         8wDA==
X-Forwarded-Encrypted: i=1; AJvYcCVdZDJG6Fl9Sw10BR3rcOU/Op/IUPOVfVOxz80nulc20HWyR2Wd8+zcKM5EokU/XtxgY8o1P4+Xx72PW9cDoudmsJSdsff0tmM=
X-Gm-Message-State: AOJu0YwGZzJe1OqlMGSC0hf6bsHfk8N0yBF6JyvL2OsdwOJpQ0J/cVMP
	q5Dsj8WymIPJR66v7llu0yzgSTAzK+hD9kL9tK7UK8ptB9wkeLqErJS/Q0a6DYT63KejuPgSyMO
	hj8KDoPORX2wsSC/FpeIfMpaXwfZMr+90lpJA/A==
X-Google-Smtp-Source: AGHT+IF0CN7Ryol7qmamq7DrWXyYZkwvZgbPRNHrR3nczqiDKiEYYS7aZK8HtFSbIhrDgqTa7oMs3VHOgqV6taESy9U=
X-Received: by 2002:a05:6102:1610:b0:470:51ab:3e46 with SMTP id
 cu16-20020a056102161000b0047051ab3e46mr5334654vsb.30.1708427781847; Tue, 20
 Feb 2024 03:16:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-10-brgl@bgdev.pl>
 <48164f18-34d0-4053-a416-2bb63aaae74b@sirena.org.uk> <CAMRc=Md7ymMTmF1OkydewF5C32jDNy0V+su7pcJPHKto6VLjLg@mail.gmail.com>
 <8e392aed-b5f7-486b-b5c0-5568e13796ec@sirena.org.uk>
In-Reply-To: <8e392aed-b5f7-486b-b5c0-5568e13796ec@sirena.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 20 Feb 2024 12:16:10 +0100
Message-ID: <CAMRc=MeAXEyV47nDO_WPQqEQxSYFWTrwVPAtLghkfONj56FGVA@mail.gmail.com>
Subject: Re: [PATCH v5 09/18] arm64: dts: qcom: qrb5165-rb5: model the PMU of
 the QCA6391
To: Mark Brown <broonie@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 8:59=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Mon, Feb 19, 2024 at 07:48:20PM +0100, Bartosz Golaszewski wrote:
> > On Mon, Feb 19, 2024 at 7:03=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
> > > On Fri, Feb 16, 2024 at 09:32:06PM +0100, Bartosz Golaszewski wrote:
>
> > > > +                     vreg_pmu_aon_0p59: ldo1 {
> > > > +                             regulator-name =3D "vreg_pmu_aon_0p59=
";
> > > > +                             regulator-min-microvolt =3D <540000>;
> > > > +                             regulator-max-microvolt =3D <840000>;
> > > > +                     };
>
> > > That's a *very* wide voltage range for a supply that's got a name end=
ing

Because it's an error, it should have been 640000. Thanks for spotting it.

> > > in _0_p59 which sounds a lot like it should be fixed at 0.59V.
> > > Similarly for a bunch of the other supplies, and I'm not seeing any
> > > evidence that the consumers do any voltage changes here?  There doesn=
't
> > > appear to be any logic here, I'm not convinced these are validated or
> > > safe constraints.
>
> > No, the users don't request any regulators (or rather: software
> > representations thereof) because - as per the cover letter - no
> > regulators are created by the PMU driver. This is what is physically
> > on the board - as the schematics and the datasheet define it. I took
>
> The above makes no sense.  How can constraints be "what is physically on
> the board", particularly variable constrants when there isn't even a
> consumer?  What values are you taking from which documentation?
>

The operating conditions for PMU outputs. I took them from a
confidential datasheet. There's a table for input constraints and
possible output values.

And what do you mean by there not being any consumers? The WLAN and BT
*are* the consumers.

> The cover letter and binding both claimed (buried after large amounts of
> changelog) that these PMUs were exposing regulators to consumers and the
> DTS puports to do exactly that...
>

Yes, but I'm not sure what the question is.

> > the values from the docs verbatim. In C, we create a power sequencing
> > provider which doesn't use the regulator framework at all.
>
> For something that doesn't use the regulator framework at all what
> appears to be a provider in patch 16 ("power: pwrseq: add a driver for
> the QCA6390 PMU module") seems to have a lot of regualtor API calls?

This driver is a power sequencing *provider* but also a regulator
*consumer*. It gets regulators from the host and exposes a power
sequencer to *its* consumers (WLAN and BT). On DT it exposes
regulators (LDO outputs of the PMU) but we don't instantiate them in
C.

Bart

