Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172591D12C4
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 14:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbgEMMdg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 08:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731333AbgEMMdf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 08:33:35 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B74C061A0C
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 05:33:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f134so14188836wmf.1
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 05:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qpWJI6FbhpbhBsS8uD91tXQ8La+pJMlR93bNeYKPQqA=;
        b=xTRxNL+8+QajdVqdoqaLz2GNmho7dYijta8I+VPSQqDtB2JXmKvjpsfL4ApdOOxXnq
         JKD5TKMuAugjlXX9WdtRsdrQvu8ofuPgEH4rAF6vnis9w9LKtA8JngMjdZBBnS0u1vGF
         KmkVpjAMQa+1mYGHUt1kyJ7BN4bOhnaA5mSkm2kOf/QGXudaOxJw3H4T1WDRPM9dHloP
         EkSemID7BtfXhrQCKb4QxEtqDnSlYvc2UxhT1DHLQv9BeNDBr1hHYz0/cRxn8u/XrYtM
         gcQLgE+rgUekF1R/2kP5hMI+ZNL0sM5dkW9SCI/XvU8JgSDxu33xpjkDbqVrlhcnSjv5
         Ac9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qpWJI6FbhpbhBsS8uD91tXQ8La+pJMlR93bNeYKPQqA=;
        b=Hf4tN1GihxbDgMyTc34NjJlTfU7I+CB7/9DSFyNaiyNv+Oxpsw6UaWLrLhIBgA/bo/
         LYJTLC+3sOYGYEgf7yuYMsxOX2eY3zKwdpXDzTKjUdcx49uwFC8uNQ5skcVj5fr0LYum
         K8pWtUsI53ilNpjHS3jbd1Bd50RvEKwQuARrGoIujuq+ycAHO4P457qSuUztO+fvbVaf
         U6S3L0bm+1uE4eI2f8KzaiNhet7+BkiwCI4p/MNsOSPE8qkvkETsRP7aBAz9xC58vCNy
         2pVIF6CQf+MSdYeMKbXE5yBwFYqDMonJ6aTqhJJT9zqBk6EmDRSgLH7Ocxrirv6SBSsk
         mzxg==
X-Gm-Message-State: AGi0PuZoGBuoMLlsyrBLD+S+uHUNtD50A5ON+9Byv0XBKDT1qOhRkqMH
        VQTcPONTm1Pn1QSf71xg3/r+Bw==
X-Google-Smtp-Source: APiQypLafv/klXsRptF5Sb8wEMHohwZ+jSfHlIKPb7TWrj2caQEtrinP6Pd4k6d50wFuGxt6ZvYD7g==
X-Received: by 2002:a1c:7513:: with SMTP id o19mr30771767wmc.104.1589373211812;
        Wed, 13 May 2020 05:33:31 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:4460:3fd3:382:4a71? ([2a01:e35:2ec0:82b0:4460:3fd3:382:4a71])
        by smtp.gmail.com with ESMTPSA id m6sm25978063wrq.5.2020.05.13.05.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 05:33:31 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] nvmem: add support for the Khadas MCU Programmable
 User Memory
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200512132613.31507-1-narmstrong@baylibre.com>
 <20200512132613.31507-5-narmstrong@baylibre.com>
 <09026bde-0ae7-b1a4-835f-bf2481199398@linaro.org>
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
Message-ID: <b885eeb5-1542-775f-ab7b-b1218c6a337a@baylibre.com>
Date:   Wed, 13 May 2020 14:33:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <09026bde-0ae7-b1a4-835f-bf2481199398@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/05/2020 12:34, Srinivas Kandagatla wrote:
> 
> 
> On 12/05/2020 14:26, Neil Armstrong wrote:
>> The new Khadas VIM2, VIM3 and Edge boards embeds an on-board microcontroller
>> offering a 56bytes User Programmable NVMEM array.
>>
>> This array needs a password to be writable, thus a password sysfs file
>> has been added on the device node to unlock the NVMEM.
> 
> Is this one time programmable? Or does it need to be unlocked for every read/write?

It can be rewritten, and needs the password to read & write.

> 
> How can you make sure that the memory is unlocked before making attempt to read/write?

The only way to know it's unlock is reading back the password when unlocked.

> 
>>
>> The default 6bytes password id: "Khadas"
>>
>> This implements the user NVMEM devices as cell of the Khadas MCU MFD driver.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>   drivers/nvmem/Kconfig               |   8 ++
>>   drivers/nvmem/Makefile              |   2 +
>>   drivers/nvmem/khadas-mcu-user-mem.c | 128 ++++++++++++++++++++++++++++
>>   3 files changed, 138 insertions(+)
>>   create mode 100644 drivers/nvmem/khadas-mcu-user-mem.c
>>
>> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
>> index d7b7f6d688e7..92cd4f6aa931 100644
>> --- a/drivers/nvmem/Kconfig
>> +++ b/drivers/nvmem/Kconfig
>> @@ -67,6 +67,14 @@ config JZ4780_EFUSE
>>         To compile this driver as a module, choose M here: the module
>>         will be called nvmem_jz4780_efuse.
>>   +config NVMEM_KHADAS_MCU_USER_MEM
>> +    tristate "Khadas MCU User programmable memory support"
>> +    depends on MFD_KHADAS_MCU
>> +    depends on REGMAP
>> +    help
>> +      This is a driver for the MCU User programmable memory
>> +      available on the Khadas VIM and Edge boards.
>> +
>>   config NVMEM_LPC18XX_EEPROM
>>       tristate "NXP LPC18XX EEPROM Memory Support"
>>       depends on ARCH_LPC18XX || COMPILE_TEST
>> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
>> index a7c377218341..0516a309542d 100644
>> --- a/drivers/nvmem/Makefile
>> +++ b/drivers/nvmem/Makefile
>> @@ -17,6 +17,8 @@ obj-$(CONFIG_NVMEM_IMX_OCOTP_SCU)    += nvmem-imx-ocotp-scu.o
>>   nvmem-imx-ocotp-scu-y        := imx-ocotp-scu.o
>>   obj-$(CONFIG_JZ4780_EFUSE)        += nvmem_jz4780_efuse.o
>>   nvmem_jz4780_efuse-y        := jz4780-efuse.o
>> +obj-$(CONFIG_NVMEM_KHADAS_MCU_USER_MEM)    += nvmem-khadas-mcu-user-mem.o
>> +nvmem-khadas-mcu-user-mem-y    := khadas-mcu-user-mem.o
>>   obj-$(CONFIG_NVMEM_LPC18XX_EEPROM)    += nvmem_lpc18xx_eeprom.o
>>   nvmem_lpc18xx_eeprom-y    := lpc18xx_eeprom.o
>>   obj-$(CONFIG_NVMEM_LPC18XX_OTP)    += nvmem_lpc18xx_otp.o
>> diff --git a/drivers/nvmem/khadas-mcu-user-mem.c b/drivers/nvmem/khadas-mcu-user-mem.c
>> new file mode 100644
>> index 000000000000..a1d5ae9a030c
>> --- /dev/null
>> +++ b/drivers/nvmem/khadas-mcu-user-mem.c
>> @@ -0,0 +1,128 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for Khadas MCU User programmable Memory
>> + *
>> + * Copyright (C) 2020 BayLibre SAS
>> + * Author(s): Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +#include <linux/clk.h>
> 
> Why do we need this header?

Will drop

> 
>> +#include <linux/module.h>
>> +#include <linux/nvmem-provider.h>
>> +#include <linux/mfd/khadas-mcu.h>
>> +#include <linux/regmap.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +
>> +static int khadas_mcu_user_mem_read(void *context, unsigned int offset,
>> +                void *val, size_t bytes)
>> +{
>> +    struct khadas_mcu *khadas_mcu = context;
>> +
>> +    return regmap_bulk_read(khadas_mcu->map,
>> +                KHADAS_MCU_USER_DATA_0_REG + offset,
>> +                val, bytes);
>> +}
>> +
>> +static int khadas_mcu_user_mem_write(void *context, unsigned int offset,
>> +                 void *val, size_t bytes)
>> +{
>> +    struct khadas_mcu *khadas_mcu = context;
>> +
>> +    return regmap_bulk_write(khadas_mcu->map,
>> +                KHADAS_MCU_USER_DATA_0_REG + offset,
>> +                val, bytes);
>> +}
>> +
>> +static ssize_t password_store(struct device *dev, struct device_attribute *attr,
>> +                 const char *buf, size_t count)
>> +{
>> +    struct khadas_mcu *khadas_mcu = dev_get_drvdata(dev);
>> +    int i, ret;
>> +
>> +    if (count < 6)
>> +        return -EINVAL;
> 
> Possibly this magic 6 value needs proper define. An additional check here for > 6 would be better as well.

Ok

> 
>> +
>> +    ret = regmap_write(khadas_mcu->map, KHADAS_MCU_PASSWD_START_REG, 1);
>> +    if (ret)
>> +        return ret;
>> +
>> +    for (i = 0 ; i < 6 ; ++i) {
>> +        ret = regmap_write(khadas_mcu->map,
>> +                   KHADAS_MCU_CHECK_USER_PASSWD_REG,
>> +                   buf[i]);
>> +        if (ret)
>> +            goto out;
>> +    }
>> +
>> +    ret = regmap_write(khadas_mcu->map, KHADAS_MCU_PASSWD_START_REG, 0);
>> +    if (ret)
>> +        return ret;
>> +
>> +    return count;
>> +out:
>> +    regmap_write(khadas_mcu->map, KHADAS_MCU_PASSWD_START_REG, 0);
>> +
>> +    return ret;
>> +}
>> +
>> +static DEVICE_ATTR_WO(password);
>> +
>> +static struct attribute *khadas_mcu_user_mem_sysfs_attributes[] = {
>> +    &dev_attr_password.attr,
>> +    NULL,
>> +};
>> +
>> +static const struct attribute_group khadas_mcu_user_mem_sysfs_attr_group = {
>> +    .attrs = khadas_mcu_user_mem_sysfs_attributes,
>> +};
>> +
>> +static int khadas_mcu_user_mem_probe(struct platform_device *pdev)
>> +{
>> +    struct khadas_mcu *khadas_mcu = dev_get_drvdata(pdev->dev.parent);
> 
> You could probably get away with dependency of this structure and the header itself by directly getting hold of regmap from parent device.

Ok

> 
> 
>> +    struct device *dev = &pdev->dev;
>> +    struct nvmem_device *nvmem;
>> +    struct nvmem_config *econfig;
>> +
>> +    econfig = devm_kzalloc(dev, sizeof(*econfig), GFP_KERNEL);
>> +    if (!econfig)
>> +        return -ENOMEM;
>> +
>> +    econfig->dev = pdev->dev.parent;
>> +    econfig->name = dev_name(pdev->dev.parent);
>> +    econfig->stride = 1;
>> +    econfig->word_size = 1;
>> +    econfig->reg_read = khadas_mcu_user_mem_read;
>> +    econfig->reg_write = khadas_mcu_user_mem_write;
>> +    econfig->size = 56;
> define 56 to make it more readable!

Ok

> 
>> +    econfig->priv = khadas_mcu;
>> +
>> +    platform_set_drvdata(pdev, khadas_mcu);
>> +
>> +    nvmem = devm_nvmem_register(&pdev->dev, econfig);
>> +    if (IS_ERR(nvmem))
>> +        return PTR_ERR(nvmem);
>> +
>> +    return sysfs_create_group(&pdev->dev.kobj,
>> +                  &khadas_mcu_user_mem_sysfs_attr_group);
>> +}
>> +
>> +static const struct platform_device_id khadas_mcu_user_mem_id_table[] = {
>> +    { .name = "khadas-mcu-user-mem", },
>> +    {},
>> +};
>> +MODULE_DEVICE_TABLE(platform, khadas_mcu_user_mem_id_table);
>> +
>> +static struct platform_driver khadas_mcu_user_mem_driver = {
>> +    .probe = khadas_mcu_user_mem_probe,
>> +    .driver = {
>> +        .name = "khadas-mcu-user-mem",
>> +    },
>> +    .id_table = khadas_mcu_user_mem_id_table,
>> +};
>> +
>> +module_platform_driver(khadas_mcu_user_mem_driver);
>> +
>> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>> +MODULE_DESCRIPTION("Khadas MCU User MEM driver");
>> +MODULE_LICENSE("GPL v2");
>>

Thanks for the review.

Neil
