Return-Path: <linux-pm+bounces-13432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 502F896A109
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 16:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FBA1F2661B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 14:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1447718800D;
	Tue,  3 Sep 2024 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="JHyIPsv5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E11154BE9
	for <linux-pm@vger.kernel.org>; Tue,  3 Sep 2024 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374771; cv=none; b=Y5K1N/REgkFAytvRC9ijx5v7hs1hcQaULPc4jvNEgjmm5qdx1t9nf3imSVhDEaZmvymRvg6rZdtqkmcUdYdipEkH6rCfYktBjRoxP/ynkcFt8BZgMbEbx0dlxJduOZdmBe2Lgm/n3nQg6xviK2wiwMDqk3mHtZK8ablWoVEl30w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374771; c=relaxed/simple;
	bh=Z4BjGtamMnnJf4aAKLMsPWYV6C8APwGl9my/5sXf9NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=luxWCSupWFSOGiyAjrnqZPEGhtMWzimAiSX8gZu/5YsPSbOpVoMuBZrX4/cfs6LC9g9C1Tkulq9PQGf18jicx6wYIN7Pp2QT0aVoXKFCWy4QAHBI3j2bIWn73XxPBx3X1GMfDGjxDI19ELd2ilV/iKR7bZTs812e/4BU+wQilOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=JHyIPsv5; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f3f07ac2dcso60884741fa.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Sep 2024 07:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725374767; x=1725979567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=10RLo6vQI16ZQLY55PJnQinuqmPpyY7pcz6lIln/dYk=;
        b=JHyIPsv5kMj2R2fk38yqLy96tMjyWMBNMh+wNeh9a6vDgO7Gj4n2csTjZPoCmVP63L
         tC70m7VXjdgudChbPhas/xJH/RnAWZVCeyQ4AQPi6bXJJ9wMIkPYbMev8klcMfOu/SE7
         XTM2ZwJXPt5iyGVGMkkgM+ZnhcazNfNUoCp+V6qbC01m9+P3w2Ta4O1TotLDjrO7Tkpt
         diyuLUsfvnztZAnsuX19BsBouWG4T81Bt2IHfdamQE9THnWL4CjMPsYWg9QWa+Lq28FK
         vPIei3CRtDKRrTC8cVc06NASPdvcamyvjD22fZRn0ZKR2gncd/R4L0n8kKJX1yu2j0s0
         LEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725374767; x=1725979567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10RLo6vQI16ZQLY55PJnQinuqmPpyY7pcz6lIln/dYk=;
        b=UB0lvfrE/pSsqWTNMpVJCavkbyJnfmxORi0sFsTjDciIOB6lGmFO4NbJxx/r4KEqmt
         alZLhN4lQtLQrTgETPNirXR1E6JGMRyUFYX4T6ca/pBHh2ZJx3cen8hLwFR/2Jf6UOuQ
         GpKRIgS1cyazlbJXq1KMIgtDMuldeTps/oFgnpFCydJr+JUMVGgr043MvpzhdyW7qymQ
         pSl+fOJemAM3N2zEW804e8Vf97siajMudYrnjh+W5oGijRK7BcfXTRKUPH4mGDlzSx29
         7xm88JZlXVQc6YMPhcATvU0VtbUKfrm47Z9apH0prMYDo5ZpSDC/jSKE1w7Ect3s6hw1
         3HXg==
X-Forwarded-Encrypted: i=1; AJvYcCUIRmS3PjkibBmNSB2t2jWhDwruZGYQnSGcUsL+/Mp3y0faeNgF6hY9C6MS0UGI9cpZ4vUCe9yG3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRFkqYVanlPZp9ebk8AggR6RqkFXysqddIxSVRHIzNdVOD+VUB
	hvcGHfe99PDoQMAYx88NN4JPgHLGYhFPT+5j50p2/tqAgmoT1be/ov1/TyIf6Ro=
X-Google-Smtp-Source: AGHT+IHBF7/z9fE2IIPqXvT2mCPSoKoEFEBXPrIEjkmEaUhTM3epbcIR3W3mZTjeBzvwo0J9N98xnA==
X-Received: by 2002:a2e:a99b:0:b0:2f1:59ed:879d with SMTP id 38308e7fff4ca-2f61038cbe8mr134852401fa.1.1725374766668;
        Tue, 03 Sep 2024 07:46:06 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a46esm6583009a12.3.2024.09.03.07.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 07:46:05 -0700 (PDT)
Message-ID: <7ffb6419-b8f0-4940-99d9-7779eec9bbb7@tuxon.dev>
Date: Tue, 3 Sep 2024 17:46:03 +0300
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
 <TY3PR01MB11346505565B81AD2894E035586922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
 <TY3PR01MB11346FAC6022C81ED8B9B2DC386932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB11346FAC6022C81ED8B9B2DC386932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03.09.2024 16:09, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>> Sent: Tuesday, September 3, 2024 1:57 PM
> -
>> clk@vger.kernel.org; linux-pm@vger.kernel.org; Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
>>
>>
>>
>> On 03.09.2024 15:37, Biju Das wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>>>> Sent: Tuesday, September 3, 2024 1:26 PM
>>>> To: Biju Das <biju.das.jz@bp.renesas.com>; Ulf Hansson
>>>> <ulf.hansson@linaro.org>
>>>> Cc: vkoul@kernel.org; kishon@kernel.org; robh@kernel.org;
>>>> krzk+dt@kernel.org; conor+dt@kernel.org; p.zabel@pengutronix.de;
>>>> geert+renesas@glider.be; magnus.damm@gmail.com;
>>>> gregkh@linuxfoundation.org; mturquette@baylibre.com;
>>>> sboyd@kernel.org; Yoshihiro Shimoda
>>>> <yoshihiro.shimoda.uh@renesas.com>;
>>>> linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
>>>> linux-kernel@vger.kernel.org; linux- renesas-soc@vger.kernel.org;
>>>> linux-usb@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>>> linux- clk@vger.kernel.org; linux-pm@vger.kernel.org; Claudiu Beznea
>>>> <claudiu.beznea.uj@bp.renesas.com>
>>>> Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas
>>>> RZ/G3S SoC
>>>>
>>>>
>>>>
>>>> On 03.09.2024 15:00, Biju Das wrote:
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Biju Das <biju.das.jz@bp.renesas.com>
>>>>>> Sent: Tuesday, September 3, 2024 12:07 PM
>>>>>> To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>; Ulf Hansson
>>>>>> <ulf.hansson@linaro.org>
>>>>>> Cc: vkoul@kernel.org; kishon@kernel.org; robh@kernel.org;
>>>>>> krzk+dt@kernel.org; conor+dt@kernel.org; p.zabel@pengutronix.de;
>>>>>> geert+renesas@glider.be; magnus.damm@gmail.com;
>>>>>> gregkh@linuxfoundation.org; mturquette@baylibre.com;
>>>>>> sboyd@kernel.org; Yoshihiro Shimoda
>>>>>> <yoshihiro.shimoda.uh@renesas.com>;
>>>>>> linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
>>>>>> linux-kernel@vger.kernel.org; linux- renesas-soc@vger.kernel.org;
>>>>>> linux-usb@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>>>>> linux- clk@vger.kernel.org; linux-pm@vger.kernel.org; Claudiu
>>>>>> Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>> Subject: RE: [PATCH 00/16] Add initial USB support for the Renesas
>>>>>> RZ/G3S SoC
>>>>>>
>>>>>> Hi Claudiu,
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>>>>>>> Sent: Tuesday, September 3, 2024 12:00 PM
>>>>>>> Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas
>>>>>>> RZ/G3S SoC
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 03.09.2024 13:31, Biju Das wrote:
>>>>>>>>>> During boot clr USB PWR READY signal in TF-A.
>>>>>>>>>> STR case, suspend set USB PWR READY signal in TF-A.
>>>>>>>>>> STR case, resume clr USB PWR READY signal in TF-A.
>>>>>>>>> As I said previously, it can be done in different ways. My point
>>>>>>>>> was to let Linux set what it needs for all it's devices to work.
>>>>>>>>> I think the way to go forward is a
>>>>>>> maintainer decision.
>>>>>>>>
>>>>>>>> I agree, there can be n number of solution for a problem.
>>>>>>>>
>>>>>>>> Since you modelled system state signal (USB PWRRDY) as reset
>>>>>>>> control signal, it is reset/DT maintainer's decision to say the
>>>>>>>> final word whether this signal fits in reset
>>>>>>> system framework or not?
>>>>>>>
>>>>>>> I was thinking:
>>>>>>> 1/ Geert would be the best to say if he considers it OK to handle this
>>>>>>>    in Linux
>>>>>>
>>>>>> I agree Geert is the right person for taking SYSTEM decisions,
>>>>>> since the signal is used only during state transitions (Table
>>>>>> 41.6.4 AWO to ALL_ON and 41.6.3 ALL_ON to AWO)
>>>>>
>>>>> One more info, as per [1], this USB PWRRDY signal setting to be before Linux kernel boots.
>>>>
>>>> The "controlled by" column mentions CA-55 on PWRRDY signal control
>>>> line and it is b/w steps "DDR exits from retention mode" and  "clock
>>>> start settings for system bus and peripheral modules". AFAICT, after DDR exists retention mode
>> Linux is ready to run.
>>>
>>> DDR retention exit happens in TF-A and it jumps into reset code where it executes BL2 in TF_A. Bl2
>> checks for warm or cold reset.
>>> If it is warm reset, it sets required minimal clocks/resets and pass
>>> the control to linux by calling the SMC callback handler. Which in turn calls resume(step 11-->14)
>> path.
>>
>> Is this from HW manual or some specific documentation? I'm referring at "resume" == "steps 11-->14"

You branched the discussion, there was at least this question that I've
asked you above that interested me.

>>
>>>
>>> Step 8, Cortex-A55 Exit from DDR retention mode (when using) Setting
>>> for exiting form DDR retention mode Step 9, Cortex-A55 USB PHY PWRRDY
>>> signal control (if use USB) SYS_USB_PWRRDY Step 10, Cortex-A55 PCIe
>>> RST_RSM_B signal control (if use PCIe) SYS_PCIE_RST_RSM_B
>>
>> Note *if use*: how does the TF-A know if USB/PCIe is used by Linux? The documentation mention to set
>> it *if use*. Same note is on ALL_ON to VBATT transition documentation (namely "if using USB", "if
>> using PCIe"). If TF-A will do this it should set this signals unconditionally. It will not be
>> something wrong though. We don't know at the moment what this involves in terms of power consumption,
>> if it means something...
> 
> You mean, you modelled this as reset signal just to reduce power consumption by calling runtime PM
> calls to turn on/off this signal??

In this series it is though a reset control driver.

The internal BSP propose the control of this signal though SMC calls in
each individual USB driver; I think the hardware team was checked for this;
I may be wrong, as I don't have this insight.

As you know, the initial control of these bits in the BSP was though SMC
calls and you propose to have a separate Linux driver to control this after
finding that these registers are accessible in normal world. As a result,
this series, with reset approach, which you were against, but I felt this
was the best way (I know) to describe the hardware and the relation b/w
hardware blocks. To conclude, you initially proposed me internally to have
it in Linux.

To answer your question, the answer is no, I didn't try to just model
something fancy just to be fancy. I did it based on what is proposed in BSP
as this may have been checked with hardware team and I did tests around
this. And considering this best describes the HW and the relation b/w
individual hardware blocks and in this way Linux can have at its hand all
the resources it needs w/o relying on third parties. And from the HW manual
description my understanding was that this is possible. I never said that
this solution is the best. I'm just adding information here as I requested
help from maintainers to guide on the proper direction.

You were adding information to sustain your TF-A idea, too.

> 
> Does will it have any system stability issue as hardware manual says to do it at very early stage
> before starting any clocks/resets?? Have you checked with hardware team?

All the implementation of this is based on what has been proposed on BSP,
the same approach was proposed there, meaning the control of these signals
was done on probe/remove, suspend/resume in Linux.


> 
> Cheers,
> Biju

