Return-Path: <linux-pm+bounces-387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286BE7FBD23
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 15:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1921282CD1
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699665B5BA;
	Tue, 28 Nov 2023 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pk101a4/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9A8AA
	for <linux-pm@vger.kernel.org>; Tue, 28 Nov 2023 06:48:22 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a0029289b1bso768857966b.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Nov 2023 06:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701182901; x=1701787701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YXM2QvVCfM/PcFCqOwwKdvg2nVXyFEWc8mKRxKzbzTQ=;
        b=pk101a4/CwbMf3wXq3THwftGYH7H8dO4zVHkIX3HqEbeB6Ot0nEnJY9Txg86xvmMI8
         YVW0S+QsIPRIY+0v1voM7XJvpk9PM0nZfr12JMI3pTo4Zt88QKzxwyXl0MtQywSieZKA
         8FyxdbYlArqKC3tUmQ6LO9x+2ZNXiRASCnQtzqTGmJ5Nmjh8rXqxZAu6NKJjuLnOz4Xi
         j5YiVl3BFJebP86kHZhGeoxlBgVDGuhlfv35PB/58jHgRuk9VnXXtEU/P5/abFCbho+U
         b27RkQooINGqSCzQ/9OclThVeg3gG9LqvjBezA8VSBYVwSzI3uwDsF3curSBXzHMP594
         8YuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701182901; x=1701787701;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXM2QvVCfM/PcFCqOwwKdvg2nVXyFEWc8mKRxKzbzTQ=;
        b=quif8oez08/FjTfXwpcbUm4GuH77BsR7HPa2RFThfS7EeZqKnP96bg0H/OxfoDL+Qd
         MwQWewqmj1oP5mZplpwJ5+28FOy8o5FOmaAedqOIg13mwLF7MgipdtTPp5WsTGDxKTVU
         7EpsMPTrZxcScBG30wlb6AlP/ob6dATdGu7Bt19Aw8DB13pjGjSJ+X/+/ri1LE6nuvGz
         IAbF47i2lgy+AXzkzN3FpOfkiS36BdCqtMjr6hQ4V+t+GFpsC9IA9jZrHCGAGT5QN5j/
         6U2j5sVYXvt1a4nudJg3yQXs2IQ9RZCelx0oOMyVvcGtR5Uqw62FJJSjKDa2HGIgCqW1
         l3gg==
X-Gm-Message-State: AOJu0YxkBgZUKteU4hKR212C8uKYKnxLJosY/2NAglFehv97YmFhmCl3
	zgb0ula4oBpCyp7T8l2ZVIklig==
X-Google-Smtp-Source: AGHT+IHXkszZI4Dc6MOOOL7fYPkFDn7aB1/w1V2XnU19A5IPpq4XJl+HD8u3ZmfUBoElU0FeS3Drrg==
X-Received: by 2002:a17:906:20ce:b0:a0c:46b4:a70d with SMTP id c14-20020a17090620ce00b00a0c46b4a70dmr7003390ejc.28.1701182900768;
        Tue, 28 Nov 2023 06:48:20 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id kz15-20020a17090777cf00b009fd50aa6984sm6846778ejc.83.2023.11.28.06.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 06:48:20 -0800 (PST)
Message-ID: <4e90608e-aca5-4b57-be76-350ad54f9e7c@linaro.org>
Date: Tue, 28 Nov 2023 15:48:18 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] thermal: sun8i: add syscon register access code
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li
 <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Martin Botka <martin.botka@somainline.org>,
 Bob McChesney <bob@electricworry.net>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Icenowy Zheng <icenowy@aosc.io>
References: <20231128005849.19044-1-andre.przywara@arm.com>
 <20231128005849.19044-5-andre.przywara@arm.com>
 <ddceb30f-1778-4312-af91-97813fe3c6fb@linaro.org>
 <20231128143309.38a4ce61@donnerap.manchester.arm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20231128143309.38a4ce61@donnerap.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/11/2023 15:33, Andre Przywara wrote:
> On Tue, 28 Nov 2023 08:43:32 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> Hi,
> 
>> On 28/11/2023 01:58, Andre Przywara wrote:
>>>  
>>> +static struct regmap *sun8i_ths_get_syscon_regmap(struct device_node *node)
>>> +{
>>> +	struct device_node *syscon_node;
>>> +	struct platform_device *syscon_pdev;
>>> +	struct regmap *regmap = NULL;
>>> +
>>> +	syscon_node = of_parse_phandle(node, "syscon", 0);  
>>
>> Nope. For the 100th time, this cannot be generic.
> 
> OK. Shall this name refer to the required functionality (temperature
> offset fix) or to the target syscon node (like allwinner,misc-syscon).
> The problem is that this is really a syscon, as in: "random collection of
> bits that we didn't know where else to put in", so "syscon" alone actually
> says it all.

Every syscon is a "random collection of bits...", but not every "random
collection of bits..." is a syscon.

Your target device does not implement syscon nodes. Your Linux
implementation does not use it as syscon. Therefore if something does
not look like syscon and does not behave like syscon, it is not a syscon.

I looked at the bit and this is SRAM, not syscon. I am sorry, but it is
something entirely different and we have a binding for it: "sram", I think.

> 
> 
> And btw: it would have been about the same effort (and more helpful!) to
> type:
> 
> "This cannot be generic, please check writing-bindings.rst."    ;-)
> 
>>
>>> +	if (!syscon_node)
>>> +		return ERR_PTR(-ENODEV);
>>> +
>>> +	syscon_pdev = of_find_device_by_node(syscon_node);
>>> +	if (!syscon_pdev) {
>>> +		/* platform device might not be probed yet */
>>> +		regmap = ERR_PTR(-EPROBE_DEFER);
>>> +		goto out_put_node;
>>> +	}
>>> +
>>> +	/* If no regmap is found then the other device driver is at fault */
>>> +	regmap = dev_get_regmap(&syscon_pdev->dev, NULL);
>>> +	if (!regmap)
>>> +		regmap = ERR_PTR(-EINVAL);  
>>
>> Aren't you open-coding existing API to get regmap from syscon?
> 
> That's a good point, I lifted that code from sun8i-emac.c, where we have
> the exact same problem. 
> Unfortunately syscon_regmap_lookup_by_phandle() requires the syscon DT
> node to have "syscon" in its compatible string list, which we
> don't have. We actually explicitly dropped this for the A64 (with
> 1f1f5183981d70bf0950), and never added this for later SoCs in the first place.
> I guess we could add it back, and it would work for this case here (tested
> that), but then cannot replace the sun8i-emac.c code, because that would
> break older DTs.
> So is there any chance we can drop the requirement for "syscon" in the
> compatible string list, in the implementation of
> syscon_regmap_lookup_by_phandle()? Maybe optionally, using a different
> prototype? Or is there another existing API that does this already?

I must correct myself: I was wrong. You are not open-coding, because as
pointed out, this is not a phandle to syscon (even if you call it like
"syscon").

The code is fine, maybe except missing links (needs double checking,
because maybe regmap creates links?). The DT binding and DTS needs
fixing, because it is not a syscon.

Best regards,
Krzysztof


