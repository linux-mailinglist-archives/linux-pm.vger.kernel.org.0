Return-Path: <linux-pm+bounces-5383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5142588BB37
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 08:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6EE1F35133
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 07:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3612F130E30;
	Tue, 26 Mar 2024 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gzWsWrn8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF468130A66
	for <linux-pm@vger.kernel.org>; Tue, 26 Mar 2024 07:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438215; cv=none; b=TmeqrgyUkujJ4gcAfYSnOmgMRkE/MO8NJo72Ks91ZqF/zrDAuJjwZ0Yz3D+B/bgVhXsSlekMcVEYtwnciUthYkpyx12TBqUDw92lPYEPhGDajs1z1Sg5nDlzJqp618AX4cugkR/RA9Ks9qd685xFtSMSGAC4Fa01b1lnZxDkhfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438215; c=relaxed/simple;
	bh=qlXHSjD4oRu6T1ULa+mNDp9G2uRL5HO5IKVjGUSBBEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZvBBwAuvVs0c0WVsM3N86raOe/FKYTGO+SOePO3EUOCxkUE6Y3Eb6LxPIom7/Nw3qiSQc9ewYBJCWuhiniVhyW4PTQaRBSZwi+Q3ecSIbRW5CB3SkpW49Bnr9JIN0ogcg20NB7JsemoRpH2d0E34NRLUby+WscI0mGeZ4MlWm1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gzWsWrn8; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56c147205b9so2631064a12.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Mar 2024 00:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711438211; x=1712043011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NS0LFbGO6Diz+O55zW1kIhPFuGDQKse20XAQBsjLplY=;
        b=gzWsWrn8dAydMAjU7M5cDpcTBdcnHaVjoRdketV9VXwlSsGTNdQIkXLPdc4CEpb+7f
         sHmRPLiArI51m4RlbuIjbwDb4vQ49AXZK28cTkQ+FbE8Ta9flaCfHb2gyWVbI5/gmqL5
         RxLekNHaBbwq7/zmwTaWnCUwg5oNL1SxgFBiQ+oJdnxloqbPJyk/0EArPNIbtvagRrOG
         une/vVqWHx4gyrNATboIKL03rAqhUd9Rh4E1ZOQtxxj0tOrbcIyOREf4wp1zm3O1LM1b
         Fuaw4wyNd1bHBPI5RhGTuuJT8ueh4sdL6lvMsyJJV/cLgBM3AauOthFrcxR2usx8SpOn
         BJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711438211; x=1712043011;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NS0LFbGO6Diz+O55zW1kIhPFuGDQKse20XAQBsjLplY=;
        b=csxWg8g8p0Ibp/NqEZShKuizbmM7j+E9LXusKOcDGSIEFwceADG09uQPB4NQpa5skR
         ieQuLIgkrBwbjnwGLiVLUr3IH2xVOITgTEdDja7RkpOtBOtaikqirzbTMKTcxL6l3h6m
         tqcMRCKOo5oijlj00+pqoZeyjPVnrTMSPeIZRurhIg2f7rD88hwRrIQY6QUjzeaIkgRB
         YeK7vAjT7IykSRpCIPfyTcudojQGwvVjjvvT2rmBo4t5E9n3mQAX11xKv4e/Hk6HybaP
         eBlnf3Nmezb42zLiyUYynbiqfvnMxY+TPK82vG2oo9oIer6VIQ3t1AzfoYLq+gQbPr1x
         Og7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUc4YpUkWOqv/N4r1Uwm8s5lrikzM3Buxo7wjtM0TsZfNRuSJdH5X133wwmu3GzPJZggo8o3hDB+io1F6k3ZXm9iXVj52b2on4=
X-Gm-Message-State: AOJu0YztV1v+eYtRkDTO2tRTqBn720FDFsegWZxRda2nbccEw2hNy7Dj
	rrbLkKKlijr2hRT9N4HF0q3dH6fLixN84H/YkFRr6NUj8pAWwNgs0xR9hEr/df4=
X-Google-Smtp-Source: AGHT+IHiCRE6k1Cpx73jh67er/H6/gp+YnVuWHmlblCeMCWF2i9jddFGIkvdgtlrEQ0uNnrlDzqI/A==
X-Received: by 2002:a50:9343:0:b0:566:59a2:7a10 with SMTP id n3-20020a509343000000b0056659a27a10mr696876eda.1.1711438211145;
        Tue, 26 Mar 2024 00:30:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id r1-20020aa7cb81000000b0056c052f9fafsm2969290edt.53.2024.03.26.00.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 00:30:10 -0700 (PDT)
Message-ID: <a259fa95-bfc3-4959-a159-8683df473e66@linaro.org>
Date: Tue, 26 Mar 2024 08:30:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] dt-bindings: interconnect: add clock property to
 enable QOS on SC7280
To: Odelu Kukatla <quic_okukatla@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, cros-qcom-dts-watchers@chromium.org,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, quic_rlaggysh@quicinc.com,
 quic_mdtipton@quicinc.com
References: <20240325181628.9407-1-quic_okukatla@quicinc.com>
 <20240325181628.9407-4-quic_okukatla@quicinc.com>
Content-Language: en-US
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
In-Reply-To: <20240325181628.9407-4-quic_okukatla@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2024 19:16, Odelu Kukatla wrote:
> Added clock property to enable clocks required for accessing
> qos registers.
> 
> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
> ---
>  .../bindings/interconnect/qcom,sc7280-rpmh.yaml    | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
> index b135597d9489..950ecdd5252e 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
> @@ -35,6 +35,10 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  clocks:
> +    minItems: 1
> +    maxItems: 2

Why is this flexible? Nothing in commit msg explains that. I gave the
same talk twice, gave there examples, yet it is not enough...

https://elixir.bootlin.com/linux/v6.8/source/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml#L132

> +
>  required:
>    - compatible
>  
> @@ -57,6 +61,7 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
>      interconnect {
>          compatible = "qcom,sc7280-clk-virt";
>          #interconnect-cells = <2>;
> @@ -69,3 +74,12 @@ examples:
>          #interconnect-cells = <2>;
>          qcom,bcm-voters = <&apps_bcm_voter>;

If all devices have clocks, then you could add them here. It seems not
all of them have clocks...

Best regards,
Krzysztof


