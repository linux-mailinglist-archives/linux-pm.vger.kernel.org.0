Return-Path: <linux-pm+bounces-19821-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5839FDE59
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 10:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914723A1C29
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 09:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612DF70838;
	Sun, 29 Dec 2024 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uc5JJpLE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1320CC148;
	Sun, 29 Dec 2024 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735465818; cv=none; b=WswFaL3bzIjE7dGKdbSnWYWBAgemoe6DFZMWprG94bG1+Q11+RWTEVPXCpbr4W80g9yA/dpASSfapYR/V9atdMgYcolhs8X0bMLBUKZdAVUDhtXrd9wPcHdq2PujQ963kY69eea6Qm839k9q0aqtdWGiNOuDLwC0F/t/2dB/XEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735465818; c=relaxed/simple;
	bh=AvY5jNWA3138rOdPbrpyng+2vYJ1IMDw6Ay/kLMl2Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1emTNx8OAXdLqYtMwyyx6d2ulrvhaTBLSCW6ZzdqzS1AWdT7+RvGcMAy0YGzrVm0NkN9SSjzL8YCKuZIq06s+IvST8/XQKxdwRtOhp9Xk6y2IzrXRUxm/RRAv4egHvAwRkbi4ddYgNXvdp0grC6n36SCqH8QlmSGxA87OESQ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uc5JJpLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABF3C4CED1;
	Sun, 29 Dec 2024 09:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735465817;
	bh=AvY5jNWA3138rOdPbrpyng+2vYJ1IMDw6Ay/kLMl2Ao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uc5JJpLEKq0HP2KTfF7qDC0iYgqYe4aGoppCroCU6YB1hGQEp62T3EQAW7qqMgJN2
	 iNOoFBGBc5iYd5TlMsW4AO76mufvCw6ZgYbDu2ipGLT80ZxQV+TzQ55zu7oQcFInAx
	 rfeVmzIdLHetEur9JTFZ9Lfk+/jO9BJ96+waA2kHIpnTsYgUHvb0CjVR0xiN/iSeMW
	 jyEQ73EjcTn4eOH2XPuSVUH5aIK6wf08XuJaGSDMLskhc+C9LJnUDrEXYVUd7SbpY1
	 qQ1GWKPQVceLwTCmNrebVievVfYtjCM2GGKqfWBt09if5FjoQaRcWXtaBQHumNPiqQ
	 C8Ko+mfT05Hzg==
Message-ID: <ff53d7f7-0103-4e52-ac0a-c05bf4521cd1@kernel.org>
Date: Sun, 29 Dec 2024 10:50:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: platform: Add Huawei Matebook E Go EC
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: andersson@kernel.org, bryan.odonoghue@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org,
 gregkh@linuxfoundation.org, hdegoede@redhat.com,
 heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 konradybcio@kernel.org, krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-usb@vger.kernel.org, nikita@trvn.ru,
 platform-driver-x86@vger.kernel.org, robh@kernel.org, sre@kernel.org
References: <705f52a9-562b-4b17-8b28-ee837b41ea7d@kernel.org>
 <20241228105017.585067-1-mitltlatltl@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241228105017.585067-1-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/12/2024 11:50, Pengyu Luo wrote:
> On Sat, Dec 28, 2024 at 5:54 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 27/12/2024 18:13, Pengyu Luo wrote:
>>> +
>>> +description:
>>> +  Different from other Qualcomm Snapdragon sc8180x sc8280xp based machines,
>>> +  the Huawei Matebook E Go tablets use embedded controllers while others
>>> +  use something called pmic glink which handles battery, UCSI, USB Type-C DP
>>> +  alt mode. Huawei one handles even more, like charging thresholds, FN lock,
>>> +  lid status, HPD events for the USB Type-C DP alt mode, etc.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - huawei,sc8180x-gaokun-ec
>>> +          - huawei,sc8280xp-gaokun-ec
>>
>> sc8180x and sc8280xp are not products of Huawei, so you cannot combine
>> them. Use compatibles matching exactly your device, because I doubt any
>> of us has actual schematics or datasheet of that device.
>>
>>> +      - const: huawei,gaokun-ec
>>
>> How did you get the name?
>>
> 
> From website of Huawei([1]), please search for 'gaokun' here, we can know

Then please explain this in commit msg or bindings description (what is
gaokun).

> this series is called gaokun. Many files from windows indicate more,
> someone fetch drivers from microsoft server([2]), in one of driver archive
> 'OemXAudioExt_HWVE.cab', there are two files, "algorithm_GaoKunGen2.xml"
> "algorithm_GaoKunGen3.xml". And `Gaokun Gen3` print can be found on
> motherboard(someone have the motherboard, I can ask for it later).
> 
> So can I use?
> - enum:
> 	- huawei,gaokun-gen2
> 	- huawei,gaokun-gen3

The internal name?

> 
> Some backgroud:
> There are 3 variants, Huawei released first 2 at the same time.
> Huawei Matebook E Go LTE(sc8180x), codename should be gaokun2.
> Huawei Matebook E Go(sc8280xp@3.0GHz), codename is gaokun3.
> Huawei Matebook E Go 2023(sc8280xp@2.69GHz).

Well, I believe it is still not good choice because we have absolutely
zero insights what is actually there, what else is called gaokun etc.
Especially "gen2" and "gen3" - how can anyone, outside of Huawei, figure
out which is gen3?

Why do people try to decode some vendor naming scheme instead of using
well recognized, public and available naming: the device name?


Best regards,
Krzysztof

