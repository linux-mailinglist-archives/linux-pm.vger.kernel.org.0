Return-Path: <linux-pm+bounces-28491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2035EAD58C0
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 16:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B48FE7A34EB
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 14:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8BB244678;
	Wed, 11 Jun 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="Ar4jT8v4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2496FBF;
	Wed, 11 Jun 2025 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652215; cv=none; b=YW/KGUrufW0zibexfGrNg601jqqcv9lkUZZ3FnBaY/nDc8yZO7IRTdI+UKH0yEGx0VJi3nYFWyeSr3P97PDlURQd0QWxFz5+3tDtyo/oQ5kwZ0JAAhUcuHEleBYiaOHbuK5/m2VKovjLXkhg8dxY41nuGFFMqKmltUizf2ipQI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652215; c=relaxed/simple;
	bh=EK7Ua+XxuKwvJrhmcdD2Nx6g8d0iUYoZdRE24xUl+jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gseb15KjH9VC6OrO5tBQ9+t6eTrKsgSGc9sPEZ+0FloGkNz6u6D+ImfdV8np3MXUbX8B6oWylg9WpJVEq13zYs/aaZu33Tpgo1MM5fMPmlrKKZpO2KVFKH/UA5Qv8SZdElfemet/MQJXzUPmxGTloLGlvNgNAA0n+lnBNmiNXEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=Ar4jT8v4; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id EFA7A3D88025;
	Wed, 11 Jun 2025 10:30:10 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 0AioK79u5rRX; Wed, 11 Jun 2025 10:30:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 282833D88026;
	Wed, 11 Jun 2025 10:30:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 282833D88026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1749652210; bh=eeeRtpM133CZLAcaCizEee0AzA7tK+TGafIv/V4LQ30=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=Ar4jT8v4pSlyj4nT4qzvMjSYIucGPmKdEPusGXABGOWTJDX3a7isZV0EGfwfpRdYh
	 9DoaqgfUss7mf8jTWWUn5BW5K3g8csexLmsUQp4IlaEKQytgP9CWB7N3gD6A55Cnm/
	 G18MnZYuKVLlzeaOzoPodGFFKg3u4vgFOM6hz1xV9qNMJZ4a2toVOiUm2YeEzJSAD1
	 AdvlWZSNa0l+ipI6y+8q7hgvykJwI4BcNgiSIMrbQUigD/d6WBZE6gsfil/dKZ06Zz
	 YBSu1Sss2tzZdY+20EHy0NqoxDsQhJReFWEeqXmSAi/xWKb4mf4Inpi1sMGoqdJn3n
	 lfVhoG1j5nXzg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Nreq9lvN9_Jw; Wed, 11 Jun 2025 10:30:09 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id C8BFD3D88025;
	Wed, 11 Jun 2025 10:30:09 -0400 (EDT)
Date: Wed, 11 Jun 2025 10:30:08 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
	Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v5 5/6] power: supply: pf1550: add battery charger support
Message-ID: <aEmS8N8gdz8-6GBD@fedora>
References: <20250610-pf1550-v5-0-ed0d9e3aaac7@savoirfairelinux.com>
 <20250610-pf1550-v5-5-ed0d9e3aaac7@savoirfairelinux.com>
 <aEifg/+mIuVVm6El@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEifg/+mIuVVm6El@lizhi-Precision-Tower-5810>

On Tue, Jun 10, 2025 at 05:11:31PM -0400, Frank Li wrote:
> > +static void pf1550_chg_vbus_work(struct work_struct *work)
> > +{
> > +	struct pf1550_charger *chg = container_of(to_delayed_work(work),
> > +						  struct pf1550_charger,
> > +						  vbus_sense_work);
> > +	unsigned int data;
> > +	bool psy_changed = false;
> > +
> > +	if (!chg->charger)
> > +		return;
> > +
> > +	if (regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_VBUS_SNS, &data)) {
> > +		dev_err(chg->dev, "Read VBUS_SNS error.\n");
> > +		return;
> > +	}
> > +
> > +	mutex_lock(&chg->mutex);
> > +
> > +	if (data & PF1550_VBUS_UVLO) {
> > +		chg->psy_desc.type = POWER_SUPPLY_TYPE_BATTERY;
> > +		psy_changed = true;
> > +		dev_dbg(chg->dev, "VBUS detached.\n");
> > +	}
> > +	if (data & PF1550_VBUS_IN2SYS)
> > +		dev_dbg(chg->dev, "VBUS_IN2SYS_SNS.\n");
> > +	if (data & PF1550_VBUS_OVLO)
> > +		dev_dbg(chg->dev, "VBUS_OVLO_SNS.\n");
> > +	if (data & PF1550_VBUS_VALID) {
> > +		chg->psy_desc.type = POWER_SUPPLY_TYPE_MAINS;
> > +		psy_changed = true;
> > +		dev_dbg(chg->dev, "VBUS attached.\n");
> > +	}
> > +
> > +	mutex_unlock(&chg->mutex);
> 
> not sure why need lock here, you just update chg->psy_desc.type?
>
It prevents concurrent access in this delayed work and in pf1550_reg_init.
However, it's unlikely that the probe is still active during the first execution
of the delayed work. So, i also think this mutex can be removed.
> > +
> > +	if (psy_changed)
> > +		power_supply_changed(chg->charger);
> > +}
> > +
> > +static irqreturn_t pf1550_charger_irq_handler(int irq, void *data)
> > +{
> > +	struct pf1550_charger *chg = data;
> > +	struct device *dev = chg->dev;
> > +	struct platform_device *pdev = to_platform_device(dev);
> > +	int i, irq_type = -1;
> > +
> > +	for (i = 0; i < PF1550_CHARGER_IRQ_NR; i++)
> > +		if (irq == platform_get_irq(pdev, i))
> > +			irq_type = i;
> > +
> > +	switch (irq_type) {
> > +	case PF1550_CHARG_IRQ_BAT2SOCI:
> > +		dev_info(dev, "BAT to SYS Overcurrent interrupt.\n");
> > +		break;
> > +	case PF1550_CHARG_IRQ_BATI:
> > +		schedule_delayed_work(&chg->bat_sense_work,
> > +				      msecs_to_jiffies(10));
> > +		break;
> > +	case PF1550_CHARG_IRQ_CHGI:
> > +		schedule_delayed_work(&chg->chg_sense_work,
> > +				      msecs_to_jiffies(10));
> > +		break;
> > +	case PF1550_CHARG_IRQ_VBUSI:
> > +		schedule_delayed_work(&chg->vbus_sense_work,
> > +				      msecs_to_jiffies(10));
> > +		break;
> > +	case PF1550_CHARG_IRQ_THMI:
> > +		dev_info(dev, "Thermal interrupt.\n");
> > +		break;
> > +	default:
> > +		dev_err(dev, "unknown interrupt occurred.\n");
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int pf1550_charger_probe(struct platform_device *pdev)
> > +	mutex_init(&chg->mutex);
...
> > +
> > +	INIT_DELAYED_WORK(&chg->vbus_sense_work, pf1550_chg_vbus_work);
> > +	INIT_DELAYED_WORK(&chg->chg_sense_work, pf1550_chg_chg_work);
> > +	INIT_DELAYED_WORK(&chg->bat_sense_work, pf1550_chg_bat_work);
...
> > +	ret = pf1550_reg_init(chg);

Thanks,
Sam

