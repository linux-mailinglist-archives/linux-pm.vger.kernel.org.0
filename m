Return-Path: <linux-pm+bounces-17517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04F09C7B5A
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 19:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E0A2817E0
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 18:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B1B20125C;
	Wed, 13 Nov 2024 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="beBquw/T"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7076E13B298
	for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523158; cv=none; b=aJwYXpnPkOVD7kbmRXVbt3BOpXhcoaofiU+LRuCqQ5KnUuvDUnUGuR5AmGuabY9k/9V9uf6G1m2oN5eR1Ra3DYPTCXcLW7TOwtZUgoAUAG8Yz61AlsZrU3vHEOk/Z5027AG2GdBe/HbOYjh1YqqSZRR/MfDkpDvcM8ab203JYAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523158; c=relaxed/simple;
	bh=jjuVdWU7zSVeYxbOflUlo5CQAJpwgAMude4YJp+CV+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNrmLKyYRXLhOus5Xn3g5RFQl/td2oBOGHFdStKZc5mFdSgOrVSP/rL9b2/UZc8jgRNF86aso91c7JC/cywz25lAtBKU1mZYyI+I6O3nuYbPW2GpvITwnZZz6cUhxsjvU86l+nbZzBipRp9oge1lilYc1IQ/sad27nIfUOopogY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=beBquw/T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731523154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mcbkjwECU8Y7+6lafe9yZ7pyaau+st73Hne50Zv2aPo=;
	b=beBquw/TyDUyaihWyBlE4QrbF+8hL+YCUtsnGXky+Xft3cB0BfyTClXeUf7aLo+YjjFCHN
	91dRWBN//0iHUvTMoFBf1Shg6nqwy9NjSEZVv9+OeHUsxQT+6k6YgXttvqUW6bMqKcvKat
	zZA2UrM69oHHfMZ9iEUmUFZzy5zYF6w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-VAuD4J9BPx2LcQEy3FROig-1; Wed, 13 Nov 2024 13:39:13 -0500
X-MC-Unique: VAuD4J9BPx2LcQEy3FROig-1
X-Mimecast-MFC-AGG-ID: VAuD4J9BPx2LcQEy3FROig
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9e0574854dso257138566b.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 10:39:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731523152; x=1732127952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcbkjwECU8Y7+6lafe9yZ7pyaau+st73Hne50Zv2aPo=;
        b=PwgHchJ8JOqPFf+8Cc9y60lYTlMpovM+vzE2xVNuEs1sTFJ9CgzN7YHjlPQnhw35H1
         RHl7TBC+WeNO64wHC03KOo/bP2894ruOEZleHzNEHOZsPo8iyRlYg8EeXAbRQpph3th6
         dmRCYuAL+UPjjzW9bm0tYBUqX86WdwZTl1B8ok3rEjV14wewocIwSc4j6OHCcZ7421/9
         hZ51xKN434A9nQyJcLlbq79k7uBj0II4glm9bW1tUAqZude0Idv4kiaWcv6l5Tjb3zz+
         A+TOM0OKnaqoVqnTKzRIqjHd/OU53XSgKvUJSoQKw7eIZgh5zsPfPxkI9aSrd1eXRSYW
         ciFg==
X-Forwarded-Encrypted: i=1; AJvYcCUqcyfLe7O9mKjDtyu18aF+16mYSuGmbnrDxmxijUsnEtzpcpSURohBrnwJdd3703LeSYDK8WUbww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4zUyrKAO7eNaCE7DRA0Qt1JXSSEXGogjTWj0/d1lRh6tq8LNC
	f6ypiZkKZJD093+rfim0emJunwlsZnI9mVpEkm16T/+2zfj15aaks7z8iV66jJPz05nQKSrkVOW
	ErEXNCZlFlfAOBkZ4K00Jn2u4Idi3+vgNzwX2Do9SsElRAl/VMA837Le4Qocg8ziI
X-Received: by 2002:a17:907:3e8e:b0:a99:f6ee:1ee3 with SMTP id a640c23a62f3a-aa1f8106245mr365405966b.43.1731523151662;
        Wed, 13 Nov 2024 10:39:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUVqwY6xWiWiUm7kVlrB9M1MSKlS/Lxxyf3kAHg+T0yi0Jz5WlRcSbeJOz0PbOdM7PimsReQ==
X-Received: by 2002:a17:907:3e8e:b0:a99:f6ee:1ee3 with SMTP id a640c23a62f3a-aa1f8106245mr365404466b.43.1731523151268;
        Wed, 13 Nov 2024 10:39:11 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a17684sm905969266b.34.2024.11.13.10.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 10:39:10 -0800 (PST)
Message-ID: <8d666b0a-a33e-4ee2-9f7f-fbb0a5ffc365@redhat.com>
Date: Wed, 13 Nov 2024 19:39:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] platform/x86: x86-android-tablets: Add Vexia EDU ATLA
 10 EC battery driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
References: <20241104203555.61104-1-hdegoede@redhat.com>
 <20241104203555.61104-2-hdegoede@redhat.com>
 <CAHp75Vdkwg4pUs=k-GNv9wxuecVpMromh_F49bbfhYL7sxjwDg@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75Vdkwg4pUs=k-GNv9wxuecVpMromh_F49bbfhYL7sxjwDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andy,

On 5-Nov-24 11:39 AM, Andy Shevchenko wrote:
> On Mon, Nov 4, 2024 at 10:36 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> The Vexia EDU ATLA 10 tablet has an embedded controller instead of
>> giving the os direct access to the charger + fuel-gauge ICs as is normal
>> on tablets designed for Android.
>>
>> There is ACPI Battery device in the DSDT using the EC which should work
>> expect that it expects the I2C controller to be enumerated as an ACPI
> 
> expect --> except
> 
>> device and the tablet's BIOS enumerates all LPSS devices as PCI devices
>> (and changing the LPSS BIOS settings from PCI -> ACPI does not work).
>>
>> Add a power_supply class driver for the Atla 10 EC to expert battery info
>> to userspace. This is made part of the x86-android-tablets directory and
>> Kconfig option because the i2c_client it binds to is instantiated by
>> the x86-android-tablets kmod.
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

Thank you for the reviews for both patches. I'll try to prepare a v2
series addressing the small remarks you had tomorrow.

Regards,

Hans




> 
> ...
> 
>>  obj-$(CONFIG_X86_ANDROID_TABLETS) += x86-android-tablets.o
>> +obj-$(CONFIG_X86_ANDROID_TABLETS) += vexia_atla10_ec.o
> 
> This splits the original (compound) object lines, please move it
> either before (and this seems even better with ordering by name in
> mind) or after this block.
>>
> 
> Actually this blank line gives the false impression that the
> originally two lines are not related. I would drop this blank line as
> well.
> 
>>  x86-android-tablets-y := core.o dmi.o shared-psy-info.o \
>>                          asus.o lenovo.o other.o
> 
> ...
> 
>> +#include <linux/bits.h>
>> +#include <linux/devm-helpers.h>
> 
> + err.h
> 
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/power_supply.h>
>> +#include <linux/types.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include <asm/byteorder.h>
> 
> ...
> 
>> +/* From broken ACPI battery device in DSDT */
>> +#define ATLA10_EC_VOLTAGE_MIN_DESIGN           3750000
> 
> _uV ?
> 
> ...
> 
>> +struct atla10_ec_battery_state {
>> +       u8 len;                         /* Struct length excluding the len field, always 12 */
>> +       u8 status;                      /* Using ACPI Battery spec status bits */
>> +       u8 capacity;                    /* Percent */
>> +       __le16 charge_now;              /* mAh */
>> +       __le16 voltage_now;             /* mV */
>> +       __le16 current_now;             /* mA */
>> +       __le16 charge_full;             /* mAh */
>> +       __le16 temp;                    /* centi degrees celcius */
> 
> Celsius / celsius
> 
>> +} __packed;
>> +
>> +struct atla10_ec_battery_info {
>> +       u8 len;                         /* Struct length excluding the len field, always 6 */
>> +       __le16 charge_full_design;      /* mAh */
>> +       __le16 voltage_now;             /* mV, should be design voltage, but is not ? */
>> +       __le16 charge_full_design2;     /* mAh */
>> +} __packed;
> 
> Instead I would add the respective units to the variable names:
> _mAh
> _mV
> ...etc.
> 
> (* yes, with the capital letters to follow the proper spelling)
> 
> ...
> 
>> +static int atla10_ec_cmd(struct atla10_ec_data *data, u8 cmd, u8 len, u8 *values)
>> +{
>> +       struct device *dev = &data->client->dev;
>> +       int ret;
>> +
>> +       ret = i2c_smbus_read_i2c_block_data(data->client, cmd, len, values);
>> +       if (ret != len) {
>> +               dev_err(dev, "I2C command 0x%02x error: %d\n", cmd, ret);
>> +               return -EIO;
>> +       }
> 
>> +       if (values[0] != (len - 1)) {
> 
> Hmm... AFAIU this is part of SMBus protocol. Why do we need to care
> about this? Or is this an additional header on top of that?
> 
>> +               dev_err(dev, "I2C command 0x%02x header length mismatch expected %u got %u\n",
>> +                       cmd, len - 1, values[0]);
>> +               return -EIO;
>> +       }
>> +
>> +       return 0;
>> +}
> 
> ...
> 
>> +               val->intval = min(charge_now, charge_full) * 1000;
> 
> MILLI (here and below)?
> 
>> +               break;
>> +       case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>> +               val->intval = le16_to_cpu(data->state.voltage_now) * 1000;
>> +               break;
>> +       case POWER_SUPPLY_PROP_CURRENT_NOW:
>> +               val->intval = le16_to_cpu(data->state.current_now) * 1000;
>> +               /*
>> +                * Documentation/ABI/testing/sysfs-class-power specifies
>> +                * negative current for discharing.
> 
> discharging
> 
>> +                */
> 
> --
> With Best Regards,
> Andy Shevchenko
> 


