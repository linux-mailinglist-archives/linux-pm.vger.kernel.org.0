Return-Path: <linux-pm+bounces-10655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471E0928367
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 10:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A8A2811E5
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 08:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9059113C681;
	Fri,  5 Jul 2024 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fnlIpplR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22F5481AB
	for <linux-pm@vger.kernel.org>; Fri,  5 Jul 2024 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166892; cv=none; b=lcOHb+oSJuv1UvwK4aMI/kBCmzBkA5I4Bx0Dh/Jfyq3IsEQMXSY7oKyqBTf+mdVJE00KJNQuM7QnKUWQhCQ9GFnzmObuBWV+LEpDNylAfK2+6BebVkADFwMlvAC/R2k2R2hJU1/pyciPMxCYJW2c91/IEgC1858iJcQGUG00RGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166892; c=relaxed/simple;
	bh=wvdYHlQL8lO+IlfRdDENMqAj3V5CQXQwPRSb2U+uwUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2JbR06kYk8jEBs2BTUsziAL3hzuuny2mM3UvvZDeLb6kVKO/NHJV9uh0RjTLSE4e9Hp1J+/+DD+J0LhBw8Y3Tak+jivpZcMKaJ/JLL2VqQMutq3wWFaeovdPrffps1ymrm9HrLQFcJwZ9Co2GDUu/OMRL9v5yXpEja+aeIK+X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fnlIpplR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-424aa70fbc4so9304635e9.1
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2024 01:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720166889; x=1720771689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WjGU82DEow4vCfytvOBUtVOJAoZCXHrpyKm0G7YFVnw=;
        b=fnlIpplR9LVNWRfe10iIgFf8ceq972oakgQaG4vSaisaMyiqjMZumWNq8PcVlLdSux
         e0/F4m98qe6sLDLFnH9px+Qnoriar/jDMxdtmufxGKdm2/9olUGu5gDdJ6WkbfzXA06n
         B7fJhfSbfLllstFBV8GwB8HFEUSL2r1BEua6Zq3AYFXUsmwzT0H0GL6PwbPi96B4pWyw
         hUr2H2y2z36a0wve3LoLgrMmYlxgfa+kpTEFMMCy4CZUXlYN3bDRzoZd1yaGIURxFrgd
         QhvlcoYDIgBp6KoV5EDPX59oMLl/5H+Gg+bT/pOswCjviK0wDwLhqEIifO5LoUWdR5MX
         D4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720166889; x=1720771689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjGU82DEow4vCfytvOBUtVOJAoZCXHrpyKm0G7YFVnw=;
        b=Ed18o1z5cuRcD8AEU/s5BfGILVt7wLicD4VOZSGs8c+hGFdfVA18UHuDa0Is3x3R12
         MgOygr0C1Vl1DweENiEQFUzuhkCwXNQPGIdUR0n2dURXISOiHl6goA7Zyw/Xz+zk54qn
         d839hMXmgub/57vGi6O8NOFJ8GLCSByGclXKY9QE3NnBvsAowvGRm78ZI7L9pw2VwWhf
         dfUXOK+X8sgh6C+IW+Gnw3AZ/uXv1ehuRFDBiKOfimvTGcWBTxoqo4aBVjRadNqf6W90
         PFk/cQhjKE0VheOWESGuhPLe7Ucd5SIOdLpvDX3NBbV34sE+Ifdd9RByLWjHwWmwfnWb
         zBvw==
X-Forwarded-Encrypted: i=1; AJvYcCXFIWpb5rVbWsjHwHsDi3Iq9iKLIogYWcrAbTyvtorx1aYVIFiR8bvv9+XoN1KNUZaXrRD+Y2WnHWojvSGsn1vMrM8DxMTMA10=
X-Gm-Message-State: AOJu0YxlRA9XyxobWVX8KKx++hZoGC2hhlYM9xg0qKeZrrGzgDKHwls1
	F0F7xO5dPa0OU8pirMZyMaiYdmqjPFgFglpEhv78OvzdYTCGNwzMThimu/iVy8Q=
X-Google-Smtp-Source: AGHT+IFknzjJC+OXw3nrKuw0O6Ja5aXZl7xCifpIrGmyLs9uFgT9hmZIVSZhR+sgHT6jrB7dDgY4ZA==
X-Received: by 2002:a05:600c:1c11:b0:424:ada1:6d9 with SMTP id 5b1f17b1804b1-4264a46928dmr31258775e9.34.1720166889435;
        Fri, 05 Jul 2024 01:08:09 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4264a1d69d8sm51097775e9.19.2024.07.05.01.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 01:08:09 -0700 (PDT)
Message-ID: <b63ac8c6-213b-4307-8d33-48badee7881d@linaro.org>
Date: Fri, 5 Jul 2024 10:08:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: core: return -EAGAIN on uninitialized read
 temp
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rhyland Klein <rklein@nvidia.com>,
 Anton Vorontsov <cbouatmailru@gmail.com>, Jenny TC <jenny.tc@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <20240704-topic-sm8x50-upstream-fix-battmgr-temp-tz-warn-v1-1-9d66d6f6efde@linaro.org>
 <a50eb87a-4dcc-4272-b897-fb8170bfe58b@linaro.org>
 <0516a900-0911-47f3-888e-57d014986e3b@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <0516a900-0911-47f3-888e-57d014986e3b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/07/2024 07:56, Krzysztof Kozlowski wrote:
> On 04/07/2024 18:41, Daniel Lezcano wrote:
>> On 04/07/2024 10:52, Neil Armstrong wrote:
>>> If the thermal core tries to update the temperature from an
>>> uninitialized power supply, it will swawn the following warning:
>>> thermal thermal_zoneXX: failed to read out thermal zone (-19)
>>>
>>> But reading from an uninitialized power supply should not be
>>> considered as a fatal error, but the thermal core expects
>>> the -EAGAIN error to be returned in this particular case.
>>>
>>> So convert -ENODEV as -EAGAIN to express the fact that reading
>>> temperature from an uninitialized power supply shouldn't be
>>> a fatal error, but should indicate to the thermal zone it should
>>> retry later.
>>>
>>> It notably removes such messages on Qualcomm platforms using the
>>> qcom_battmgr driver spawning warnings until the aDSP firmware
>>> gets up and the battery manager reports valid data.
>>
>> Is it possible to have the aDSP firmware ready first ?
> 
> I don't think so. ADSP firmware is a file, so as every firmware it can
> be loaded from rootfs, not initramfs (unlike this driver), or even missing.

Ok, said differently, can't we initialize the thermal zone after the 
firmware is loaded ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


