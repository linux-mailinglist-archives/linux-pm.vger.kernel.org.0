Return-Path: <linux-pm+bounces-27265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A810ABA9AE
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 13:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36BAF9E02C5
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 11:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC281EA7C2;
	Sat, 17 May 2025 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIMu3lUz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B41E4A9;
	Sat, 17 May 2025 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747480819; cv=none; b=rPsMPlPUDPoHddPj40p9OfY9dWvskqvN9J49rfh48Svuj3IO0N3IAq213sQbKLqfRerVyIWGr7SU5LQuP9iPhL/pVGovBbJlkIM3bqc5Az3BvMDt1XPg21AKS6rsp17EzkOi0eJrX2XNh8PFe2UwIMhy2klkGQ5X+839bGx8ej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747480819; c=relaxed/simple;
	bh=H3f0gcRlbgfMYVmgHqa0rkRax47A6L3pBATHb78Mqpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMPANI7pzMDzerVHt6w9ZQmcX7Tq6XbTVkse281P/60lSRNl9+pSx1MPKccQJnr0J79W5i76+ZfNcnxrU4QU/qmwDXgQvUer3/9kdCBUBeUyxEyMDmZfJM/RWOdwR0Tzhv4KEFHlNlOhsyxeeVSBsabMzECTWIWGJyA/TY6Pd68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIMu3lUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8769C4CEE3;
	Sat, 17 May 2025 11:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747480819;
	bh=H3f0gcRlbgfMYVmgHqa0rkRax47A6L3pBATHb78Mqpw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BIMu3lUzI9IXDR1HHiWgO2o8Tjsb+eQuTR9O3HWtaUrlBbM+tnAI0JMVLv18Ik20u
	 I7ugAYGNN2Jc0UC41obrutYUhz1/6thxaMu6okGDlA04kIEUL3Ew9aQ5UKN9ergFmA
	 CLI296vYWyrogjuGGgN8aim2I1b//y2auTQhd9N4BqAo4sFyIveDM2+DMb/HwH/ACN
	 FkTUNkm4W+7mx8L3Q78fyRyQ802VGo4EhCbbfSo846H/67Fjs+Z4I8to4i6zvwiMLM
	 KDDmVfyjv4QycjqjzDd1txqRunYkViT9ZBMUtSJ5C+Nq1nRWGDBhAJ78DHZPCvwdql
	 Nxbvm25YisElA==
Message-ID: <f164a44b-331d-4f9b-825a-5ebc8ee47f24@kernel.org>
Date: Sat, 17 May 2025 13:20:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] power: supply: pf1550: add battery charger support
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>,
 Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>,
 Robin Gong <yibin.gong@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-imx@nxp.com, linux-input@vger.kernel.org,
 Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>,
 Robin Gong <b38343@freescale.com>, Enric Balletbo Serra <eballetbo@gmail.com>
References: <cover.1747409892.git.samuel.kayode@savoirfairelinux.com>
 <4f51191483189a69072fe08c5609048fa14b39b1.1747409892.git.samuel.kayode@savoirfairelinux.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <4f51191483189a69072fe08c5609048fa14b39b1.1747409892.git.samuel.kayode@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/05/2025 20:58, Samuel Kayode wrote:
> +
> +	chg->psy_desc.name = PF1550_CHARGER_NAME;
> +	chg->psy_desc.type = POWER_SUPPLY_TYPE_BATTERY;
> +	chg->psy_desc.get_property = pf1550_charger_get_property;
> +	chg->psy_desc.properties = pf1550_charger_props;
> +	chg->psy_desc.num_properties = ARRAY_SIZE(pf1550_charger_props);
> +
> +	chg->charger = devm_power_supply_register(&pdev->dev, &chg->psy_desc,
> +						  &psy_cfg);
> +	if (IS_ERR(chg->charger)) {
> +		dev_err(&pdev->dev, "failed: power supply register\n");
> +		ret = PTR_ERR(chg->charger);

Same comments as on patches before.

> +		return ret;
> +	}
> +
> +	ret = pf1550_reg_init(chg);
> +
> +	return ret;
> +}
> +
> +static void pf1550_charger_remove(struct platform_device *pdev)
> +{
> +	struct pf1550_charger *chg = platform_get_drvdata(pdev);
> +
> +	cancel_delayed_work_sync(&chg->irq_work);
> +}
> +
> +static const struct platform_device_id pf1550_charger_id[] = {
> +	{ "pf1550-charger", 0 },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, pf1550_charger_id);
> +
> +static struct platform_driver pf1550_charger_driver = {
> +	.driver = {
> +		.name	= "pf1550-charger",
> +	},
> +	.probe		= pf1550_charger_probe,
> +	.remove		= pf1550_charger_remove,
> +	.id_table	= pf1550_charger_id,
And this proves that your compatible in the binding is also useless. Not
used in the driver itself

Best regards,
Krzysztof

