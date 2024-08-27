Return-Path: <linux-pm+bounces-12944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5199605AA
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 11:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2638281F2E
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EAE19D880;
	Tue, 27 Aug 2024 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v2NO6o1o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD911990CF
	for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751216; cv=none; b=KVt0prcYeF5uZZThozTWwQg1SrokQpcGaeagKEFrbKbBj8WysMZdxMHdGW7bxlDs2G6ZaJqi1cY5fhyu9rABDQgw9OzWKYzk3aTV/CT0obtJGrHgMvxVcY0tocWPB0cM9LDSC5sHJswNquKsiRHVc78lpx0rn/t4STo9TOh0mnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751216; c=relaxed/simple;
	bh=EeA7qq3rsJ55dQOeLzkCx2GOeBOL2372aylz0/+ODo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRfQg/haCTRsSaTN7bz+ZvSb0fdBCOYhAVvPd82s8oPxaVaCr/MAg6aAaqiqQW6NNuSoWTopIHwv1nsTRd7c6j4XXXAhCwcaJfKiN5y0Q2GSGu7/tH+aQfuafOOCyxHPXtHj4rWjCxyLGYZNx/+HPSAsghl4n1eQAdkkIqIya5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v2NO6o1o; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42803adb420so6668865e9.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 02:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724751212; x=1725356012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xhCRE/Dt+PARny9PJYa/9C1D1jCS6Em1dPLj6ri+rj8=;
        b=v2NO6o1o/UXs9oB1Hk13noVlNwopbn7cdLhRjBtvl7P7c5BeB0bkffBoAmlYcqfBAc
         NBXzNHxRaKltRpU9ZbkT5nhy4gsEZA7Xi9V9s0aldqR1Cxiv1dg5gvj3YBbetwJLWKf0
         szYO9UnMKspmkORZ7hcE14pBKa1UFbrPk8TUxSSAHsxzxg4ryJC5r10HE4oqmFG0tl/p
         hpPr51sByvV5Q1N+5wV0txPKHpyH8m/hbZ8KdgGoQ7VpwRhFk9MP1hGqRDICqNpR50MH
         yhV3mPMEN+SKcgj1uLMjMj/1ICAa+G4nyI2Gw1PbJaRY6T96H+/4nVcYljZQd0xiB8Os
         Sbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724751212; x=1725356012;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhCRE/Dt+PARny9PJYa/9C1D1jCS6Em1dPLj6ri+rj8=;
        b=JGzSt/emb0GM4qWze5LGmLXjKkyny9uX0AAbkdTONZkNnHvRBrDhpa33iiV+M3SMA7
         7vzEiaS6tYucr8Vn3z/0b9yMJqipceifQUr+09mzk+cCrpMYlH479xVJzpp8KpKmcEqy
         l+hV0jlJxixlZM8ik8Bhd4uPStBiU3djK5+gxpgyZY6Jir9roYuyk5PGMEWuSlZdW/Sd
         AZ3frdGAjccrxx9OYXThvkCyPsS4ndUPWMluVSctZZ5pwzBXonNpdaBFL0gWIkvXx/rr
         YSbIIgjm9Kv9BdxCMzTv/Fue1/GB/pVHVrOjaUlzLkqpw0BFIr9XOXxsFUSkdLe4RALo
         zFXA==
X-Forwarded-Encrypted: i=1; AJvYcCVskLMfCnwIHAUaqqFYJeNnpgdVCkSmT9NnUdJ9RfS/SggiaVFGZKHgMZBfNz3X9GXR3Ab2ezkvqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdm6XJ3zu/pDLD0MTMrY0DYPAI0nUfYrXICmBY9/Qf7Z0P7PpI
	tbtu/GHZJQNcrjsymxhsEe5XxR/Qy81oD64S5JUsImG6j6/7QWC/xoUW3HbOr60=
X-Google-Smtp-Source: AGHT+IH63pkESvr8WAGG6Va2kOWPz/dYDrPxiymv32ZbAdx/cvZUiR85ioNyNii7YqJtjoTUp0YkxA==
X-Received: by 2002:a05:600c:1391:b0:428:f1b4:3466 with SMTP id 5b1f17b1804b1-42acca00571mr54085815e9.3.1724751212175;
        Tue, 27 Aug 2024 02:33:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefc626fsm217777435e9.31.2024.08.27.02.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 02:33:31 -0700 (PDT)
Message-ID: <a48f1a0b-0e20-4782-bf6b-c430da9ae391@linaro.org>
Date: Tue, 27 Aug 2024 11:33:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] pmdomain: renesas: rcar-gen4-sysc: Use scoped
 device node handling to simplify error paths
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
In-Reply-To: <CAMuHMdV0R0+u1eCiUOHhL5w-wzge9KhgyumJSd28oF9kQmnx_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/08/2024 09:48, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Fri, Aug 23, 2024 at 2:51 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> Obtain the device node reference with scoped/cleanup.h to reduce error
>> handling and make the code a bit simpler.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Thanks for your patch!
> 
>> --- a/drivers/pmdomain/renesas/rcar-gen4-sysc.c
>> +++ b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
>> @@ -303,12 +304,12 @@ static int __init rcar_gen4_sysc_pd_init(void)
>>         const struct rcar_gen4_sysc_info *info;
>>         const struct of_device_id *match;
>>         struct rcar_gen4_pm_domains *domains;
>> -       struct device_node *np;
>>         void __iomem *base;
>>         unsigned int i;
>>         int error;
>>
>> -       np = of_find_matching_node_and_match(NULL, rcar_gen4_sysc_matches, &match);
>> +       struct device_node *np __free(device_node) =
>> +               of_find_matching_node_and_match(NULL, rcar_gen4_sysc_matches, &match);
> 
> This breaks the declarations/blank-line/code structure, so please move
> this up.

What do you mean "declaration structure"? That's the way how variables
with constructors are expected to be declared - within the code.

> 
> If you insist on keeping assignment to and validation of np together,
> the line should be split in declaration and assignment.

No, that would be inconsistent with cleanup/constructor coding style.
Maybe this is something new, so let me bring previous discussions:

https://lore.kernel.org/all/CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com/

https://lore.kernel.org/all/CAHk-=wgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuESs1JyA@mail.gmail.com/

https://lore.kernel.org/all/CAHk-=whvOGL3aNhtps0YksGtzvaob_bvZpbaTcVEqGwNMxB6xg@mail.gmail.com/

and finally it will reach documentation (although it focuses on
unwinding process to be specific - "When the unwind order ..."):
https://lore.kernel.org/all/171175585714.2192972.12661675876300167762.stgit@dwillia2-xfh.jf.intel.com/

> 
>>         if (!np)
>>                 return -ENODEV;
>>
> 
>> @@ -369,14 +365,12 @@ static int __init rcar_gen4_sysc_pd_init(void)
>>                 if (error) {
>>                         pr_warn("Failed to add PM subdomain %s to parent %u\n",
>>                                 area->name, area->parent);
>> -                       goto out_put;
>> +                       return error;
>>                 }
>>         }
>>
>>         error = of_genpd_add_provider_onecell(np, &domains->onecell_data);
>>
>> -out_put:
>> -       of_node_put(np);
>>         return error;
> 
> return of_genpd_add_provider_onecell(...);

Ack.

Best regards,
Krzysztof


