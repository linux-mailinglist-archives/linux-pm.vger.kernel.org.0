Return-Path: <linux-pm+bounces-13322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD26F968252
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 10:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9E11C21801
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 08:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F42C186E38;
	Mon,  2 Sep 2024 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="JOwaJQa7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D87156885
	for <linux-pm@vger.kernel.org>; Mon,  2 Sep 2024 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266851; cv=none; b=ep/DnzqKgNeyx5cJ//xyQmvVXghtut5U1AEOtrcJnvOS7idhU6Pho16zxHzk7tlbMl53ck7sqA49TK4WMEHzt2+YosMPm4gylw1aXzoM9j4rFdb9TqIdS/vpp3G52cWBK3WMnxqZ44jzm7/JEk6LxLONaMby54ZrU7xJaj6nOMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266851; c=relaxed/simple;
	bh=N2g00tuABoBPM0sSD+eLbo4vma8qIxTBQwjDX+kBOwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a892ISQS5wYIjKgX85BohopvhdxY4GAlz/Dj8Nec0cj9EAMjk21PxS1tEgIrj2JGe1CO3mGAnGrkCTt9VlqAwP+wkRv8sKh90h/1DF4wMG8oomfDP6wmVNxk3szvxtICcmiyTwirQM+qUcYdDo60AjIt6g9OLhxkTJFFYTVy8w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=JOwaJQa7; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5343e75c642so5164786e87.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2024 01:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725266847; x=1725871647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oOaSphN4uqIVyGx4/lf/Z0TMBGuenM0C4nTClydRFg4=;
        b=JOwaJQa7oe0E2nuM/9p9QTTllF4o7QC8SPrdiGTm4A+0CzJpTWjOtKcgg49SsjD0NB
         ZZk4IR6JDv7Ejtx8dnfzr3At5DycGmJBoy1SylS/VZchjiIiN63oUWCnsBMQNA8bOmIT
         ZEBWsWWKCceWaPlHSgfuN2bKTYMd4sEtaR94p3uE2Mdzv97Z8CKtgkR3AEd0vZVZpS2b
         VkOiWUOoQtQOl96pQt/+J/q41Hbzis5CI3JJU60XId8GBHw77SoTRZ87KCgRR1DDAgUS
         IT1M6AdUGpj+8/6kzRbllNIdfTBH/N1b1a78rWKDzzH/n5C2+d97GNUBAwx49CrrJjXE
         KGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266847; x=1725871647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOaSphN4uqIVyGx4/lf/Z0TMBGuenM0C4nTClydRFg4=;
        b=d07C12AADBp0J1nHbCcmEBLp9MqAEhxjPHDc+jMVwu4c5Qaa8yoRASOm5bHqqL/+NE
         G7eqbOYsu1+0N/VPpOwDnJmV+Nwy2JnnBqHLZjrNx+opHht7U1MZpNl0TghyDQ/LTOVM
         MqtsiOJjEmF7PZII0RWqpbe1CQGugipn0xtGWYOUvmUrdSvjZ0Oes8gy0hguc1dTZmLW
         5etF5WcoIroLV3hyI5Y8pUzfopPTir7aspN+QBnhRkHh2mcqSOp+9NmfAKRUTTiJP5LE
         QoeCrJGQYorWqpOrqdUmC8//xvKfKS+JtFmTRpUPni5DXoQZQJk/UKpDO07Orqs7rBSo
         RjWw==
X-Forwarded-Encrypted: i=1; AJvYcCUaEA99xLxItcluk7yrkAT+Un3Vpkn3EpmOhKQPufzb6XUZXegJaU94245LuLiUnbQBzKIYJbaUiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0M8IC6OeRne55RLH+mpKN5xOim+PZq8G2ePQN1aqKigwj675w
	Dg5yJwEqBeEfMFMTbFDxwUzet3lkogLQxUdKR0VhsL/Ae8B23lB6SMLqHRYEJ8U=
X-Google-Smtp-Source: AGHT+IFKP+TMYUf8hSyMMTGOziIULq1HvfnDIOTbDSCryKJ5amdlOmDWug+wIx0ZuZ/E3sdbRQoVKA==
X-Received: by 2002:a05:6512:15a5:b0:52e:9e70:d068 with SMTP id 2adb3069b0e04-53546afad74mr5564997e87.4.1725266847009;
        Mon, 02 Sep 2024 01:47:27 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988fef4c3sm525445666b.32.2024.09.02.01.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 01:47:26 -0700 (PDT)
Message-ID: <5556d176-cca7-492c-ba21-48256d5d6338@tuxon.dev>
Date: Mon, 2 Sep 2024 11:47:24 +0300
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
 <TY3PR01MB113467275C519B729FCAB1ACB86922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB113467275C519B729FCAB1ACB86922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Biju,

On 02.09.2024 10:54, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: Biju Das
>> Sent: Saturday, August 31, 2024 6:14 AM
>> Subject: RE: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
>>
>> Hi Claudiu,
>>
>>> -----Original Message-----
>>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>>> Sent: Friday, August 30, 2024 9:23 AM
>>> Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas
>>> RZ/G3S SoC
>>>
>>> Hi, Ulf,
>>>
>>> On 29.08.2024 18:26, Ulf Hansson wrote:
>>>> On Thu, 22 Aug 2024 at 17:28, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>>>
>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>
>>>>> Hi,
>>>>>
>>>>> Series adds initial USB support for the Renesas RZ/G3S SoC.
>>>>>
>>>>> Series is split as follows:
>>>>>
>>>>> - patch 01/16           - add clock reset and power domain support for USB
>>>>> - patch 02-04/16        - add reset control support for a USB signal
>>>>>                           that need to be controlled before/after
>>>>>                           the power to USB area is turned on/off.
>>>>>
>>>>>                           Philipp, Ulf, Geert, all,
>>>>>
>>>>>                           I detailed my approach for this in patch
>>>>>                           04/16, please have a look and let me know
>>>>>                           your input.
>>>>
>>>> I have looked briefly. Your suggested approach may work, but I have
>>>> a few thoughts, see below.
>>>>
>>>> If I understand correctly, it is the consumer driver for the device
>>>> that is attached to the USB power domain that becomes responsible
>>>> for asserting/de-asserting this new signal. Right?
>>>
>>> Right!
>>>
>>>>
>>>> In this regard, please note that the consumer driver doesn't really
>>>> know when the power domain really gets powered-on/off. Calling
>>>> pm_runtime_get|put*() is dealing with the reference counting. For
>>>> example, a call to pm_runtime_get*() just makes sure that the PM
>>>> domain gets-or-remains powered-on. Could this be a problem from the
>>>> reset-signal point of view?
>>>
>>> It should be safe. From the HW manual I understand the hardware block is something like the
>> following:
>>>
>>>
>>>                   USB area
>>>          +-------------------------+
>>>          |                         |
>>>          | PHY --->USB controller  |
>>> SYSC --> |  ^                      |
>>>          |  |                      |
>>>          | PHY reset               |
>>>          +-------------------------+
>>
>> How USB PWRRDY signal is connected to USB?
>>
>> USB block consists of PHY control, PHY, USB HOST and USB OTG Controller IPs.
>>
>> Is it connected to top level block or connected to each IP's for turning off the USB region power?
>>
>> ? Or Just PHY (HW manual mentions for AWO, the USB PWRRDY signal->USB PHY PWRRDY signal control)?
> 
> As per the update from HW team,
> 
> "SYS_USB_PWRRDY and SYS_PCIE_RST_RSM_B are used when transition from ALL_ON to AWO (or from AWO to ALL_ON).
> 
> Refer to step 8,9 in Table 41.10 Example Transition Flow Outline from ALL_ON Mode to AWO Mode.
> Refer to step 9,10 in Table 41.11 Example Transition Flow Outline from AWO Mode to ALL_ON Mode.

All this is not new information.

From experiments, we need to control these signals also when booting as
intermediary booting application may control and leave it in improper
state. W/o having SYSC signals configured properly there is no chance for
USB to work (it should be the same for PCIe but I haven't explored it yet).

> 
> When turning off USB PHY and PCIe PHY, if they are not controlled, PHY may break."

From experiments, I know this, as this is the reason the SYSC USB PWRRDY
has been implemented in Linux and proposed in this series.

> 
> Do you have any plan to control this power transitions(ALL_ON to AWO and vice versa) in linux? 

As you know, the RZ/G3S USB PM code is already prepared. This is also
configuring these signals when going to suspend/exiting from resume. W/o
configuring properly these signals the USB is not working after a
suspend/resume cycle.

Thank you,
Claudiu Beznea


> Cheers,
> Biju
>  

