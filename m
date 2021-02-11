Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1FF318509
	for <lists+linux-pm@lfdr.de>; Thu, 11 Feb 2021 07:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhBKF7z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Feb 2021 00:59:55 -0500
Received: from mail-40131.protonmail.ch ([185.70.40.131]:30600 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhBKF7y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2021 00:59:54 -0500
Date:   Thu, 11 Feb 2021 05:59:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613023151;
        bh=ehBfJwC3S6JmY6v9WlIBP5fvzCROEEaXZlkI/hZuTXo=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=eo90MmipK77EfiE/uMIVh7Ljru1gRKQHPXgzib741KbcD7q0b2Zq90f4Hj+FqRLYo
         8lpl1amPtpznLdNLO2qcAmJ20KPGrvQpGT25VmWI5TzhbbrSdfZIcM9nfGt2z3BEAB
         m/oq8uy3fHbrZ2PXi+w9S39yolmUV4h3+HR+w7QE=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Timon Baetz <timon.baetz@protonmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: exynos: Add charger supply for I9100
Message-ID: <20210211065850.1e4a8943.timon.baetz@protonmail.com>
In-Reply-To: <20210130172747.2022977-3-timon.baetz@protonmail.com>
References: <20210130172747.2022977-1-timon.baetz@protonmail.com> <20210130172747.2022977-3-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 30 Jan 2021 17:29:31 +0000, Timon Baetz wrote:
> The regulator is used for charging control by max8997_charger driver.
>=20
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
>  arch/arm/boot/dts/exynos4210-i9100.dts | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/e=
xynos4210-i9100.dts
> index 304a8ee2364c..dad950daafb4 100644
> --- a/arch/arm/boot/dts/exynos4210-i9100.dts
> +++ b/arch/arm/boot/dts/exynos4210-i9100.dts
> @@ -384,6 +384,8 @@ pmic@66 {
>  =09=09pinctrl-0 =3D <&max8997_irq>, <&otg_gp>, <&usb_sel>;
>  =09=09pinctrl-names =3D "default";
> =20
> +=09=09charger-supply =3D <&charger_reg>;
> +
>  =09=09regulators {
>  =09=09=09vadc_reg: LDO1 {
>  =09=09=09=09regulator-name =3D "VADC_3.3V_C210";

Now that the bindings have been accepted and integrated into linux-next,
is anything else blocking this?

Thanks,
Timon

