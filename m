Return-Path: <linux-pm+bounces-34807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 926CFB7D6FF
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975611893027
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 00:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DA51E376C;
	Wed, 17 Sep 2025 00:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lLhPqSRK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BEA1C3C18
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 00:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758069351; cv=none; b=IO2wg68lV6uTw0EmpH+Irx5YTPpNFOve89HzV4VFX14VniEhyYXmyzFVcWbmxrfZ9Ds1OOX/IOVjjF6HKX2m/qLUJ0T8acAU4ZFf8LkibyclOQzR79y+kDX0wRSZsPPE6ddjUT327Lx5/0TzF+FQN3Kxx9UOTmeSUsIZJ0jtZ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758069351; c=relaxed/simple;
	bh=OHJWfaJyWpGK0VAeh46ZpICOh7jiXlPJ5BpYZKqe+RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGCmxzNg0jQH+yrG8S8fC5YELyrlKEfPe4vGj6PP8e4ItdhhwxHIZnpABpM2Ck7BwZfw1Q4LyhxnZn+qr4V6IqNOaFhCBF4OfFM03mvi4USCv6h/qKiOhcDgkLL6NexC1qtPYVfpB4dMGWsGrMt2ZnF55b83mGX/cI+LEDFjj8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lLhPqSRK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-265f97930baso4648245ad.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 17:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758069349; x=1758674149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+yKyuCdjvfHTZC/Lr1XyLH1f+wAtJ15tCU/+O5Qcke0=;
        b=lLhPqSRKbnFfKl3NAkquB86O6TfEGoXuDrGiRhKJKg9E1zciy59vy/NFVGHXdViMqZ
         z1K8U+yWTs8g3TNtTCGzfW+iS88EY9hXIq3ZuFQIKEta5WejW2BkuoviZy1Wn5VKZQ7h
         iE2A3ZGASFOyfxXZom1hgXZB9rwx/AoygmCWn0BmAbPje14j+feKlpv8uEFA8zNvuMB+
         Rk1T1o1f8Ibn1sLPcvRz+3vFo/SVM1ueNsoO+LrAR90RLmZucEHNZ6cyyqenZ3wipaHT
         sU2U/oPwDiLNHHpHQzaiiK1E/UOGHz1XBUz1kjo6iCXLHhfUQSb6EuXSSjAkEaS+NQfZ
         KvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758069349; x=1758674149;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yKyuCdjvfHTZC/Lr1XyLH1f+wAtJ15tCU/+O5Qcke0=;
        b=RT3HSGwFHdGe8ywWYtOB4/QIWPZtO6f5Edb0PE3/1yRLeXjhf0EjSfm2P1O642ysEq
         qPSuiVVt0kM2AZvs3YH3JjRKihNlloagBpTs65cY07kGviUczszgFEAo6jcs4wpY8i6U
         XNQqJ74nSQt1N6uVot9RixpzlEAUCiBkdgmnEE44mVomWo2U8GIdQKkckgQV9exUMQJ1
         q82AAcl7xf5XWMk5B5tnQmLYUCwEQoQ2U2z+n3OF7kuhN/nmllPPdEXlJ1yVExcT1ue7
         g1hxQdJJiA2n+ZxGE2SqUr+7yB5Hz8HeC+VtgqMFtEBxDgNmid4pX9vwBnapy3xN2IM+
         QUbw==
X-Forwarded-Encrypted: i=1; AJvYcCVBlGPAkqxJzLevVwnGEiKYsInIE3MahwDLbyGnGtVKQEGXr1np8WvmxIkVbjcpEv7SQC6yd8j1Kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrOKREvUaeOAY++mMQCTuSgIGqrw1T5lPBZTLSsHs+C3t76vUk
	97Md9tyRmK+DF9mViRP7LWeS+rEkVzkK4xMDyzO9be445DdZiEpDzth0huLjmBoPhaA=
X-Gm-Gg: ASbGncuG84nPUHWlnyvFr8u3z43vajCjuVKuhF6z0d72jydyiNvaxgK5g/HdQhzAjgd
	zfQnE/4bCc+fvGbBviTE6r1RArJy3AICdQwH/r6y04PANjOEJeYPJUdoBeR0osghC5JF+KNUWWv
	wZb5r7jNQrLv1zrQ5/6R6pfT4/ObqMr9AcXBnSoklUTsTrWIQY3k6QIRhbM+KKxxoTl0a4GAl/X
	LZEY3dAnwk+wRYNP7nj8wKoWZtOsurBzDqTrVVJOiLJpST9eQhXRY04AhxL/5no+fpbRTLCPC2i
	7hwZJMmAp3LxJtjujyERk+4uPlC7eyck5SYMO4v7nwXyU6dNP5xuU0pJ2w+By1HXK7gofttxyHP
	8++4RJ9errkODBSLPv+FHTYuX48KRzCxkExBstSuYg8w=
X-Google-Smtp-Source: AGHT+IF390E63ZU9vuARjO+nw1ZUI7FtlCAawkFr1p8xl1+Uo1mLtRWneXPuNPAB/asviLaSXJOoEA==
X-Received: by 2002:a17:902:c94a:b0:261:500a:5742 with SMTP id d9443c01a7336-26813f75090mr1125965ad.10.1758069348416;
        Tue, 16 Sep 2025 17:35:48 -0700 (PDT)
Received: from [192.168.35.228] ([218.51.42.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25fc8285639sm118508945ad.134.2025.09.16.17.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 17:35:47 -0700 (PDT)
Message-ID: <e874339e-f802-4793-8c0f-db85575be8e5@linaro.org>
Date: Wed, 17 Sep 2025 09:35:38 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] dt-bindings: clock: Add required
 "interconnect-cells" property
To: Luo Jie <quic_luoj@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>,
 Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
 Devi Priya <quic_devipriy@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Richard Cochran <richardcochran@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, quic_kkumarcs@quicinc.com,
 quic_linchen@quicinc.com, quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
 quic_suruchia@quicinc.com
References: <20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com>
 <20250909-qcom_ipq5424_nsscc-v5-2-332c49a8512b@quicinc.com>
 <20250912-nocturnal-horse-of-acumen-5b2cbd@kuoka>
 <b7487ab1-1abd-40ca-8392-fdf63fddaafc@oss.qualcomm.com>
 <0aa8bf54-50e4-456d-9f07-a297a34b86c5@linaro.org>
 <1e7d7066-fa0b-4ebc-8f66-e3208bb6f948@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <1e7d7066-fa0b-4ebc-8f66-e3208bb6f948@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/09/2025 16:03, Luo Jie wrote:
> 
> 
> On 9/12/2025 5:16 PM, Krzysztof Kozlowski wrote:
>> On 12/09/2025 11:13, Konrad Dybcio wrote:
>>> On 9/12/25 9:04 AM, Krzysztof Kozlowski wrote:
>>>> On Tue, Sep 09, 2025 at 09:39:11PM +0800, Luo Jie wrote:
>>>>> The Networking Subsystem (NSS) clock controller acts as both a clock
>>>>> provider and an interconnect provider. The #interconnect-cells property
>>>>> is mandatory in the Device Tree Source (DTS) to ensure that client
>>>>> drivers, such as the PPE driver, can correctly acquire ICC clocks from
>>>>> the NSS ICC provider.
>>>>>
>>>>> Although this property is already present in the NSS CC node of the DTS
>>>>> for CMN PLL for IPQ9574 SoC which is currently supported, it was previously
>>>>> omitted from the list of required properties in the bindings documentation.
>>>>> Adding this as a required property is not expected to break the ABI for
>>>>> currently supported SoC.
>>>>>
>>>>> Marking #interconnect-cells as required to comply with Device Tree (DT)
>>>>> binding requirements for interconnect providers.
>>>>
>>>> DT bindings do not require interconnect-cells, so that's not a correct
>>>> reason. Drop them from required properties.
>>>
>>> "Mark #interconnect-cells as required to allow consuming the provided
>>> interconnect endpoints"?
>>
>>
>> The point is they do not have to be required.
> 
> The reason for adding this property as required is to enforce
> the DTS to define this important resource correctly. If this property
> is missed from the DTS, the client driver such as PPE driver will not
> be able to initialize correctly. This is necessary irrespective of
> whether these clocks are enabled by bootloader or not. The IPQ9574 SoC
> DTS defines this property even though the property was not marked as
> mandatory in the bindings, and hence the PPE driver is working.
> 
> By now marking it as required, we can enforce that DTS files going
> forward for newer SoC (IPQ5424 and later) are properly defining this
> resource. This prevents any DTS misconfiguration and improves bindings
> validation as new SoCs are introduced.

So you explain to the DT maintainer how the DT works. Well, thank you,
everyday I can learn something.

You wasted a lot of our (multiple maintainers) time in the past, so I
will just NAK your patches instead of wasting time again.

Best regards,
Krzysztof

