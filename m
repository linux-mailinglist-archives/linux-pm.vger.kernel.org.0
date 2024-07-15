Return-Path: <linux-pm+bounces-11090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B59D931137
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 11:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17D21F22D69
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 09:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A88E186E58;
	Mon, 15 Jul 2024 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VtDt2bwL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A03185084
	for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035833; cv=none; b=Zq61qyLMZohtPjmp1L0K6oerEmIe9MsCpTlxuSZ9VcXKswMy5bigjcsLNU/F7ftqK6zO/ur7chmZdWQGtmYf9tr5Y4L4s8DHsu1dvlG4Anr/JArdcqxjQMY3kZP6pKxZFtb72qLcI58bHWuSk6ABWboKztRVI/Adk8ho+jtHyi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035833; c=relaxed/simple;
	bh=FqI/bphkN0rOdG4vF28KZjAJieDErty2Lx6fxtDiNMw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=APsCTTr/iuMd80HNnlhOFRFdcKGT+kyNmjSgkq8w+kA2ohFC0u46704TfEHKlWHkVzRLXdM84Ygy+wEeRdi5BHw4Ag73ADkTpq+IrmU5CL4XCHDYk5Kkrqouw+V/TmhYZ049yCfAGB9XEO0MKRekvIbWYzcGiWWJs89JqVRoIA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VtDt2bwL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-367b6e5ffbfso2258773f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2024 02:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721035829; x=1721640629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYsj7RibyMm2aUhUDxFApBRwygADSFVFKokYkxs/z7E=;
        b=VtDt2bwLAP43wioX/uXp+f316i95fevV/krM7Dd06PvtQbY1eTu+dBTBOCMzS//Z9d
         PsJtd3msMEcxyfK0RoY66ndKge980AZ4/x+t0w8tigUS75eHk4VdKfKhhgphkc9MoPxj
         evx0es21lRkRLb4JQyNFJsgjv8fey5o40YsTKbwdrHnGyYiDGyGQSPWXwtvqjpQwlWjc
         aXIqZMGZj5GOuqdRI5nwWFD3RfQYFNIgcCG42oS4CLf+d+fgYhjRynqAdkCnopxG0hNM
         Qc9ZVo7ns3lw2cAEitjX5rT78n/dhEp8O4UyYszdYTNG5XZID0Nhdx0q6/DuV0djlrfj
         S6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721035829; x=1721640629;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MYsj7RibyMm2aUhUDxFApBRwygADSFVFKokYkxs/z7E=;
        b=cJNRywz4TS5z6dU1w1lQPC8Em3ajEEi8SZrRNO5rnxBl+i1L65/zXMQ1MSJpHjgaG8
         AxKDBtY8DC7oBhY1axxvjK4sC0ASpoEUJObQy/OFOCRSj3W2EeZWrpK2+O2rfb2s0rQt
         AHesynRuIJdwV/LVUHts0Aseb/uNVUxJVbw8avO7f8INplKC8DkWevaL2ZL2jVeJFYgR
         j9ynmJ8tBYSPTZTJY0Jw0lNjEhBSpRpIWZ6+qHlNsT9MiuQ5z0axw+SHy4TCysvZXtzL
         2wS/TNPRZ9H8IRjBwIBo8zYshPNl+nXv1ugEBU8CfnSIEnHCYjgX2OQG06vhykKmRtqm
         NeVw==
X-Forwarded-Encrypted: i=1; AJvYcCWfsapJJ15OCDuQvHpShQQvhz4AdTLneI2UDJS+UEc7PNWutzaBHLReWMedM1IJsXfUiLf/dKoqdKNeE+rWjk+cisbvLDLrjWk=
X-Gm-Message-State: AOJu0Yy+TabiCKIty8QuNsmsuDy0G4BjS1Pm/GcF2/gw0Pe3O+YGumxy
	U+0811wmNYXanhQ38aBFdyK6e33fcRpke4BGfJVsJxTEzgfMd6DW29Ygnf0dcbaVQEzR6VZrWje
	N
X-Google-Smtp-Source: AGHT+IFYmwoaUV9aHPWBxAXNtnJbwpt8dYdNhLmIQDOCyS2/SsqbuLdKDC0Wux5x0K9lLAr3xJhpMQ==
X-Received: by 2002:adf:edc6:0:b0:355:143:b5f5 with SMTP id ffacd0b85a97d-367ceadd4f6mr11560756f8f.64.1721035829150;
        Mon, 15 Jul 2024 02:30:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:79bb:5f59:8e51:52d4? ([2a01:e0a:982:cbb0:79bb:5f59:8e51:52d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db04841sm5775197f8f.101.2024.07.15.02.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 02:30:28 -0700 (PDT)
Message-ID: <1c981a21-8735-4bf6-9964-233b3a742f44@linaro.org>
Date: Mon, 15 Jul 2024 11:30:27 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] power: supply: core: return -EAGAIN on uninitialized read
 temp
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Rhyland Klein <rklein@nvidia.com>, Anton Vorontsov <cbouatmailru@gmail.com>,
 Jenny TC <jenny.tc@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <20240704-topic-sm8x50-upstream-fix-battmgr-temp-tz-warn-v1-1-9d66d6f6efde@linaro.org>
 <a50eb87a-4dcc-4272-b897-fb8170bfe58b@linaro.org>
 <0516a900-0911-47f3-888e-57d014986e3b@kernel.org>
 <b63ac8c6-213b-4307-8d33-48badee7881d@linaro.org>
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
In-Reply-To: <b63ac8c6-213b-4307-8d33-48badee7881d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/07/2024 10:08, Daniel Lezcano wrote:
> On 05/07/2024 07:56, Krzysztof Kozlowski wrote:
>> On 04/07/2024 18:41, Daniel Lezcano wrote:
>>> On 04/07/2024 10:52, Neil Armstrong wrote:
>>>> If the thermal core tries to update the temperature from an
>>>> uninitialized power supply, it will swawn the following warning:
>>>> thermal thermal_zoneXX: failed to read out thermal zone (-19)
>>>>
>>>> But reading from an uninitialized power supply should not be
>>>> considered as a fatal error, but the thermal core expects
>>>> the -EAGAIN error to be returned in this particular case.
>>>>
>>>> So convert -ENODEV as -EAGAIN to express the fact that reading
>>>> temperature from an uninitialized power supply shouldn't be
>>>> a fatal error, but should indicate to the thermal zone it should
>>>> retry later.
>>>>
>>>> It notably removes such messages on Qualcomm platforms using the
>>>> qcom_battmgr driver spawning warnings until the aDSP firmware
>>>> gets up and the battery manager reports valid data.
>>>
>>> Is it possible to have the aDSP firmware ready first ?
>>
>> I don't think so. ADSP firmware is a file, so as every firmware it can
>> be loaded from rootfs, not initramfs (unlike this driver), or even missing.
> 
> Ok, said differently, can't we initialize the thermal zone after the firmware is loaded ?

This is the goal, but this can't be a fix but a proper rework.

> 

I think changing power_supply_core.c is not the right solution.

qcom_battmgr_bat_get_property() should return -EAGAIN instead of
-ENODEV.

Neil


