Return-Path: <linux-pm+bounces-29358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D38AE4893
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 17:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EAEE18877EC
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C9A25D1EC;
	Mon, 23 Jun 2025 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cq22qlyj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF27279DB8;
	Mon, 23 Jun 2025 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692113; cv=none; b=ZLN+gqa0kktMjqBu1DteuvDK/JHaygys1WnLwdqrl/kD13XRHriNSDm0nlbfgIxoSuOCYI/+gYjG5+Kq2KAgupGX7Uy7WlEbnhLcs6qsK/t8C3VPS9mLUnj4iA9yiSqE4dRmUNLbhVW7XfAxIqkkeU6ad4B2r5WpyRo8auw0JG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692113; c=relaxed/simple;
	bh=iDXmdEhyAO55W9iBkV7RRGlSD2vDaGwcbZyTfII/c6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5oWSjO8q26gqrkKidUNLb9VTEv7TEWibHwFqHcjEMr+948vm+XBCZSHajezezi2jbb1QXG8WDqjhvijMKyqd3AIBcyh7RIsf7Harzo7kuOPki21qYMhZHDXrdHXZX3T3DtGu7/A2DUEpLIGv4OQXMHI0dJ7wVm53C6G19w0N78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cq22qlyj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a588da60dfso2636820f8f.1;
        Mon, 23 Jun 2025 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750692109; x=1751296909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8cS4vJgt2bzsMVFILHHyd6+LvUrXZQpLtPCNsj4gvqY=;
        b=Cq22qlyjm6TKNL//rujdsm0fHSug0Y3/iMqw+fuU2tTxvrkkeGhzp061B7K1Dln1EI
         aw0Bjnrw72VVEjh74oREmlq4tJQrKgAI3BbWLhQRqCPwrox8zJREroLn+SmtRX+r1dvE
         P9ZLHpF5B/G1ylGAbchUlMYyAiITn96Qy7HvG4qJaiynvAZBEyaC1siJvrg1z9rdWk5w
         TJKBDdvK9+vBz+RpRW2xMdCiWhvlIvB7brqItTzSFTv696U5d48Ag2GfdNViC2TG83P5
         hsj3sRsHKnu6TGOvjr4bd3A4C//XYgfack69InqjzAKyVRKz5pbLHX37HX3E3ChbalTC
         +wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750692109; x=1751296909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cS4vJgt2bzsMVFILHHyd6+LvUrXZQpLtPCNsj4gvqY=;
        b=fOxvhTjU5vw1BY9WRzMhbE0xpuGMn6ufh3WuKtyEIutC3szS3ZdyDvK8DSSUqQY5tN
         yxrJkfTSqijogfDCtkZYOeOICd7Ih2LtC8dELHIYjxRE9/x/GsAtCmB4XBM4s3OjWz8O
         rgoUSs7S67d1JL9+XKndXwnoTvst6dKoL4lH8WRyfCcRewcBjANtLbTFyFP/NuFApCpV
         aUAUxC4u1PHpu8ZIk4NYbY0X1iuGU5f1Jhjri4taw0rbQDCOks9/fopNA1jqNynWjaVA
         WP7DJK3U3sXe7u6k3OduQxOXsKfatNX8GQPU0MUSyOcOaBGUCSdhG6+b18BJb/WAZjVz
         CNRA==
X-Forwarded-Encrypted: i=1; AJvYcCU/s/08SfWdM7gghjl6DELd5fu1HSIkLfHxwYNYwSq1yE4o0T22tmyrAGayLwJQpc4WvBbdYyvIPwsTOy8u@vger.kernel.org, AJvYcCUhu3esKepKG29bPHQEB8CZ+9rlexCcQm4DmnCiTvHTaaKk8hclddC+yzSFLcRoDaPnvR17iHoXRC0=@vger.kernel.org, AJvYcCWBTeSX4RDQOwdn+pMGTrQJ/gO5iu+sj4wVjLWdPSzyEuiiap0sSOaPe1zfchCMm0M1F9Qj+YtiM/x2XBQd@vger.kernel.org
X-Gm-Message-State: AOJu0YywyWHI31DrFlZGYbbZjFpcAujaXJQaYT3M3jtsY0i9GgRbiyfC
	g89X+kgU/WLl1U+FixVIrryC1yEd3YG5XCnCW5LRR1aZzopLnyMnjEkO
X-Gm-Gg: ASbGncsGrCNGBPTaBSBDpwrf5lz4xYnFX7NgkN8RRBPuRlDNqch65GWdIdp1qM24n+H
	cPrzf7PwkT+UmvirCa9N1lEH0VscFmQWApff1XOx6XzizG8iBqatIC5ETf7VJCUvpvEtMJHxVId
	WB2FQAPaDUe6IZq48WWaCeeB/k4RfVnJAn2HQNOiOiF2MBvcawuto3kQDJZq/WIQfQvTbX8C8AB
	+5EEDB4w1op/7m+t6rQwT8miT4EvgWg9rdPA7uVkirtoccCUm+GKwaNg8aEtImBBTe6Nb+ytSyG
	v2al25JHHLxBHZXUkWU73MOkN5Cb8RrEsgnnGQKSrjl8z5QL4zCjVrmzGdV9su2I+gtYb1Oozzc
	bWVq1oKyZDjj/kTVEAmHQQbXYIamQfHBQQ7wWyQ==
X-Google-Smtp-Source: AGHT+IFI+UkT9DwUjH1yfJfwdV03hy+2c6+S628d0RymdX+ud/yGlYJZMvlaz3gsjSyYyweYRnEGjQ==
X-Received: by 2002:a05:6000:240a:b0:3a5:2182:bce2 with SMTP id ffacd0b85a97d-3a6d129d5a4mr10659078f8f.17.1750692109171;
        Mon, 23 Jun 2025 08:21:49 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646cb57fsm115444585e9.1.2025.06.23.08.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 08:21:48 -0700 (PDT)
Message-ID: <225213b8-4d90-4db5-a0a8-21edd3a5b2fc@gmail.com>
Date: Mon, 23 Jun 2025 17:21:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] interconnect: avoid memory allocation when
 'icc_bw_lock' is held
Content-Language: hu
To: Johan Hovold <johan@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>,
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Johan Hovold <johan+linaro@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>
References: <20250618-icc-bw-lockdep-v2-1-3223da346765@gmail.com>
 <aFPhdWoZDOrdrbQz@hovoldconsulting.com>
 <90bfae80-f3d3-4c1e-9a5c-9f8205bf90b9@gmail.com>
 <aFkXGUgM9R_MmcB0@hovoldconsulting.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <aFkXGUgM9R_MmcB0@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025. 06. 23. 10:58 keltezéssel, Johan Hovold írta:
> [ +CC: Bjorn ]
> 
> On Thu, Jun 19, 2025 at 03:03:50PM +0200, Gabor Juhos wrote:
>> 2025. 06. 19. 12:07 keltezéssel, Johan Hovold írta:
>>> On Wed, Jun 18, 2025 at 09:58:31PM +0200, Gabor Juhos wrote:
>>>> The 'icc_bw_lock' mutex is introduced in commit af42269c3523
>>>> ("interconnect: Fix locking for runpm vs reclaim") in order
>>>> to decouple serialization of bw aggregation from codepaths
>>>> that require memory allocation.
>>>>
>>>> However commit d30f83d278a9 ("interconnect: core: Add dynamic
>>>> id allocation support") added a devm_kasprintf() call into a
>>>> path protected by the 'icc_bw_lock' which causes this lockdep
>>>> warning (at least on the IPQ9574 platform):
>>>>
>>>>     ======================================================
>>>>     WARNING: possible circular locking dependency detected
>>>>     6.15.0-next-20250529 #0 Not tainted
>>>
>>>> Move the memory allocation part of the code outside of the protected
>>>> path to eliminate the warning, and add a note about why it is moved
>>>> to there. Also add memory allocation failure handling, while we are
>>>> at it.
>>>>
>>>> Fixes: d30f83d278a9 ("interconnect: core: Add dynamic id allocation support")
>>>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>>>> ---
>>>> Changes in v2:
>>>>   - move memory allocation outside of icc_lock
>>>>   - issue a warning and return without modifying the node name in case of
>>>>     memory allocation failure, and adjust the commit description
>>>>   - remove offered tags from Johan and Bryan
>>>>     Note: since I was not sure that that the added WARN_ON() is a substantial
>>>>     change or not, I have removed the offered tags intentionally to be on the
>>>>     safe side
>>>
>>> Bah, what a mess (thanks for dropping the tags).
>>>
>>> This dynamic id feature looks like a very ad-hoc and badly designed
>>> interface.
>>>
>>> icc_node_add() should not be allocating memory in the first place as it
>>> is not designed to ever fail (e.g. does not return errors).
>>>
>>> Generating the name could have been done as part of of
>>> icc_node_create_dyn() or yet another helper for the caller could have
>>> been added for that. In any case, it should be done before calling
>>> icc_node_add().
>>>
>>> Perhaps the best minimal fix of the regression is to move the allocation
>>> into the two users of this interface. They already handle both dynamic
>>> and non-dynamic node allocation explicitly.
>>
>> Ok, I will change the patch. Just to be clear, do you mean the
>> qcom_icc_rpmh_probe() and qcom_osm_l3_probe() functions, right?
> 
> Yes, indeed.

Ok.

> 
> Apparently this is how it was done in the first six iterations of the
> series adding this and then the author was asked to generalise the name
> generation. That can still be done as a follow up (by the Qualcomm
> folks) after fixing the immediate issues:
> 
> 	https://lore.kernel.org/all/lm6gvcrnd2pcphex4pugxie7m47qlvrgvsvuf75w4uumwoouew@qcuvxeb3u72s


Thanks for digging this out, I have only checked the last two iterations.

>>> Then whoever cares about this code can come up with a common interface
>>> for allocating the name (e.g. move it into icc_node_create_dyn() or add
>>> a new icc_node_init() helper or similar).
> 

Regards,
Gabor

