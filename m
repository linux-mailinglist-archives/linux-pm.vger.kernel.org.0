Return-Path: <linux-pm+bounces-16491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE879B140E
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 03:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E146B218FA
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 01:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FCC2BB04;
	Sat, 26 Oct 2024 01:38:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4815661;
	Sat, 26 Oct 2024 01:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729906681; cv=none; b=nWLQUt8PHZM7VkQyd4HXcdO7nqFHULKKw6zyFXL2NsYcEqT/jAEOSk7zI5g7N6F1R8bNujsSjch+B8oZgdbx7RFXPyxtS744m8TUTG79JHrlYMvGlYBqPye6YRJP7DpWt91VNCFpoNh4OEn7VReOD84Ph+HG13OqARtwP/RuHNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729906681; c=relaxed/simple;
	bh=wan6ghRrYyCJS2yMSO6K6VxY4zUUUkYsmFebGzhfPBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tl8eFoC9Fz5GdmDstnntThRb1fxtuHN2dVUD24xQMPFNm3t7O0XrgujfWX1Yo4UI7MPJjxIuFUCLz7axQRqp0qpcRQGsTSn/dcPuyvzElnWP38ZjkUviC2OmSP/hM849xxBer14NVmEBJ40801D9K1GbVpCgB1ArNnLZwyKmF5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso343978766b.3;
        Fri, 25 Oct 2024 18:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729906676; x=1730511476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=00KlULZXQFFyz7svzxYaJpGGf2+6ICGFX0E8y5C8Vlc=;
        b=fX5rfWFq62FUmioDIO3Pj/XZhbdhrWGTvkNd+pAKP7cpkHc/9nq0z2xpFGRgErSNJq
         s/G8ryAMX4sVkoYn+PmCP+YXBm6iPcbOW2Fp3APVaMt99fll5eSV9WguZBr8dUmqulYd
         TYgDwCoIEh6fCw7NtEX2ju0krwEfUa7/bQTdeFcxRbk069KVzriWbgnfSGpfIqfflFIv
         tEHdB1Z71rlt3cM5Q6FfCyB61sCkX3vVN3q/eb6h09Y6BEc8Tx72bUUWdCmOok+km51q
         00fO3Owqo4sXPz8CQui3DrDkbPFX5No6omN9XNfdZbWQsgV7oCVXfGS5AbL0bTg8hV5/
         nofw==
X-Forwarded-Encrypted: i=1; AJvYcCVMtr228KDDyV+hM2crzXHOwydvUP9Ye57DlVswoRaGrVK+Xg1CXaWSqteo6L98zBjyIkJPDojtAF0a@vger.kernel.org, AJvYcCWHkMrmcwQZghKk0fwWmFtjdIG9m+vEpMHFYtqC1nbXYdrMASAmXCk/f1E0aM17F3PrrbyPGhS9Dna4@vger.kernel.org, AJvYcCWoRofggFmwEMiwg0bbA3i13nIDAHnA4R5KR9fC6iPQtWxOhXkZ75QWGi6Ov5RkeGwbzZqfpQ4q/EF7Fv5M@vger.kernel.org
X-Gm-Message-State: AOJu0YwR4bph0sFg+n0eNjGtnwIxFgDaA/z+cWl4AKymL5kjYvNtLTph
	k+99s2WKDtZBdhQgtxdC99y7ostkGRCpSlerdsgncYNxPB5U96Jes72nv9ov6FQ=
X-Google-Smtp-Source: AGHT+IGV8I5G54ZE7AkHgmJFJnFMDrlz/bmnYEipZYOcmItB5t5j+rFYglPpKbRYJXPTV4dKVA3OyQ==
X-Received: by 2002:a17:907:97c6:b0:a9a:4158:494a with SMTP id a640c23a62f3a-a9de615bc4emr69706466b.41.1729906675865;
        Fri, 25 Oct 2024 18:37:55 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f2994ffsm121226366b.114.2024.10.25.18.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 18:37:54 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so300204766b.2;
        Fri, 25 Oct 2024 18:37:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvSqLTPRQQvAcnHasXw9XEwtYqk8RD8PwnRJm2BmxQfd8naXtDlDvkj4ACYpGoObQWhB3uMmjRkC5u@vger.kernel.org, AJvYcCVfk3D0mClPQHBymIPjWv+9J5IHSJWrA+KluV1Nl3p9OMZfPo2hXYPAIwwHWQt3S/RmuKECTPKfoqRj@vger.kernel.org, AJvYcCXofE0k50cfLVZsDfuXJqvUZCDI74jq7UGmmfGvLnjAEN1GsQkEIXQ9u/nu7kKZfIxDEsjpqX8w7+MoXvC3@vger.kernel.org
X-Received: by 2002:a05:651c:19a1:b0:2fb:5138:a615 with SMTP id
 38308e7fff4ca-2fcbddfcba6mr5324521fa.0.1729906179135; Fri, 25 Oct 2024
 18:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest> <20241024170540.2721307-8-masterr3c0rd@epochal.quest>
In-Reply-To: <20241024170540.2721307-8-masterr3c0rd@epochal.quest>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 26 Oct 2024 09:29:27 +0800
X-Gmail-Original-Message-ID: <CAGb2v64tQ_9C3mwJqt-tm-6SV=SHAk75sO5Ho7gT=p=iyRfLcw@mail.gmail.com>
Message-ID: <CAGb2v64tQ_9C3mwJqt-tm-6SV=SHAk75sO5Ho7gT=p=iyRfLcw@mail.gmail.com>
Subject: Re: [PATCH 07/13] arm64: dts: allwinner: a100: add usb related nodes
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-usb@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Andre Przywara <andre.przywara@arm.com>, Parthiban <parthiban@linumiz.com>, 
	Yangtao Li <frank@allwinnertech.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Thierry Reding <treding@nvidia.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Maxime Ripard <mripard@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 1:09=E2=80=AFAM Cody Eksal <masterr3c0rd@epochal.qu=
est> wrote:
>
> From: Yangtao Li <frank@allwinnertech.com>
>
> Allwinner A64 have two HCI USB controllers, a OTG controller and a USB

            ^^^ Please update this.

> PHY device, let's add nodes on dts.
>
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> [masterr3c0rd@epochal.quest: fallback to a33-musb instead of h3-musb]
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> ---
>  .../arm64/boot/dts/allwinner/sun50i-a100.dtsi | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-a100.dtsi
> index adb11b26045f..0aee1b578661 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> @@ -302,6 +302,97 @@ ths: thermal-sensor@5070400 {
>                         #thermal-sensor-cells =3D <1>;
>                 };
>
> +               usbphy: phy@5100400 {
> +                       #phy-cells =3D <1>;
> +                       compatible =3D "allwinner,sun50i-a100-usb-phy";
> +                       reg =3D <0x05100400 0x14>,
> +                             <0x05101800 0x4>,
> +                             <0x05200800 0x4>;
> +                       reg-names =3D "phy_ctrl",
> +                                   "pmu0",
> +                                   "pmu1";
> +                       clocks =3D <&ccu CLK_USB_PHY0>,
> +                                <&ccu CLK_USB_PHY1>;
> +                       clock-names =3D "usb0_phy",
> +                                     "usb1_phy";
> +                       resets =3D <&ccu RST_USB_PHY0>,
> +                                <&ccu RST_USB_PHY1>;
> +                       reset-names =3D "usb0_reset",
> +                                     "usb1_reset";
> +                       status =3D "disabled";
> +               };
> +
> +               ehci0: usb@5101000 {
> +                       compatible =3D "allwinner,sun50i-a100-ehci",
> +                                    "generic-ehci";
> +                       reg =3D <0x05101000 0x100>;
> +                       interrupts =3D <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks =3D <&ccu CLK_BUS_OHCI0>,
> +                                <&ccu CLK_BUS_EHCI0>,
> +                                <&ccu CLK_USB_OHCI0>;
> +                       resets =3D <&ccu RST_BUS_OHCI0>,
> +                                <&ccu RST_BUS_EHCI0>;
> +                       phys =3D <&usbphy 0>;
> +                       phy-names =3D "usb";
> +                       status =3D "disabled";
> +               };
> +
> +               ohci0: usb@5101400 {
> +                       compatible =3D "allwinner,sun50i-a100-ohci",
> +                                    "generic-ohci";
> +                       reg =3D <0x05101400 0x100>;
> +                       interrupts =3D <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks =3D <&ccu CLK_BUS_OHCI0>,
> +                                <&ccu CLK_USB_OHCI0>;
> +                       resets =3D <&ccu RST_BUS_OHCI0>;
> +                       phys =3D <&usbphy 0>;
> +                       phy-names =3D "usb";
> +                       status =3D "disabled";
> +               };
> +
> +               usb_otg: usb@5100000 {
> +                       compatible =3D "allwinner,sun50i-a100-musb",
> +                                    "allwinner,sun8i-a33-musb";
> +                       reg =3D <0x05100000 0x0400>;
> +                       clocks =3D <&ccu CLK_BUS_OTG>;
> +                       resets =3D <&ccu RST_BUS_OTG>;
> +                       interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names =3D "mc";
> +                       phys =3D <&usbphy 0>;
> +                       phy-names =3D "usb";
> +                       extcon =3D <&usbphy 0>;
> +                       dr_mode =3D "otg";
> +                       status =3D "disabled";
> +               };
> +
> +               ehci1: usb@5200000 {
> +                       compatible =3D "allwinner,sun50i-a100-ehci",
> +                                    "generic-ehci";
> +                       reg =3D <0x05200000 0x100>;
> +                       interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks =3D <&ccu CLK_BUS_OHCI1>,
> +                                <&ccu CLK_BUS_EHCI1>,
> +                                <&ccu CLK_USB_OHCI1>;
> +                       resets =3D <&ccu RST_BUS_OHCI1>,
> +                                <&ccu RST_BUS_EHCI1>;
> +                       phys =3D <&usbphy 1>;
> +                       phy-names =3D "usb";
> +                       status =3D "disabled";
> +               };
> +
> +               ohci1: usb@5200400 {
> +                       compatible =3D "allwinner,sun50i-a100-ohci",
> +                                    "generic-ohci";
> +                       reg =3D <0x05200400 0x100>;
> +                       interrupts =3D <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks =3D <&ccu CLK_BUS_OHCI1>,
> +                                <&ccu CLK_USB_OHCI1>;
> +                       resets =3D <&ccu RST_BUS_OHCI1>;
> +                       phys =3D <&usbphy 1>;
> +                       phy-names =3D "usb";
> +                       status =3D "disabled";
> +               };
> +
>                 r_ccu: clock@7010000 {
>                         compatible =3D "allwinner,sun50i-a100-r-ccu";
>                         reg =3D <0x07010000 0x300>;
> --
> 2.47.0
>
>

