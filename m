Return-Path: <linux-pm+bounces-17099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D4F9C01AF
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 11:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0AF1C219EC
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 10:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A4E1EABB4;
	Thu,  7 Nov 2024 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YHkQTghs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD231E9094
	for <linux-pm@vger.kernel.org>; Thu,  7 Nov 2024 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973613; cv=none; b=h6jdzOPyoysZDhzGasC6i50WMqbqRMdzic1G2oHrChnfQwap6L2jufULOwxWHTtL1REdkGHHflgXFNzvXF6zRy7/7FFfXocGz13mldYZv7LB2UzyYg21KZL8jQYDGSMiADKhee9E2WjOZMRocT9n+ioGB3bSrf0IPIZfPHqNUIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973613; c=relaxed/simple;
	bh=TRanJs9ePaxX/riCnO0so01k5BCuXb4pkZrMsFxRULg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XXNSL/y7DZMyOLnoar6fVScEwFlfLsh4FeftdsfxYDHh6VZRhhRpkIKyzBzhnOhl/Pi/datAY2uPFymW7Up6GNheA6jw5+Q6BG5DoJeuHZgQ2qoStrxaYIWWZb++XcpFJKwwZiV6gET/rWGKfiDQCPHCGojzly/+bKB7SNzdulA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YHkQTghs; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so624774f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2024 02:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730973609; x=1731578409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R02EDs+did3sWf/l/M/xZDeb+Ibpap6rP6djlTEoJvs=;
        b=YHkQTghsBm8V784J7+Uy1a9e45npNlPTkNMHwKGvvccALUdtY7Y3DSgvLv6t2CoSR9
         iDGQfJSo2WZQKzkCvec5xreljkCLVEiPkDsnoEP1cKWVrI3cWzIxkLtLSdgk7W4hMjb7
         IHvXrPpdAGAWAg7dPI+TwdQcUS3trnVTbCARUyqv1KRGEniQnES5K5Xjo368fGR7V5X4
         8d3KqDTQVT2kVteDXmwsmP4h2cl2BusSTE2ulxbkq/84qVBqaFpNc0kJ5Z064/n+0mLW
         aaPiS+lYG1kk9yMak5DbiVrHlbIFM2nvmAOJi8lEhQH6bkNWeYgnISB6KgZ2kde9SCtE
         +aUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730973609; x=1731578409;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R02EDs+did3sWf/l/M/xZDeb+Ibpap6rP6djlTEoJvs=;
        b=hoSx8bYPsCUeT3xjuhVBFGf5/zjZjkSyoW0toxkZQ7BPV7f40bnSj8Z+9hrjB40pKR
         OaG/bZQukJBwpNcRY+yhXHNas0JHAW5Ly1zcaM+y81JD+4PYPFzH4F//fQWLIHkCuPAU
         pVEfcMn8O0ZPUnmiiMiGeV7TWUaVlklkYQM8PvfjxcKziKc4ijaMyfGk1Ej9hidlQ7ca
         flJEb7WBRzx6xEhCE6w+v/OwbvrIamqOZ164aVyTG3tFQYc0anLU9fsi/0IAOICXVRQW
         Oo4eSkJU+/7vI5OGRPWE/vDw5K/YvmZaWCyFoOvQvGctXO0JkdVoJryuhACiQETax9uj
         9IgA==
X-Forwarded-Encrypted: i=1; AJvYcCXHVbHYa4oiB8R/yikELhgAeb3sUhwJVS+uqu+66cEJfYwiMb38waO71kmkVVsEoEsofH+KSNtpdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsUcTYBE/pSJcdF7WwCuOm82iuGuuWfHf0UTKKFZP4OiEhZYFM
	UAGmhwiqZjV1TerHYbT341bGdoFit+9oHjTLD5FvYdy9BZibNzh5i9ZZJi8nQeg=
X-Google-Smtp-Source: AGHT+IEffb2xJDgmV6dLSuFyO1fmxJvqSnlcu1KUumgCd4EHyMTsYXx5V2d5rZ79w6rYl9OZ0LDdOw==
X-Received: by 2002:a5d:47ac:0:b0:37d:48f2:e749 with SMTP id ffacd0b85a97d-381c7a4636cmr23082414f8f.10.1730973608986;
        Thu, 07 Nov 2024 02:00:08 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5871sm17547405e9.37.2024.11.07.02.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 02:00:07 -0800 (PST)
Message-ID: <91916297-8156-44d9-b56f-9a67e651a9a4@tuxon.dev>
Date: Thu, 7 Nov 2024 12:00:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
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
 <35dc7414-f5bd-4ed4-bfa1-f723f4f0078c@tuxon.dev>
 <TY3PR01MB11346A4814F83FE296A1DED8886922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB1134648BF51F1B52BFE34DD6D86932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <fbfa9179-2f52-429f-8b69-f7f4064e796b@tuxon.dev>
 <TYCPR01MB11332EF1A8D064C491D8F261286932@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <f7c57e76-b890-491f-880d-62d060b7b31e@tuxon.dev>
 <TYCPR01MB11332BE2EDB318950B9C7B54C86932@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <TY3PR01MB113469FC8A9F49D9B1FA432FD86932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <0b73544b-0253-43b9-b631-6578b48eaca8@tuxon.dev>
 <TY3PR01MB1134689573A785E91A9041E1886932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5bcdc677-e61e-4312-a19b-57b4600685d3@tuxon.dev>
 <TY3PR01MB1134690F9D37E3BB4814D864386932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <d64243fe-48ea-4cb5-b6d6-e9f820e1b8a3@tuxon.dev>
In-Reply-To: <d64243fe-48ea-4cb5-b6d6-e9f820e1b8a3@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, all,

On 03.09.2024 17:48, claudiu beznea wrote:
> 
> 
> On 03.09.2024 16:45, Biju Das wrote:
>> Hi Claudiu,
>>
>>> -----Original Message-----
>>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>>> Sent: Tuesday, September 3, 2024 1:57 PM
>>> Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
>>>
>>>
>>>
>>> On 03.09.2024 15:37, Biju Das wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>>>>> Sent: Tuesday, September 3, 2024 1:26 PM
>>>>> To: Biju Das <biju.das.jz@bp.renesas.com>; Ulf Hansson
>>>>> <ulf.hansson@linaro.org>
>>>>> Cc: vkoul@kernel.org; kishon@kernel.org; robh@kernel.org;
>>>>> krzk+dt@kernel.org; conor+dt@kernel.org; p.zabel@pengutronix.de;
>>>>> geert+renesas@glider.be; magnus.damm@gmail.com;
>>>>> gregkh@linuxfoundation.org; mturquette@baylibre.com;
>>>>> sboyd@kernel.org; Yoshihiro Shimoda
>>>>> <yoshihiro.shimoda.uh@renesas.com>;
>>>>> linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
>>>>> linux-kernel@vger.kernel.org; linux- renesas-soc@vger.kernel.org;
>>>>> linux-usb@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>>>> linux- clk@vger.kernel.org; linux-pm@vger.kernel.org; Claudiu Beznea
>>>>> <claudiu.beznea.uj@bp.renesas.com>
>>>>> Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas
>>>>> RZ/G3S SoC
>>>>>
>>>>>
>>>>>
>>>>> On 03.09.2024 15:00, Biju Das wrote:
>>>>>>
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Biju Das <biju.das.jz@bp.renesas.com>
>>>>>>> Sent: Tuesday, September 3, 2024 12:07 PM
>>>>>>> To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>; Ulf Hansson
>>>>>>> <ulf.hansson@linaro.org>
>>>>>>> Cc: vkoul@kernel.org; kishon@kernel.org; robh@kernel.org;
>>>>>>> krzk+dt@kernel.org; conor+dt@kernel.org; p.zabel@pengutronix.de;
>>>>>>> geert+renesas@glider.be; magnus.damm@gmail.com;
>>>>>>> gregkh@linuxfoundation.org; mturquette@baylibre.com;
>>>>>>> sboyd@kernel.org; Yoshihiro Shimoda
>>>>>>> <yoshihiro.shimoda.uh@renesas.com>;
>>>>>>> linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
>>>>>>> linux-kernel@vger.kernel.org; linux- renesas-soc@vger.kernel.org;
>>>>>>> linux-usb@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>>>>>> linux- clk@vger.kernel.org; linux-pm@vger.kernel.org; Claudiu
>>>>>>> Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>> Subject: RE: [PATCH 00/16] Add initial USB support for the Renesas
>>>>>>> RZ/G3S SoC
>>>>>>>
>>>>>>> Hi Claudiu,
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>>>>>>>> Sent: Tuesday, September 3, 2024 12:00 PM
>>>>>>>> Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas
>>>>>>>> RZ/G3S SoC
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 03.09.2024 13:31, Biju Das wrote:
>>>>>>>>>>> During boot clr USB PWR READY signal in TF-A.
>>>>>>>>>>> STR case, suspend set USB PWR READY signal in TF-A.
>>>>>>>>>>> STR case, resume clr USB PWR READY signal in TF-A.
>>>>>>>>>> As I said previously, it can be done in different ways. My point
>>>>>>>>>> was to let Linux set what it needs for all it's devices to work.
>>>>>>>>>> I think the way to go forward is a
>>>>>>>> maintainer decision.
>>>>>>>>>
>>>>>>>>> I agree, there can be n number of solution for a problem.
>>>>>>>>>
>>>>>>>>> Since you modelled system state signal (USB PWRRDY) as reset
>>>>>>>>> control signal, it is reset/DT maintainer's decision to say the
>>>>>>>>> final word whether this signal fits in reset
>>>>>>>> system framework or not?
>>>>>>>>
>>>>>>>> I was thinking:
>>>>>>>> 1/ Geert would be the best to say if he considers it OK to handle this
>>>>>>>>    in Linux
>>>>>>>
>>>>>>> I agree Geert is the right person for taking SYSTEM decisions,
>>>>>>> since the signal is used only during state transitions (Table
>>>>>>> 41.6.4 AWO to ALL_ON and 41.6.3 ALL_ON to AWO)
>>>>>>
>>>>>> One more info, as per [1], this USB PWRRDY signal setting to be before Linux kernel boots.
>>>>>
>>>>> The "controlled by" column mentions CA-55 on PWRRDY signal control
>>>>> line and it is b/w steps "DDR exits from retention mode" and  "clock
>>>>> start settings for system bus and peripheral modules". AFAICT, after DDR exists retention mode
>>> Linux is ready to run.
>>>>
>>>> DDR retention exit happens in TF-A and it jumps into reset code where it executes BL2 in TF_A. Bl2
>>> checks for warm or cold reset.
>>>> If it is warm reset, it sets required minimal clocks/resets and pass
>>>> the control to linux by calling the SMC callback handler. Which in turn calls resume(step 11-->14)
>>> path.
>>>
>>> Is this from HW manual or some specific documentation? I'm referring at "resume" == "steps 11-->14"
>>>
>>>>
>>>> Step 8, Cortex-A55 Exit from DDR retention mode (when using) Setting
>>>> for exiting form DDR retention mode Step 9, Cortex-A55 USB PHY PWRRDY
>>>> signal control (if use USB) SYS_USB_PWRRDY Step 10, Cortex-A55 PCIe
>>>> RST_RSM_B signal control (if use PCIe) SYS_PCIE_RST_RSM_B
>>>
>>> Note *if use*: how does the TF-A know if USB/PCIe is used by Linux? The documentation mention to set
>>> it *if use*. Same note is on ALL_ON to VBATT transition documentation (namely "if using USB", "if
>>> using PCIe"). If TF-A will do this it should set this signals unconditionally. It will not be
>>> something wrong though. We don't know at the moment what this involves in terms of power consumption,
>>> if it means something...
>>
>> IIUC,
>> The only information we have is,
>>
>> "SYS_USB_PWRRDY and SYS_PCIE_RST_RSM_B are used when transition from ALL_ON to AWO (or from AWO to ALL_ON).
>> "When turning off USB PHY and PCIe PHY, if they are not controlled, PHY may break"
>>
>> ALL_ON to AWO_MODE state transition: 
>> USB/PCIe are part of PD_ISOVCC power domain and before turning PD_ISOVCC to off,
>> we need to set USBPWRRDY signal.
>>
>> AWO_MODE to ALL_ON state transition:
>>
>> Turn on PD_ISOVCC first, then clr USBPWRRDY signal for USB usage in linux.
>>
>> Maybe we need to ask hw team, exact usage of USBPWRRDY signal other than state transition.
> 
> As you may already know, this is open for quite some time and is ongoing.

I got more clarification about the USB PWRRDY signal from the HW team.

The conclusion is that the USB PWRRDY is a signal controlled by SYSC
controller that goes to the USB PHY and it tells the USB PHY if the power
supply is ready or not.

In the diagram at [1] the PWRRDY signal need to be asserted/de-asserted
before/after G6, G7, G8, G9, G10 signals.

Philipp,

Can you please confirm that you don't want this signal to be implemented as
a reset signal to know clearly your input on it? I would like to start
looking for another approach in that case.

Thank you,
Claudiu Beznea

[1] https://pasteboard.co/0a1zYBFZXZVb.png

> 
>>
>> Cheers,
>> Biju
>>
>>

