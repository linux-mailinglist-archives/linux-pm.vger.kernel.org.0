Return-Path: <linux-pm+bounces-31059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691ABB0A4EB
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 15:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504F13A2916
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 13:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BA92DC32A;
	Fri, 18 Jul 2025 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="lqBr9JbL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AA82E370B;
	Fri, 18 Jul 2025 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752844595; cv=none; b=Ll3QcaMTC1NM2P4h8EsldQAi30KyIiACiWVHj5BmFcdIiUzni+vdDF34kCTzFAi8+TAY4AXz0JfKf2rWoYEa/tu6F9ACVOxb2WU1KQ4Zbw4zpSESJmYN4Ee5lHytea/uFB5enhGfKZKpBLYmomJ2lReYnnMi+InZADR4Wb3hfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752844595; c=relaxed/simple;
	bh=aRnDQrCYUBk/LDKhnGyuWMtVBPgBQdZosKC63wybPCc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4gI5eXAAPJm+dw+UmWMKGw5HRgrdPISrI+hU1knkJ5w8zIX+InmP8TFbkPzfSVfG3SGKr6wW133Y6ZSL+6TxUpsXmOvuBOLcC+mpmIgd7Fmj5sxo0L9Co3Sl4kH88pEAtQN62WwSzhENVvC7jXAf1GgXeErJ4ZCyFrZ9Espf7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=lqBr9JbL; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752844584; x=1753103784;
	bh=w5mFdxT2E55cBl/6uXS9G8hfrL+IO2X+Cc4+swbUN2Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lqBr9JbLrA3cUDVZDcRJPSh39bcoH7zgIMzkz8a4SdXkc0E+qtkBvKzQp3mmShmeO
	 mSHJBcYCHZPv5S1bRioStQq16a/U9ov1c2wPakrJDU97nJc0ILifinIxWj6S+dt/CI
	 4vJFEbeY7TWT4JGTaxfOEmJQ6kbDwJbGOvlJovcQpnfiSIN1nfhXRPdntRx6SNgkvb
	 uBY15upqiIqIX5IWYBAlXMkpwT8Xp1v8m1iNBPv2La0JgkJEEFxZYiZjWhBkehCnbh
	 Gc7Dl/C/qXfXucvhWitKrRRuSFikUhQo5F94V+tXBaTQq7jeGg4ypHb8LZyRFRTesh
	 OmIe96G8Epcqw==
Date: Fri, 18 Jul 2025 13:16:16 +0000
To: samuel.kayode@savoirfairelinux.com
From: Sean Nyekjaer <sean@geanix.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>, imx@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v9 4/6] input: pf1550: add onkey support
Message-ID: <67ki6m7dg5sbh7wknrnlermv5l3pw5fyx4agjtljbv54e5pxyj@d3l5jbz7osiz>
In-Reply-To: <20250716-pf1550-v9-4-502a647f04ef@savoirfairelinux.com>
References: <20250716-pf1550-v9-0-502a647f04ef@savoirfairelinux.com> <20250716-pf1550-v9-4-502a647f04ef@savoirfairelinux.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: b4707700d9b27a7fb9b454f27aadd55bfec2e4c5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 11:11:47AM +0100, Samuel Kayode via B4 Relay wrote:
> From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
>=20
> Add support for the onkey of the pf1550 PMIC.
>=20
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> ---

[...]

> +
> +static int pf1550_onkey_probe(struct platform_device *pdev)
> +{
> +=09struct onkey_drv_data *onkey;
> +=09struct input_dev *input;
> +=09bool key_power =3D false;
> +=09int i, irq, error;
> +
> +=09onkey =3D devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
> +=09if (!onkey)
> +=09=09return -ENOMEM;
> +
> +=09onkey->dev =3D &pdev->dev;
> +
> +=09onkey->pf1550 =3D dev_get_drvdata(pdev->dev.parent);
> +=09if (!onkey->pf1550->regmap)
> +=09=09return dev_err_probe(&pdev->dev, -ENODEV,
> +=09=09=09=09     "failed to get regmap\n");
> +
> +=09onkey->wakeup =3D device_property_read_bool(pdev->dev.parent,
> +=09=09=09=09=09=09  "wakeup-source");
> +
> +=09if (device_property_read_bool(pdev->dev.parent,
> +=09=09=09=09      "nxp,disable-key-power")) {
> +=09=09error =3D regmap_write(onkey->pf1550->regmap,
> +=09=09=09=09     PF1550_PMIC_REG_PWRCTRL1, 0);

I would use regmap_clear_bits() here.

/Sean


