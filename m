Return-Path: <linux-pm+bounces-3676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0250C84F188
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 09:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0BA1F286A7
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 08:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C9067E98;
	Fri,  9 Feb 2024 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C41hl/6f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA0E664C3
	for <linux-pm@vger.kernel.org>; Fri,  9 Feb 2024 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468050; cv=none; b=ZAJ92cebRF23cDcC+EIkAIF7MguWrkzTlrONJgGCJy7lCJQtz+ud8uh2cdiPSJJZ5WAhTKDU8om7t1lKxVahlRoaIlBP/kw/Y+OJvIVDz/tEaCyxGmJc5GPdjwWRcKO1ph8PZI8iVWrPNjL2eGQq4YMLXXZqfYmkP7Wf7VQakTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468050; c=relaxed/simple;
	bh=D52U6RCOwTXdjvOuG5ThiAwzGWauNPFTL7uCjDuqrCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sz9vanO6eL+5onFBZQrQaPPoXpM0pCMQuzcmamcj/X+LZ5f3AMCphd9xeSiX8XKuy2dB2H4elqGRavwAcS9Oo0u87aZLpmvTOdf/BZ1wtvtYnad/Gq9FezFmvhc9dz1YLRVISGT/RX0Z93wJQEJzg8jF8KmM69Rr+ZGBhV7BpCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C41hl/6f; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51142b5b76dso1070338e87.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Feb 2024 00:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707468046; x=1708072846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5j6Idpi1IBtNUQwdNNsR9mTeZh5ZtkWz63O8RSjg7eA=;
        b=C41hl/6fuOIPBglEZxgKgPzz9MlKAE4MCV1G38WSGAmgInNGJf4U4uZ0+GWGr5k+HN
         WaU3rRQZqrxdQzPhsHjAwO64iy5RJTZIwKS3eSFhwntgWVtRNDsUyy5eSBvtE2Bwt934
         rK79sMy1yu/HUROYGbKTz0kwKBjS7MMbpxMKLqX6NibJTH2UgnrNZjplxr1vN23srQ+u
         5Y8riI8DR7AnLVzRT6LCBVG8Q07MayIgay5TyQLt34souTQyDyZwMA4W6vv5J6rYWWhu
         9Pb4rJDTLkgZpQXZX1fSi5U95qaAQ3xQtPS+H9Wd0lkPUWizNeVNAVcE6M69k5fvYFI6
         3LPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707468046; x=1708072846;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5j6Idpi1IBtNUQwdNNsR9mTeZh5ZtkWz63O8RSjg7eA=;
        b=clwyDl9tZ+blfvxZVBBnJwHujS7jrjaSa8RyWn4rLBY9BPcZ43lwhUK3S/I1kKOT+W
         mLGiYLW/RWP02ZPW4dqoTsHjg4iOSgLYqmbFaE7FX17XMzqJPDJhAXX/33PuW4cuzsfv
         KAhIZLZ4OD3GC1lIyin+j1QW9sjY0xXibZKzTFhioSpHjlhobsexZV8uf36EqaVRYYEu
         FW72AnliqRxZG2Ue5/zGhkV+jWqMuL4jfrRYwMT8FhuRsLmXEPhSFY0N4WqKtpx+o+9J
         9M+LB9dOlb5mTTXaKfhu/hqT9UKVdAMC+KQVHiZeaXO82wOyPWY0Te/glcASLTvYY0fn
         1UvQ==
X-Gm-Message-State: AOJu0YyBjSqYq7GsEYFCYd6ROYEzVQNHV1c6dlsAYCP29wGYKUZ6Km/6
	ol/YOKLx8MXCl2GFibrJ8i2LeXyRsDGWESqIX5rkO6pQtqMYE43TzcP5SGvvov0=
X-Google-Smtp-Source: AGHT+IGm4sdMHz5fvbBKA4fpUvSO937ck2kqN1HSnwwxHiVxf6YXBZjHnXJOqe4w0knC+XR6KBIHKw==
X-Received: by 2002:ac2:5f76:0:b0:511:1790:e3dd with SMTP id c22-20020ac25f76000000b005111790e3ddmr572810lfc.54.1707468046300;
        Fri, 09 Feb 2024 00:40:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+hJJIhlBgwfTaleax6yohFq4v2QVusQt/MBhMG1yHGTEmfPuDe4MvNGdV3PbBM94jDHCq5nfJwCbjLdnmYwmJuyrea1gLzW9+0ABE+5BUbHx9mn14aBaOPqxPzwsRcgl++WsCoj8B/bxz7mSJlMyYFuiDjI7fFn9XTZ3iHnvCOk5MijEsB5vOSxznpnALBoLJLiywBFuEJJhmL721GctR1j5loWvko4ffAXHVpWnjo8rmwi7Ar7GjgOrmdmaCIwCS/hwOJBgshtT5x0q5RDXGjWwu4E8XDvwtkYjX+vizSQavwq6oKxI4i0Rnz6FbefEy5zuYsB+EvaZ8Zi2kfY6LHAt1oIWW/0Kco8lfF/b+VnBLDfsSqfHil4yH8+yZAjhcMdrD2lO6DMXVVNaKY/Di4UZhgGFSXR5AP5zoA6XczzdckWnnktDvq9bGSWkGpOBy8eIkIFNXrHGSYqEpba1ev44Ah80CkLwnHdGK4JlLZdZyORPDo3VXO9WCU0LBLFxcIU+SWTkXc5UCGGy4+8fxdq7+4o79UNASr2k8n6NAqZCCJ+ml+kV8yHDxy0+FOnD6ZeuO8FMJy1jyr0JoqdpWVwM5NVtwbihZBjjdZovvEBeuCkVxTQ==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c190f00b0040fb03f803esm1860861wmq.24.2024.02.09.00.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 00:40:45 -0800 (PST)
Message-ID: <6a4f516e-dd86-4a88-ada1-89b1dbac0560@linaro.org>
Date: Fri, 9 Feb 2024 09:40:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] dt-bindings: thermal: mediatek,thermal: document
 AUXADC 32k clock
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Daniel Golle <daniel@makrotopia.org>,
 Sam Shih <sam.shih@mediatek.com>
References: <20240209055203.17144-1-zajec5@gmail.com>
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
In-Reply-To: <20240209055203.17144-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/02/2024 06:52, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> SoCs MT7981 and MT7986 include a newer thermal block (V3) that requires
> enabling one more clock called AUXADC 32k. Require it in binding.
> 
> Cc: Daniel Golle <daniel@makrotopia.org>
> Cc: Sam Shih <sam.shih@mediatek.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


