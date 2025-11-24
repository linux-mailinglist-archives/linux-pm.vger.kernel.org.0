Return-Path: <linux-pm+bounces-38455-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFC5C8024F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8752F3ACF1B
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEC72FDC26;
	Mon, 24 Nov 2025 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijgtDLJ6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861562FDC2F
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982517; cv=none; b=JoN9tOVZ64ofu30FGTcw11BMIoyI3gJdbDRbYYQtc4wMmDjMtZXcqPN5LMwwQ31XsXPjd5bQVh8vJeRlGZam0dw5YGeLoF+NNOdk1u7S6ukfx9WkUq2xILiKyz+mdOfyKgx0j7P0CwMvNgywhIxoWpEIyY2Saet++FixZxRHZ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982517; c=relaxed/simple;
	bh=pX8uLa24ufHlLnnLsdkJcwhfxVMAqlg8mivH7rZolUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJQwC9hU4KDgK7PeMZbtrtzdOYr6XJvWMLulD/+/z6ZYBjRor31Tb6LgO1WyhmCeCzS0tJWdWfeszPUqPdCr9inQYF50Y1RFHQOY9urRRU8ptyGoeH5CDfyVbsCaMV3d+Rv+UDI32EBSmouqeHAabHZy1kYYmi7L38oCmedWneg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ijgtDLJ6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso25348685e9.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 03:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763982514; x=1764587314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6+5l3fHno/+RdcEbAfvBbgPLJtbuD4ohAwU1afUy64o=;
        b=ijgtDLJ6oHUA1HOO3yZn/MmCXSUYorO2nogBZvBDzkP/o11ZGYY2Sv1l/dYiwPJudc
         lPCXvHw/n4bho6mdlVfhA52Q2u5FMwN3Db2fIcR860IkEGvn16MUOwTeuVuvzmPWnQYH
         3gt4ilOS3ejCHGYkmQESxgLBB97wqtK/M15z83+ZWz14bL3y3C1NBYH+0sJx6QqjwWH0
         yTFr17xvak0uLhRDmZn/fvbhorQ54xYp2bCBuKEp6JAkJcT70hD0wsAZhofhtSnl8ZWm
         7KAZW1I0kGtjkjUpkgaSmVJSLRIrf+oxX3szz40CM546YsERIQV5EzTAX3Km2GaSkCcQ
         PBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763982514; x=1764587314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+5l3fHno/+RdcEbAfvBbgPLJtbuD4ohAwU1afUy64o=;
        b=u4x4/BBc+HXd2Y7ccLY1HbG53eQz0vYP4TEQtZurbdN35Vmowt6hs3vIOue01aacMf
         TQLcSbIW9xulwCXiLvd896IP1m90G4O1mCSUXm58hV6FhEF+a6cTxt/haXQtRQV1YRR9
         mv7TICByxk9gw3wBncfjec2UtEDk8x5C+c6JR7weEjRafMpmtC+WOWY+q+/Feng9m0fd
         55ZnIKYquObarHngS8pQy6x9pkxNbUspYX3J253E72r1OSI+KkKi2hrZyhPbnM+GUfCL
         /AWwfnYnuwEvxaW344idzgDXaFl/BO+Hgp2hH7lWVvo4N8JGh0Wgyfy6aM5IDbOLs7hs
         /T8A==
X-Forwarded-Encrypted: i=1; AJvYcCV0jfyiIE3SpyqMeV6R1T2/tpsSWeYe7IwkL7TYr8MmBEXTQe04h1C9HOQ+JOBt7+BuUYzNNkBllQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTA+jmcc53IjrI2ZcYSKh9x10V8i1XGQovD+zTQYNe7QVU/TQ2
	NLTg406ZlL0tZbqK/qfXkLpgUC5wY4y62atoB0QzB3QTfn/Bqfwgnb5sm1yj4UDLHww=
X-Gm-Gg: ASbGncshrR/zcBQv8RN/EbjVc9Sq8lV3JQZESKYWgb66oecIG2I7BceCEx7PtHEMZ4P
	EzdOp3Qya3n2yGUQDvjm/Zt8w7wsBRzIhlC9SM9iWzqHSlIX6G38Vf8bANETo7B1KThQlp+LZBU
	eukrXVw+ZD/3eNa0PCe+mxyVcbG1wnRcf9ntwl6Lob2CNmJny7F20Sepjgsvbq6w3UX6tv1oqbR
	tsD9tSHw/5Q9ZlgIdYE4hBGUy40FXfp3daX6AbtFUfLDG9OPb0HbvZxh9rouANk7/Ll8wa5E9l3
	D+J1nC/Xd//saaC5EdDTwirWvU9QXCTKh9pM9YbzBoifHcxZMBNIzCkien0zkhb0KQdz3l6xozp
	OOwpZf+hyufTmVyit/mQHDF91N///hW5hBVjJ5RR1l284r4qLympf6O3C49PtdYb/MZXmvo0G38
	mhBTdYkAx2FEAOtJsvfvVstQKQiHTDkPpu2Z2LGk8x3gVyJKw3//xxzbK5VPEOAHoxWQ==
X-Google-Smtp-Source: AGHT+IFTZFirZPCwnUDDiKfKr7H0K4OzotyW7bjOyOjeldVQNp8jBiM4RwHnhw/nv1j7ENdmzDjRpA==
X-Received: by 2002:a05:600c:1914:b0:471:114e:5894 with SMTP id 5b1f17b1804b1-477c112587fmr86546865e9.25.1763982513683;
        Mon, 24 Nov 2025 03:08:33 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:a756:bb6c:7b35:af9b? ([2a05:6e02:1041:c10:a756:bb6c:7b35:af9b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-477bf3af0e1sm186819905e9.10.2025.11.24.03.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 03:08:33 -0800 (PST)
Message-ID: <2b63c064-ce62-421b-8469-e434bd0c9652@linaro.org>
Date: Mon, 24 Nov 2025 12:08:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 RESEND 2/3] thermal: exynos_tmu: Support new hardware
 and update TMU interface
To: =?UTF-8?B?7IaQ7Iug?= <shin.son@samsung.com>,
 'Bartlomiej Zolnierkiewicz' <bzolnier@gmail.com>,
 'Krzysztof Kozlowski' <krzk@kernel.org>,
 "'Rafael J . Wysocki'" <rafael@kernel.org>, 'Zhang Rui'
 <rui.zhang@intel.com>, 'Lukasz Luba' <lukasz.luba@arm.com>,
 'Rob Herring' <robh@kernel.org>, 'Conor Dooley' <conor+dt@kernel.org>,
 'Alim Akhtar' <alim.akhtar@samsung.com>
Cc: 'Henrik Grimler' <henrik@grimler.se>, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251113064022.2701578-1-shin.son@samsung.com>
 <CGME20251113064044epcas2p1b87addb21473eca7cc52052e4e2e9237@epcas2p1.samsung.com>
 <20251113064022.2701578-3-shin.son@samsung.com>
 <2180a854-8ba6-4424-add2-eb34637530c1@linaro.org>
 <000001dc5d2a$0697bf10$13c73d30$@samsung.com>
 <ab35c20e-390c-4479-9bb1-9f5e49cba2a0@linaro.org>
 <000001dc5d32$2b4bfb20$81e3f160$@samsung.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <000001dc5d32$2b4bfb20$81e3f160$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/24/25 12:04, 손신 wrote:
> Hello, Daniel Lezcano.
> 
>> On 11/24/25 11:06, 손신 wrote:
>> [ ... ]
>>
>>> However, since ExynosAutov920 diverges significantly from the existing
>>> driver, Would introducing a separate driver instead of unifying
>> everything be acceptable?
>>
>> So this driver is one controller for multiple sensors while the others
>> drivers are one controller for one sensor, right ?
>>
> 
> Yes. As far as I understand, the previous Exynos variants used one TMU controller per sensor,
> while on ExynosAutoV920 the hardware has multiple TMU instances and each instance contains multiple sensors.
> Therefore, this new automotive SoC requires supporting multiple sensors behind a single TMU controller.

Ok thanks. It makes sense to create a separate driver.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

