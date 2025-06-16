Return-Path: <linux-pm+bounces-28838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4722ADB66A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 18:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B633A3FA8
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 16:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D403628643E;
	Mon, 16 Jun 2025 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JNCL0Pl7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0D61F8676
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090497; cv=none; b=lO439FSaDn1XRZtj46AWhdd3y2lGSs0+pa4CEoNW7gr+k1jyvJglF5BaG91KTmQiUPIT1yShGMQU2QgUeAAmbeDJySzVlPLO5bhOsBNCeCYlQPDJllBoMMcYkxaEltPw+A/Rme4P5QaBkAbxeSfnwfBiX3y7Dc3qpHoWG4uzKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090497; c=relaxed/simple;
	bh=z439W5Ak0AIQ4ZXFqNztHbJlyRGwss0RRsUcYjTyWOk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jYiRQaPWRPD4vMC8MFCU56hH5rwatPVyIAwdFMla/CjYlgtgmcdHxJpUrBF9dkjjT3BBQnZZYydnk1NHsBbEtRYJjxTp4pBkZYObrbPYVzU3jx0LLEFzm67hd7G2lstTsBVfBL/hSqsID2wxjC9YR8rmhyNB6zA5Q3LOazrF+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JNCL0Pl7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d54214adso36741895e9.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750090494; x=1750695294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6ibnzdhEbpwMjSrCwWztiKo4mjian3JWQr5b7BDJBQ=;
        b=JNCL0Pl7wdkuKSQk9CBHiPDTjh+4d3b8wnIua7jG2CU4N+rLCSWGVFPRojdAMNynQX
         d8CucZN80xB+Jls8HUNdgvzoxz/ufGm5ZV84adAb8oHwTpsIa+HLnC8nStiaYKdkw+hv
         eWForqgLXeRPRG3B8brB0Mrlp39ndThlKyu4EhDVjEwftI7RXmvg5sfe697orWcZUFD8
         vvRNiPYvKVdccZ4FvJrn8FmQKcDzCC+cVzBg43j9YnTujLaUbyBcg6hQtYpj+hXeTHZt
         fHWv3ajTaQiVrTLtUKtBjtnrQc0izLfNveBHESgEA1RclJKSJjChxdA5ih5hWoZT0006
         MthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750090494; x=1750695294;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T6ibnzdhEbpwMjSrCwWztiKo4mjian3JWQr5b7BDJBQ=;
        b=nmaiVshrW8ii6Cw4R17I1mCdNjs3WnRA5cEb2lKJ2AI0sLDgjWHtgpKCr8QejKUtaN
         +8asXd+N1ASyDBOTxbk+ge1RRtTxKm0BbZi6X3vwP5atkPqEpI9dzW7Ua1yGWyX14TeL
         P4rP/KzqnNuKoP1D+Yzrk703NfUgEdKbzJTohKzIBmVdiLRGu6nsGXKF+66m7RY8CH6P
         8X6gppgWyC1ya8cbljxjQhQsNrmgqszVtqsKStgk2CgK7GrQs6Rk2lzfLj2uJlMDNId5
         tNTjrhpLmsIJ5n0lUYy2gWY4KReoIoWqgGpBH60EqJ6xojJpPUCffGJZIklCphlAv1b0
         FIsA==
X-Forwarded-Encrypted: i=1; AJvYcCV1vdU9DlLcTrWnSPzq4QoFhHEtQnhC5VAsKlCmTXeCex+0Bk/uFy7kmcmCvVx8HbuDHrnKhW/nRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDN6HSHzDYRpyvxu28C6PstZSOAHEyjm/yF0tGs8E+8qEncAlU
	WVPhp6jx/TQipU8gymWce+GC2jXqNJ8WhEkM5iVb1Gfct44SZliEMeNsgtRc1wpFRjg=
X-Gm-Gg: ASbGncva9NIw69y2mH5x2vwCQrjMfuyHHZ/0/btjk+aNxV4Rvyxnp3fCh7qI5JClgZQ
	xtex1xoRJ9SdtjArs2x/a4inuXGyS1d808+ikZJN4ltqBGXVOLML9stImg0Qwt76+0FpJL0u8gq
	XLXzTHXiLa1qeVhUaBaiQMPwpVT7JKnIBjhglLczV0jdp4wfeVWEdUDWRkkjWrZFElakaKzuqwY
	EniEEIpPimP/vsoam34W6yNlq8y++zAWZweVg3JoNr7G3dgivUBgOhKkvTVBXVUOs93Rfsml2Zu
	8VBuJnjtabGc+mhDipqP6I/IR/RjbIAFMubE8qNR7dW3rjlo3CjT8TZTF72LXKVSgZ5GmMLQX94
	xx6S9QhXml17CIyxhqJpQAnW+xJjZ6EddS1As
X-Google-Smtp-Source: AGHT+IEPIO5Rqt/93HylwQWU87OlnErReHGRzssV5WREAarN4Bu7nuprotM72PiFJu5jYscm3o2rqw==
X-Received: by 2002:a05:600c:4e02:b0:453:c39:d0c2 with SMTP id 5b1f17b1804b1-4533cab541amr86940715e9.24.1750090494145;
        Mon, 16 Jun 2025 09:14:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:6c7:97de:65a8:488a? ([2a01:e0a:3d9:2080:6c7:97de:65a8:488a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532dea1cc5sm153416565e9.16.2025.06.16.09.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 09:14:53 -0700 (PDT)
Message-ID: <346f0fbe-5bf7-492e-9e00-0fafbf02899e@linaro.org>
Date: Mon, 16 Jun 2025 18:14:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 00/28] interconnect: qcom: icc-rpmh: use NULL-terminated
 arrays and drop static IDs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
 <786e3337-4c14-4281-932e-6a93aac53cf8@linaro.org>
 <8af6ce19-7aa3-4fc7-a963-d8ab0cd22b02@oss.qualcomm.com>
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
In-Reply-To: <8af6ce19-7aa3-4fc7-a963-d8ab0cd22b02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/06/2025 17:53, Dmitry Baryshkov wrote:
> On 16/06/2025 18:51, neil.armstrong@linaro.org wrote:
>> Hi,
>>
>> On 16/06/2025 02:28, Dmitry Baryshkov wrote:
>>> Qualcomm interconnect code has been using .num_foo fields together with
>>> the arrays embedded in the structure, which results in hard-to-notice
>>> mistakes if .num_foo gets omitted or incorrect.
>>>
>>> Rework RPMh interconnect code to use NULL-terminated arrays for the
>>> dynamic IDs case (as now all the arrays contain only pointers) and,
>>> while we are at it, rework all the drivers to use dynamic IDs and drop
>>> static IDs code.
>>>
>>> This series touches only RPMh interconnect drivers. Corresponding series
>>> for RPM drivers will follow up shortly.
>>
>> Can you specify on which base thie patchset applies ?
>>
>> I tried v6.15, v6.16-rc1, v6.16-rc2, next-20250613 & next-20250616 and they all fail to
>> apply on patch 5.
> 
> I'm sorry, I forgot to mention https://lore.kernel.org/linux-arm-msm/20250613-sc7280-icc-pcie1-fix-v1-1-0b09813e3b09@radxa.com/

This does the trick, thx!

Neil

> 
>>
>> Thanks,
>> Neil
>>
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> ---
>>> Dmitry Baryshkov (28):
>>>        interconnect: qcom: sc8280xp: specify num_links for qnm_a1noc_cfg
>>>        interconnect: qcom: sc8180x: specify num_nodes
>>>        interconnect: qcom: rpmh: make nodes a NULL_terminated array
>>>        interconnect: qcom: rpmh: make link_nodes a NULL_terminated array
>>>        interconnect: qcom: sc7280: convert to dynamic IDs
>>>        interconnect: qcom: sc8180x: convert to dynamic IDs
>>>        interconnect: qcom: sc8280xp: convert to dynamic IDs
>>>        interconnect: qcom: sdm845: convert to dynamic IDs
>>>        interconnect: qcom: sm8250: convert to dynamic IDs
>>>        interconnect: qcom: x1e80100: convert to dynamic IDs
>>>        interconnect: qcom: qcs615: convert to dynamic IDs
>>>        interconnect: qcom: qcs8300: convert to dynamic IDs
>>>        interconnect: qcom: qdu1000: convert to dynamic IDs
>>>        interconnect: qcom: sar2130p: convert to dynamic IDs
>>>        interconnect: qcom: sc7180: convert to dynamic IDs
>>>        interconnect: qcom: sdm670: convert to dynamic IDs
>>>        interconnect: qcom: sdx55: convert to dynamic IDs
>>>        interconnect: qcom: sdx65: convert to dynamic IDs
>>>        interconnect: qcom: sdx75: convert to dynamic IDs
>>>        interconnect: qcom: sm6350: convert to dynamic IDs
>>>        interconnect: qcom: sm7150: convert to dynamic IDs
>>>        interconnect: qcom: sm8150: convert to dynamic IDs
>>>        interconnect: qcom: sm8350: convert to dynamic IDs
>>>        interconnect: qcom: sm8450: convert to dynamic IDs
>>>        interconnect: qcom: sm8550: convert to dynamic IDs
>>>        interconnect: qcom: sm8650: convert to dynamic IDs
>>>        interconnect: qcom: sm8750: convert to dynamic IDs
>>>        interconnect: qcom: icc-rpmh: drop support for non-dynamic IDS
>>>
>>>   drivers/interconnect/qcom/bcm-voter.c |    4 +-
>>>   drivers/interconnect/qcom/icc-rpmh.c  |   20 +-
>>>   drivers/interconnect/qcom/icc-rpmh.h  |   13 +-
>>>   drivers/interconnect/qcom/qcs615.c    |  713 ++++++++-----------
>>>   drivers/interconnect/qcom/qcs615.h    |  128 ----
>>>   drivers/interconnect/qcom/qcs8300.c   |  911 +++++++++++-------------
>>>   drivers/interconnect/qcom/qcs8300.h   |  177 -----
>>>   drivers/interconnect/qcom/qdu1000.c   |  470 ++++++------
>>>   drivers/interconnect/qcom/qdu1000.h   |   95 ---
>>>   drivers/interconnect/qcom/sa8775p.c   |  493 ++++++-------
>>>   drivers/interconnect/qcom/sar2130p.c  |  795 ++++++++-------------
>>>   drivers/interconnect/qcom/sc7180.c    |  892 +++++++++++------------
>>>   drivers/interconnect/qcom/sc7180.h    |  149 ----
>>>   drivers/interconnect/qcom/sc7280.c    |  840 ++++++++++------------
>>>   drivers/interconnect/qcom/sc7280.h    |  154 ----
>>>   drivers/interconnect/qcom/sc8180x.c   | 1013 +++++++++++++-------------
>>>   drivers/interconnect/qcom/sc8180x.h   |  179 -----
>>>   drivers/interconnect/qcom/sc8280xp.c  | 1257 +++++++++++++++ +-----------------
>>>   drivers/interconnect/qcom/sc8280xp.h  |  209 ------
>>>   drivers/interconnect/qcom/sdm670.c    |  712 +++++++++----------
>>>   drivers/interconnect/qcom/sdm670.h    |  128 ----
>>>   drivers/interconnect/qcom/sdm845.c    |  986 ++++++++++++--------------
>>>   drivers/interconnect/qcom/sdm845.h    |  140 ----
>>>   drivers/interconnect/qcom/sdx55.c     |  611 ++++++++--------
>>>   drivers/interconnect/qcom/sdx55.h     |   70 --
>>>   drivers/interconnect/qcom/sdx65.c     |  577 +++++++--------
>>>   drivers/interconnect/qcom/sdx65.h     |   65 --
>>>   drivers/interconnect/qcom/sdx75.c     |  498 ++++++-------
>>>   drivers/interconnect/qcom/sdx75.h     |   97 ---
>>>   drivers/interconnect/qcom/sm6350.c    |  838 +++++++++++-----------
>>>   drivers/interconnect/qcom/sm6350.h    |  139 ----
>>>   drivers/interconnect/qcom/sm7150.c    |  860 +++++++++++-----------
>>>   drivers/interconnect/qcom/sm7150.h    |  140 ----
>>>   drivers/interconnect/qcom/sm8150.c    |  930 ++++++++++++------------
>>>   drivers/interconnect/qcom/sm8150.h    |  152 ----
>>>   drivers/interconnect/qcom/sm8250.c    |  977 ++++++++++++-------------
>>>   drivers/interconnect/qcom/sm8250.h    |  168 -----
>>>   drivers/interconnect/qcom/sm8350.c    |  901 ++++++++++++-----------
>>>   drivers/interconnect/qcom/sm8350.h    |  158 -----
>>>   drivers/interconnect/qcom/sm8450.c    |  823 ++++++++++-----------
>>>   drivers/interconnect/qcom/sm8450.h    |  169 -----
>>>   drivers/interconnect/qcom/sm8550.c    |  683 ++++++++----------
>>>   drivers/interconnect/qcom/sm8550.h    |  138 ----
>>>   drivers/interconnect/qcom/sm8650.c    |  713 ++++++++-----------
>>>   drivers/interconnect/qcom/sm8650.h    |  144 ----
>>>   drivers/interconnect/qcom/sm8750.c    |  779 ++++++++------------
>>>   drivers/interconnect/qcom/x1e80100.c  |  819 ++++++++++-----------
>>>   drivers/interconnect/qcom/x1e80100.h  |  192 -----
>>>   48 files changed, 8655 insertions(+), 13464 deletions(-)
>>> ---
>>> base-commit: 410f15dcfe222c06f0d6379adec630061e88dc72
>>> change-id: 20250613-rework-icc-0d3b7276a798
>>>
>>> Best regards,
>>
> 
> 


