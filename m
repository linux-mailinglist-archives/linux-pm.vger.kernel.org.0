Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE336204C48
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 10:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbgFWIZs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 04:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbgFWIZs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 04:25:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1DDC061573
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2020 01:25:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g21so2263292wmg.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2020 01:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EindUy1KykqPVILpEGr4jUAyu70krV4jHpQOVk2rR6s=;
        b=kKOABJKf3seoFcZ0yOWEfPGnDQox0mqQS6CtpM1W9PiPyGAD1BR465kldIhb0x0cJH
         P4mJFPRw3ox9NCNS5vXL+rDFR8N9xoaYNd09+vyDMR/5zSPYyJfJB57kzKDkEhMjJL/3
         FcYu3DPfNqsV/Aa/hSWydlRFa1oZCD9zKEwcBRt80EK/LqSBMaAqqWSVb4k/CwGgGpi7
         zvEVOEysCBnThEVcVAzKQhHk8zq+pYqV2/GW2ZoQHbDjKUz64l6TlGN+XUWvhjUrMuud
         qPXrebyFTiZeN33v+8azfHc2z0iKj0tFjzfPcHAUjTXVYA8NIl7spw9m1Vc0PSyRtgri
         ZlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EindUy1KykqPVILpEGr4jUAyu70krV4jHpQOVk2rR6s=;
        b=ZTNBjO0GAfTN6y1vNk98T1S5hTOcmnN4L7p5RnrdTvsvxfvw2Q+sYXPVrCQdz+3USl
         XSUz+vvXbxVsyENXppgQ7KnVZIOPX5Set1bikO0ntn11zenau34Z/XzgF9rZHf4vrYjS
         yT9huKWbbPMvIjp3KxjMcbld/RGmRlg0LNFOjaNPgr5DQuSF2cJhvt1ZQSmLBlYWuFrZ
         U6VO9oJ9rLkUUEGneSNp8yXalD8N0XvvE6rN8GMX3Z+FmAjc9h4toxs7VGTXQweMNTe8
         58zwrnybVUN82yTT/O40b2TJiUjazbnKw9ifKtY+XOUYk7g0PtIxArAxlD43zKdw1s7d
         FROQ==
X-Gm-Message-State: AOAM533YL/CdUw4jUNxwdGF4p9tdEOlLzpcURT+xZUcPtiM8O1keB/0d
        Zqpoz7B/EqMGXLYBbjGp5GDndqRAsh8BlA==
X-Google-Smtp-Source: ABdhPJzGLlSGLKY3Ns6BF27wm9aj33E4Evq0EuonKQlU/zri6AT/MtIq0tcYwXfoKdgJh2Qa6uG/ig==
X-Received: by 2002:a1c:2e47:: with SMTP id u68mr23532842wmu.45.1592900743832;
        Tue, 23 Jun 2020 01:25:43 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:89ac:d9e8:f44c:b137? ([2a01:e35:2ec0:82b0:89ac:d9e8:f44c:b137])
        by smtp.gmail.com with ESMTPSA id b19sm2819786wmj.0.2020.06.23.01.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 01:25:43 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] thermal: add support for the MCU controlled FAN on
 Khadas boards
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, lee.jones@linaro.org
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com,
        Amit Kucheria <amit.kucheria@linaro.org>
References: <20200618133818.15857-1-narmstrong@baylibre.com>
 <20200618133818.15857-2-narmstrong@baylibre.com>
 <53aa62a3-1d8e-bc91-1a2b-88c766276beb@linaro.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT7CwHsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIXOwU0EVid/pAEQAND7AFhr
 5faf/EhDP9FSgYd/zgmb7JOpFPje3uw7jz9wFb28Cf0Y3CcncdElYoBNbRlesKvjQRL8mozV
 9RN+IUMHdUx1akR/A4BPXNdL7StfzKWOCxZHVS+rIQ/fE3Qz/jRmT6t2ZkpplLxVBpdu95qJ
 YwSZjuwFXdC+A7MHtQXYi3UfCgKiflj4+/ITcKC6EF32KrmIRqamQwiRsDcUUKlAUjkCLcHL
 CQvNsDdm2cxdHxC32AVm3Je8VCsH7/qEPMQ+cEZk47HOR3+Ihfn1LEG5LfwsyWE8/JxsU2a1
 q44LQM2lcK/0AKAL20XDd7ERH/FCBKkNVzi+svYJpyvCZCnWT0TRb72mT+XxLWNwfHTeGALE
 +1As4jIS72IglvbtONxc2OIid3tR5rX3k2V0iud0P7Hnz/JTdfvSpVj55ZurOl2XAXUpGbq5
 XRk5CESFuLQV8oqCxgWAEgFyEapI4GwJsvfl/2Er8kLoucYO1Id4mz6N33+omPhaoXfHyLSy
 dxD+CzNJqN2GdavGtobdvv/2V0wukqj86iKF8toLG2/Fia3DxMaGUxqI7GMOuiGZjXPt/et/
 qeOySghdQ7Sdpu6fWc8CJXV2mOV6DrSzc6ZVB4SmvdoruBHWWOR6YnMz01ShFE49pPucyU1h
 Av4jC62El3pdCrDOnWNFMYbbon3vABEBAAHCwn4EGAECAAkFAlYnf6QCGwICKQkQFpq3saTP
 +K7BXSAEGQECAAYFAlYnf6QACgkQd9zb2sjISdGToxAAkOjSfGxp0ulgHboUAtmxaU3viucV
 e2Hl1BVDtKSKmbIVZmEUvx9D06IijFaEzqtKD34LXD6fjl4HIyDZvwfeaZCbJbO10j3k7FJE
 QrBtpdVqkJxme/nYlGOVzcOiKIepNkwvnHVnuVDVPcXyj2wqtsU7VZDDX41z3X4xTQwY3SO1
 9nRO+f+i4RmtJcITgregMa2PcB0LvrjJlWroI+KAKCzoTHzSTpCXMJ1U/dEqyc87bFBdc+DI
 k8mWkPxsccdbs4t+hH0NoE3Kal9xtAl56RCtO/KgBLAQ5M8oToJVatxAjO1SnRYVN1EaAwrR
 xkHdd97qw6nbg9BMcAoa2NMc0/9MeiaQfbgW6b0reIz/haHhXZ6oYSCl15Knkr4t1o3I2Bqr
 Mw623gdiTzotgtId8VfLB2Vsatj35OqIn5lVbi2ua6I0gkI6S7xJhqeyrfhDNgzTHdQVHB9/
 7jnM0ERXNy1Ket6aDWZWCvM59dTyu37g3VvYzGis8XzrX1oLBU/tTXqo1IFqqIAmvh7lI0Se
 gCrXz7UanxCwUbQBFjzGn6pooEHJYRLuVGLdBuoApl/I4dLqCZij2AGa4CFzrn9W0cwm3HCO
 lR43gFyz0dSkMwNUd195FrvfAz7Bjmmi19DnORKnQmlvGe/9xEEfr5zjey1N9+mt3//geDP6
 clwKBkq0JggA+RTEAELzkgPYKJ3NutoStUAKZGiLOFMpHY6KpItbbHjF2ZKIU1whaRYkHpB2
 uLQXOzZ0d7x60PUdhqG3VmFnzXSztA4vsnDKk7x2xw0pMSTKhMafpxaPQJf494/jGnwBHyi3
 h3QGG1RjfhQ/OMTX/HKtAUB2ct3Q8/jBfF0hS5GzT6dYtj0Ci7+8LUsB2VoayhNXMnaBfh+Q
 pAhaFfRZWTjUFIV4MpDdFDame7PB50s73gF/pfQbjw5Wxtes/0FnqydfId95s+eej+17ldGp
 lMv1ok7K0H/WJSdr7UwDAHEYU++p4RRTJP6DHWXcByVlpNQ4SSAiivmWiwOt490+Ac7ATQRN
 WQbPAQgAvIoM384ZRFocFXPCOBir5m2J+96R2tI2XxMgMfyDXGJwFilBNs+fpttJlt2995A8
 0JwPj8SFdm6FBcxygmxBBCc7i/BVQuY8aC0Z/w9Vzt3Eo561r6pSHr5JGHe8hwBQUcNPd/9l
 2ynP57YTSE9XaGJK8gIuTXWo7pzIkTXfN40Wh5jeCCspj4jNsWiYhljjIbrEj300g8RUT2U0
 FcEoiV7AjJWWQ5pi8lZJX6nmB0lc69Jw03V6mblgeZ/1oTZmOepkagwy2zLDXxihf0GowUif
 GphBDeP8elWBNK+ajl5rmpAMNRoKxpN/xR4NzBg62AjyIvigdywa1RehSTfccQARAQABwsBf
 BBgBAgAJBQJNWQbPAhsMAAoJEBaat7Gkz/iuteIH+wZuRDqK0ysAh+czshtG6JJlLW6eXJJR
 Vi7dIPpgFic2LcbkSlvB8E25Pcfz/+tW+04Urg4PxxFiTFdFCZO+prfd4Mge7/OvUcwoSub7
 ZIPo8726ZF5/xXzajahoIu9/hZ4iywWPAHRvprXaim5E/vKjcTeBMJIqZtS4u/UK3EpAX59R
 XVxVpM8zJPbk535ELUr6I5HQXnihQm8l6rt9TNuf8p2WEDxc8bPAZHLjNyw9a/CdeB97m2Tr
 zR8QplXA5kogS4kLe/7/JmlDMO8Zgm9vKLHSUeesLOrjdZ59EcjldNNBszRZQgEhwaarfz46
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <5f7154f6-c527-6665-4f7b-affd3cd62b70@baylibre.com>
Date:   Tue, 23 Jun 2020 10:25:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <53aa62a3-1d8e-bc91-1a2b-88c766276beb@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 22/06/2020 21:46, Daniel Lezcano wrote:
> On 18/06/2020 15:38, Neil Armstrong wrote:
>> The new Khadas VIM2 and VIM3 boards controls the cooling fan via the
>> on-board microcontroller.
>>
>> This implements the FAN control as thermal devices and as cell of the Khadas
>> MCU MFD driver.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---
>> Hi Lee,
>>
>> Could you apply this patch via the MFD tree since it depends on
>> the linux/mfd/khadas-mcu.h header ?
>>
>> This patch is unchanged from the v3 serie.
>>
>> Thanks,
>> Neil
>>
>>  drivers/thermal/Kconfig          |  11 ++
>>  drivers/thermal/Makefile         |   1 +
>>  drivers/thermal/khadas_mcu_fan.c | 174 +++++++++++++++++++++++++++++++
>>  3 files changed, 186 insertions(+)
>>  create mode 100644 drivers/thermal/khadas_mcu_fan.c
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 3eb2348e5242..0125561488c9 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -500,4 +500,15 @@ config SPRD_THERMAL
>>  	help
>>  	  Support for the Spreadtrum thermal sensor driver in the Linux thermal
>>  	  framework.
>> +
>> +config KHADAS_MCU_FAN_THERMAL
>> +	tristate "Khadas MCU controller FAN cooling support"
>> +	depends on OF || COMPILE_TEST
>> +	depends on MFD_KHADAS_MCU
>> +	select MFD_CORE
>> +	select REGMAP
>> +	help
>> +	  If you say yes here you get support for the FAN controlled
>> +	  by the Microcontroller found on the Khadas VIM boards.
>> +
>>  endif
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index 0c8b84a09b9a..4b6aabaa7e31 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -61,3 +61,4 @@ obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
>>  obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>>  obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>>  obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
>> +obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
>> diff --git a/drivers/thermal/khadas_mcu_fan.c b/drivers/thermal/khadas_mcu_fan.c
>> new file mode 100644
>> index 000000000000..6995b443cad4
>> --- /dev/null
>> +++ b/drivers/thermal/khadas_mcu_fan.c
>> @@ -0,0 +1,174 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Khadas MCU Controlled FAN driver
>> + *
>> + * Copyright (C) 2020 BayLibre SAS
>> + * Author(s): Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/mfd/khadas-mcu.h>
>> +#include <linux/regmap.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/thermal.h>
>> +
>> +#define MAX_LEVEL 3
>> +
>> +struct khadas_mcu_fan_ctx {
>> +	struct khadas_mcu *mcu;
>> +	unsigned int level;
>> +	struct thermal_cooling_device *cdev;
>> +};
>> +
>> +static int khadas_mcu_fan_set_level(struct khadas_mcu_fan_ctx *ctx,
>> +				    unsigned int level)
>> +{
>> +	int ret;
>> +
>> +	ret = regmap_write(ctx->mcu->regmap, KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
>> +			   level);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ctx->level = level;
>> +
>> +	return 0;
>> +}
>> +
>> +static int khadas_mcu_fan_get_max_state(struct thermal_cooling_device *cdev,
>> +					unsigned long *state)
>> +{
>> +	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
>> +
>> +	if (!ctx)
>> +		return -EINVAL;
> 
> It is pointless to check 'ctx' is NULL, that was done at probe time.
> 
>> +	*state = MAX_LEVEL;
>> +
>> +	return 0;
>> +}
>> +
>> +static int khadas_mcu_fan_get_cur_state(struct thermal_cooling_device *cdev,
>> +					unsigned long *state)
>> +{
>> +	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
>> +
>> +	if (!ctx)
>> +		return -EINVAL;
> 
> Ditto
> 
>> +	*state = ctx->level;
>> +
>> +	return 0;
>> +}
>> +
>> +static int
>> +khadas_mcu_fan_set_cur_state(struct thermal_cooling_device *cdev,
>> +			     unsigned long state)
>> +{
>> +	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
>> +
>> +	if (!ctx || (state > MAX_LEVEL))
>> +		return -EINVAL;
> 
> Ditto

Will remove these.

> 
>> +	if (state == ctx->level)
>> +		return 0;
>> +
>> +	return khadas_mcu_fan_set_level(ctx, state);
>> +}
>> +
>> +static const struct thermal_cooling_device_ops khadas_mcu_fan_cooling_ops = {
>> +	.get_max_state = khadas_mcu_fan_get_max_state,
>> +	.get_cur_state = khadas_mcu_fan_get_cur_state,
>> +	.set_cur_state = khadas_mcu_fan_set_cur_state,
>> +};
>> +
>> +static int khadas_mcu_fan_probe(struct platform_device *pdev)
>> +{
>> +	struct khadas_mcu *mcu = dev_get_drvdata(pdev->dev.parent);
>> +	struct thermal_cooling_device *cdev;
>> +	struct device *dev = &pdev->dev;
>> +	struct khadas_mcu_fan_ctx *ctx;
>> +	int ret;
>> +
>> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>> +	if (!ctx)
>> +		return -ENOMEM;
>> +	ctx->mcu = mcu;
>> +	platform_set_drvdata(pdev, ctx);
>> +
>> +	cdev = devm_thermal_of_cooling_device_register(dev->parent,
>> +			dev->parent->of_node, "khadas-mcu-fan", ctx,
>> +			&khadas_mcu_fan_cooling_ops);
>> +	if (IS_ERR(cdev)) {
>> +		ret = PTR_ERR(cdev);
>> +		dev_err(dev,
>> +				"Failed to register khadas-mcu-fan as cooling device: %d\n",
>> +				ret);
>> +		return ret;
>> +	}
>> +	ctx->cdev = cdev;
>> +	thermal_cdev_update(cdev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int khadas_mcu_fan_disable(struct device *dev)
>> +{
>> +	struct khadas_mcu_fan_ctx *ctx = dev_get_drvdata(dev);
>> +	unsigned int level_save = ctx->level;
>> +	int ret;
>> +
>> +	ret = khadas_mcu_fan_set_level(ctx, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ctx->level = level_save;
> 
> Nitpicking : move the save section to suspend.

OK, but moving this makes khadas_mcu_fan_disable() useless.

> 
>> +	return 0;
>> +}
>> +
>> +static void khadas_mcu_fan_shutdown(struct platform_device *pdev)
>> +{
>> +	khadas_mcu_fan_disable(&pdev->dev);
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int khadas_mcu_fan_suspend(struct device *dev)
>> +{
>> +	return khadas_mcu_fan_disable(dev);
>> +}
>> +
>> +static int khadas_mcu_fan_resume(struct device *dev)
>> +{
>> +	struct khadas_mcu_fan_ctx *ctx = dev_get_drvdata(dev);
>> +
>> +	return khadas_mcu_fan_set_level(ctx, ctx->level);
> 
> Out of curiosity, did you check the fan is not continuously spinning
> after a resume when the suspend happened during a mitigation phase?

No, but I took the logic from the hmwmon pwm-fan driver.

Not sure this is critical here.

Neil

> 
>> +}
>> +#endif
>> +
>> +static SIMPLE_DEV_PM_OPS(khadas_mcu_fan_pm, khadas_mcu_fan_suspend,
>> +			 khadas_mcu_fan_resume);
>> +
>> +static const struct platform_device_id khadas_mcu_fan_id_table[] = {
>> +	{ .name = "khadas-mcu-fan-ctrl", },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(platform, khadas_mcu_fan_id_table);
>> +
>> +static struct platform_driver khadas_mcu_fan_driver = {
>> +	.probe		= khadas_mcu_fan_probe,
>> +	.shutdown	= khadas_mcu_fan_shutdown,
>> +	.driver	= {
>> +		.name		= "khadas-mcu-fan-ctrl",
>> +		.pm		= &khadas_mcu_fan_pm,
>> +	},
>> +	.id_table	= khadas_mcu_fan_id_table,
>> +};
>> +
>> +module_platform_driver(khadas_mcu_fan_driver);
>> +
>> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>> +MODULE_DESCRIPTION("Khadas MCU FAN driver");
>> +MODULE_LICENSE("GPL");
>>
> 
> 

