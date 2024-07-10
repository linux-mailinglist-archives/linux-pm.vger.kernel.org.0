Return-Path: <linux-pm+bounces-10920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0739F92CFC8
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 12:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1891F221CD
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 10:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156E618FC62;
	Wed, 10 Jul 2024 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQ3cuRsj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3464F18FA06
	for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2024 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720608560; cv=none; b=QE9iEDFxJz3RWPIHidVVfg/MZh7MPe/yR4yZgUWfoA7NHu2GoKK/2GZBAiLHuGjnpLfgv2bvS33Zdj68/q3VG52RM6/pk6bIKFfO08QAxReO82MgEei+lc+4DVyqj5jNqvZZ1/jwl+u/v6a08EVeZajAH7/INGUyCauBbIqTZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720608560; c=relaxed/simple;
	bh=bbaLeSmE37zgEmxjhsm3MgKlF7I7utb0zJojaDQSFPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbfh2th4ifX4rapikHtePje3IzqTGN/dd3YMTOJ2umJ4BWk72htZvuoiXEyWi8e9o11odFOakeux/SweGQqg6yFvxgy1yaLDwwX1G6x97NZy03d5B/kDdZmS+gc9Vy/1AnqjlCgPHWb+8XjUTC/kyaOw3m3AMO9gUfP5muEV4H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cQ3cuRsj; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77baa87743so667269066b.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2024 03:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720608556; x=1721213356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p2SmmD8lFnK+3ph0iUIhMMBa+ayR7kGRg2lbUgLnUKk=;
        b=cQ3cuRsjQjxzycuQulvSBpAp0d3dNgTkYHhxP+1pZxBhP1i9fh4PmwuvZKxu5TB8xb
         bOQ9hKROK1reSQ9BnNmy78AMOtacNgWyRlXMXlLS83ywTp4TsIZOHVA3I8OX/k1+iuQz
         MsWGzzEbowGRY1gBKm1OYiR+YWqjUAYkeByS3gAjGmtTjPZm6E4fya9udS2tJulVGkWd
         IP+/2UGfRQUSdFu3oHmJ/lUMiRJsBTIAklLMBMoE0ydmOHrOKKjK+QuGjX8F8CSWPhPA
         G1lvMRKgHu+srwd2aO/Z/SXNrBCJe5JKFNMKqawz7OUMgIBYCB2cdC03J6KV/c8QXqcF
         tNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720608556; x=1721213356;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2SmmD8lFnK+3ph0iUIhMMBa+ayR7kGRg2lbUgLnUKk=;
        b=Pyi+G/FHiF1LEY7L0fpIoKdm6dJINC5rsdl87TL8BzOax6usXWw9LJXUn4p86g7VHy
         Z3OfAfF/4UesMxCbRmiA7i2bDfCbvoc/Ot0gxqFEJfwvn2IZ6m8uXWkDMIdaqwI1qX2e
         HYSj4PYEi4TFZqzQNQh+AF7EDTcNIrPu3JS1Um3mfiCiIY6q94t5Qn5hvIOvZgQVGQRH
         FgtWUCLX+E866IQ12J7orVOBDa3s62g9hRoS3LUOvGFlDpmR8+O0+q1q6XxljlWnHZ3J
         LNzafMEj2ClOVDmM6jqWa1m7QOcLpC412RbSsUPgUx3r6o0iiiLjBpw8Jba3xQm2uDxa
         xZDA==
X-Forwarded-Encrypted: i=1; AJvYcCU+1RQrXWBFAD5XZ3BodvG4c9N1F5pqUekucleq3GGdJLVkmMM89SZtMwgu4eKko1sKm3/+GnItSLt3OPFslndx9BGxI4Yd/ck=
X-Gm-Message-State: AOJu0Yxd9CT+8/pw/tRENUJK62sblpkEK7eXAUumLIJrIhGwNy8tkxd7
	7r71a1O8iyEQUCjeEOApjFGzOTo+/wAXuHV4INe+WlJuHpckzdnPOr7pMYcr+1Y=
X-Google-Smtp-Source: AGHT+IG3kAOB3GOzFDTrAkyUAM0HTc3HljgITzx2bz5AFyIbijHZglmfyD1oe5cVWg1XVEjLEK7DfA==
X-Received: by 2002:a17:907:7e9c:b0:a6f:e3cf:2b8e with SMTP id a640c23a62f3a-a780b89dd3bmr501964266b.76.1720608556339;
        Wed, 10 Jul 2024 03:49:16 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a856dd6sm148649466b.180.2024.07.10.03.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 03:49:16 -0700 (PDT)
Message-ID: <a4deabfa-1366-47ef-993f-2fae3e206a44@linaro.org>
Date: Wed, 10 Jul 2024 12:49:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] arm64: dts: qcom: ipq5332: Add icc provider
 ability to gcc
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, djakov@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240709063949.4127310-1-quic_varada@quicinc.com>
 <20240709063949.4127310-4-quic_varada@quicinc.com>
 <cef54c07-4ecb-44bd-ad7c-aea475b89ffb@linaro.org>
 <Zo5lfDVVdgZ/iwi3@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <Zo5lfDVVdgZ/iwi3@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10.07.2024 12:42 PM, Varadarajan Narayanan wrote:
> On Tue, Jul 09, 2024 at 11:53:41AM +0200, Konrad Dybcio wrote:
>> On 9.07.2024 8:39 AM, Varadarajan Narayanan wrote:
>>> IPQ SoCs dont involve RPM in managing NoC related clocks and
>>> there is no NoC scaling. Linux itself handles these clocks.
>>> However, these should not be exposed as just clocks and align
>>> with other Qualcomm SoCs that handle these clocks from a
>>> interconnect provider.
>>>
>>> Hence include icc provider capability to the gcc node so that
>>> peripherals can use the interconnect facility to enable these
>>> clocks.
>>>
>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>> ---
>>
>> Doesn't the USB host need to have its path described to keep working?
> 
> Presently, USB host enables GCC_SNOC_USB_CLK directly using
> the clocks/clock-name entries. So it is not dependent on ICC.
> 
> Shall I update the USB DT node to use interconnects now itself,
> or wait until this IPQ5332 ICC enablement series is approved?
> Please let me know.

Definitely so. Now that you registered that clock with the
interconnect framework, the current usage is essentially
circumventing it..

Say some consumers casted an ICC vote on that node, and then
the USB driver called set_rate on the clock.. The data from
icc-clk would be discarded

Konrad

