Return-Path: <linux-pm+bounces-20300-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06BAA0B2B0
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 10:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048E9167300
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 09:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5EB23A580;
	Mon, 13 Jan 2025 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIT55bXS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637772397BF
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760362; cv=none; b=oO53SZKcpP7rgVs3LZM/Y5hfoQJlxz+H6Ck7Jw5Hil6GGIRfkXpcDss2oNCkRrmKp3su29F2Q3KBY8PaiLHdZJoY2BJwesJLHCQ5MvrNVQuN70IFlyCXSS/QVASfFxOB0Mp0b57ioAvnlgzGuhL1YM8KHdcqARsvwkxCBq0DOXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760362; c=relaxed/simple;
	bh=LzhQ97fHILTYwmA3VvX34lCCeJsGHBrrga3Q8maQrXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B2WulqzXFxGIodVLXo4T1duOW1eTlas2L7XnZ78fPH/5p4gc6QZVcLVSJrVyOWeSF9iJxlpQXtfEPS4vgn7rgLHfsWNbXUB3r/QdlAka5GXC69bnav4Rq3Kzj/ZIB6neeUA6RLUqEJ60ZNg5XHUFi5NsshWSGc3mn3tqd3dcahU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oIT55bXS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso28399295e9.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 01:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736760358; x=1737365158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1oTNvOqfukHrgIuovSK0uBo5g5AB7kI/WzXWHrElV1A=;
        b=oIT55bXSjBZ4i4nZ/u4nxOIIJAH6KZ+MUS9iHKW4dojKQ54ytHKXHSaBLizrI82f1W
         TU7bUu4U+Mz7jXg3sALsUrovvUKtuzF/AscPs1JjAKo+d3w9Vyb75pIPQsSx0wLqNW7O
         L3ybu+mWGJwGVbwDzgZGkg37QYrKqjBZD8m4WoTXpYiDHtpwb4KOOhGXezofsDF/G+rK
         jE5YHrY4bgkiG+IOGUqXzmoMzI4oUiV9KqmNxvZbAKvv3+Zlou+Nl4IPC9lTaAAejKA1
         yoazC1HrYhdytEnz4MjdblaEDbq/S5zwm0xHTytpzvoHaxIl7V6r6wG+FwI6UlxqMLFA
         +bBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760358; x=1737365158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1oTNvOqfukHrgIuovSK0uBo5g5AB7kI/WzXWHrElV1A=;
        b=DnHyw6cz5uOkbKtBq7lwTaM+fCMxSLEOGxJKkn2t/dr1vFAk7Iv6OvieWdpsmeuFyD
         KvvoosnbMAOZ/ikJrdvb/rC+nq1j4ityPr0knrl93txJD7oh9vxhv3KTWo2AgeMY/SSM
         kazPgOcEnfHnliVkWyilRedevs8jD4f/EYM87Rvf4Emi2UABAOELLaafkyJ99BiJ/fnu
         eJ9LK8AdTFjP1D+MOIle5VvfUU8ob09eBbbB6nBKVrMZoDvlJEtPMA5pSyYNoDKWYY6h
         gmSDV2FnXl3qd2LFI3aNJMUL/eY3hvPOtlsdoVujiAJ00NZCXauXFtlg025Il0oOoQWV
         Gv/g==
X-Forwarded-Encrypted: i=1; AJvYcCXwNLKIE8O1dZ0032C/Xje+ajJarl+8XbeZ73svihtExgCFVkl8Tbd7dZBWWRzk7I5vz30+23Wa0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1iZjBuxyGfkXcrHXMSB+2azlb+HMITJNzXQW9qhsGbLGF59X6
	U3WFs/k6DQyKhWFe6jt64uBEsj4NazAKQe3I31jHxrxKT6AyA0iaWuLWrHKeg/M=
X-Gm-Gg: ASbGncs5J9kC9rELBJB8XHiPx0m+gDL3Juq+hcLvOJNc8EVbqgKteMM3XKzsahZsZXx
	MqlO7lM7gW8eFhd183i5ICWKOcHCLzDXSwDX5asjG/wV1jg7dMa3ocnwJQtUecvxih/zJgJgEwZ
	SBNUzhmjBwMOgzNACwG4G682nIje6Tx6Ii/u1T9yz8I2sNTnp7xT+XNeZTja5kkibuhUIAtrQN8
	i1sxyPMTj4FLziosxyjpBFuUl63k1GiKZBKlvT96diXV4oYFqiKr5WR6VQSZww6qGez9V/8Qi8f
	gQcmTYix3n/etu7OA84+
X-Google-Smtp-Source: AGHT+IGrBvoo7a9T5ollC4Kafzr+5dvI/yM48bSNQ9PzhCKzvzS2+NRcCKfJfrFmUMRa61h//DtHbg==
X-Received: by 2002:a5d:47a6:0:b0:385:d7a7:ad60 with SMTP id ffacd0b85a97d-38a872f6a32mr16896203f8f.3.1736760357235;
        Mon, 13 Jan 2025 01:25:57 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436e9e03e5fsm136289565e9.18.2025.01.13.01.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 01:25:56 -0800 (PST)
Message-ID: <a679d4df-839b-4fd0-87b6-0e2ea2e357b1@linaro.org>
Date: Mon, 13 Jan 2025 10:25:55 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v4 2/2] thermal: Add support for Airoha EN7581
 thermal sensor
To: Christian Marangi <ansuelsmth@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@airoha.com
References: <20241218073016.2200-1-ansuelsmth@gmail.com>
 <20241218073016.2200-2-ansuelsmth@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241218073016.2200-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/12/2024 08:29, Christian Marangi wrote:
> Add support for Airoha EN7581 thermal sensor. This provide support for
> reading the CPU or SoC Package sensor and to setup trip points for hot
> and critical condition. An interrupt is fired to react on this and
> doesn't require passive poll to read the temperature.
> 
> The thermal regs provide a way to read the ADC value from an external
> register placed in the Chip SCU regs. Monitor will read this value and
> fire an interrupt if the trip condition configured is reached.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

Sorry fpr the delay, this month has been complicate for patch review.

I'm reviewing it now

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

