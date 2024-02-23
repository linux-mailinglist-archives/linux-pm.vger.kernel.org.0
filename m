Return-Path: <linux-pm+bounces-4357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 756A6861DC1
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 21:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033C61F24706
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 20:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FD6146E76;
	Fri, 23 Feb 2024 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZ4kBtAC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC9142649;
	Fri, 23 Feb 2024 20:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720899; cv=none; b=QAFZyaVrsLo+SASQjUzMCiNpeG/Es73rMKki+hLBMy1uidvVHTIL8YvfzmBW9aANyUnafYQVuLd0yhUh2WJvJnCC0aDsskKXXckG1/gEvP4kce2q/8sC+pxuUeQIIwbE8Q/hq1HHmvqlBUnbXvdG3U5cZbMG3Lf2msSKBOVuoeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720899; c=relaxed/simple;
	bh=h7Lx0jQ4dl7jKRJSCenNZoCOEDhfi18hDxw3dD5ReaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gelyf4QfSvyYBSIhaX/Zqb5DLkX48JBMGXL6ltnS5GfdV4K46Dzxp0JHBY/TSc+8L+q5c+WWYBd6Mn71b/v/PLfVGNjB9MvlMUemsUfXzZJjkvCcKO6X6S8357XCiMXI2zcjy4pMlrY9dlVNo2y21eor2l2+8Js1kGk4OpygF8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZ4kBtAC; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so1602239a12.1;
        Fri, 23 Feb 2024 12:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708720896; x=1709325696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfQMOvarM5YXluKmxjyf8kg0u/LvgCShKkrNwvbX5RY=;
        b=MZ4kBtACOUZ2aSP/1YouT04Bzi51dIR5vln3/cRWKK7UIZ0PXkF/3qULOz0fC1dka1
         6rpdjSX5fBU5lskGjKNNIEVroxo8YjS5jNGhB0h0/zNy6fuVeUdpsj7GzDPcZDWm1GtN
         F3HujEJMNS3D7JOoizCAFpCiiCqgD1kNbujqiKezaEo8Bzb9NtI/2lS0W8KHTe1N5vkc
         1343YPkFGMOcwtPOis7mATKKJDEaKOI32MnqrCfunY8OpK5R2PDBAy28sanCHt0nkuqi
         x+Yw+qPgeVNMNgeQwkpyHrSmlUXeXnpOBUqHcB7gaVF+F883Dkg7mtuhgY2T8oUwW+JP
         JZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708720896; x=1709325696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfQMOvarM5YXluKmxjyf8kg0u/LvgCShKkrNwvbX5RY=;
        b=LLJVbM3p6KAnFbGV58waAB85kFNipo1bo4EQosRyxYqAyNCLaJzt/S6ATphKGFZzEY
         RCNU9uET+nP3Aq+MW+K/TDXTzIDt17U5Yi7JEIi8JIi9GMxcvkm4Qv/Yk17cLzJyfong
         +Cktr9oN3jPpmWtm/i7JINjWt97x9uDtMRitE0ccm+XmEbu6RrG9QS81hj6mK6p00mr2
         2fYqeonSMkdXYJRVPJZdT1RpsGazwnd1abcyt9EU4tnZyEnLUeJ2epha2qjD2RCMAfH9
         OPby8g2elL95HUQUx2iZyOEcBmqZwcZjHrxQI3J+6ewv+kxremVgk6iUobF/skN1EH/q
         3iYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtA/COutFhad1xNgvgun2cB26xnqmDFNvRPYdmuJTgnOFEpDUemMrBWBv8IGaOHtQdsPaL24S4PK3+egjOpU27QDqVwrEDl9gK/SUxSRB4AGsArnAWv78TMwuvQTm31kTLjW9h
X-Gm-Message-State: AOJu0YwMfcSI0PkKJUJz016JLLXSDPkRMgXT+J2d8dkaS4PpUPdJADIX
	l+hycsIxx/bTxkh64mLi7M0IHVaPweZyFro4DSlSntH0JV23uzae
X-Google-Smtp-Source: AGHT+IF/qpn86Bjd0nToevWU3u82HCSLTOOj3XhqK/HahY6igDRqhNN2SlnXNlbV8okxQWXuvNuYcg==
X-Received: by 2002:aa7:c64d:0:b0:565:9938:a881 with SMTP id z13-20020aa7c64d000000b005659938a881mr225843edr.36.1708720895972;
        Fri, 23 Feb 2024 12:41:35 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id k20-20020aa7c054000000b005657eefa8e9sm603852edo.4.2024.02.23.12.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 12:41:35 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
 Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Martin Botka <martin.botka@somainline.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Bob McChesney <bob@electricworry.net>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject:
 Re: [PATCH v5 7/7] arm64: dts: allwinner: h616: Add thermal sensor and zones
Date: Fri, 23 Feb 2024 21:41:34 +0100
Message-ID: <4545502.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <6017645.lOV4Wx5bFT@jernej-laptop>
References:
 <20240219153639.179814-1-andre.przywara@arm.com>
 <20240219153639.179814-8-andre.przywara@arm.com>
 <6017645.lOV4Wx5bFT@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne petek, 23. februar 2024 ob 20:59:08 CET je Jernej =C5=A0krabec napisal(=
a):
> Dne ponedeljek, 19. februar 2024 ob 16:36:39 CET je Andre Przywara napisa=
l(a):
> > From: Martin Botka <martin.botka@somainline.org>
> >=20
> > There are four thermal sensors:
> > - CPU
> > - GPU
> > - VE
> > - DRAM
> >=20
> > Add the thermal sensor configuration and the thermal zones.
> >=20
> > Signed-off-by: Martin Botka <martin.botka@somainline.org>
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>=20
> I can't cleanly apply patch on top of sunxi/dt-for-6.9. Can you please re=
base?

I rebased and applied. Thanks!
=20
Best regards,
Jernej

> > ---
> >  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 88 +++++++++++++++++++
> >  1 file changed, 88 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm6=
4/boot/dts/allwinner/sun50i-h616.dtsi
> > index 12ffabc79bcde..7c7d7c285505c 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > @@ -9,6 +9,7 @@
> >  #include <dt-bindings/clock/sun6i-rtc.h>
> >  #include <dt-bindings/reset/sun50i-h616-ccu.h>
> >  #include <dt-bindings/reset/sun50i-h6-r-ccu.h>
> > +#include <dt-bindings/thermal/thermal.h>
> > =20
> >  / {
> >  	interrupt-parent =3D <&gic>;
> > @@ -138,6 +139,10 @@ sid: efuse@3006000 {
> >  			reg =3D <0x03006000 0x1000>;
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> > +
> > +			ths_calibration: thermal-sensor-calibration@14 {
> > +				reg =3D <0x14 0x8>;
> > +			};
> >  		};
> > =20
> >  		watchdog: watchdog@30090a0 {
> > @@ -517,6 +522,19 @@ mdio0: mdio {
> >  			};
> >  		};
> > =20
> > +		ths: thermal-sensor@5070400 {
> > +			compatible =3D "allwinner,sun50i-h616-ths";
> > +			reg =3D <0x05070400 0x400>;
> > +			interrupts =3D <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks =3D <&ccu CLK_BUS_THS>;
> > +			clock-names =3D "bus";
> > +			resets =3D <&ccu RST_BUS_THS>;
> > +			nvmem-cells =3D <&ths_calibration>;
> > +			nvmem-cell-names =3D "calibration";
> > +			allwinner,sram =3D <&syscon>;
> > +			#thermal-sensor-cells =3D <1>;
> > +		};
> > +
> >  		usbotg: usb@5100000 {
> >  			compatible =3D "allwinner,sun50i-h616-musb",
> >  				     "allwinner,sun8i-h3-musb";
> > @@ -761,4 +779,74 @@ r_rsb: rsb@7083000 {
> >  			#size-cells =3D <0>;
> >  		};
> >  	};
> > +
> > +	thermal-zones {
> > +		cpu-thermal {
> > +			polling-delay-passive =3D <500>;
> > +			polling-delay =3D <1000>;
> > +			thermal-sensors =3D <&ths 2>;
> > +			sustainable-power =3D <1000>;
> > +
> > +			trips {
> > +				cpu_threshold: cpu-trip-0 {
> > +					temperature =3D <60000>;
> > +					type =3D "passive";
> > +					hysteresis =3D <0>;
> > +				};
> > +				cpu_target: cpu-trip-1 {
> > +					temperature =3D <70000>;
> > +					type =3D "passive";
> > +					hysteresis =3D <0>;
> > +				};
> > +				cpu_critical: cpu-trip-2 {
> > +					temperature =3D <110000>;
> > +					type =3D "critical";
> > +					hysteresis =3D <0>;
> > +				};
> > +			};
> > +		};
> > +
> > +		gpu-thermal {
> > +			polling-delay-passive =3D <500>;
> > +			polling-delay =3D <1000>;
> > +			thermal-sensors =3D <&ths 0>;
> > +			sustainable-power =3D <1100>;
> > +
> > +			trips {
> > +				gpu_temp_critical: gpu-trip-0 {
> > +					temperature =3D <110000>;
> > +					type =3D "critical";
> > +					hysteresis =3D <0>;
> > +				};
> > +			};
> > +		};
> > +
> > +		ve-thermal {
> > +			polling-delay-passive =3D <0>;
> > +			polling-delay =3D <0>;
> > +			thermal-sensors =3D <&ths 1>;
> > +
> > +			trips {
> > +				ve_temp_critical: ve-trip-0 {
> > +					temperature =3D <110000>;
> > +					type =3D "critical";
> > +					hysteresis =3D <0>;
> > +				};
> > +			};
> > +		};
> > +
> > +		ddr-thermal {
> > +			polling-delay-passive =3D <0>;
> > +			polling-delay =3D <0>;
> > +			thermal-sensors =3D <&ths 3>;
> > +
> > +			trips {
> > +				ddr_temp_critical: ddr-trip-0 {
> > +					temperature =3D <110000>;
> > +					type =3D "critical";
> > +					hysteresis =3D <0>;
> > +				};
> > +			};
> > +		};
> > +	};
> >  };
> >=20
>=20
>=20
>=20
>=20
>=20





