Return-Path: <linux-pm+bounces-38764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ED0C8CCAE
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 05:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 738BD4E136D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 04:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F502D73B6;
	Thu, 27 Nov 2025 04:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eIZBMn1n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DE71FC110
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 04:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764216943; cv=none; b=dYNIOjFzq88h57H6rEg6GoWJg9mF/A0L+U69xjqOaAJZVrBa0fab4j8QuM9+vpWEeF0p1llcPkm9lJH1N2ve2IPNijzLj59pM9Xyx0kZkMwr8Rqmu5DItOZ8YQk44i9U5CgYS2Ta1i6jPIKXbSo5cwmyGBkWUd0xZTGvukV2Vh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764216943; c=relaxed/simple;
	bh=JGo7Z1jibLQxReWr7ufYyOjlW5ky5THyGr654nH0moM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOv4LEvbq/HgnitLjrA6BMITbekxjGqmtmgIuUYSQRJ2crmm2bZuxr9MZDy0mtgCQdxlK+f+/EluqDazpnrQxGoqSQ52LA/8lv9dqc+WsZMCI9xrqqxTCnoI62h8ZNruPJ8tkr16Tpf5MewJLSGd4kFqzXxNLBk5xS6fQ43MNh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eIZBMn1n; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso336820a12.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 20:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764216941; x=1764821741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TkXUCD/sfJEqbYrrabHICoE25LMTNly9IBUsbDSuWOk=;
        b=eIZBMn1nKLWpkamsDw6L7R0yM13dNgW4476aY3Iigcyh6OKAOd6G52zvJV8Frmlwtz
         A9LT6/eH7mZgkYV3foIeFRPJcnL7n+ps34yqap+3E7kRvK735z+vcB3NyBawp97VVCd5
         MrlxWGMuj1nulSePGsF7KOxJKjgEomm1iKYjebDK6IWN1xIUZ6qQ2nL01q5tUljRN+RI
         i36C4bbVxLIPaZKWO0aFyCKEEJmxby+Ioe7Bxow/PUtDF0XfzosdicnTwGJkb+DBqbPu
         KhQbEF80UDLsgxVml9caGXvjhKo99xV9Q2XzA0YkhZ3MGlqZ8MSImogM7G/EB8SHv2PH
         M3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764216941; x=1764821741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TkXUCD/sfJEqbYrrabHICoE25LMTNly9IBUsbDSuWOk=;
        b=XmVdwc83tk/x0RcgjajX+V9tHFVpThL4jQ/y3U6M4ewsPIpYF20xLaqyLXCJ8sRQkK
         2uSl0Pcq41HFMm5kcHKokYiCFbkLQ5GQFFZFFuMGkhPeajUeGXNnvIQgC7KlaJ7SsSe5
         AJxBvHS+ZmuBmN0NLFYfyUYNm76aRjIHN9g2WlZCU+oacLR1/GcITN9T5t/ljem997vA
         rsbC9KAGfkKMrTxTcv8QXOXlMmhihAWtyXIrL4GRQDozWSk3CF0ro/ag5O6wo9cGTCyN
         sbrrEpGfxet4o77+WDeqsctoIAYIVnZx5lTRF9LwINUFoM3dFbAhNCBWZYAnr6TRzPlC
         XAXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3LmHHorqDsvAsRvhfGmB6UKfgG+mg75X5ecvPbmx3JduxnDHMqGOhItseiEAleiQFSLKv8fb/bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdSpaka1FZA2FIxP2P3EEEOGBlpdW6jLaIdSWLu8/bX0YCeJtp
	0cSGPF/LudIJvKny+G3RnQ0p+gRwhcaTTltzv2o50u9AQ5NJjeoRl5CPl0KcPFG42A==
X-Gm-Gg: ASbGnctEuH9iUgOpVqHCkAGJ7xAI+ri1K/kMbg4EfsoVm2UEuU1Z1BfAaZpRiq3lPd8
	kj7VKL00bFVQ+LsL9GCs8lwQh9WdWP9H39sSoyRClgOQQGqEBIEcPciEH+BgmAA0AUuDPo/I9wG
	UKWAq9q7YCRB2Oa54HwCFMLE6IM+bk8p2l3qedarwUT0MeIjyVtn8RMAl8HV0dIPcCKpmvYlYuB
	Sn0+YsTw5UYSMXGo5Q8SeqnbjM9kalGUI6cBSCvdHKsSaqtP6cChJTZ3lCtYQzDsoC4a8PLg9YW
	RbJSXITttG9+PszamXzpKwsVPdV326L7eAJwLQStIDCqCelze9FfDjOF8W4g4Vehl+skeyMIWDo
	tvb1l/haxIXg+mA5IuBkB77PDI2r8vlinHSw2A6P488ucc5A0qwZp+EPSjuMa72MgUARy3ecO/T
	SD8c8Iyt9dU/1lKxfT9z170VGRL1BBS/P7ugbssqLj7T9fdgq2pK7CErdIYS/uJG3B2TXlRy2RM
	9MHBTBzGsC/3g==
X-Google-Smtp-Source: AGHT+IGdB7ijJFvVK8Snhgzlb9iXXr21271jtHTPlPGlAm0Ty7r+mUpMoHeF2HI52zomvLA2TJb3xQ==
X-Received: by 2002:a05:7300:d405:b0:2a4:3593:c7d6 with SMTP id 5a478bee46e88-2a7195cb23fmr12999898eec.22.1764216940215;
        Wed, 26 Nov 2025 20:15:40 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:c116:b1c9:632d:a902? ([2a00:79e0:2e7c:8:c116:b1c9:632d:a902])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965b47caasm2419198eec.6.2025.11.26.20.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 20:15:39 -0800 (PST)
Message-ID: <6f2f075b-3570-4424-9cc7-695fb8c3b988@google.com>
Date: Wed, 26 Nov 2025 20:15:38 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] mfd: max77759: modify irq configs
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
References: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
 <20251123-max77759-charger-v1-4-6b2e4b8f7f54@google.com>
 <5c901a6c831775a04924880cc9f783814f75b6aa.camel@linaro.org>
 <aa7bdeb1-c8a9-4353-af56-869f16a083c2@google.com>
 <e25ff0e5ff103433942fc7744eea4a3c61ce1daf.camel@linaro.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <e25ff0e5ff103433942fc7744eea4a3c61ce1daf.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/25/25 10:44 PM, André Draszik wrote:
> Hi Amit,
>
> On Tue, 2025-11-25 at 17:10 -0800, Amit Sunil Dhamne wrote:
>> Hi André,
>>
>> On 11/23/25 10:21 PM, André Draszik wrote:
>>> Hi Amit,
>>>
>>> Thanks for your patches to enable the charger!
>> Ack!
>>
>>
>>>> From: Amit Sunil Dhamne <amitsd@google.com>
>>>>
>>>> Define specific bit-level masks for charger's registers and modify the
>>>> irq mask for charger irq_chip. Also, configure the max77759 interrupt
>>>> lines as active low to all interrupt registrations to ensure the
>>>> interrupt controllers are configured with the correct trigger type.
>>>>
>>>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>>>> ---
>>>>    drivers/mfd/max77759.c       | 24 +++++++++++++++++-------
>>>>    include/linux/mfd/max77759.h |  9 +++++++++
>>>>    2 files changed, 26 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/mfd/max77759.c b/drivers/mfd/max77759.c
>>>> index 6cf6306c4a3b..5fe22884f362 100644
>>>> --- a/drivers/mfd/max77759.c
>>>> +++ b/drivers/mfd/max77759.c
>>>> @@ -256,8 +256,17 @@ static const struct regmap_irq max77759_topsys_irqs[] = {
>>>>    };
>>>>    
>>>>    static const struct regmap_irq max77759_chgr_irqs[] = {
>>>> -	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_1, 0, GENMASK(7, 0)),
>>>> -	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_2, 1, GENMASK(7, 0)),
>>>> +	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_1, 0,
>>>> +		       MAX77759_CHGR_REG_CHG_INT_AICL |
>>>> +		       MAX77759_CHGR_REG_CHG_INT_CHGIN |
>>>> +		       MAX77759_CHGR_REG_CHG_INT_CHG |
>>>> +		       MAX77759_CHGR_REG_CHG_INT_INLIM),
>>>> +	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_2, 1,
>>>> +		       MAX77759_CHGR_REG_CHG_INT2_BAT_OILO |
>>>> +		       MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CC |
>>>> +		       MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CV |
>>>> +		       MAX77759_CHGR_REG_CHG_INT2_CHG_STA_TO |
>>>> +		       MAX77759_CHGR_REG_CHG_INT2_CHG_STA_DONE),
>>>>    };
> You should also add the remaining bits in each register here, so that the
> regulator-irq can mask them when no user exists. It will only touch the
> bits it knows about, so the state of the mask register is non-
> deterministic with this change as-is (depends on how the bootloader
> configured it).
>
> [...]

I see what you're saying. I will remove this and keep it the way it was 
before.


>
>>>
>>>> diff --git a/include/linux/mfd/max77759.h b/include/linux/mfd/max77759.h
>>>> index c6face34e385..0ef29a48deec 100644
>>>> --- a/include/linux/mfd/max77759.h
>>>> +++ b/include/linux/mfd/max77759.h
>>>> @@ -62,7 +62,16 @@
>>>>    #define MAX77759_CHGR_REG_CHG_INT               0xb0
>>>>    #define MAX77759_CHGR_REG_CHG_INT2              0xb1
>>>>    #define MAX77759_CHGR_REG_CHG_INT_MASK          0xb2
>>>> +#define MAX77759_CHGR_REG_CHG_INT_AICL          BIT(7)
>>>> +#define MAX77759_CHGR_REG_CHG_INT_CHGIN         BIT(6)
>>>> +#define MAX77759_CHGR_REG_CHG_INT_CHG           BIT(4)
>>>> +#define MAX77759_CHGR_REG_CHG_INT_INLIM         BIT(2)
>>>>    #define MAX77759_CHGR_REG_CHG_INT2_MASK         0xb3
>>>> +#define MAX77759_CHGR_REG_CHG_INT2_BAT_OILO     BIT(4)
>>>> +#define MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CC   BIT(3)
>>>> +#define MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CV   BIT(2)
>>>> +#define MAX77759_CHGR_REG_CHG_INT2_CHG_STA_TO   BIT(1)
>>>> +#define MAX77759_CHGR_REG_CHG_INT2_CHG_STA_DONE BIT(0)
>>> Even if wireless out of scope, it'd still be nice to add macros for
>>> the remaining bits to make this complete and avoid having to update
>>> these again in case wireless support gets added in the future.
>> I would prefer to only define the macros I am currently using to keep
>> the review focused, unless you consider this a strict requirement.
> It makes sense to add them now, as per above.

Okay. I will add them.


>
>
>
>>> Also, would be nice to keep existing style and indent the bits from
>>> the registers (see existing bit definitions in this file a few lines
>>> further up).
>>> Finally, can you add the bits below the respective register (0xb0 / 0xb1)
>>> please, to keep suffix meaningful, and to follow existing style for cases
>>> like this (see MAX77759_MAXQ_REG_UIC_INT1).
>> I will fix the indentation and ordering in the next revision.
>>
>> Regarding bit definitions: In [PATCH 5/6], the max77759_charger.c driver
>> defines bits for the register addresses defined in this file. Currently,
>> those macros are only used locally by the max77759 charger driver. Would
>> you prefer I move those definitions to this header file as well?
> Yes, would be nice to have them all in one place (in this file). That said,
> CHG_INT, CHG_INT_MASK, and CHG_INT_OK all have the same layout and share
> the same bits, so I personally would probably reuse the ones you added for
> INT for all three of them - MASK (as you did already), and also for the OK
> register. But up to you.

Sounds good.


Thanks,

Amit

> Cheers,
> Andre'

