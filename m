Return-Path: <linux-pm+bounces-13400-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80EA969A16
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 12:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095BA1C23467
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 10:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A156A1B9839;
	Tue,  3 Sep 2024 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="hbe4FiQ9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4831AD277
	for <linux-pm@vger.kernel.org>; Tue,  3 Sep 2024 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359128; cv=none; b=bQLUEn7P4Ipx8CgDZh02lDF/mgpF84Ap+25fXZf9YeJLnlOQ4bTrtxaUShslk2OFB7vBMQLGrrTnc7X4cdUwkWM7RXbMBpXVqLCpifKvaUWb24PcDli1bsNqX+9/7eiedmCPxpUjHJauhLkEgD6K7Cero10Q/CfzJarlTGSeFMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359128; c=relaxed/simple;
	bh=Fgey+hZ4JPGo/6NiaNfA8JYGY/v0Tm7r20mcUahfiu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nU0PE361v72cDe83eg90Smg077SuMedUl1ZBP/yRMwaanrj5hwvmXig9pUmQmbd1kccsXjj/f+5b/D0rKvbohJ5v4nxk8uk6Xx7LmxnoAjSd7QxNkR+w/hH2dnryePY1c1HQYaSl/jMK8SoNQs6xTHwfLiROPXz9kIJf1CQZHXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=hbe4FiQ9; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f3f0bdbcd9so60252421fa.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Sep 2024 03:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725359124; x=1725963924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuTSwIl9q9JUC3i2aYAeogOmWxwYrrJ9+YxLTjByK44=;
        b=hbe4FiQ9klHOilXrX7mh+mXhcPY1cGxE1rpEZafYKlD7W6Sbkh1bGtjOtdEc0j1gPh
         b8VyG+QWJD4YKjEsdA7Lp9xOJckJKzS0xIPR5sWcrUe77wtHDf0vlIOSzua/eiHwjNFM
         E55l5Yxe6KSsgP568SCnnwo7M4lLhiXQGLighnLozMjVmlA3aqLR68ZrIhMzUhP/Dh4M
         jmmtDZyG5PqwKmnGcLRO1MUv9moasVN4FY0stM3PA1P9lmru1R38qAP43Hy4L3ti2yTC
         KTPPnBua+1Mfx54XrMoJsqw/87ERYSHv64l3YsFY4uQP/iHTZICssshLuhOhbVAuHfaJ
         Mfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725359124; x=1725963924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YuTSwIl9q9JUC3i2aYAeogOmWxwYrrJ9+YxLTjByK44=;
        b=jvjR/yJSqzM2R3QetST3JCm8x+30PLt+SMxdhGsgjT2eRMS4vF0cP0nD7vQ+eg/Pb1
         TNV0/CtYebokTF9+E7IdBW3fOmuKphs0IKC0z5xDrpro8Rx4uMO2DHtSBTymqZDyDNuL
         L3/ICMCNj21+AuN1r5hkww4l0sGt9p13UrZW7eYNz/c42DuUvgJLox5kDGvSms+JgPo1
         XT03ZIK1juUdQyjIEg7wpFIRoQAN+hnHkKylYxlGwanXCrBQTt9pPjZE8b82jEWfdr9E
         in/uGwGYgJ9rMiO3TMgP+5lsiWlr6k8p52q3Js7QRlxvYcM2gUzKGUBK5pYURabCRHNF
         lQUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+ZOVXQrX/5fbFfSpnIWXPi9vgQJNluyTQnEG/xCAPQ4SCVZkK5myDYQK9BMumgcbQSWXx5+iSqg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8LYQTBXQe1PiincIhXOgq7QDkPIORlTdzzruI3npumsvUkc6I
	b0tTbGPCSvRYGrO1bB43nR7JV6KlHdRaBqfRnyKoFUMGKSbMIsnMTkBiZIrVTzw=
X-Google-Smtp-Source: AGHT+IGZWwpSEYRg2qH2RqcYvPMCJJySduQWh9YhT7sAL+Iohwe2+AkwTjRfrV7dO20ThLaUEJ4qCQ==
X-Received: by 2002:a2e:a7c1:0:b0:2f3:d82b:1955 with SMTP id 38308e7fff4ca-2f636a2be54mr41394781fa.25.1725359124125;
        Tue, 03 Sep 2024 03:25:24 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226cd4bcbsm6343668a12.74.2024.09.03.03.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 03:25:23 -0700 (PDT)
Message-ID: <fbfa9179-2f52-429f-8b69-f7f4064e796b@tuxon.dev>
Date: Tue, 3 Sep 2024 13:25:21 +0300
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
 <5556d176-cca7-492c-ba21-48256d5d6338@tuxon.dev>
 <TY3PR01MB113464D53083F4C8A5DBBA36586922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <590a4fb2-24b2-432b-92db-534c5a52ed0b@tuxon.dev>
 <TY3PR01MB11346505565B81AD2894E035586922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <35dc7414-f5bd-4ed4-bfa1-f723f4f0078c@tuxon.dev>
 <TY3PR01MB11346A4814F83FE296A1DED8886922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB1134648BF51F1B52BFE34DD6D86932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB1134648BF51F1B52BFE34DD6D86932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 03.09.2024 10:18, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: Biju Das
>> Sent: Monday, September 2, 2024 11:48 AM
>> Subject: RE: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
>>
>> Hi Claudiu,
>>
>>> -----Original Message-----
>>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>>> Sent: Monday, September 2, 2024 11:41 AM
>>> Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas
>>> RZ/G3S SoC
>>>
>>>
>>>
>>> On 02.09.2024 12:18, Biju Das wrote:
>>>>>>>> Do you have any plan to control this power transitions(ALL_ON to AWO and vice versa) in linux?
>>>>>>> As you know, the RZ/G3S USB PM code is already prepared. This is
>>>>>>> also configuring these signals when going to suspend/exiting from resume.
>>>>>>> W/o configuring properly these signals the USB is not working after a suspend/resume cycle.
>>>>>> One option is to handle SYSC USB PWRRDY signal in TF-A, if you
>>>>>> plan to handle system transitions
>>>>> there??
>>>>>
>>>>> As I mentioned, the settings in these registers may be changed by
>>>>> intermediary booting
>>> applications.
>>>>> Depending on that, Linux need to control it also on probe for USB
>>>>> to work (it should be the same with PCIe, these signals seems similar from HW manual
>> description).
>>>> You mean system transition settings will be override by U-boot, so Linux needs to restore it
>> back??
>>>
>>> It was talking about booting...
>>
>> I am also referring to boot. Boot starts with TF-A and it has a system state.
>>
>>>
>>> You proposed to handle SYSC signals from TF-A in a discussion about system power transitions:
>>>
>>> "One option is to handle SYSC USB PWRRDY signal in TF-A,  if you plan to handle system transitions"
>>>
>>> (I was guessing the "system transition" statement there refers to
>>> power states transitions, ALL_ON <->
>>> AWO/VBAT)
>>
>> That is correct.
>>
>>>
>>> and I gave the booting process as a counter example: if we handle it
>>> in TF-A it may not be enough as these signals might be changed by intermediary booting applications
>> (e.g., U-Boot).
>>
>> Why should U-boot override, system state signals such as USB PWRREADY? Can you please give an example.
>>
>>>
>>> To conclude, there are 3 scenarios I see where these signals need to
>>> be
>>> handled:
>>> 1/ booting
>>> 2/ suspend to RAM
>>> 3/ driver unbind/bind
>>
>> --> It should be OK as linux is not handling USB PWRREADY signal.
>>
>>>
>>> In case of booting: if we have TF-A to set signals there might be
>>> intermediary booting applications (e.g. U-Boot) that set these signals
>>> also. If it leaves it in improper state and Linux wants to use USB then the USB will not work (if
>> Linux doesn't handle it).
>>
>> That is the problem of U-boot. U-boot should not override system state signals such as USB PWRREADY.
>>
>>>
>>> In case of suspend to RAM: as TF-A is the only application in the
>>> suspend to RAM chain, it should work handling it in TF-A.
>>
>> That is correct, TF-A should handle based on system state.
>>
>>>
>>> In case of unbind/bind: currently we don't know if these signals
>>> introduces any kind of power saving so asserting/de-asserting them in Linux may be useful from this
>> perspective, if any.
>>
>> These are system signals, according to me should not be used in unbind/bind.
>>
>> I may be wrong.
> 
> Just to add the below are the 4 system states (power mode) for this LSI.
> 
> If I understand correctly, we need to configure USB PWRRDY signal
> only when there is a transition from ALL_ON to AWO mode and vice versa.
> as you see on AWO mode only CM-33 is active.
> 
> • ALL_OFF mode: All CPUs and peripheral modules can not be worked.
> • ALL_ON mode: All CPUs and peripheral modules can be worked.
> • AWO mode: Cortex-M33 and peripheral modules in PD_VCC and PD_VBATT domain can be worked.
> • VBATT mode: Only RTC, tamper detection and backup registers can be worked.
> 
> System manager which is controlling both CA-55 and CM-33, will set USB PWRRDY signal
> based on system state.
> 
> Since we don't have system manager for controlling both CA-55 and CM-33
> Probably from CA-55 perspective, TF-A should be sufficient.
> 
> During boot clr USB PWR READY signal in TF-A.
> STR case, suspend set USB PWR READY signal in TF-A.
> STR case, resume clr USB PWR READY signal in TF-A.

As I said previously, it can be done in different ways. My point was to let
Linux set what it needs for all it's devices to work. I think the way to go
forward is a maintainer decision.

Thank you,
Claudiu Beznea

> 
> I am not expert in this area. I may be wrong.
> 
> Maybe we need to get an opinion from Power experts in Linux.
> 
> Cheers,
> Biju

