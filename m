Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBB72B3A8C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 00:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgKOXMe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Nov 2020 18:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgKOXMd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Nov 2020 18:12:33 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9C2C0613CF;
        Sun, 15 Nov 2020 15:12:31 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id 11so18119897ljf.2;
        Sun, 15 Nov 2020 15:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+d69nkc43tsxlWAdrY2B8Lv8/D9Hq7HoZ8uP+nxtrpU=;
        b=rw/MacKYgPqufYzCAcV49V9EFPkaGaY49qdhek/4+wuqbCFb3KLnZqichUMsNzXgt3
         H1osuM3WWraMicDdhUhO9ZTmmX7BM1f0hDC2gBbZRW4cILup2m2wuNdPF8phJYSAPxru
         vaWKJB9Zzd8Pj2PCsjloR76pHj3EctM+be3YMh/dBftfZV0hmDWBMirSxXtqduBDTG/m
         LmyGF9JWzkCpVkkF2lTNBP/6UvYQv/nfgyPHyRGHt6oOgMA+HVh2NY1Dw7e6u3BhZi+3
         ShdTQf8vdNazLWQUalPaHsEB5A3uXNO/Bo9ZWNKnP7trLRP8ewla8Cxzz16aehIIFbyb
         prYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+d69nkc43tsxlWAdrY2B8Lv8/D9Hq7HoZ8uP+nxtrpU=;
        b=Xhi5IyACryoZLUyvjnKDkHC0/2fbyRetYnXSX100050yCDLaQ1ZIYdKjQrm/z67Bx7
         eyfNQeFyT6wU8FYhSd02rSxOUVoq7oFTCrCbEA8LeyeKCO2/f/sAGBI6N25xq6pIUNbS
         eBZSdcEBX60YucjkCX/mjMJVF7tMz9xgfMzCdbjz2StnwaO1mHe2PB1aR8oH8g0CZ6G7
         IBtmBzRRcro8+0xz3RSnoocBQBmGdpYkpfgW0QCWPmbru2DJzlEY8CDu6+RjIq8jMjfG
         100pVN3XAzONsgf2pYcZfTs2vgCDwZFEL2BP3LXKcaxwiJh1T0QzJyPv9E3QADge1oS9
         Hw0g==
X-Gm-Message-State: AOAM532Etqk3InqgGhQDANs0acR7hdQxC+JECwpMEkWShYV0sonl+tpZ
        YNqvV3NO/ANncWtlpiBEjFe1eS4RfYI=
X-Google-Smtp-Source: ABdhPJweNLpJrdfTfSIrR2pHU83vh4d7qoq/W7T4NCC96902xjSBicuLhW6l2KkEi2owX/3xqbrTyA==
X-Received: by 2002:a2e:9207:: with SMTP id k7mr4906912ljg.71.1605481950294;
        Sun, 15 Nov 2020 15:12:30 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id w12sm2519786ljo.67.2020.11.15.15.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 15:12:29 -0800 (PST)
Subject: Re: [PATCH v5 2/4] mfd: Add driver for Embedded Controller found on
 Acer Iconia Tab A500
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201104203403.24937-1-digetx@gmail.com>
 <20201104203403.24937-3-digetx@gmail.com> <20201113093747.GJ2787115@dell>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3ad644fd-cd03-a1e1-36d9-014304fdfcee@gmail.com>
Date:   Mon, 16 Nov 2020 02:12:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201113093747.GJ2787115@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

13.11.2020 12:37, Lee Jones пишет:
...
>> +config MFD_ACER_A500_EC
>> +	tristate "Embedded Controller driver for Acer Iconia Tab A500"
> 
> Drop "driver".  This is meant to be describing the device.
> 
>> +	depends on I2C
> 
> depends on OF ?
...
>> +	depends on ARCH_TEGRA_2x_SOC || COMPILE_TEST
>> +	select MFD_CORE
>> +	select REGMAP
>> +	help

ARCH_TEGRA_2x_SOC selects OF.

For COMPILE_TEST it doesn't matter since OF framework provides stubs for
!OF.

...
>> +static int a500_ec_read(void *context, const void *reg_buf, size_t reg_size,
>> +			void *val_buf, size_t val_sizel)
>> +{
>> +	struct i2c_client *client = context;
>> +	unsigned int reg, retries = 5;
>> +	u16 *ret_val = val_buf;
>> +	s32 ret = 0;
>> +
>> +	if (reg_size != 1 || val_sizel != 2)
> 
> No magic numbers please.
> 
> What does this *mean*?

These are the size of address register and size of a read value, both in
bytes.

>> +		return -EOPNOTSUPP;
> 
> Why EOPNOTSUPP?

Other sizes aren't supported by embedded controller.

Although, perhaps this check isn't really needed at all since the sizes
are already expressed in the a500_ec_regmap_config.

I'll need to take a closer look at why this size-checking was added
because don't quite remember already. If it's not needed, then I'll
remove it in the next revision, otherwise will add a clarifying comment.

>> +	reg = *(u8 *)reg_buf;
>> +
>> +	while (retries-- > 0) {
>> +		ret = i2c_smbus_read_word_data(client, reg);
>> +		if (ret >= 0)
>> +			break;
>> +
>> +		msleep(A500_EC_I2C_ERR_TIMEOUT);
>> +	}
>> +
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "read 0x%x failed: %d\n", reg, ret);
>> +		return ret;
>> +	}
>> +
>> +	*ret_val = ret;
>> +
>> +	if (reg == REG_CURRENT_NOW)
>> +		fsleep(10000);
> 
> Ooo, new toy!
> 
>> +	return 0;
>> +}
> 
> I'm surprised there isn't a generic function which does this kind of
> read.  Seems like pretty common/boilerplate stuff.

I'm not quite sure that this is a really very common pattern which
deserves a generic helper.

...
>> +static int a500_ec_restart_notify(struct notifier_block *this,
>> +				  unsigned long reboot_mode, void *data)
>> +{
>> +	if (reboot_mode == REBOOT_WARM)
>> +		i2c_smbus_write_word_data(a500_ec_client_pm_off,
>> +					  REG_WARM_REBOOT, 0);
>> +	else
>> +		i2c_smbus_write_word_data(a500_ec_client_pm_off,
>> +					  REG_COLD_REBOOT, 1);
> 
> What's with the magic '0' and '1's at the end?

These are the values which controller's firmware wants to see, otherwise
it will reject command as invalid. I'll add a clarifying comment to the
code.

Thank you for the review. I'll address all the comments in the v7.
