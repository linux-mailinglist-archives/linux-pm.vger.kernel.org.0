Return-Path: <linux-pm+bounces-5434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D36988C964
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 17:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCA41F262AE
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 16:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEC72F5E;
	Tue, 26 Mar 2024 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tbx9eszl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38BEF9EB
	for <linux-pm@vger.kernel.org>; Tue, 26 Mar 2024 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470790; cv=none; b=thRFrI2AICHguEJ3d9R4hH8kQkzZf5UjSPDoLWbzWO+1K8pjiWq9Otg6Y6cVDZnUwmK1VFjapf62k9iEMf/iOSvLb/LUAGiEo5oYFVl6RNg7ZeSGjsW8qDKh0VxmGHuMInDwQxn8LZokc2Yhuj59J7qHkzmzDmUylSvy9MQwiwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470790; c=relaxed/simple;
	bh=lVoQMVplppCC3bZfzFJMPRwm9a5E9DObxpQyJv4ei/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9IcnUHAKA070wFM+cMWLsC1+wD2iCk8YCFs1OUTBLS3iYKU+wXmbohXrUzWxuCCEblmbJ5Mi9YJO9ZSF1fXgYkm1fnPshIrT36lwPfi8X+6piC4O2zbnADDYkzhtyZj8fzE5c7RyaokmGp/z5oqMVBnJNbhty0lTemFBYm3TIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tbx9eszl; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d4979cd8c8so59435551fa.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Mar 2024 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711470787; x=1712075587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQ6jS2CUTKGhZdxpuXUPTr0agZibBpPyyI13tXK5e6s=;
        b=tbx9eszl0cv3hSGR2z5T1MUqNEFMqOK0hvuUXK4rky/ZLiX7/ruc4w35Wa6enxWLhy
         jqYTQ6baqOYwBEPfw8EyZsa1IaqSg7IlHG+YqWDCCA0rIkEN94Vbs5U6ww3v89vN1w1I
         0nqGzNdcCZSF0zAp6TSiu46brej3P99kOXNi4PRIAzaw0yMELlRpmcXliW4+4QxY+LtV
         O8xrYDYrVS4Up40ecp8dyuj/sICiqnVfBNZVkxQg6hmXUnZFDaK/qkfK7cpzxGt63mcL
         eZAhX6x/1ghz8UjnhKhvM95t5Bgtrh5YH7RDfBvymF0vUdIjbVmyPCYnXR5AfFfD5PYR
         BD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711470787; x=1712075587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQ6jS2CUTKGhZdxpuXUPTr0agZibBpPyyI13tXK5e6s=;
        b=dN786SwjxFt8is75kSIFu5tw1Cpetpl7SfUXTUS8XspUsg7fvMEL3bosReFuf3PH+v
         Rw8oVGKNZzAopKnPM0od198/mmv6syyc/zRoHMdCkPXLFmN/aS3b4bgEd8D4Za+82FaV
         FA4JOOgJaOfZ3PpxZmOZMyBl8bXvFX8xHCYKmpObopLw0mk7OPXOYYgURwSrNjRGGoUU
         x/G7KersLyiJytckaQPPk33PbXI+CK46Z7L+auuJ2M8F5QmLd5K89iriIs4zj0CtIG30
         TSULO/90KoVHIplMka2ExDvawFRiYfwTD8EoQxmeAF96xADLAgicSMWahSSBDvoFV6U9
         610A==
X-Forwarded-Encrypted: i=1; AJvYcCU9bXJF1m0rdgAPWi4oGYPoVpY+Oepbm2sRz0bkjZwKHGkbaG1G04SE8TO0Bpgx+x22KJMURKk/c1zFtwyByy2f86v6/dWc4Ig=
X-Gm-Message-State: AOJu0YxqIMjmTBdPD0WItkRgOpWJMv7I08cvW/FIGHnJZ83pbggSZumZ
	+Se0SF3VQxVxX/Af21q5eQronpC88KKnX7KgAZuxgYAd2QeuKPWkHZ0fFT/mL7yrPih4HTEh3Yj
	1zY4RaEqwiTvwFdphPTsc/R1xPA3nBdoDo3g/Cw==
X-Google-Smtp-Source: AGHT+IEPlW3Mndd9DAskKl8BnO4uLoQgb2fvBGrOQCORYGpNt3ZO7pjyZJGUAGM4Jnm65aupzhhwN4AXLf4B/UzV5SQ=
X-Received: by 2002:a05:651c:210b:b0:2d2:4477:6359 with SMTP id
 a11-20020a05651c210b00b002d244776359mr800282ljq.7.1711470786783; Tue, 26 Mar
 2024 09:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325131624.26023-1-brgl@bgdev.pl> <20240325131624.26023-5-brgl@bgdev.pl>
 <87r0fy8lde.fsf@kernel.org> <CAMRc=Mc2Tc8oHr5NVo=aHAADkJtGCDAVvJs+7V-19m2zGi-vbw@mail.gmail.com>
 <87frwe8jiu.fsf@kernel.org> <CAMRc=MdCv+vTMZML-wzRQqZZavquV3DABYM4KYw-HwqS47sTyw@mail.gmail.com>
 <874jct10yf.fsf@kernel.org>
In-Reply-To: <874jct10yf.fsf@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 26 Mar 2024 17:32:55 +0100
Message-ID: <CAMRc=Me5ef_kFDz0SyGZb4S+2Ma4i=Fek_tzwj+bYD4DGSV4mA@mail.gmail.com>
Subject: Re: [PATCH v6 04/16] dt-bindings: net: wireless: qcom,ath11k:
 describe the ath11k on QCA6390
To: Kalle Valo <kvalo@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
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
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, ath11k@lists.infradead.org, 
	Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 4:12=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> >> >> I don't know DT well enough to know what the "required:" above mean=
s,
> >> >> but does this take into account that there are normal "plug&play" t=
ype
> >> >> of QCA6390 boards as well which don't need any DT settings?
> >> >
> >> > Do they require a DT node though for some reason?
> >>
> >> You can attach the device to any PCI slot, connect the WLAN antenna an=
d
> >> it just works without DT nodes. I'm trying to make sure here that basi=
c
> >> setup still works.
> >>
> >
> > Sure, definitely. I there's no DT node, then the binding doesn't apply
> > and the driver (the platform part of it) will not probe.
> >
> >> Adding also Johan and ath11k list. For example, I don't know what's th=
e
> >> plan with Lenovo X13s, will it use this framework? I guess in theory w=
e
> >> could have devices which use qcom,ath11k-calibration-variant from DT b=
ut
> >> not any of these supply properties?
> >>
> >
> > Good point. I will receive the X13s in a month from now. I do plan on
> > upstreaming correct support for WLAN and BT for it as well.
> >
> > I guess we can always relax the requirements once a valid use-case appe=
ars?
>
> I think we have such cases already now:
>
> $ git grep ath11k-calibration-variant -- arch
> arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts:     qcom,ath11k-calib=
ration-variant =3D "Fairphone_5";
> arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts:              =
       qcom,ath11k-calibration-variant =3D "LE_X13S";
>
> But please do check that. I'm no DT expert :)
>

You're thinking about making the required: field depend on the value
of qcom,ath11k-calibration-variant? Am I getting this right?

Bart

