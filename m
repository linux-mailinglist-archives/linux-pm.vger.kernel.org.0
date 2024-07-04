Return-Path: <linux-pm+bounces-10584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFDC92719B
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 10:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368DC1F23354
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 08:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCAF1A3BC5;
	Thu,  4 Jul 2024 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NKY1Ej1u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881F41A3BB0
	for <linux-pm@vger.kernel.org>; Thu,  4 Jul 2024 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720081445; cv=none; b=UsuwmDoZwZmrXxNnrZy4DQtqR4UG3lJmxJJLgpfMCDmpviXjhvNzCffqJO6+sfPi7yaSa9ZtkJDmF3xn+a9fCMm98QqcUr5Y/rrZOzSkdt9CfVzZrHBjXAjvRl9kSMqb3ryC56FuZxcbEXZp5WcncyISm7KeFOqt0VWnzqQUZaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720081445; c=relaxed/simple;
	bh=IDnYpu6LnIH+k0zmCD3wUrVsalUVdhXmRpn0RlxEM1k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QiKMEaIv617/VyHRC+ay5+nasyh7fG7XJjQLT6pT+1bLpXRETco1jW8xK1ABXLE/8rvySm9BIbKiLJFLCJR89vfUgRHYvg5NTeu0941qkk/kz832TlA4/ftI9dPRkMAtFL7t9tIQ1AoYVwLk+o2W6RvBfsNe0Z8+jaX6CahXoJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NKY1Ej1u; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-424ad289949so2297715e9.2
        for <linux-pm@vger.kernel.org>; Thu, 04 Jul 2024 01:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720081442; x=1720686242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqCtJ5y5zSnhwHC2voq3IkAJVOxWAlAg39jm3a/zAaI=;
        b=NKY1Ej1uUsKo5b9ycDMpTZhhiJabgYKjsgfsAp6L71jv93kOew7eqvhzG5iHuAt/A1
         jsMqKRGwnRTf3R3Bhc2GFT1+gqChfwyAkqP9CldeDgfZrckBmYrhm20fCyFNSyPViokw
         CYNHIJ+g5MpeYazoarQ3Bo32NwHua7PYmjtiWs2wMZCJMa80JhJE80F4/cEOqgnjOoMn
         HLQYitTqdWftfEjx6ESqC1XVjtEO2Sb+iRUAH/MxG98W+rjRhm6Rwxlfx7u1XSLLmB8d
         XQ61SarjC3nKsX+3mLABPmFZ+OIm9M/72hDJ9bg2OxRs6XsEQlfu/KZ2irTZdoz5Pmr4
         hHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720081442; x=1720686242;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZqCtJ5y5zSnhwHC2voq3IkAJVOxWAlAg39jm3a/zAaI=;
        b=NBeXOU4+6uSV3rLh4selo7MjgWdBaJ8HtOnbpC0yTkOQXTUkYXKbGJ7C0xBWg5F1RH
         4FpjxlpX1u2DoWW0NjhzPWhkoWAi81j/my5RCgJ9IR9Evds5YadK8o3uEzgWh1hsT6ax
         OAhiH0VONX7SGAl51dnY+UtuRhBXJLIyt5TMzpClG84eOPAEDpR4Otc744jiMV0kA30W
         uRbB/YbCPmuOo4M7p16dHRRWvsZmWwaDyt2N1DOoZSnEwLuRR2YCKA8qlC0uyd2mHSAq
         UFtNZLjowuD3rspBwFirTwjqPrXRXythzIWZ69eJXOVtQyDscP48WHB/VFKtQMI0uchN
         917w==
X-Forwarded-Encrypted: i=1; AJvYcCVPEiDULIlnxfKsNTQ5KC+WUvefnfgIymxwZYVyGTfJ2zgPWA0iTlPEGBKf44vaUEQmJ8OGkJfYme61do1jOXshHekLtiQU9gw=
X-Gm-Message-State: AOJu0YzS8CTUj80Ald/IxRiJU0uVpfz/9GTrrftR6PRBv4VgTqmaARbT
	vUrL8uP2VTpQXZzHQnhGIW1eC44IBd7E+Kjq1dVBwQ15XkDyFeE3SC26kI6sB3c=
X-Google-Smtp-Source: AGHT+IE4czX4omat9eL2TaWnpIIfB52dh+deEPL+LZJeB9XOHhLob4g4U3ybxs5P6/smcUxeUNiz7g==
X-Received: by 2002:a5d:4b41:0:b0:367:9571:ceee with SMTP id ffacd0b85a97d-3679dd31841mr880760f8f.37.1720081441615;
        Thu, 04 Jul 2024 01:24:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:bf0c:e5a4:4535:f45c? ([2a01:e0a:982:cbb0:bf0c:e5a4:4535:f45c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678e68a622sm5161933f8f.106.2024.07.04.01.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 01:24:01 -0700 (PDT)
Message-ID: <5ad6a075-7280-4280-a797-cf04a1df0830@linaro.org>
Date: Thu, 4 Jul 2024 10:24:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <2764814.mvXUDI8C0e@rjwysocki.net>
 <2ed4c630-204a-4f80-a37f-f2ca838eb455@linaro.org>
 <8d91a3c1-018f-495b-83be-979b795b5548@linaro.org>
 <12c5c133-9519-4a26-b9a3-2da1d3466e94@linaro.org>
 <15b67ce6-3238-435d-ad28-7c06efbe9153@linaro.org>
 <ce6c2e8a-65a7-4cb2-a91d-fbcaeef6edc1@linaro.org>
 <0c4b401e-86b8-4169-af88-475433012d67@linaro.org>
 <636922b4-96d4-49cb-9020-2359e7497f56@linaro.org>
 <50390ee7-20df-4be1-9cda-639981bf4ca7@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <50390ee7-20df-4be1-9cda-639981bf4ca7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/07/2024 09:57, Daniel Lezcano wrote:
> On 04/07/2024 09:39, neil.armstrong@linaro.org wrote:
> 
> [ ... ]
> 
>> OK I just found out, it's the `qcom-battmgr-bat` thermal zone, and in CI we do not have the firmwares so the
>> temperature is never available, this is why it fails in a loop.
>>
>> Before this patch it would fail silently, but would be useless if we start the firmware too late.
>>
>> So since it's firmware based, valid data could arrive very late in the boot stage, and sending an
>> error message in a loop until the firmware isn't started doesn't seem right.
> 
> Yeah, there was a similar bug with iwlwifi. They fixed it by registering the thermal zone after the firmware was successfully loaded.
> 
> Is that possible to do the same ?

The thermal zone is indirect, it's registered via power_supply_core.

A tentative was done to delay registering the power supply , since it caused issues in suspend/resume,
but it was reverted because it would require much more work:
https://lore.kernel.org/all/20240123160053.18331-1-johan+linaro@kernel.org/

Seems we should instead return -EAGAIN instead of -ENODEV in qcom_battmgr_bat_get_property(),

But I think power_supply_read_temp() should return -EAGAIN on -ENODEV, since it's the return
code for when a power supply isn't initialized.

Neil

> 
>> I think Rafael's new patch is good, but perhaps it should send an error when it finally stops monitoring.
> 
> 
> 


