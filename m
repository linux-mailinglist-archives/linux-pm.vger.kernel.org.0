Return-Path: <linux-pm+bounces-29813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37FFAED374
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 06:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61C83B3980
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 04:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4068615CD74;
	Mon, 30 Jun 2025 04:32:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81B979D2;
	Mon, 30 Jun 2025 04:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751257974; cv=none; b=cmdGzJXfxT3xrLEjmKNl1oPB0zRd5Vb9RUTMIMD9im0Q7pkcQI3fu7UIBZE4T/ExMMxkttOq6dnsaRnX6kEx1Y3MVcbJ/qniFu4sf51s5Qiqhp3B/xJ/hzITVz9ePCiM67h6YUIVn2hFgC3V5YoOxKYRxRZKQt4UDcW44TCGPRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751257974; c=relaxed/simple;
	bh=R7zcCovUjtiZyN7Xl7zbfCp3HhGk37QNCfMdhJI4qQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OV+mY8GedZfAKrwTjFMRBeOPqRHLEsGOaTH1A6WqRNDwn/6O827lX07sFLffQAodm2M+FYXEL1yWgHtOPqzSqSy5yHyadKVcoppU7nsjd22W6Olai425HvtokStPTu3t17G8Lec8sUooXXfbbkmM0OqsPHo0zDbVOWLj7U49XkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32b3a3a8201so14738541fa.0;
        Sun, 29 Jun 2025 21:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751257967; x=1751862767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JbVuaR12V0J6Xt+/G9MNTrnfxERz+sAIcOpg6dKC95Y=;
        b=g7lYg6hEQlzmpjzLwyTFmK5b3Ept/6Shb6y8yNBvP/qoYV4LFkIr+9KfQN7OobyZUG
         /ipj2sy2fyOhajpoASKi5v59K/xXXaqNcm5tBEBqAURBue1cu3vwp6fQgTLueMQoT2ho
         /vqlycc2zMlbxdSXnqqhabivTNKyFH9BP7RHglXx4lCHiOSUunMMdUhcZ1zAhcrbosqO
         H7gqZvHqLh94MvTd/kj1ry7fpcgtVHhI+5f0/XvM8X6/Sdxsh8SiM6HyISeUIYBlfTAT
         2o/gNugfDQFBhLZDEq8s5MqtrZhoZD7hgkdvPyTLl4F/tIQFrfRXXiGDwa5hwuVzZR0a
         F07w==
X-Forwarded-Encrypted: i=1; AJvYcCVLBtio+K2tWGARYXFzZokIlGVDVdDbA59lIQGavccU+F0eTrOhLDMG1eDLLq9yzROzoOl6uHnzBUHj@vger.kernel.org, AJvYcCVTAJ/EJTTPBMvoWpHjuxxzghNbGUVmRNIRAxrYtM4YkB/X5X6i1GSyvhhZZc2wxxLw94F7JuuO3to=@vger.kernel.org, AJvYcCVec/tIvmXz8paN+1fIX8CPNp4REjtZdb7SA17p9cp0IWqdlBQQ3BbNwsbN8b7DP1Vd9hcFCf2IcJQPQhI5@vger.kernel.org
X-Gm-Message-State: AOJu0YzpsRyEp3BiR/Spou8vel96MnvCXdIiitiX85dYBAdm96w7Cx/u
	q1D9sWtQtAlH7zuPBRVlpEnou1etWsDQCdYSHNC7/JxdJBwPTAxQYEaymn+ZDiDs
X-Gm-Gg: ASbGncuYaGAkaYfwu6YhYWYfyEA76hepsFHJfmeFt8VJXXIC83iagH5wgerd+XOqNqh
	PJmRDUj6/4TD/Wc79Ib9lNGtkL+1bCs4a6J2SmM0/R48QGmqLqZaGzoGMVpc9Z8V4vPwzsrbuiw
	OyrNddJTviOipdGJtpUqqnzT5lIAONLr6RtBlDidcfRt1ZYxiqZo5IjaEGFZQeiXr9t7ue6bTYa
	4dOQapcGb1vWoUuz0lz83pi0Rjq0cC+r+3/e3t0KxdbF9k4kKT7MRKb4SN2NapjzM0z05XZsGsE
	ALIoXa40UWjjFwAvdO5a3n+0Feg3Vtc23mDkQ0PbmGAfleUTzDKkyIwaLpUsMZ/i8SG2pC5eBdj
	8h+SniLoNzCrJ7YORLQ4=
X-Google-Smtp-Source: AGHT+IHka60/fjRwCxsDIPnM9RNanmC9+SlPaHmhUHvYwouRWRyMWrT5ocMruSmQjcoM6MLq0ZhSUg==
X-Received: by 2002:a05:6512:b87:b0:553:30fc:ceda with SMTP id 2adb3069b0e04-5550b7e6e32mr3341855e87.7.1751257967114;
        Sun, 29 Jun 2025 21:32:47 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2f327dsm1284388e87.257.2025.06.29.21.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jun 2025 21:32:45 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32add56e9ddso15704801fa.2;
        Sun, 29 Jun 2025 21:32:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHYVQseElP3rXd7AySTgeFqHcdbukMhKhyZx3wGgBZi4AjtGgh2A7HbllxIjJjjNEiOzLcZASy9lc=@vger.kernel.org, AJvYcCUbOmA9R+rcBYTALi9JJYTB1yIMrPdTZ4TRSFKAYQI/LP+Jp+lwczjU2GYwE4W2wFwcEJrEDWcLM9oo@vger.kernel.org, AJvYcCVbMxTbsWQORJUESXUicEwA4MsmUoXnm4vQG9fn9HIK+4feolGRnOIZhNhlv+elhFQBCtYMkcAlvqZLbAo6@vger.kernel.org
X-Received: by 2002:a05:651c:20c5:b0:30b:edfc:5d8a with SMTP id
 38308e7fff4ca-32cdc329543mr23944531fa.0.1751257965460; Sun, 29 Jun 2025
 21:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411003827.782544-1-iuncuim@gmail.com> <20250411003827.782544-5-iuncuim@gmail.com>
In-Reply-To: <20250411003827.782544-5-iuncuim@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 30 Jun 2025 12:32:33 +0800
X-Gmail-Original-Message-ID: <CAGb2v659nQit-cOsr6q+ACO2MJ+c6RyfBWVg7iP_u1DO4fXBHQ@mail.gmail.com>
X-Gm-Features: Ac12FXycZ4eBZnw1-9h5Z5_HZw9HoRSOqmeNCAZOYMw7KeNLsUjQ12gZN6IqRgQ
Message-ID: <CAGb2v659nQit-cOsr6q+ACO2MJ+c6RyfBWVg7iP_u1DO4fXBHQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: allwinner: A523: Add SID controller node
To: iuncuim <iuncuim@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Andre Przywara <andre.przywara@arm.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 8:40=E2=80=AFAM iuncuim <iuncuim@gmail.com> wrote:
>
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
>
> The SID controller should be compatible with A64 and others SoC with 0x20=
0
> offset.
>
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

But this also needs a matching update to the binding.

> ---
>  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/=
boot/dts/allwinner/sun55i-a523.dtsi
> index ee485899b..d626612bb 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> @@ -171,6 +171,13 @@ ccu: clock-controller@2001000 {
>                         #reset-cells =3D <1>;
>                 };
>
> +               sid: efuse@3006000 {
> +                       compatible =3D "allwinner,sun50i-a523-sid", "allw=
inner,sun50i-a64-sid";
> +                       reg =3D <0x03006000 0x1000>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <1>;
> +               };
> +
>                 mmc0: mmc@4020000 {
>                         compatible =3D "allwinner,sun55i-a523-mmc",
>                                      "allwinner,sun20i-d1-mmc";
> --
> 2.49.0
>

