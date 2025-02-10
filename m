Return-Path: <linux-pm+bounces-21658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF15CA2E703
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 09:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CFFF1672EE
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 08:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40001C3029;
	Mon, 10 Feb 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5On25TM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6BF1C2443;
	Mon, 10 Feb 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739177549; cv=none; b=beIJOYHYeFUpekOPLlNfOVL2rOXiXD7SOoRykw7bfJ7qxMfpSpybs7Awd3gNAcfv7Kbnvht2I2+0nkiphLMngGa5VPpcPiwqnUJY67szk4srvin2BXFdTOCffMmdx+TOH6EbAlEwqHLDSIZouTeTC9VUOgqLGmiU6OiKlyoEzHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739177549; c=relaxed/simple;
	bh=Ad+EIxlM+shMGClzmU5rodJzGmXvYM+2G7RRmW8zDpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFPV+cNrEqut/eY1Ohns8EDF4ZCQl/iode2uoFQUgz1hYLHHoTlAN2fdxlvpFsS3CWJhm2W7BeKG0zVK6AmTjSv2/qQQO5k5+WfrGyjucrBFZGdPY7nWOvio6lALKMRwUHEM9JkAn0GNnww+NvDf07zQGtEZJJyBgG3kYC8EhGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5On25TM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771C7C4CEE4;
	Mon, 10 Feb 2025 08:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739177549;
	bh=Ad+EIxlM+shMGClzmU5rodJzGmXvYM+2G7RRmW8zDpw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U5On25TMs1vbgyw09AYUX8cjzl1mb3d410J6wvfr8qoqpGQIJimcLVVVhqo9sxxU2
	 D+FEHNwRgDcgdNVaLI23zqfhIHJ3UwYvi/WIEAcuY2ADCJec/XTyCuRIvWFOiXhL4I
	 TQRta7R1QLkUJ4JuHlXOHo61rs55nDrjEhtEt2jjH7ne+SwIcBGE0qV2JwsIff23j4
	 E+1JZkwYYW3ksdnwT9kPL1Hu8iBIZi7beZOuvOYHS6XFd6WHXocublKyU4XEfwGKiF
	 2OE04q1HvNLm2v/CF24ObB2bufOysgo7cUgCFXCVFr/7StZRO2zWCu1npBD22Rrt8W
	 9g2CjkxpTzZVg==
Message-ID: <6e479752-ef15-40c4-a01f-f971cb075525@kernel.org>
Date: Mon, 10 Feb 2025 09:52:23 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] power: reset: cv18xx: New driver
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, soc@lists.linux.dev
Cc: Chen Wang <unicorn_wang@outlook.com>,
 Inochi Amaoto <inochiama@outlook.com>, linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org, Haylen Chu <heylenay@outlook.com>,
 linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Philipp Zabel <p.zabel@pengutronix.de>,
 Lee Jones <lee@kernel.org>
References: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
 <20250209220646.1090868-10-alexander.sverdlin@gmail.com>
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
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
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
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <20250209220646.1090868-10-alexander.sverdlin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/02/2025 23:06, Alexander Sverdlin wrote:
> +
> +static int cv18xx_reset_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	rtcsys_ctrl_regs = syscon_regmap_lookup_by_phandle(np, "sophgo,rtcsys-ctrl");
> +	if (IS_ERR(rtcsys_ctrl_regs))
> +		return dev_err_probe(dev, PTR_ERR(rtcsys_ctrl_regs),
> +				     "sophgo,rtcsys-ctrl lookup failed\n");
> +
> +	rtcsys_core_regs = syscon_regmap_lookup_by_phandle(np, "sophgo,rtcsys-core");
> +	if (IS_ERR(rtcsys_core_regs))
> +		return dev_err_probe(dev, PTR_ERR(rtcsys_core_regs),
> +				     "sophgo,rtcsys-core lookup failed\n");
> +
> +	ret = devm_register_restart_handler(&pdev->dev, cv18xx_restart_handler, NULL);
> +	if (ret)
> +		dev_err(&pdev->dev, "Cannot register restart handler (%pe)\n", ERR_PTR(ret));

You called it reset driver and placed it in reset, but this is reboot
handler?

> +	return ret;
> +}
> +
> +static const struct of_device_id cv18xx_reset_of_match[] = {
> +	{ .compatible = "sophgo,cv1800-reset" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, cv18xx_reset_of_match);
> +
> +static struct platform_driver cv18xx_reset_driver = {
> +	.probe = cv18xx_reset_probe,
> +	.driver = {
> +		.name = "cv18xx-reset",
> +		.of_match_table = cv18xx_reset_of_match,
> +	},
> +};
> +module_platform_driver(cv18xx_reset_driver);
> +
> +MODULE_AUTHOR("Alexander Sverdlin <alexander.sverdlin@gmail.com>");
> +MODULE_DESCRIPTION("Cvitek CV18xx/Sophgo SG2000 Reset Driver");
> +MODULE_ALIAS("platform:cv18xx-reset");

You should not need MODULE_ALIAS() in normal cases. If you need it,
usually it means your device ID table is wrong (e.g. misses either
entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute
for incomplete ID table.




Best regards,
Krzysztof

