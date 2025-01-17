Return-Path: <linux-pm+bounces-20599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ECCA14A2A
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 08:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A7447A4245
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 07:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C8D1F8660;
	Fri, 17 Jan 2025 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQR5H43R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345261F76CB
	for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2025 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737099130; cv=none; b=ihSRiCLKCutb4BfSxk8N/v9t3tUcTm9hjsG0eEE9YZ0XVlQ8trZ/LEIxY64wqeYYAruCvTs3Z5o72xxcIlpwkoXM2+Qkic1l3ndRZvYkeEUJKNEEPXlzE7AX02gYUEM/rEi+M2wvy4bB8eaPSGWzUE3LJRNxL0bYbSWZgJ6Qvnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737099130; c=relaxed/simple;
	bh=1wfw7cp0NYAmtFWKXEOaOzj1ZSbntdmhcKZWPEgxGAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RzVjx29kUBOIP/McS8MX4iTX5B1aAduUX9qBPs+vFXeITVe0/exoqwV/IiDwyQtgYyW3b1+FYr/mIoH8f4lXoUVuIhlYC5hPy5+rfvhHsYxmmme9+X1lAtF0ZDoFdwp5sz1WYaaSh7xSt3/gJ/hx9H/cCn4XVLSCSF2Y938nj28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FQR5H43R; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361f09be37so2266045e9.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 23:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737099123; x=1737703923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QhnZV2qLygGGQYrfuXJ4IFopDJzf5nAynmXZ+qlJOqI=;
        b=FQR5H43RcU5bqsH3h3B9RH/ec2qutyx6zJEVSwPqUW5Cq3ijiBa3vZJDxWN64XRE15
         hV70huxvUnukmWUbek26iT5x5zjpR2ulRCFRpN5s2C0dCtVcf+VlTb+nf24S2nuVMJeM
         ieS6kExi+4k1AZgWtOsxX5zANtXpxmSIOdGcxO/W8LO7acZy8gUXGqnPXhTimKNpFs3y
         hzyxT9irCLgPgG9vb0hdqmjGPd46ewVimJxoss/Cnn1eQSOSocwjD/jt8+FImCRULDGz
         SWYGerlcnflMTubBA4LJAazRE7yv1RwrtKB0BepS1qY/QMbrDT32lVdy1LAHpKlhpfbU
         qQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737099123; x=1737703923;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhnZV2qLygGGQYrfuXJ4IFopDJzf5nAynmXZ+qlJOqI=;
        b=wWx1X5VNvwZM+ij18orp6xVpkZGu4OHlB1nmFel46XcPLd9bFEjYNIP/iLJaTbWD5J
         cG5fu1lPFBK+5oAbZ6zCpOd6xeCzSUVbjl1gUThPzEByUeSN2m844fLdYeqe4zsL8KzK
         i2g5t3v7a82aNkjaXdgKXt/M1Ext35aIXnj3QfWdidOlMZTcWYnGQeUyFGzOdwr2omi7
         ZW7m4y7kkZsk5w529Kp0iS9FIfeZVFUxbDN+JaOAT0rLmPN+8WQXItnlkX8TNhWJx+Ly
         Q+0MlKKH1Rzg2woNhLQv10DtSbKONZnxyEDAVix1N/ecd+KfqOCtDHp6P+JpgVsNrqAT
         q/8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHnPO/C9XXHIAUi0bGLOz1tMCFO4BkK4Eaezw1Mi/LfYNUaF49L91iD4uSc1O3osloQcW0W6uvLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyU1+7U35pX1uQPx05vBlh/jaujVaKqDOR+WO1HcahEDP9UKW7
	WCKwCydMZMX62pMF3/TuJGWPNC+NsxY+8AvjWDCkD9EV2bdrETw9LKz74HazELljH6ykzF8601h
	G
X-Gm-Gg: ASbGncuJ0IrVRfAS34IGwKMlVocux0rhtivgG4WGNLRtnjW9qlWSSbMUYTs3KNk4X4N
	KfFe1OTMQADelir4HuSSbhzCSvL6hn+W6Fnars4HW5nnLzvpyW/4cb1xfjOlc+kdWEPrhyqH+kZ
	iCt5NmV9z8P8XbRoUlu+Ucrr6unRvy37nddl4+eQg13dog9GAT6gxBwdByAeOaZnT5nANblNKTq
	CNEmX3oHb09wriXOm2XfZjtLeldXnKUMATG9s5bYBIQjhQrE8kQUjxHXqzn0pol8sWN0tRS5yhX
X-Google-Smtp-Source: AGHT+IGa9SO+65kR3fV0CVKf2Dpp0m4XXlC1sodI+HOrGtEKptb60EuOzshMaTW5d4BO54Rq0idoyg==
X-Received: by 2002:a05:6000:156e:b0:386:3c21:b1f7 with SMTP id ffacd0b85a97d-38bf56789d7mr502409f8f.7.1737099123403;
        Thu, 16 Jan 2025 23:32:03 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c753c60csm82333035e9.36.2025.01.16.23.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 23:32:02 -0800 (PST)
Message-ID: <3712d97e-8a2d-47fb-8f95-a9153c71dab3@linaro.org>
Date: Fri, 17 Jan 2025 08:32:00 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] soc: rockchip: power-domain: add power domain
 support for rk3562
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
 Finley Xiao <finley.xiao@rock-chips.com>, linux-pm@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20241224093920.3816071-1-kever.yang@rock-chips.com>
 <20241224093920.3816071-2-kever.yang@rock-chips.com>
 <CAPDyKFqYjTsWsqf-C+iHJz3x-RKdsm2-2cPm-HMeH=WBNzcSLw@mail.gmail.com>
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
In-Reply-To: <CAPDyKFqYjTsWsqf-C+iHJz3x-RKdsm2-2cPm-HMeH=WBNzcSLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2025 15:46, Ulf Hansson wrote:
>>  static const struct rockchip_pmu_info rk3568_pmu = {
>>         .pwr_offset = 0xa0,
>>         .status_offset = 0x98,
>> @@ -1429,6 +1471,10 @@ static const struct of_device_id rockchip_pm_domain_dt_match[] = {
>>                 .compatible = "rockchip,rk3399-power-controller",
>>                 .data = (void *)&rk3399_pmu,
>>         },
>> +       {
>> +               .compatible = "rockchip,rk3562-power-controller",
> 
> I couldn't find the corresponding DT patch where this compatible is
> being documented. Can you please re-send and keep me posted for both
> the DT and pmdomain patch?

I already commented on this on 1st patch - the split of original
patchset is entirely broken and actual binding is missing. Or not
missing but sent to entirely different folks in different thread...

Best regards,
Krzysztof

