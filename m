Return-Path: <linux-pm+bounces-25435-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B023A8964A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0691895CEF
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 08:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462D91C8616;
	Tue, 15 Apr 2025 08:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D69lBGaz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601342DFA4D
	for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 08:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705083; cv=none; b=MxlCofJce+1NQGd7jNPFr7S2MYex2FozUH0qRwRuxWIQ6rWOkn4i8bltsOzvmHANewlw0mdADsEbK1BaB6fb0ByGV2+2iPDPQ3P9WIvllpHykkeIk/Y5TA/QyMENClRfM55/5jj7fLNHP2V2hkZGOU7BIXY2LouS22nBII0VrO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705083; c=relaxed/simple;
	bh=aNw1qEcSdgkM/iAxlZgi9SL+WfRPwqneqwPkmwf/s5Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mMbuH5UQ9j6g1JnSsCK7EQ89hJs1gZxVXoh+brXpNCA2ZqndG+OoIHduWt1RoV0m38SMbiW11bQBXpOoUxNzVMUnF3SV6DqBLUcRIacor0v4SnAUChNY5w92pTpnxDYfLfry85dlzlzMkBtwXzfduCcjooJAidB5PTJNdvbx3gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D69lBGaz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3995ff6b066so2812045f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 01:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744705079; x=1745309879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9R0bq6Xay7hUWOWZTLdriMvdW3Bm293BXWhekm88cU=;
        b=D69lBGazTCXUL3GDlbms8GMOnXIulr4MyaD5vRJZbqlTcNcLQq6iziuSvYEvRMRE3x
         FakxC/cd6O+rfL0NY4zWm5xgi6chzwqj7QwsBRWahrTj0oIV31Lv9ms83axp+w3EKvl6
         f0x/4YU1yx0ohWeb7au96/F6rwjGxIq5GYyeZTjvenn2tXc8mX3thN7pmTKTM+78ge54
         YxSm0dJc7B4ihNEuF2c0aG13M4g/XvLeojIUv5kQ2ALmN+NxcGhLBwN7Y+eid93nXTAl
         PrhSqVgAExBx6g65FxKQdIvfcMQKTqSqxytz4TXTwcMMNwf+uuvYtikIrRZjxlUaIcPc
         HQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744705079; x=1745309879;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S9R0bq6Xay7hUWOWZTLdriMvdW3Bm293BXWhekm88cU=;
        b=KcDprwDk2hKkLfLT1N5ZA9GeUhpx87AZoqofPeV5QRzwBpM282r9RwgcAzDta/M4cQ
         9UClwrThvr7F+CzC5X4pKZ1HHU7i7VweunAYBV4aTqh7aInXxWXpeljTtxAUA9r5PZKM
         UC22yZs1UYeP9U0I/A3JZpfzLOdIpoH3o5+/cwvd1b7tHnEmhrpivK1yxJq/h0euVunQ
         AitVKu8jTK+fSJOFYqFeS8Kv0VBrMsrpHacFer/JENskpSbv7/Be2IeVOUXkMoGeX8Uk
         vkzDeeSPp4n77Cdxi4vix8BnvnyZhWku/jkZlspYylwMSnoUjropmW9Lz3DH5c2Zgb3a
         ysdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB2RcH79gvxzNhYWdbMPsIMJfJJDph3U7LhnVFrjk6e2qM42KklOL1PueeynjtbIEjTKJj8yeTOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww0Kw98X9HH6O0Csidqg4hN2TFfxtgFdSwHMQOQ64H8x6uZ0of
	oobI0eVadqlnZ41OoW5JF51tVTOs6/dnuOFhdaWiais+AnsFo35ogVJBvwxbknM=
X-Gm-Gg: ASbGncvKatIM/wI+GXv6vX8lYlwGDMAAyVNSKweuHcEWC9jzsCXllP50+WH8Z8dFQlw
	higs83fkfxIwHdU4OKaRHSK1fapQ+3K+4Gxsu7F5TE9wwrJSxfzhS+MYAQLFlMbZBKp5QUhi7i2
	bhXKXcgnjZRy0mgdnfJFTRt4/ejKB/rxFlbtpVCvNBmTNyMDoMD8Tiid6ic0dQXPUzNbnQz4HQz
	z4cA9QUJY2Uc4Iv99Ur1hC0N45KAGRSnoQFjp1xmtDehtEQ2JzZ6uw58iMe+z30+B5tl2wPw3tk
	7yI5/CN8BZih2ea57fga1nBqn9+Y0C6gUpAM11v/2TYcb0GMvrTnFlnJRC05J70vS6DncZZKGnP
	67iE63JcRg2hQdcW2VYT9NhHRDY5A
X-Google-Smtp-Source: AGHT+IGlH94Rv73ba2D5G22X7lVH9eT2jkQiPunHZHRgDARM4xIe1+hQwGc/DsRp941ZCmPOdb90Sg==
X-Received: by 2002:a5d:5c84:0:b0:39c:13fd:ea9c with SMTP id ffacd0b85a97d-39eaaec7b70mr10629699f8f.47.1744705079656;
        Tue, 15 Apr 2025 01:17:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:ac71:de35:af4b:b8fb? ([2a01:e0a:3d9:2080:ac71:de35:af4b:b8fb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae963c15sm13754713f8f.13.2025.04.15.01.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 01:17:59 -0700 (PDT)
Message-ID: <d80e2553-e5b9-4b79-b96e-f7092ac8d707@linaro.org>
Date: Tue, 15 Apr 2025 10:17:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] interconnect: qcom: sm8650: enable QoS configuration
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250407-topic-sm8650-upstream-icc-qos-v1-1-93b33f99a455@linaro.org>
 <b9f90b0c-cae5-4dc3-817a-183b49f947b9@kernel.org>
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
In-Reply-To: <b9f90b0c-cae5-4dc3-817a-183b49f947b9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/04/2025 19:08, Georgi Djakov wrote:
> On 7.04.25 18:16, Neil Armstrong wrote:
>> Enable QoS configuration for master ports with predefined values
>> for priority and urgency forwarding.
>>
> 
> Hi Neil,
> 
> Thanks for the patch! It looks fine, but i noticed that there should be also
> QoS configuration for the qnm_apss_noc node, but it's missing from the driver.
> Do you know if skipping it was intentional?

The qnm_apss_noc node is not present in the upstream driver, I wanted to add it
in a second time. Or I can do it first as you prefer

Neil

> 
> Thanks,
> Georgi
> 
> 
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/interconnect/qcom/sm8650.c | 327 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 327 insertions(+)
>>
> 


