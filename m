Return-Path: <linux-pm+bounces-39997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E4832CE5530
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 19:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D68D300846A
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 18:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10801212F89;
	Sun, 28 Dec 2025 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="o/xWum0q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC5A14AD0D;
	Sun, 28 Dec 2025 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766944880; cv=none; b=DLDlrN/wTpOikDugyAXEwrZYohfWAUKtfuRvcqkciZhF0gJ60S1LRD2GdRTuagXd/eHzcrlRvsyjIWGe80OlrMfOgvldftzaNc3kg10dJrVpeKs7D1MtZ7dMZJLo2KMiSCb0HzDcb/+5NXbXyLGr/jNxUJYauOi7uQwsxJWeOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766944880; c=relaxed/simple;
	bh=CIZy/jAORgCQmsD1NyLgCSqHutUS1C8cP3+JbGBMMII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YssVEfUlRJp1eNTt16z2jF9DEAbE0tIo1QXTLy+v88YIkhAMIE4rHw1h3JnisdZ8AXwIBU5CmkIvY3ijbE17poIzTcL4WDlLWf+MHDT8vJ0LzOYX3p9Zfe34kI0UO6JlmLWK5fRzLufeo51sc5lx+v+q5bScSquCDySpqpLDbo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=o/xWum0q; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1766944862; x=1767549662; i=j.neuschaefer@gmx.net;
	bh=iV+a3QU1u9zgF/HMHOcZk08Z+S1cfAayNrCh+S6rGB4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=o/xWum0qJKUl9QHSMpQxiaHs3CjPbdT42wa0ZzsbYRmid7flXgDks5mjjxFkHsXu
	 ScSsxOu5dmMuF7wNUuZdM2ckPeUHq89NUbb9ZlOrWfvyBNAN95wS8vTu9yCTW6vke
	 G0Gcb7+4AtxmWaYBCbI3ngXk8xrbjovCWng6txw6ZR6sUuRq9M0S1WFOQ1bVGXnVW
	 w/9Dza9g3JFHhCvN9cT0t4/2HyBWXqMQT6XvSxHb7hYZNpaOEgFFX93XhSG55NZXR
	 Ya6pezi/vNkdeS0bvrEzyo4pqxfVqOEGBFUbzMn3Iq+ygJ0MjQFURNtloeHIj0pFu
	 0uM3KSv3NyRlcEzscA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.100.107]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZTqW-1vOFwp44V4-00UhxV; Sun, 28
 Dec 2025 19:01:02 +0100
Date: Sun, 28 Dec 2025 19:01:01 +0100
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Josua Mayer <josua.mayer@jm0.eu>
Cc: j.neuschaefer@gmx.net, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] ARM: dts: imx: imx50-kobo-aura: add description for
 battery
Message-ID: <aVFwXWkPPW_kya-h@probook>
References: <20251227-kobo-aura-battery-v1-0-328a90ef5122@jm0.eu>
 <20251227-kobo-aura-battery-v1-3-328a90ef5122@jm0.eu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251227-kobo-aura-battery-v1-3-328a90ef5122@jm0.eu>
X-Provags-ID: V03:K1:JUO7iNWvAJ/9f1iaFck40NARVjqYVivDcImGNCcQqVWSr4RPV2q
 25sot2/5t6EQTCfh/PWxJoe5U4dAcasQbQSttMmL0/W7ml7Y92QtF2STiNyQLx2EgpxANog
 VXXYTqUTqNShOFwSylk7ukeJyXIyqPOwu+dFtvIHSSGNd+ksQ+HhM2WQCk0iRcz3EmW/1I8
 ibo44yDsohNA3CvSkcydw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6/irBIHuHR8=;Ugo7S7uqlCaAHffj0mDZGCiyZHf
 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
 OisbAgyvT2mbFRhzs=

On Sat, Dec 27, 2025 at 05:28:15PM +0100, Josua Mayer wrote:
> Kobo Aura has a rechargable battery that is monitored by the embedded
> controller.
>=20
> Battery markings: PR-285083 3.7V Typ. 1500mAh; 575327416288 5.55Wh.
>=20
> Add description for this battery and link it for monitoring by the
> embedded controller.
>=20
> Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
> ---

Reviewed-by: J. Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Thanks!

>  arch/arm/boot/dts/nxp/imx/imx50-kobo-aura.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/nxp/imx/imx50-kobo-aura.dts b/arch/arm/bo=
ot/dts/nxp/imx/imx50-kobo-aura.dts
> index b1a6a9c58ac33..dc8d9fd45cd23 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx50-kobo-aura.dts
> +++ b/arch/arm/boot/dts/nxp/imx/imx50-kobo-aura.dts
> @@ -16,6 +16,14 @@ chosen {
>  		stdout-path =3D "serial1:115200n8";
>  	};
> =20
> +	battery: battery {
> +		compatible =3D "simple-battery";
> +		voltage-min-design-microvolt =3D <3400000>;
> +		voltage-max-design-microvolt =3D <4100000>;
> +		energy-full-design-microwatt-hours =3D <5550000>;
> +		charge-full-design-microamp-hours =3D <1500000>;
> +	};
> +
>  	memory@70000000 {
>  		device_type =3D "memory";
>  		reg =3D <0x70000000 0x10000000>;
> @@ -151,6 +159,7 @@ embedded-controller@43 {
>  		system-power-controller;
>  		interrupts-extended =3D <&gpio4 11 IRQ_TYPE_EDGE_FALLING>;
>  		#pwm-cells =3D <2>;
> +		monitored-battery =3D <&battery>;
>  	};
>  };
> =20
>=20
> --=20
> 2.51.0
>=20

