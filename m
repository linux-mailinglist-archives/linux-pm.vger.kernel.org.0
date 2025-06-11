Return-Path: <linux-pm+bounces-28444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C82AD4C59
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6F3174039
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 07:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9436F22DFA3;
	Wed, 11 Jun 2025 07:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggpUFbak"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D5C1494A8;
	Wed, 11 Jun 2025 07:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749625987; cv=none; b=hpZlzaaH9zypVepE0GTU/LH4HLl7h4a7OdS4gkw4eGrBOlstw2ZcPRb1RCqMGerH/MT52bm0WRprZIxOBEVjGt30Oo10R3qrjNYJzVzKe1h5+YotQQi0n0840w4Ocl/T9h76U6QGfc1E2bX9XHYk812s531V+f8f8uDHgeLFpB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749625987; c=relaxed/simple;
	bh=BU/YIa0ZINv1YKgZsp2RiDxt77s+yheUVlOxVKJfnoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5Dd/EUntMLFlp8uOCBSboTZ04tmD3/bi8TzillrIwVVolEJWM46mr1Tfz2wC//hG3dV9rTeTKfFJzWZ6MhfNV0+cnyRKHwSD/uKlD6R9pvogz4q5lrI95LgUTRtiDZjlZvKo0oaDwSEsoKm4D3PQZ+ZTT5Jm0ek+PiOfaiRy70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggpUFbak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B3EC4CEEE;
	Wed, 11 Jun 2025 07:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749625986;
	bh=BU/YIa0ZINv1YKgZsp2RiDxt77s+yheUVlOxVKJfnoI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ggpUFbakPeZUwoBwH3YDz6XB4SvzLcIv93QmM46YM+pk7TkxphJmt2AVm4vM4d2I4
	 9YRikKRU79nDuRh9+COoO01myW8eoqucdmNmT0Ss1NCLtMRHoQi+mRpjdkuLVTi3YZ
	 /K9HDQFxYSEToErX9mnDPVlsYlxvYn0ED1ktHAcIeATAh8ADHulLe6C8+BO+qvC+hx
	 cfPS/DEEHI1kDaHTrdbqUBDDirhU5SFwmKEB38XR0R3eA24RPfN19S29wSdIYx2FOX
	 wbcLBHbnidiJVTIn2ldh2CCZKuXrE2VsfLWS6K+Q3cnP9a/+ipMcSUyziEumMJXQnN
	 2mnFPkDF9EUTw==
Message-ID: <61e53f55-394d-422f-8600-9035eac40ff4@kernel.org>
Date: Wed, 11 Jun 2025 09:13:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/2] dt-bindings: thermal: qcom-tsens: make ipq5018
 tsens standalone compatible
To: George Moussalem <george.moussalem@outlook.com>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250611-ipq5018-tsens-v11-0-266566bfd16a@outlook.com>
 <20250611-ipq5018-tsens-v11-1-266566bfd16a@outlook.com>
 <17eaaad4-7713-4149-b66c-1c48db3ab42f@kernel.org>
 <DS7PR19MB8883034308D6642B6B567CAD9D75A@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <DS7PR19MB8883034308D6642B6B567CAD9D75A@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/06/2025 09:06, George Moussalem wrote:
> Hi Krzysztof,
> 
> On 6/11/25 10:51, Krzysztof Kozlowski wrote:
>> On 11/06/2025 07:12, George Moussalem via B4 Relay wrote:
>>> From: George Moussalem <george.moussalem@outlook.com>
>>>
>>> IPQ5018 tsens should not use qcom,tsens-v1 as fallback since it has no RPM
>>> and, as such, deviates from the standard v1 init routine in the driver.
>>> So let's make qcom,ipq5018-tsens a standalone compatible in the bindings.
>>>
>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>> ---
>>>   Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 5 ++++-
>>
>> You just added it recently with the fallback (in v9 of this patchset)
>> and now remove it?
>>
>> And what does it mean it has no RPM? How does it affect the driver? Does
>> fallback work or not?
> 
> IPQ5018 tsens IP is V1, but since it's got no RPM, it follows a 
> different init routine for which VER_1_X_NO_RPM was created just like 
> there is one for V2 without RPM, else the driver wouldn't probe. This 
> was added as part of:
> 
> https://patchwork.kernel.org/project/linux-arm-msm/patch/DS7PR19MB8883C5D7974C7735E23923769DCC2@DS7PR19MB8883.namprd19.prod.outlook.com/
> 
> Since its introduction, I missed updating the bindings which caused a 
> binding issue (as reported by Rob) on the compatible as it expects the 
> qcom,tsens-v1 as a fallback. But we can't use that fallback, so that's 
> why it needs to be a standalone compatible.


So you need Fixes tag and explain what was buggy in previous patch.

> 
>>
>>
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> index 0e653bbe9884953b58c4d8569b8d096db47fd54f..73d722bda8adc2c930edfc3373e6011f19c7c491 100644
>>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> @@ -36,10 +36,13 @@ properties:
>>>                 - qcom,msm8974-tsens
>>>             - const: qcom,tsens-v0_1
>>>   
>>> +      - description: v1 of TSENS
>>
>> So that's still v1... I don't understand.
> 
> As mentioned, the IP is still v1 but with a different init routine in 
> the driver for IP v1 without RPM

OK, just merge it into first enum and drop the description there.

Best regards,
Krzysztof

