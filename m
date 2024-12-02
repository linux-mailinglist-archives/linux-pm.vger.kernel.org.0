Return-Path: <linux-pm+bounces-18339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEE39DFEF0
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 11:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6236C28215E
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 10:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DAA1FC7DF;
	Mon,  2 Dec 2024 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikhjkACi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91B61FC119;
	Mon,  2 Dec 2024 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135402; cv=none; b=txKCpco/3scPb5EseulNB+WfY3vO+3kZSCQRcvcJ6yHiB7THnUTkfPdCIdx0X6mwOiye+n5y3DyCUriMXEqHdGdY/0gThaQWFb0cFSNKPk85KTDZurk8gFGHo0fpFvt4qfkyD/NcRZTlnNXNKk7QpX8U5uIOoXg3hIKBOO7jDh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135402; c=relaxed/simple;
	bh=LuFsk7gRGBuCuEnZFd0Z5kjf8SQVkInCv2kWohtubqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jm8LYo7TN47dq8RfdAGMiOHpIbAnGjiJAi7uRaOQxSnmQ3KWwBmtsfj5JvtbmAsD4wWaz2YPUqbgpGaDKKKIIK22AyqvoVPSF25tuSbdnFF1LdO0w28Gor33KWgT0U9zRS+pcVdWnQj2pWTM0c0kBOMeDLOQV7KHBcLyVWodv48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikhjkACi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D399C4CED1;
	Mon,  2 Dec 2024 10:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733135401;
	bh=LuFsk7gRGBuCuEnZFd0Z5kjf8SQVkInCv2kWohtubqk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ikhjkACihn+xC0pbMrkkFlVcoFHZag2jhTZJ60iU9/et26klYWxrv6eJdU74GDyaS
	 1apJVYRRuCyNDXXFgLyvs+WnpF0dEoKpKIOVGWeAJOy14chBW62C8/R3gENIsKDTbx
	 QbxjcJdo4B6qpc9vxFtICOsIl/vrayaE4Sc1wutLTBNNXN1dljAviJRqJCLY3EtN/y
	 pOl+9lP5qnsQ3bzb5E6+8Eu9/YK1Sj+l5c1kxj92uwNjUYWACBwd14naoJqk6z+f6L
	 mVB9tX5qnByqNqTbi+YsXOM5vZkKwqq2PNQvZlPIXHSoo2K2b4sOwufxkmJGIsf2mh
	 ZDujRu2/s69QA==
Message-ID: <b7e4162a-a7f7-462d-9dde-121eeb59d148@kernel.org>
Date: Mon, 2 Dec 2024 11:29:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 9/9] leds: max77705: Add LEDs support
To: Dzmitry Sankouski <dsankouski@gmail.com>,
 Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Hans de Goede <hdegoede@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org
References: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
 <20241202-starqltechn_integration_upstream-v9-9-a1adc3bae2b8@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241202-starqltechn_integration_upstream-v9-9-a1adc3bae2b8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/12/2024 10:48, Dzmitry Sankouski wrote:
> This adds basic support for LEDs for the max77705 PMIC.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 
> ---
> Changes for v8:
> - join line where possible to fit in 100 chars


Coding style asks for 80. checkpatch is not a coding style, unless this
came from maintainer's review.

> - change comment style C++ -> C
> 

> Changes for v6:
> - change compatible suffix to 'rgb'
> - remove I2C dependency in Kconfig
> - remove copyright and author from 'based on' header statement
> - replace MFD abbreviation with PMIC
> - MAINTAINERS: alphabetic order
> - max77705_rgb_blink: replace ternary operators with if..else if sequence
> - max77705_rgb_blink: move hardcoded numbers to constants
> - max77705_led_brightness_set: move ret to the bottom
> - s/map/regmap
> - replace device_for_each_child_node with scoped version
> - s/rv/ret
> Changes for v5:
> - use same hardware name in Kconfig and module descriptions
> - remove copyrighter owner from module authors
> 
> Changes in v4:
> - inline BLINK_(ON|OFF) macro
> - remove camel case
> - drop backwards compatibility(new driver)
> - drop module alias
> ---
>  MAINTAINERS                          |   1 +
>  drivers/leds/Kconfig                 |   6 ++++++
>  drivers/leds/Makefile                |   1 +
>  drivers/leds/leds-max77705.c         | 167 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max77705-private.h |  18 ++++++++++++++++
>  5 files changed, 193 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS


...

> diff --git a/include/linux/mfd/max77705-private.h b/include/linux/mfd/max77705-private.h
> index be781a0f9802..2140693ce747 100644
> --- a/include/linux/mfd/max77705-private.h
> +++ b/include/linux/mfd/max77705-private.h
> @@ -35,6 +35,24 @@
>  #define MAX77705_SYSTEM_IRQ_SYSOVLO_INT	BIT(5)
>  #define MAX77705_SYSTEM_IRQ_TSHDN_INT	BIT(6)
>  #define MAX77705_SYSTEM_IRQ_TM_INT	BIT(7)
> +/* MAX77705_RGBLED_REG_LEDEN register */
> +#define MAX77705_RGBLED_EN_WIDTH	2
> +/* MAX77705_RGBLED_REG_LEDBLNK register */
> +#define MAX77705_RGB_DELAY_100_STEP_LIM 500
> +#define MAX77705_RGB_DELAY_100_STEP_COUNT 4
> +#define MAX77705_RGB_DELAY_100_STEP 100
> +#define MAX77705_RGB_DELAY_250_STEP_LIM 3250
> +#define MAX77705_RGB_DELAY_250_STEP 250
> +#define MAX77705_RGB_DELAY_500_STEP 500
> +#define MAX77705_RGB_DELAY_500_STEP_COUNT 10
> +#define MAX77705_RGB_DELAY_500_STEP_LIM 5000
> +#define MAX77705_RGB_DELAY_1000_STEP_LIM 8000
> +#define MAX77705_RGB_DELAY_1000_STEP_COUNT 13
> +#define MAX77705_RGB_DELAY_1000_STEP 1000
> +#define MAX77705_RGB_DELAY_2000_STEP 2000
> +#define MAX77705_RGB_DELAY_2000_STEP_COUNT 13
> +#define MAX77705_RGB_DELAY_2000_STEP_LIM 12000
> +
>  

No need for multiple line breaks.

Best regards,
Krzysztof

