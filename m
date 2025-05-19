Return-Path: <linux-pm+bounces-27345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 074FEABBF23
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 15:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E434164F5B
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 13:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59C227A116;
	Mon, 19 May 2025 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ddplbHC8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81CC2798FF
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747661405; cv=none; b=rcvJgY+stiM4ZHNrgzSdDneUWfN5il6AkR27uA4Y6bhPFIkvJq+49S74O7nooWof51WkOiagieP150ujmc/HWtJ0JAapUAytrkfwglCtgy3WCmJG1ZibQJ5CfMB4a4JZndLuTny5xqH2EPBrs5TBCp/ZCkli0KOIootAQWEdVf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747661405; c=relaxed/simple;
	bh=ceoocduNlo16bShRSxr/bYEvB6DSdiuerrL0JPRXSZQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aadAvd2H35eE2gnnPlJckrCVzqN1a0qnZzsjjRTtNZ9RFx0o0TzXTVCtSTZWcXDQHzjVUdJu91hBqgj1bSK9l5ZiU2b21JaJkT/2wnI8lt2tOwiI6bG5T8bgxWeI8ReiClec/Iw2LxnCGW2Vqin03EPrKkBmcRW9IkzA7fR+DkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ddplbHC8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43edb40f357so35725955e9.0
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 06:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747661402; x=1748266202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDBNlQ3g6oC2KKNqaV/PvSTd0uwtCUXu465+xGLQdN8=;
        b=ddplbHC8dawZY+lqgmoo04W0T15X1fbiqizQtDbLLU/iJ2uqq+HRfULyLJBjs4Vdo8
         KkBeSp036Sl+7YUGPO25jRmMd+Zm7rVeGMfavWj/1r9jL6e+ZyLH1yQbtxiDm1oug3+Q
         zIH4x4a6Q6WH5Wkv7n8VxRhriOtUl1mQOBUzt1cWQZirGXZx4523hLOjcsi2lOda1fEL
         0SUmenTy9vz58mg/XVzC1U5FcY7Jk0whh5OefVEyDCymjUCuZxUXpotspMOIpeKBcuYP
         3OAmJX0+feMcdMpcKPIgUslOLjo+XLcgue1zJPg7LL63Ku5jhXmwEdbWFaxw0FQK4ZXu
         JpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747661402; x=1748266202;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mDBNlQ3g6oC2KKNqaV/PvSTd0uwtCUXu465+xGLQdN8=;
        b=iHrZ6iB+t+cesMHGm5v4zLLQYmqiIm6b42lkC97teGjhU0Spj0nVCRwEB8jN4Ll3pz
         ScoChdhdmOXLMXOYLK6OXNM/igFfHNPXp+/CyvmjhQu7mJ8yVTSlWmHhBK85YU22DW0o
         /NjP1NGD9Hje7viQ3dwo9Hqfgj7InMwW4XFzbhdN+ztIPOYF8DNTQFP2Ib7xRpaoCuOB
         PNKLCBzPxdszqY9ceCc35YThaSbcJH7Bw31cG7SsNObeFlxJionFknzNrcRHHmkZcrer
         X8oqWSb+4F9hfs4uJCvJT193Ep8IBVbyubWaRKgmDKrn6EcEAA/JYPi0IdJfNH8wB1yX
         I6Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWKYbf9BHTygAL9s5bych3k/MIYzU/FSyCTHNcsB49F+nfhBsvrJ0wLMWPoNpnyFhhVxf2hq9zW7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwUzUt6Iv6aTaFcYDNQD/FeQZUkFVqhxdSAVkBckaZpAvaVICP
	coqR1MYzgEUlwULzdobOhy/yPCOf/6j9PHu4cjkSGCfUHkM93yZ+uMjajT8o9vmtMxs=
X-Gm-Gg: ASbGncvOYOJDwKp69lmOj1IdA51+k7/NqomkHVrnWFvSCVX49hErfymwxfYmgjegHV5
	qWYckFPSPVwNFTcXl3+veMVWfeCKiVB+9LMMjpw91GmL/dIog+e3swRjS0naIg8YjonAbP+z6Qa
	mY06YIRSHqSh4CDrUnEhJlBVTOLqj/7VvqbB/U5RZcuLW+eWZEEuvTCMVIMz+k855s2Tu79KtsS
	JnTC7qsRjZxsPIpp6QnZEyZE+SixeDBHQxdMQHPTJY0tjCBDmJPjHeucPTrTaOtHiCGSOh6g03f
	AZfi4rMVaKY6drX/GElnnKJz7mRyn2XR0GF/iuRM1NB7PKtv21SZtRlXtpST6yOsw1jLQmq4jd2
	2v5XDuMhLEDMG02Z6XH7FjiE0wG/c
X-Google-Smtp-Source: AGHT+IEZZaVnqBZzCTNrAs0XlbgmkZpK+jBXgRrvy+8bDHfECKm5po9fM93yC+ioRRyCDCBRZdM+5g==
X-Received: by 2002:a05:600c:3b94:b0:43c:f0ae:da7 with SMTP id 5b1f17b1804b1-442fd60ce91mr110613535e9.7.1747661402047;
        Mon, 19 May 2025 06:30:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:ce80:58bb:54b7:ad18? ([2a01:e0a:3d9:2080:ce80:58bb:54b7:ad18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5beccsm13020104f8f.36.2025.05.19.06.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 06:30:01 -0700 (PDT)
Message-ID: <2328c351-1bd8-4ce8-afe5-a6df675a2738@linaro.org>
Date: Mon, 19 May 2025 15:30:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] interconnect: qcom: sm8650: enable QoS configuration
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: djakov@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250407-topic-sm8650-upstream-icc-qos-v1-1-93b33f99a455@linaro.org>
 <20250519082305.81258-1-mitltlatltl@gmail.com>
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
In-Reply-To: <20250519082305.81258-1-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/05/2025 10:23, Pengyu Luo wrote:
> On Mon, 07 Apr 2025 17:16:47 +0200 Neil Armstrong <neil.armstrong@linaro.org> wrote:
>> Enable QoS configuration for master ports with predefined values
>> for priority and urgency forwarding.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> [...]
> 
>> +static const struct regmap_config icc_regmap_config = {
>> +	.reg_bits = 32,
>> +	.reg_stride = 4,
>> +	.val_bits = 32,
>> +	.fast_io = true,
>> +};
> 
> [...]
> 
>>   static const struct qcom_icc_desc sm8650_mc_virt = {
>> +	.config = &icc_regmap_config,
>>   	.nodes = mc_virt_nodes,
>>   	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
>>   	.bcms = mc_virt_bcms,
> 
> Hi, Neil. It seems that the config for clk_virt, mc_virt is not working
> on some devices. My device Oneplus Pad 2(pineappleP variant, mtp based,
> but without modem) shown the following.
> 
> Apr 30 01:56:16 oneplus-caihong kernel: qnoc-sm8650 interconnect-0: error -EINVAL: invalid resource (null)
> Apr 30 01:56:16 oneplus-caihong kernel: qnoc-sm8650 interconnect-1: error -EINVAL: invalid resource (null)

Right, those doesn't have registers, let me check

Thanks,
Neil

> 
> Best wishes,
> Pengyu


