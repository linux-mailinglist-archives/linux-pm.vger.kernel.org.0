Return-Path: <linux-pm+bounces-18195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF559DB45C
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 09:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EADAB21B74
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 08:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DD61509BF;
	Thu, 28 Nov 2024 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQF/OHvS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5870213FD86;
	Thu, 28 Nov 2024 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732784162; cv=none; b=dP7uUoJ0U/+g8nvR2up43u1C+tGu1nYjK8lgZUZqmIz3MFk9c28mkcPYfv7qEwsHShjvNzemudf0yRWm/toE1d0mAMPsQMCnhGznag60jpwPfsXV9sslVzwE/jeff/Y3acjlPCNKmbe+mEtsuApx9kFQDutLrS/m8DVueRhjWEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732784162; c=relaxed/simple;
	bh=YWa86xpU5GVMy0wLVUVGSqUpxiLDbWoXZJ2EvOhxffY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPYqdLMHZOZkS5G6A8fNDgEy9NJpRtPigRtay0xIBkUpf+oKir6CDUX2QkP5m1Ne4tsBATh2uIgObcg9LKuUt62Km44XvPM5Gm0TVZgD4S9qMp1HO7hKuW7oeUaCoCf/jfwISjUShtIP9Du6L6bFWKH989pAUjad29+rsVOVN1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQF/OHvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07701C4CECE;
	Thu, 28 Nov 2024 08:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732784161;
	bh=YWa86xpU5GVMy0wLVUVGSqUpxiLDbWoXZJ2EvOhxffY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sQF/OHvSHCEEOQaM3QM2NWPCDZjo1tZesMOhNWaXpBqv5mW3bd+BqKbS65R3TYa3k
	 1tuUWq9aYhXntmlzTLWRXQYPIdiLM0kNqMWVZPkRmikA4CSGpBnhTAy5fbGZ3PGuho
	 YjZiPA5k4l2Zth+vDmTsmWlePh1HJ9rGHhLH+bW55CwP7M718vGjXn8+WbGDglmZkW
	 QczYopAbYD42DObDvoxUtz5dz60enHjLiD/jrYb5+EZkvmiXftPNSAezvveSSG3EqA
	 Y2VvezGGNMzcHFE9kgo9SUrkTFHh39zJopMjxmI2E8UI4oshJNNg3QiAX8OsEuuymN
	 4c6Ca4x2hGDQw==
Message-ID: <057577e0-a0e6-453c-8e14-13fc078d99a6@kernel.org>
Date: Thu, 28 Nov 2024 09:55:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] power: supply: Add STC3117 fuel gauge unit driver
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
 "sre@kernel.org" <sre@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241127151953.29550-1-bhavin.sharma@siliconsignals.io>
 <20241127151953.29550-3-bhavin.sharma@siliconsignals.io>
 <be00dec6-d598-4dea-b608-51ea67b37084@kernel.org>
 <MA0P287MB1178B165FAFE680FDBD14301F2292@MA0P287MB1178.INDP287.PROD.OUTLOOK.COM>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <MA0P287MB1178B165FAFE680FDBD14301F2292@MA0P287MB1178.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/11/2024 09:44, Bhavin Sharma wrote:
> Hi Krzysztof,
>  
> Thank you for your review and feedback.
>  
>>> +struct stc3117_data {
>>> +     struct i2c_client       *client;
>>> +     struct regmap           *regmap;
>>> +     struct delayed_work update_work;
>>> +     struct power_supply     *battery;
>>> +
>>> +     u8 SOCValue[16];
>>> +     int CC_cnf;
>>> +     int VM_cnf;
>>> +     int CC_adj;
>>> +     int VM_adj;
>>> +     int AvgCurrent;
>>> +     int AvgVoltage;
>>> +     int Current;
>>> +     int Voltage;
>>> +     int Temp;
>>> +     int SOC;
>>> +     int OCV;
>>> +     int HRSOC;
>>> +     int Presence;
>>> +     int Battery_state;
>>
>> That's some Windows coding style... You need to clean up everything here
>> to match Linux Coding style.
>  
> Could you clarify what specific changes are required here to align with the Linux
> coding style?


Entire. Go one by one: "Breaking long lines and strings" - not
implemented. "Naming" - not implemented. Then go with every point. You
are making here some sort of shortcut - ignoring coding style, not
reading it and insisting on me to provide you exact things to change.
No, that's way too many things. You are supposed to read the coding style.

>  
> I am not sure what exactly needs to be changed here.
>  
>>> +     data->battery = devm_power_supply_register(&client->dev,
>>> +                                                &stc3117_battery_desc, &psy_cfg);
>>> +     if (IS_ERR(data->battery))
>>> +             dev_err_probe(&client->dev, PTR_ERR(data->battery), "failed to register battery\n");
>>> +
>> You ignored (again!) received comments. In multiple places. Go back to
>> previous email and carefully read commetns.
>  
> Sebastian suggested using dev_err_probe, while you mentioned using dev_err.
> so what should i follow ?


No. That's not true. Read comments again. I am not happy that after
pointing out you still insist and force me to re-iterate the same.
That's my last reply in this matter:

comment was:
"return dev_err_probe(dev, PTR_ERR(stc_sply), "failed to register
battery\n");"

Where do you have "return" statement?

What about all my other comments? You are supposed to reply inline and
acknowledge each of such comment. That's the only way I believe you will
really do what we ask you to do.

> 
>> One more thing:
>>  
>> Please wrap code according to coding style (checkpatch is not a coding
>> style description, but only a tool).
>  
> Could you recommend an example driver from the kernel source tree that 
> follows the expected coding style? This would help me ensure compliance.


`git log -- path` will tell give you the latest drivers..


>  
> Best Regards,
> Bhavin
>  


Trim your replies and do not top-post. All this copied stuff below is
making things just difficult to read.

> 
> 
> 
> 
> 
> 
> 
> ________________________________________
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Wednesday, November 27, 2024 11:54 PM
> To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>; sre@kernel.org <sre@kernel.org>; krzk+dt@kernel.org <krzk+dt@kernel.org>; robh@kernel.org <robh@kernel.org>; conor+dt@kernel.org <conor+dt@kernel.org>
> Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>; linux-pm@vger.kernel.org <linux-pm@vger.kernel.org>; devicetree@vger.kernel.org <devicetree@vger.kernel.org>; linux-


All this must be removed.


Best regards,
Krzysztof

