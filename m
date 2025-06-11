Return-Path: <linux-pm+bounces-28452-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8328BAD4F3F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 11:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8841779B8
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7EF25E824;
	Wed, 11 Jun 2025 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPNoHuW4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0489256C7E
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749632468; cv=none; b=YwlBSElKJYBHvbe2w+9ARiiBVc7kZ+hCEPOo48faSvlCV5RsCSn9F+7rSnGd6mrGFzpmBE/gq9bO+K9NXkFLXWn8B9JbhP6eNf7dKsVNes6p3AmwGmVnq4n+eIavM+mL8yO755Dou0MjxNpb1O7uzHippnW8vE3EWgEav8sR+Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749632468; c=relaxed/simple;
	bh=v3DyRzczkE2UVZWBbNgYtQeA5CY37lCJpmkA1PO1XPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXFMhKbHZPIToId3Vpp2K5yzl5thyNJG/I8BzS8MXeUQvDQhgnwqRuj9ZaBGG3gs4cA/bCtIJKgkkfRVCc07uxviLFtPdXVZAVcaxYnHvmcV5HHlfs5L8xpgycjiWaljam4LZGcXl0K5SAWvX/13aUxhM1oLMK0Qkh72gcYnRX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MPNoHuW4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4508287895dso4128965e9.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 02:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749632465; x=1750237265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJm40I/c8bMbSQ2gLkckcPV2BT9XiCMqMdBOXz+J4DM=;
        b=MPNoHuW4k3h6zH/5aIrFagUtBQMZMtkjigXSGuBpGqsN73XwyMonHbniRGAw1GUP4Y
         KfGANXWqt/R7MWnP0TvB1tyqv+mXPZXhO8AZaTUh6EjFeUcmWikBfK/LRTa0e6pVG9CI
         yiSNdr9u6o46RvuMIlp4VxFVDdUoY0DTkGSrceJAgEQthFCFYm88wo5jI+Zf4DIk3krd
         giVfDUar+ZE2LQVKPEqJUTLEqIGE1FKwjCZQrjn0aOfwgBJ22StwRUnSWwtgycEwqTq3
         vSjYnoIZYODXPOfLfD0KcMwS9GoHMcaREKozexWIi4t0jtPgiAbZZW7Pq5jeoWez6Jwj
         9kHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749632465; x=1750237265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJm40I/c8bMbSQ2gLkckcPV2BT9XiCMqMdBOXz+J4DM=;
        b=tvJa1se/byWYCnHVJj07fSsmXWYqPhWW4l9Zu/K5DZzmnVX5NnPJmnl3ozHgYqhWTK
         Fi5lD+/QtdRlS19qHsU3gOlsT/bUBwXtXRmYJlDEkNZkYCd3e8fORN3JuhFcQwBUaIfu
         ApyS/YBWYYTPHS9onS7+CTO+aZR9xM5kMIUuDarirQXxC/EDRcAYCG1oiGcZdlchZ2V4
         lBw3ZmoUmH3H/Tp4k2X6CVqWYeAJcIn7GtvTzBzHfsx7U++kGNzMSf4B9UHqmUTSgzRJ
         CCWb8t4c0M8iucMngKK+KK6pc/OX+sgw9JDKLFehJD3UqBh5Phm9Vpa6UkNtq2B1An15
         qKJw==
X-Gm-Message-State: AOJu0YwvGaP3IkC3a8MI6RbB4CbKtfRH5tk56pQ7GjSVy+N2XMfN9ChT
	PB5tEwG3+rQmrILzBqLyzzDd+H7lbNHIohTE2YNzeIkhgR2RtmuivWyo4KY23w3G7P8=
X-Gm-Gg: ASbGncs8XRY45IYrFATfPRWOVBKIuCN8X9nnOYE8mHT6p13rbmoBmeTxAh6KF7hXqOP
	0EdNI4WN9B1tRxx48BUdxCjS4bXygU03mXItKGI+RF9PeeuL+TIR+CVVA6NBvGjMq37XK1ErKsp
	euqdBWFilBxluNA9A6EE0wmFbN9W1gggQkRFJQRx6VZ5YRAy+DM2a5ZbrHBFJ0MeTZmRPSzlAS1
	cWC0GFDaObNt0uQdvyjF/gsoxe7GKmYI0LTLHcMRJ+Qa953vby5ytkQw1mp7s62srbMjEkt8Qj+
	Uc4PFcQ/hp8b9UV4vuPTRG1l7p/RaLX3QCjEEX1gLl7++H0kv7sQZVHH9vkfd9JoSs36Ka+Jn3i
	CVQFhb2qN0PcuUl5Z+Y65Tz7nnUgvILi823+MxQ==
X-Google-Smtp-Source: AGHT+IExzgwdr8TfxBDCEu+Ey1NeulxA8+khs0xDE+znUJY2X/I7uK4IKHUPwG64Q7l/cfcNMl/rlw==
X-Received: by 2002:a05:600c:a108:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-45324204ce6mr15992715e9.12.1749632465041;
        Wed, 11 Jun 2025 02:01:05 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:1a1e:c277:1c68:9459? ([2a01:170:117e:fc:1a1e:c277:1c68:9459])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532517266dsm14793785e9.18.2025.06.11.02.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 02:01:04 -0700 (PDT)
Message-ID: <4929c09d-ea3e-4dab-a440-a7d806793d9f@linaro.org>
Date: Wed, 11 Jun 2025 11:01:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: power: supply: qcom,pmi8998: Add missing
 power-supply ref
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
 Jakob Hauser <jahau@rocketmail.com>, David Heidelberg <david@ixit.cz>,
 Dmitry Osipenko <digetx@gmail.com>, Tobias Schrammm <t.schramm@manjaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250604-dt-bindings-psy-monitored-battery-v1-0-7f755ff75218@linaro.org>
 <20250604-dt-bindings-psy-monitored-battery-v1-3-7f755ff75218@linaro.org>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250604-dt-bindings-psy-monitored-battery-v1-3-7f755ff75218@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/4/25 10:18, Krzysztof Kozlowski wrote:
> Reference the common power supply schema to bring the definition of
> monitored-battery property.  Drop also the obvious description because
> it is duplicating what is in power-supply.yaml.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>> ---
>   .../devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml     | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
> index 90c7dc7632c58dc5cbfb3abcde8e730882bfd936..70f5cd6eaeabe822babf567d92b1d7f9124f3680 100644
> --- a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
> @@ -38,9 +38,7 @@ properties:
>         - const: usbin_i
>         - const: usbin_v
>   
> -  monitored-battery:
> -    description: phandle to the simple-battery node
> -    $ref: /schemas/types.yaml#/definitions/phandle
> +  monitored-battery: true
>   
>   required:
>     - compatible
> @@ -51,6 +49,9 @@ required:
>     - io-channel-names
>     - monitored-battery
>   
> +allOf:
> +  - $ref: power-supply.yaml#
> +
>   additionalProperties: false
>   
>   examples:
> 

-- 
Casey (she/they)


