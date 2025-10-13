Return-Path: <linux-pm+bounces-35965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B76BD3083
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 14:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 181A534BC6E
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 12:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A378257AD3;
	Mon, 13 Oct 2025 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHP6RLDw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E58A261581
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760359567; cv=none; b=uo3YncS+acuNI/20N+iDeGVxcWVvLByhCc/DgCFKz+mwQ+KygvVHKQ+nCXR40AhKoSamlr1xjq66itNz+L9yvaDmrKUQe5tBBQvCurKKC47JgB8845u8J+ec1dEpvgj2aV2XVfCfwGFAiU/H2MoMQ/jbXul9RovZBx419HiNC24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760359567; c=relaxed/simple;
	bh=JpkIi/+vhaU0BNI9/P+j1qfp8E4UfRVJu5ZcRjrM5jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWSygoBtB8uFnvpz24vH0GImGMZ1MYyQyMkXZWesbqlWTrK1YvIn4ogu0vjG+6cPjyuiZlapdtAL6HSVmqtR3X8h9CWuMXzGJOqPFoFQge7bJ+hoB5oURA8Hnfs7ZjdirDmInPmHIPPdu1as12/28t098YwWFdRGzujWySypOzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aHP6RLDw; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-362e291924aso28834961fa.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760359562; x=1760964362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yr0CAioySbg+winRW7SfP2+jGITybsbqsD8lEteT+kw=;
        b=aHP6RLDwb0UG2uPMFu+XHDG3kF+N7eCxd/Ka/asDGgCNbHTIKKuXZSEMQW63BQP5+J
         3Fm3A8yjdNcygmUxPD0dxoBPCRBFCkdQHaIHUNd4JKIu+KlodAf2i8fNXSdsx5WDnfUQ
         ibmWCNbjVfzi9LjChJ/HBXACzVLhWJH7YUypITyzjf0ewOmsgJ1zqTN8R9EHXOK83hvD
         QmEMqLweAgmok12WakNdVjOBQA6AzLEZsHo21wM1PmKh9XgpqQ5RjHHgH7vp5z1TaZDQ
         rWTBZfkyh3L4Spo0aXEFXaJTzAY8C1DU3xjrjlpMIs4U5bxeHGSh+dxJj+9aIbcz2kr6
         XNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760359562; x=1760964362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yr0CAioySbg+winRW7SfP2+jGITybsbqsD8lEteT+kw=;
        b=tL+IDqh6ie/u/LqJ3VrBqKUVXKOdfyhVhfqYVEI0T5sLcV2UVnQmoGuSCfpmYXudHc
         ZgOQQWUn9H+AMy7wQfRjSy0mNNIa5UIkmrHOeLX/KoGLaN1nNDPgNC4CTVCt26udJcUS
         1OFoErFPvAdVgdTK+9/wXKg8twPYI1VC0A3ijE4Yc1LSY3KbuVudUtEObT8Uv/ySJ92Z
         0DTiWdLBrVvON/uKdRK4xg4vuLBwKK38UTVwkcHasiDpLj/iedIDu7GHSN9TWPdlyKq0
         Nwh1gfrGvtPpXwSM3RFkrZA1ciE4JwDEasKwxQ/bSd8cbjoUbeG3wL4LJ35yYVC/GhvP
         UA6w==
X-Forwarded-Encrypted: i=1; AJvYcCX6q9jSdOzgqoAMjJ7P+z0CpfjwU5G/mLSFdp96Qo1DVMdtk6vVpZ755bqerNqKhRyzKchrCKg7Vg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOL0un59yDhUzNEvPnLoXhtnylIAhYRQ47bTpjOi29NL5X1+3
	E1C0FhKNyDobyJUCFkZjCyvHFXU2tIMqqpH2BoNehODM60nKqr18VK5GQXu+o54pzi8emaSPfCr
	64SyNkfi4B5ZuzZM4xP2dF1xjSKh05aFCqr0LrGFNWw==
X-Gm-Gg: ASbGnctaFzOunfuhwgBMOK8Hpp3Qienuu1Kf4UnXpshU/rlQ5L0uy5iUMOctmdjH1rI
	uSp/9WNjGe1ax7TFANPRmXgBiZHo8UvOn2QICBISRBXqXmzmXQx+6YM1IuTrKVrVs6Ub3Pyg+jo
	RwfBY1OxmLzZB94ZhJFDVEoWKeXt8wDlpKOb+kFeslYM8DKzAxNpY3TgF+Qkd7IDUm3YxZ978wf
	Tn0F/xuE7xn/Ce1q2lxemSUWuFMr4QdcGUUqzZ/
X-Google-Smtp-Source: AGHT+IECEgvwWZ6twWsaItTnYS8HV/K8Xbz+foZN6OXGOnnvuhf5OIE7J2dBzITkBTeCj2Oicn8ol15+IVgCGD9o8F8=
X-Received: by 2002:a2e:9a10:0:b0:36a:a401:628a with SMTP id
 38308e7fff4ca-37609cf85d9mr54890731fa.6.1760359562017; Mon, 13 Oct 2025
 05:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759824376.git.mazziesaccount@gmail.com> <19d537f9920cae5fa849b649e5bc42ba0b8e52f8.1759824376.git.mazziesaccount@gmail.com>
In-Reply-To: <19d537f9920cae5fa849b649e5bc42ba0b8e52f8.1759824376.git.mazziesaccount@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 14:45:50 +0200
X-Gm-Features: AS18NWBXkMvQX4UMEqrcFAQn-COI9GhJKLnUY40gmxEPa8GpJstGMsxg8s5ctP8
Message-ID: <CACRpkdbHBQQnnTUrUzOrYxzQKCzDyy8aNK7w8OEFz-ic8ic1FQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] dt-bindings: power: supply: BD72720 managed battery
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andreas Kemnade <andreas@kemnade.info>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matti,

thanks for your patch!

On Tue, Oct 7, 2025 at 10:33=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> The BD72720 PMIC has a battery charger + coulomb counter block. These
> can be used to manage charging of a lithium-ion battery and to do fuel
> gauging.
>
> ROHM has developed a so called "zero-correction" -algotihm to improve

algorithm?

> the fuel-gauging accuracy close to the point where battery is depleted.
> This relies on battery specific "VDR" tables, which are measured from
> the battery, and which describe the voltage drop rate. More thorough
> explanation about the "zero correction" and "VDR" parameters is here:
> https://lore.kernel.org/all/676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohme=
urope.com/
>
> Document the VDR zero-correction specific battery properties used by the
> BD72720 and some other ROHM chargers.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

> The parameters are describing the battery voltage drop rates - so they
> are properties of the battery, not the charger. Thus they do not belong
> in the charger node.

Right!

> The right place for them is the battery node, which is described by the
> generic "battery.yaml". I was not comfortable with adding these
> properties to the generic battery.yaml because they are:
>   - Meaningful only for those charger drivers which have the VDR
>     algorithm implemented. (And even though the algorithm is not charger
>     specific, AFAICS, it is currently only used by some ROHM PMIC
>     drivers).
>   - Technique of measuring the VDR tables for a battery is not widely
>     known. AFAICS, only folks at ROHM are measuring those for some
>     customer products. We do have those tables available for some of the
>     products though (Kobo?).

It would be sad if we later on have to convert it to a standard property
because it turns out to be wider used than we know.

But I buy your reasoning!

> +properties:
> +  rohm,voltage-vdr-thresh-microvolt:
> +    description: Threshold for starting the VDR correction
> +
> +  rohm,volt-drop-soc:
> +    description: Table of capacity values matching the values in VDR tab=
les.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

Which unit is this? Seems to be capacity in % *10?

> +  rohm,volt-drop-high-temp-microvolt:
> +    description: VDR table for high temperature
> +
> +  rohm,volt-drop-normal-temp-microvolt:
> +    description: VDR table for normal temperature
> +
> +  rohm,volt-drop-low-temp-microvolt:
> +    description: VDR table for low temperature
> +
> +  rohm,volt-drop-very-low-temp-microvolt:
> +    description: VDR table for very low temperature

Doesn't the four last properties require to be defined as uint32-array?

> +        rohm,volt-drop-soc =3D <1000 1000 950 900 850 800 750 700 650 60=
0 550 500
> +          450 400 350 300 250 200 150 100 50 00 (-50)>;

This one makes a lot of sense.

> +        rohm,volt-drop-high-temp-microvolt =3D  <100 100 102 104 106 109=
 114 124
> +          117 107 107 109 112 116 117 108 109 109 108 109 122 126 130>;
> +
> +        rohm,volt-drop-normal-temp-microvolt =3D <100 100 102 105 98 100=
 105 102
> +          101 99 98 100 103 105 109 117 111 109 110 114 128 141 154>;
> +
> +        rohm,volt-drop-low-temp-microvolt =3D <100 100 98 107 112 114 11=
8 118 112
> +          108 108 110 111 113 117 123 131 144 157 181 220 283 399>;
> +
> +        rohm,volt-drop-very-low-temp-microvolt =3D <86 86 105 109 114 11=
0 115 115
> +          110 108 110 112 114 118 124 134 136 160 177 201 241 322 403>;

I would have expected something like this, to avoid the a bit fuzzy definit=
ions
of high, normal, low and very low temperature either:

Provide an array of temperatures in millicentigrades (I just guessed
these temperatures, you will know the real ones!):

rohm,vold-drop-temperatures-millicelsius =3D <500, 250, 100, (-50)>;
rohm,volt-drop-microvolt-0 =3D <...>;
rohm,volt-drop-microvolt-1 =3D <...>;
rohm,volt-drop-microvolt-2 =3D <...>;
rohm,volt-drop-microvolt-3 =3D <...>;

Where each array correspond to the temperature, or if you wanna
go all-out custom:

rohm,volt-drop-50-celsius-microvolt =3D <...>;
(...)

So we get the actual temperature in there one way or the other.

> +        rohm,voltage-vdr-thresh-microvolt =3D <4150000>;

This property seems to be missing from the bindings?

Yours,
Linus Walleij

