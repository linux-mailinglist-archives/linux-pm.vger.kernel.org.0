Return-Path: <linux-pm+bounces-18228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 816DA9DC190
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 10:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4208F28121C
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 09:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5565176228;
	Fri, 29 Nov 2024 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RzOaXE8a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1175D38DD1
	for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732872862; cv=none; b=DqTKkTUK6pumWqssWN/SBepUjgR3oz76UTPSY0uZM1UBBOrXMxKgjL1DglPJZQtyQrHuRUSR0novbrEVsU52TdAMLWZU+1p3GoNRXEMbMNRQTjHkBI7zx5nIi1SJVNk04S8bJVNSWJoQln5eiy/7+S5F1m5dsTPx0PXOMpYyor0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732872862; c=relaxed/simple;
	bh=yOtrPDXbGX/QBT7wSJ/9OMwKIY4busXY72xbe51fPJQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gvvVWrFPsGtC4sN3glhFG4PwWCdduoL+z4bWfyAeMFRQCXbhvgefHL8ei0DiEbZdOJzWX2FK/YeFkaXnNcvLeI4JXzdxWBKp10oHbteHoNxkZIBk2OHiHTXJvn8hnfq0bo7GU+7/IgSCZiQeLVvOz6A0X6EdTh0Ihk0qnWqLlBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RzOaXE8a; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385d6e36de7so981629f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 01:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732872858; x=1733477658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frwEjMxeExMtfX3XC/j5Yk8ObcotpNNmRK2VNHCk87U=;
        b=RzOaXE8aFiH9yRyJKMEhw4QvPB1wjoj0iPi4E9ng2qFsWLD+n9iU+TVkzomZhp0C+D
         DLrsQcQp/bZ8Z5VKXmZf8ct4NYqJcuz5Csnq7buqsL5BVtzrbnP94o7uoZBO7WI4k4DB
         G7eu2xEKi5bQua7xNLBy4Lr/OBq6oqEwDMYwYHgcQJ9LMgEU2bDq+eCuJgzm7GdR3/F4
         sPlbwt6Kv2vfERQIGq+BoxRDOYKpKMC8dFUk7na9MAnC16LE79i7tOBrmnwODRg6fBaa
         naJizMEFbXTpxUxgQAVm9bFpkJUCS7Noh146qz8QAgGt1/tlxqu4nQ1NGVdtZAF9NC+s
         vShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732872858; x=1733477658;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=frwEjMxeExMtfX3XC/j5Yk8ObcotpNNmRK2VNHCk87U=;
        b=RuENu/YWK5zdlYk+nhviFOmuzrzTdfA7MDW4pdSiy6Tj6OG0xsnrkO6wHe+LwyLVNd
         Zb5o2au0KYlfn7kVAjxnk/wLt8on7INdWS9hvvqWgU0tBJbpxT0vnducSA/AZQVoGNiT
         PZmEQeuUYGyvrjIjpxMQqZXVaAUmDajUHbBVDB5ClTgF15wiYK2BRE1Vqtual23tubOQ
         ojonPYOYH4eK/W6Ly4wckECDnM7YxP1YYgSfyMKeOzdP8l9UvzwfIWwrd5wnX9upmt0r
         1Vwq2NQpH9aDV03zB3hAjsEHD8L1MTAmjw7Hb0UZGnQkSycRAfJ/A8FLiHX1f0PrJ9G+
         LO1w==
X-Forwarded-Encrypted: i=1; AJvYcCUPDBmCUXTJ4GHpai98uSJvhV9376w8pO2XDuK1KZmXSG02uGNlpsN6CFcByv/UMiakCRO+nYuLFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyffSPPmZPEnFq3ON8P4bT/jL6pcBKKZONoZLKaNXAtz4V0RaX0
	NuP34XStxY4p7lRnJhoTlWsSFamk7LAYTjD45QDChii5EIx5lfFrpVXoLsTbFr0=
X-Gm-Gg: ASbGnctH1axlBZ/8e1Pzq4d/7kg75PGzEQvU1nIqOhjCTsBEzsOXL0b76N8FTPMxURp
	wJiAobrMK5raAg9eLW/gqcPP7BQwZ5Gkk1sZHUzWjVYSdZnI6P3Nz3n++scu+LfSvYuvjTRpidh
	GSQIWme16yfLI6h7TZcJS17exbbZyGPaVM5++00JyHuMnb0akXACXIMc4RwWfI3Ovjk8aYPnNOl
	LBUR9GYjV8IsXjO3iwBTdUp9y/wRbvOrfugW7cUfytJqw8YVQRV+3cwmPANbYnFaqkkJWuvmLZb
	cfiBTMUlAuBPD1Fgh/CeqpLh
X-Google-Smtp-Source: AGHT+IGX6hqLD25wTvy9AZ3obZoIsUBBVXYsBRZjNK2aIzKIZ21zoU17TT4VN0HehBOnR5SRfd0viw==
X-Received: by 2002:a05:6000:705:b0:382:49fe:6f8a with SMTP id ffacd0b85a97d-385c6edd520mr9826067f8f.55.1732872858372;
        Fri, 29 Nov 2024 01:34:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:f573:30fa:4c5:27df? ([2a01:e0a:982:cbb0:f573:30fa:4c5:27df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd68b41sm4041165f8f.74.2024.11.29.01.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 01:34:17 -0800 (PST)
Message-ID: <46cb2f2a-908a-4600-8716-db7f937ec13c@linaro.org>
Date: Fri, 29 Nov 2024 10:34:17 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] OPP: fix dev_pm_opp_find_bw_*() when bandwidth table
 not initialized
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241128-topic-opp-fix-assert-index-check-v1-0-cb8bd4c0370e@linaro.org>
 <20241128-topic-opp-fix-assert-index-check-v1-2-cb8bd4c0370e@linaro.org>
 <20241129084111.ifwak4y4irxjnpru@vireshk-i7>
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
In-Reply-To: <20241129084111.ifwak4y4irxjnpru@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/11/2024 09:41, Viresh Kumar wrote:
> On 28-11-24, 11:07, Neil Armstrong wrote:
>> If a driver calls dev_pm_opp_find_bw_ceil/floor() the retrieve bandwidth
>> from the OPP table but the bandwidth table was not created because the
>> interconnect properties were missing in the OPP consumer node, the
>> kernel will crash with:
>> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
>> ...
>> pc : _read_bw+0x8/0x10
>> lr : _opp_table_find_key+0x9c/0x174
>> ...
>> Call trace:
>>    _read_bw+0x8/0x10 (P)
>>    _opp_table_find_key+0x9c/0x174 (L)
>>    _find_key+0x98/0x168
>>    dev_pm_opp_find_bw_ceil+0x50/0x88
>> ...
>>
>> In order to fix the crash, create an assert function to check
>> if the bandwidth table were created before trying to get a
>> bandwidth with _read_bw().
>>
>> Fixes: add1dc094a74 ("OPP: Use generic key finding helpers for bandwidth key")
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/opp/core.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index 8692e8ce05b7c31a725ea3a7928f238c7a1d6f51..178780e294dad49c22d866930efb7b8b13ae2d61 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -114,6 +114,14 @@ static bool assert_clk_index(struct opp_table *opp_table, int index)
>>   	return opp_table->clk_count > index;
>>   }
>>   
>> +/*
>> + * Returns true if bandwidth table is large enough to contain the bandwidth index.
>> + */
>> +static bool assert_bandwidth_index(struct opp_table *opp_table, int index)
>> +{
>> +	return opp_table->path_count > index;
>> +}
>> +
>>   /**
>>    * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an opp
>>    * @opp:	opp for which bandwidth has to be returned for
>> @@ -913,7 +921,8 @@ struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev, unsigned int *bw,
>>   	unsigned long temp = *bw;
>>   	struct dev_pm_opp *opp;
>>   
>> -	opp = _find_key_ceil(dev, &temp, index, true, _read_bw, NULL);
>> +	opp = _find_key_ceil(dev, &temp, index, true, _read_bw,
>> +			     assert_bandwidth_index);
>>   	*bw = temp;
>>   	return opp;
>>   }
>> @@ -944,7 +953,8 @@ struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
>>   	unsigned long temp = *bw;
>>   	struct dev_pm_opp *opp;
>>   
>> -	opp = _find_key_floor(dev, &temp, index, true, _read_bw, NULL);
>> +	opp = _find_key_floor(dev, &temp, index, true, _read_bw,
>> +			      assert_bandwidth_index);
>>   	*bw = temp;
>>   	return opp;
>>   }
> 
> Applied. Thanks.
> 

Wait, this needs the first patch to work, otherwise index is not passed to assert

Neil

