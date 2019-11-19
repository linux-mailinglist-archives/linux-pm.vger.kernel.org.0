Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E43210195E
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 07:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfKSG1U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 01:27:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40823 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfKSG1U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2019 01:27:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id q15so9539312wrw.7;
        Mon, 18 Nov 2019 22:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yTRHG5EOWt5NU/bZKOdQMhQ2F0oJ1P28s+F2Gnw6004=;
        b=WhqB5g99eKaoHd/dJsvVMSNno9QHqufRtB793LV5xPXsNyd6HMA/N/BdLe92qoe6xE
         70bdl7LxcEZJ4KlKD8Trq207cvB8/Z7FtAtgysvGL/DL/xaTqW9mqKoLwWRgJIJaPrUb
         qQ+QzzDVpBQDKPwvN9EwNHkCc4cXJlcz0O3AlsFYtuH5D+VePTy4zsj22Dg+erUvGy85
         +9DvIySK3w26Os87RBWX0wv426u7J4gZwsqWZLJyKxQbckfmYAB/LVUIcJfixpIR0tAe
         o9Y11pklnCJ0Ffk5THB6xqp0RRUMAOlkZoF6wWXhznGDmmw24PgbZbioP1FP1H8txZWy
         +CDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yTRHG5EOWt5NU/bZKOdQMhQ2F0oJ1P28s+F2Gnw6004=;
        b=LYxH7X4rnXTZeafg2b0OL9stjSIl7RtIFc9fJcJbZ3VjP2CTB9wzQDvdoCHXFJlyaB
         /+vv0b02DnqzCh8wc5AqoOV2AOy/7J/XQU5uhMU8A2YFkV59kCBRgwegS/qo+nJxVByc
         H1ADmo9uFBUbh3xrNdnbJ1ulJQLwS/QElrO+JCNMJoYuGz6WJrkFBDWCoVJ3NWbgW1YH
         3gw0hC6DpeifH0kq5ONFSgbBrPIAwkd87dnsbTMBYOsS8kTo1VkfpXvyjlRhn0lLhZG0
         dHMIcHjYWZtdLznG6F416rf1egwKTpVfKKHmH9QFVhsLCELBMy7Ep1RIardF0AQ6q1I9
         5k6g==
X-Gm-Message-State: APjAAAVyQNdqOt4VZSvRypPgqyTqFC7kG6YaVwZQiH6XcufZj96+Nxkx
        neyp+S6Psen6sG+D6SleKiM=
X-Google-Smtp-Source: APXvYqzlpDjFkeUcdGOBlWMBxZPRxM6E7+Q/CFyBN8fN+NDaMa+SWoA7MlyEZvVA4SOK39bKq8DGbw==
X-Received: by 2002:a5d:6550:: with SMTP id z16mr34472096wrv.66.1574144837687;
        Mon, 18 Nov 2019 22:27:17 -0800 (PST)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id k4sm1993915wmk.26.2019.11.18.22.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 22:27:16 -0800 (PST)
Date:   Tue, 19 Nov 2019 07:27:15 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 11/29] ARM: tegra: Add interconnect properties to
 Tegra124 device-tree
Message-ID: <20191119062715.GD2462695@ulmo>
References: <20191118200247.3567-1-digetx@gmail.com>
 <20191118200247.3567-12-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1sNVjLsmu1MXqwQ/"
Content-Disposition: inline
In-Reply-To: <20191118200247.3567-12-digetx@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--1sNVjLsmu1MXqwQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2019 at 11:02:29PM +0300, Dmitry Osipenko wrote:
> Add interconnect properties to the memory controller, external memory
> controller and the display controller nodes to describe interconnection
> of these nodes.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/boot/dts/tegra124.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124=
=2Edtsi
> index 413bfb981de8..5069af3011cc 100644
> --- a/arch/arm/boot/dts/tegra124.dtsi
> +++ b/arch/arm/boot/dts/tegra124.dtsi
> @@ -3,6 +3,7 @@
>  #include <dt-bindings/gpio/tegra-gpio.h>
>  #include <dt-bindings/memory/tegra124-mc.h>
>  #include <dt-bindings/pinctrl/pinctrl-tegra.h>
> +#include <dt-bindings/interconnect/tegra-icc.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/tegra124-car.h>
>  #include <dt-bindings/thermal/tegra124-soctherm.h>
> @@ -111,6 +112,9 @@
>  			iommus =3D <&mc TEGRA_SWGROUP_DC>;
> =20
>  			nvidia,head =3D <0>;
> +
> +			interconnects =3D <&mc TEGRA_ICC_MC_DC &emc TEGRA_ICC_EMEM>;
> +			interconnect-names =3D "dma-mem";

I don't think this is quite correct. The display controller is not
connected to the EMC. Instead, requests go to the MC which then forwards
them to the EMC. So I think we really only need the one connection here.
There are some clients that are read/write and they may need extra
entries, but all connections from memory clients should be to the MC,
not the EMC.

Thierry

>  		};
> =20
>  		dc@54240000 {
> @@ -126,6 +130,9 @@
>  			iommus =3D <&mc TEGRA_SWGROUP_DCB>;
> =20
>  			nvidia,head =3D <1>;
> +
> +			interconnects =3D <&mc TEGRA_ICC_MC_DCB &emc TEGRA_ICC_EMEM>;
> +			interconnect-names =3D "dma-mem";
>  		};
> =20
>  		hdmi: hdmi@54280000 {
> @@ -620,6 +627,7 @@
>  		interrupts =3D <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> =20
>  		#iommu-cells =3D <1>;
> +		#interconnect-cells =3D <1>;
>  	};
> =20
>  	emc: emc@7001b000 {
> @@ -627,6 +635,8 @@
>  		reg =3D <0x0 0x7001b000 0x0 0x1000>;
> =20
>  		nvidia,memory-controller =3D <&mc>;
> +
> +		#interconnect-cells =3D <1>;
>  	};
> =20
>  	sata@70020000 {
> --=20
> 2.23.0
>=20

--1sNVjLsmu1MXqwQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3Ti0MACgkQ3SOs138+
s6Hg9xAApJU8FlgxLpB/IXKidtprmMk8vhh02ZMQqOhROMwyOmbLTvhH/q9SYso0
z+dc7koPVCuOxG+yWy69RlSK+7YoYPR2hEq+SoEwtfFQd2pzLz7wMaNNjlofr3zB
PFxTm1Dd/PKlju/uGF9n+Tpc5Ar3BVyVJE9Sh3NTwkD+KKf4PKvaGKroC5efguXV
trB8vap+Z6QnnE10smpRue/ohdmhwEEN5Fov/DRWF391QcPqPbDnAlvI3jTgcuIO
XMXSUHAxKhE34vW7hCx3tu/la7qIwdVIwG35ZVAZvTRNV1Neu+YwdN0dAYsicNH9
KJ9BTZCD6McAfk9/ngtq43dzrGeUNE35dnwB7vMIoknA+6wqmilKTpLdY1t7SWAc
uekdPYUFCwz3p70Q4V1dxNzZ8bJsJPLUisiyoKwjLS9TmIQ6FKTOAj7uUNvFUPG1
etwyvln6H1E2ErFYEm+7A5oLhu7f44YU+rztJTCCuix2dz8umbrnA2xeFZ9ORgaV
PRrwQVtjW4Vnw6eqxjP1rE02Fv5/6W3G+Ic0Fb6oj4mNV1bhcVAACSrGRcGTHGFL
IPPmaXJ/mBQfjH4IQKtWDXCUCwbJJjquBiN7VKhWRH39R1FdCIASG9T9RF4/Dnfu
rzksgamzMrrieI08R6GnglLTCe84RepCSN9oqzKGQji469xyeaI=
=B4p+
-----END PGP SIGNATURE-----

--1sNVjLsmu1MXqwQ/--
