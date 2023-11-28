Return-Path: <linux-pm+bounces-334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84C07FB2F8
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 08:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053F01C2074B
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 07:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215DA13FEA;
	Tue, 28 Nov 2023 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8JzAzLj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16487D41
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 23:41:13 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-544455a4b56so6668517a12.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 23:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701157271; x=1701762071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eWAZTNH1owl43DfAMqnorKC9heAavDsuXgKZMRgXHEQ=;
        b=I8JzAzLjfDMeDwevOXnQ6J5AgStAT1Cih3CQcpmr4Lxby3qrZL8ZRApGzAKT4tPzj0
         TLp8vZdl1nU4Zjjsq/7QLPQUa48UqCEGCvozg9a+SmiZ3MwJMFSbGVcH5XmdciINPjDy
         /CRt+EqDgIubyc1yU9hwh3eUUar/+ELwQksVTI4XUBWLOZSA0BzYLCeJXu/qg+kkThsp
         QrHtC0tSvvLxSPaJ4vs6V4gvRveDFuGx2gKX/N00TKueOHRuvEyndYZtwbx7w8g23OC8
         jtmxiXmZTLoaXaG1JCHNwWIEXNcrhpG2frBjrmDkbGH9qMQG1JhLYeA0k1ehqSov9BUK
         yGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701157271; x=1701762071;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWAZTNH1owl43DfAMqnorKC9heAavDsuXgKZMRgXHEQ=;
        b=jZ1psGH/+4O7vYQ6YVp2hFxOuvPpVpiH/Fnvhh0g+yCwrG4RjbnowgFr5/ga7KbjI9
         oJGO02D0V71EYq7FKsfifbBytcrE/H9njomiJcjgHmGsBWaxzghooyFH8/ddr7oOh33m
         l0dNLnwWtUdNESvS/GBKrt1PEiWpjFX4fygpnx6fLuNtvYjeGTnInHshcsLHnzEsjwqE
         8NHjA0F1mtpXhMj4v6qKmvqxOf2YnLUog5es2RVItmHvsD/9tgq2E8QRPNquHgV4IRUU
         RL1Jc1Jz8N/I3VFGfyWx7NsxzBZpw0Uab/nVgOuqnEsdUlWKRjCtrlOJ2JMUTlfVSi1G
         JRQQ==
X-Gm-Message-State: AOJu0YxAbn3bAAzzT67e9h9YVHmjaBWNKPg1DpTuvMqt6/slyZckgUmo
	Qlok0TsEldEroEvqg3lVKS+9kg==
X-Google-Smtp-Source: AGHT+IHeWsC7fml3P7Hus4eFMCtgG/ZqAyXDpOvFkPrBX38PZz4jJDFbWN3YM4jcIIHlPrIHOOxHPg==
X-Received: by 2002:a50:9312:0:b0:53e:3b8f:8a58 with SMTP id m18-20020a509312000000b0053e3b8f8a58mr11696420eda.11.1701157271546;
        Mon, 27 Nov 2023 23:41:11 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id w4-20020a056402268400b0054b2daa6654sm3413986edd.56.2023.11.27.23.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 23:41:11 -0800 (PST)
Message-ID: <c30f126b-d295-4482-8a7f-5dc5cf651e84@linaro.org>
Date: Tue, 28 Nov 2023 08:41:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] dt-bindings: thermal: sun8i: Add H616 THS
 controller
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Martin Botka <martin.botka@somainline.org>,
 Bob McChesney <bob@electricworry.net>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <20231128005849.19044-1-andre.przywara@arm.com>
 <20231128005849.19044-3-andre.przywara@arm.com>
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
In-Reply-To: <20231128005849.19044-3-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/11/2023 01:58, Andre Przywara wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> This controller is similar to the H6, but covers four sensors and uses
> slightly different calibration methods.
> Also the H616 requires to poke a bit in the SYS_CFG register range for
> correct operation, so add a "syscon" phandle property to point there.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 30 ++++++++++++-------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> index fbd4212285e28..95a6ab9a5889b 100644
> --- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> @@ -20,6 +20,7 @@ properties:
>        - allwinner,sun50i-a100-ths
>        - allwinner,sun50i-h5-ths
>        - allwinner,sun50i-h6-ths
> +      - allwinner,sun50i-h616-ths
>  
>    clocks:
>      minItems: 1
> @@ -63,6 +64,7 @@ allOf:
>              enum:
>                - allwinner,sun50i-a100-ths
>                - allwinner,sun50i-h6-ths
> +              - allwinner,sun50i-h616-ths
>  
>      then:
>        properties:
> @@ -80,6 +82,18 @@ allOf:
>          clock-names:
>            minItems: 2
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: allwinner,sun50i-h616-ths
> +
> +    then:
> +      properties:
> +        syscon:

Nope, there is no such property. First of all, properties must be
defined in top level. Second of all - this is exactly the example I used
for my talk. Two times.

> +          maxItems: 1
> +          description: phandle to syscon device allowing access to SYS_CFG registers

You must also say what is the purpose. Drop redundant parts like
"phandle to syscon device allowing access" and explain what is the hardware.



Best regards,
Krzysztof


