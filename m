Return-Path: <linux-pm+bounces-9502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE7590DC3F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 21:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5848F1F22DDB
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 19:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FF215EFCC;
	Tue, 18 Jun 2024 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oH0hcvFJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92CF15EFA6
	for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718737927; cv=none; b=T5PA2jIREWQmIt8XnOxpxAPBnAaoDhv/QhPCCWOn+Iz9Zd8AUERmZSJgTX1ZjjxUlQm/A1Cp5Rwlh9BcHTR5h9EcoEsRU834OYvnFm1dm7wtxo4N2BCGRdvbhGdqcbVlWCdh+BU+Yp36rd40NuUsDdM9keepOD2z+JZx8edUPbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718737927; c=relaxed/simple;
	bh=V6TUkHZXRl29GH5tB+9zD1O+XS7wyCwcd/6nrTmB+zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AMZBug6UBb7GWW5qbQh69zXvwjPuJwEKxRPfYFc78HoikIAkDmkVr92aIvsNGz8D00jS/7ELN0u7nRn3/wQxV/lnXvQU74bZhbSfkbPcDhFAkHHKV/850o9t308PIeww3iIw2/pSlMl3/OrmDOT3ZQRJkaMUvdTp7SJut9JgNH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oH0hcvFJ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35f1bc2ab37so5160680f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 12:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718737924; x=1719342724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f8+/cR8dmnRCIY8KO1c6EzfyrRTOkElOzLEANvqSOFw=;
        b=oH0hcvFJ7FmVmxz8THavBoaaaDNUg/2g4Z6LQuingacqxNEXmPzSba9sw4TOfi492Q
         ooW+qyu7XLOz22qJtfnr6/AwZa8qp6je324y00HxdtdPZebey5DLkLE2XUdSAgZntRq7
         3ULheWyKCY99KmTO1ePsCu4PxnXk5M7s1jZcGlXhssPN5elk8ATtHOYNi0t+I5f6qvd+
         TWe2H/5jBl+xtvh7NRA+yfKJWXBGFq7fVgRTq1xBECGXEvF2iXCxeq2jal3oJgtrDO4i
         TC1F+3uLJu3LyNbchFfqH23CB1Xg9OeZsZvFWA0qVcA8y0cYcLSFg7DPyiKuyCGqdLre
         5lLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718737924; x=1719342724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8+/cR8dmnRCIY8KO1c6EzfyrRTOkElOzLEANvqSOFw=;
        b=vLDrt+gNL0z92ppcJ/gC0pQdRUX04VuYp0ktR3FZWEw1k/nhIwx+GSzvXgcr6sENFU
         YCvOltvzkhnewEmis1usNTINT+cIFnRYO0u7Aw9892SlqBTrqT16PZji9Ui+7b1ITsQb
         uwePjlOWxaF3RIVN76WjR4muV98H4uKBraTqUlrv5Z+8SgQib/5LARuSaT/4yInyxic/
         bxdIpPh1eGVKEKT12NPhQIZrMWCi/lCo9FgS9ijyCRxpQ1qeHmjqtAXE9ABCCpq55IrM
         efuXrFW3BQN+nOldYgwc4LYMB0adMAwZEa7RqTBt6iOcP0HLXjynYFHa+aEC4KxhQZpj
         9/KA==
X-Forwarded-Encrypted: i=1; AJvYcCXkyAlq14IGIzw+jrjUf9sajW61XfSIdfm7+6GcdF17FDMy+dJxBkhbZ0H027rvg90FPNmYCEnJ09FKwpIFQ/Eppf0FUJZV2fs=
X-Gm-Message-State: AOJu0Yw0MsMqBTEEsjk0Sn5rzonolseL2MW55APW8TVZ+5m9yapNe6pB
	6IP2OkypqYu8EkXpS2A0btvehblA7g9FjXxX0oj4DCOLy1xKRFIXBhRpTMBMmpM=
X-Google-Smtp-Source: AGHT+IHdn2YVcteO5gHaAZyTpV2RKc9NRMuQMnYAe8emYCZSQL9/iTeEcqYKL05YMuGAZiFOdSXtsQ==
X-Received: by 2002:adf:fe11:0:b0:35e:5bf6:5432 with SMTP id ffacd0b85a97d-363175b8c65mr437516f8f.21.1718737923890;
        Tue, 18 Jun 2024 12:12:03 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:5d11:7fa7:8997:f811? ([2a00:f41:9028:9df3:5d11:7fa7:8997:f811])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-361a85074a2sm2280828f8f.25.2024.06.18.12.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 12:12:03 -0700 (PDT)
Message-ID: <85e03d10-59a2-4f15-bb85-7b2c0354a5d1@linaro.org>
Date: Tue, 18 Jun 2024 21:11:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/23] gcc-sdm845: Add rates to the GP clocks
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
 Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 phone-devel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
 <20240618-starqltechn_integration_upstream-v3-2-e3f6662017ac@gmail.com>
 <wnf3mfgdm4p4f5wrxdtlx4wccnizdvohc7iiyu5t22eeb67r57@xun3r73hksrg>
 <ad04e203-4244-4cd3-9c9a-fae002962990@linaro.org>
 <lwrz4rvn6ogseea5v6j7plc3yi3xnzo76dvrsl3muat3iswlkb@zmwa3xo3xgw4>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <lwrz4rvn6ogseea5v6j7plc3yi3xnzo76dvrsl3muat3iswlkb@zmwa3xo3xgw4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/18/24 20:55, Dmitry Baryshkov wrote:
> On Tue, Jun 18, 2024 at 08:50:52PM GMT, Konrad Dybcio wrote:
>>
>>
>> On 6/18/24 19:50, Dmitry Baryshkov wrote:
>>> On Tue, Jun 18, 2024 at 04:59:36PM GMT, Dzmitry Sankouski wrote:
>>>> sdm845 has "General Purpose" clocks that can be muxed to
>>>> SoC pins.
>>>>
>>>> Those clocks may be used as e.g. PWM sources for external peripherals.
>>>> Add more frequencies to the table for those clocks so it's possible
>>>> for arbitrary peripherals to make use of them.
>>>>
>>>> See also: bf8bb8eaccf(clk: qcom: gcc-msm8916: Add rates to the GP clocks)
>>>
>>> Each time I look at the table attached to the GP CLK, I feel that it's
>>> plain wrong. In the end the GPCLK can in theory have arbitrary value
>>> depending on the usecase.
>>>
>>> Bjorn, Konrad, maybe we should add special clk_ops for GP CLK which
>>> allow more flexibility than a default clk_rcg2_ops?
>>
>> If we can somehow get max m/n/d values for all possible parents, sure
> 
> Calculate them at runtime?

We'd be calculating the mnd values for a frequency that's either equal or
reasonably close to the one requested. My worry is that we somehow need
to get the maximum values they can take (unless they're well-known)

Konrad

