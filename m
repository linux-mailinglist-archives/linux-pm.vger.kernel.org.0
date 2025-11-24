Return-Path: <linux-pm+bounces-38437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F932C7FEE0
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BD544E46C9
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 10:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC06F2F7ADC;
	Mon, 24 Nov 2025 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WF+lv+fu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E708A2F7ABC
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763980525; cv=none; b=Y4Pvbs1byxQMJq/QJ0Nu9zLrZk2ljjxcw8C769AG6cICaurLjVyw+0Q68tugXnKB8Ubgn5gXm7no7u6FrVQtiidKtgM+nKTVnYaHXrbra2ZtLUViTLsB5mR/GfjMbQsDLDFXokERAvOv64F3+ISwla2d2RUD5eW7L2tFyqYCQAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763980525; c=relaxed/simple;
	bh=7d8DEOx2yg6NDuhtFka3LOEqH41+BuOXBDXoifyZ9PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ncK7xuIaQYZYmBgjJuaWY9hUhZn3Q+VVvGfjvkU+EHOVJZR1WnNxb6cgRNIJQHhO92ZCA3fcOCWPPq3G9h+cMqfucRidY9Ywz0oup4RfSB4Srd3JM6HjW2rv5JH5kqZkSomF+FyE8NHkn05WZFtTiSJXC0xsKyxKJ0jLVVAoXbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WF+lv+fu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477a219db05so24512085e9.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 02:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763980522; x=1764585322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ndD6GFhIDsyYEQSTuUmCfWcKYqCeLVrqI/SLqnCg8Xg=;
        b=WF+lv+fuAg6M9f14nCe7tOFBPqTIeRR1NvtN9dJ6iKHXhMTzaqx305arZ9VRmL1/Vr
         yoTvXI2khSBwlHteUGy1rfT9N7qrGT3UwcTw4ZzDGIs/j+jVF/bmcCw9RNBspednnVxy
         M1xHNZxUPGRGOmXocSwB5tXko8bdeLcCsTSmXswjW9oIvyAKtfF6POqMuOK4zW/EZWai
         GL5WX+2t3RV4BCBQQt5+LWg2DKFDdUuYUl3NhvsSK2QVgbG/f+VcdeWrZrizjngOGoDq
         0arxWo6KLNjX1zXXoaBEAS3kn4L6BTJ4cBQbLTWrH5SalTLsFg4aABmvj21jLNzACqSy
         YWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763980522; x=1764585322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndD6GFhIDsyYEQSTuUmCfWcKYqCeLVrqI/SLqnCg8Xg=;
        b=Y8im1Vntdq3kMmARm6FUpF7gZ52mtErYbR12GES+IYWVWJ/Ck/JDLRGw7ph0+Jl+Gy
         ju5Dc9LT5R1zDJN+pgftJbttg09pG4CpR3ZsBwyE3AhyDqcG+HbFMi2DXMUkvfbrbizy
         YmSZ2EY06e014PSJgGUhJJ7X0bXstx8/VtcgZRxl9EtsasFeV2ibohoQaw27A5qjKdij
         pd8z1LqtY2aK13/i23L3iXf80hKd2fq/rgg9Rn18jzN53HpHpDe1xhq8MBkxLChWSWIU
         rhjefSX0q375tl2auKG9mFXRvTzk9i11Rfz4wdiRcu/Cs/wSPwo13ypj4CwY8isyO6bY
         IPPA==
X-Forwarded-Encrypted: i=1; AJvYcCVwIWREwKPiZ65VimXmy2Za4WwAex+7UFIRIm/yBS3OAEWSzk/FLUrxSCFgnP5JVR8UX7wQaeP/NQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWTsR+2MSbDh4Q6eBd9/wLIm8tcaHxTPiHaBweCJ5P7LZjxJig
	9tala3+tPedLxHK50gwg2nysP9EDrdywj62Rbr6k1yqh1b0vpI5W+1xu54S6/l2Q2Nk=
X-Gm-Gg: ASbGnct43twx7NYvWVH3WYXKMfS8RWjgSg3smo1uIxutC1YMuXKdS96+U8u7VmxtZsc
	nghTNFMGodBp7+7HakfOBOeuqtkQbKCCFm4aPYZ1pZQQrUxqxQAWmvA/x15NH1y7Noj6XWhyWBw
	A/GK+vHdSIzaOjiTzE4tzr6aF86sblNBY9mFQbXKpPJNVBvqLkOyt2L8tSm7RAi5ga9rnTWxB6M
	0NEAPwVkrj07nYeWKH0ED+jrNdCbLfMscyL9R0nUlgW5D1fUoMfimwlHCPmGTxnsMoaAjpNkbU7
	We01GJRez4rwZYdGDCn640VR8ScgQGLZ+9ko5mg0sak/bzhjk3nkTe29TgLTkS4nZrynVXi3eD2
	iwX55k2ndcu8Jg2qijXvtIyxui3ajUAAHTCgvQurhC+xplZTPfhggKn85CCJYH+fF5qgzc0cziB
	J7+m7JXlKitfyBbLh4Qo6bZ4rMPFGBKKmzWAp7/fsbwWGK4ybcTuS6OecNXpQ4BsRpZQ==
X-Google-Smtp-Source: AGHT+IElNEZ5h3JUQ/4nKEFrG2nnJ9W9xdmqEYug4voX9K+dF3FjdDILyhWbdWr6Fd3WQPE4haywCg==
X-Received: by 2002:a05:600c:3511:b0:476:d494:41d2 with SMTP id 5b1f17b1804b1-477c112f7b1mr105073885e9.29.1763980522164;
        Mon, 24 Nov 2025 02:35:22 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:a756:bb6c:7b35:af9b? ([2a05:6e02:1041:c10:a756:bb6c:7b35:af9b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-477bf1df3d5sm188767955e9.2.2025.11.24.02.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 02:35:21 -0800 (PST)
Message-ID: <ab35c20e-390c-4479-9bb1-9f5e49cba2a0@linaro.org>
Date: Mon, 24 Nov 2025 11:35:20 +0100
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
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <000001dc5d2a$0697bf10$13c73d30$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/24/25 11:06, 손신 wrote:

[ ... ]

> However, since ExynosAutov920 diverges significantly from the existing driver,
> Would introducing a separate driver instead of unifying everything be acceptable?

So this driver is one controller for multiple sensors while the others 
drivers are one controller for one sensor, right ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

