Return-Path: <linux-pm+bounces-27996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97951ACC32E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 11:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570583A4211
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 09:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9920E281379;
	Tue,  3 Jun 2025 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srDdJSkP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6264720C482;
	Tue,  3 Jun 2025 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748943296; cv=none; b=XLOd/czUvTcBRgWLLwPt6uH/TvwjvFfRY1DW56+3iBf8Pxcca3JX8lKDzJ2cWVzy2LpJCc7rFALw1SzKyqszsQfROhEhXmjo5orB3AwAPstRR3YHDMSUErsKn0R/B5ECm0tSr9sN2yImE2zdL8ab8+5pJ4TjhOTt51tIbZFLdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748943296; c=relaxed/simple;
	bh=SzH0hLM90X54zNxf3UOoXPCdHZQgrQSH/0xF6n5l+Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YA2ZVJXWSK10wSzD+4qatG9Ko7LE4b5QPY9pxJeipeCWNtWtZf3CUufZS3cCspvxin6POSMF9gayHacz/7jyj9zTtAxtmM6eRLLZZW3AxHMFe2wGbHtSRs3tZ8rlYCA+gp5uvGeMnYXjhtXEMTwQ773+2TuV5sEIS0/iTKdc11Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srDdJSkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937F4C4CEEF;
	Tue,  3 Jun 2025 09:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748943293;
	bh=SzH0hLM90X54zNxf3UOoXPCdHZQgrQSH/0xF6n5l+Ew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=srDdJSkP2e3NBR54PwK7tPn+pnEmkbWWCDYUriloqP4gJ2ngGGPBIjVANul9CvKVa
	 txe2qIZAn1DlaTiT1nsubDpoMA/bLrJc950ORVoD2rOchfo8bL8QAphXLynhbm/iTv
	 AZnghSR8pEduFhjQrXNwYOtMk4ZXEJym1QFN3RgWW0/IFccZ58f4KVwkDBRBeoyv5d
	 PLdV0J/xYV1l5DCt8s81ZfTvf5c5jatDpX1EhYV5rSXCWvE/t4l8f55pwRrdpORxCx
	 1yQ0SWuIzn1SdrSGzA/GxN1fewLgF+WsB/lWDQmuiGJ9KMzI7MTIOM+eesAZaG+ylj
	 ZXf/tJNFPvJvg==
Message-ID: <898e998f-11b2-4b08-9580-263046c0615a@kernel.org>
Date: Tue, 3 Jun 2025 11:34:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] dt-bindings: soc: qcom: pmic-glink: Move X1E80100
 out of fallbacks
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
 Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
 David Collins <david.collins@oss.qualcomm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 kernel@oss.qualcomm.com, devicetree@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
 <20250530-qcom_battmgr_update-v2-6-9e377193a656@oss.qualcomm.com>
 <4e093835-af3b-4a84-b42f-fa7d3a6f60a1@kernel.org>
 <14cba9ae-e3bb-46e8-a800-be5d979b2e06@oss.qualcomm.com>
 <b07200a2-4e7b-480e-a683-d116e7da8de8@kernel.org>
 <c4be4b97-6104-45e3-b555-6691e369c3a4@oss.qualcomm.com>
 <bcf487c9-e522-44a3-b094-daf98823a195@kernel.org>
 <a840aa80-75ef-4527-bc17-226ba5157a85@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <a840aa80-75ef-4527-bc17-226ba5157a85@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/06/2025 09:41, Fenglin Wu wrote:
> 
> On 6/3/2025 3:06 PM, Krzysztof Kozlowski wrote:
>> On 03/06/2025 08:59, Fenglin Wu wrote:
>>> On 6/3/2025 2:47 PM, Krzysztof Kozlowski wrote:
>>>> On 03/06/2025 08:42, Fenglin Wu wrote:
>>>>> On 6/2/2025 3:40 PM, Krzysztof Kozlowski wrote:
>>>>>> On 30/05/2025 09:35, Fenglin Wu via B4 Relay wrote:
>>>>>>> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>>>>>>>
>>>>>>> Move X1E80100 out of the fallbacks of SM8550 in pmic-glink support.
>>>>>> Why?
>>>>>>
>>>>>> Do not describe what you do here, it's obvious. We see it from the diff.
>>>>>>
>>>>>>
>>>>>> Best regards,
>>>>>> Krzysztof
>>>>> Previously, in qcom_battmgr driver, x1e80100 was specified with a match
>>>>> data the same as sc8280xp, also sm8550 was treated a fallback of sm8350
>>>>> without the need of a match data.
>>>>>
>>>>> In ucsi_glink driver, sm8550 had a match data and x1e80100 was treated
>>>>> as a fallback of sm8550. There was no issues to make x1e80100 as a
>>>>> fallback of sm8550 from both qcom_battmgr and ucsi_glink driver perspective.
>>>>>
>>>>> In patch [5/8] in this series, in qcom_battmgr driver, it added charge
>>>>> control functionality for sm8550 and x1e80100 differently hence
>>>>> different match data was specified for them, and it makes x1e80100 ad
>>>>> sm8550 incompatible and they need to be treated differently.
>>>> So you break ABI and that's your problem to fix. You cannot make devices
>>>> incompatible without good justification.
>>> I would say x1e80100 and sm8550 are different and incompatible from a
>>> battery management firmware support perspective. The x1e80100 follows
>>> the sc8280xp as a compute platform, whereas the sm8550 follows the
>>> sm8350 as a mobile platform.
>> Not correct arguments for compatibility.
>>
>>> The difference between them was initially ignored because the sm8550
>>> could use everything that the sm8350 has, and no match data needed to be
>>> specified for it. However, now the sm8550 has new features that the
>>> sm8350 doesn't have, requiring us to treat it differently, thus the
>>> incompatibility was acknowledged.
>> So they are perfectly compatible.
>>
>> I really do not understand what we are discussing here. Explain in
>> simple terms of DT spec: what is incompatible that SW cannot use one
>> interface to handle the other?
> 
> 1. x1e80100 was a fallback of sc8280xp, it used "sc8280xp_bat_psy_desc" 


No, that's not true. Read the binding again:

              - qcom,x1e80100-pmic-glink
           - const: qcom,sm8550-pmic-glink

No fallback to sc8280xp.


> when registering the power supply device.
> 
> 2. sm8550 was a fallback of sm8350, and they all used 


Also not true. The remaining fallback is not sm8350.


> "sm8350_bat_psy_desc" when registering the power supply device.
> 
> 3. x1e80100 and sm8550 they are incompatible as they are using different 
> data structure of "xxx_bat_psy_desc"  and other “psy_desc" too, such as, 
> ac/usb/wls.

Look at the driver and bindings now - they are compatible. It looks like
you made it incompatible and now you claim the "they are incompatible".
No, you did it. Look at the driver.



> 
> 4. For charge control functionality, it's only supported in the battery 
> management firmware in x1e80100 and sm8550 platforms. And the change in 
> battmgr driver (patch [5/8]) adds the support by using 2 additional 
> power supply properties, which eventually need to be added in the 
> "properties" data member of "xxx_bat_psy_desc" when registering power 
> supply devices. Hence, "x1e80100_bat_psy_desc" and "sm8550_bat_psy_desc" 
> are created and used separately when registering power supply device 
> according to the "variant" value defined in the match data.
> 
> The main code change is in [5/8], I am pasting a snippet which might 
> help to explain this a little bit:
> 
> -       if (battmgr->variant == QCOM_BATTMGR_SC8280XP) {
> -               battmgr->bat_psy = devm_power_supply_register(dev, 
> &sc8280xp_bat_psy_desc, &psy_cfg);
> +       if (battmgr->variant == QCOM_BATTMGR_SC8280XP || 
> battmgr->variant == QCOM_BATTMGR_X1E80100) {
> +               if (battmgr->variant == QCOM_BATTMGR_X1E80100)
> +                       psy_desc = &x1e80100_bat_psy_desc;
> +               else
> +                       psy_desc = &sc8280xp_bat_psy_desc;
> +
> +               battmgr->bat_psy = devm_power_supply_register(dev, 
> psy_desc, &psy_cfg);
>                  if (IS_ERR(battmgr->bat_psy))
>                          return dev_err_probe(dev, 
> PTR_ERR(battmgr->bat_psy),


This explains nothing to me. I think you did not get my questions at all
and just want to push whatever you have in drivers.

Such ping pongs are just tiring, so go back to my previous email, read
it carefully and try harder to understand what compatibility means.


NAK, you are affecting the users and ABI with justification "I make it
now incompatible, so it is incompatible".

Best regards,
Krzysztof

