Return-Path: <linux-pm+bounces-22526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A373A3CE78
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 02:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB40B177E17
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 01:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91001130E58;
	Thu, 20 Feb 2025 01:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="jINtxwQI"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D9D15624D;
	Thu, 20 Feb 2025 01:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014078; cv=pass; b=luZRmaVlMW2virTxqBmg2R2YwtNieDUtmBOmitVPjJbsWfh2xrV0ZP5/RgHLsyE4bs6UMgC6sNtYxWs4RrMZKxBaqkGW+Tx6uRDiSIjTICTdxIanRH+MNyUOFmYmquSqTcxF9x0TJF2vBBVy18RhjDcizjU2foanxEP6z8eoR0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014078; c=relaxed/simple;
	bh=zJkBB492HwKk7oWSVF9d77ThEDLdy11QUR6n3qm+NGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+e1sNonCqv56tG7R2dPlUVFuXAK4EXDlQSMKjWV3HOwnbDZZag2Sg0KQqvHsZJkudekzhUqpt+nOiCp0l21rhs6p7gqmqPfhkUeNBPqsJia/ERHLRYslucXA1g6Vg4gu1jbBLjxpQ8MLvBkcJEXihBkbsPGY7RWStVCvmukECU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=jINtxwQI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740014055; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FKE4DGPHfK3pSQzOrAVcQPJnHlLrjRyU52MeQX2NJ6KXFkZyf+7vVUyqf3F9A4uiILCGtyVvcr+KIuL5yTKAdGomO81lWjikOr8kh4F1YdJqbOFs7WAoPf9emwpua2KetQZZ9+LuSCqeULTfdAUCSfKS93sZYM3FawTTyuWT3Zk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740014055; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fy3eZlkZDiRooYkfeOXa4T84dJQafoGp21goOeYujS8=; 
	b=I3rZCuLAukzm9+YE2+9Nwon/NUu4uGLAJ5wKfu2nW6afjYD717VqIwMTCYJWks5aoinyguIpmqyowo7aO3GmG5ARHbrgQR9Sx1+NLNOEawI4MJt3aUNorvzF6uiwiWcBhqd/xJTotxX5IeCsKQyyBwEEzxNB0hlHLHNM7Ig2GjI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740014055;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=fy3eZlkZDiRooYkfeOXa4T84dJQafoGp21goOeYujS8=;
	b=jINtxwQIQmq3LfzRcCQ34frj++Sy3H73y5Hg5Yfa/3sF59RBGJ+cI+ANG4G/QeD/
	fJC2Lyyb4+X2JUvXGqZbyY3DCUkF2oEjgBBG2X09X8U1PP2IQJu+f+p8Wz6vq0XBYtH
	boEN1WNFQHYayKEPTHdrPMQoZxQ5foPJvbqGIEcs=
Received: by mx.zohomail.com with SMTPS id 1740014052769796.8629411328841;
	Wed, 19 Feb 2025 17:14:12 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 44A8F180608; Thu, 20 Feb 2025 02:14:08 +0100 (CET)
Date: Thu, 20 Feb 2025 02:14:08 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64: dts: rockchip: Add thermal trim OTP and tsadc
 nodes
Message-ID: <p3pddbmqyairfuqubvbjrsdi3s6m5w6etcfyevyatwlevetra6@5daaqilf7ve5>
References: <20250216-rk3576-tsadc-upstream-v1-0-6ec969322a14@collabora.com>
 <20250216-rk3576-tsadc-upstream-v1-5-6ec969322a14@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f2oqydbedyoledmw"
Content-Disposition: inline
In-Reply-To: <20250216-rk3576-tsadc-upstream-v1-5-6ec969322a14@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/239.939.29
X-ZohoMailClient: External


--f2oqydbedyoledmw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5/6] arm64: dts: rockchip: Add thermal trim OTP and tsadc
 nodes
MIME-Version: 1.0

Hi,

On Sun, Feb 16, 2025 at 12:34:54AM +0100, Nicolas Frattaroli wrote:
> Thanks to Heiko's work getting OTP working on the RK3576, we can specify
> the thermal sensor trim values which are stored there now, and with my
> driver addition to rockchip_thermal, we can make use of these.
>=20
> Add them to the devicetree for the SoC.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi | 75 ++++++++++++++++++++++++++=
++++++
>  1 file changed, 75 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/d=
ts/rockchip/rk3576.dtsi
> index 73df515a3937414d89515b4ddccf71f33f6a4fe7..c55d7096a3e985d48240c2cab=
3de572b9ece2b23 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> @@ -1441,6 +1441,48 @@ gpu_leakage: gpu-leakage@21 {
>  			log_leakage: log-leakage@22 {
>  				reg =3D <0x22 0x1>;
>  			};
> +			bigcore_tsadc_trim_l: bigcore-tsadc-trim-l@24 {
> +				reg =3D <0x24 0x1>;
> +			};
> +			bigcore_tsadc_trim_h: bigcore-tsadc-trim-h@25 {
> +				reg =3D <0x25 0x1>;
> +				bits =3D <0 2>;
> +			};

Looks like TRIM-L and TRIM-H are always consecutive and even for
Rockchip it would be weird to change that in the future. So I
think you can simplify this:

bigcore_tsadc_trim: bigcore-tsadc-trim@24 {
    reg =3D <0x24 0x2>;
    bits =3D <0 10>;
};

That looks much cleaner IMHO and should also simplify the driver and
the binding a bit :)

Greetings,

-- Sebastian

> +			litcore_tsadc_trim_l: litcore-tsadc-trim-l@26 {
> +				reg =3D <0x26 0x1>;
> +			};
> +			litcore_tsadc_trim_h: litcore-tsadc-trim-h@27 {
> +				reg =3D <0x27 0x1>;
> +				bits =3D <0 2>;
> +			};
> +			ddr_tsadc_trim_l: ddr-tsadc-trim-l@28 {
> +				reg =3D <0x28 0x1>;
> +			};
> +			ddr_tsadc_trim_h: ddr-tsadc-trim-h@29 {
> +				reg =3D <0x29 0x1>;
> +				bits =3D <0 2>;
> +			};
> +			npu_tsadc_trim_l: npu-tsadc-trim-l@2a {
> +				reg =3D <0x2a 0x1>;
> +			};
> +			npu_tsadc_trim_h: npu-tsadc-trim-h@2b {
> +				reg =3D <0x2b 0x1>;
> +				bits =3D <0 2>;
> +			};
> +			gpu_tsadc_trim_l: gpu-tsadc-trim-l@2c {
> +				reg =3D <0x2c 0x1>;
> +			};
> +			gpu_tsadc_trim_h: gpu-tsadc-trim-h@2d {
> +				reg =3D <0x2d 0x1>;
> +				bits =3D <0 2>;
> +			};
> +			soc_tsadc_trim_l: soc-tsadc-trim-l@64 {
> +				reg =3D <0x64 0x1>;
> +			};
> +			soc_tsadc_trim_h: soc-tsadc-trim-h@65 {
> +				reg =3D <0x65 0x1>;
> +				bits =3D <0 2>;
> +			};
>  		};
> =20
>  		gic: interrupt-controller@2a701000 {
> @@ -1852,6 +1894,39 @@ tsadc: tsadc@2ae70000 {
>  			rockchip,hw-tshut-temp =3D <120000>;
>  			rockchip,hw-tshut-mode =3D <0>; /* tshut mode 0:CRU 1:GPIO */
>  			rockchip,hw-tshut-polarity =3D <0>; /* tshut polarity 0:LOW 1:HIGH */
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			tsadc@0 {
> +				reg =3D <0>;
> +				nvmem-cells =3D <&soc_tsadc_trim_l>, <&soc_tsadc_trim_h>;
> +				nvmem-cell-names =3D "trim_l", "trim_h";
> +			};
> +			tsadc@1 {
> +				reg =3D <1>;
> +				nvmem-cells =3D <&bigcore_tsadc_trim_l>, <&bigcore_tsadc_trim_h>;
> +				nvmem-cell-names =3D "trim_l", "trim_h";
> +			};
> +			tsadc@2 {
> +				reg =3D <2>;
> +				nvmem-cells =3D <&litcore_tsadc_trim_l>, <&litcore_tsadc_trim_h>;
> +				nvmem-cell-names =3D "trim_l", "trim_h";
> +			};
> +			tsadc@3 {
> +				reg =3D <3>;
> +				nvmem-cells =3D <&ddr_tsadc_trim_l>, <&ddr_tsadc_trim_h>;
> +				nvmem-cell-names =3D "trim_l", "trim_h";
> +			};
> +			tsadc@4 {
> +				reg =3D <4>;
> +				nvmem-cells =3D <&npu_tsadc_trim_l>, <&npu_tsadc_trim_h>;
> +				nvmem-cell-names =3D "trim_l", "trim_h";
> +			};
> +			tsadc@5 {
> +				reg =3D <5>;
> +				nvmem-cells =3D <&gpu_tsadc_trim_l>, <&gpu_tsadc_trim_h>;
> +				nvmem-cell-names =3D "trim_l", "trim_h";
> +			};
>  		};
> =20
>  		i2c9: i2c@2ae80000 {
>=20
> --=20
> 2.48.1
>=20

--f2oqydbedyoledmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAme2gdwACgkQ2O7X88g7
+pqOnw/7BJwL3Y6HgC9xGEeFk3FYRXVxo1LmATjJX1xSRdUBgELTq/qwrW4CGzjO
zJYnXdbr5Ywvsdg1V4TjFEHSLLu5VHZcPXWFn1um2fFFZP6RAZqY7jKNsiMXP5dA
JUcvuELX2Ns44BkKyoYUX9rOZOcIHOjseh6S15CVOxa/eOuxFlV0Iqs5KcY4HnZ7
RveVjnwB29MLsGA81zAfJ53RASCMt3jtmojdqG1P2/qk/CI53Hv9oTCl9bF82yiq
tRoCXHyyWutOOmJvG2ZUfQOZc2KADwzL2MpWaEIQV3WeZmvF35yAzxk3d9JnyKwR
5w6SisxKXuwMp3PUGCTjAR4YVPucC3UqRBtQx+3gSkpNm4Kc8gON9vIvmJMjQgGN
ve+nX2Uzu7yaQqOsHzARgyZ5k0Yc4P5XOkQTo0t3hqXX1Tt0Y7jlkI+wG2HoZrLi
vKtVOBar3wq3TGQA0IVpWPNENbAtURVwB7e3zLQMlwobqmqTwUsg2VrpQKAGNuTq
sGvCUievEwSEzSdoPVjWBzRCqKFo2hq+zdOOlBH32w+tLNU9NXGuoRmDnwH2icvk
+3a3T2+jarvpvcA0PkkuTrUVPkp7GAjtlJusEtrKjNnqhQ5GhUMKY4FsA+N5YipZ
4xafMEzXk43Z+4jbGJlVH0I7uSbk8sEjI5ddTd8BypmMb2dzSgE=
=gZfm
-----END PGP SIGNATURE-----

--f2oqydbedyoledmw--

