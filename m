Return-Path: <linux-pm+bounces-9145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA8C90863B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 10:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5390828D2C0
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 08:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD9118F2E2;
	Fri, 14 Jun 2024 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RMtpL1ne"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B367185086
	for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353460; cv=none; b=dwW/fCinrNO435NCnR5U/qfA/EODTYgjwUWUrKjbCkdOyN53Xkf60YnSWBg0IkTyqErWkL6kLybDwBqZeX90A3ovIv6lOfnYvRJlRSdPCwM4NTa13fFDAnJx31BvTdW8sPJeBYc0YI93ZIf7d7EvU0auymswYXrY6+gQJ/dEj7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353460; c=relaxed/simple;
	bh=fv0TaSfIqslUmjuOoZwpyiDbVyDeYNBKgbCqOA67DE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQQFkfC/1x86/8LG4mW1zYR40drXZBEAQ7fQ6oDhE78M2bYz33oP0Lc96ar/azo/mYn3X3rj8x8uz+oa22tky3KA2xnNFajpM9ZCO3rP0zyTd20YJmTMxttcm6UFcWCrWlP+M/7Jt3sv/fHYHti0S+VM8CyVWlvnEGZ0cyBCLCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RMtpL1ne; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57cad4475e0so3997226a12.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 01:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718353457; x=1718958257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pCUM5zB/whIY+F5E3NPWVek5NaTuOm+4yywidCzp4Os=;
        b=RMtpL1neE7BwaN2gMr0bfP+03xygkNktpJ74oOwxhR3ctp1gtpk4lwIdVjlIux2TW1
         V/VF209iUNwt0zRUqyswJgmuThAuv2XlL0tGJVj3kFVLuCDOG5I5CELjuxDdWiigqULt
         OpCfPQ12DWonGU00nKup6Ozy/aBxtmydix+z8NkwnbFvkRKiTcsbtrENo6G3VZJX2qu+
         YdiL4q+5us0kyjy3ciABPuC6LoJTYijv6t8TUDXg1YjrGPnnScBZ+36D08FiDpBSu2h3
         DecwZ8ftmXi78xzp0WD7scJA0Rcfg4+Ch0zhMKrzaGgd0/tBbIWV16LIYK1bKLtKIEAV
         s7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718353457; x=1718958257;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCUM5zB/whIY+F5E3NPWVek5NaTuOm+4yywidCzp4Os=;
        b=uNsmVXusQ84VtXyRY8iivegtem59zpWT12KtUB9EQUiItPK6NlifP5PbKFqaUVf3/e
         0FMviaawTfCXH4RAw1y8xVFR5C9eRjX+O/Gf6PndsH7pJjwqEqyDeYf0GFjp84yMfRqP
         PckbMQLL4bDeUIUg3ZHFOfGPYG4RrkCl1BedY42Jc835EiMz30Bo9hhe9xubCPlXBvRD
         OOBuLDfg4e9vnzm+fRBrwhHdIEKduM/YsbNlG6VnAYEhEMNDdOfW/Q8JO0iEOqfjp7wZ
         PlRYMDEFRYCszDkqqvqSqblvbsoPqhlGIvf/neOe2mwnDz/G9R6QAdPqSVkNB5Gy9nhL
         9GrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGOVCUsibkPrhQcxOtixqKnxcw1ErF6ggQ/Ye0gr+sHC0UaAmZJe7WDlYjNTa9Pu6UEO/Tq00fAADyZMRFIoVziyGaZ7inCAQ=
X-Gm-Message-State: AOJu0YyQFb4ccjHHdimsl7Z0O/x5fmbx714QyeYmbAkx5k9SabNspFMS
	D1bliUtspSarzyTRgpWLzI8IcvCTaIFvDobLloupOzoI+1Rv+uae30PFS7kq2y0=
X-Google-Smtp-Source: AGHT+IG5dXFX4FQjxsHkE+bXQUT7iPYQo4HzyMTeAPhjpUybtl9Gh1ZYex+QjtwhNT1jEV3hOTI02g==
X-Received: by 2002:a17:907:9805:b0:a68:e681:be2c with SMTP id a640c23a62f3a-a6f52414868mr385966266b.20.1718353456776;
        Fri, 14 Jun 2024 01:24:16 -0700 (PDT)
Received: from [192.168.0.18] ([78.10.206.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb743adacsm1946396a12.86.2024.06.14.01.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 01:24:16 -0700 (PDT)
Message-ID: <672b6156-e425-4f3b-86f4-02a34cab2b67@linaro.org>
Date: Fri, 14 Jun 2024 10:24:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] soc: qcom: icc-bwmon: Allow for interrupts to be
 shared across instances
To: Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, djakov@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com, conor+dt@kernel.org,
 dmitry.baryshkov@linaro.org, abel.vesa@linaro.org
References: <20240604011157.2358019-1-quic_sibis@quicinc.com>
 <20240604011157.2358019-3-quic_sibis@quicinc.com>
 <5e5f052b-df59-47fb-aed0-10b4f980f151@linaro.org>
 <5df5dc6b-872f-34c5-a6d2-a64f9c881193@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <5df5dc6b-872f-34c5-a6d2-a64f9c881193@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/06/2024 19:02, Sibi Sankar wrote:
> 
> 
> On 6/4/24 12:16, Krzysztof Kozlowski wrote:
>> On 04/06/2024 03:11, Sibi Sankar wrote:
>>> The multiple BWMONv4 instances available on the X1E80100 SoC use the
>>> same interrupt number. Mark them are shared to allow for re-use across
>>> instances.
> 
> Hey Krzysztof,
> 
> Thanks for taking time to review the series :)
> 
>>
>> Would be nice if you also mention you checked that it is safe to have
>> both devm and shared interrupts (so you investigated possibility of race
>> on exit path).
> 
> I didn't see any problems with devm being used with SHARED when I posted
> it out. After your review comments I went back again to vett the exit
> path for races and ran into an pre-existing splat [1] but the bwmon
> instances work as expected on module removal/re-insertion.

Using devm and shared interrupts is in general sign of possible race
issues and should be avoided. Just "not seeing problems" is not an
argument for me, to be honest.

Best regards,
Krzysztof


