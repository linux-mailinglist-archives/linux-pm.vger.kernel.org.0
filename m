Return-Path: <linux-pm+bounces-30592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5F9B004B9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 16:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F24AA7B9910
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 14:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BB327057C;
	Thu, 10 Jul 2025 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="eiI5L9tx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C461242D62;
	Thu, 10 Jul 2025 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156509; cv=none; b=Ux2gxVpGAw0taA9L2QjNmLSH+NXaMQzd/4442sxi05motFi6dNqB1Cf5WSyRfzXzpLOF1b3+YXgME9W0Rj7zwAokn0SkV0heRh3r5UZxE951bSYUA8DbnXXWJQ/ft0COmwpanL3l4USR2Hc4egegsK5vqHVbURdREcVdZir45vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156509; c=relaxed/simple;
	bh=6+V6b48EzWgWG8MSnsUjJWAfwO4HcQ599pAv9PMWIe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0fna1ZBCsiqel5mvDg9x+/Mvz+M5KpviulD9o3H1qP3u0yMx/e6W0abnlbkEz0Lz6baqp/+ET+3+eku0gxXBEzx/BL/6mpij9KzJccRF9p9/eTFx09T4EY2Prfo3DPEIIUUX6Quc77uVpN+dpKSIdZ9ORfRXHNTpCaEPe0hy/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=eiI5L9tx; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 807163D8570F;
	Thu, 10 Jul 2025 10:08:20 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id O8O26kgwxypV; Thu, 10 Jul 2025 10:08:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A7AE33D875E7;
	Thu, 10 Jul 2025 10:08:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com A7AE33D875E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1752156499; bh=EhdCuuk3MsnvKWneuePEB9v7psFEpBgaIrswFJsCaTM=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=eiI5L9txRHCopE2fnkP0oI2iR09ru1hhSxhD72AiJph9EmOfBFWozobaGPW96AJCg
	 y20ij65cW9KEn2XjyNQOPE65m6uIniR/s4iYaKCdfJmx+WkBXOV0mJHBnMZNmXNFqn
	 epC8zeVa3dGaPk/5jGzdzupceRde0cG3neSQFZD44FYUdaxnZL97VZMQyaDZ+xJgyq
	 +ywApD4UlTpFGG9/xevR+agtU/kSNGNvivGQ4lmfljx85CsIKXQb37kR2gM8JKOJGk
	 JrfZVByyinDxo4geIA6o8I951StEPiElJvF6PUPXhR2EPrUYt3jTwEE/8Sk3pRe0mJ
	 3ZzcN5cTuFweQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 8J66NYaKQAMU; Thu, 10 Jul 2025 10:08:19 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 595523D8570F;
	Thu, 10 Jul 2025 10:08:19 -0400 (EDT)
Date: Thu, 10 Jul 2025 10:08:18 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: devnull+samuel.kayode.savoirfairelinux.com@kernel.org, Frank.li@nxp.com,
	abelvesa@kernel.org, abelvesa@linux.com, b38343@freescale.com,
	broonie@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com, eballetbo@gmail.com, imx@lists.linux.dev,
	krzk+dt@kernel.org, lee@kernel.org, lgirdwood@gmail.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, robh@kernel.org, sre@kernel.org,
	yibin.gong@nxp.com
Subject: Re: [PATCH v8 2/6] mfd: pf1550: add core driver
Message-ID: <aG_JUhEQaiYQfJmz@fedora>
References: <20250707-pf1550-v8-0-6b6eb67c03a0@savoirfairelinux.com>
 <20250707-pf1550-v8-2-6b6eb67c03a0@savoirfairelinux.com>
 <0406698c-6534-4aca-8994-e8a69ecee2b2@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0406698c-6534-4aca-8994-e8a69ecee2b2@wanadoo.fr>
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 08, 2025 at 08:46:48PM +0200, Christophe JAILLET wrote:
> Le 07/07/2025 =E0 23:37, Samuel Kayode via B4 Relay a =E9crit=A0:
> > From: Samuel Kayode <samuel.kayode-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@p=
ublic.gmane.org>
> >=20
> > Add the core driver for pf1550 PMIC. There are 3 subdevices for which=
 the
> > drivers will be added in subsequent patches.
> >=20
> > Reviewed-by: Frank Li <Frank.Li-3arQi8VN3Tc@public.gmane.org>
> > Signed-off-by: Samuel Kayode <samuel.kayode-4ysUXcep3aM1wj+D4I0NRVaTQ=
e2KTcn/@public.gmane.org>
>=20
> Hi,
>=20
> some nitpicks and a few real questions.
>=20
> CJ
>=20
> ...
>=20
> > +	/* Add top level interrupts */
> > +	ret =3D devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap, pf155=
0->irq,
> > +				       IRQF_ONESHOT | IRQF_SHARED |
> > +				       IRQF_TRIGGER_FALLING,
> > +				       0, &pf1550_irq_chip,
> > +				       &pf1550->irq_data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Add regulator */
> > +	irq =3D regmap_irq_get_virq(pf1550->irq_data, PF1550_IRQ_REGULATOR)=
;
>=20
> Same as above.
>=20
> > +	if (irq < 0)
> > +		return dev_err_probe(pf1550->dev, irq,
> > +				     "Failed to get parent vIRQ(%d) for chip %s\n",
> > +				     PF1550_IRQ_REGULATOR, pf1550_irq_chip.name);
> > +
> > +	ret =3D devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap, irq,
> > +				       IRQF_ONESHOT | IRQF_SHARED |
> > +				       IRQF_TRIGGER_FALLING, 0,
> > +				       &pf1550_regulator_irq_chip,
> > +				       &pf1550->irq_data_regulator);
> > +	if (ret)
> > +		return dev_err_probe(pf1550->dev, ret,
> > +				     "Failed to add %s IRQ chip\n",
> > +				     pf1550_regulator_irq_chip.name);
> > +
> > +	domain =3D regmap_irq_get_domain(pf1550->irq_data_regulator);
> > +
> > +	ret =3D  devm_mfd_add_devices(pf1550->dev, PLATFORM_DEVID_NONE, reg=
ulator,
>=20
> 2 spaces after =3D
>
Will drop.
> > +				    1, NULL, 0, domain);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Add onkey */
> > +	irq =3D regmap_irq_get_virq(pf1550->irq_data, PF1550_IRQ_ONKEY);
>=20
> Same
>=20
> > +	if (irq < 0)
> > +		return dev_err_probe(pf1550->dev, irq,
> > +				     "Failed to get parent vIRQ(%d) for chip %s\n",
> > +				     PF1550_IRQ_ONKEY, pf1550_irq_chip.name);
> > +
> > +	ret =3D devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap, irq,
> > +				       IRQF_ONESHOT | IRQF_SHARED |
> > +				       IRQF_TRIGGER_FALLING, 0,
> > +				       &pf1550_onkey_irq_chip,
> > +				       &pf1550->irq_data_onkey);
> > +	if (ret)
> > +		return dev_err_probe(pf1550->dev, ret,
> > +				     "Failed to add %s IRQ chip\n",
> > +				     pf1550_onkey_irq_chip.name);
> > +
> > +	domain =3D regmap_irq_get_domain(pf1550->irq_data_onkey);
> > +
> > +	ret =3D  devm_mfd_add_devices(pf1550->dev, PLATFORM_DEVID_NONE, onk=
ey, 1,
>=20
> 2 spaces after =3D
>=20
Will drop.
> > +				    NULL, 0, domain);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Add battery charger */
> > +	irq =3D regmap_irq_get_virq(pf1550->irq_data, PF1550_IRQ_CHG);
>=20
> This calls irq_create_mapping().
> Should irq_dispose_mapping() or another helper be called in the error
> handling path and in the remove function, or is it already handled by a
> devm_ function?
>=20
This creates a mapping for the allocated `irq_data` runtime controller by
devm_regmap_add_irq. The `irq_data` is for the top level interrupts. Sinc=
e it
was allocated with a devm_, I think irq_dispose_mapping is called during =
a
remove.
> > +	if (irq < 0)
> > +		return dev_err_probe(pf1550->dev, irq,
> > +				     "Failed to get parent vIRQ(%d) for chip %s\n",
> > +				     PF1550_IRQ_CHG, pf1550_irq_chip.name);
> > +
> > +	ret =3D devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap, irq,
> > +				       IRQF_ONESHOT | IRQF_SHARED |
> > +				       IRQF_TRIGGER_FALLING, 0,
> > +				       &pf1550_charger_irq_chip,
> > +				       &pf1550->irq_data_charger);
> > +	if (ret)
> > +		return dev_err_probe(pf1550->dev, ret,
> > +				     "Failed to add %s IRQ chip\n",
> > +				     pf1550_charger_irq_chip.name);
> > +
> > +	domain =3D regmap_irq_get_domain(pf1550->irq_data_charger);
> > +
> > +	return devm_mfd_add_devices(pf1550->dev, PLATFORM_DEVID_NONE, charg=
er,
> > +				    1, NULL, 0, domain);
> > +}
> > +
> > +static int pf1550_suspend(struct device *dev)
> > +{
> > +	struct pf1550_ddata *pf1550 =3D dev_get_drvdata(dev);
> > +
> > +	if (device_may_wakeup(dev)) {
> > +		enable_irq_wake(pf1550->irq);
> > +		disable_irq(pf1550->irq);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int pf1550_resume(struct device *dev)
> > +{
> > +	struct pf1550_ddata *pf1550 =3D dev_get_drvdata(dev);
> > +
> > +	if (device_may_wakeup(dev)) {
> > +		disable_irq_wake(pf1550->irq);
> > +		enable_irq(pf1550->irq);
>=20
> Should this 2 lines be inverted?
>=20
I don't think it matters. disable_irq_wake is 'completely orthogonal' to =
the
enable/disable(irq). See function irq_set_irq_wake.
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> ...
>=20
> > +#define PF1550_CHG_LINEAR_ONLY		12
> > +#define PF1550_CHG_SNS_MASK		0xf
> > +#define PF1550_CHG_INT_MASK             0x51
>=20
> Space vs tab
>=20
Will make changes.
> > +
> > +#define PF1550_BAT_NO_VBUS		0
> > +#define PF1550_BAT_LOW_THAN_PRECHARG	1

Thanks,
Sam

