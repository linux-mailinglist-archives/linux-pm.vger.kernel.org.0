Return-Path: <linux-pm+bounces-20001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B903A03AD1
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 10:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48AC71615F0
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 09:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C056A1E3DE8;
	Tue,  7 Jan 2025 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SfAdx9pD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30551E3DF2
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736240816; cv=none; b=VtBLM5Z4VzdFsL3jfE/8HmvyLxdliLtLS9ia115AUmfTiXHYHHU9FfEVBDVKNa3LaWbU2M8qUuS3VhYa+rwjUDUoC2d+W4GSuU0vllaWeNeU3IKYTvCVd0ZSFxjb7yfXzJlMogSzXQYsGBiJNaULeqBeSq8KeWwVZE+yAoqWYMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736240816; c=relaxed/simple;
	bh=LvDd8U5d1JAExU6nJWpv5tD30jOU1E0HMWgRrqOF98o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RLPDvsF8CmhET++TJUkzMudY9q0qEORLfOvruHLlPChBikaCuruKt2XhNqiyJd3cgHlGEl7NVAUOgBZG7t40iK5jI3CGff1iAa52Wx9IEh6n3GUkJBfc8iiHgVvw/bM7p9HxACI2uIaYT7ChtaDfMU1VAsPyqubQg7YxvBT0LHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SfAdx9pD; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385eed29d17so7239448f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2025 01:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736240810; x=1736845610; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A4jDBOd4uA6iWq10QaHFHWmxRK0/Onl9k6WANOitcUI=;
        b=SfAdx9pD8u00Jk9Zxg0HjjKtk1PVJmVuNIy9xCxr+lvGr1MG556UlGirUbNwzin2fM
         B5W9X7aSnTOHrW8TNLLqMjEAGtpkxIMPrFtw8ZPHmGK0UONtJ5a2vIMgtg0+EaGp5kav
         Ig0vwgueYHJeWZsDXVngEJXFKhSiAnZ+t+NwYmhTq1J/Sl01WQDkO67RunPulI8W7AH9
         pE5K+IxSLUFtn2kaKDhnggjHeSqmgKATS8F7RAV42vQvgXmlvLUqV43qGko9Bfo8ltdO
         5kx/qTdsKN6PzJhJfnKV8FaQC4bopzDcLPpLLhkATo5R72zc0t2bY5otgiMnJqVJPnGi
         Svgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736240810; x=1736845610;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A4jDBOd4uA6iWq10QaHFHWmxRK0/Onl9k6WANOitcUI=;
        b=aFJLHGpiBTeuDiG1ftRVSkc3ZG3hsTuGOFG3Jjc7irfon0oEPzYhN+xXymvIV1qOzT
         qPAJe77Ng0TWpUczptTaNYX+qmvxRZqCttDOS6aK1t9ejUd/FqRBAhCQ8MQU/8FOIQil
         qfjjMa9xF+5zw/mSEot7lzr8VRtRYFaNKnIgCYQPjM4GPnIMqMayGLsN1PSlp9F2TUsg
         j/8moK7D4yyTjVp6R3cgXqB6hbMB0pxeazfAQz94e3HiesE6tn4T21+xu6crM6SymHLN
         2WPMspjavC26ZByPJd6LzBe7Loxo2sl641w4qiS2pcRIdZG6iv+g7P8yLeKVmMTyVMUg
         sWbw==
X-Gm-Message-State: AOJu0YzhRISGsnJKnOCayw2JisRzcOdCmZRZvmclJd3SEF/xjCWkw428
	/1ShzBb6jyTwA+FkPFtI6TizbT0ujU2hXfKyd2JYwS+k/3Rj6Aqs+haQB70B+24=
X-Gm-Gg: ASbGnctb/I+VBQwtKy7n/yVrBuQ5+3z0AZA95ky+ZXsPB5TEl3mo1EtIAonozmcWgGG
	DyqCGn0vTTo0EQGqVJqxPoODQ3JUWmjquWO8jJAYVtbK7/4bxoYpTutq5Hc+Xf1mWLIAQIg/SO6
	LPDsfHhJbpv2NT1USugECUZZrZyyAgp0uILK1DxI5S6u1q9k2YvapWQKE9Tm2XEtZXGGLR/xXmG
	+BdaUumtUmY2dKqSiJ1CePbHzbxSXvx0NByXd5CpoKjW5oeyrpx2Q8pYJ9Z+g==
X-Google-Smtp-Source: AGHT+IHZAZxqzkt43hjIPdmiX16LWtAmIlQjSGTOiM5YyAVZqEoQExXofh761RH379rxPGTtkqw/RA==
X-Received: by 2002:a05:6000:480a:b0:386:1cd3:89fa with SMTP id ffacd0b85a97d-38a221fa8c6mr57479039f8f.33.1736240809665;
        Tue, 07 Jan 2025 01:06:49 -0800 (PST)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b013e1sm619089305e9.12.2025.01.07.01.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:06:49 -0800 (PST)
Message-ID: <74430be84cb49dc0a7413656a2923facc021cd15.camel@linaro.org>
Subject: Re: [PATCH v2 4/4] arm64: dts: exynos: gs101-oriole: enable Maxim
 max77759 fuel gauge
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: t.antoine@uclouvain.be, Sebastian Reichel <sre@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Peter
 Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Date: Tue, 07 Jan 2025 09:06:48 +0000
In-Reply-To: <20250102-b4-gs101_max77759_fg-v2-4-87959abeb7ff@uclouvain.be>
References: <20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be>
	 <20250102-b4-gs101_max77759_fg-v2-4-87959abeb7ff@uclouvain.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Thomas,

Thanks for your patch!

On Thu, 2025-01-02 at 12:15 +0100, Thomas Antoine via B4 Relay wrote:
> From: Thomas Antoine <t.antoine@uclouvain.be>
>=20
> Add the node for the max77759 fuel gauge as a slave of the i2c.
>=20
> The todo is still applicable given there are other slaves on the
> bus (pca9468, other max77759 functions and the max20339 OVP).
>=20
> The fuel gauge has been tested and seems to give coherent results.
> Manual activation of the charger via i2cset shows that the sign of
> the current does indicate charging/discharging status.
>=20
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> ---
> =C2=A0arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 10 ++++++++++
> =C2=A01 file changed, 10 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/ar=
m64/boot/dts/exynos/google/gs101-oriole.dts
> index 387fb779bd29ea3812331a7951f03b181c5fe659..6c83ee6f8a6b0327c576573d0=
3a8d2bcc93f9e16 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> +++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> @@ -10,6 +10,7 @@
> =C2=A0
> =C2=A0#include <dt-bindings/gpio/gpio.h>
> =C2=A0#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> =C2=A0#include "gs101-pinctrl.h"
> =C2=A0#include "gs101.dtsi"
> =C2=A0
> @@ -90,6 +91,15 @@ eeprom: eeprom@50 {
> =C2=A0&hsi2c_12 {
> =C2=A0	status =3D "okay";
> =C2=A0	/* TODO: add the devices once drivers exist */
> +
> +	fuel-gauge@36 {
> +		compatible =3D "maxim,max77759-fg";
> +		reg =3D <0x36>;
> +		reg-names =3D "m5";
> +		shunt-resistor-micro-ohms =3D <5000>;
> +		interrupt-parent =3D <&gpa9>;
> +		interrupts =3D <3 IRQ_TYPE_LEVEL_LOW>;
> +	};

The order of properties within a node should follow
Documentation/devicetree/bindings/dts-coding-style.rst

In particular shunt-resistor-micro-ohms should come last in
this case.

Cheers,
Andre'


