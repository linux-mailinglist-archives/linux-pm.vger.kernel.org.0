Return-Path: <linux-pm+bounces-30951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A9DB07F62
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 23:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8BA582A51
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 21:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8701E1D79BE;
	Wed, 16 Jul 2025 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYi3mjlh"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD1E19E83C
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700529; cv=none; b=SmsWWL6g0TgFtu9Y2RDAEkCCgrTPMZSCB8vw03iXflTvtrxBgNRaE5h5FWWaY51X1lVXggsuW3X7RRc00V0yw8qYhKxgTf7tWeuO02nkr/V+vEiF+zMkaOuR1mWH0vfp2+dKazbTiJrdpFZTn39s/yHEM0W2z5ODdrvb3ZjK2Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700529; c=relaxed/simple;
	bh=FukWgzNsJKare6BXZbNXusV9s6vX5Y2YzA0r+72g6Fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjGOrc9OKAoMp2x3ZG67ikvDXgu/cqJMhcQix40yq123Zdm0xhjzznexw05yQiqm87oByce6aEVh0yjwWETtKuiaO+DVNMDimz7iJvugcojHVNMuHxqW3xwlK0tKbggkSIwEzdzwlKScVE9g/WThrqjFim0Z1qJjq1Tzv4OE0dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYi3mjlh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752700526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jah8q+9VF9jPv6RX7CYskal9Vq9xQi30YSBCNspuCSg=;
	b=TYi3mjlhAjdfJeXLRRZNZ42bjdv6qCfdTkJwMJwK8TM9fF+qQp6sSVhizeRCl2Lyyfb2yI
	zy9t/ryjz7V6eAs/Szr6vHAa2LeuwwddodQNgM5eeKvKn5oQUkWnKz60wHl6uKt21vxnNf
	IfA/E6H8yJVOwQkk7PDFJC4s6MaSdsM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-P3mWhvK6OXCZxJYOsATvKw-1; Wed, 16 Jul 2025 17:15:24 -0400
X-MC-Unique: P3mWhvK6OXCZxJYOsATvKw-1
X-Mimecast-MFC-AGG-ID: P3mWhvK6OXCZxJYOsATvKw_1752700522
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ae0cd07eeb2so18263566b.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 14:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752700522; x=1753305322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jah8q+9VF9jPv6RX7CYskal9Vq9xQi30YSBCNspuCSg=;
        b=jFXXnO+hUlqOQTXUaXFKwymOOnUB53nJDUjqaw0WEMPJ7L/OlaYRggBpuwshppPyVY
         z/LH5i7khw3/ntCS3WIwBmj3+NHcoOGAKvT/7zBQdpclOZz/0BvOnvECJ145faXykEfJ
         w2fRXsStAPVxyT8ExY1YvGhXAVgJssCUFSvi3fkBqCxBoX1RaK9PnfjgyUPyc23WGLBq
         ZivxXWv8cejGzmRX99OHUqXwFvEg+kkG+/eJYXM36+jI3mTQkPQnHs7eVsFNbJZMr+z7
         FrlVCBh6vQFNdJ0RtY/WNGrqe/2FKYKU3Alv2xnA3g70w7d4X/038CPQbkIUGGbTyUvH
         M/gw==
X-Forwarded-Encrypted: i=1; AJvYcCViQVIzOeHIVai9rEhd4DrojVdE15a/+xEMcs9neRujvabnlALatt3MdZZ97xsCoWneqpg1ffE0EQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7twfvBrMTfxHkptiPD7eNHcC6aTO68clyK+65gy+75lLKEOpF
	lcAxvIhJ4h35EUBilirekjRf2upSoFopYSHt9r9OLFL84mUGfm95PLIwyOGc6X7/YKyWcoCQN+3
	8ObOdmJXw/yxRedpK5f8vC0V+fxVSYfZR2oG8pRJYChQNq6Td7eaxT+YgUKBYGZ5xscPBga0=
X-Gm-Gg: ASbGncv+DRCqIF/mHLED/ArRxD/cpV8F5UhZAbZngk+su1wRHROpHzmzoBc58EazXK6
	DvJaWD8/krXov/D/Qkt5xxW+Y9CKgz+dlHXaXdqIk8EmPXhCvVIEk6IgUUg0q05yv3jSBQe07kU
	ynBF8/IvPpL4/Ornu1rGB+6Yg0A2zQTABkuU1pObfAP8Z4OGmDUkoMifJxe+zKKry4YvPuySTyM
	wRmFr7emmnuJ6eJ6rbrXGtgP497tBCjppwdaiVdFEubXDbbGILV2WarZ4zK2Uh+l+do7jwpkGUf
	4XeQZS3I7yRFE4e3g9KC5YMUpoUaHZ4vRm7oliKC5ItNtHmQCU4huMFaWzG+ELf+hcbzd9F3aJu
	UjwbuK6ZaWgNx0hMjYhJXpcgSZr4c2l0S88AjS+KpLZs8PXxFTElAdemhjF9MUuFzmcdAhnwGB3
	DjAwjJdwhmma67MA==
X-Received: by 2002:a17:907:3eaa:b0:ad8:a41a:3cd2 with SMTP id a640c23a62f3a-ae9cddce21dmr452979466b.16.1752700521557;
        Wed, 16 Jul 2025 14:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtCyRAn7nT3+0uhM14bj2reHGYguqzCm6M5R2kyjo+YQ4KRhh8QNbmq0gfJHnbvApmLpqNzw==
X-Received: by 2002:a17:907:3eaa:b0:ad8:a41a:3cd2 with SMTP id a640c23a62f3a-ae9cddce21dmr452976266b.16.1752700521047;
        Wed, 16 Jul 2025 14:15:21 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee8d9fsm1227513066b.46.2025.07.16.14.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 14:15:20 -0700 (PDT)
Message-ID: <5f6af744-7f07-4d7a-a89a-3c543c92c1f9@redhat.com>
Date: Wed, 16 Jul 2025 23:15:19 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] power: supply: Add adc-battery-helper
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
References: <20250107113346.170612-1-hdegoede@redhat.com>
 <20250107113346.170612-2-hdegoede@redhat.com>
 <CACRpkdaStgNdQTivNb693wvzZ+3OXCeD7977JVcZqVhyv9FOgw@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CACRpkdaStgNdQTivNb693wvzZ+3OXCeD7977JVcZqVhyv9FOgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Thank you for your review / insights
and sorry for the quite slow reply.

I agree with almost everything you've said and
I'll implement the suggested changes for v3
of this patch-series.

On 9-Jan-25 7:50 PM, Linus Walleij wrote:
> Hi Hans,
> 
> thanks for your patch!
> 
> Overall I really like the looks of this.
> 
> Some high-level questions, and sorry for the verbiage I got
> a bit carried away when refreshing my memories of this type of
> work:
> 
> On Tue, Jan 7, 2025 at 12:34 PM Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> +static int adc_battery_helper_get_capacity(struct adc_battery_helper *help)
>> +{
>> +       /*
>> +        * OCV voltages in uV for 0-110% in 5% increments, the 100-110% is
>> +        * for LiPo HV (High-Voltage) bateries which can go up to 4.35V
>> +        * instead of the usual 4.2V.
>> +        */
> 
> This is a pretty bold claim, given how individual batteries are.
> 
> I challenge this and ask if this isn't really *one* *specific* battery
> and not as general as it looks here.

The story here is that as a hobby project I'm doing hw-enablement work
on some somewhat older x86_64 tablets. Some of which have these not
quite a fuel-gauge fuel-gauge chips which from using Linux's POV are
mostly just glorified ADCs.

I have no datasheets for either the fuel-gauge or the batteries used.

The below table is generic in the sense that I just took a generic
table from the internet and went with that.

For the next version these tables will be gone from the driver,
instead the driver now expects there to be at least a
"ocv-capacity-table-0" device-property with the table.

> 
>> +       static const int ocv_capacity_tbl[23] = {
>> +               3350000,
>> +               3610000,
>> +               3690000,
>> +               3710000,
>> +               3730000,
>> +               3750000,
>> +               3770000,
>> +               3786667,
>> +               3803333,
>> +               3820000,
>> +               3836667,
>> +               3853333,
>> +               3870000,
>> +               3907500,
>> +               3945000,
>> +               3982500,
>> +               4020000,
>> +               4075000,
>> +               4110000,
>> +               4150000,
>> +               4200000,
>> +               4250000,
>> +               4300000,
>> +       };
> 
> Compare this to the ocv-to-capacity tables for a few batteries that exist
> in drivers/power/supply/samsung-sdi-battery.c, i.e. any use of
> struct power_supply_battery_ocv_table such as:
> 
> static const struct power_supply_battery_ocv_table
> samsung_ocv_cap_eb485159lu[] = {
>         { .ocv = 4330000, .capacity = 100},
>         { .ocv = 4320000, .capacity = 99},
>         { .ocv = 4283000, .capacity = 95},
> (...)
>         { .ocv = 3456000, .capacity = 2},
>         { .ocv = 3381000, .capacity = 1},
>         { .ocv = 3300000, .capacity = 0},
> };
> 
> Apart from being upside-down, this is strikingly similar, just
> slightly different
> ocv vs capacity for each of the batteries in this file.
> 
> The struct power_supply_battery_ocv_table use linear interpolation
> helpers in the core, see power_supply_ocv2cap_simple() in
> power_supply_core.c.

Ack, for v3 I'm switching to using power_supply_batinfo_ocv2cap()
replacing the custom table + mapping.

> Further it has been found (in the datasheet for Samsung batteries) that
> the OCV table is varying with the temperature of the battery. For this
> reason a two-dimensional look-up exists, power_supply_find_ocv2cap_table()
> and the helper power_supply_batinfo_ocv2cap() that will look up
> a proper ocv2cap for a certain temperature and then interpolate
> in that table. In this case the capacity estimate is three-dimensional.
> I bet this is actually true for your battery as well, if you have a datasheet.

Right, so without a datasheet (and also note that these batteries
are old and have already seen quite a few cycles) we don't really
have per temperature ocv to capacity mappings table. Also there
is no temperature measurement of the actually battery cells
themselves here. So the new version just calls
power_supply_batinfo_ocv2cap() with a hardcoded temperature of
25° Celsius.

Which is fine since there will only be one ocv->capicity table
anyways since we lack a datasheet with this info.


>> +       for (i = 1; i < ARRAY_SIZE(ocv_capacity_tbl); i++) {
>> +               if (help->ocv_avg_uv > ocv_capacity_tbl[i])
>> +                       continue;
>> +
>> +               ocv_diff = ocv_capacity_tbl[i] - help->ocv_avg_uv;
>> +               ocv_step = ocv_capacity_tbl[i] - ocv_capacity_tbl[i - 1];
>> +               /* scale 0-110% down to 0-100% for LiPo HV */
>> +               if (help->psy->battery_info->constant_charge_voltage_max_uv >= 4300000)
>> +                       return (i * 500 - ocv_diff * 500 / ocv_step) / 110;
>> +               else
>> +                       return i * 5 - ocv_diff * 5 / ocv_step;
>> +       }
> 
> This looks to *me* like someone taking a highly nonlinear problem and
> trying to linearize it. LiPo batteries are not this linear.
> 
> I would rather expect a good old ocv-to-capacity table based on a
> discharge diagram from a datasheet.
> 
> In any case, the above can certainly be converted into one, but I have
> my doubts about the quality of that.
> 
> In any case I suggest passing in a struct power_supply_battery_ocv_table *
> to this function instead and use the core interpolation.

Ack, as mentioned already the upcoming v3 has switched to
power_supply_batinfo_ocv2cap() and all this code is gone now.

> 
>> +static void adc_battery_helper_work(struct work_struct *work)
>> +{
>> +       struct adc_battery_helper *help = container_of(work, struct adc_battery_helper,
>> +                                                      work.work);
>> +       int i, curr_diff_ua, volt_diff_uv, res, ret, win_size;
> 
> Pls tag res with unit such as rs_mohm or (as suggested below)
> res_uohm.

Ack, done for v3.

> 
>> +       struct device *dev = help->psy->dev.parent;
>> +       int volt_uv, prev_volt_uv = help->volt_uv;
>> +       int curr_ua, prev_curr_ua = help->curr_ua;
>> +       bool prev_supplied = help->supplied;
>> +       int prev_status = help->status;
>> +
>> +       guard(mutex)(&help->lock);
> 
> Guarded mutexes are nice!
> 
>> +       help->volt_uv = volt_uv;
>> +       help->curr_ua = curr_ua;
>> +
>> +       help->ocv_uv[help->ocv_avg_index] =
>> +               help->volt_uv - help->curr_ua * help->intern_res_avg_mohm / 1000;
>> +       dev_dbg(dev, "volt-now: %d, curr-now: %d, volt-ocv: %d\n",
>> +               help->volt_uv, help->curr_ua, help->ocv_uv[help->ocv_avg_index]);
>> +       help->ocv_avg_index = (help->ocv_avg_index + 1) % MOV_AVG_WINDOW;
>> +       help->poll_count++;
>> +
>> +       help->ocv_avg_uv = 0;
>> +       win_size = min(help->poll_count, MOV_AVG_WINDOW);
>> +       for (i = 0; i < win_size; i++)
>> +               help->ocv_avg_uv += help->ocv_uv[i];
>> +       help->ocv_avg_uv /= win_size;
> 
> This part of the algorithm needs comments to explain what is going on with
> the moving average window here. It looks clever!
> 
> What I know for sure is that a battery's internal resistance also varies
> with temperature so this isn't very good for all conditions, and this is
> why we have the helper function power_supply_temp2resist_simple()
> in the core to supply look-up interpolation tables also for this. But I
> guess maybe you don't have either a temperature sensor or the
> data for the temperature variation curves?


I have neither a temperature sensor for the cells; nor
temperature variation curves.

> I'm pretty sure you must have a temperature sensor because it is
> dangerous to make chargers without them, but whether you can
> read it is another question, and whether you have a temp->ri table
> is a third question so I understand there might be lacking
> information here.

As far as I can deduce from the Android kernel code there only
is support for measuring the PMIC ICs own temperature.

Anyways without temperature variation curves this does not matter.


> 
>> +       help->supplied = power_supply_am_i_supplied(help->psy);
>> +       help->status = adc_battery_helper_get_status(help);
>> +       help->capacity = adc_battery_helper_get_capacity(help);
>> +
>> +       /*
>> +        * Skip internal resistance calc on charger [un]plug and
>> +        * when the battery is almost empty (voltage low).
>> +        */
>> +       if (help->supplied != prev_supplied ||
>> +           help->volt_uv < LOW_BAT_UV ||
>> +           help->poll_count < 2)
>> +               goto out;
>> +
>> +       /*
>> +        * Assuming that the OCV voltage does not change significantly
>> +        * between 2 polls, then we can calculate the internal resistance
>> +        * on a significant current change by attributing all voltage
>> +        * change between the 2 readings to the internal resistance.
>> +        */
> 
> Interesting algorithm. It will however include any resistance in
> series with the battery such as resistance in wires (negligible)
> and pads, connectors and silicon circuitry (not negligible).
> 
> The algorithms I have seen carefully specify the internal
> resistance vs temperature in a table and specify the
> resistance in series with the battery separately. (OK the
> latter is maybe a bit overzealous.)

Right, that is the nice way of doing things when doing
a new design and with datasheets in hand.

This code is for reverse-engineered battery support on somewhat
older tablets. Even if we had temperature variation curves,
I'm pretty sure that the battery cells are old enough those
will likely not be super accurate anymore.

> 
>> +       curr_diff_ua = abs(help->curr_ua - prev_curr_ua);
>> +       if (curr_diff_ua < CURR_HYST_UA)
>> +               goto out;
>> +
>> +       volt_diff_uv = abs(help->volt_uv - prev_volt_uv);
>> +       res = volt_diff_uv * 1000 / curr_diff_ua;
>> +
>> +       if ((res < (help->intern_res_avg_mohm * 2 / 3)) ||
>> +           (res > (help->intern_res_avg_mohm * 4 / 3))) {
> 
> I have found that micro-ohms are usually needed to get the
> right precision so please consider this, mohm may be good
> enough for this AD. But there is a famous paper about capacity
> estimation pointing out that precise measurements of Ri
> is critical for capacity estimation, and for that micro-ohms
> should be encouraged IMO.

Since the internal-resistance is calculated as discussed
below using uOhms would just give a false pretense of
precision IMHO.

> This is why factory internal resistance uses micro-ohms.
> 
>> +               dev_dbg(dev, "Ignoring outlier internal resistance %d mOhm\n", res);
>> +               goto out;
>> +       }
> 
> Ugh that looks hacky and random for a certain AD-converter
> which is pretty unstable if things like this happens... oh well.
> Don't know what to say about that. Maybe this is good?

This does not trigger often. I expect this happens when
the current makes a big jump during the sample window
for measuring voltage and current.

> 
> Maybe there should be absurdity guards as well, such as
> internal resistance being
> 
>> +       dev_dbg(dev, "Internal resistance %d mOhm\n", res);
> 
> Maybe we actually need a sysfs file for that?
> 
>> +       help->intern_res_mohm[help->intern_res_avg_index] = res;
>> +       help->intern_res_avg_index = (help->intern_res_avg_index + 1) % MOV_AVG_WINDOW;
>> +       help->intern_res_poll_count++;
>> +
>> +       help->intern_res_avg_mohm = 0;
>> +       win_size = min(help->intern_res_poll_count, MOV_AVG_WINDOW);
>> +       for (i = 0; i < win_size; i++)
>> +               help->intern_res_avg_mohm += help->intern_res_mohm[i];
>> +       help->intern_res_avg_mohm /= win_size;
> 
> If we want to do moving averages in general maybe we should
> have a helper in power_supply_core.c for this?
> Just a suggestion.
> 
>> +       if (!help->psy->battery_info ||
>> +           help->psy->battery_info->factory_internal_resistance_uohm == -EINVAL ||
>> +           help->psy->battery_info->constant_charge_voltage_max_uv == -EINVAL) {
>> +               dev_err(dev, "error required properties are missing\n");
>> +               return -ENODEV;
>> +       }
> 
> As mentioned, I think you should pass in and use at least:
> 
> .ocv_temp[0] = 25, // What we use when we know nothing else...
> .ocv_table[0] = foo_ocv_cap_table,
> .ocv_table_size[0] = ARRAY_SIZE(foo_ocv_cap_table),

Ack, this is all done for the upcoming v3.

> If for nothing else so for the fact that someone will want to use this
> with a (proper) nonlinear table and you can test it easily by constructing
> one for your battery.
> 
>> +       /* Use provided internal resistance as start point (in milli-ohm) */
>> +       help->intern_res_avg_mohm =
>> +               help->psy->battery_info->factory_internal_resistance_uohm / 1000;
> 
> .resist_table
> .resist_table_size
> 
> would be better I think, but if you have no datasheet and no idea
> how much resistance is connected in series with the battery...
> well. Fair enough I guess.

Right the issue is there is no datasheet, so no idea.

Regards,

Hans


