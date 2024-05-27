Return-Path: <linux-pm+bounces-8136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAEC8CF9AB
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 09:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC532B20F75
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 07:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64758208D1;
	Mon, 27 May 2024 07:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A1Mdf7No"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B700F1AAA5
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716793336; cv=none; b=mkmXmcvoNdvEm+HI+oMRL/7qGi7KEvCutPcpKKHwd2kBterinlbEL/iayjOkNZUX51MOCRqpMTy7aDZIqzMTR7SXt8MFt4s/Y+eb4p08cPB/X80feZiyNZohX1ZmHONxi7pzch+7KGQpIyqUNFi03YdtTCIqaekex14qEWDwJAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716793336; c=relaxed/simple;
	bh=ajmuBU8NEYgZvZcyeXhACXwISAspaNIqOJpgLEmIEJg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A8uoOootTn4QsSNwhm0WAT/6DveOGBuVf8hJWadZ2h3IcxIYyC4svhq34OYqA4wYnaVsTJozTTG49XUYgHwic2w0QXQkJqbn4MgFcwn8jnjgErTkjZAX5rxUmZ1YehafcsiWPg8Yh9rRoTxc9BG0pUERxyzjw/VY71s2z4CTXVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A1Mdf7No; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6269ad9a6fso320620266b.2
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 00:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716793333; x=1717398133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HDVkgZOBY2Ju7MirHdefJO2Dq3agcHKAwL90ZDsI39g=;
        b=A1Mdf7Novp/NQP1Soc0zF6QcdpeMtaSWnjBfAeQbCKjVrrH0nP0ZvkoJDJGZqzgKmC
         WGEkl8l8DZdZAuS2eiQ2s4WcVQJy6rT9+yKUpWl0otcLkvQKKgcGuX4qoXz2Rf/3xjgq
         3t5SCPw+IZPR9px4ZbQDNEfnme6H3YA/Bu8a575jFMJcKSk3I3sLqvpGOiQsNEu1+pOj
         VzoxN7tvjLsP1ZQJRgd2tJybdhXJ+ogS30SGdxx3IcWNYbiWVk9Lz8hkr3KWcpyrhw2e
         AwuuWjjJxd4AnkLdjbB0me0oJ16Mfg/JCDQdR7xcivL6C4Sktfjz/FjLzHGc8iokvpy5
         5ePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716793333; x=1717398133;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDVkgZOBY2Ju7MirHdefJO2Dq3agcHKAwL90ZDsI39g=;
        b=eDzV7HYqOwNHsJ83pm0Z2GLnQP4B+r9YW9LdEDRq0NtS9lVzNNqE6usVTjeYTPtDdw
         /q6N36YigGVUH4uNKWFZIHoHMZlwhDlnGFiC3RhZgaZUfvYSscASSi8AKTVO9ZdQVzOE
         j3uiif8kBLvdX76wmDViB6fTSq1LCeN2EG+tZUh1yDhirOK8s150SQKJY41rTMauk1ic
         hzeY7y2ha7/ZlzHobBc2PlGOE2d94r8X+JbaOhkTzroQ0Jhd4ZHoN5pQ8vDWvcWM7XhK
         EhYoTuiuJ3rp88pUjac3QtCoAlza77blpbJ5XEKl7MIMS0aMTPPk8imQw3xODbFmd3It
         DNWw==
X-Forwarded-Encrypted: i=1; AJvYcCXVbbgSzDvUNRmrDWocrUpb1CUwZ+yOGs+0tIGug68sHLTfmmelN4DXWeIKpf6e9785hkjEZDLsO3I488HyNFf6OK93Eliu1FY=
X-Gm-Message-State: AOJu0YwdRV3fPQScjSYx/SD4D8O9Gsa7F7aLG8/f1Pchg0qIQrk3cg/9
	gaEsA2uzLXSH/zLW9zKDEZXbfgVb8A5zRUfzRklWLRk/y//2KlH3CYTUNCenz3Y=
X-Google-Smtp-Source: AGHT+IEhAmEq5fUBmvnsYx1wE5qAeBjBbMstVg009LHAt5ChBbwxUWqgWM/46OPuefPSTQdqK/dOug==
X-Received: by 2002:a17:906:a082:b0:a5a:15b6:25ab with SMTP id a640c23a62f3a-a6264f16065mr542470366b.61.1716793333016;
        Mon, 27 May 2024 00:02:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c936facsm458543666b.49.2024.05.27.00.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 00:02:12 -0700 (PDT)
Message-ID: <ec830d15-c717-4b81-bda8-6018a4c84258@linaro.org>
Date: Mon, 27 May 2024 09:02:11 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] thermal: Add support of multi sensors to
 thermal_core
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alexandre Bailon <abailon@baylibre.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240524143150.610949-1-abailon@baylibre.com>
 <20240524143150.610949-3-abailon@baylibre.com>
 <834e18c7-21b6-400e-aa61-a4f591027620@linaro.org>
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
In-Reply-To: <834e18c7-21b6-400e-aa61-a4f591027620@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/05/2024 09:00, Krzysztof Kozlowski wrote:
> On 24/05/2024 16:31, Alexandre Bailon wrote:
>> This adds support of multi sensors to thermal.
>> Currently, this only support the get_temp operation.
>> This returns an average temperature of all the sensors.
>> If defined, a coefficient is applied to the value read from the sensor
>> before computing the average.
>>
>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
>> ---
>>  drivers/thermal/Makefile        |   1 +
>>  drivers/thermal/thermal_core.h  |  15 ++
>>  drivers/thermal/thermal_multi.c | 332 ++++++++++++++++++++++++++++++++
>>  include/uapi/linux/thermal.h    |   5 +
>>  4 files changed, 353 insertions(+)
>>  create mode 100644 drivers/thermal/thermal_multi.c
> 
> This does not really build...
> 
> 
> ../drivers/thermal/thermal_multi.c:249:38: error: initialization of ‘struct thermal_trip *’ from incompatible pointer type ‘struct thermal_trip_desc *’ [-Werror=incompatible-pointer-types]

and there are other warnings:

warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst


Best regards,
Krzysztof


