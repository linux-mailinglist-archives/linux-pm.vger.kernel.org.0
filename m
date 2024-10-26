Return-Path: <linux-pm+bounces-16497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CDF9B1806
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 14:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579FF282D79
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 12:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4371D5AC2;
	Sat, 26 Oct 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGAXZT6D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C78217F54;
	Sat, 26 Oct 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945584; cv=none; b=JjWyXDpgcIEYCDlysscwJA6jX0Otwi2+MvBEbfA4ofM+gfl2oMMTHqZnBZetnPfX0ZemjvbGMqt1IY9KF6Zdy1hL1kmi7Hyo8c38ZchnR9j3tBYfbV4LgYc3g+gSZejoQM3vSajyFU5M1NO24hX0kQE66+ZS9BTPfS+FnKTeaws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945584; c=relaxed/simple;
	bh=W57meclX8lAWf+c8MubzAdivjO+6JkigLOBqPzEu78Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5sfT6uhU9Y45itjIHGAXd8LdfRN04tsDrK+P9yyiqCkmPTvufwZDqILpS0HYjPzRWwHzCimfypxaT/pM4qhA03LCKbrFY58/PYBUjYZ8tQxZJIvzmcB+eFJrtTRkKTci/71Qp8Lpf2tVk0Lo+1XbA7I1O67lmdrpJtPJw7vvk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGAXZT6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE71C4CEC7;
	Sat, 26 Oct 2024 12:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729945584;
	bh=W57meclX8lAWf+c8MubzAdivjO+6JkigLOBqPzEu78Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hGAXZT6DeCcy8Zr9HDpnuBCIyRM3C11gAPzerAJc2LiqJT7epIgBPpPBVRnwUeKPU
	 EQbegMoX5LTva0zakF0lScrctHCAEieYlfps0nBjJfkh/6E27dwcs5LPjrNtDtmF2F
	 Q1GqR0BX09IqD5gOis6eUgL1dHeEBtpfLzFTVQFxoutzOZ0qrdwPX9LNjNCR7oW7fU
	 H9Uz4++fiDEAqciNTtoC9fiAqRF4AXF6ZjBnQsjPMZZw+xNck3jRex+s8RX5odIrEf
	 Y3Ls3LRQQxgcEJGf0WHVRUspvrmkeLrJFk+bSaY6sj5wYkEHOIDdRjALJlU8Cxeplc
	 IUTNB9Vjr9MwQ==
Message-ID: <c47aa9fc-fae5-440f-b7a3-c350cacf4023@kernel.org>
Date: Sat, 26 Oct 2024 14:26:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] interconnect: qcom: Add EPSS L3 support on SA8775P
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_okukatla@quicinc.com,
 quic_mdtipton@quicinc.com
References: <20240904171209.29120-1-quic_rlaggysh@quicinc.com>
 <20240904171209.29120-4-quic_rlaggysh@quicinc.com>
 <c3efb01d-2138-4b79-97a1-653b7bd531d0@kernel.org>
 <bfcc65b2-97a4-4353-a2fd-dce927c53428@quicinc.com>
 <49aa8205-6324-412d-b03d-c2b3f738cc98@kernel.org>
 <6b89de85-58c0-4808-9a33-6ee7dc26611d@quicinc.com>
 <e7ce51a1-97a1-4d54-a1d4-0f6d279a9055@kernel.org>
 <8a8df92d-a8f1-456c-92cb-d0d485f03345@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <8a8df92d-a8f1-456c-92cb-d0d485f03345@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/10/2024 14:24, Konrad Dybcio wrote:
> On 26.10.2024 1:28 PM, Krzysztof Kozlowski wrote:
>> On 25/10/2024 17:38, Raviteja Laggyshetty wrote:
>>>
>>>
>>> On 9/6/2024 10:00 PM, Krzysztof Kozlowski wrote:
>>>> On 06/09/2024 17:32, Raviteja Laggyshetty wrote:
>>>>>
>>>>> On 9/4/2024 11:52 PM, Krzysztof Kozlowski wrote:
>>>>>> On 04/09/2024 19:12, Raviteja Laggyshetty wrote:
>>>>>>> +
>>>>>>>  static const struct qcom_osm_l3_desc epss_l3_l3_vote = {
>>>>>>>  	.nodes = epss_l3_nodes,
>>>>>>>  	.num_nodes = ARRAY_SIZE(epss_l3_nodes),
>>>>>>> @@ -284,6 +307,10 @@ static const struct of_device_id osm_l3_of_match[] = {
>>>>>>>  	{ .compatible = "qcom,sm8150-osm-l3", .data = &osm_l3 },
>>>>>>>  	{ .compatible = "qcom,sc8180x-osm-l3", .data = &osm_l3 },
>>>>>>>  	{ .compatible = "qcom,sm8250-epss-l3", .data = &epss_l3_perf_state },
>>>>>>> +	{ .compatible = "qcom,sa8775p-epss-l3-cl0",
>>>>>>> +	  .data = &epss_l3_perf_state },
>>>>>> Don't grow it but express compatibility.
>>>>> ok. Will rename compatible from "qcom,sa8775p-epss-l3-cl0" to "qcom,sa8775p-epss-l3".
>>>>
>>>> This won't solve the problem. You still grow the table, right?
>>>
>>> Falling back to "qcom,epss-l3" won't work because we need to vote into perf state register.
>>> I am introducing a new fallback compatible "qcom,epss-l3-perf" for perf voting, which can be used for upcoming qcs8300.
>>
>> Maybe, no clue, this was 1.5 months ago. I don't have original patches
>> in the inbox anymore.
>>
>> Just choose something sensible following writing bindings guideline.
> 
> You can see that qcom,sm8250-epss-l3 uses the same match data, so that
> sounds like a good fit

Yep, so probably this was obvious to me when I wrote above comment and I
just don't get why fallbacking to qcom,sa8775p-epss-l3...

Best regards,
Krzysztof


