Return-Path: <linux-pm+bounces-30703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DC0B021BB
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 18:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BFF81C4707A
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 16:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8E22EF2BA;
	Fri, 11 Jul 2025 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="wFYIrYKK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206A32EF2A4;
	Fri, 11 Jul 2025 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251267; cv=none; b=IASO+/J6pPibc6dhoK+2TcbpYOlTSF600CsCN1y6mC8OkY6sGHPptzMIqYyOJc5/2O8tJQlY4VY8XyjBUUP5VkjuWS+JS/0NZe4wFhbrCy5RsI2ZCl9XkNlwsqTe145KBoPoL+Y0qjADg4LaK7/YucuNP6NvFRrqiW4eAHupf9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251267; c=relaxed/simple;
	bh=p5v1EtMD51u1KHquHZqIS2exV6FPTpr5oUVUdI6LNus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MddO9tH9HLeC5+H502S7OzEqZTIdTXIUn8eNnQpJ+tCp8nwliq12Ig0ZEmpvI7/Xn8os2TJlaNPAE3QrVI54jc7LM4wcbKpbQlRUGdKq6xZXbI5pLsLTmgonfN3ZiewwU7Z4+C7RP8j5QRRTmUT1HvPug9wdIjnRQz2GlqwV3FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=wFYIrYKK; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3AFB63D8766E;
	Fri, 11 Jul 2025 12:27:38 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id qHeJ5v5rpaBn; Fri, 11 Jul 2025 12:27:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7599E3D88021;
	Fri, 11 Jul 2025 12:27:37 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 7599E3D88021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1752251257; bh=YzdULXl7BbVQ37/QpOsk673Q8jqQ7vEJz2f+cjdjd5I=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=wFYIrYKK/Xnd+rJDqR+VfHI/8Rs7T/JycchX7XBWtDwm7Cq8ZVPF5ynsfYC5D3xOs
	 qhF27/9+D6gdE1HlrYADMuPY5UiQqwRWJasx5PZDJQyhXh6/e+KNKIDHAk9Xf/dHoJ
	 eHGEEJ/DFnRA5rz7oxK+l3+KFK0MJupqrGIIvPIUoQyLRm3LvZr/s7tHoyoq3z7suI
	 K3g4/r7dVWzjgfHd2XuSMFjhWehDhOpgVV8uGwrvkNHf9W1cbhvpKZ85KPFJrxL0Jx
	 dnj4AJbYu3xdZLDVZL3bv+LfxjS8DEXrCltUY3/9EwxId+X3QdCuKIWgxGzW4a0ho+
	 AL8WYRAeRDfwg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id XvZUh_E28-ls; Fri, 11 Jul 2025 12:27:37 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 1DDA73D8766E;
	Fri, 11 Jul 2025 12:27:37 -0400 (EDT)
Date: Fri, 11 Jul 2025 12:27:35 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
	Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v8 5/6] power: supply: pf1550: add battery charger support
Message-ID: <aHE7d3gDITZMWEcH@fedora>
References: <20250707-pf1550-v8-0-6b6eb67c03a0@savoirfairelinux.com>
 <20250707-pf1550-v8-5-6b6eb67c03a0@savoirfairelinux.com>
 <e2veigexln4ma5meguxqh6jh2r2fhj2d47pv4exjzwrhlazn7d@raknfsiucqls>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2veigexln4ma5meguxqh6jh2r2fhj2d47pv4exjzwrhlazn7d@raknfsiucqls>

On Fri, Jul 11, 2025 at 09:02:18AM +0000, Sean Nyekjaer wrote:
> > +#define PF1550_DEFAULT_THERMAL_TEMP	75
> 
> Default is 95
>
Will make changes.
> > +
> > +static int pf1550_set_thermal_regulation_temp(struct pf1550_charger *chg,
> > +					      unsigned int cells)
> > +{
> > +	unsigned int data;
> > +
> > +	switch (cells) {
> > +	case 60:
> > +		data = 0x0;
> > +		break;
> > +	case 75:
> > +		data = 0x1;
> > +		break;
> > +	case 90:
> > +		data = 0x2;
> > +		break;
> > +	case 105:
> > +		data = 0x3;
> > +		break;
> 
> From the datasheet 80, 95, 110 and 125c is supported
>
Yeah, the temp values should be as you mentioned. I'll be replacing the current
temperature range.
> > +	default:
> > +		return dev_err_probe(chg->dev, -EINVAL,
> > +				     "Wrong value for thermal temperature\n");
> > +	}
> > +
> > +	data <<= PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_SHIFT;
> > +
> > +	dev_dbg(chg->dev, "Thermal regulation loop temperature: %u (0x%x)\n",
> > +		cells, data);
> > +
> > +	return regmap_update_bits(chg->pf1550->regmap,
> > +				  PF1550_CHARG_REG_THM_REG_CNFG,
> > +				  PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_MASK,
> > +				  data);
> > +}
> > +
> > +/*
> > + * Sets charger registers to proper and safe default values.
> > + */
> > +static int pf1550_reg_init(struct pf1550_charger *chg)
> > +{
> > +	struct device *dev = chg->dev;
> > +	unsigned int data;
> > +	int ret;
> > +
> > +	/* Unmask charger interrupt, mask DPMI and reserved bit */
> > +	ret =  regmap_write(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_INT_MASK,
> > +			    PF1550_CHG_INT_MASK);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "Error unmask charger interrupt\n");
> > +
> > +	ret = regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_VBUS_SNS,
> > +			  &data);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Read charg vbus_sns error\n");
> 
> data is unused here :/
>
Yeah, that should be dropped.
> > +
> > +	ret = pf1550_set_constant_volt(chg, chg->constant_volt);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = pf1550_set_min_system_volt(chg, chg->min_system_volt);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = pf1550_set_thermal_regulation_temp(chg,
> > +						 chg->thermal_regulation_temp);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Turn on charger */
> > +	ret = regmap_write(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_OPER,
> > +			   PF1550_CHG_TURNON);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Error turn on charger\n");
> 
> There are 3 modes for the charger operation:
> 0: charger = off, linear = off
> 1: charger = off, linear = on
> 2: charger = on, linear = on
> 
> The driver is hardcoded to use no. 2.
> 
> We are using the mode 1, and setting it to 2 causes my system to boot loop.
> 
> I don't know how we should select mode, maybe it could be an option from
> the devicetree or use power_supply_get_battery_info() to look for a
> battery and the only select between 1 or 2, but 0 would also be a valid
> option.
> 
I like the latter solution of using the power_supply_get_battery_info. I think
selecting between only 1 or 2 should be fine.

Thanks,
Sam

