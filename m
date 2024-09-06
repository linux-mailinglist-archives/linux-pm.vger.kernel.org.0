Return-Path: <linux-pm+bounces-13779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8F896F005
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 11:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136FE2865E7
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 09:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432361CB127;
	Fri,  6 Sep 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYvozVGM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FCC1CA6AF;
	Fri,  6 Sep 2024 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615903; cv=none; b=ex+7u9FqNrbBqN4+hvo/SOgK7SkHx6dkAsEHwy5IGyC72YE0bzEbiufgOaGtvhFpAWiNkX62S5m9lmwT6hoAWpt6101Lk7lyWSl82u2tKo31XWLeBuM5uzHZV6w+HlpnZeeygfpD9pm7FF2KsdoID1Vvlq2gPPoAUVx2ps4gKwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615903; c=relaxed/simple;
	bh=Rt2nyfE5ubP8pA0B8PPUA3nYtqppOBbV6wORmmUvWSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYjrUhLpnC7FFrueo854jGkxJrls9kWcAMVwwoSi3SFYp+15t2tsozJdqT3n0LeIIifiNylOM8I7dE9a57G0cFveZhejyqmxViHtbb3WWge+CPbKJAa/siyO5r7YWpGo0Ma2FmDSbWN/df/GvSUVsIdEFc3Iyc5ZlRAcA2wyxRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYvozVGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94185C4CEC4;
	Fri,  6 Sep 2024 09:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725615902;
	bh=Rt2nyfE5ubP8pA0B8PPUA3nYtqppOBbV6wORmmUvWSk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uYvozVGMeF2/g2AfsViHKq0jq64rjOe9ORT9k2+I+fyuafVQ91YpaGC6KflyRH/L6
	 W7VWPThXq+AdS5TKuaPNPPz2rLmq0AJ/eVz3QTLe7Av6oPQLmkR3QH2AtkFtbZhNTo
	 M44tj570e5pvNl7fm6X3GMmplSv3Wb7PlvX1WNIWEnTVJ/sr4mPi47jjubuPBpa4xY
	 fibniBERy0g1ZX/GGCXhFnNhaZhP54x9YIVcAT6gVel0i1wdPL3NYo8+IXo9FdrGqd
	 N8wAWN00iYaVLIS0xosnvynSpBmWsArG2YTG/Y7FzAsyotd1J8hH9nzDEBE/L8lC7s
	 Mu7TVwoYngDgQ==
Message-ID: <90a5b41b-84cd-4daa-b102-04a29c2cd46b@kernel.org>
Date: Fri, 6 Sep 2024 11:44:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] power: reset: add Photonicat PMU poweroff driver
To: Junhao Xie <bigfoot@classfun.cn>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Heiko Stuebner <heiko@sntech.de>,
 Chukun Pan <amadeus@jmu.edu.cn>
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
 <20240906093630.2428329-3-bigfoot@classfun.cn>
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
In-Reply-To: <20240906093630.2428329-3-bigfoot@classfun.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/09/2024 11:36, Junhao Xie wrote:
> This driver implements the shutdown function of Photonicat PMU:
> 
> - Host notifies PMU to shutdown:
>   When powering off, a shutdown command (0x0F) needs to be sent
>   to the MCU.
> 
> - PMU notifies host to shutdown:
>   If the power button is long pressed, the MCU will send a shutdown
>   command (0x0D) to the system.
>   If system does not shutdown within 60 seconds,
>   the power will be turned off directly.
> 
> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
> ---
>  drivers/power/reset/Kconfig               | 12 +++
>  drivers/power/reset/Makefile              |  1 +
>  drivers/power/reset/photonicat-poweroff.c | 95 +++++++++++++++++++++++
>  3 files changed, 108 insertions(+)
>  create mode 100644 drivers/power/reset/photonicat-poweroff.c
> 
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index fece990af4a7..c59529ce25a2 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -148,6 +148,18 @@ config POWER_RESET_ODROID_GO_ULTRA_POWEROFF
>  	help
>  	  This driver supports Power off for Odroid Go Ultra device.
>  
> +config POWER_RESET_PHOTONICAT_POWEROFF
> +	tristate "Photonicat PMU power-off driver"
> +	depends on MFD_PHOTONICAT_PMU

|| COMPILE_TEST, no?

> +	help
> +	  This driver supports Power off for Photonicat PMU device.
> +
> +	  Supports operations:
> +	    Host notifies PMU to shutdown
> +	    PMU notifies host to shutdown
> +
> +	  Say Y if you have a Photonicat board.
> +
>  config POWER_RESET_PIIX4_POWEROFF
>  	tristate "Intel PIIX4 power-off driver"
>  	depends on PCI
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index a95d1bd275d1..339b36812b95 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_POWER_RESET_MT6323) += mt6323-poweroff.o
>  obj-$(CONFIG_POWER_RESET_QCOM_PON) += qcom-pon.o
>  obj-$(CONFIG_POWER_RESET_OCELOT_RESET) += ocelot-reset.o
>  obj-$(CONFIG_POWER_RESET_ODROID_GO_ULTRA_POWEROFF) += odroid-go-ultra-poweroff.o
> +obj-$(CONFIG_POWER_RESET_PHOTONICAT_POWEROFF) += photonicat-poweroff.o
>  obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) += piix4-poweroff.o
>  obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
>  obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
> diff --git a/drivers/power/reset/photonicat-poweroff.c b/drivers/power/reset/photonicat-poweroff.c
> new file mode 100644
> index 000000000000..f9f1ea179247
> --- /dev/null
> +++ b/drivers/power/reset/photonicat-poweroff.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024 Junhao Xie <bigfoot@classfun.cn>
> + */
> +
> +#include <linux/mfd/photonicat-pmu.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +
> +struct pcat_poweroff {
> +	struct device *dev;
> +	struct pcat_pmu *pmu;
> +	struct notifier_block nb;
> +};
> +
> +static int pcat_do_poweroff(struct sys_off_data *data)
> +{
> +	struct pcat_poweroff *poweroff = data->cb_data;
> +
> +	dev_info(poweroff->dev, "Host request PMU shutdown\n");
> +	pcat_pmu_write_data(poweroff->pmu, PCAT_CMD_HOST_REQUEST_SHUTDOWN,
> +			    NULL, 0);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int pcat_poweroff_notify(struct notifier_block *nb, unsigned long action,
> +				void *data)
> +{
> +	struct pcat_poweroff *poweroff =
> +		container_of(nb, struct pcat_poweroff, nb);
> +
> +	if (action != PCAT_CMD_PMU_REQUEST_SHUTDOWN)
> +		return NOTIFY_DONE;
> +
> +	dev_info(poweroff->dev, "PMU request host shutdown\n");

Nope. Drop.

> +	orderly_poweroff(true);
> +
> +	return NOTIFY_DONE;
Best regards,
Krzysztof


