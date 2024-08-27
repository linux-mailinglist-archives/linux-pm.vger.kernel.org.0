Return-Path: <linux-pm+bounces-12945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD5C9605E0
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 11:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1461928191A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 09:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4773419D067;
	Tue, 27 Aug 2024 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YULUR8Yy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8516319B59F
	for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751577; cv=none; b=a4noEiR1lKXatGz9OI8wUue6NFFu0rg9rzRI2hwOEZpM8nklsBvCkikxIfxocnFwJaKoV5ED8kUsOk/p0N1bnmPQ1Q6mxXcCjWaXnQ8/hjsSLFEzoZPMLUsSprZmlwZHtEoMGg7VlgSJd1kHvhtmK7gPIWSIbE42YvdcSepWhG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751577; c=relaxed/simple;
	bh=pd7vAXEynb0hQPnIaxUHQTA8QqnRpztQOlW6pMiXuWw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fz+qN2LR9u6lacMxKEJkbb+JwUNnICZiEpzqvbwQLiInTiUNMjp4KL/PKzRJ4hMrqYl0pRaMM6H+c6A304OJbKKfwmnJVaBcUcLdK5mEZTk9caD+Bd+RB62ydDupHrbQf7U/LoTewvoTQEZdo8Z9B4/Hl4S5GH2W0xroCM7wdpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YULUR8Yy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4280ef642fbso6687425e9.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 02:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724751573; x=1725356373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9NA1hPLphJFkg55aBOeaWrnCS8TwQLe/FT77xsFVr/g=;
        b=YULUR8Yy8y05bKM85RDC9NjuO/tDizuQBhNDgXTGBj9unuEQRmAR7Xc+GCytXqyAUE
         OgwbXwB23fCuDq+N/VQwPYgRyt6/NsjfkAYSEBG2CdgajNGzNSUBR2UddLqFS2yM4lbN
         MSBBNnaCPsjRihFuRAkxnWd+X61ebAMTRBBA94ZFmve5wAZ42nsj4JNmRCnQhIqXaYUC
         5g1qyCeVqWaiZlsoBX+wtahWN91vVoAseFBORhK/DEXL+vrgyzLsXVia1Vb8+rwcljBp
         wnlJ5qgRCPg0eN7Qs+Rv99ejiayPbht49Jrqf5HSTELIWF3hQaOcbfAcvq+mvv2c2+dg
         KpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724751573; x=1725356373;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NA1hPLphJFkg55aBOeaWrnCS8TwQLe/FT77xsFVr/g=;
        b=lAPcb/muoryZFIh2tGOI0DGFmV1aqz6sNj3Dkw95PnYO6dbImNNeH+ZErUQRuLvRbf
         kYIDwLlhtlayrQ6tda+rMu0QxOeTQzb6kBKSUOvLWtuQfzuPw2nLEZ2gLlqpTor31erd
         hxV/K6HN/wxm32cn8oIGj1kaHnpWbbawyVS2R+TbR3IJhuTejxHXfSNHc7TH72lz7Lut
         JGy+jQIFeNFAgfH6f2JcflNmGirom81aNgnyYWeA7BShekRrUzuoZK7N3pNOpj2a9qhB
         PzAwd7Eth4eddJD7PNxJej1qpIbAD56vdtZIqniam5MU8+v50R5Rj+Uw1aWPbCgBlHB5
         C8Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWYE0Ugm4ofGRRfjJWP6zF5zPkN1Dgleb9p/iqlY6FUFZO4x0UeJD/EEVOsjhXGu1mLuS8Qpmb5WA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDB2Y3TOEbLg7e4PN5ebmr8N4x4oXWL+geloKAXMC11dwu0z9D
	bgYKi+1FSV4CXSzrU+JnPp4TohaM6iUoZt9id1wtlaLE2Nns07Zz1na6t7RMNgk=
X-Google-Smtp-Source: AGHT+IEucEoPnsJ4jJ6ZUZu1I9QHe7Vec7KyXnEjRKdsR+FfHN00nz2DTyVEWDOUtU6KNSpcb2mu9A==
X-Received: by 2002:a05:600c:3ca3:b0:426:6358:7c5d with SMTP id 5b1f17b1804b1-42acca0c1c8mr54322945e9.4.1724751572652;
        Tue, 27 Aug 2024 02:39:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac514e269sm182322605e9.2.2024.08.27.02.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 02:39:32 -0700 (PDT)
Message-ID: <58f5d332-2f2a-4607-9662-e71fd23b1316@linaro.org>
Date: Tue, 27 Aug 2024 11:39:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] pmdomain: renesas: rcar-gen4-sysc: Use scoped
 device node handling to simplify error paths
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20240823-cleanup-h-guard-pm-domain-v1-0-8320722eaf39@linaro.org>
 <20240823-cleanup-h-guard-pm-domain-v1-9-8320722eaf39@linaro.org>
 <CAMuHMdV0R0+u1eCiUOHhL5w-wzge9KhgyumJSd28oF9kQmnx_Q@mail.gmail.com>
 <a48f1a0b-0e20-4782-bf6b-c430da9ae391@linaro.org>
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
In-Reply-To: <a48f1a0b-0e20-4782-bf6b-c430da9ae391@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/08/2024 11:33, Krzysztof Kozlowski wrote:
> On 27/08/2024 09:48, Geert Uytterhoeven wrote:
>> Hi Krzysztof,
>>
>> On Fri, Aug 23, 2024 at 2:51 PM Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>> Obtain the device node reference with scoped/cleanup.h to reduce error
>>> handling and make the code a bit simpler.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Thanks for your patch!
>>
>>> --- a/drivers/pmdomain/renesas/rcar-gen4-sysc.c
>>> +++ b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
>>> @@ -303,12 +304,12 @@ static int __init rcar_gen4_sysc_pd_init(void)
>>>         const struct rcar_gen4_sysc_info *info;
>>>         const struct of_device_id *match;
>>>         struct rcar_gen4_pm_domains *domains;
>>> -       struct device_node *np;
>>>         void __iomem *base;
>>>         unsigned int i;
>>>         int error;
>>>
>>> -       np = of_find_matching_node_and_match(NULL, rcar_gen4_sysc_matches, &match);
>>> +       struct device_node *np __free(device_node) =
>>> +               of_find_matching_node_and_match(NULL, rcar_gen4_sysc_matches, &match);
>>
>> This breaks the declarations/blank-line/code structure, so please move
>> this up.
> 
> What do you mean "declaration structure"? That's the way how variables
> with constructors are expected to be declared - within the code.

Continuing thoughts, so you prefer:

	struct rcar_gen4_pm_domains *domains;
	void __iomem *base;
	struct device_node *np __free(device_node) =
		of_find_matching_node_and_match(NULL, rcar_gen4_sysc_matches, &match);

(assuming I will put it at the end of declarations).

Are you sure this is more readable? It's really long line so it
obfuscates a bit the declarations. The point of the scoped assignment is that
you declare it at point of need/first use.

> 
>>
>> If you insist on keeping assignment to and validation of np together,
>> the line should be split in declaration and assignment.
> 
> No, that would be inconsistent with cleanup/constructor coding style.
> Maybe this is something new, so let me bring previous discussions:
> 
> https://lore.kernel.org/all/CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com/
> 
> https://lore.kernel.org/all/CAHk-=wgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuESs1JyA@mail.gmail.com/
> 
> https://lore.kernel.org/all/CAHk-=whvOGL3aNhtps0YksGtzvaob_bvZpbaTcVEqGwNMxB6xg@mail.gmail.com/
> 
> and finally it will reach documentation (although it focuses on
> unwinding process to be specific - "When the unwind order ..."):
> https://lore.kernel.org/all/171175585714.2192972.12661675876300167762.stgit@dwillia2-xfh.jf.intel.com/
> 
>>
>>>         if (!np)
>>>                 return -ENODEV;
>>>
>>
>>> @@ -369,14 +365,12 @@ static int __init rcar_gen4_sysc_pd_init(void)
>>>                 if (error) {
>>>                         pr_warn("Failed to add PM subdomain %s to parent %u\n",
>>>                                 area->name, area->parent);
>>> -                       goto out_put;
>>> +                       return error;
>>>                 }
>>>         }
>>>
>>>         error = of_genpd_add_provider_onecell(np, &domains->onecell_data);
>>>
>>> -out_put:
>>> -       of_node_put(np);
>>>         return error;
>>
>> return of_genpd_add_provider_onecell(...);
> 
> Ack.
> 
> Best regards,
> Krzysztof
> 

Best regards,
Krzysztof


