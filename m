Return-Path: <linux-pm+bounces-18212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E3A9DBBD5
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 18:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0CA281E26
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EDC1C1758;
	Thu, 28 Nov 2024 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAmaXley"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEDE1C173C
	for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2024 17:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732815497; cv=none; b=aOnkuI2HCMY9xDgT/BDzW7kBLy59LIObEIM24dazWtFUzB5S2mDBIBKrGKo8LK5Khn3gjAjF0qxNlN7XgPPsMsDYbI2wbtMPJXVHPaGjaZwclmadlN95s1Z6BskKTRIlPh+rLfbW2M0zxoXTdIwmrP/qJeVDPiwf7E+fA3mmbeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732815497; c=relaxed/simple;
	bh=7Wg7RpuZOM/HyrjX0bWWh7XXJ/yOw0T82VzA/PUnTxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qLwXSIExMfYVJ6KSfPOFMrIgIEYFQBCyemdZUjUjBg585EqBvnmrjKRnwBFFPMNHIRvdKFkK8rnewq84YBivz3k1QezRsdFl0Hilq/lNND7ZsT8hl0UqSkIhY6y1KLnIL6LZw2OpXzNYfM0sPRoyoDuwpHm+mNvu89oRLyRALTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DAmaXley; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a14d6bf4so9568945e9.1
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2024 09:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732815494; x=1733420294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=10gOONKYd0Gk3rZPYV0aoJyh1TGfB9PFutKnizLk6Y4=;
        b=DAmaXleyI2w5Pod442rCsFxEJe2rHFKbx6/Iyj4/XGok5Yq/jKCjntGw12ynFMS3n4
         T8iStoSQH18DMLcWWOEhECChaZ/ITXGhw0/bZY/aTxwtDmd7g2szUxTREken1V+wjiGA
         EkOPZKATsV1Nuy0Yy0rKPbM0sdiazZoj5SigVGJnur/Hpdhl/8VotdUBHsJzqWZDExWA
         c9atkGBBBY2384aFg+GK1VYST97pUmNAtj4O9YH6hrgMzA+Ej7LFgzglzENnNNEiHn8d
         6cqQOVPfxpsi/d95U0kg/S0NAGiJc8QjVK4jGpdk1XVPM9E900SsWU7B/kdB4E2ImvkE
         ey/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732815494; x=1733420294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10gOONKYd0Gk3rZPYV0aoJyh1TGfB9PFutKnizLk6Y4=;
        b=pEQ3OKCfraOkt+RXXuCaP53C+K0EkNSvnP8jfh57lXN/XHbRBkv04tkbl/2vHYLt/Y
         +gBOh0i6k11RqT48jsE5j5ao4waqZ1PRg77HM+AMI/9ix4hrM8xbf20JQPGBn6Dtj5+c
         qjqXhbmxcdKXn7BxmkCeIeaFgssT+olmXDOmKNg0LDv43s5zPGbGCn2Cm38veT3Def24
         7uGka4I2TQiwCzAiJgl9EYOQT1p22p98LBs56pMj5Dr6KKKiaD/KRikwH5KfmUm6HtZg
         qCVvnOnzlR8/0YE6a+yBRUxfgg7splzUalobIHGIqxXkrefPwzlQ9w/17p1lnHVX9+VY
         0zRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKgi+AQ/o6ej4u1EQhLk8+WjvcyNXw8GHXDIxEDN2Ngti6x7hCC/IZ4d8h4Xd2PxyRitr3wVAcTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKCJfqwPxqYBRVV9o2d+ZTGvPoDdt2V+Y7354daXtBhsy5rEL7
	A1FBcaotoAiK58FQa4gS56eVWRzsM30tZHdPD5rjgHX+vxVCxuyYIxt3wTwvSc0=
X-Gm-Gg: ASbGnctiBIlPBgilWWnBlkSbMbNDKUvdw0J7reXrqutf5YDpDWObSY6ChdE+/pSjncL
	bNhuG0ama6PH6niD3HC9WoNocWfWzXvq88EkVedGXXEi1HnCMsANJaxw4aZbhGFSoTWNc9oV3sl
	/JEMVjQHW2bRn2BiiNfSuFwbtWHUMN7+yrWprwwQCYjomuX49ywDF5iLFwDCjsxTiUHQCISsPCC
	JBprLXyyd8rPKG0kAUXvzM1WBZCoxGPKcaWEifBW5SPZgaYr0KQzdGZ4Gp8zQZKzAlDIja3RtZ+
	+/pY6DSnUdJqeQ==
X-Google-Smtp-Source: AGHT+IGyiJDbepmBMbDSY4970QLlGU0+MdW25rYKAMlGZRbsCkkVDjf5WuEnqq8LxT5+l+e+vpF+ww==
X-Received: by 2002:a05:600c:4447:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-434a9dbaed6mr78728755e9.4.1732815494001;
        Thu, 28 Nov 2024 09:38:14 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434b0dbf95fsm28022775e9.15.2024.11.28.09.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 09:38:13 -0800 (PST)
Message-ID: <c1c14ada-c0bf-4353-a8ba-7b3a2fb6d971@linaro.org>
Date: Thu, 28 Nov 2024 18:38:12 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] thermal: multi-sensor aggregation support
To: Nicolas Pitre <nico@fluxnic.net>, "Rafael J . Wysocki"
 <rafael@kernel.org>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexandre Bailon <abailon@baylibre.com>
References: <20241112052211.3087348-1-nico@fluxnic.net>
 <s120q967-4r69-pps2-1qo3-9952r9173125@syhkavp.arg>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <s120q967-4r69-pps2-1qo3-9952r9173125@syhkavp.arg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Nicolas,

On 27/11/2024 23:05, Nicolas Pitre wrote:
> Gentle ping, feedback appreciated.

I'm currently reviewing the series.

We have been discussing this feature since a long time and multiple 
times at different plumbers without any progress since then. So thank 
you for proposing an implementation of this feature.

I have some concerns regarding the approach I will raise tomorrow.

Thanks

   -- Daniel

> On Tue, 12 Nov 2024, Nicolas Pitre wrote:
> 
>> This series provides support for thermal aggregation of multiple sensors.
>> The "one sensor per zone" model is preserved for all its advantages.
>> Aggregation is performed via the creation of a special zone whose purpose
>> consists in aggregating its associated primary zones using a weighted
>> average.
>>
>> Motivation for this work stems from use cases where multiple sensors are
>> contained within the same performance domain. In such case it is preferable
>> to apply thermal mitigation while considering all such sensors as a whole.
>>
>> Previous incarnation by Alexandre Bailon can be found here:
>> https://patchwork.kernel.org/project/linux-pm/cover/20240613132410.161663-1-abailon@baylibre.com/
>>
>> diffstat:
>>   .../bindings/thermal/thermal-zones.yaml       |   5 +-
>>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 210 +-----
>>   drivers/thermal/Kconfig                       |  27 +
>>   drivers/thermal/thermal_core.c                | 643 ++++++++++++++++++
>>   drivers/thermal/thermal_core.h                |  14 +
>>   drivers/thermal/thermal_of.c                  |  86 ++-
>>   6 files changed, 780 insertions(+), 205 deletions(-)
>>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

