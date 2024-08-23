Return-Path: <linux-pm+bounces-12799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009C295C6C3
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 09:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC64828502D
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 07:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AC213C9B8;
	Fri, 23 Aug 2024 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIVybSze"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF26B136E2E;
	Fri, 23 Aug 2024 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724398935; cv=none; b=aIy1nfqn50SMQAiUKsoC95ajkMakWnZXkibU99IylEOiVqgdhw9LWlPr1HDUU3xhuN1E0Yhv8vDcBmsyKIkPloZv11YaIx/y09jmifXq6RndKDJHSYg0tcCyRBz3vGW/dHFBplujSmZbp07ODIPMo+UQ61bKKizZCmEpj2gF2L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724398935; c=relaxed/simple;
	bh=M7afrbCTOjJsx5/pZ/k1jDI9Mt/cA+YQE9ScwQankdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQ328mQcGXKZpT3o9TrySZiG1UWoWQznGfDKYjrVrAgIbMtz2v5ZNTd92YweZBEsqyw3KBz/qCuGOxGE48nn8EQisZORhTU3eGPxYUA5e7CJE+IP5iRUSORvvMjmoZVHC7y1Ia5ey6IQYt27mzSW3C6KaFAqcBLQw2bEHIbeKKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIVybSze; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37196229343so980965f8f.0;
        Fri, 23 Aug 2024 00:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724398932; x=1725003732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MSL59BbQ6Xk5NHEIiJ2YE2YoOu8orcdF2pGp210GrzM=;
        b=CIVybSzeABHU0NtpHsXR3c5NmqP9xWGfKmxfMA+bphZxl7hGMWm+L7Vew5N3YgQZ2J
         kYo6LliDIsG0mOyzAnkDu8SzVB8x1BuZZbmffSBL+9VIRbexl+jW+hrFnFoARUO3khZS
         m/gtQ+sEeYEfPJNMSg4NHGJr5GyFnmd3+jflzAxNpEnzLPOzkhUXJacTyF2ZuIuiM+ZP
         46V0tpPjhBwFNY7JFpvaw3LDn0qWVndgZG5gi9n18dGWKMwezpEfqXICaKmNsuLGZEZN
         zTA+UtqLXzj0j5zgC19gBjmPPkn9YOQ/e5xKTAKVlm75AG/gOHklZh7fnGHeE0HxnVuJ
         hgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724398932; x=1725003732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSL59BbQ6Xk5NHEIiJ2YE2YoOu8orcdF2pGp210GrzM=;
        b=gim36CM+cYOkvVUONvjFMOD50CAHCo9kCxCtz+nM3d+xeyBTns0Pq7vRiYrwL7b9ff
         NwQ1hZPMCqVldnD2iwpq0dsw6TmD8AJQE7UvuxcaDKArZGgHyXFEjmo8kvV3Tu8Dc9q+
         6bHNc9oVYCZ/e1L7matzTXcdYkkzoA7loE0dDuZuJB4sUtc++A5rNKr9f+bG1QzVGTNt
         ATIFB+4X0UiVwEchBEhMZAInt8ohwpZ13dXyuSEQO42pulYpJBsAITsC0u6s1BXvHuuJ
         OiTkXYap0V3QjXOJ7RmyGWXIkTjQ+QnevoHD+PGaqd21J3lgUQ6nEhqspwV4ltl+e2xG
         9P1w==
X-Forwarded-Encrypted: i=1; AJvYcCU8AGzr1qdq1kdjc94MDYJH6T2yJ1ZaxV1odIUoK6rJyWE9Xt63RSvNjtv2vb0QvQJQhiPcRfZtcZUECoY=@vger.kernel.org, AJvYcCU9GUjdpw9vtNxU4Zzy8wMDjv8PjB5CWhMjL56YdrkfEnOS6jm/tkXij/f5dhwTfqx9Ak/hiDmuZcOPlpQl@vger.kernel.org, AJvYcCW0CcusvBmKU+9TwbVMD+/Qo6mDIjnjwqSzr1rbof+E3c0EVlqqULekTFdN7jg+V7z28+uKOjy3gnA=@vger.kernel.org, AJvYcCXS40mhXqSaeO6SPYAJnHiW8atvF4270xBY52kykVV7pOwogYaLsBOyI7m5kiHQPjiWnN/miJtev49/uxtv@vger.kernel.org
X-Gm-Message-State: AOJu0YwTDUlFp3g7VvEPl0V3B4yVOGajJ4BA7CGzAoML+BwAP/iU/4pv
	kEfb5wjckm25N/z0yy3SdIichONMYEydRKMuavAZRDi3olIpCVMV
X-Google-Smtp-Source: AGHT+IF6cfTkCHL1aIPaVHxBmCjOhItdmwlQH2yJuElaKoubs+GcMSkGpFZ+LVUfgUF1aGi7WQThbA==
X-Received: by 2002:adf:f510:0:b0:368:4bc0:9211 with SMTP id ffacd0b85a97d-37311865088mr754647f8f.17.1724398931675;
        Fri, 23 Aug 2024 00:42:11 -0700 (PDT)
Received: from [192.168.1.19] (79-100-234-73.ip.btc-net.bg. [79.100.234.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730821ab1bsm3478097f8f.99.2024.08.23.00.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 00:42:11 -0700 (PDT)
Message-ID: <557d576b-627f-4cc8-9f4b-59dc8d86a9ae@gmail.com>
Date: Fri, 23 Aug 2024 10:42:10 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] media: venus: Use dev_pm_domain_attach|detach_list()
 for OPP PM domain
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Vikash Garodia <quic_vgarodia@quicinc.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240723144610.564273-1-ulf.hansson@linaro.org>
 <20240723144610.564273-3-ulf.hansson@linaro.org>
 <0af670ae-8c8f-4e78-b1e0-e9ccb4fba2c9@gmail.com>
 <CAPDyKFr5xjE867rHRZxtKPr0iKh9B6_Ckyu=B4Jzn-ExDpQjVQ@mail.gmail.com>
 <bfb90d04-6885-4623-a846-f04b4fe4bff4@gmail.com>
 <CAPDyKFp5R=T1BgCHZhR=mr+z7VnF3x=DeAvjPZ3bE1Q5TWYzVQ@mail.gmail.com>
Content-Language: en-US, bg-BG
From: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
In-Reply-To: <CAPDyKFp5R=T1BgCHZhR=mr+z7VnF3x=DeAvjPZ3bE1Q5TWYzVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ulf,

On 23.08.24 г. 0:40 ч., Ulf Hansson wrote:
> On Thu, 22 Aug 2024 at 20:05, Stanimir Varbanov
> <stanimir.k.varbanov@gmail.com> wrote:
>>
>> Hi Ulf,
>>
>> On 21.08.24 г. 11:56 ч., Ulf Hansson wrote:
>>> On Tue, 20 Aug 2024 at 22:48, Stanimir Varbanov
>>> <stanimir.k.varbanov@gmail.com> wrote:
>>>>
>>>> Hi Ulf,
>>>>
>>>> Thank you for the patch!
>>>>
>>>> On 23.07.24 г. 17:46 ч., Ulf Hansson wrote:
>>>>> Rather than hooking up the PM domains through devm_pm_opp_attach_genpd()
>>>>> and manage the device-link, let's avoid the boilerplate-code by converting
>>>>> into dev_pm_domain_attach|detach_list.
>>>>>
>>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>> ---
>>>>>     drivers/media/platform/qcom/venus/core.c      |  8 ++---
>>>>>     drivers/media/platform/qcom/venus/core.h      |  6 +---
>>>>>     .../media/platform/qcom/venus/pm_helpers.c    | 31 ++++++-------------
>>>>>     3 files changed, 14 insertions(+), 31 deletions(-)
>>>>>
>>>>
>>>> Acked-by: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
>>>
>>> Thanks!
>>>
>>>>
>>>> I'll pick it through linux-media.
>>>
>>> Please don't.
>>>
>>> I should have stated that this depends on another series [1] - and
>>> they need either to go together or we need to defer $subject patch
>>> until the next release cycle.
>>
>> Sure, then I guess we will deffer venus patch until the preparation
>> series is merged to avoid conflicts. Thank you!
> 
> Assuming the preparation series gets accepted, maybe we can give it a
> try via my pmdomain tree? Or do expect to land a lot of code that
> could conflict?

Please take it via pmdomain tree. Thank you!

> 
> I also realized that I already have a different series [1] queued in
> my pmdomain tree from Dikshita Agarwal (reviewed by Bryan), that moves
> an existing call for dev_pm_domain_attach() to the new
> devm_pm_domain_attach() helper. So far I haven't received any reports
> about conflicts from linux-next, so it looks good I think.
> 
> Kind regards
> Uffe
> 
> [1]
> https://lore.kernel.org/all/CAPDyKFqsHL3uatmLZaRzZ_GfkZw-+fURQNSEgvmrf-ini+WHng@mail.gmail.com/

-- 
regards,
Stan

