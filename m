Return-Path: <linux-pm+bounces-8341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A888D30C6
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 10:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFFF1F24CED
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 08:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795C518132D;
	Wed, 29 May 2024 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UEqCNGs+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7079318130F
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970124; cv=none; b=gYSN1pnkGIteaeftmehaORztTibjmLfiEfmw9iGpc7mt6/PR2jrJMJG8oARe4ZF9XW/calteVeYhSvwfZvDODDplMrEoSvR5MOpFDR2JJv2fsKq1TNfeHrCPLhrdM0yM349zXKoo8EPFXyA9t7iX4nrORTjtlbliCtdzua8QjjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970124; c=relaxed/simple;
	bh=T3LsNDsQjui6zBSWsbGtzYkzQN8h8gfwvEMkMXJ//Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovJuhBXIKKtP1smQhKj/MdX4aphQ7qx8IXAuKXDZ9EZUDLKqnOhiO57AWYlPU9vlY7XoHjNChjNpiDt1d+h19xz5flSq+Nne7sZ5if/vb0DGJi8Nwf2XdcN58wb64XpCLmOLr4Z60v0iA5+f6KoVDpYtyQPAzsWCd6gCFU9VGAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UEqCNGs+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-421205e8cdeso17830005e9.1
        for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 01:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716970121; x=1717574921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/JqdadxOtCgPk5Z92J6Iz23Jf3+Y16joj23RLu5HX0=;
        b=UEqCNGs+fNHoYv50zpSrTx/PiSv4obl+HDUKrrSNy4QdgzTjjO2e7nGSFuzJfkxQni
         sQtcbBmcwYQvL2Kd0uwlR3YggHK/S1eouMJ6a/vkgJdjc2QQVxVhaMcpxuR2keWz5gkM
         4VuqMiXAmfO/hsvoA0Tk3rTSV+DA/O6pSzypolQT/wi99XnRs/xjYcS9cVFIw56oOG0Q
         WvxsKzby+xQKRyD8C5oQWzoFMk9vbcvWpRH0YEEEkVezx9U/ldTn5Pi8r8xuGZDeiR2v
         +161X7nuHqgGEy5L3vlLqQUsfuo42cxHzVI6w7TKe9unRrIaRm8vnLgyFnVuRNi9/2x8
         iCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970121; x=1717574921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/JqdadxOtCgPk5Z92J6Iz23Jf3+Y16joj23RLu5HX0=;
        b=KAEa8vLk/QRs4tS9eWdFLtYbrv5OdPZKBEhpTXCxu6Cn0JeU1OOKauEMiRVCoeNtYd
         icxT9Tw1Qu6ynSJu7B9/ZnXX/mziMfZJh/o03MSXeTBin3OItjVEAMGCMPKvaJTv7urI
         SoS9iPwKuKgt9mLDIezp4CPbdEtTJJU1hcBG0VGwfq5RLhb2VdiJ6nTeambfjDrxKsaL
         HXi2JR+68Y7pk1SE/FfoRh3pgPDZoClUKVNoVzSC4KaQQsS4Nk9rlY1a8+p0Kg29syoG
         mw5rtmCNKKwzIyzX0JsEGIBSXjKin0m6/B9aVLIJzVMnztRP8UnaODVAUqhl7iLyvN7D
         fm+A==
X-Forwarded-Encrypted: i=1; AJvYcCVlPbP5iYRpl3NQn/w2szAdH3EL2d2MDCyNLs9A45pQeG/d7RVmPcA1aLxf99WbyqxQEVZlFPqLpJ43DY40Iy2fhIGxxUBfwMQ=
X-Gm-Message-State: AOJu0Yy3vAKolJ3wdip+8FVtsLdTIjlNR0pvLlM8cu82Z7jyOkT01mkV
	SC+yKNrxCVt8cFaEQL0UPZILBstUhAzRHdfv/l2ScYGyqA91kYJboNLz6FRdlC0=
X-Google-Smtp-Source: AGHT+IG37BWRZMEjsIkkPqzKrnfVQeOHaDJWHEmylLb4ayfm/w5tbXgAnW+F/WgUw+Xxl6kVsnytaw==
X-Received: by 2002:a05:600c:5354:b0:420:f8:23d6 with SMTP id 5b1f17b1804b1-42108aa7589mr151469755e9.36.1716970120703;
        Wed, 29 May 2024 01:08:40 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a090366sm13891799f8f.56.2024.05.29.01.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 01:08:40 -0700 (PDT)
Message-ID: <0f337380-4e43-4ed4-aa05-0c7072ecd112@linaro.org>
Date: Wed, 29 May 2024 09:08:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] platform: arm64: add Lenovo Yoga C630 WOS EC
 driver
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
References: <20240528-yoga-ec-driver-v4-0-4fa8dfaae7b6@linaro.org>
 <20240528-yoga-ec-driver-v4-2-4fa8dfaae7b6@linaro.org>
 <2b76f27e-f223-4ff9-880e-9e232ce9ddc6@linaro.org>
 <3gbjbuav5l2td5xrfj46krhgdew42medhfrnkd47iahdv4fm3x@qv6jadf6tkol>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <3gbjbuav5l2td5xrfj46krhgdew42medhfrnkd47iahdv4fm3x@qv6jadf6tkol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/05/2024 00:56, Dmitry Baryshkov wrote:
> On Wed, May 29, 2024 at 12:51:04AM +0100, Bryan O'Donoghue wrote:
>> On 28/05/2024 21:44, Dmitry Baryshkov wrote:
>>> Lenovo Yoga C630 WOS is a laptop using Snapdragon 850 SoC. Like many
>>> laptops it uses embedded controller (EC) to perform various platform
>>
>> an embedded controller
>>
>>> operations, including, but not limited, to Type-C port control or power
>>> supply handlng.
>>>
>>> Add the driver for the EC, that creates devices for UCSI and power
>>> supply devices.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>    drivers/platform/arm64/Kconfig                 |  14 ++
>>>    drivers/platform/arm64/Makefile                |   1 +
>>>    drivers/platform/arm64/lenovo-yoga-c630.c      | 279 +++++++++++++++++++++++++
>>>    include/linux/platform_data/lenovo-yoga-c630.h |  42 ++++
>>>    4 files changed, 336 insertions(+)
>>>
>>> diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kconfig
>>> index 8fdca0f8e909..8c103b3150d1 100644
>>> --- a/drivers/platform/arm64/Kconfig
>>> +++ b/drivers/platform/arm64/Kconfig
>>> @@ -32,4 +32,18 @@ config EC_ACER_ASPIRE1
>>>    	  laptop where this information is not properly exposed via the
>>>    	  standard ACPI devices.
>>> +config EC_LENOVO_YOGA_C630
>>> +	tristate "Lenovo Yoga C630 Embedded Controller driver"
>>> +	depends on I2C
>>> +	help
>>> +	  Driver for the Embedded Controller in the Qualcomm Snapdragon-based
>>> +	  Lenovo Yoga C630, which provides battery and power adapter
>>> +	  information.
>>> +
>>> +	  This driver provides battery and AC status support for the mentioned
>>> +	  laptop where this information is not properly exposed via the
>>> +	  standard ACPI devices.
>>> +
>>> +	  Say M or Y here to include this support.
>>> +
>>>    endif # ARM64_PLATFORM_DEVICES
>>> diff --git a/drivers/platform/arm64/Makefile b/drivers/platform/arm64/Makefile
>>> index 4fcc9855579b..b2ae9114fdd8 100644
>>> --- a/drivers/platform/arm64/Makefile
>>> +++ b/drivers/platform/arm64/Makefile
>>> @@ -6,3 +6,4 @@
>>>    #
>>>    obj-$(CONFIG_EC_ACER_ASPIRE1)	+= acer-aspire1-ec.o
>>> +obj-$(CONFIG_EC_LENOVO_YOGA_C630) += lenovo-yoga-c630.o
>>> diff --git a/drivers/platform/arm64/lenovo-yoga-c630.c b/drivers/platform/arm64/lenovo-yoga-c630.c
>>> new file mode 100644
>>> index 000000000000..3d1d5acde807
>>> --- /dev/null
>>> +++ b/drivers/platform/arm64/lenovo-yoga-c630.c
>>> @@ -0,0 +1,279 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Copyright (c) 2022-2024, Linaro Ltd
>>> + * Authors:
>>> + *    Bjorn Andersson
>>> + *    Dmitry Baryshkov
>>> + */
>>> +#include <linux/auxiliary_bus.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/module.h>
>>> +#include <linux/notifier.h>
>>> +#include <linux/platform_data/lenovo-yoga-c630.h>
>>> +
>>> +#define LENOVO_EC_RESPONSE_REG		0x01
>>> +#define LENOVO_EC_REQUEST_REG		0x02
>>> +
>>> +#define LENOVO_EC_UCSI_WRITE		0x20
>>> +#define LENOVO_EC_UCSI_READ		0x21
>>> +
>>> +#define LENOVO_EC_READ_REG		0xb0
>>> +#define LENOVO_EC_REQUEST_NEXT_EVENT	0x84
>>> +
>>> +struct yoga_c630_ec {
>>> +	struct i2c_client *client;
>>> +	struct mutex lock;
>>> +	struct blocking_notifier_head notifier_list;
>>> +};
>>> +
>>> +static int yoga_c630_ec_request(struct yoga_c630_ec *ec, u8 *req, size_t req_len,
>>> +				u8 *resp, size_t resp_len)
>>> +{
>>> +	int ret;
>>> +
>>> +	WARN_ON(!mutex_is_locked(&ec->lock));
>>> +
>>> +	ret = i2c_smbus_write_i2c_block_data(ec->client, LENOVO_EC_REQUEST_REG,
>>> +					     req_len, req);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	return i2c_smbus_read_i2c_block_data(ec->client, LENOVO_EC_RESPONSE_REG,
>>> +					     resp_len, resp);
>>> +}
>>> +
>>> +int yoga_c630_ec_read8(struct yoga_c630_ec *ec, u8 addr)
>>> +{
>>> +	u8 req[2] = { LENOVO_EC_READ_REG, };
>>> +	int ret;
>>> +	u8 val;
>>> +
>>> +	mutex_lock(&ec->lock);
>>> +	req[1] = addr;
>>> +	ret = yoga_c630_ec_request(ec, req, sizeof(req), &val, 1);
>>> +	mutex_unlock(&ec->lock);
>>> +
>>> +	return ret < 0 ? ret : val;
>>> +}
>>> +EXPORT_SYMBOL_GPL(yoga_c630_ec_read8);
>>> +
>>> +int yoga_c630_ec_read16(struct yoga_c630_ec *ec, u8 addr)
>>> +{
>>> +	u8 req[2] = { LENOVO_EC_READ_REG, };
>>> +	int ret;
>>> +	u8 msb;
>>> +	u8 lsb;
>>> +
>>> +	mutex_lock(&ec->lock);
>>> +
>>> +	req[1] = addr;
>>> +	ret = yoga_c630_ec_request(ec, req, sizeof(req), &lsb, 1);
>>> +	if (ret < 0)
>>> +		goto out;
>>> +
>>> +	req[1] = addr + 1;
>>> +	ret = yoga_c630_ec_request(ec, req, sizeof(req), &msb, 1);
>>> +
>>> +out:
>>> +	mutex_unlock(&ec->lock);
>>> +
>>> +	return ret < 0 ? ret : msb << 8 | lsb;
>>> +}
>>> +EXPORT_SYMBOL_GPL(yoga_c630_ec_read16);
>>> +
>>> +u16 yoga_c630_ec_ucsi_get_version(struct yoga_c630_ec *ec)
>>> +{
>>> +	u8 req[3] = { 0xb3, 0xf2, 0x20};
>>
>> You have a define above for the read_reg and write_reg commands, could you
>> not define 0xb3 as LENOVO_EC_GET_VERSION ?
>>
>> All of the other commands here seem to have a named define.
> 
> Because unlike other registers it is not clear what other use cases does
> 0xb3 support
> 
>>
>>> +	int ret;
>>> +	u8 msb;
>>> +	u8 lsb;
>>> +
>>> +	mutex_lock(&ec->lock);
>>> +	ret = yoga_c630_ec_request(ec, req, sizeof(req), &lsb, 1);
>>> +	if (ret < 0)
>>> +		goto out;
>>> +
>>> +	req[2]++;
>>
>> why not set reg[2] = 0x21;
> 
> ack
> 
>>
>> also is req[2] some kind of address ?
> 
> Unfortunately no idea. This is totally based on the AML code in DSDT. I
> have no documentation on the EC or its programming interface.
> 
>>
>>> +	ret = yoga_c630_ec_request(ec, req, sizeof(req), &msb, 1);
>>> +
>>> +out:
>>> +	mutex_unlock(&ec->lock);
>>> +
>>> +	return ret < 0 ? ret : msb << 8 | lsb;
>>> +}
>>> +EXPORT_SYMBOL_GPL(yoga_c630_ec_ucsi_get_version);
>>> +
>>> +int yoga_c630_ec_ucsi_write(struct yoga_c630_ec *ec,
>>> +			    const u8 req[YOGA_C630_UCSI_WRITE_SIZE])
>>> +{
>>> +	int ret;
>>> +
>>> +	mutex_lock(&ec->lock);
>>> +	ret = i2c_smbus_write_i2c_block_data(ec->client, LENOVO_EC_UCSI_WRITE,
>>> +					     YOGA_C630_UCSI_WRITE_SIZE, req);
>>> +	mutex_unlock(&ec->lock);
>>> +
>>> +	return ret < 0 ? ret : 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(yoga_c630_ec_ucsi_write);
>>> +
>>> +int yoga_c630_ec_ucsi_read(struct yoga_c630_ec *ec,
>>> +			   u8 resp[YOGA_C630_UCSI_READ_SIZE])
>>> +{
>>> +	int ret;
>>> +
>>> +	mutex_lock(&ec->lock);
>>> +	ret = i2c_smbus_read_i2c_block_data(ec->client, LENOVO_EC_UCSI_READ,
>>> +					    YOGA_C630_UCSI_READ_SIZE, resp);
>>> +	mutex_unlock(&ec->lock);
>>> +
>>> +	return ret < 0 ? ret : 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(yoga_c630_ec_ucsi_read);
>>> +
>>> +static irqreturn_t yoga_c630_ec_intr(int irq, void *data)
>>> +{
>>> +	u8 req[] = { LENOVO_EC_REQUEST_NEXT_EVENT };
>>> +	struct yoga_c630_ec *ec = data;
>>> +	u8 event;
>>> +	int ret;
>>> +
>>> +	mutex_lock(&ec->lock);
>>> +	ret = yoga_c630_ec_request(ec, req, sizeof(req), &event, 1);
>>> +	mutex_unlock(&ec->lock);
>>> +	if (ret < 0)
>>> +		return IRQ_HANDLED;
>>> +
>>> +	pr_info("NOTIFY %x\n", event);
>>
>> why not dev_info() ?
> 
> Argh, debugging code. I should drop it.
> 

Assuming you do all of that in v5

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

