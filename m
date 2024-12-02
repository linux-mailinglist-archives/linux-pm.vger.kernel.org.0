Return-Path: <linux-pm+bounces-18340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0379DFF13
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 11:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7655E163A61
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 10:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05FA1FCFDF;
	Mon,  2 Dec 2024 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PgoqD9ly"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BCB1FCFDA
	for <linux-pm@vger.kernel.org>; Mon,  2 Dec 2024 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135791; cv=none; b=ho+uVrx52WFjxnF5rR04E3TntU84E4MXQjol8Ry3ovGrlHJXaTazIN/C0Om8dtL2r/8wy/fl8f/kM+9bv7+Apkd2g2hlASFWZ+TDVvurx5g4WJ4peK8LlW69KIVI4xofdi+cAsZCDyGR+oUaGEN9gSOiXKZYWZsRIFnFFdz9OMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135791; c=relaxed/simple;
	bh=SpVvQveKxiNQvzdBswELA+LyVOPATjwCrjSbwVYdBmo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CqD3znCIKfhxvMM00CsVR9Kfx41MovqtRhNVPPwmosWzZaUH/JBhTwtrM330O/BWrlSfOlD1xp42resICE5xaE9CjnAxdRydLb190f1v3a3izc0qnhM90bh1ooAQO+sbpaAH1VCrtc0pCLW18ds+9WlQ04R7/7ia4uA0YAutofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PgoqD9ly; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so37428455e9.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2024 02:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733135788; x=1733740588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jT5KvV791CFakvqVD4nDqzeY5ycP2MP9JkUV7Z1sqOM=;
        b=PgoqD9lyJmylPqdRos5gvcKc8QQwxpGQOFkIe0EQ3v39fVioPnBmLp03TzUSKNMxUa
         IF2etBjQ8QAN2T4R3Rg1ciXZCgAMdXkFrNgNWilNKUGFWVipQuxmJImBUIwYyx7svlv9
         8ATNC7D8jC5TR9aVF+h9NrQ+6Kk2a/nZFjxjc4b0nyr9aHKY2mDb5jDYc7g0IveKtAXu
         H2v3L8UsuHAu2Nmt7ME0q9LWs+qPjxvYu3sD+Uhn9GwMOFUfZ/PrHcVPJ+ffeorGdpFb
         FYgEf8Wmej/CNeomO9iSw+raRD5Ark2nqm9XrvPX61xAw6M9uoB25I+3Ufn6wNr5jiUh
         NJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733135788; x=1733740588;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jT5KvV791CFakvqVD4nDqzeY5ycP2MP9JkUV7Z1sqOM=;
        b=F8Us2gfQ5CaOihhbG1qBgEPDDshCFzpB+3TkRT0y5zUMFR/Mn0AgX/ZCYVlGTX8gw4
         vsHdsDB/rWySS6BRb8O9Itnc9KHWUfZGZDf2/XeLLxOK2M0toO+wHQLVMj/8xtJ4fl8/
         tBcOSVvEJha6FiNOLviV7UmbBfEm3dlWmG5xJhVhTc2g12G8sH5y3WLPZ5aOhQA2qhWC
         YQXXTsiNxZna3m1RSAqt9O53LmXZny2nugB472NDf0Rb27AQZn1QNgubALVQf09kGBCy
         mG01Ipn7gysgVm3my2MS8y5HOstNmYevElVonVwu9/UNidrCV/ABSVsw2e1FERtibcVF
         XGFg==
X-Forwarded-Encrypted: i=1; AJvYcCUTGciYJ4SB+W83GymbJwanpcd9GnyM1OALUHE6f5Mlc1FnRetFrhW6WOUrqSY/C9srkJU6Ewjd/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgnbwzNI4ThqlWu+6bGP+x0pwiOBKJ7f/ybFOx3oaT+1zcH0M0
	YOhorkwge6Mk3ZZmoRENSR83e7AblFs68cEJ4/avv5Ku+s83smxZHJc3ezhoLMY=
X-Gm-Gg: ASbGncumlOvFiGzPwHiWuAB+4kCD1vxAxHPA5k3YpJVONlBIFwsqDOlFnMDNAdg5b7k
	FEP9H7B6HMuya8BDfbSJWq3ImIUTinQZjyhDTH37hrcFPHw6G/UlLZPRs189TJHvt46jZP8qHDf
	b0yz6j1gGETrI+UAPIQlPHbz0t5ubt4upWWTwIU3VJEf4199gdWl9lZNLFdcOFxvNN9nvisZjCb
	7LYAyEb59Dis30d0raepNCmHfkgjNGxYrtIGo/VmO6n+iy8+Fuo04B2QTBDYRzkA5hScGyxp8zE
	BW/N+KQEcGAEPkUvSSngcQaAJfU=
X-Google-Smtp-Source: AGHT+IFRy9RZUNp8ERNv8snQhR6iNB+4RIFpjf/OrMOMYeZ+gVloBql9BUB0vkomr0RQYQBfBtfSYw==
X-Received: by 2002:a5d:5f4f:0:b0:385:ecdf:a30a with SMTP id ffacd0b85a97d-385ecdfa4ddmr4438963f8f.33.1733135788377;
        Mon, 02 Dec 2024 02:36:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1485:2a78:787c:c669? ([2a01:e0a:982:cbb0:1485:2a78:787c:c669])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385f0d38a89sm3180538f8f.97.2024.12.02.02.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 02:36:27 -0800 (PST)
Message-ID: <64dc6a89-7245-4546-a3e3-33bc2820388f@linaro.org>
Date: Mon, 2 Dec 2024 11:36:26 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/2] OPP: add index check to assert to avoid buffer
 overflow in _read_freq()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241129-topic-opp-fix-assert-index-check-v2-0-386b2dcbb9a6@linaro.org>
 <20241129-topic-opp-fix-assert-index-check-v2-1-386b2dcbb9a6@linaro.org>
 <20241202063311.g3333gi7ztblx2hr@vireshk-i7>
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
In-Reply-To: <20241202063311.g3333gi7ztblx2hr@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/12/2024 07:33, Viresh Kumar wrote:
> On 29-11-24, 16:06, Neil Armstrong wrote:
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> +static bool assert_single_clk(struct opp_table *opp_table, int __always_unused index)
> 
> Shouldn't the index be unsigned int here ?
> 

Yes, I'll respin a v3 with that.

Thanks,
Neil

