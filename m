Return-Path: <linux-pm+bounces-21715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9D3A2F432
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 17:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DEC1887B73
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 16:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0518524F5A4;
	Mon, 10 Feb 2025 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CV4kd5Hy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A7624BD14;
	Mon, 10 Feb 2025 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206281; cv=none; b=AnEgZ8rqBmtzPYl98IkLZtmoOKMvZoVNmZ4UarrgCKUZZHvqVc6L2UdBEeCVGQn7O3J83fGkIAtkmtQp1K2L4Easa3K4QOzlhV74d0jtQc15ATbP87hgHUHECxHANIxMKl55+BcgurnZHp/TL8Bc5Pw9ovDZ74qcIcWdytUVQvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206281; c=relaxed/simple;
	bh=U2vjziE5GMYK6ByV+mMd6XOjSQjKurIySf6gTUHivws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PC/mMezImWVSZd9rIWB2VR+JDI3EIl0CD84WuaJvt5SrPidmu8vVRkovSTX0EBnK0Nr9z6/fjxOgtaSgXkCKlastQIZf9c3do+XP4kqfmhu0s+UCIlx0QS2W0gKnylrRuLPernaO3gNm7w0ByvH17L/IxAVs+xjhCczQxg+pHg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CV4kd5Hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2216C4CEFB;
	Mon, 10 Feb 2025 16:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739206281;
	bh=U2vjziE5GMYK6ByV+mMd6XOjSQjKurIySf6gTUHivws=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=CV4kd5HyY99FFRw4Ycx+q2mq0AlX+Gn0a0Fd11V0dPzAFGOrRW82W913gaDL2yCIU
	 fow19XuE3anLwm4AK0bGZVa0/SP15/ET0iRfjrUbm1sh6OSD9kV3Vfksl/HTJVp6Tg
	 JwZ3+BvouBGe/N4hjqcl/BBhYrMGU7VL9IZY1Avr4cDF9BIx3jwoghwlL/MI5vVDSo
	 bRakNDR9WC0ptgiva6vRa/7r7s8MctEf33cUYsuMghwfLXsrITacUvzIEbHFWkLd6N
	 uEaTUNuK7Zmj3TUHD3v5p6ilKLdGUoOGtytx4JBtVlQQnPtq6CIcgGDlxbo6UZFHUL
	 sYFBp8ll9SH7w==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30795988ebeso46289151fa.3;
        Mon, 10 Feb 2025 08:51:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9dFrk0/Oi7mxCNoy2E3vhsIX96vjQz5BhYLKRwZAITUuQorMb4V0RYp9P33gpUMbk4jZl/6CQ+7w=@vger.kernel.org, AJvYcCVUTtuS5+1Z7r/drUv7RQZnpcZE+xRcJGciKuoxbRUWQuGUU1sNP7OR3IT8LVy4PkYJW20WVpbljA7EFvo=@vger.kernel.org, AJvYcCVXUhh0BpUX+5neD/jf8IDzAkEu4G1NA9Ks512wcSS3Ie3759NDnfc2yMxLR80I1p7018WYjhBuJoDv@vger.kernel.org, AJvYcCVrOPJvd6p39VCuWiciCJdPqI2JwuY4X6J6/djLRXuTd9DkSq5nFZwam/Bog0KbUQGAeIYR7uifrFjJ@vger.kernel.org, AJvYcCXLcw2J/L6CNuFpNvKYZI7U7di6KZcqnFduTQS6ZUwBFLJSp2KnoaWfvQyFU6xiZPJbTA4KIA8Iqs+4pMlt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4IACsddk3yPqYa4kyvPIjwHqN64E+buY9TDPQ1uAcEj7LelgG
	/hH2JrDbx9CyI0Whr3n/GT3DYpuKmNvnDYjdWDJitHby7zMfHP4tnTu6reHpsjJ5TyxjOY0U78b
	xPQw4tiP6v3NhpRvwYUkUTNRKpEI=
X-Google-Smtp-Source: AGHT+IG5t025yFQgv5+IxDx2jt/zCEdWoaia7+P9FBemxbZfy7NIWzyqdgtOgMR7KudhZEJun+VV7TSIGjzCCgMPaoc=
X-Received: by 2002:a05:651c:2129:b0:308:f01f:1829 with SMTP id
 38308e7fff4ca-308f01f1f54mr12808581fa.6.1739206279007; Mon, 10 Feb 2025
 08:51:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226050205.30241-1-val@packett.cool> <20241226050205.30241-10-val@packett.cool>
In-Reply-To: <20241226050205.30241-10-val@packett.cool>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 11 Feb 2025 00:51:06 +0800
X-Gmail-Original-Message-ID: <CAGb2v64VhJ0KDiqfFdEG9s__uuVHCN2kss+KHi-ta8WDmG0KKA@mail.gmail.com>
X-Gm-Features: AWEUYZknWIa5-CPGuL8BqnhcoaA-Kfslk_4yIvAua3sKJhdR6f_EU04T4LA0r7U
Message-ID: <CAGb2v64VhJ0KDiqfFdEG9s__uuVHCN2kss+KHi-ta8WDmG0KKA@mail.gmail.com>
Subject: Re: [PATCH 9/9] arm64: dts: mt6392: add mt6392 PMIC dtsi
To: Val Packett <val@packett.cool>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Eddie Huang <eddie.huang@mediatek.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Fabien Parent <parent.f@gmail.com>, 
	Yassine Oudjana <y.oudjana@protonmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2024 at 1:21=E2=80=AFPM Val Packett <val@packett.cool> wrot=
e:
>
> Add the dts to be included by all boards using the MT6392 PMIC.
>
> Signed-off-by: Val Packett <val@packett.cool>
> ---
>  arch/arm64/boot/dts/mediatek/mt6392.dtsi | 232 +++++++++++++++++++++++
>  1 file changed, 232 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt6392.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt6392.dtsi
> new file mode 100644
> index 0000000000000..a7c65dbb043c1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + * Copyright (c) 2024 Val Packett <val@packett.cool>
> + */
> +
> +#include <dt-bindings/input/input.h>
> +
> +&pwrap {
> +       pmic: mt6392 {
> +               compatible =3D "mediatek,mt6392";
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +
> +               regulators {
> +                       compatible =3D "mediatek,mt6392-regulator";

While listed in the binding, this doesn't actually do anything in
the driver.

> +                       mt6392_vproc_reg: buck_vproc {

Could we get rid of the "buck_" and "ldo_" prefixes?

> +                               regulator-name =3D "buck_vproc";
> +                               regulator-min-microvolt =3D <700000>;
> +                               regulator-max-microvolt =3D <1350000>;

PMIC ranges are already implied by the compatible string and regulator
node name. No need to repeat them.

> +                               regulator-ramp-delay =3D <12500>;

This probably belongs in the driver?

Comments apply to all the regulator sub-nodes.

ChenYu


> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vsys_reg: buck_vsys {
> +                               regulator-name =3D "buck_vsys";
> +                               regulator-min-microvolt =3D <1400000>;
> +                               regulator-max-microvolt =3D <2987500>;
> +                               regulator-ramp-delay =3D <25000>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vcore_reg: buck_vcore {
> +                               regulator-name =3D "buck_vcore";
> +                               regulator-min-microvolt =3D <700000>;
> +                               regulator-max-microvolt =3D <1350000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vxo22_reg: ldo_vxo22 {
> +                               regulator-name =3D "ldo_vxo22";
> +                               regulator-min-microvolt =3D <2200000>;
> +                               regulator-max-microvolt =3D <2200000>;
> +                               regulator-enable-ramp-delay =3D <110>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vaud22_reg: ldo_vaud22 {
> +                               regulator-name =3D "ldo_vaud22";
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <2200000>;
> +                               regulator-enable-ramp-delay =3D <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vcama_reg: ldo_vcama {
> +                               regulator-name =3D "ldo_vcama";
> +                               regulator-min-microvolt =3D <2800000>;
> +                               regulator-max-microvolt =3D <2800000>;
> +                               regulator-enable-ramp-delay =3D <264>;
> +                       };
> +
> +                       mt6392_vaud28_reg: ldo_vaud28 {
> +                               regulator-name =3D "ldo_vaud28";
> +                               regulator-min-microvolt =3D <2800000>;
> +                               regulator-max-microvolt =3D <2800000>;
> +                               regulator-enable-ramp-delay =3D <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vadc18_reg: ldo_vadc18 {
> +                               regulator-name =3D "ldo_vadc18";
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-enable-ramp-delay =3D <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vcn35_reg: ldo_vcn35 {
> +                               regulator-name =3D "ldo_vcn35";
> +                               regulator-min-microvolt =3D <3300000>;
> +                               regulator-max-microvolt =3D <3600000>;
> +                               regulator-enable-ramp-delay =3D <264>;
> +                       };
> +
> +                       mt6392_vio28_reg: ldo_vio28 {
> +                               regulator-name =3D "ldo_vio28";
> +                               regulator-min-microvolt =3D <2800000>;
> +                               regulator-max-microvolt =3D <2800000>;
> +                               regulator-enable-ramp-delay =3D <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vusb_reg: ldo_vusb {
> +                               regulator-name =3D "ldo_vusb";
> +                               regulator-min-microvolt =3D <3300000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-enable-ramp-delay =3D <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vmc_reg: ldo_vmc {
> +                               regulator-name =3D "ldo_vmc";
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-enable-ramp-delay =3D <264>;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vmch_reg: ldo_vmch {
> +                               regulator-name =3D "ldo_vmch";
> +                               regulator-min-microvolt =3D <3000000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-enable-ramp-delay =3D <264>;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vemc3v3_reg: ldo_vemc3v3 {
> +                               regulator-name =3D "ldo_vemc3v3";
> +                               regulator-min-microvolt =3D <3000000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-enable-ramp-delay =3D <264>;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vgp1_reg: ldo_vgp1 {
> +                               regulator-name =3D "ldo_vgp1";
> +                               regulator-min-microvolt =3D <1200000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-enable-ramp-delay =3D <264>;
> +                       };
> +
> +                       mt6392_vgp2_reg: ldo_vgp2 {
> +                               regulator-name =3D "ldo_vgp2";
> +                               regulator-min-microvolt =3D <1200000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-enable-ramp-delay =3D <264>;
> +                       };
> +
> +                       mt6392_vcn18_reg: ldo_vcn18 {
> +                               regulator-name =3D "ldo_vcn18";
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-enable-ramp-delay =3D <264>;
> +                       };
> +
> +                       mt6392_vcamaf_reg: ldo_vcamaf {
> +                               regulator-name =3D "ldo_vcamaf";
> +                               regulator-min-microvolt =3D <1200000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-enable-ramp-delay =3D <264>;
> +                       };
> +
> +                       mt6392_vm_reg: ldo_vm {
> +                               regulator-name =3D "ldo_vm";
> +                               regulator-min-microvolt =3D <1240000>;
> +                               regulator-max-microvolt =3D <1390000>;
> +                               regulator-enable-ramp-delay =3D <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vio18_reg: ldo_vio18 {
> +                               regulator-name =3D "ldo_vio18";
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-enable-ramp-delay =3D <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vcamd_reg: ldo_vcamd {
> +                               regulator-name =3D "ldo_vcamd";
> +                               regulator-min-microvolt =3D <1200000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-enable-ramp-delay =3D <264>;
> +                       };
> +
> +                       mt6392_vcamio_reg: ldo_vcamio {
> +                               regulator-name =3D "ldo_vcamio";
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-enable-ramp-delay =3D <264>;
> +                       };
> +
> +                       mt6392_vm25_reg: ldo_vm25 {
> +                               regulator-name =3D "ldo_vm25";
> +                               regulator-min-microvolt =3D <2500000>;
> +                               regulator-max-microvolt =3D <2500000>;
> +                               regulator-enable-ramp-delay =3D <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vefuse_reg: ldo_vefuse {
> +                               regulator-name =3D "ldo_vefuse";
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <2000000>;
> +                               regulator-enable-ramp-delay =3D <264>;
> +                       };
> +               };
> +
> +               rtc {
> +                       compatible =3D "mediatek,mt6392-rtc";
> +               };
> +
> +               keys {
> +                       compatible =3D "mediatek,mt6392-keys";
> +
> +                       key-power {
> +                               linux,keycodes =3D <KEY_POWER>;
> +                               wakeup-source;
> +                       };
> +
> +                       key-home {
> +                               linux,keycodes =3D <KEY_HOME>;
> +                               wakeup-source;
> +                       };
> +               };
> +       };
> +};
> --
> 2.47.1
>
>

