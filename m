Return-Path: <linux-pm+bounces-40140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9867CEF369
	for <lists+linux-pm@lfdr.de>; Fri, 02 Jan 2026 20:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9A94300D65B
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jan 2026 19:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BE32BCF45;
	Fri,  2 Jan 2026 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="HS4uPEl9";
	dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="VfPQEo6t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE1131961F;
	Fri,  2 Jan 2026 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767380410; cv=pass; b=RXc5y681KvBxOL/jUTxx5x0579UTFM8lkF2g8Ew2kDsNw06AFF00uG4erjyzhrYY34jnz72aTEmqQMaT3V+ShlGPtaGgvVjHfWED+KYmRlguvCyR908rQuj101S7NasDt1gHpEjAIMfJY4lZHVenYw3OupbX02HtCMu+VDbC7Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767380410; c=relaxed/simple;
	bh=U5OAmAIUBkZjYBrSIJbc7l6a1zymYumUW8OA0QVQTM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qeq8EgGmVG6+QH6/AXw365f0Er+vmYpNRN3to12potZSEBXmSrGou/6ZiIOn4g3Le6Q8eESw2cFEa6doqgIW7QqQzytXfudvOkXDJgE2nRxDrmS4bZQzuJW9IHa78NAjiaC+zZdKsdkfXEukdM+q0SkGUD13eVh0UMoEt5BZN8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu; spf=none smtp.mailfrom=jm0.eu; dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=HS4uPEl9; dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=VfPQEo6t; arc=pass smtp.client-ip=85.215.255.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jm0.eu
ARC-Seal: i=1; a=rsa-sha256; t=1767379679; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FF1mhaLwEXV6c2uA2Ka4DoOiIr8oXvscuH3PfGytWJwfYWhp5f41eY+MnE6Y12GX9T
    PMMAg+mTiRx2nSs3Ikfh9KBgnkEXawyG0GXf7wubFdwWFAdCILH+92EnFW59rKVXSqtp
    keSN3tgOi6b9tprwzH7/BzlerMBW+zMF7tNHTJDyjL8qymmahA94dm6eKZ2v6y1jNq0S
    afDYoqgjJDLodMsQ/FVlrPyUA1lmbRNRKjJgFcRyL6zBSjY9+OJksAhEbQPaenvc+3iS
    /bd9qb2HucSzwO07HiYdvrO4EuWpjCf1qzX+4wmm0U4Mx+e5en4iiTqS74ARQDD8rGQU
    faYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767379679;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=j9EJ2X8RMS9IecySDKNE83h12NY8fqhR6DwLAlrRmCs=;
    b=A60BygkXpIdu95J6POmNu2s0BesoelcXa1Z6PiyS7tzYKBkjMVjy0iaKtT8escNRpw
    fWe+ItvVZ9vG1kZwUX8ysNoy8vdYWM0b02s2lRJKBQAVMYyOI64q3urieO6uL83tDfPF
    0vT5hbWJ4yFC1XqvrWwa1HqWsCjDsLeMZYknmO19YkR5bEQumaZrGHV3UakTanaYZxe9
    nVzrzK63SPl2AZ6dEvydVlu3bxSsAMF8cQK316Xm7DNTc+Z9IbjR+tCP4Gne2iOKPdnv
    FgczyH4U/VeQIendBIJaJj/7RCDacdFoD1xOPrGZqIKkdENDIPVkPtJVjIr6a/VIzD02
    9EBA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767379679;
    s=strato-dkim-0002; d=jm0.eu;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=j9EJ2X8RMS9IecySDKNE83h12NY8fqhR6DwLAlrRmCs=;
    b=HS4uPEl9TxCPlteJkHKB/3YESWvOJv1dWxiWcyyM1K39td6B1Ngbw9OIg4ze9xNxWo
    nQIVW88oL34eYPPAOjz4RzuMDmColNl75feDtECrAikh2tcdsKXFUGDCX+60/p7WgRvB
    shOhF+09uJq8JspCieR4EXNetzjDNzcaBVYyAinYies48QvrBKbty93PtR9ZkL1ynWXA
    zwQchSx+NgoMsGg/MV5azFJpoVWkiBLKRK/0uxdMcqSh/asa2q4pdhxFdGKakE7ew5td
    ru3tBwsNZw/JKBtqeCkgNcMZaILU+qZlrYxptx4T2eSCp7LyfgZO575CHHrc9B+bXE7j
    +qag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767379679;
    s=strato-dkim-0003; d=jm0.eu;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=j9EJ2X8RMS9IecySDKNE83h12NY8fqhR6DwLAlrRmCs=;
    b=VfPQEo6tUFQLxnxhUf1a/yYdohd8sf8DrrfbgUx2qRd2EAG6tfGnNhfMvDcD8IBBJy
    I3v1M4BpGQD/sIZuIdAw==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPUekEaRuJYlK1sYXypxVL0CQ9+6hiGfCNGIsC/uv4p9fxkB90Xm84033ewK4crZA="
Received: from localhost
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id z0d4ec202IlwEbp
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 2 Jan 2026 19:47:58 +0100 (CET)
Date: Fri, 2 Jan 2026 19:47:55 +0100
From: "Ing. Josua Mayer" <josua.mayer@jm0.eu>
To: Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>, Lee
 Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] power: supply: add battery driver for netronix ec
Message-ID: <20260102194755.000030a4@jm0.eu>
In-Reply-To: <20260102-kobo-aura-battery-v1-0-501f2a8fa575@jm0.eu>
References: <20260102-kobo-aura-battery-v1-0-501f2a8fa575@jm0.eu>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; i686-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Greetings everyone,

I made some mistake using "b4" on a different device,
and the v2 was not added as subject prefix.

I will try to fix it after hopefully some comments.

Am Fri, 02 Jan 2026 19:00:29 +0100
schrieb Josua Mayer <josua.mayer@jm0.eu>:

> This series adds a new battery driver for the netronix embedded
> controller multi-function device.
>=20
> Bindings are updated supporting a monitored battery, and battery
> description is added to kobo aura device-tree.
>=20
> Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
> ---
> Changes in v2:
> - Fixed identity mixup between from address and SoB.
>   (Reported-by: Krzysztof Kozlowski <krzk@kernel.org>)
> - Changed patch ordering, device-tree first.
> - Separated new driver and mfd subdevice changes into separate
> patches. (Reported-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>)
> - reworded Kconfig to explicitly mention device-tree
>   instead of vague firmware tables expression.
>   (Reported-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>)
>=20
> ---
> Josua Mayer (4):
>       dt-bindings: mfd: netronix,ntxec: add reference to power-supply
>       ARM: dts: imx: imx50-kobo-aura: add description for battery
>       power: supply: add battery driver for netronix ec
>       mfd: ntxec: register battery subdevice.
>=20
>  .../devicetree/bindings/mfd/netronix,ntxec.yaml    |   9 +-
>  arch/arm/boot/dts/nxp/imx/imx50-kobo-aura.dts      |   9 ++
>  drivers/mfd/ntxec.c                                |   1 +
>  drivers/power/supply/Kconfig                       |   9 ++
>  drivers/power/supply/Makefile                      |   1 +
>  drivers/power/supply/ntxec-battery.c               | 101
> +++++++++++++++++++++ 6 files changed, 127 insertions(+), 3
> deletions(-) ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251227-kobo-aura-battery-3e60bc159d16
>=20
> Best regards,


