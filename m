Return-Path: <linux-pm+bounces-18406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC719E141E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 08:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A051EB25DB8
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 07:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4CC19E968;
	Tue,  3 Dec 2024 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LD+qe9JU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459DD189F36
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210597; cv=none; b=IYh2Lx2ml2/0cQO/mBCgnjY45341ppU4nvfDsRjXgyBOVktlQUkUE9Aeai6HbtQ50y4QqKcTdGyncljCRQdD4rlDPQ8t77u4ioYn9X7V8Lqf+Dw2Fz/zpgAJe2TEcv0MuxEgH1vOSMJ5jCijiocDlyL13z/sDQzfLtFb2PF4itc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210597; c=relaxed/simple;
	bh=7PufCq3nC5zFU2FasV6TuJNdoNp9wubPx5T0RK6t1xA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Buf/sud2yljbH9oFTZ//ATfKuPW4jK0g0Fd/QhEiYZsGNxhuoE+TUx5m9d5vgaS4B9zY3s/moNeZY/Vfw/5hGuVMe+/3jCUAvl1rnPTpESq/0ecNsj2TmNtSf/RfCqJWl9xsKBvp1SoOuNvPSCpLn3OHF4B9zVwOVYWVb7UTwZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LD+qe9JU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385e06af753so2100470f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2024 23:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733210594; x=1733815394; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=har3faI8rWqjG1DeufIBkpWXrmN5D7dbzN2EbW5L5A4=;
        b=LD+qe9JUnpYmZ3nWocSmgQlbgwWWeR4GLubdSPv71j4i18tawxvzJlUk64BhMoGRVm
         h0HyAyWPfKA+u/2fW3+T/gW2kQ604k0tkw9X+ICOj0PRae0PoM5EnyBtR+CCXSPK0cTY
         n0AQ+0NBeWACaDekP8oB49A2DDkGj1OQbZFWKCy4M20iWEDaaPzTRIn824qhbOraRtVG
         07wUQFnQcTy1WzvA0jk+WV+5+bJuqoQMbZjSEi8guJpYzX5bkKq4rZJ38rwawfrAyCIw
         K0Ivz0lbNE5Js1npKDUTpAA6BqmBazBSuo0NrBIJalWXdZ1imLBFZC3nuADXnMExEu9c
         VWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733210594; x=1733815394;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=har3faI8rWqjG1DeufIBkpWXrmN5D7dbzN2EbW5L5A4=;
        b=e/244UlTzxMXB9hiWRzRHEIzw4uciwUFhOJ5SXPqJpWwc0DAoKPxd5yYuvNyJsCXrT
         EPL83h3Q/ZiDc3H019YfAtU5+ULmkPggIjYFVIJAB956z6tGRakaQonBDUTNlG+mZujG
         zIO7S/aUbRf0Wcgao3ibsrqi5xnOADP0W2Or45X+zG6PjS8lFg9ppz5D+k8GJavrYRL5
         lH7o5pN7nsqhUH1Cz0anjMmPMiTcBGIDcpMNVgsgvh+3VM79EmsatKGTO7C6A20ynhrg
         1Vde/8hSHx1Q26ZtQzCiuY9rhUr5f2BsQMoVB5r0T3WfOGoQaR1IqkA7uPkZg8T03jAS
         De6Q==
X-Gm-Message-State: AOJu0YyqrZ4UHN08vyj1Fey8dYZ/+M+QQubuFtCPXi02uj+maCAcsRU6
	bQrbrQIZuSKszEI48IhTKu/e23HbvHosw3qscKGMsaIMVvNps+AN8Qjw06r/CBk=
X-Gm-Gg: ASbGnctHOuEqGUTUmOkE18y01Mad4ILWiMwxsyltCBpb08oW+w7M7pd8z3JrVLUxLlB
	dapLU7gRvyKiBQq4L9Ly8NjgJE0DW9pu0tkrcaZHgWjAekRmztbtNvuEXtyUIBW+bNYq4pP4Qy0
	4Hx0sXHyrMTlp5UjASFnlMU+oB0aJG8B0Sb94Fpfx1rJHt61C5IO7jbbWoBmaf3YBBU46TgRt4M
	6q8JhKu0ttY11pPIlKawV6WPWfkmiEyDJQ0aQKtKEHEhSJjQXVDLRQ=
X-Google-Smtp-Source: AGHT+IG/NOcXjFAExqQ0F5f6jl7y9cNorOaeuQVYtVLDO/J9NGcpJBFDj38O5aqVvTeq5nIo+I6kZg==
X-Received: by 2002:a5d:648f:0:b0:385:e36a:e19f with SMTP id ffacd0b85a97d-385fd419194mr994522f8f.41.1733210593694;
        Mon, 02 Dec 2024 23:23:13 -0800 (PST)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385dec66e0esm12193749f8f.43.2024.12.02.23.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:23:13 -0800 (PST)
Message-ID: <8f585460a1bc52f78a6d0867aed87398bde30152.camel@linaro.org>
Subject: Re: [PATCH 1/4] power: supply: add support for max77759 fuel gauge
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: t.antoine@uclouvain.be, Sebastian Reichel <sre@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Peter
 Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Date: Tue, 03 Dec 2024 07:23:12 +0000
In-Reply-To: <c377f3302c6c282ad826211c859e2b65bb1222cb.camel@linaro.org>
References: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
	 <20241202-b4-gs101_max77759_fg-v1-1-98d2fa7bfe30@uclouvain.be>
	 <c377f3302c6c282ad826211c859e2b65bb1222cb.camel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-12-03 at 06:47 +0000, Andr=C3=A9 Draszik wrote:
> Hi Thomas,
>=20
> Thanks for looking into this!
>=20
> > From: Thomas Antoine <t.antoine@uclouvain.be>
> >=20
> > The Maxim max77759 fuel gauge has the same interface as the Maxim max17=
20x
> > except for the non-volatile memory slave address which is not available=
.
>=20
> It is not fully compatible, and it also has a lot more registers.
>=20
> For example, the voltage now is not in register 0xda as this driver assum=
es.
> With these changes, POWER_SUPPLY_PROP_VOLTAGE_NOW just reads as 0. 0xda
> doesn't exist in max77759
>=20
> I haven't compared in depth yet, though.

Regarding the regmap in this driver, please see below comparison I had
collected some time ago:

	regmap_reg_range(0x24, 0x26), // exists
	regmap_reg_range(0x30, 0x31), // exists
	regmap_reg_range(0x33, 0x34), // exists
	regmap_reg_range(0x37, 0x37), // exists
	regmap_reg_range(0x3B, 0x3C), // exists
	regmap_reg_range(0x40, 0x41), // exists
	regmap_reg_range(0x43, 0x44), // exists
	regmap_reg_range(0x47, 0x49), // exists
	regmap_reg_range(0x4B, 0x4C), // exists
	regmap_reg_range(0x4E, 0xAF), // 0x4e 0x4f exists
	regmap_reg_range(0xB1, 0xB3), // exists
	regmap_reg_range(0xB5, 0xB7), // exists
	regmap_reg_range(0xBF, 0xD0), // 0xd0 exists
	0xd1 .. 0xdb don't exist
	regmap_reg_range(0xDB, 0xDB),
	regmap_reg_range(0xE0, 0xFF), // 0xfb 0xff exist

the comments refer to whether or not the register exists in max77759

>=20
> > No slave is available at address 0xb of the i2c bus, which is coherent
> > with the following driver from google: line 5836 disables non-volatile
> > memory for m5 gauge.
> >=20
> > Link:
> > https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef=
474573cc8629cc1d121eb6a81ab68c/max1720x_battery.c
> >=20
> > Add support for the max77759 by allowing to use the non-volatile
> > memory or not based on the chip. Value for RSense comes from the follow=
ing
> > stock devicetree:
> >=20
> > Link:
> > https://android.googlesource.com/kernel/devices/google/gs101/+/33eca36d=
43da6c2b6a546806eb3e7411bbe6d60d/dts/gs101-raviole-battery.dtsi
> >=20
> > Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> > ---
> > =C2=A0drivers/power/supply/max1720x_battery.c | 71 ++++++++++++++++++++=
+++++++-
> > -----
> > =C2=A01 file changed, 59 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/max1720x_battery.c
> > b/drivers/power/supply/max1720x_battery.c
> > index
> > 33105419e2427bb37963bda9948b647c239f8faa..faf336938dd4306dd2ceeb0a84b90=
ca8
> > 0ad41a9f 100644
> > --- a/drivers/power/supply/max1720x_battery.c
> > +++ b/drivers/power/supply/max1720x_battery.c
> > @@ -13,6 +13,7 @@
> > =C2=A0#include <linux/nvmem-provider.h>
> > =C2=A0#include <linux/power_supply.h>
> > =C2=A0#include <linux/regmap.h>
> > +#include <linux/types.h>
>=20
> Please keep file names in alphabetical order.

Ignore that, it's too early :-)



Cheers,
Andre'


