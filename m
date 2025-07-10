Return-Path: <linux-pm+bounces-30560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D03B00072
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 13:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A773B5B84
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 11:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902F32E5B13;
	Thu, 10 Jul 2025 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="oWqA3t5F"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29364295530;
	Thu, 10 Jul 2025 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146492; cv=none; b=Hap13xGPmR+OGj8e36l1larTM5tZJDRV1P9ycvBIYR+SltSkrg4EV5UiMPMrx3Cmi4N/inrTziCmRDYW2rZNjgrL0S3YEX6GVaYg0x0WlAPwaJSv9dsCh7C1/qqLpl/c9bEyjxKMU4pUmHIw7i6mKeFuxAdQGjUpu3XlM7nQ18g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146492; c=relaxed/simple;
	bh=FlM00GdyojsKlhNyqQ60miBTBWWfQWeTdhmPstM0OXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GMwfU8p5rEDLferd3RbE/JlaSmKOzrnk+YZIDaBTibCUlGsS/Ws++ChzlmL98jQMwYdmSBYSnRUkvdqQtvGSjAqeMmQisjQ/PONdl4gym8T/RL3O6CSMqLVngg4/6YxEnNllJEUNBsdlIjkuOrzdIvScK74aGzOHusxStoLqXJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=oWqA3t5F; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=44pTvFaVwV8DGemXvVyLFKizLr/RNUQE/CGSbN7Xx/4=; b=oWqA3t5FpiwDDXz3OxYTP0050s
	uo4AjZyZHhIUBwCD3rcwbx1oUdmgKY/XOq8QfxELCK0s0b6ROHLFRy0hpIm1B2jYOnC2k9yQEoxyo
	CAUJB8l3om1s7GESdPFCQaYxCQf6QF30ziZ9hTXT5L7163S4KBLqsf2hUVPUMiBfwaZxvp/QrDk31
	Q1rNS16MOCr9O3SY3PK5WJrNZtvqKaEvgth0l6a+tQg1c3zAIyf/LWtsBsCYF7HG0mmaitsPwMeHW
	svILvWuLii/xUsSMZYLlFz+AauuNXHNxM3oIQEetbP2yJm40YmcesL5jG8PDCGmewJtxxIPQnwACz
	f6WwTd7Q==;
Received: from [194.95.143.137] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZpL6-0004SZ-8y; Thu, 10 Jul 2025 13:21:20 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Alexey Charkov <alchark@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject:
 Re: [PATCH v6 4/7] dt-bindings: thermal: rockchip: document otp thermal trim
Date: Thu, 10 Jul 2025 13:21:19 +0200
Message-ID: <3592348.tdWV9SEqCh@phil>
In-Reply-To: <20250610-rk3576-tsadc-upstream-v6-4-b6e9efbf1015@collabora.com>
References:
 <20250610-rk3576-tsadc-upstream-v6-0-b6e9efbf1015@collabora.com>
 <20250610-rk3576-tsadc-upstream-v6-4-b6e9efbf1015@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 10. Juni 2025, 14:32:40 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Nicolas Frattaroli:
> Several Rockchip SoCs, such as the RK3576, can store calibration trim
> data for thermal sensors in OTP cells. This capability should be
> documented.
>=20
> Such a rockchip thermal sensor may reference cell handles that store
> both a chip-wide trim for all the sensors, as well as cell handles
> for each individual sensor channel pointing to that specific sensor's
> trim value.
>=20
> Additionally, the thermal sensor may optionally reference cells which
> store the base in terms of degrees celsius and decicelsius that the trim
> is relative to.
>=20
> Each SoC that implements this appears to have a slightly different
> combination of chip-wide trim, base, base fractional part and
> per-channel trim, so which ones do which is documented in the bindings.
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>

with one question below

> ---
>  .../bindings/thermal/rockchip-thermal.yaml         | 61 ++++++++++++++++=
++++++
>  1 file changed, 61 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.y=
aml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> index 49ceed68c92ce5a32ed8d4f39bd88fd052de0e80..573f447cc26ed710063827759=
8b0e745d436fd01 100644
> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> @@ -40,6 +40,17 @@ properties:
>        - const: tsadc
>        - const: apb_pclk
> =20
> +  nvmem-cells:
> +    items:
> +      - description: cell handle to where the trim's base temperature is=
 stored
> +      - description:
> +          cell handle to where the trim's tenths of Celsius base value i=
s stored
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: trim_base
> +      - const: trim_base_frac
> +

are we sure, we want underscores here?
trim-base, trim-base-frac looks somewhat nicer.

Heiko



