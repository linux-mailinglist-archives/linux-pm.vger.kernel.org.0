Return-Path: <linux-pm+bounces-12335-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6030A95466A
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 12:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B219BB23024
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91D01741D2;
	Fri, 16 Aug 2024 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dl79Qb7q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A630217335C;
	Fri, 16 Aug 2024 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802466; cv=none; b=P4vRJ830YDHLelH85Q999UIBQTat3+CQTBs7dMGXqJ5aiT/U0qVWoFanfruBFiRDLkSzPOfRa02xXvMpa214hdAOBXNADXJlhTOPqTSzyWVine+HWqep3zz4QloNlrzN+7bTjROHdNjZ32rAxHei0btKE4RCaBmrCWZxvtUmomw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802466; c=relaxed/simple;
	bh=QeWVCPKhXV5WY0xeONx29/jL2izZ/08c3nC6IK6z/sI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkWqGpeaBueyyFb3N/5i6oxe27WLZyk3iyk0IazZ0PAXrp3t3I6hpKPcu1G2nG4Ir+PSdAxf5R8zIuJLpnTxP0FNTURdKsmxOQ1Zf9wnTOsDFU3BFuEChIIULiJJ+P9RJD//n+nwlv/sxffyjd1Zj1YDedlkQ8kZS5ZlEq4zAw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dl79Qb7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3792C32782;
	Fri, 16 Aug 2024 10:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723802466;
	bh=QeWVCPKhXV5WY0xeONx29/jL2izZ/08c3nC6IK6z/sI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dl79Qb7qjEtgAMxFBDK8fiwx0MKXsv9qZCukrdDn6atqw1iKohJCrmhd9j7AAR+Ui
	 Uze6B/iqDov9APrAsqz9sCZ2AgYXCbu52JUW9SNRS6XxTGmCRvR3fLUQwyRPyty9XQ
	 A2fJr4fgGd151qT2BPkyFEUuF/qItDNL1bnwgW+Luj/kl1oEvxRCblGWcgnKW+yOGP
	 ONBqcD1ocIcxhTlP8ZhA6iDZvN+6Dd8JNt0R/zEaCG2nK3nvPF4F+d0Q4nFslpuzqJ
	 cZBUXr+Q1oJzW6JRkm4QDmdw43HZAo+MrutAXrg6Fh8MMwkXG1tuw+IzyOV4k55lBH
	 z9BOqFGb0ZNsA==
Message-ID: <d8c5be11-5c5d-459e-8563-d9ca41c31295@kernel.org>
Date: Fri, 16 Aug 2024 12:00:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] power: supply: max77693: Add support for
 detecting and enabling OTG
To: Artur Weber <aweber.kernel@gmail.com>,
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>,
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>,
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
References: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
 <20240816-max77693-charger-extcon-v4-6-050a0a9bfea0@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240816-max77693-charger-extcon-v4-6-050a0a9bfea0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/08/2024 10:19, Artur Weber wrote:
> Building upon the newly added extcon detection support, add detection
> for USB OTG cables (EXTCON_USB_HOST type), and enable/disable the OTG
> bits as needed.
> 
> Acked-by: Lee Jones <lee@kernel.org>
> Tested-by: Henrik Grimler <henrik@grimler.se>
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changes in v3:
> - Dropped CHARGER regulator in favor of enabling charging directly
> 
> Changes in v2:
> - Added CHGIN OTG current limit value
> - Squashed MFD header register changes into this commit
> ---
>  drivers/power/supply/max77693_charger.c | 53 ++++++++++++++++++++++++++-------
>  include/linux/mfd/max77693-private.h    |  5 ++++
>  2 files changed, 48 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
> index d67857d2aa0b..bf156544fe1b 100644
> --- a/drivers/power/supply/max77693_charger.c
> +++ b/drivers/power/supply/max77693_charger.c
> @@ -692,11 +692,30 @@ static int max77693_set_charging(struct max77693_charger *chg, bool enable)
>  			data);
>  }
>  
> +static int max77693_set_otg(struct max77693_charger *chg, bool enable)
> +{
> +	unsigned int data;
> +
> +	if (enable)
> +		data = CHG_CNFG_00_OTG_MASK | CHG_CNFG_00_BOOST_MASK |
> +				CHG_CNFG_00_DIS_MUIC_CTRL_MASK;
> +	else
> +		data = ~(CHG_CNFG_00_OTG_MASK | CHG_CNFG_00_BOOST_MASK |
> +				CHG_CNFG_00_DIS_MUIC_CTRL_MASK);
> +
> +	return regmap_update_bits(chg->max77693->regmap,
> +			MAX77693_CHG_REG_CHG_CNFG_00,
> +			CHG_CNFG_00_OTG_MASK | CHG_CNFG_00_BOOST_MASK |
> +			CHG_CNFG_00_DIS_MUIC_CTRL_MASK,
> +			data);
> +}
> +
>  static void max77693_charger_extcon_work(struct work_struct *work)
>  {
>  	struct max77693_charger *chg = container_of(work, struct max77693_charger,
>  						  cable.work);
>  	struct extcon_dev *edev = chg->cable.edev;
> +	bool set_charging, set_otg;
>  	int connector, state;
>  	int ret;
>  
> @@ -715,25 +734,39 @@ static void max77693_charger_extcon_work(struct work_struct *work)
>  	case EXTCON_CHG_USB_FAST:
>  	case EXTCON_CHG_USB_SLOW:
>  	case EXTCON_CHG_USB_PD:
> -		ret = max77693_set_charging(chg, true);
> -		if (ret) {
> -			dev_err(chg->dev, "failed to enable charging\n");
> -			break;
> -		}
> +		set_charging = true;
> +		set_otg = false;
> +
>  		dev_info(chg->dev, "charging. connector type: %d\n",
>  			 connector);

Same comments as for other patch - dev_dbg.


Best regards,
Krzysztof


