Return-Path: <linux-pm+bounces-17515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F5C9C7AE5
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 19:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5785281463
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 18:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B120520124C;
	Wed, 13 Nov 2024 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vpzsf5df"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE2433997
	for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 18:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521889; cv=none; b=IAHtxM3UCwBF+VzLttspppWricXHfVLXkQcP2A74QSurnpG3p3/syteb1iYwHVBRnVRyAxZ8N0FrJFFqxKkRLAI1ia02YTgXU7P3VMG8cxEwiyyhCzBdp1eAdvvm8ftKEHR7hclTvluh+o7qvO056Wvcznabsgh3/kg8wXuSrdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521889; c=relaxed/simple;
	bh=hEmpp2nGMQFSZrQajXmI8OL1Mf8n48M60jnyic/SXPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HuveX62q9wDznKIte9tGJ9vruFh7tZUZv2BeUVOylvyHRmfH3ca6opNYnfUKMaa74Gp5/RYGRjuLAOaaLMNNY4A9IY1iSeKxmqTqj8/GKXCKONMIUvsZ/l3gb6w3bSAQOF3GoVZhXE4/LDFMyqogKZzL2cCxUD8TJcalG7lIR30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vpzsf5df; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53da07b78dfso1182510e87.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 10:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731521886; x=1732126686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tAIY4e+nFwJ6QvkC9kPfrl0tjap1nueeybQc4XVeRTA=;
        b=vpzsf5dfmrL3h/pzpARqk3HuMrreVhk+miVAGGaO2d9/2knmuRyjaBBaZw853Go/PN
         iWZ9YznqoWRojOyom8EmrOa6nwsPFI+O8PIHjaZQ4EjSjITwYzymDnN4zuZlY5EydK8B
         NswjqU9fxXdo9zFzMRGfg2RvDvKLY35ZgoBuYWuqXCvYJllO8Y5LwPdx0Uehh3ULpVvq
         HfLhfLVXy5zdqjknt7tb6mhk3tjRlHg+FkqDqkSyHgxqRi8nYDsH+a5gclI1UxA3jD2/
         5K5hqWXLnMNEgat9igk4Jkui36wlHFBURCjfuSO0gXjxx3FCjUtX5IleuqerDWOPlFzz
         USLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731521886; x=1732126686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAIY4e+nFwJ6QvkC9kPfrl0tjap1nueeybQc4XVeRTA=;
        b=mtLCUvB8Hn2udVut47GKODHU226TcJiYR+UXfDwbla21e2o4FoV710ZWNxO4452MWO
         4Ofkg8F3Ub9p8vPhKDQjFKI/7+AqXZUEgeCz8fspNSt4Ny4tllRnIZw0P3x9hGs3O5og
         25R82BCpSt4nqwmr+riLbezUkDIrJymAHpvaKar+yP6X19w29biFySn/gQxtDYHj3fc2
         Ib2NyD/bSDFI4CwPcPOYN6B7X1yOA92nlZp8JUmHHmwVkqxjTYuCqnRCG+HSDVe4m8Ra
         FGFrJH6KlDzam5G1bYqGbd4FNWr9RBIznuaWJJ80K/931/9Gv8SzC9NnjzlVA6z93zNu
         eQBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn8AYGplwuQCOS9TPdgmNl31ScjCDawaHXsAnkjt/4ip4FqxolnzoLC3/X8yOXeQwLC9TDsS9l8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHAX9/+KzrZ8P4VThUbk0g4GZ+v7zxO4loYdxIb6sRNEOr7CjM
	ZWN4bBkgjO5NujXkVLj3boGLl+PDc/BiLF2qz6YyQK8NaNMgCN4FyXhpZGyAeog=
X-Google-Smtp-Source: AGHT+IFglkeI6r32PMMOYdeEIyDlK6/q1n2Mf24sf/LbW1WwZdIjzqbhaymCyPGrKUmZOzNVWVy/4Q==
X-Received: by 2002:ac2:5049:0:b0:53d:a07e:9c22 with SMTP id 2adb3069b0e04-53da07e9cd0mr1592717e87.33.1731521885941;
        Wed, 13 Nov 2024 10:18:05 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432d54f76b9sm32140295e9.14.2024.11.13.10.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 10:18:05 -0800 (PST)
Message-ID: <487d0de5-6f70-4b82-a22b-5e74ba32da11@linaro.org>
Date: Wed, 13 Nov 2024 19:18:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: thermal: Add support for Airoha
 EN7581 thermal sensor
To: Christian Marangi <ansuelsmth@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
 upstream@airoha.com
References: <20241018104839.13296-1-ansuelsmth@gmail.com>
 <6734cc42.df0a0220.4521f.ac78@mx.google.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6734cc42.df0a0220.4521f.ac78@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Ansuel,

On 13/11/2024 16:56, Christian Marangi wrote:
> On Fri, Oct 18, 2024 at 12:48:04PM +0200, Christian Marangi wrote:
>> Add support for Airoha EN7581 thermal sensor and monitor. This is a
>> simple sensor for the CPU or SoC Package that provide thermal sensor and
>> trip point for hot low and critical condition to fire interrupt and
>> react on the abnormal state.
>>
>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> 
> Any news with this series? Everything wrong with the thermal core small
> patch?

I understand why you are trying to achieve this but usually it is the 
kernel which overloads the firmware description, not the opposite, no?

Either way, we ignore the offset/slope from tzp and use a couple of 
private variables offset/slope in the driver (iow do not call 
thermal_zone_get_offset() thermal_zone_get_slope()). Or add the 
thermal_zone_set_offset() and thermal_zone_set_slope() helpers.

I would prefer the first solution as for today I can not see any DT for 
ARM64 with the coefficients set. So may be we can consider the slope and 
the offset as a legacy which should be removed from sysfs and the 
thermal zone device parameters in a near future.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

