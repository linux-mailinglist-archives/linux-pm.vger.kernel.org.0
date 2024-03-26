Return-Path: <linux-pm+bounces-5380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2B088BA6B
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 07:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C332C170F
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 06:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28C7130A62;
	Tue, 26 Mar 2024 06:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvJiQP3Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA317132C1A
	for <linux-pm@vger.kernel.org>; Tue, 26 Mar 2024 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434566; cv=none; b=WoKg7sVEUVBb0+F2qqg8pWdgO78Cau+KtHdMD+bkxqHjHOIk+7X9JGHGWKPQdb55D/DFcyB2bOkBm9xYNHSA+TN5V1LJnaBWrLcUOCZK3wKwglasVWCAtMuuKj54AzdvKngHY+rxH7xj6yr9XwQ/6rq77VXx6cAdxAJZAr6Ltw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434566; c=relaxed/simple;
	bh=SR9YNar3/X3F4Y7T5Iev7JOeoTFsIajhJNRqCU0l+tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbsFC+pqh+ZWICh+RDmgXXla4u3YjcHgrLcw66yaF6Dnv21xUQ7ahp2uWeTBc4MNfkTxP366WxdrthFJwPDjPtmPc0mEW6lqvfOf9Ln3AWo8IinnP0hkQS1cth4joNxdX3MZMp8JchKFiNOtdjWvlMnw2Kf3Fck8QVuSGHbSgqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PvJiQP3Y; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5688eaf1165so7033003a12.1
        for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2024 23:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711434560; x=1712039360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5QDBHaSC5fntPQdx5nI9UDxMCD9F3a8euvISqTDLhTk=;
        b=PvJiQP3YbGwbuoAej92Vu/nUGx2B7zPW3Pjuid3x9lOyeLvWuK9dxA9N9dfUUrEnL6
         286cgmGkNNGNmsg76xa/iGbZ+iDMymmZ5xPb8alIhhlrtApYktwXf6iKgT4Mog9oFIov
         qr+htwfi4X+9Iqi0GYb25eP1i5T6giUK1OltbGxaCZVZGw/FvPBGDfD0ZFy0fg75OAb5
         uxmPxnXWGvRsgCqB2b6HN0EJjnrOCtwmo/dwJDp/XYk9eoTew7lE0NPyAow1MEauCgeN
         c41EfBQQDi4d9yeDw9/J0WltaG4/aSuNHSegfS/3OgjDNhmhAJd3EU6Bbv14abe+A0Ee
         rHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711434560; x=1712039360;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QDBHaSC5fntPQdx5nI9UDxMCD9F3a8euvISqTDLhTk=;
        b=q4wPDi9fHBWTZfs7Ctlh2uhRvaY1vAQjdKuQj51VtHX4VgRxtAnfVkBpRcxpbr/Pu4
         hrAMioC9yYgboj/uVS+r0ahRusEo/501UpCuVnlZ4ut2EkrYGM3R7/f5Lzre0n+eoull
         gE1uAtT4YxvYzFWE5Q+SDBfjxEtUoezUng5CAjOvbeMmewgslZXUGDCzDJZ+XvavsI0k
         izCua4CDmQ0/lm4/4GBTEHrlqTONO9rPZOcGb1jr7E5cxM85w8SoXKwmTYP8yF805aVr
         Zl+KhLNY7So84J5TaIWYeJhPeJjmzkfTgiasEx8r/2d8JOkJJlBtZLZHTIKKEG/L/2fp
         XasA==
X-Forwarded-Encrypted: i=1; AJvYcCXy9A/BhQy5ab/esZHIiCsXCdSUHe8v7ewAdMWBk8fYl+LfaXpa1R1UREl46C16bTsgCiV5ZQm5KWUcETeR5ZtmGb9ZVqMOx4Y=
X-Gm-Message-State: AOJu0YxCLEyM3EtuXtFNsj/4BdhbAD7E2NwEknsqftO5ee2nyN948CZ+
	r/LKjjyF6NSZsbCT5RYdQ8RfAY3ldU07zgHXUyu+OcVcus2lJSbuJIKTN8DF3Ts=
X-Google-Smtp-Source: AGHT+IHS+Py7F4eCiITse8lcGWhLrhntEwe1W757/7QYsqErqTxDqZZZwsaVh7yrPgaOIa8FUDlqxg==
X-Received: by 2002:a50:9b58:0:b0:566:2aff:2d38 with SMTP id a24-20020a509b58000000b005662aff2d38mr5980629edj.26.1711434559971;
        Mon, 25 Mar 2024 23:29:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id fk26-20020a056402399a00b0056c2bd89354sm219887edb.14.2024.03.25.23.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 23:29:19 -0700 (PDT)
Message-ID: <68dbebe0-acaa-40f0-9a5c-fd49d265ae08@linaro.org>
Date: Tue, 26 Mar 2024 07:29:17 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] QCM2290 LMH
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, Amit Kucheria <amitk@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, stable@vger.kernel.org,
 Loic Poulain <loic.poulain@linaro.org>
References: <20240308-topic-rb1_lmh-v2-0-bac3914b0fe3@linaro.org>
 <d8ed4e6c-549f-4c04-b38a-2d788df8b707@notapiano>
 <dbe90a1c-bac2-4176-8eba-7ad96a182313@linaro.org>
 <8e0cc005-0b3a-4475-bfe4-82ec46d918a5@notapiano>
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
In-Reply-To: <8e0cc005-0b3a-4475-bfe4-82ec46d918a5@notapiano>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/2024 00:01, Nícolas F. R. A. Prado wrote:
> On Mon, Mar 25, 2024 at 08:59:55PM +0100, Krzysztof Kozlowski wrote:
>> On 20/03/2024 20:08, Nícolas F. R. A. Prado wrote:
>>>> Loic Poulain (1):
>>>>       arm64: dts: qcom: qcm2290: Add LMH node
>>>>
>>>>  Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 12 ++++++++----
>>>>  arch/arm64/boot/dts/qcom/qcm2290.dtsi                   | 14 +++++++++++++-
>>>>  drivers/thermal/qcom/lmh.c                              |  3 +++
>>>>  3 files changed, 24 insertions(+), 5 deletions(-)
>>>
>>> Hi,
>>>
>>> I've started tracking the results of 'make dtbs_check' on linux-next, and I've
>>> noticed that on today's next, next-20240320, there's a new warning coming from
>>> this. The reason is that the DT change has landed, but the binding has not,
>>> since it goes through a separate tree. I thought the binding was supposed to
>>> always land before the driver and DT that make use of it, but looking through
>>
>> There is no such rule. Of course new binding should be documented in
>> earlier or the same kernel release cycle as users get in, but it's not a
>> requirement.
> 
> So, after giving the documentation a second look, I found this:
> 
> "For new platforms, or additions to existing ones, make dtbs_check should not
> add any new warnings."
> 
> Source: https://www.kernel.org/doc/html/latest/process/maintainer-soc.html#validating-devicetree-files

It's just "should"...

> 
> What is not clear there is what the reference point is: is it on linux-next?
> Mainline release?

Does it matter? There was never a new warning introduced by this
patchset. The patchset itself is correct. No new warnings.

> 
> As Konrad pointed out it's tricky (and maybe not worth it) to guarantee this for
> linux-next. But for mainline release it seems feasible (and IMO the target, as
> after that stability guarantees should apply).

I don't believe in such guarantees. Different maintainers apply patches
differently, especially bindings, so this is beyond our control. Often
also beyond SoC maintainer control.

> 
>>
>>
>>> the dt-binding documentation pages I couldn't find anything confirming or
>>> denying that.
>>>
>>> I expect this to happen again in the future, which is why I'm reaching out to
>>> understand better how to deal with this kind of situation.
>>
>> Deal as what to do? Are you asking in terms of maintenance of some
>> subsystem or sending some patches? In this particular case here, I don't
>> think there is anything on your side to deal with.
> 
> I'm asking what's the most helpful way to you the maintainers for me to report
> these failures in the future.

The most effective way is LKP-like or Rob's-bot-like automated replies
to original email threads, by testing the original patchset on
linux-next. But Rob's bot is actually doing it, just on different base.

Other reports, like for cases when only parts of patch is applied, could
be also useful but I am afraid you will generate way too much of them.
Binding is supposed to go via subsystem, DTS via SoC, so basically 90%
of patchsets might have some sort of delays resulting in dtbs_check
false positive warnings.

For my SoC I check my trees, mainline and next, and keep adding list of
exceptions for expected issues. What's useful for Qualcomm? Konrad,
Bjorn, any thoughts?

Have in mind that expected warnings can be for entire cycle when dealing
with technical debt, because DTS goes N+1.

> 
> Rob has already automated running dtbs_check for patches coming into the mailing
> list. And I have set up KernelCI to run dtbs_check on linux-next in order to
> catch any issues that might slip through, or happen during integration of the
> trees, etc.
> 
> Now, if we agree that dtbs_check regressions on linux-next are acceptable, at
> least ones like this, where the issue is just synchronization between

Yes and no. True regressions are not acceptable. Expected intermediate
regressions as a result of patchset being applying, but not yet fully
applied, are OK. Expected regressions for intra-cycle-work are also OK.

> maintainers, then I can simply not report them in the future. But we should
> have some point where dtbs_check should not regress, and mainline release seems
> the reasonable choice, because if we don't then dtbs_check warnings would just
> keep growing forever.

I invite therefore to my session:
https://eoss24.sched.com/event/1aBEf?iframe=no
We'll see if they keep growing :)

Best regards,
Krzysztof


