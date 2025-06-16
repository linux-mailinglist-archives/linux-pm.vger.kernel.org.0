Return-Path: <linux-pm+bounces-28836-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D49DEADB65E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 18:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54EBB188D0DA
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 16:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6A0286887;
	Mon, 16 Jun 2025 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DFwFJ5WS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B402CA9
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090391; cv=none; b=MAOzCXpI6K5vkJzBDYP1oZi5ZtHXOyq0bVog6EnKTs33niHKM9+oFor31WRXRHLEgwD0Ot2W7mlnkWot4r4NMOODYjHHGRhbbauB/Ek7M+bKnp/S7olqMnfFZPYWuJ/CJylsnQdr+Ut7GKyValV2bjqespfhHAivRzOjUczzaUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090391; c=relaxed/simple;
	bh=ILjhoj5fN6xWnb8keBOdVIJ2262xj2ko3vcsf1iyMM8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IGMFfbijHBX+wDnQF1byvQl5mZY0RIZh9wn1mB1+jpDSWmsdQE+ru5wsvtTyRncLkrcREkoIkAXhredjWejqagZ28KmnLsiU+Hn45tQOQmCFyl6iiVzXF4s2dEuwVk7/CHeUvNFb4BfqAb+zBf75wC+w7S/42ZLzXeRBVvEZCGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DFwFJ5WS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45348bff79fso17593155e9.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 09:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750090387; x=1750695187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Hd5P5/fg13yTtPAuYFp/jk0X6jaF7MqYN05lmVOV1Y=;
        b=DFwFJ5WS8AIdNWUxMIm+c02+uLGVwfmvQqALa4hNXYcbozz8N/KfE/2W9w0Ak1UKmt
         Kop1XMBI3V85u23tZ/Ij/ggWk0vV+Nf3kU9pTDhShfAVxhHIpiL4nxARWTRWxZMfXw4q
         rji74d6XHGD1w4Gz0IoVUzEvjucYEMQLHil7OPQjr26sqPYlIn/zihVhKyW/WAfbSYjV
         1KFNZpATB0mTyzBAlRzsEkzc6uIejy5kslZ4vXscLo+ifTwsxpZiFmR4LoJCcNvhHfIS
         HOkApYwa95+yykzMgN4BwidBrGCf+EWNkMwcOzMMMe+ytX5csKeCLIGFaNJ2qJs7GZVX
         a4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750090387; x=1750695187;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Hd5P5/fg13yTtPAuYFp/jk0X6jaF7MqYN05lmVOV1Y=;
        b=He+T09UxOeHk/ii0/RwOpZ9AhgQw26T+D3+M39InqLUeNXvaz6xH+Zh7fN1DRJ4VKx
         FwXHhaaB1mSFG07p+2P/fmFFmuGfSr7D7RSD0wlQgUzEWZ/ZvaqSWS1FkZbHDPbAwzUp
         Gog2vnlEB/IJjVdkF9WJv9rm1E/QG7HAl/YLx6twOw5SbSxaJ2PE2FDM81KJDZe781zG
         v3ZHeodMr6dTcYbh7lVwO7MOsrnpf6FAXOox65h/Ur/pyZQno/sd1ks5I1ba3RpmbJVv
         TzSzrw/4zb0i9OZtEPkcYZtvBEanbu5VNzb1M124sWrgNsO2UbyiLC5Yn3Ei9RHOZfVn
         P+gg==
X-Forwarded-Encrypted: i=1; AJvYcCWop74PhhtGYp7K3OvjU9eBepRBSVAG6nMKrsFSDtxXM2CyN2LRDv3IdTU1hsal4A325oM6MzpSqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKXuEQdUs/sh+CikVOVER1WLdrjXWUKL/+1LCp6OOq/oegEGtj
	U9vOz0sV637q1J5QtaFTyuAvMZU3pYdd4iKClcFx5ttO2qigSlGT+Unnei0KG67QRSA=
X-Gm-Gg: ASbGnctp2LkESPnkehgQbh6/8wCFuI7fPnZPGPtHw7FmM8bIpNQ2392dAgG8qQYIZSW
	0mppGTA4m6qS5jUfE53q6n7zFYs6tQMmjh7FsBudrnbsDAcDHAOwKhy3kHonQZojq/zWE611XPj
	dW4J59H+4y0hyOjBQS/HgzVSTJ+vXMIObUhzSiTElF8aLrZ+bFVz4jxvug4bU9bMV4qQN2r/+q/
	VWUuU0eM++LjkKX04JffT/NfBj0BPcelSlCdlLLc73zRKGGBVW50VLpDCoCVd42IetEd9otwP3z
	/qmUxUjSDEMI6ALqJATwUUGvVNrQ8dSMVNWKGGxUOZUCZlVk3hTTlOkS1D6BdShisV7/MLuysQZ
	nVKgXqcbrrswCoTMC8plPtwKL+jyWWMy9S1Yv
X-Google-Smtp-Source: AGHT+IGyQp72RXnLaT+pSp37o2CpRoobwxRIaAao2r8SQYLUldCgDD83g2oNjxuzIPwfOXf/xNX3bA==
X-Received: by 2002:a05:600c:8b29:b0:450:cf42:7565 with SMTP id 5b1f17b1804b1-4533cb0aeb2mr87997315e9.23.1750090387487;
        Mon, 16 Jun 2025 09:13:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:6c7:97de:65a8:488a? ([2a01:e0a:3d9:2080:6c7:97de:65a8:488a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2618f0sm147336605e9.37.2025.06.16.09.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 09:13:06 -0700 (PDT)
Message-ID: <1ad7e8c6-ca68-493d-90e2-88b81398c155@linaro.org>
Date: Mon, 16 Jun 2025 18:13:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 25/28] interconnect: qcom: sm8550: convert to dynamic IDs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
 <20250616-rework-icc-v1-25-bc1326294d71@oss.qualcomm.com>
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
In-Reply-To: <20250616-rework-icc-v1-25-bc1326294d71@oss.qualcomm.com>
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
>   drivers/interconnect/qcom/sm8550.c | 640 +++++++++++++++++--------------------
>   drivers/interconnect/qcom/sm8550.h | 138 --------
>   2 files changed, 292 insertions(+), 486 deletions(-)
> 

Runtime tested by comparing the interconnect graph before and after, the
ids are now dynamic and the labels have the node name, apart that the graph
is the same on both runs!

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on QRD8550

Thanks,
Neil

