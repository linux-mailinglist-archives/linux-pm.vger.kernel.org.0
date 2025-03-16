Return-Path: <linux-pm+bounces-24120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0250A635E7
	for <lists+linux-pm@lfdr.de>; Sun, 16 Mar 2025 14:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F0E16FC3D
	for <lists+linux-pm@lfdr.de>; Sun, 16 Mar 2025 13:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7693C1A9B23;
	Sun, 16 Mar 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GH3cmSCK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C3A1A2C04;
	Sun, 16 Mar 2025 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742133365; cv=none; b=mt9t3YwF4owa0ccVh48vr9WufO5K8cNG+DzMFSrFEA7FOro6upFeazuyKaxFTK4KOKezxd6URhCjHqNV9ipDCgb6voxNWH2eDNPIim3f7HeWBW8vwIu1ujF5zPgEZieaIzATT3e1lKI8lHFHuVsFkNOqqGacyHPTphub+Iv6QOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742133365; c=relaxed/simple;
	bh=zjXq3eil1LfCz35iq2Hg/iyKxdRR68ntQrUfxggay/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dH1h22ATut7nXcT6VNU6kZvmEeizqoxiQ5x+tp4LxOc0X/Zkz7i2qNBdqUp5HK8rmSPsUtPAarAgQT9o6gXrApmjBOisjbL/PUAmTmK+ySWu3BUhw/b7d8qKfW4GcmV9RZJg8eIzhMzndg6Vsy8yJmtBtJnck5qbCjs6JiHgyHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GH3cmSCK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22548a28d0cso97666075ad.3;
        Sun, 16 Mar 2025 06:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742133362; x=1742738162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=noLd4AZN+eg28JLL4nGD028dNkKTdO8iweQZwVM6Ku4=;
        b=GH3cmSCKz95CR89Y9884WQlDqdJR4rAHRagyk4yptN58gl4HGrOPufzHO0YQjcKrNH
         j9TppBFxkjYiYEVj34DGG8t/xg2eZj3rNIeJ+lCxjHZsdYBiF+0tVkrnXgLjep4/euW/
         /zZC+EHm+isNwldkGrpPNIfKuuvv1A2x0TU9Y2MZ9r0JVfDFOaJ/tvPQawroYy1qt2DY
         +IIalCKvc2pHO8ecsStSeFrqrKnftyTrGjNwRvoESRLUyX9aGQ+cjP29ngd7QqhPj9Qk
         LzPLBGUlZq7h+/oOtrUh1/3pRfBH56tVqHSPxcyVyNsGe6Q07HR1fCJLxyv3Xh4nTnn4
         3DMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742133362; x=1742738162;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noLd4AZN+eg28JLL4nGD028dNkKTdO8iweQZwVM6Ku4=;
        b=vKR+GWoKAvTwLExUbiyFC087PZpuk2Rmkfk90WAilfhXbpide08PFrtAWaosh/KCt3
         XPmkCOGMXI8+VIXTrBEGAK6VjycT0tDO5utqx6yeKvcRU/h9FUf/Jpsxd0PviVqiH7Nd
         W36e+hG+2yNWZ4oedM8xo++ZEzhdBHC3BdnKOVKDCE9fToxjEp3gUx/s0YeyZ8SN3WTU
         sKJp8/quH6OfcS8WRFAH4G31v02QkUDaYw8JfvV+ZWcylH+mXOsXUK6f3L8YXVQQzVaA
         0U8b+tMKXsZh0DfTXF+Za1/PDv6V8klZA/viq6F+gocSbqBdcJtLJ3dNviRulImoU22N
         sx7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkQ/x8lXnO7KHWYs5oGY1TtCuwOwPhSIpWSaCHYru51AKcAgO3TgPysHcMIRmQ08JV/flL72qzrsY=@vger.kernel.org, AJvYcCW3Ifwxn8GsfsaNhMA9RKAiVcjYmzgemoBDmRH1tjHQvMZmsKRaO+oiw75Q3MYuTe4XApnOKjPYrsk=@vger.kernel.org, AJvYcCWiC7Jj961J1vRvjflv67v5JMV7HJlGWwF7cxhZOHsi+DoO8rlwC70DAwHYAnHGoS8ltI+f6dGDXJc8CqTbOXTuR6oA8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWWz2CcPycYVX3zsnDuD2/1/l7pCv02sXgOBZwrCq9p2vo8GkE
	2O0WjXN44jRbOu2VYOqoaFuRyYbxq15YltDIRjH2+9Gr5aT9IND4
X-Gm-Gg: ASbGnctS0RDflZPS+v6J1FJ61GmRyL3R0bqcCki2PPwfdPZGdfLD1pK1A/OwDKZ0zlz
	oD16RLMoUu4k+yN+vKX/mVEZN6qyG1AeKE+C8rTzfoEuFh/RXpU5z66+8G/OT8DWBL5F8TqxH/N
	eYmgtr00zZvu9ES3UyaBLnvjJpxvVCpu5waVLSPeUjINB7itmj7lTqZf9HD3VpxWBlIcqpi//7h
	H/WXEfKxdHte5nKc2XqXgHNqErE7hK4otmnT2xYYnsZOb/4OqexXse8rltrNhUnMoCVXXxLs5zr
	3Ai5MkMECYDXdOqXp+nSNK6AijCq2HsBJQBg2+f5mQWkC7XINLDyxkb0sLMvBjKhq6WmYPQt8wi
	RLOoHhp77afS3pVyvDQ==
X-Google-Smtp-Source: AGHT+IHzInz35CfL8RMUuk6uPHCDPxZjxMH+en9UtqT4fqqsCLlSt7M1MCiWMNj6OZVzG33hzKHRCw==
X-Received: by 2002:a05:6a20:8424:b0:1f5:8d3b:e2a6 with SMTP id adf61e73a8af0-1f5c12c854fmr13465370637.27.1742133362539;
        Sun, 16 Mar 2025 06:56:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167e11asm5982710b3a.101.2025.03.16.06.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Mar 2025 06:56:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0aec1406-00cd-44ee-959f-48b646d3dad3@roeck-us.net>
Date: Sun, 16 Mar 2025 06:56:00 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/13] power: supply: add inhibit-charge-s0 to
 charge_behaviour
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
 Eileen <eileen@one-netbook.com>
References: <20250311165406.331046-1-lkml@antheas.dev>
 <20250311165406.331046-6-lkml@antheas.dev>
 <CAGwozwELmp7v_46wmo_bbORWMEeA-NWRjXeRML4Jd=p=huLNaw@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAGwozwELmp7v_46wmo_bbORWMEeA-NWRjXeRML4Jd=p=huLNaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/16/25 04:40, Antheas Kapenekakis wrote:
> On Tue, 11 Mar 2025 at 17:54, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>>
>> OneXPlayer devices have a charge bypass feature
>> that allows the user to select between it being
>> active always or only when the device is on.
>>
>> Therefore, add attribute inhibit-charge-s0 to
>> charge_behaviour to allow the user to select
>> that bypass should only be on when the device is
>> in the s0 state.
>>
>> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>> ---
>>   Documentation/ABI/testing/sysfs-class-power | 11 ++++++-----
>>   drivers/power/supply/power_supply_sysfs.c   |  1 +
>>   drivers/power/supply/test_power.c           |  1 +
>>   include/linux/power_supply.h                |  1 +
>>   4 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
>> index 2a5c1a09a28f..4a187ca11f92 100644
>> --- a/Documentation/ABI/testing/sysfs-class-power
>> +++ b/Documentation/ABI/testing/sysfs-class-power
>> @@ -508,11 +508,12 @@ Description:
>>                  Access: Read, Write
>>
>>                  Valid values:
>> -                       ================ ====================================
>> -                       auto:            Charge normally, respect thresholds
>> -                       inhibit-charge:  Do not charge while AC is attached
>> -                       force-discharge: Force discharge while AC is attached
>> -                       ================ ====================================
>> +                       ================== =====================================
>> +                       auto:              Charge normally, respect thresholds
>> +                       inhibit-charge:    Do not charge while AC is attached
>> +                       inhibit-charge-s0: same as inhibit-charge but only in S0
>> +                       force-discharge:   Force discharge while AC is attached
>> +                       ================== =====================================
>>
>>   What:          /sys/class/power_supply/<supply_name>/technology
>>   Date:          May 2007
>> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
>> index edb058c19c9c..1a98fc26ce96 100644
>> --- a/drivers/power/supply/power_supply_sysfs.c
>> +++ b/drivers/power/supply/power_supply_sysfs.c
>> @@ -140,6 +140,7 @@ static const char * const POWER_SUPPLY_SCOPE_TEXT[] = {
>>   static const char * const POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[] = {
>>          [POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO]            = "auto",
>>          [POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE]  = "inhibit-charge",
>> +       [POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0]       = "inhibit-charge-s0",
>>          [POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE] = "force-discharge",
>>   };
>>
>> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
>> index 2a975a110f48..4bc5ab84a9d6 100644
>> --- a/drivers/power/supply/test_power.c
>> +++ b/drivers/power/supply/test_power.c
>> @@ -214,6 +214,7 @@ static const struct power_supply_desc test_power_desc[] = {
>>                  .property_is_writeable = test_power_battery_property_is_writeable,
>>                  .charge_behaviours = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)
>>                                     | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)
>> +                                  | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0)
>>                                     | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE),
>>          },
>>          [TEST_USB] = {
>> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
>> index 6ed53b292162..b1ca5e148759 100644
>> --- a/include/linux/power_supply.h
>> +++ b/include/linux/power_supply.h
>> @@ -212,6 +212,7 @@ enum power_supply_usb_type {
>>   enum power_supply_charge_behaviour {
>>          POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO = 0,
>>          POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE,
>> +       POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0,
>>          POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE,
>>   };
>>
>> --
>> 2.48.1
>>
> 
> Hi Guenter,
> I think I need an ack here, and then someone from platform-x86 to
> triage the series.
> 
> Do I need to cc anyone extra?
> 

You need to cc the maintainers of affected subsystems. Copying the mailing
list is insufficient.

Guenter


