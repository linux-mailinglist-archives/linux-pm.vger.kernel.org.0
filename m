Return-Path: <linux-pm+bounces-18222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B9D9DC0DE
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 09:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341CD164039
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 08:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9922816DEDF;
	Fri, 29 Nov 2024 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xyb3x9v6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5C016DECB
	for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732870430; cv=none; b=N3YiOSrLZ0mAkhOwr7dfc0l2bBHCefAUZ63jLNOFG45Vp6yZ/mF3kX3gcnMCkxCQqb0qyyHmrwR72mxf5eWX0+DHP961xAK6DXOTK9PVJaasuL4ZIqaeQ8naWUBpesFyfL/usiy+EHJ5dkux1alQz0GeqM6kRoMKdxTvf3WstKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732870430; c=relaxed/simple;
	bh=n8IJdecDMHQzahVcw8xdhr9EL5oNee60NvkmMoAdlV8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=spFp3U9jGDFr0kXse63tS/Gchzw1QBKxwqpMUVcPiok+7Rb0/WzgX+FFP4M45s2jxDkAsxDAVehiFtzo46mN/EdxjNnKYSuhhil+jLBP9UuobedcyZfTF18Zhh3k4VuQveAeUIxpZv2iGqD9BbDSGyS78lVazaiUP2X4x8DhX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xyb3x9v6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434aa472617so14710945e9.3
        for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 00:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732870427; x=1733475227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u46XbdPL5l4Wfy/A3vmf4c64xyaqFvqK15sX5xGxSDk=;
        b=Xyb3x9v6S5nyVHb1XQoz/t9YgLxc/GNINpLFDghP25pxfsoY9ho/HmmpQdwxYHiXGI
         CltMBBQe4vu972tvLJ/gUIH58J+KyTZcX1+5pXd8O1zXyvOofoDzaBYSiv0dMFcXa0DJ
         Iz93QrYu+uz7kmxCN29K5Zc7CTMaDjjx5k38m7Ikxle6IIulIV1rbyQJ2fAgTA++X3Cq
         AekBUe5ObTxcnWvhZS4NLKCFfxXZXZa/n+hkIX5yLBc5mGMvZeAcsZf6BSM4QwO75/Aq
         SPiRRs6EK2FIO4IbmpcFR3Mmcte9lYw3Hy0LOM97BCugmxCZeqQkX1kAE/+snbsq7Scx
         6kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732870427; x=1733475227;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u46XbdPL5l4Wfy/A3vmf4c64xyaqFvqK15sX5xGxSDk=;
        b=MW3HAjX9O9eeVtMOzsM/Z7f4odM+xFsYrnxAqUjIZ04C7LZG3T1o4LzE/dNtqCOZUB
         80NPLXiB3wq+dQ//3TfrVDvtRWYd6ZDRauRsRHaD4r1LgXJXCzumDuKOl+x+O8tQ9Mo/
         +C1lMOUr63vTeZXRbETHQsla8yNTs6GscLZWhxHWqDnSqr/ClGwf0LifK9IIoZrb++wi
         mw0r0Iam1kLzyKdsUA4m4KT3eYEIS2/dN/hgsvWwjqrisihLWylIY02L4hrCaMkaM37n
         7/Ozj4bHIrV0BGxM7KhubK/XKwzKdZzdS90h7Hob/U7oZe1tTI+q35AzsLPh02hvZlXB
         aHQw==
X-Forwarded-Encrypted: i=1; AJvYcCUwFI0GJ7JV8csGYrX2mcT5MFtSG6TcNTnYv++6CCyJndkxnWlao9RneJ+8m69WJLGVOQEYcAkWkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyapKqCoId6Y0AUXtjd7ocjmNBpYofW2EX2oSdVa65qLLpgcObd
	YuXGrU/fm/RkQrKR/sYAflAckiQPBwqbaDsXzwDXgoTo2l0iYJHNDRuNaDPJ3BY=
X-Gm-Gg: ASbGncshoA+UBFBAk5oGqZh7kRzm7huCJA27ASteAIxLQpqe2VAiV/gXaKMzFEmFP4c
	aTjMiOxWWjmz3K1uzwOcJEDxpJk7xDS5W5DWNakQt3GZQmEhDGWCpIFzsMyqHL3am/CgAy+L9MW
	ZnkyCbSJh69tUR+cZVDNCMIrc8of5Al51XsQDVdxazq58NMtSYqWH63EXdFDJf2PHzt4hSFzy2S
	X/qcYofFHF07YRf5sIkfkai6w5LHAKibN1FMCO/JQPa3r23101DXiQFWxmno1ek7QTIAyKToCD2
	WI2gYuEz2/Ou65xumKpL9aOQ
X-Google-Smtp-Source: AGHT+IHldnNNjjdF9Zj40j8crC1Nm/FHndf+0pCBRz6FsjlgY7JCbQ8VDIg87hlM9vjS8eO4PSt4XA==
X-Received: by 2002:a05:600c:6d46:b0:434:a5d1:9917 with SMTP id 5b1f17b1804b1-434a9de4533mr80614775e9.21.1732870426941;
        Fri, 29 Nov 2024 00:53:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:f573:30fa:4c5:27df? ([2a01:e0a:982:cbb0:f573:30fa:4c5:27df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa6e929csm80103585e9.0.2024.11.29.00.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 00:53:46 -0800 (PST)
Message-ID: <c6b5b6f7-ab55-4d46-888e-f9e00b269c9c@linaro.org>
Date: Fri, 29 Nov 2024 09:53:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] OPP: add index check to assert to avoid buffer
 overflow in _read_freq()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241128-topic-opp-fix-assert-index-check-v1-0-cb8bd4c0370e@linaro.org>
 <20241128-topic-opp-fix-assert-index-check-v1-1-cb8bd4c0370e@linaro.org>
 <20241129084052.wfi7nakgcnt3zkur@vireshk-i7>
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
In-Reply-To: <20241129084052.wfi7nakgcnt3zkur@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 29/11/2024 09:40, Viresh Kumar wrote:
> On 28-11-24, 11:07, Neil Armstrong wrote:
>> Pass the freq index to the assert function to make sure
>> we do not read a freq out of the opp->rates[] table.
>>
>> Without that the index value is never checked when called from
>> dev_pm_opp_find_freq_exact_indexed() or
>> dev_pm_opp_find_freq_ceil/floor_indexed().
> 
> These APIs aren't supported for cases where we have more than one clks
> available and hence assert for single clk.
> 

I don't understand, the _indexed functions clearly have an index parameter
which is documented as "Clock index"

I agree we could leave the other ones with assert_single_clk, but we would
need to duplicate it to have one with the index parameter, so it felt simpler
to use assert_clk_index everywhere but indeed we do not exclude them for
when there's multiple clock...

Neil

