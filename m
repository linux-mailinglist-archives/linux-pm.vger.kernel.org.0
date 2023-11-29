Return-Path: <linux-pm+bounces-476-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850257FD7A3
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 14:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412E3282EEE
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 13:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8D41E53C;
	Wed, 29 Nov 2023 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aO/WLcXr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DEEC4
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 05:13:50 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c9bf8964c3so6871111fa.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 05:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701263629; x=1701868429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kk4M7AwI3W99Qm8CxBKV2U7EfbSP+F7GBdZrhfnsGq4=;
        b=aO/WLcXrnbldWdwu0jCtoRhXb9E93B1XVB9UpsPwXnjaHJXV7HlyPzL0eqUBIK4n/Z
         ovA9QA7q+4hEzyQSN4Yr1Lh8FA9RBRg5IiWQKJfMMyvsJeyaUK0Zt7gBiTqM5bafPvl+
         z1zy705gnuA/+66q4WnveU01n2QyU7Ak10YhS7njugmeJ1ZSRCmGf+T1RphEoZbu8g4C
         g1VX3q+0m/5vy1l5kVj6kaTCoq5rXPlxYDB1eGwggdgVZeaLOEeXcLScCmBM22NSgt14
         wbxo87PV0lojGGyUX8jDbQwB6F6hbh9ukeaS6F+mwPGRLxsQ/g/eKeAJD16gGbtYlmWi
         3bQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701263629; x=1701868429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kk4M7AwI3W99Qm8CxBKV2U7EfbSP+F7GBdZrhfnsGq4=;
        b=RMwvZxX/KQ3/B/u/RmqoWxpNtAVgUE208IxdsCKAyrfz2dBsZsjByVfFfQUZV9oB4L
         MYxnt43QLbXXrrClEDNWyyGU0xEQa581n3YjvwcovntIPWpkHSRJl+5PCXKdupFKRhVE
         Ry75SheHLfHo5K2O+UIPHjZOjsu5fvc6vsDv46fwnWRyYDGms7qajk6VuTnndqsCvtum
         SrbECFlnrgYNUe4isagebeBg0DgivWL6NyUkKn3RTxA3cS+6SsglWtcviZ/od5LX18KT
         Dn5u3VJK+OIg09GARppQGh56c6XZR5EYNLuU/8CD+gYprnEHsvC1trrNHmFEkqGMbDaJ
         hPLw==
X-Gm-Message-State: AOJu0YzaXIOhsupms6uEx3Lde0BOK3YD9AVGexr1UBS5O9G1DO8wrgGL
	/KksMnaPbzSiOjsLthRRZZO03xHwk2Pj9B2Zhqg=
X-Google-Smtp-Source: AGHT+IHtI9o3FfcYbP4L5uPTDwvKzzF5bIc9uFZvfsqa6bA9rhnuV6hmC3AdJw9e7Kf/T4vKT5U9UQ==
X-Received: by 2002:a05:651c:625:b0:2c9:a6e5:85a3 with SMTP id k37-20020a05651c062500b002c9a6e585a3mr5579448lje.39.1701263629078;
        Wed, 29 Nov 2023 05:13:49 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:38f1:13b7:9b7a:2d6b? ([2a05:6e02:1041:c10:38f1:13b7:9b7a:2d6b])
        by smtp.googlemail.com with ESMTPSA id h19-20020a05600c261300b0040523bef620sm803676wma.0.2023.11.29.05.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 05:13:48 -0800 (PST)
Message-ID: <e0b9c0c1-eae5-4664-bddb-56515e9fee56@linaro.org>
Date: Wed, 29 Nov 2023 14:13:48 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/4] dt-bindings: thermal-zones: Document
 critical-action
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
 conor+dt@kernel.org, mazziesaccount@gmail.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20231129124330.519423-1-festevam@gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231129124330.519423-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/11/2023 13:43, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Document the critical-action property to describe the thermal action
> the OS should perform after the critical temperature is reached.
> 
> The possible values are "shutdown" and "reboot".
> 
> The motivation for introducing the critical-action property is that
> different systems may need different thermal actions when the critical
> temperature is reached.
> 
> For example, in a desktop PC, it is desired that a shutdown happens
> after the critical temperature is reached.
> 
> However, in some embedded cases, such behavior does not suit well,
> as the board may be unattended in the field and rebooting may be a
> better approach.
> 
> The bootloader may also benefit from this new property as it can check
> the SoC temperature and in case the temperature is above the critical
> point, it can trigger a shutdown or reboot accordingly.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Rafael, ok for you if I pick this series ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


