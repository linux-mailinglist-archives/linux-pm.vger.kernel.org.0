Return-Path: <linux-pm+bounces-17886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3B29D5223
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4381F227C8
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 17:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32A71B5ED2;
	Thu, 21 Nov 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3wUhqNB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3B71A2C0B;
	Thu, 21 Nov 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732211497; cv=none; b=UcdWmknP9EMQfY70WCHnLlk24KZLdLIkJD5VNmA8yjOZqgLnZjh/Ko58walpRiaXk865LIcjErl0RTAOTNb9YMaR0jI+Cp561Vu6JPq9EAAWKWvdAtem3A0dufGUgdT1lrbE/YxycVN6nd2F3ujPyDqJKNVQ88Vd+2tpui80a0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732211497; c=relaxed/simple;
	bh=tIyuKwVzYt4lv1djHoHrdJQEtZZee9KgbdgMNNR+LoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RE12UIdKGIA8Ps4V0SNzeCKY3U9jVQNkgVLiCo4tgkOlp2vXdn3XC4BFWSH2Bu4X3ZYCMRg3oPYlJHrzDDZCdKFsTWlxpVYXW71lXVUy3zT0FtMfMURkpcBKl4zKRBMNuU1KhuT6csxHl+3sLFlM4/rKNHg/b+4idtNVCauBvMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3wUhqNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FE9C4CECC;
	Thu, 21 Nov 2024 17:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732211497;
	bh=tIyuKwVzYt4lv1djHoHrdJQEtZZee9KgbdgMNNR+LoA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t3wUhqNBBq5LJPJPcb8miJOJby+P/k+qu9k7h89ULs4g2GONuQ9T5D7LF18wiZOkh
	 WLg+d70/1AjCtJ5bPk3vrLPUEJSAORq/nJ3e8v0o9RXX2G8d6LygpX5M5PnhTFZ7qY
	 sI4v0J07OI/G8fJ4550ozH96AQEOnyZHIHdKpX4TvaukSa3pzmCvfshMeSNZRwoNzV
	 7k7sRxpmsIKwgrjcwSDo2ttW67mGIs0LIdd1nze7WMEa+m/M2LYSeghoVeUYKsLKHj
	 1DL2mvY9CyRwUH+LqYaNoz8j3ga+awp/BjxsvdscV4i+NWtNhKDTDXKyrHPUkj/Ymp
	 yNYxxiXQaPOEQ==
Message-ID: <19dce115-097d-43f1-97d6-e80f0578cf91@kernel.org>
Date: Thu, 21 Nov 2024 18:51:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/4] arm64: dts: qcom: sa8775p: add EPSS l3
 interconnect provider
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
 <20241121113006.28520-3-quic_rlaggysh@quicinc.com>
 <2b72c05e-eeb3-4c27-99b0-66bec8adba7c@kernel.org>
 <41977702-51da-42d3-ad18-0d77ba9c8b5b@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <41977702-51da-42d3-ad18-0d77ba9c8b5b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/11/2024 18:49, Raviteja Laggyshetty wrote:
> 
> 
> On 11/21/2024 5:24 PM, Krzysztof Kozlowski wrote:
>> On 21/11/2024 12:30, Raviteja Laggyshetty wrote:
>>> Add Epoch Subsystem (EPSS) L3 interconnect provider node on SA8775P
>>> SoCs.
>>>
>>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>>> index 9f315a51a7c1..dd7207eb3616 100644
>>> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>>> @@ -10,6 +10,7 @@
>>>  #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
>>>  #include <dt-bindings/clock/qcom,sa8775p-gpucc.h>
>>>  #include <dt-bindings/dma/qcom-gpi.h>
>>> +#include <dt-bindings/interconnect/qcom,osm-l3.h>
>>>  #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
>>>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>>>  #include <dt-bindings/firmware/qcom,scm.h>
>>> @@ -4282,6 +4283,15 @@ rpmhpd_opp_turbo_l1: opp-9 {
>>>  			};
>>>  		};
>>>  
>>> +		epss_l3_cl0: interconnect@18590000 {
>>
>>
>> Drop unused label.
>>
> This will be used by DCVS driver for getting the interconnect path.

Fine then.


Best regards,
Krzysztof

