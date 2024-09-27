Return-Path: <linux-pm+bounces-14877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B15988444
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 14:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D0A1C220E9
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 12:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA7918C033;
	Fri, 27 Sep 2024 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoDp0xHJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF4418BC33;
	Fri, 27 Sep 2024 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439951; cv=none; b=lryV6eaznApwUNTaQI0Vxke2I2/8g+WpEEgYK/Lutq9iVrTfN8xCW/eaew1GChl2m6tlQY69x62toCaidklQjwlRN14j8JcOn3lzofUKG7tWrTMOrJ+QlAkxKpPUthV+AY5qqX0gmV9JXhkBC+u7fmtv0PL6C3205z1yHOvrHVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439951; c=relaxed/simple;
	bh=5/aTywjszcFdL4TiAfPImD5MRBzQIeR2ebX5yRMrvjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8Xowo9EN0cbw1lSXN4DUHXqbKZxYcuxgGaRtQW3D1BmiwcTJAU5MZWDyiapSThYav2hyrT5OKzHLADPkzAjNUIf32QCP6XU6iXaQu8xzO+k6KIXYT646MZn9gSYrjkiZSE1FsoJL+y59yirQYoFZDYXLU21lL9fblLMSft9zR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoDp0xHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D74EC4CEC4;
	Fri, 27 Sep 2024 12:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727439950;
	bh=5/aTywjszcFdL4TiAfPImD5MRBzQIeR2ebX5yRMrvjI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OoDp0xHJdzDLGjSJSXiZGs2QRci7oNMIVJEYl4ArK0EOAqe/7/0RhBVsrWSIhNbKf
	 9AIztz3QJKvh6bP/e6Q5Fp3mtyVPFN9JrYnodkaiHnZdFVUY9iY80SQ7KgBNN48lVy
	 5aXpoP09tOgIIoDcp9OUUh1U1O2CgxZICmAC7A9lgLtwvBILO3sxds6WQZwd9NGkkT
	 HmRoQs0fEqvOmIdfox/4ScxUkfpM7m79YGZFHFZ6omRHxmVLw0t1fEYKXvr2HQDdCD
	 st1X7Z0pVr7C8drMlpyGAXoAmDV2t5tQvpQmq0zzDzqvOpxgeTF1d7pplbQTMOaWci
	 F9e2y7EndWJ2A==
Message-ID: <6da6159f-10e0-42be-8215-1071cb22e25d@kernel.org>
Date: Fri, 27 Sep 2024 14:25:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: power: qcom,rpmpd: document qcs615 RPMh
 power domains
To: Tingguo Cheng <quic_tingguoc@quicinc.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, quic_fenglinw@quicinc.com,
 quic_tingweiz@quicinc.com
References: <20240920-add_qcs615_powerdomains_driver_support-v1-0-8846efaf9454@quicinc.com>
 <20240920-add_qcs615_powerdomains_driver_support-v1-1-8846efaf9454@quicinc.com>
 <30458916-90f4-4126-b5b4-a52f580c4fa7@kernel.org>
 <a0c4ba44-8cd3-419e-89cc-0c9cbfcbfda5@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <a0c4ba44-8cd3-419e-89cc-0c9cbfcbfda5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/09/2024 14:16, Tingguo Cheng wrote:
> 
> 
> On 9/20/2024 9:15 PM, Krzysztof Kozlowski wrote:
>> On 20/09/2024 06:08, Tingguo Cheng wrote:
>>> Add compatible string for the RPMh power domains on qcs615 platform.
>>>
>>> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
>>> ---
>>>   Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>
>> You sent within 30 minutes two independent patchsets touching the same
>> part of code, so you knew it will lead to conflicts. I don't get how you
>> imagine this to be applied. I suggest combining patchsets in such case.
> I created a new patchset by combining the two patchsets into one to 
> resolve the conflicts.
> 
> 20240927-add_qcs615_qcs8300_powerdomains_driver_support-v2-0-18c030ad7b68@quicinc.com
> |
> |<--Patchset 1:Current patchset.
> |<--Patchset 
> 2:https://lore.kernel.org/r/20240920-add_qcs8300_powerdomains_driver_support-v1-0-96a2a08841da@quicinc.com
> 
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

And this?

Please carefully read your internal go/upstream guides and in-kernel
submitting patches before posting.

Best regards,
Krzysztof


