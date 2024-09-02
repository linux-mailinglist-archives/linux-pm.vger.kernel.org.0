Return-Path: <linux-pm+bounces-13321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 939EB9681D1
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 10:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21AFA1F22DB6
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 08:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AB5187561;
	Mon,  2 Sep 2024 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qd4FSUXZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EC91865F2
	for <linux-pm@vger.kernel.org>; Mon,  2 Sep 2024 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265712; cv=none; b=OwHfMPslNodTEqSt9W0swzFuJwXE+CsiYiZLSIEiGnhj6QsNypJ2Woq+gnv3hsNYIs7MpXe4LOtWWgvwnwNROvanA0aC4ot8MqStSiKPYyh2wFpd45pGDaD7bVPaDXzB4hjn4Rd7oMng17E0vTvT6+LQQLoTeZESB2CFPEf0Wfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265712; c=relaxed/simple;
	bh=rnpVTjL4kf4dMqWQgikUzL9UOIZNjCvBFJeMtodla3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgMoLNWj4aIPx+ZJnNKU+5qgDEglmMp+9/eEyFcNPik2PcWzSQmT9B8Lhl/zieGUJMN1WmZLVdq1XQfntKLK4bSykCFDcYEr4iAOatHDG0jqyeHVir14OpkIAuB5G5aQW/12YM2mJiu5lh0PNQ3+ZCBxu24V/rdgwgjuxd2xMmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=qd4FSUXZ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c24c92f699so1517509a12.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2024 01:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725265709; x=1725870509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xuSIAX3TkFJwp4EKqR8txlbKQ8ME5wdxgrNK5MzVZqo=;
        b=qd4FSUXZHwG0Meg+YbcvpkGXy7BFowdm/+/mRSu3CwvviIkAudmc3/odkCcT/3rOxu
         xdFZQeNTSgwvajA/STsjKwT0fhmc2jSr15blVwcbrO0vLi6zUWDEND1R02poiy8roeg2
         NWzad0p30kb9lpel2EdSOduw12Y12uU6tDldAghbbmjwqRfUM7zwCzGtv6ZI2KRSlwg8
         /RpOPHinZpTeTYFmWY1a4Iq42KooB6lSpaqBsHjfZkE4DRf0g69wfA9FPdguAOnqiB4G
         etW6BtHR9LQmaqUvORGK0H9DfC9QOMHqa1GZnRsxsZW/FBKZH09Mf1AelNi+sruHjmbi
         XQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725265709; x=1725870509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xuSIAX3TkFJwp4EKqR8txlbKQ8ME5wdxgrNK5MzVZqo=;
        b=lcFe1b9RBz6dWFYlOJ241ZrzFK73I9sadeT6SUrC3Qs1lF/qOjs6aOhgNa0snAEDfC
         m1EJ1q6ty3C+NfS/EwUT7GBkzHnq+lxhYP7wUQt2xflpVxMua0HzZDq+Hpp9sZ1xVMZP
         Za1JIz92W6XvJlbCQ9ZBHmJ38nSYDzu0SwamvJYvIW5DW787T9xa7mdX7MmXfk7X97pL
         bq+3kWGUcRydLr6jnClKLZ9fKQ4QCW2Gew307vLemnnuA8O3jeUoNWLERxWl3/ml+KFX
         qJdBjU6c4Mz+olo4l7cGdH1FyVQbbMUjTGMYKcjWCBB/XXnCDWQJ1zdbsBHwW0nrNyAV
         Z3Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXU4epPVxd5rZNnLjgHdFLSRpyIhtY3dEx55qZ0pNZQqg+WFWKi1t43sNwRWP//dC7GOVNgBT6x4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0jhtlfUb0mT6TD9Gj2XZLyKxwxj+EVK0IAe3qJJFfN2aiPvqz
	JGUx3TTFli6FoHg4lM5ULEsBHZJxL0XhlvZVx5W2fYHFGrdoJa1U2u0gDFpR0+k=
X-Google-Smtp-Source: AGHT+IFnSS3AyZyXwK3tX+2059zJpEoBIuXq5dRlOW8dSAq2eAxT17MymZumSDwZSnEQaWTkK5CbQg==
X-Received: by 2002:a17:907:944c:b0:a7a:97ca:3058 with SMTP id a640c23a62f3a-a897f7910e8mr1024209166b.5.1725265708448;
        Mon, 02 Sep 2024 01:28:28 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6f87sm522330766b.158.2024.09.02.01.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 01:28:28 -0700 (PDT)
Message-ID: <90df82c1-bb09-4c91-ba7f-af328066bd43@tuxon.dev>
Date: Mon, 2 Sep 2024 11:28:25 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
Content-Language: en-US
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: "vkoul@kernel.org" <vkoul@kernel.org>,
 "kishon@kernel.org" <kishon@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFrS4Dhd7DZa2zz=oPro1TiTJFix0awzzzp8Qatm-8Z2Ug@mail.gmail.com>
 <99bef301-9f6c-4797-b47e-c83e56dfbda9@tuxon.dev>
 <TY3PR01MB1134652F9587CFA0ADE851CA486902@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB1134652F9587CFA0ADE851CA486902@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31.08.2024 08:13, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>> Sent: Friday, August 30, 2024 9:23 AM
>> Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
>>
>> Hi, Ulf,
>>
>> On 29.08.2024 18:26, Ulf Hansson wrote:
>>> On Thu, 22 Aug 2024 at 17:28, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>>
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> Hi,
>>>>
>>>> Series adds initial USB support for the Renesas RZ/G3S SoC.
>>>>
>>>> Series is split as follows:
>>>>
>>>> - patch 01/16           - add clock reset and power domain support for USB
>>>> - patch 02-04/16        - add reset control support for a USB signal
>>>>                           that need to be controlled before/after
>>>>                           the power to USB area is turned on/off.
>>>>
>>>>                           Philipp, Ulf, Geert, all,
>>>>
>>>>                           I detailed my approach for this in patch
>>>>                           04/16, please have a look and let me know
>>>>                           your input.
>>>
>>> I have looked briefly. Your suggested approach may work, but I have a
>>> few thoughts, see below.
>>>
>>> If I understand correctly, it is the consumer driver for the device
>>> that is attached to the USB power domain that becomes responsible for
>>> asserting/de-asserting this new signal. Right?
>>
>> Right!
>>
>>>
>>> In this regard, please note that the consumer driver doesn't really
>>> know when the power domain really gets powered-on/off. Calling
>>> pm_runtime_get|put*() is dealing with the reference counting. For
>>> example, a call to pm_runtime_get*() just makes sure that the PM
>>> domain gets-or-remains powered-on. Could this be a problem from the
>>> reset-signal point of view?
>>
>> It should be safe. From the HW manual I understand the hardware block is something like the following:
>>
>>
>>                   USB area
>>          +-------------------------+
>>          |                         |
>>          | PHY --->USB controller  |
>> SYSC --> |  ^                      |
>>          |  |                      |
>>          | PHY reset               |
>>          +-------------------------+
> 
> How USB PWRRDY signal is connected to USB? 

HW manual mentions this in the chapter describing the SYS_USB_PWRRDY register:

Controls PWRRDY terminal of USB

0: PWRRDY

1: PWRRDY down

When turning off the *USB region* power, set this bit to 1.

When turning on the *USB region* power, set this bit to 0

By USB region I get the that it is related to the SoC area where resides
all the USB IPs. I cannot tell more than what is in the hardware manual.


> 
> USB block consists of PHY control, PHY, USB HOST and USB OTG Controller IPs.
> 
> Is it connected to top level block or connected to each IP's for turning off the USB region power?

I cannot tell more than it is in the hardware manual.

> 
> ? Or Just PHY (HW manual mentions for AWO, the USB PWRRDY signal->USB PHY PWRRDY signal control)?
> 
> If the USBPWRRDY signal is connected across modules with this reset signal approach
> then you may need to update bindings [1] with that reset signal
> 
> [1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20240822152801.602318-12-claudiu.beznea.uj@bp.renesas.com/

If that is true, then this signal may need to be routed to the PHY for
better hardware description.

>  
> 
> Cheers,
> Biju
> 
>>
>> Where:
>> - SYSC is the system controller that controls the new signal for which
>>   I'm requesting opinions in this series
>> - PHY reset: is the block controlling the PHYs
>> - PHY: is the block controlling the USB PHYs
>> - USB controller: is the USB controller
>>
>> Currently, I passed the SYSC signal handling to the PHY reset driver; w/o PHY reset the rest of the
>> USB logic cannot work (neither PHY block nor USB controller).
>>
>> Currently, the PHY reset driver call pm_runtime_resume_and_get() in probe and pm_runtime_put() in
>> remove. The struct reset_control_ops::{assert, deassert} only set specific bits in registers (no
>> pm_runtime* calls).
>>
>> The PHY driver is taking its PHY reset in probe and release it in remove().
>> With this approach the newly introduced SYSC signal will be de-asserted/asserted only in the PHY reset
>> probe/remove (either if it is handled though PM domain or reset control signal).
>>
>> If the SYSC signal would be passed to all the blocks in the USB area (and it would be handled though
>> PM domains) it should be no problem either, AFAICT, because of reference counting the
>> pm_runtime_get|put*() is taking care of. As the PHY reset is the root node the in the devices node
>> tree for USB the reference counting should work, too (I may miss something though, please correct me
>> if I'm wrong).
>>
>> If the SYSC signal would be handled though a reset control driver (as proposed in this series) and we
>> want to pass this reference to all the blocks in the USB area then we can request the reset signal as
>> shared and, AFAIK, this is also reference counted. The devices node tree should help with the order,
>> too, if I'm not wrong.
>>
>> Thank you for looking at this,
>> Claudiu Beznea
>>
>>>
>>> [...]
>>>
>>> Kind regards
>>> Uffe

