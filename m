Return-Path: <linux-pm+bounces-17885-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E459D5226
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B799B244AB
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 17:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020401A3AB8;
	Thu, 21 Nov 2024 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsFr0mZY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A2E155CBF;
	Thu, 21 Nov 2024 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732211452; cv=none; b=nsUZQv7H5H0LKrhWPO027HN3aaOtku6Putmf0dnHqhU5JBP82XHIefMEFBVyCI8QziFc2q93CjtDJf4DzwALGT12Ox9fU8wY1XzlH9pX5kVrasFiIHzthP1IDZ98jYRUFPU0ob6KFMf9eRA73YleuGDaOHraDlpAx1FRjBHWS78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732211452; c=relaxed/simple;
	bh=4Ml+P17lrWm+bXwVe+cHthrWGUIcUifUoH76IJNZ1YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oynqj+PJgCFB3gtW+vRFTJDNSpMpQKsqZsW4s8hVbBa/9BsG5Tv5Clg9tleRujWkb+S2JCDZc1yC9Mi4KgGueBgEWDWjCTeKj6UXUPFw8Ah1029f2RBNUrCKcBwvLDjFhng2ie1va4WeGpms+ILRGGYaXhHeyTY5HB5IvcjvP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsFr0mZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08930C4CECC;
	Thu, 21 Nov 2024 17:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732211452;
	bh=4Ml+P17lrWm+bXwVe+cHthrWGUIcUifUoH76IJNZ1YA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QsFr0mZYpuJrx4aChVRQwZNS8lEhvgGSK7yYP2xJPzD/Aaz2CqDs+30w5LjkWcqKd
	 Y+iR5KbdhypyObdTEvaT9Xgli3JcDrrTSLORELcIsIBRGxBBq+NSmOpMA75fwnO89v
	 wjl1CLasMyxE5BQ/6XIb1A6WOEd5B898mtzPGg+BKdEnEWbEUQRLPLmp8YlFWiEyc5
	 lfppOwCwbpohnW7xTTIunS6sCHTR64yRDG0szKmc2/YwrwTWa2k2JV8VI08gym2Sdl
	 Re90KCIWO9572m0sJZAOcy9kCKTlSlZz8sjLRYV68uDzPEQ6K7G3TCx0ygZ0R0Xc+X
	 smAEXkr7Y/cAA==
Message-ID: <53876db8-4401-481d-8684-af7e135d481e@kernel.org>
Date: Thu, 21 Nov 2024 18:50:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 1/4] dt-bindings: interconnect: Add EPSS L3 compatible
 for SA8775P
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Odelu Kukatla <quic_okukatla@quicinc.com>,
 Mike Tipton <quic_mdtipton@quicinc.com>, Sibi Sankar
 <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241121113006.28520-1-quic_rlaggysh@quicinc.com>
 <20241121113006.28520-2-quic_rlaggysh@quicinc.com>
 <bda810ab-68d8-4265-87c3-a6d021092e62@kernel.org>
 <10e4fd4e-559d-4164-ab94-d5f0a60ffc22@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <10e4fd4e-559d-4164-ab94-d5f0a60ffc22@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/11/2024 18:43, Raviteja Laggyshetty wrote:
> 
> 
> On 11/21/2024 5:23 PM, Krzysztof Kozlowski wrote:
>> On 21/11/2024 12:30, Raviteja Laggyshetty wrote:
>>> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
>>> SA8775P SoCs.
>>
>> This we see from the diff. Explain the hardware, why adding epps-l3-perf.
>>
> The EPSS instance in SA8775P uses PERF_STATE register instead of REG_L3_VOTE to scale L3 clocks.Along with SoC specific compatible, add new generic compatible "qcom,epss-l3-perf" for PERF_STATE register based L3 scaling.

Pasting the same replies as you pasted to others won't solve the
problem. Solve the problem - fix the commit msg.

> 
>>>
>>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>>> ---
>>>  .../devicetree/bindings/interconnect/qcom,osm-l3.yaml         | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>> index 21dae0b92819..042ca44c32ec 100644
>>> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>> @@ -34,6 +34,10 @@ properties:
>>>                - qcom,sm8250-epss-l3
>>>                - qcom,sm8350-epss-l3
>>>            - const: qcom,epss-l3
>>> +      - items:
>>> +          - enum:
>>> +              - qcom,sa8775p-epss-l3
>>> +          - const: qcom,epss-l3-perf
>>
>> I don't understand this change in context of driver. These are the same.
>> Isn't this compatible with sm8250?
>>
> 
> The intention for adding "qcom,epss-l3-perf" generic compatible is to use it for the chipsets which use perf state register for l3 scaling.
> Using generic compatible avoids the need for adding chipset specific compatible in match table.


Not true, specific compatibles used as fallback do the same and is a
preferred way.


> But received comment from konrad to add both SoC-specific and generic compatibles.

I went through the history and don't see anything like that. Point to
the specific email please, if you disagree.

> Dmitry has suggested to update generic comaptibles for sc7280 and sm8250 SoCs, which makes use of perf state registers. 

OK

> It will be done as separate patch series.

No. I expect to see full, correct picture, not half baked patches which
contradict what is in current code.


Best regards,
Krzysztof

