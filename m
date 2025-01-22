Return-Path: <linux-pm+bounces-20819-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEE9A197C4
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 18:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586903A5EE2
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 17:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E3B2153E4;
	Wed, 22 Jan 2025 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9tP3DwV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE6121519A
	for <linux-pm@vger.kernel.org>; Wed, 22 Jan 2025 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567690; cv=none; b=H2cDB1blv+Ij+NsdJaOrybT0ef6hZFspVjkJ8PaNaj+AoZVVPn1IPOBRRmy0KwySR8Hd9NtbkEwORPAbYU4MJqqcwhSKbmF3aZTd+NoZbBw6jI1jf2mkNiCQkyf+YOGsbcv7Pr46lNn8qT8qa4Oq9S4AHTiud1iNMmcKznae61w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567690; c=relaxed/simple;
	bh=N2CZWraLu3rKKT314RvxJgkSvmsJbpLZz+Zmygz4zkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEP02cwUAnaHC0qVCiG25HfblzAgwyeIdki6PsUAluo721kQL0MYXtmVL0alQ9UeG1UmjIupIFQ9iyAH5MrnUgBPdi544kvZo0XeF8+bGnte0OiReaBQMUnCsc3+WSDnTsEiNp9QiUBXa5pIlaX9jevFwOU1J2izuDqfqzEYANc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I9tP3DwV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436345cc17bso117395e9.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Jan 2025 09:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737567685; x=1738172485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P3xfQ6HsRwZfSocl+h/g5AkAwP96buHXsNBwC1dywZs=;
        b=I9tP3DwVC/Fa6g1fcKcch14Du+hiJS49gR2qQuczTA/aOoQZmFAhYYdOh8cqRAcpPN
         GZkDlCvfTfouvBHthtM3BQe73ce8EnUpaxlEmbNglwDl33+xxCiItJrlfU4c6YNNGe11
         9N+kc3poztCk8w1xrojWDU+F7azpUkQw/lnE0jTjE4fRL29Y6PWUYIORKcME8XQA8385
         4Cq4IPhbcxsbBiPj7KllbUYvjv4rXA2Q6zC69yZHpl4m6rdI6/ph+RrCB4357IghBdFN
         6zGZV56v5+0bAzieVNZQ7jKnjT25xV55ZZ1MO/FA9/3MH7bX67EjQEFnHN9o5xU2WpMn
         5ekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567685; x=1738172485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3xfQ6HsRwZfSocl+h/g5AkAwP96buHXsNBwC1dywZs=;
        b=AqJB1GTidFUwdPegvhP80MgJpfRQF1uhW32tuTVUkVEG3d8VcdxEo2MtxWH3h+70Rw
         rZZP9YiTDwob3AlrG/83i41VWplkW+OREW/2NG38RQ+3a3uAhRwfTJsGC/Q5IM4r0m53
         WXm75iZfHWMiRpRYgj+Vg3fFeF5w3K0j60otxP8vl1hS+9BMixA9CCdfQr16a5CP/8/R
         ShfRZQxlXZ75ayWxTXGVRj2IjFnjTrMEf3QyXOVzRhXPpclmwtIPNpm6SP7Nso2x71yi
         9qJqlrNL1JCv5Z4bqTdI3dSmV7/VhkoN6ZBri81JvmAKVDXVjI35vh/Vj1zUx/pkVYIj
         kNUg==
X-Forwarded-Encrypted: i=1; AJvYcCWwAng50pV8JKTLzTp4ocEHbcqBUGM9aANQOaPeMsmZFBZQaPaJ4Nf5x1xIUQruB0ZQq6P2rPJB7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yym0w+62Fid8qxt6JCCtFfydyronBPjWFxe/DHhrKrdqv2TIe9f
	7lxPLFd0U1ZDXGOsYMz/1yrh5oeJXkgIvfL9Tv2A6EYn1wDGple/tNWvqA+CTA4=
X-Gm-Gg: ASbGnctDQM9JLgle3sczk2EuwhRNYgek30FzCm0PlLek6mxrdVSazLjZCHGyhxaJTQq
	zmyggvY/3HbQAD33GmwEKx3mWBN3CGuwxSS+/1+zLwATW1IeYRHXgU5Mhq7aB1ghOo//AmysGoJ
	u7J8OT/XdGpgP3JiSl9NaylZtWJ7591S0AQ0sHMM/doFKG/BYNp5OTfDoUVj+zmNTqNB3jgtngD
	3jJxaF4qXBotz4ihOa88l27N7LGUxL6BV3u27/jJMzUL+DieLFQ8vhpqdQwhItx9EGa0+vNwCOO
	5/J45no7pU3K+3EuzLf2S+djWjflYeoQ+w==
X-Google-Smtp-Source: AGHT+IESAU8rkg/qlaPKVu84CybcOG1aDw4TcSQv1t/w3ZJI/axU8cqUp0BHHY9Y43ilPZTapRvMJw==
X-Received: by 2002:a05:600c:4c24:b0:434:f3a1:b214 with SMTP id 5b1f17b1804b1-4389da1e6c7mr189187235e9.28.1737567683952;
        Wed, 22 Jan 2025 09:41:23 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-438b31aefcbsm32095365e9.17.2025.01.22.09.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 09:41:23 -0800 (PST)
Message-ID: <8693bf83-9878-404e-b609-dcaf758d485c@linaro.org>
Date: Wed, 22 Jan 2025 18:41:22 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] thermal/drivers/qoriq: Use dev_err_probe()
 simplify the code
To: Frank Li <Frank.li@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20241209164859.3758906-1-Frank.Li@nxp.com>
 <Z5EULLr7hsk1RIZy@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Z5EULLr7hsk1RIZy@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Frank,

On 22/01/2025 16:52, Frank Li wrote:
> On Mon, Dec 09, 2024 at 11:48:58AM -0500, Frank Li wrote:
>> Use dev_err_probe() and devm_clk_get_optional_enabled() to simplify the
>> code.
>>
>> Signed-off-by: Frank Li <Frank.Li@nxp.com>

I applied the patches, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

