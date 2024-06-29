Return-Path: <linux-pm+bounces-10240-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA8E91CD3D
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 15:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BEBD1F22191
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 13:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC6C80614;
	Sat, 29 Jun 2024 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9wQ9gaE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAD61D52D
	for <linux-pm@vger.kernel.org>; Sat, 29 Jun 2024 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719668212; cv=none; b=XlZxpWjT4MJHJbVO5Hl/Skliqr1PnxNmwO7SMX7f8cAGgwrd/48Vx1DRKa9O9VXSf7x3iCoFsWvc7Ltt8+kXkoDOaVr6V+FX+9l+hAtJwjLxVD/Kvg4zSRVSVSyDSe6i2hEwN6vd+SkXN09ZxP9eDl9t3yGscM0r4/SJHumrLlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719668212; c=relaxed/simple;
	bh=pEKkk9d0dkZtVkvo71avDXYFjS+/LQXs6eudgJgzkCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUGT6Gn7eo41audHvVMZWGn+v9eM4gYvX6RXRoGBoCc+EaTJ0Q7dhIJNzm0w8Gu1OYljDpc8i5CGZ+QclvQS9EJE0ifZ6PC9CnYb1nfQaqF6eGMpdhTp4rLZrQ8pKq9/KpXbwNdZa3Vn6HLwJZ86Blx8q6F2ETaQj1tl8q7Mc3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m9wQ9gaE; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so20315931fa.2
        for <linux-pm@vger.kernel.org>; Sat, 29 Jun 2024 06:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719668208; x=1720273008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fb+wSaIrJVe+pkmIcOdPYU+4bx32BHvpwZol/N+Ajuo=;
        b=m9wQ9gaEGSueTlCiFflwMTHImkHduTDhofaQZ0/fB+JwSTOdcAfWvfs865Co1e4rkf
         rdTVWXva2aNUp8bvRbmgTRb2oLPE+EO5tlDjMM6D2k1Os1nrMCCtM3mW5M6uFURybKvF
         xn7IuEtilhwXAe/PIuh6fopUYkk7WYfwQkfVvsRgMsEPxMXKZ9uTW+DYzJBDcMgY8Pb6
         QaIndoqSXTV6qU1HT5e8+BC59xQfh5/zZj0MyFm3w0gc9D6rbJRh7p7ICzXkEElrnzlK
         hWh/P5wNlUJpc/hbYL1x/uVgDhZ4y4ZrIIkK3yfge4yC0pfFDv63Gw7VU4FxmnEdvnb5
         kCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719668208; x=1720273008;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fb+wSaIrJVe+pkmIcOdPYU+4bx32BHvpwZol/N+Ajuo=;
        b=g2h5NZdcuZ7j9l6Aq/9R1GJ92hx7SKM9HVRnDW9ZitjOHbB3mxnUFpL7wZzqR3bstl
         hhpFJAc661EWK5ZAhBmhflfoQ1nVpYrktd0G8vXymB4Z6wopLkpnKbmKfcgNkI64nlht
         m/FhrsiGTQ5fznIUmY7kvg+Q4BT+jKdtyFaKmt6taVj4jRF2QEPPlzHPNlGIAZDM7fNw
         UhsH1cXkC2uD146sNWZK21bP2wIsRMiPjm6fogE+6ki3dsbC9g7zzmRFaR5FNIRAv+C8
         XQT5ERoJNijWJCAmRaCfDE4BsYMy0sE6l9zUHcUzBYkDCVX6hU2vZbZeQLdfyU525Mvc
         Tb/g==
X-Forwarded-Encrypted: i=1; AJvYcCW+eSacVcP3TvEOlza5QY39Dg43WUvpu0nZqrfMR5TiAbY2laMa/OftmYxdQXQT00PnzhRD/3z+8U+OqWV+h+LXNoXfLh1o6P4=
X-Gm-Message-State: AOJu0Yx1T6arfKKtIGuzeNlw7ftCGzlur51dd8v14KoAX+gIJiRAmMsv
	+lzcI5CPVmSRxKt94+CulOb7PAtK4xHy5MUekRdtbU15uPnfc0NywHf7VjGsNbo=
X-Google-Smtp-Source: AGHT+IFViPkvLnjVI+tzuVPmDLNUpmDc9Ajbta0rj8EHH09MphUCQjSVvr6pLzm9yp2KFajt9W7Q6A==
X-Received: by 2002:a2e:b00e:0:b0:2ec:5785:ee97 with SMTP id 38308e7fff4ca-2ee5e707ddemr8165451fa.53.1719668208268;
        Sat, 29 Jun 2024 06:36:48 -0700 (PDT)
Received: from [192.168.215.29] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861381756esm2268082a12.56.2024.06.29.06.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 06:36:47 -0700 (PDT)
Message-ID: <bc6d0faa-b3d6-4094-b569-dec3a5ed7545@linaro.org>
Date: Sat, 29 Jun 2024 15:36:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/6] Add interconnect driver for IPQ9574 SoC
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, djakov@kernel.org,
 dmitry.baryshkov@linaro.org, quic_anusha@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, bryan.odonoghue@linaro.org
References: <20240430064214.2030013-1-quic_varada@quicinc.com>
 <ZjXrTywO6+iRaEYk@hu-varada-blr.qualcomm.com>
 <90bb9256-d54d-4e01-aa06-4184e2b95d48@linaro.org>
 <Zmgc+Qzwt6Zbg/w+@hu-varada-blr.qualcomm.com>
 <ZnumpkYR2ILpbOwF@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZnumpkYR2ILpbOwF@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.06.2024 7:27 AM, Varadarajan Narayanan wrote:
> On Tue, Jun 11, 2024 at 03:16:33PM +0530, Varadarajan Narayanan wrote:
>> On Thu, Jun 06, 2024 at 04:07:23PM +0200, Konrad Dybcio wrote:
>>> On 4.05.2024 10:01 AM, Varadarajan Narayanan wrote:
>>>> Bjorn,
>>>>
>>>>> On Tue, Apr 30, 2024 at 12:12:08PM +0530, Varadarajan Narayanan wrote:
>>>>> MSM platforms manage NoC related clocks and scaling from RPM.
>>>>> However, in IPQ SoCs, RPM is not involved in managing NoC
>>>>> related clocks and there is no NoC scaling.
>>>>>
>>>>> However, there is a requirement to enable some NoC interface
>>>>> clocks for the accessing the peripherals present in the
>>>>> system. Hence add a minimalistic interconnect driver that
>>>>> establishes a path from the processor/memory to those peripherals
>>>>> and vice versa.
>>>>>
>>>>> Change icc-clk driver to take master and slave ids instead
>>>>> of auto generating.
>>>>>
>>>>> Currently, drivers/clk/qcom/clk-cbf-8996.c is the only user of
>>>>> icc-clk. And, it had exactly one master and one slave node.
>>>>> For this the auto generated master (= 1) and slave (= 0) was
>>>>> enough.
>>>>>
>>>>> However, when drivers/clk/qcom/gcc-ipq9574.c wanted to make use
>>>>> of the icc-clk framework, it had more number of master and slave
>>>>> nodes and the auto generated ids did not suit the usage.
>>>>>
>>>>> ---
>>>>> v11:	No code changes
>>>>> 	Commit log changed for the first patch
>>>>> 	Added Acked-By: to 3 patches
>>>>
>>>> Can this be included in your driver changes for 6.10?
>>>
>> Konrad,
>>
>>> FWIW there is still an open discussion at v9
>>> <CAA8EJpqENsojPQmCbma_nQLEZq8nK1fz1K0JdtvLd=kPrH_DBw@mail.gmail.com>
>>
>> Thanks for reminding. Have responded to it.
>> https://lore.kernel.org/linux-arm-msm/Zmgb+OjdBNw71sC1@hu-varada-blr.qualcomm.com/
> 
> Bjorn/Konrad,
> 
> Can this be merged for 6.11. I believe the discussion open at v9
> has been addressed. Please let me know if anything is still pending.
> 
> Below patches depend on this series:
> 
> 	PCI: https://lore.kernel.org/linux-arm-msm/20240512082858.1806694-1-quic_devipriy@quicinc.com/
> 	NSSCC: https://lore.kernel.org/linux-arm-msm/20240625070536.3043630-1-quic_devipriy@quicinc.com/

Looks solved now! Bjorn, feel free to pick this up

Konrad

