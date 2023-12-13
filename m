Return-Path: <linux-pm+bounces-1053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F3B810EF9
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 11:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89AAF1C208ED
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 10:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A4222EE4;
	Wed, 13 Dec 2023 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iZf7i6i+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E7E98
	for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 02:52:32 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c25973988so69301465e9.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 02:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702464751; x=1703069551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qxIYzcVRWND5b4+SGdqxP3/bI43pIIDmR5zOk1xwKqI=;
        b=iZf7i6i+Ku5gz5OS4BKIkSqPCQb4vRO5e+vPMbWoXvnOue5sgwxjJ2jE+uv71WNjpr
         KlRiJ2HwZN3lBARAvUw99ZMP5xqbQ4foS4lw9FfUFwSzgs/qVBKnf8ZG7soegL9keJHL
         EXtAc6NNaAi/hyCoQTlvL4nNmS1l6NbNZr4Zwso/n9wgpYMYvWwz4tSwETNJZ6YUgpEd
         zpxAXQfII37OtahJ037QPczrMpBYd8nKvXC2Z6l1teA9pHeYxRtTk/yWo9UL5lKFL4Lx
         jtIucNmU6bdZXEVTR+fvJ/FwSgchyxUPsVfeeb7dV9cgJJaVvSOh6PGJPOHQXzn+h1CC
         zN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702464751; x=1703069551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxIYzcVRWND5b4+SGdqxP3/bI43pIIDmR5zOk1xwKqI=;
        b=l1umN6Rd1Dt6WweqH178f747uoSOvegmqUldR7qud+wEa2iMlREFQqpV5tJTdvyYDe
         RJ1f9yp5LOPA4zid1uR4UZB9BMaJYDoe4waqYL729krNGEfky+bcjt26xv0CANNedXvl
         u3qV3QSAAT+e0ixtdOTE+kkoOj6OKHohH65ii5iE4jvAMn1zKnlsBk4lJRQ/YjySg9Tj
         qeEpHxKh3Ab2Mistb22LNAu1CByXa/XCY7q472wkg/AsIJHEbItW4VjmPSXdMjAFt6PC
         3dnTlAmgsd9ec5QnqjQ8yyDW7aQcr+2lzXLAhH2C+ps9D1BEMqobNZT5Zip/7+ap46Sz
         d/Lg==
X-Gm-Message-State: AOJu0YyXNCctYvVUIOUPGQw1VP57n0fFLUqLPgruNsvMZhel2Sx/NL7d
	MfsX+ZzdBbxyUTs4g5dJorC8Ig==
X-Google-Smtp-Source: AGHT+IG7JfDcAFhdjtXhcIPZe9enkVB1Tw2aLM9KQNbGHj23a2G7fv6l1molZi/rwAwKLXbv+FeE7w==
X-Received: by 2002:a05:600c:8515:b0:40b:5e21:e285 with SMTP id gw21-20020a05600c851500b0040b5e21e285mr4067503wmb.114.1702464751264;
        Wed, 13 Dec 2023 02:52:31 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id f9-20020a7bcd09000000b0040c26a459b4sm652436wmj.0.2023.12.13.02.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 02:52:30 -0800 (PST)
Message-ID: <23ee1fee-dd1a-4797-8459-8c589c6dd9f6@linaro.org>
Date: Wed, 13 Dec 2023 11:52:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: trip: Drop redundant
 __thermal_zone_get_trip() header
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <2709306.mvXUDI8C0e@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2709306.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/12/2023 20:36, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The __thermal_zone_get_trip() header in drivers/thermal/thermal_core.h
> is redundant, because there is one already in thermal.h, so drop it.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


