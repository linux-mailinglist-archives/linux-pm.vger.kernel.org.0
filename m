Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560F41D4BB9
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 12:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgEOKzO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 06:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgEOKzN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 06:55:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34552C061A0C
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 03:55:13 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k13so903251wrx.3
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 03:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I2QvltFHXQr9p9UAZpJJikt11QdGcy1kML39gcXzFpA=;
        b=FUG5/nfs93Vz9iLBxx1HJeFDwVyW9gYFMrxT8X0cJMc8g32DDo1wXujDbv5y9gwpiX
         3PWkfTRqNvjT2sbxdOkc4fZlYpr3NZo6rFaLM5iinXAEVn8gngkMp8nGyba+9wsskqeb
         peXTVhAs9A3fwdEGwQF+GoIPmDN8TEzrqt66wPrd0HppqRz6MEYBIKDf1Z3mKiPifTr0
         ZOIvS1f61RLWyo0m68uhpeXAQRaEMnj231Qk0/Q6y4E9LlY/QVWGrEqID1Jf7CY1YLvs
         JlyGfY5NwSFqKW/pAAF0k5ZnyMmfC7xZyY+s+zkFkjoZF9iud8ave2d5cF9rQOz+8xlJ
         RS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I2QvltFHXQr9p9UAZpJJikt11QdGcy1kML39gcXzFpA=;
        b=eNStnPSePqQE/rvfTEh06Z2Gux+uHkxhJVYcc4V8w/9itEUYFGZdx/QvK7Id6/fQdN
         vyfw66sfLvxKOlDA9Y+HSoQBHGsAo3uiNML3FtvC8Z55PtDjEmvg9w+cDer3LYNb0z8y
         25E+BAm0XpBYI0rc4c+hNGiQAKlxGARE/P8dUwezOfX5hHF4gA7EDwdYMoeuFhsJt/7O
         gcLItH+L3jEMHTIEFYtCDT7Io7kWgeU93MuV4Kd5ucTBEiIpkYrfjTeHS9EwISkTgAD5
         3oFPoJCvuLXWnOzhnU2cM83UxEvfzpxREsnkvZ+zsKatBRI64/2yaRLZB5O1Ybe0aPdJ
         GIFg==
X-Gm-Message-State: AOAM531hz9GWF8GZEFB2kg8dfqF+sDNh/5FaW0RkyqpRGwih+DnrtdCS
        AK6fHBc0lwT3rokoTWKczlCaj3Tav0Y=
X-Google-Smtp-Source: ABdhPJwxJwVGq73LEGsq6Gfb9MLvFXk2uQziWIzkwbUGxyOf8Pu8pBbXSqg6Q+vqOvNnKoC3O3kxGg==
X-Received: by 2002:adf:9422:: with SMTP id 31mr3798066wrq.10.1589540111763;
        Fri, 15 May 2020 03:55:11 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id n9sm3301452wmj.5.2020.05.15.03.55.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2020 03:55:11 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] nvmem: add support for the Khadas MCU Programmable
 User Memory
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200512132613.31507-1-narmstrong@baylibre.com>
 <20200512132613.31507-5-narmstrong@baylibre.com>
 <09026bde-0ae7-b1a4-835f-bf2481199398@linaro.org>
 <b885eeb5-1542-775f-ab7b-b1218c6a337a@baylibre.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <5f24e094-088b-5787-f1be-158ab9412812@linaro.org>
Date:   Fri, 15 May 2020 11:55:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b885eeb5-1542-775f-ab7b-b1218c6a337a@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 13/05/2020 13:33, Neil Armstrong wrote:
> On 13/05/2020 12:34, Srinivas Kandagatla wrote:
>>
>>
>> On 12/05/2020 14:26, Neil Armstrong wrote:
>>> The new Khadas VIM2, VIM3 and Edge boards embeds an on-board microcontroller
>>> offering a 56bytes User Programmable NVMEM array.
>>>
>>> This array needs a password to be writable, thus a password sysfs file
>>> has been added on the device node to unlock the NVMEM.
>>
>> Is this one time programmable? Or does it need to be unlocked for every read/write?
> 
> It can be rewritten, and needs the password to read & write.
> 
>>
>> How can you make sure that the memory is unlocked before making attempt to read/write?
> 
> The only way to know it's unlock is reading back the password when unlocked.


Current code has no such checks for every read/write?
and looks very disconnected w.r.t to password and read/writes.

If user attempts to read/write he will not be aware that he should 
program the password first!

Also if the password is static or un-changed then why not just 
statically program this from the driver rather than providing sysfs file?

I dont see how kernel nvmem read/write interface can make sure that 
memory is unlocked?

Who is the real consumer for this provider?

--srini


> 
>>
>>>
>>> The default 6bytes password id: "Khadas"
>>>
>>> This implements the user NVMEM devices as cell of the Khadas MCU MFD driver.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>>    drivers/nvmem/Kconfig               |   8 ++
>>>    drivers/nvmem/Makefile              |   2 +
>>>    drivers/nvmem/khadas-mcu-user-mem.c | 128 ++++++++++++++++++++++++++++
>>>    3 files changed, 138 insertions(+)
>>>    create mode 100644 drivers/nvmem/khadas-mcu-user-mem.c
>>>
>>> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
>>> index d7b7f6d688e7..92cd4f6aa931 100644
>>> --- a/drivers/nvmem/Kconfig
>>> +++ b/drivers/nvmem/Kconfig
>>> @@ -67,6 +67,14 @@ config JZ4780_EFUSE
>>>          To compile this driver as a module, choose M here: the module
>>>          will be called nvmem_jz4780_efuse.
>>>    +config NVMEM_KHADAS_MCU_USER_MEM
>>> +    tristate "Khadas MCU User programmable memory support"
>>> +    depends on MFD_KHADAS_MCU
>>> +    depends on REGMAP
>>> +    help
>>> +      This is a driver for the MCU User programmable memory
>>> +      available on the Khadas VIM and Edge boards.
>>> +
>>>    config NVMEM_LPC18XX_EEPROM
>>>        tristate "NXP LPC18XX EEPROM Memory Support"
>>>        depends on ARCH_LPC18XX || COMPILE_TEST
>>> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
>>> index a7c377218341..0516a309542d 100644
>>> --- a/drivers/nvmem/Makefile
>>> +++ b/drivers/nvmem/Makefile
>>> @@ -17,6 +17,8 @@ obj-$(CONFIG_NVMEM_IMX_OCOTP_SCU)    += nvmem-imx-ocotp-scu.o
>>>    nvmem-imx-ocotp-scu-y        := imx-ocotp-scu.o
>>>    obj-$(CONFIG_JZ4780_EFUSE)        += nvmem_jz4780_efuse.o
>>>    nvmem_jz4780_efuse-y        := jz4780-efuse.o
>>> +obj-$(CONFIG_NVMEM_KHADAS_MCU_USER_MEM)    += nvmem-khadas-mcu-user-mem.o
>>> +nvmem-khadas-mcu-user-mem-y    := khadas-mcu-user-mem.o
>>>    obj-$(CONFIG_NVMEM_LPC18XX_EEPROM)    += nvmem_lpc18xx_eeprom.o
>>>    nvmem_lpc18xx_eeprom-y    := lpc18xx_eeprom.o
>>>    obj-$(CONFIG_NVMEM_LPC18XX_OTP)    += nvmem_lpc18xx_otp.o
>>> diff --git a/drivers/nvmem/khadas-mcu-user-mem.c b/drivers/nvmem/khadas-mcu-user-mem.c
>>> new file mode 100644
>>> index 000000000000..a1d5ae9a030c
>>> --- /dev/null
>>> +++ b/drivers/nvmem/khadas-mcu-user-mem.c
>>> @@ -0,0 +1,128 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Driver for Khadas MCU User programmable Memory
>>> + *
>>> + * Copyright (C) 2020 BayLibre SAS
>>> + * Author(s): Neil Armstrong <narmstrong@baylibre.com>
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>
>> Why do we need this header?
> 
> Will drop
> 
>>
>>> +#include <linux/module.h>
>>> +#include <linux/nvmem-provider.h>
>>> +#include <linux/mfd/khadas-mcu.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/of.h>
>>> +#include <linux/platform_device.h>
>>> +
>>> +static int khadas_mcu_user_mem_read(void *context, unsigned int offset,
>>> +                void *val, size_t bytes)
>>> +{
>>> +    struct khadas_mcu *khadas_mcu = context;
>>> +
>>> +    return regmap_bulk_read(khadas_mcu->map,
>>> +                KHADAS_MCU_USER_DATA_0_REG + offset,
>>> +                val, bytes);
>>> +}
>>> +
>>> +static int khadas_mcu_user_mem_write(void *context, unsigned int offset,
>>> +                 void *val, size_t bytes)
>>> +{
>>> +    struct khadas_mcu *khadas_mcu = context;
>>> +
>>> +    return regmap_bulk_write(khadas_mcu->map,
>>> +                KHADAS_MCU_USER_DATA_0_REG + offset,
>>> +                val, bytes);
>>> +}
>>> +
>>> +static ssize_t password_store(struct device *dev, struct device_attribute *attr,
>>> +                 const char *buf, size_t count)
>>> +{
>>> +    struct khadas_mcu *khadas_mcu = dev_get_drvdata(dev);
>>> +    int i, ret;
>>> +
>>> +    if (count < 6)
>>> +        return -EINVAL;
>>
>> Possibly this magic 6 value needs proper define. An additional check here for > 6 would be better as well.
> 
> Ok
> 
>>
>>> +
>>> +    ret = regmap_write(khadas_mcu->map, KHADAS_MCU_PASSWD_START_REG, 1);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    for (i = 0 ; i < 6 ; ++i) {
>>> +        ret = regmap_write(khadas_mcu->map,
>>> +                   KHADAS_MCU_CHECK_USER_PASSWD_REG,
>>> +                   buf[i]);
>>> +        if (ret)
>>> +            goto out;
>>> +    }
>>> +
>>> +    ret = regmap_write(khadas_mcu->map, KHADAS_MCU_PASSWD_START_REG, 0);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    return count;
>>> +out:
>>> +    regmap_write(khadas_mcu->map, KHADAS_MCU_PASSWD_START_REG, 0);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static DEVICE_ATTR_WO(password);
>>> +
>>> +static struct attribute *khadas_mcu_user_mem_sysfs_attributes[] = {
>>> +    &dev_attr_password.attr,
>>> +    NULL,
>>> +};
>>> +
>>> +static const struct attribute_group khadas_mcu_user_mem_sysfs_attr_group = {
>>> +    .attrs = khadas_mcu_user_mem_sysfs_attributes,
>>> +};
>>> +
>>> +static int khadas_mcu_user_mem_probe(struct platform_device *pdev)
>>> +{
>>> +    struct khadas_mcu *khadas_mcu = dev_get_drvdata(pdev->dev.parent);
>>
>> You could probably get away with dependency of this structure and the header itself by directly getting hold of regmap from parent device.
> 
> Ok
> 
>>
>>
>>> +    struct device *dev = &pdev->dev;
>>> +    struct nvmem_device *nvmem;
>>> +    struct nvmem_config *econfig;
>>> +
>>> +    econfig = devm_kzalloc(dev, sizeof(*econfig), GFP_KERNEL);
>>> +    if (!econfig)
>>> +        return -ENOMEM;
>>> +
>>> +    econfig->dev = pdev->dev.parent;
>>> +    econfig->name = dev_name(pdev->dev.parent);
>>> +    econfig->stride = 1;
>>> +    econfig->word_size = 1;
>>> +    econfig->reg_read = khadas_mcu_user_mem_read;
>>> +    econfig->reg_write = khadas_mcu_user_mem_write;
>>> +    econfig->size = 56;
>> define 56 to make it more readable!
> 
> Ok
> 
>>
>>> +    econfig->priv = khadas_mcu;
>>> +
>>> +    platform_set_drvdata(pdev, khadas_mcu);
>>> +
>>> +    nvmem = devm_nvmem_register(&pdev->dev, econfig);
>>> +    if (IS_ERR(nvmem))
>>> +        return PTR_ERR(nvmem);
>>> +
>>> +    return sysfs_create_group(&pdev->dev.kobj,
>>> +                  &khadas_mcu_user_mem_sysfs_attr_group);
>>> +}
>>> +
>>> +static const struct platform_device_id khadas_mcu_user_mem_id_table[] = {
>>> +    { .name = "khadas-mcu-user-mem", },
>>> +    {},
>>> +};
>>> +MODULE_DEVICE_TABLE(platform, khadas_mcu_user_mem_id_table);
>>> +
>>> +static struct platform_driver khadas_mcu_user_mem_driver = {
>>> +    .probe = khadas_mcu_user_mem_probe,
>>> +    .driver = {
>>> +        .name = "khadas-mcu-user-mem",
>>> +    },
>>> +    .id_table = khadas_mcu_user_mem_id_table,
>>> +};
>>> +
>>> +module_platform_driver(khadas_mcu_user_mem_driver);
>>> +
>>> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>>> +MODULE_DESCRIPTION("Khadas MCU User MEM driver");
>>> +MODULE_LICENSE("GPL v2");
>>>
> 
> Thanks for the review.
> 
> Neil
> 
