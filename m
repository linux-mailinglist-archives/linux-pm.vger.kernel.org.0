Return-Path: <linux-pm+bounces-40774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DFAD1BDBB
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 01:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE5C7304EDA7
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 00:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC17227599;
	Wed, 14 Jan 2026 00:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hoGGEBWN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2201A1E1A17
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 00:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768351666; cv=none; b=A4SI8xMg9aXOwn9YQpI78d8gnGrxaGhSa/fa9COtDXGQ9kMUn9LwTGNU1sP4wMUepzKKg9cQqjG1SJ9IwLOI/2wYhb+vtQEq7uA8ZeR8A935tq8AM4Cx2KL24nsv6H8iu6ALMPRqiow9hBktgrkUY8UEzkL+k8Yt1oEN0YeIxDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768351666; c=relaxed/simple;
	bh=FiEQxWP0gBazySZVKdQMaxlFntTAJXhqfST8zZRauYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdpte4nDA6rqW4zsl4f8rVLE7ESoWjPfbgFxDx/9mDQLq1c5C6DwiYuvTOOorGbVTFtuszIJ/FYdZF3am1Og+WUAvkNCiXK3s4GlcbEnk/lJev8gnhs5H195YE6lqwhNNvXF4aLDiT55RNy/kwwt4DJaAzmUSqM/xEoI/4INTT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hoGGEBWN; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ae5af476e1so202375eec.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 16:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768351663; x=1768956463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KrG7y4Xlsrv3rqpWtCTovQ72S57auUFAQpNG8Gw5noI=;
        b=hoGGEBWNb3UCiGtiX7SL85zovHBykVEUvanIGuU+d6EsgY6RjElXGIHFhDnGUukBSw
         8rvzUvQtTY6QBHhWsAzT/n27TcfOFrmPZh02H2FbVdSFa+HG12io17DZhDdJzsrP0iyp
         6jb895lHqHNVtxRWCCx4jVzpaTBVVi1sJdySxNhl7vOo5unXiZ/2I4ZxyFxJ7bJ1wQcx
         Ay0dk/gyDQWGa1ip+qJoxjv9Ayjb2mTsI3JiC9E+S/jSkQWgZxXVS3UGlEewbx97uMPU
         RoGa32TGp7wlcl/raBi/uQmpQr+zt5yrT8DiDDIx55n9K70eCQxPD2uRLkrxc8gCro3Q
         9jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768351663; x=1768956463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrG7y4Xlsrv3rqpWtCTovQ72S57auUFAQpNG8Gw5noI=;
        b=Nu/YxV7+ormUmPgs96HoKgl/WVCajfo6cNdbMyOIfgCHUP5FZkHHSD3FMiKJj1VEF9
         6QrosyZwrhT21F5Rp8IAOd1UvXdvyO8N/t/tI5ms8weGdLu16rZp80vyzEXLsviBV8a3
         5z3SCI9tAo2dV0m7yilH82w1oaFlL37RMhEcfcDG3kGgmY+vrwFcb1xy0R+iIsm3MEXa
         kLtZGTWnRnzwxrmCnF7SlTQYowRv1I9EJQKwhMX7jh3+LQuiulSeX01y8nPP18xdbz+R
         Cd97Ab5cISW25uYIkhx258bclfJ9SpLR1DoVX3Ycrw084RB3bbypW5zQDYRK3LI+EeZO
         OWqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/Kb6qY7J96283YjtKVBa2leKrxQfjLaFtUTwuksGsUitz6NP2wq70PViCKa/Gmo4z6umdlQW5ow==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOEC/IjnaYWTLCojwVP+xRKjEq4PV7vtyCE1RMsJHv4cB1sTW+
	BX6Cp0zhpg/8iBXNGVIzxpRG3VmJfWpyRLAY5JC8sNEe6fHR4tGVL3u1/aezLvoAWQ==
X-Gm-Gg: AY/fxX5PCvBhKKrMY9mZ16WjvA44YyEETnsDFU2AjuFMcDiXapub9ASKxuskIrgrWCP
	YLM5FkcWRdJtNYlBV8QkjL1PSP5mmREH43RfS0ipmfeDKzKVAKkRbTNLKjZCs9mGIGozlru9Xz8
	thwOAo5MvE+zDM8y5HsEpkWz/x86sBwesk+nROA3pueP7iPQGVi/XgVr5zGil4Wbw3nVSVdLMY3
	Xi/vpUj17XuTwyzzwdfPp1wiAx/qZPtHlgeWzUZUU/5dmA0pNjGUmiehSNfYgypOV8gELYhz/vG
	9pgWazlNYj1zd0nUdbNRJPf2eG7pruz/RaPCM8J32t7d0zI3IfvBbg7QO77txYSgyPq6BcWzXLV
	QWLXUD4yhFE+WhZK48SR1rQvRYCPTi26Evb7Fn0WDBsIPHMz2pvanKzGEzs2AgLRmYhl4FS4ZyI
	DISderwwmYBp1xAxXXrAy2R5nO3pKVnWzLfJB0zsJoQB0Rt03wc91EJLxHQtEbfynCou0kXlgX2
	hel6WHfhZ7MyA==
X-Received: by 2002:a05:7301:19ad:b0:2a4:6c74:c54a with SMTP id 5a478bee46e88-2b486f41ca8mr940567eec.18.1768351662492;
        Tue, 13 Jan 2026 16:47:42 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:b660:2cbe:a9b7:fc12? ([2a00:79e0:2e7c:8:b660:2cbe:a9b7:fc12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a5d3dsm17693801eec.13.2026.01.13.16.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 16:47:41 -0800 (PST)
Message-ID: <378ee786-2b44-44e7-a3f6-0cd1db3c0481@google.com>
Date: Tue, 13 Jan 2026 16:47:40 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] power: supply: max77759: add charger driver
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
References: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
 <20251227-max77759-charger-v3-4-54e664f5ca92@google.com>
 <298ca35590d2180fdcf334f94964b6110e17c606.camel@linaro.org>
 <50c29a62-1fdb-4de2-8887-0d551eee5ec0@google.com>
 <255d7726-6758-43ed-b35f-db14726bcc9b@google.com>
 <2869d309358f27652289c40810ca36b2ec155d1d.camel@linaro.org>
 <bb9b9afa-0bfa-428e-9372-549d9ba8603c@google.com>
 <6b37b88e9b7ee57eb1c006916fd995c813ab5e6e.camel@linaro.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <6b37b88e9b7ee57eb1c006916fd995c813ab5e6e.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andre',

On 1/13/26 2:02 AM, André Draszik wrote:
> Hi Amit,
>
> On Mon, 2026-01-12 at 11:37 -0800, Amit Sunil Dhamne wrote:
>> Hi Andre',
>>
>> On 1/12/26 5:47 AM, André Draszik wrote:
>>> Hi Amit,
>>>
>>> On Tue, 2026-01-06 at 17:14 -0800, Amit Sunil Dhamne wrote:
>>>> On 1/6/26 3:41 PM, Amit Sunil Dhamne wrote:
>>>>> Hi Andre',
>>>>>
>>>>> On 1/5/26 9:32 AM, André Draszik wrote:
>>>>>> Hi Amit,
>>>>>>
>>>>>> I haven't done a full review, but a few things caught my eye.
>>>>>>
>>>>>> On Sat, 2025-12-27 at 00:04 +0000, Amit Sunil Dhamne via B4 Relay wrote:
>>>>>>> diff --git a/drivers/power/supply/Makefile
>>>>>>> b/drivers/power/supply/Makefile
>>>>>>> index 4b79d5abc49a..6af905875ad5 100644
>>>>>>> --- a/drivers/power/supply/Makefile
>>>>>>> +++ b/drivers/power/supply/Makefile
>>>>>>> [...]
>>>>>>> +
>>>>>>> +static irqreturn_t irq_handler(int irq, void *data)
>>>>>>> +{
>>>>>>> +    struct max77759_charger *chg = data;
>>>>>>> +    struct device *dev = chg->dev;
>>>>>>> +    u32 chgint_ok;
>>>>>>> +    int i;
>>>>>>> +
>>>>>>> +    regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_INT_OK,
>>>>>>> &chgint_ok);
>>>>>> You might want to check the return value and return IRQ_NONE if it
>>>>>> didn't
>>>>>> work?
>>>>>>
>>>>>>> +
>>>>>>> +    for (i = 0; i < ARRAY_SIZE(irqs); i++) {
>>>>>>> +        if (irqs[i] == irq)
>>>>>>> +            break;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    switch (i) {
>>>>>>> +    case AICL:
>>>>>>> +        dev_dbg(dev, "AICL mode: %s",
>>>>>>> +            str_no_yes(chgint_ok & MAX77759_CHGR_REG_CHG_INT_AICL));
>>>>>>> +        break;
>>>>>>> +    case CHGIN:
>>>>>>> +        dev_dbg(dev, "CHGIN input valid: %s",
>>>>>>> +            str_yes_no(chgint_ok & MAX77759_CHGR_REG_CHG_INT_CHGIN));
>>>>>>> +        break;
>>>>>>> +    case CHG:
>>>>>>> +        dev_dbg(dev, "CHG status okay/off: %s",
>>>>>>> +            str_yes_no(chgint_ok & MAX77759_CHGR_REG_CHG_INT_CHG));
>>>>>>> +        break;
>>>>>>> +    case INLIM:
>>>>>>> +        dev_dbg(dev, "Current Limit reached: %s",
>>>>>>> +            str_no_yes(chgint_ok & MAX77759_CHGR_REG_CHG_INT_INLIM));
>>>>>>> +        break;
>>>>>>> +    case BAT_OILO:
>>>>>>> +        dev_dbg(dev, "Battery over-current threshold crossed");
>>>>>>> +        break;
>>>>>>> +    case CHG_STA_CC:
>>>>>>> +        dev_dbg(dev, "Charger reached CC stage");
>>>>>>> +        break;
>>>>>>> +    case CHG_STA_CV:
>>>>>>> +        dev_dbg(dev, "Charger reached CV stage");
>>>>>>> +        break;
>>>>>>> +    case CHG_STA_TO:
>>>>>>> +        dev_dbg(dev, "Charger reached TO stage");
>>>>>>> +        break;
>>>>>>> +    case CHG_STA_DONE:
>>>>>>> +        dev_dbg(dev, "Charger reached TO stage");
>>>>>>> +        break;
>>>>>> Are the above debug messages really all needed?
>>>> I forgot to respond to this comment in my previous email.
>>>>
>>>> I think we can keep AICL, BAT_OILO, INLIM. They're either special
>>>> conditions (AICL) or faulty conditions (like BAT_OILO) and we can in
>>>> fact keep them at dev_info level. Rest can be removed and a
>>>> power_supply_changed() is sufficient.
>>>>
>>>> Let me know what you think?
>>> I don't think dev_info() in an interrupt handler is appropriate. At
>>> least it should be ratelimited.
>>>
>>> If it's something special / unexpected that needs attention, having
>>> a dev_dbg() message only will usually not be visible to anybody.
>> I agree. I can change the prints to dev_info_ratelimited for the stuff
>> we care about.
> If it's an erroneous condition, maybe warn or even err are more appropriate?
>
> But then, what is the expectation upon the user observing these messages?
> What can or should they do? Who is going to look at these and can do
> something sensible based on them?

The logging will help in postmortem analysis which may or may not 
possible with just publishing uevents to userspace hoping that they log 
the psy properties. Illustrating a situation:

1. Over current situation happened where the Battery to System current 
exceeds the BAT_OILO threshold. This would also generate an interrupt.

2. The MAX77759 takes protective measures if the condition lasts for a 
certain specified time and reset. Resetting will cause Vsys to collapse 
to 0 if the system is only battery powered.

3. It'd be better that the BAT_OILO interrupt is logged in dmesg, 
instead of just delegating it to user space as user can debug this 
condition by looking at last_kmsg or pstore.

4. This signal can help the user debug conditions such as moisture (this 
signal + contaminant detection) or indicative of a mechanical failure.

I do agree though that this is a hypothetical or very rare situation and 
if you have a strong opinion against this I am okay with removing the 
prints completely.


>
>>> Also will the call to power_supply_changed() down below handle the
>>> special conditions (e.g. convey to upper levels)? If not, can it be
>>> made to do so?
>> Yes it does, as I can see a call to kobject_uevent() inside
>> power_supply_changed_work(). Also, power_supply_changed() also notifies
>> other subsystems that have registered their notifiers downstream of this
>> power_supply object. So I believe we're good there.
> If erroneous conditions are handled by other / upper layers, why print a
> message in this interrupt handler in the first place?

I tried illustrating an example above.


>
> Also, I just noticed there is a max77705 charger driver. It seems quite
> similar to this one, maybe it can be leveraged / extended?

Thanks for the feedback. I reviewed the max77705 charger driver. .

Here is a breakdown of why I believe a separate driver may be a better 
approach:

Similarities:

1. Helper Functions: We could potentially leverage common logic for 
get_charge_type, get_status, get_health, and get_input_current.

2. Register Access: MAX77705 uses regfield abstractions to handle 
register operations which can also be potentially leveraged.

3. Initialization: Some hardware initialization steps appear similar, 
though about 60% of the max77705 initialization (e.g., switching 
frequency, WCIN regulation voltage, top-off time) is irrelevant for the 
max77759 configuration I need.

Differences:

1. OTG Support: The max77759 driver supports OTG boost mode, which is a 
key requirement for my use case. While the max77705 hardware might 
support OTG based on its registers, the current driver implementation 
does not support it.

2. TCPCI/TCPM Integration: The max77759 driver is explicitly architected 
to work with a TCPCI/TCPM-compliant Type-C controller to set input 
current limits dynamically. It is ambiguous whether the max77705 device 
uses a standard TCPCI/TCPM model or a proprietary one.

3. Register Incompatibility: There are distinct register differences. 
For example, the max77705 driver relies on BATP and BATP_DTLS registers, 
which do not exist in the max77759. Conversely, the max77759 has a 
dedicated second interrupt register (CHG_INT2) that reports critical 
signals like BAT_OILO, SYS_UVLO, and charging stages, which appear 
absent or handled differently in the max77705. Additionally, MAX77759 
has input selection (wireless, usb) and uses it in the driver but it's 
not evident from register definitions whether max77705 has it.

4. Parameter Calculations: The formulas for calculating parameters like 
Fast Charge Current (CHGCC) and Float Voltage are different between the 
two chips. Merging the drivers would require separate, chip-specific 
getter/setter functions for these core properties.

5. Device-Specific Workarounds: The max77705 driver includes a 
workaround in max77705_aicl_irq that is not relevant to the max77759. 
There may also be future workarounds which may not be applicable to one 
or the other.

Logistical Constraints: I don't have access to max77705 hardware or its 
full datasheet. This makes it impossible for me to test any shared code 
changes to ensure I haven't introduced regressions on the max77705. IMO, 
given these constraints and technical divergences, maintaining separate 
drivers maybe a better choice. Please let me know wdyt?


BR,

Amit

>
>
> Cheers,
> Andre'

