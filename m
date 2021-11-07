Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0065644762C
	for <lists+linux-pm@lfdr.de>; Sun,  7 Nov 2021 23:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbhKGWI0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Nov 2021 17:08:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235654AbhKGWI0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Nov 2021 17:08:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636322742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/jAjhm6dpRyXZ0S52YEwMWBmjizDZSpCg5CbRaLOjg=;
        b=S4yN5EgumcOsiqVWUWfVSmDx99Kn+DyrVXkx9AKL6u6nCmTKKeK79SLKujFDe89Q8M81Md
        VX9k2n9FanimLcBBaJvINC/wx44E8ukJa0hjAWk2XYqfObyzBEHwWVpC6mI6EqstFC9p2+
        b6L/pd3Oa68f1syw+1NW2k2jgKqeFGg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-0PrIkISyM6G_L4UvQp6v1w-1; Sun, 07 Nov 2021 17:05:41 -0500
X-MC-Unique: 0PrIkISyM6G_L4UvQp6v1w-1
Received: by mail-ed1-f71.google.com with SMTP id m8-20020a056402510800b003e29de5badbso13176940edd.18
        for <linux-pm@vger.kernel.org>; Sun, 07 Nov 2021 14:05:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T/jAjhm6dpRyXZ0S52YEwMWBmjizDZSpCg5CbRaLOjg=;
        b=IR+QKof2zCM6ROZW9B1LyjyfbTnAWUzsETo21XVidg/UabfV3smhtlzNk0pKihtCfQ
         EHzKRCPbpDD8YNO6pG3BVeORhQuAZnXORxgghGJqX3dIDk8zaLE/TbVxR0jOXQwJ5SC4
         oZfTv0nYWpMDfivObbR0+D+DsHmVRt+50nxXjgrjZLCIV9mwBAb46mf4rLKi67EngOOC
         9j1LCEody4xWESeaO+O5iSHNuUmWYMZ1EIYz63Xn3gTcYDDybjJF67XKz5PbKJk5nFi0
         Gjry3wY/JUlpBnzLPZob8xC7/Rgb+RaktbNLdurLEQYC+9tzdQamckxo5AaXlVySv3vN
         IXtQ==
X-Gm-Message-State: AOAM531VjFb+B6uG1xN/w/Y6ocIEbUeB2dMTESSSxpfFPZsxvNb0quBj
        FVcOKhvIfGRbLgz+wp51HO62ObT3xo72w22f18ziyQmWc+MaJvPzOJARMiAGFUWcAKPwOZ66/Nb
        8M3XFFA7mRmntNJ2nzsQ=
X-Received: by 2002:a50:9993:: with SMTP id m19mr65716661edb.259.1636322739875;
        Sun, 07 Nov 2021 14:05:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2aPyUSnX+KxJaMNCVPgIJgNMz9VEfH4oLRkBU2vuvwlOFH1DrV32fpZ4sYms7ymbTwdGzOg==
X-Received: by 2002:a50:9993:: with SMTP id m19mr65716624edb.259.1636322739637;
        Sun, 07 Nov 2021 14:05:39 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id w1sm8913001edd.49.2021.11.07.14.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 14:05:39 -0800 (PST)
Message-ID: <1905fbeb-66d5-d74b-92e7-eb3b181c55ec@redhat.com>
Date:   Sun, 7 Nov 2021 23:05:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/4] bq25890: Add max input current limit property
Content-Language: en-US
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211107202001.54579-1-jekhor@gmail.com>
 <20211107202001.54579-2-jekhor@gmail.com>
 <85a4674a-9212-6f02-d351-72b2223cc4a9@redhat.com>
 <YYhAUH2nvj1b0uCW@jeknote.loshitsa1.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YYhAUH2nvj1b0uCW@jeknote.loshitsa1.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 11/7/21 22:08, Yauhen Kharuzhy wrote:
> On Sun, Nov 07, 2021 at 09:41:55PM +0100, Hans de Goede wrote:
>> Hi Yauhen,
>>
>> On 11/7/21 21:19, Yauhen Kharuzhy wrote:
>>> Add property 'ti,input-max-current' to define input current limit if
>>> needed. It will be applied if automatic charger type detection is
>>> disabled and using of ILIM pin is disabled or such pin defines greater
>>> limit than IINLIM field.
>>
>> Sorry, but this makes no sense, as the datasheet says the charger
>> itself updates iinlim dynamically when it has done charger-type
>> detection (for the bq25890 version) and for the bq25892 version
>> which does not have the D+ + D- USB pins for BC1.2 detection,
>> the iinlim should be updated based on the charger detection
>> done elsewhere (by the Whiskey Cove PMIC in case of the Yoga Book).
> 
> For Yoga Book, charger detection in the bq25892 is disabled and done in
> the extcon driver.
> 
>> My plan for this is to have drivers/extcon/extcon-intel-cht-wc.c
>> also register a power_supply device which models the detected
>> charger / negotiated external charger/power-brick settings and
>> which is the supplier of the bq25892 charger.
>>
>> Then an external_power_changed handler can be added to the
>> bq25892_charger code using the
>> power_supply_set_input_current_limit_from_supplier()
>> helper to dynamically set iinlim based on the detected
>> "power-brick"/external-charger.
>>
>> This is also how this is done for (X86) devices with an
>> full-featured USB Type-C port where this needs to be handled
>> by the kernel (rather then it being done in firmware) in
>> this case the current-max property of the Type-C power-supply
>> class device gets set either based on the Type-C pull-up
>> resistor in the charger (setting 0.5A / 1.5A / 3A), with
>> a fallback to BC1.2 for the 0.5A case, or based on the
>> USB-PD negotiated max-current.
> 
> Agree, looks reasonable.
> 
>>
>> Since we will need this mechanism to dynamically set
>> iinlim based on the PMIC-s charger-detection it seems
>> to me that setting it at boot is both unnecessary and a bad
>> idea, since we don't know the correct value to set at boot.
>>
>> The extcon code will start a charger-detection cycle
>> as soon as it loads (if there is Vbus present) and then
>> trigger the external_power_changed handler .
>>
>> TL;DR: I don't really see a need for this ?
> 
> Hmm... I think you are rigth. The only case when such property can be
> needed – if the device may be damaged by maximum current supported by
> charging source. I use it to limit current by 2A when original Lenovo adapter
> is connected because the linux kernel has default max current limit
> 5A for DCP (drivers/usb/phy/phy.c) but adapter supports only 2A.

Yeah 5A is bad, I find it a bit weird that drivers/usb/phy/phy.c
uses that, but my plan for X86 devices with this charger is
to not use the drivers/usb/phy/phy.c code, that is not really
a good fit for X86 devices.

For the axp288 code (found on many other X86 Cherry Trail
devices) we use 2A when detecting a DCP.

And the same for the full-featured Type-C case with a
C to A cable identified with a Pull Up resistor indicating
max 0.5, combined with BC1.2 DCP detection, then we too
set the input-current-limit to 2A.

Also I believe that the ILIM pin limits things to 2A
on the yogabook, I've seen the firmware set IINLIM to
3.25A and even with a 3A capable charger it only
draws 2A.

Regards,

Hans



>>>  drivers/power/supply/bq25890_charger.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
>>> index 34467bfb9537..1c43555d5bd8 100644
>>> --- a/drivers/power/supply/bq25890_charger.c
>>> +++ b/drivers/power/supply/bq25890_charger.c
>>> @@ -85,6 +85,7 @@ struct bq25890_init_data {
>>>  	u8 treg;	/* thermal regulation threshold */
>>>  	u8 rbatcomp;	/* IBAT sense resistor value    */
>>>  	u8 vclamp;	/* IBAT compensation voltage limit */
>>> +	u8 iinlim_max;	/* maximum input current limit allowed */
>>>  };
>>>  
>>>  struct bq25890_state {
>>> @@ -657,6 +658,7 @@ static int bq25890_hw_init(struct bq25890_device *bq)
>>>  		{F_TREG,	 bq->init_data.treg},
>>>  		{F_BATCMP,	 bq->init_data.rbatcomp},
>>>  		{F_VCLAMP,	 bq->init_data.vclamp},
>>> +		{F_IINLIM,	 bq->init_data.iinlim_max},
>>>  	};
>>>  
>>>  	ret = bq25890_chip_reset(bq);
>>> @@ -870,11 +872,13 @@ static int bq25890_fw_read_u32_props(struct bq25890_device *bq)
>>>  		{"ti,thermal-regulation-threshold", true, TBL_TREG, &init->treg},
>>>  		{"ti,ibatcomp-micro-ohms", true, TBL_RBATCOMP, &init->rbatcomp},
>>>  		{"ti,ibatcomp-clamp-microvolt", true, TBL_VBATCOMP, &init->vclamp},
>>> +		{"ti,input-max-current", true, TBL_IINLIM, &init->iinlim_max},
>>>  	};
>>>  
>>>  	/* initialize data for optional properties */
>>>  	init->treg = 3; /* 120 degrees Celsius */
>>>  	init->rbatcomp = init->vclamp = 0; /* IBAT compensation disabled */
>>> +	init->iinlim_max = 0x3f;
>>>  
>>>  	for (i = 0; i < ARRAY_SIZE(props); i++) {
>>>  		ret = device_property_read_u32(bq->dev, props[i].name,
>>>
>>
> 

