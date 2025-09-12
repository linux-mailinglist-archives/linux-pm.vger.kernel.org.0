Return-Path: <linux-pm+bounces-34544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D902B54A31
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 12:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9325587EBF
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1502FD7BC;
	Fri, 12 Sep 2025 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yF4ok2Dn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599502FD1C3
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674056; cv=none; b=fW9MyriJxhWfsyQmv5PtwkuNMO49e/il3CG3W6rHll2CJXLKqhPaMDA2tiyPCHM2c6GTzasZeUpoupdIpYXP5oqRFiTJpCwmzRR77BKnV4a4180dPuIEm15DFFQluxg5+Jiqx4SaVZfXmGU0gZ6SjzGZqhGfvI943Hl2HVWixB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674056; c=relaxed/simple;
	bh=fZ2Y+QVj1Q980T6u7XGCiKBFfT4CA2Sib8XpluNcSWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcTy6SHHMrQhO14mWkDkCfrGnNniIxk/quAKli235DBq8sXcLzGqanGfErRj3jaJIjenXZbI/ah5xQ4y9YwEQQ2/QUJEbwwkRpPeE0CRiHI+72Ls24hsAajjqjKuqU4H1OFqUYVsUFuE/+79E/Q21ntyXqCizgP9g7opD1LkVhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yF4ok2Dn; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-751415c488cso1482457a34.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 03:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757674052; x=1758278852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3OPza13UxQG3vaIXj292M6st2XTaYne/dlf9fQOIh4A=;
        b=yF4ok2DnJKy8g4WUEIhF3p62qGvM3lhFUmSA+pAVbC5cd8u1tPHpMIKPp1WCJOHSG5
         TJvn82wDF1U+SAryIeD5w3sAWzpqOHjGwk+lrj39hqSDkEsRzt98LF3tofAAGv2uIS65
         hrK9WYDiJTx1+QNjrj26dbaxPxqoP6MYnIzKaXLUhLVtxLt948OJ1bCJY+9UW6My8Edb
         N5Nojj2kserwLQbtOJkAEL9IrXIOeLCHjR0xgoT1ggIBZcoQ60UjKGEDDDHjzVCaTMoL
         X4ONxGToHxIEkk0mkazVU7I8nsSc1lmc1D6kh+MX94c0HkmK1swfajfwlv51MGVHoG9a
         x7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757674052; x=1758278852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OPza13UxQG3vaIXj292M6st2XTaYne/dlf9fQOIh4A=;
        b=a92vyDi4kWdUXUMfG7J2FSqi5ZxfdJPbB8tbghZ6enOG6jqoucBE9TfCWqooEcO7BH
         pdilau3MqE46Bhf613QTuzMmod4ZfL/vHx7A5BmQvuGYkH+W70xoCZ2PLR3I0kmtslW9
         MHuvArbeNSA+mHy8GQaGtAsa+es2fR3NGZWOI+kyjpKZHFNrUjjMoUhEi3dnb2q+tGY5
         mJ7i+ciLzginAN34sbSfzO7oGJuLBvcaSzY5N8+bVUsedNmrLDdaX/QTFTJKcZ/0wxyH
         J8HdOImYxr8U2VYpz0QkMpJdcD3NcIlwi/cNxzQfIZ9Q9QEy6TFQAMxtUpEdXG6JcwPS
         98xw==
X-Forwarded-Encrypted: i=1; AJvYcCVKoPVcRNcUA6ETsCKT6mMN+fnex4wFz/1eec4VWhKnMfI1f/HMI7FS2NQW9SuhYPU6EVd0Sy7mKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh1x/l/VCHgAmK2b3dwxpDrEZpL0/+617vN1ve3kBAbJaLXMNo
	CU9kXvDgEzM/t0Ys9rAGycmM+hJekNYb6naLjEre+1nXHa25r4RkP/5MdkvkmkylvbDZWbD/8+2
	6ijd2KCTcrxIPkTTQJXyCWh+rLQQE+peDFIpApGeauA==
X-Gm-Gg: ASbGncsOrfXWc8KnwsZ48HKu6QFGVTfpkCQzozIJLivQl3cZxIEoSWo+kDMr1XAiPW5
	WakWFOxZprh6k+ach9hlm8gqahWyaNRXk0Be175HcFUKpAg7Zy++/5JQBfEwy4cjNbUJwVl7Rza
	Mr02x2ygytQ19VoeWQEmCOh2yA9GA3v+wmM0XDI1F+q6yXYZ6wtayJ7HqQmgxeZlsgUTlyV4t/f
	mKtV9E=
X-Google-Smtp-Source: AGHT+IEwK6PAnW60amX/KFZUitg+3IWCKUF6YtBbEuqSyk7vuHndUimzJs3aHNTIWVsqYWSuZljSYmdD0ujXlXGOsTc=
X-Received: by 2002:a05:6830:25c3:b0:741:924c:3f60 with SMTP id
 46e09a7af769-753550e1f31mr1194594a34.20.1757674052466; Fri, 12 Sep 2025
 03:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804-b4-gs101_max77759_fg-v5-0-03a40e6c0e3d@uclouvain.be> <20250804-b4-gs101_max77759_fg-v5-4-03a40e6c0e3d@uclouvain.be>
In-Reply-To: <20250804-b4-gs101_max77759_fg-v5-4-03a40e6c0e3d@uclouvain.be>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 12 Sep 2025 11:47:21 +0100
X-Gm-Features: Ac12FXyNpSAUYBZClLOkGpS7sVjhUkL1QiaqAQuJpPSEayd4ohKDjbLy5QhjEPs
Message-ID: <CADrjBPqT8GORaMReQwMGUV+Lrh-njhk_giD2gQUPJRRuSz4XNw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] arm64: dts: exynos: google: add Maxim MAX77759 Fuel-gauge
To: t.antoine@uclouvain.be
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Aug 2025 at 15:25, Thomas Antoine via B4 Relay
<devnull+t.antoine.uclouvain.be@kernel.org> wrote:
>
> From: Thomas Antoine <t.antoine@uclouvain.be>
>
> Add the node for the Maxim MAX77759 fuel gauge as a slave of the i2c.
>
> The TODO is still applicable given there are other slaves on the
> bus (e.g. PCA9468, other MAX77759 functions and the MAX20339 OVP).
>
> For the device specific values (full design capacity and terminal
> current), the device should check an EEPROM at address 0x50 of the
> hsi2c_8 for a battery id stored in register 0x17. A set of parameters
> for the initialization of the fuel gauge should be chosen based on
> this id. Those sets are defined here:
>
> Link: https://android.googlesource.com/kernel/gs/+/refs/heads/android-gs-raviole-5.10-android15/arch/arm64/boot/dts/google/gs101-oriole-battery-data.dtsi
> Link: https://android.googlesource.com/kernel/gs/+/refs/heads/android-gs-raviole-5.10-android15/arch/arm64/boot/dts/google/gs101-raven-battery-data.dtsi
>
> This does not seem to be a standard pattern in the kernel currently
> so it is not implemented. Values observed on tested devices are
> instead used. The driver or the devicetree should be should be
> extended in the future to take versions into account.
>
> The pinctrl name follows the convention proposed in
> Link: https://lore.kernel.org/all/20250524-b4-max77759-mfd-dts-v2-2-b479542eb97d@linaro.org/
>
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> ---

This needs rebasing now to apply. With Andre's feedback addressed

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>




>  arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 10 ++++++++
>  .../boot/dts/exynos/google/gs101-pixel-common.dtsi | 30 ++++++++++++++++++++++
>  arch/arm64/boot/dts/exynos/google/gs101-raven.dts  | 11 ++++++++
>  3 files changed, 51 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> index 8df42bedbc036b5e97f6238d64820370043ffef2..18d147f6ea4a1a76c375996557349c866b9dad72 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> +++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> @@ -13,6 +13,12 @@
>  / {
>         model = "Oriole";
>         compatible = "google,gs101-oriole", "google,gs101";
> +
> +       battery: battery {
> +               compatible = "simple-battery";
> +               charge-full-design-microamp-hours = <4524000>;
> +               charge-term-current-microamp = <45000>;
> +       };
>  };
>
>  &cont_splash_mem {
> @@ -27,3 +33,7 @@ &framebuffer0 {
>         format = "a8r8g8b8";
>         status = "okay";
>  };
> +
> +&fuel_gauge {
> +       monitored-battery = <&battery>;
> +};
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi b/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
> index d6ddcc13f7b20c6dfbe92e86abafe965870d0c78..3362ad89ef6bacb7349259cf9e14452193ff7361 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
> @@ -10,6 +10,7 @@
>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/usb/pd.h>
>  #include "gs101-pinctrl.h"
>  #include "gs101.dtsi"
> @@ -99,6 +100,16 @@ &hsi2c_8 {
>         eeprom: eeprom@50 {
>                 compatible = "atmel,24c08";
>                 reg = <0x50>;
> +
> +               nvmem-layout {
> +                       compatible = "fixed-layout";
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +
> +                       fg_state: fgstate@42 {
> +                               reg = <0x42 0x17>;
> +                       };
> +               };
>         };
>  };
>
> @@ -188,6 +199,18 @@ usbc0_role_sw: endpoint {
>                         };
>                 };
>         };
> +
> +       fuel_gauge: fuel-gauge@36 {
> +               compatible = "maxim,max77759-fg";
> +               reg = <0x36>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&if_pmic_fg_int>;
> +               interrupt-parent = <&gpa9>;
> +               interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +               shunt-resistor-micro-ohms = <5000>;
> +               nvmem-cell-names = "fg_state";
> +               nvmem-cells = <&fg_state>;
> +       };
>  };
>
>  &pinctrl_far_alive {
> @@ -214,6 +237,13 @@ typec_int: typec-int-pins {
>  };
>
>  &pinctrl_gpio_alive {
> +       if_pmic_fg_int: if-pmic-fg-int-pins {
> +               samsung,pins = "gpa9-3";
> +               samsung,pin-function = <GS101_PIN_FUNC_EINT>;
> +               samsung,pin-pud = <GS101_PIN_PULL_UP>;
> +               samsung,pin-drv = <GS101_PIN_DRV_2_5_MA>;
> +       };
> +
>         key_power: key-power-pins {
>                 samsung,pins = "gpa10-1";
>                 samsung,pin-function = <GS101_PIN_FUNC_EINT>;
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101-raven.dts b/arch/arm64/boot/dts/exynos/google/gs101-raven.dts
> index 1e7e6b34b8649bc700a745c579a0268f0f6a9524..f91800879ea94b8fb0008c5e1f828072cabc1ac7 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101-raven.dts
> +++ b/arch/arm64/boot/dts/exynos/google/gs101-raven.dts
> @@ -13,6 +13,13 @@
>  / {
>         model = "Raven";
>         compatible = "google,gs101-raven", "google,gs101";
> +
> +       battery: battery {
> +               compatible = "simple-battery";
> +
> +               charge-full-design-microamp-hours = <4904000>;
> +               charge-term-current-microamp = <49000>;
> +       };
>  };
>
>  &cont_splash_mem {
> @@ -27,3 +34,7 @@ &framebuffer0 {
>         format = "a8r8g8b8";
>         status = "okay";
>  };
> +
> +&fuel_gauge {
> +       monitored-battery = <&battery>;
> +};
>
> --
> 2.50.1
>
>

