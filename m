Return-Path: <linux-pm+bounces-13399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235D89699F6
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 12:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4917B1C23221
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 10:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D691AD25C;
	Tue,  3 Sep 2024 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="OFxJCAnc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D4217C9B3
	for <linux-pm@vger.kernel.org>; Tue,  3 Sep 2024 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358790; cv=none; b=lTVXrGi5aXfqI6Rk5S73n3AyXpPVuAwF6EHAJZ7RDdnxonQx7ypPu+zHb13PDhipIyHBUKGN3ENa+ipbiCByISy/bhmXrtBNyXnOimhkt0aXUdyAg/us7q6BrNlywNDt3FyfLFQ8hD6MQN0D04tPyfwQfm4BAZwkNnPmMcYSlcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358790; c=relaxed/simple;
	bh=C8KF0NATt/6MEKo6hjD8oYxBGb+BnkEDDEBROE2tMCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkCQGToe5YYtDgnibE3R5l6jj/QsGtWoNmQzbXQzLk2m9oWXRVcaOxaSQLHP6TrSPz0i1W6OHhTTFkg0CfGGKi+G3xG9qA92VEAwVzQdO6OWu8OwGR3pVJfu1kChdUIO36jXVhnB0/DnMtNpEmewKz37WntSDPiK9kdlKXY2ZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=OFxJCAnc; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52f01b8738dso3667460e87.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Sep 2024 03:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725358787; x=1725963587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJS4mKwDt71f+czvCGcc6KmwF1qHOE0EcsdjnmVJivo=;
        b=OFxJCAncAWZH82ldEgVo3pSwlwXgGZ6kPzJIcnSj0b2oRNk4qg46x0VhvupnrCk97w
         LmIOT0HFm4ZDSTe7IIKcY5rlfUfgTjggUqQLU1IObU8a3uZSgnTOTZwAra0kwd17wyqx
         Hnb4PDBG3NWND+zyFG/j0eaUHKmabelAToIS1nT57HQga7sPC/jSccWAG5gAkT5XjFz7
         m1dQl6Oef4O+40Tqu+mjNXTqOhZcQHvcGJtxy4mTadb6kMsxxGdf5YHWrmANnhmNUDyF
         eGFXbgaywzYAvuEr3bwjQ1jWejN6QWR6BzlaWBRFGG80dRYbQeKEYTNqhStI/mLzTwJd
         uJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725358787; x=1725963587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJS4mKwDt71f+czvCGcc6KmwF1qHOE0EcsdjnmVJivo=;
        b=hqBDwzbDL0nwJCxXw7AJw+4UJ7j1UavIR5OgVO0/fBaKIn4/tIpQlKQnPJYXKmBtl8
         BcXcELoqh9Zx6B22Rl8x4ijupcr+NIsHOEfim9n7+2nU0MAMHfnBl68Y2/auh1Hnv+zA
         15Zy8Wc+SS3mGiHJtCHWh5d9MqrP5JY16FsxjD7psAqxj3K8DYpD8JQzhq3TdPTT+S+q
         IJZ3m4dF6J7zF+sw8U/RuQZ2UhqgAzfadJvPVo+9rj+RG0wvCl3r3LjU9THD7kPiSpL3
         0kgx4jleJfTzHzUQFwE6UfADzRucNkWm5BggB48OazYz52/LiNHz70ZDuW2X2S2goUWZ
         JOWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBR0SudikbjiWFIaINCq8FFkdYEbD1GqYD8O9ikw2NuI+oyfU+UY0De3JYChU3NlHTvRwUiwd3zA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxU14gHRfrqV2IziWAkj/cYJWxRE0UEushl5MJM0SyuYVHEtb6C
	NRw1heRbakWgzoktL/3brJo4T/dauPEkITm2xnMFkv7Bxop6qCIffEYljMaFeQg=
X-Google-Smtp-Source: AGHT+IEls7cIQ+6hQSbZxyc8bV5YfWpE5Og0ZDGcEK0Z3VxswtkW6lt0WU0csWHFdZCyWxXy9FAPkw==
X-Received: by 2002:a05:6512:108c:b0:52e:7125:c70a with SMTP id 2adb3069b0e04-53546b93fd9mr8417306e87.47.1725358786595;
        Tue, 03 Sep 2024 03:19:46 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb0e5sm675067666b.12.2024.09.03.03.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 03:19:46 -0700 (PDT)
Message-ID: <4cb2f788-1ba6-40f6-a48d-1fd2e5293aa8@tuxon.dev>
Date: Tue, 3 Sep 2024 13:19:44 +0300
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
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB11346A4814F83FE296A1DED8886922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02.09.2024 13:47, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>> Sent: Monday, September 2, 2024 11:41 AM
>> Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
>>
>>
>>
>> On 02.09.2024 12:18, Biju Das wrote:
>>>>>>> Do you have any plan to control this power transitions(ALL_ON to AWO and vice versa) in linux?
>>>>>> As you know, the RZ/G3S USB PM code is already prepared. This is
>>>>>> also configuring these signals when going to suspend/exiting from resume.
>>>>>> W/o configuring properly these signals the USB is not working after a suspend/resume cycle.
>>>>> One option is to handle SYSC USB PWRRDY signal in TF-A, if you plan
>>>>> to handle system transitions
>>>> there??
>>>>
>>>> As I mentioned, the settings in these registers may be changed by intermediary booting
>> applications.
>>>> Depending on that, Linux need to control it also on probe for USB to
>>>> work (it should be the same with PCIe, these signals seems similar from HW manual description).
>>> You mean system transition settings will be override by U-boot, so Linux needs to restore it back??
>>
>> It was talking about booting...
> 
> I am also referring to boot. Boot starts with TF-A and it has a system state.
> 
>>
>> You proposed to handle SYSC signals from TF-A in a discussion about system power transitions:
>>
>> "One option is to handle SYSC USB PWRRDY signal in TF-A,  if you plan to handle system transitions"
>>
>> (I was guessing the "system transition" statement there refers to power states transitions, ALL_ON <->
>> AWO/VBAT)
> 
> That is correct.
> 
>>
>> and I gave the booting process as a counter example: if we handle it in TF-A it may not be enough as
>> these signals might be changed by intermediary booting applications (e.g., U-Boot).
> 
> Why should U-boot override, system state signals such as USB PWRREADY? Can you please give an example.

I didn't say *should* but *might* and I was referring to a hypothetical
situation where any used application (bootloader) might trigger this signal
for whatever reason. My point was to let Linux to handle all the settings
that it can do for a particular functionality. The resisters in SYSC
address space controlling these signals are accessible to normal world
compared to others in the SYSC address spaces.

> 
>>
>> To conclude, there are 3 scenarios I see where these signals need to be
>> handled:
>> 1/ booting 
>> 2/ suspend to RAM
>> 3/ driver unbind/bind
> 
> --> It should be OK as linux is not handling USB PWRREADY signal.
> 
>>
>> In case of booting: if we have TF-A to set signals there might be intermediary booting applications
>> (e.g. U-Boot) that set these signals also. If it leaves it in improper state and Linux wants to use
>> USB then the USB will not work (if Linux doesn't handle it).
> 
> That is the problem of U-boot. U-boot should not override system state signals such as USB PWRREADY.

U-Boot can also use USB as well.

> 
>>
>> In case of suspend to RAM: as TF-A is the only application in the suspend to RAM chain, it should work
>> handling it in TF-A.
> 
> That is correct, TF-A should handle based on system state.
> 
>>
>> In case of unbind/bind: currently we don't know if these signals introduces any kind of power saving
>> so asserting/de-asserting them in Linux may be useful from this perspective, if any.
> 
> These are system signals, according to me should not be used in unbind/bind.

It can be done whatever way. I would just prefer to work for all scenarios.

Thank you,
Claudiu Beznea

> 
> I may be wrong.
> 
> Cheers,
> Biju

