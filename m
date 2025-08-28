Return-Path: <linux-pm+bounces-33341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C61AB3AD2C
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 00:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5CCE462D3C
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 22:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236D22BEFF7;
	Thu, 28 Aug 2025 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXslAWvA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F5B27B4E8;
	Thu, 28 Aug 2025 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756418396; cv=none; b=OlbkGU9KyFVYLZlop7EBNlyXgBrpvgGHYYBW2XiamNsvkoz0ZiWCzJG1IeXIKIZ2Rfb8kwYefrpu1EAk6PPnK+Th0+pOQGC/q92tMywIAdXVvUTnsIwyQjf3K2OusM4w7EMDOCsXIo4ymxzjwIc96rqceKhtq0k9euju3e1dO9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756418396; c=relaxed/simple;
	bh=+yn7bpIM+//8mwmC7Z0a1G3HNk6Q20Ctm8roSQE4Hxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdSONKYU48H5Z5oQH9mtix3F7Ran+FaEt5OuZbYly+eNPz1OMnjEQKRaGwXOpsn7FMdo7+jiniKB7UPSba57tLqNUOL5xuTueLPM32o2OmWYigN+WNNCifH+7s4TMoQ9S5/OcgxuI1pWFodfp3RYsC71QYBcqJSCIaI/+pObZSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXslAWvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A868C4CEEB;
	Thu, 28 Aug 2025 21:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756418395;
	bh=+yn7bpIM+//8mwmC7Z0a1G3HNk6Q20Ctm8roSQE4Hxw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hXslAWvA0T9+S0WXdu2fyyN48S1dw8Wz9ZeA7/gPudrI6PISRs+u/zJqXGfU4fSN2
	 aFf1oimw6kIqHnaLXyNK2Or1zOOkTgQYu+DwAGAtivMaZb+KYIxtG7mRHgmjrj8ckR
	 9jg1knDgv1eJ9/Mq8H0A+ULvTMNBhQcIfrwOPJw0pNg9yEPC5+3PlKWKH2DEDaD/T9
	 gN4t4MAYj/sMscWOnPphIeCgQ+945NqmU/RfvfyFvlCH13vggxwhazPpvLF//UtkKw
	 fuvdnOo7sl29GVuifed++vYTo06OLVao1SuRBXiqGlrEQglq8y1A27O1+yqCw4F0Zy
	 VV31pr2pZOm+A==
Message-ID: <26e5309e-3705-4d70-a2e7-3f0e9344816b@kernel.org>
Date: Fri, 29 Aug 2025 00:59:49 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: add clocks property to
 enable QoS on sa8775p
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
 <20250808140300.14784-2-odelu.kukatla@oss.qualcomm.com>
 <90b51e31-3217-4483-bb5b-ec328665a723@kernel.org>
 <28b97952-1b67-411f-a7fb-ddd558739839@oss.qualcomm.com>
 <ac83c453-c24d-4c4d-83bc-9ed13f2f9d1e@kernel.org>
 <7d3e5cf7-4167-4005-ba4b-c1915c254705@oss.qualcomm.com>
 <00f50d92-e4ea-4805-b771-147fa5f5ebe4@kernel.org>
 <249f8109-31b1-4cb8-a5a4-b30c27b2e987@oss.qualcomm.com>
 <6e036d6a-f2d1-43d6-bb35-54467edd7ec9@kernel.org>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <6e036d6a-f2d1-43d6-bb35-54467edd7ec9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/25 9:20 PM, Krzysztof Kozlowski wrote:
> On 28/08/2025 20:16, Odelu Kukatla wrote:
>>
>>>> QoS configuration is essential for managing latency and bandwidth across
>>>> subsystems such as CPU, GPU, and multimedia engines. Without it, the
>>>> system may experience performance degradation, especially under
>>>
>>> So how was it working for the last 2 years?
>>>
>> The system may function normally without this feature. However, enabling
> 
> 
> Huh? So you agree but keep continuing the discussion?
> 
> I don't understand what we are discussing in such case, but just to
> close the topic from my side and be explicit: based on above you cannot
> break the ABI.

To be even more specific, if we already have some DT binding without any
clocks and reg properties, we can't just suddenly change them from now
on to be "required". But they can still be "optional" and this will not
break the ABI, right? The old DT is still valid and the QoS will be
active when the new properties are present and this is handled properly
by the driver.

BR,
Georgi

> 
>> QoS helps optimize latency and bandwidth across subsystems like CPU,
>> GPU, and multimedia engines, which becomes important in high-throughput
>> scenarios.
> 
> No one discussed that.
> 
> 
> Best regards,
> Krzysztof


