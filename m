Return-Path: <linux-pm+bounces-28837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F4EADB668
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 18:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3FC3A961E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 16:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E37286887;
	Mon, 16 Jun 2025 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AmW5RMKV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0684A28689A
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090422; cv=none; b=fRG0VrX2NJxabJZR4GslORlTYHH014iLkmlAZUc2VdBikAgpsctCHD4tlak0aKgFKwwzrorjC6J2vpAqttF1BxE0n849zdVLODeUPknLleEv50F7koXmSLsDCjxNceDvWmmpZO/iE714+rm4JYXv//Qjn56oak744Bj6ESmMC9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090422; c=relaxed/simple;
	bh=HpE/pDLZnJwXNmha50ska3/wWNk6nXBAIt8OfLs0uko=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jGqPDIP0P4aoffgHcjbkDv59+48iyz94m3ZX8NjO+lOfkilKC+H5ejYWOYqROvxX70ioC5cVlYaGuJcgCn5a+waq4YWUrww/eCZ6yXuzQzMmkuKvaZdhANpuCeglufSI1e4DqtTEHy6IZjaNRZmKb4QKu7QcEYZFWW+NMJChkew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AmW5RMKV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a54700a46eso3104480f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 09:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750090419; x=1750695219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99SgOTZRzrg5GY1SDbLEkgEMAQ6XuzTJfRbX4aCiC8A=;
        b=AmW5RMKVzkl65Jk6/Nify15j+icAnXwQAZs22vP0r9vK802obVI8snVMdUiEvKMQsP
         Zd3CSnj7pO6Mw+BKmgGcKecJV0VsSmyguFaoGt9B6rsboV9opmKaGQ0ocg6cAFmlcl8U
         fJSJN84aW1bfj+ZbmR5FY/t1Ij95E+Ieu/x9qjfEUnzaWtndrm7Dv4rPvexMRPpOntyH
         EljX48UcU3EebrJmr/579SgFDPwUI2AMFzOhv1SNeuqMUy6klaclE5n2WYFdrg1pjjfr
         K/xcux3u5WBAAe0P1nNyQpx4Uk2Q7uJZn1qICWFBfOnIz0qsvYfSyKZL+8uy87+FqmWQ
         uTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750090419; x=1750695219;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=99SgOTZRzrg5GY1SDbLEkgEMAQ6XuzTJfRbX4aCiC8A=;
        b=lCYy0riPTwqq6FhU2Gn2/6ifmmrsZ/27VD/ecsJm57S3HcRsfQgwPm3SRr7GEAr6FC
         prDPLUwLzdpLzLWzN0ClLniMEiu3QpRRxPIBIzKVxArNsd/HrV+CEr7wb4+esQlam3+b
         qKKueHm+MD1O2CON4KbO5Ng+caO35gRlQHMjpgbGowCDYhHJqX6nUu0ScaCXiqMwr7HB
         rffgxhpetqQ4OopReMR86elS3Z8i4oe/fkgV/OkP4bB5Qknm7Zu+sD3eT5oL7NAAEXO/
         K9yquUVVZCh/SZ93aFJWg9hubsMzYU8MfSRpmZ/sQHignSiNg4ZnSYtaasbQoz5NuawM
         sPLg==
X-Forwarded-Encrypted: i=1; AJvYcCWVDH96kOKRFA3efimzqyNeHwGooOGjlwjqlEU2Zu4Vi/mto6Fm/4c8Y33VOv31O8dIsGRL9iHxJw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5T9/AkMgZcr0zl6DWP0wP+m76+6jV+54pJX2mz5rTQ2qnLR+f
	P7QMj9ifs+USbXxaHW71Ke7DE8XfbyeXqGHvktHeEvaibixNf7rrWsN05j7PSMQEHqM=
X-Gm-Gg: ASbGncu8vFfIuaWtiGkOesI9rLJo8pT86rkd0gnSXS5CDDiID/SZrysIjn4gWSmK9Ks
	e8PV0lzRKQMq5me9kQ0AuVP4WZtqyMY8dDkQO0MmBMr4lofpQhwoqCrAHN8j11RXZcPNLIgRPfH
	bFF18pvFUEW+jFETJ9GPxATfTXxurVVxjdkigIKz0LKOIvarGidTtaA5PMrQnrq7d6irtRP2I9P
	VSElslQLyoORxWbCN6b9RIJhjomeLC0k+M3+z3GhRvNilJy0QfTzR46nVyehUp7acZQDO7zfdVE
	NcdlsWkmES5XunMPeS7JylKXyWY8dD13xKpEOxlhuONmHPtI2CXGW/VRjW2BQAKS4gawMRT6ZZx
	6sq2MDm0fcqdNeaJr9EzzbHmLgsTBIdmoqgqU
X-Google-Smtp-Source: AGHT+IG4DpXuO0yRjlobR/oruI8mfncT7fekLlNeBTCV8c8EentzOqtU302pXbxayRLtEJaxzybOJA==
X-Received: by 2002:a05:6000:144e:b0:3a5:3b14:1ba3 with SMTP id ffacd0b85a97d-3a572e58cc9mr8196351f8f.49.1750090419360;
        Mon, 16 Jun 2025 09:13:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:6c7:97de:65a8:488a? ([2a01:e0a:3d9:2080:6c7:97de:65a8:488a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2324c6sm146860555e9.12.2025.06.16.09.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 09:13:39 -0700 (PDT)
Message-ID: <3beb5a02-8a2c-495b-b5a8-ae5e90ae6a63@linaro.org>
Date: Mon, 16 Jun 2025 18:13:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 26/28] interconnect: qcom: sm8650: convert to dynamic IDs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
 <20250616-rework-icc-v1-26-bc1326294d71@oss.qualcomm.com>
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
In-Reply-To: <20250616-rework-icc-v1-26-bc1326294d71@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/06/2025 02:28, Dmitry Baryshkov wrote:
> Stop using fixed and IDs and covert the platform to use dynamic IDs for
> the interconnect. This gives more flexibility and also allows us to drop
> the .num_links member, saving from possible errors related to it being
> not set or set incorrectly.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/interconnect/qcom/sm8650.c | 676 +++++++++++++++++--------------------
>   drivers/interconnect/qcom/sm8650.h | 144 --------
>   2 files changed, 309 insertions(+), 511 deletions(-)
> 

Runtime tested by comparing the interconnect graph before and after, the
ids are now dynamic and the labels have the node name, apart that the graph
is the same on both runs!

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on QRD8650
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on HDK8650

Thanks,
Neil

