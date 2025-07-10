Return-Path: <linux-pm+bounces-30629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A98B00C22
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 21:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777651CA0A11
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 19:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4CD288C80;
	Thu, 10 Jul 2025 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="kw7up1/5"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACE721B9F4;
	Thu, 10 Jul 2025 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752175850; cv=pass; b=VWTnB7C/OOA2xNpDjFUQ/eHhhU1Ps7XwRdojLaA2yHPdLIDNcjtYHUdh0pD/34l1E72HL32VHkMZiNIo1hqtQ4xZaVEtR4POOENfTgwbm/fnbgHZE6K/RsBDO1rk6cYeSajpk8XvcxiqMGzeVFtyWLpi+dX3pTvFJ+rkjxy6duc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752175850; c=relaxed/simple;
	bh=B0vHwcGOIIHb89H2gzxv6p6IhFT8hgODSk55/vhzf4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJgXcydhShmNBQP0hosgPDsDXjB+rCRQxVLqMKnpNTcATFdQ6EEeS4VFFsrIlxQa4opRfu6vLYA52njd3Fm56a5DDfEaHshzb6j01scebmXLczjhAWfyQoL5DIMCjvtfGBp0h42/98Ii8cVybQlbLHst6WkRkVpdlSmaUfaydRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=kw7up1/5; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752175820; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I/ka+SLGhV+QGCE7fhGV9qYnglLgy9/7ibP/VHkpOEkzzlN+hYr3n1hU+m0Czd3JuzQEcq3dJutzOQDlLs4uuTOHYI/Lj8p3iXdTFweEpCXHRjKKkqLQ24u3kz7ogTT6ITQRIH8buzu3rmYlidtSoboB93yZBpHRO+aGTxnuDY4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752175820; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2bzdLOutw45NuzUy8PqWXaJAtp7VYXU2KwETf6FwUq4=; 
	b=KGNFyCXuU/Eu7gI53XiCbXZ+2vpS1Ajv5tsP6P5DkQZQ7IogkRrzv2E2nSQ6QPoYGfJZFxB9rHfMFncR5gkPpshEpNmhmshWWYu93Hkr46rex2NKwDW57U5JARz8hTeTCfu6ErwawJQdGWt5x+2Gy63PfS87RHWiQxSiNu09gwk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752175820;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=2bzdLOutw45NuzUy8PqWXaJAtp7VYXU2KwETf6FwUq4=;
	b=kw7up1/5sk7CS9DwqFvhC738rMQmLkDy+YBescJyPukKyMiQXceMUwSSbDObh1iU
	ZFgMXP3VSkSTnRsOVkc3kmN5JNUm1ed5mQHxwFolk5+x8M8+Yi9IJdDT66VzpDBwZwD
	9Sono6bXrQ7cofGqQpGwIZMHjH9DgKP4GZKvxFWQ=
Received: by mx.zohomail.com with SMTPS id 1752175818697100.88359010230067;
	Thu, 10 Jul 2025 12:30:18 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Alexey Charkov <alchark@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v6 4/7] dt-bindings: thermal: rockchip: document otp thermal trim
Date: Thu, 10 Jul 2025 21:30:12 +0200
Message-ID: <6505070.lOV4Wx5bFT@workhorse>
In-Reply-To: <3592348.tdWV9SEqCh@phil>
References:
 <20250610-rk3576-tsadc-upstream-v6-0-b6e9efbf1015@collabora.com>
 <20250610-rk3576-tsadc-upstream-v6-4-b6e9efbf1015@collabora.com>
 <3592348.tdWV9SEqCh@phil>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, 10 July 2025 13:21:19 Central European Summer Time Heiko Stueb=
ner wrote:
> Am Dienstag, 10. Juni 2025, 14:32:40 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Nicolas Frattaroli:
> > Several Rockchip SoCs, such as the RK3576, can store calibration trim
> > data for thermal sensors in OTP cells. This capability should be
> > documented.
> >=20
> > Such a rockchip thermal sensor may reference cell handles that store
> > both a chip-wide trim for all the sensors, as well as cell handles
> > for each individual sensor channel pointing to that specific sensor's
> > trim value.
> >=20
> > Additionally, the thermal sensor may optionally reference cells which
> > store the base in terms of degrees celsius and decicelsius that the trim
> > is relative to.
> >=20
> > Each SoC that implements this appears to have a slightly different
> > combination of chip-wide trim, base, base fractional part and
> > per-channel trim, so which ones do which is documented in the bindings.
> >=20
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>=20
> Acked-by: Heiko Stuebner <heiko@sntech.de>
>=20
> with one question below
>=20
> > ---
> >  .../bindings/thermal/rockchip-thermal.yaml         | 61 ++++++++++++++=
++++++++
> >  1 file changed, 61 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal=
=2Eyaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> > index 49ceed68c92ce5a32ed8d4f39bd88fd052de0e80..573f447cc26ed7100638277=
598b0e745d436fd01 100644
> > --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> > @@ -40,6 +40,17 @@ properties:
> >        - const: tsadc
> >        - const: apb_pclk
> > =20
> > +  nvmem-cells:
> > +    items:
> > +      - description: cell handle to where the trim's base temperature =
is stored
> > +      - description:
> > +          cell handle to where the trim's tenths of Celsius base value=
 is stored
> > +
> > +  nvmem-cell-names:
> > +    items:
> > +      - const: trim_base
> > +      - const: trim_base_frac
> > +
>=20
> are we sure, we want underscores here?
> trim-base, trim-base-frac looks somewhat nicer.

a quick grep of all the bindings shows me that _ vs. - is about even.
I'm not sure deviating from what downstream calls it, what I already
sent, and what the already sent driver expects is really worth anyone's
time and mailbox space for what boils down to a matter of personal
preference.

>=20
> Heiko
>=20

Kind regards,
Nicolas Frattaroli





