Return-Path: <linux-pm+bounces-1376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4CD818F1D
	for <lists+linux-pm@lfdr.de>; Tue, 19 Dec 2023 19:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11A3288545
	for <lists+linux-pm@lfdr.de>; Tue, 19 Dec 2023 18:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2470937898;
	Tue, 19 Dec 2023 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DsZs8aj7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826FF37D01
	for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2023 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d3102a2d9so1395465e9.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2023 09:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703008783; x=1703613583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tqHXsUzuWClKVHdDcXRwOKbkdcrm5H9v6SELG5butfI=;
        b=DsZs8aj7qpStwF1OKzQig+7dJeUfaUTQjkBZW2tq902AMyIgNmtzJLMfWx16unhK8c
         Dq/DrCm2n1/MiSFBqlvdlmZg5IsxL+36AH/VcaAB8s/oi/LhWbt7TGsOYd54z9pOMq2A
         RggFbTv8JdRCkPS2XxOxGkw0HYnmlQxDGHn/HFH8jXZ5KVJeFlIxKxHnxT5fdBpZFAFS
         5PALjg21dPwECNIyLFwCJ2IJzxuP4Yt7mfXzFppFAb+USkUCY/Kt/iSywazI6CD7HD5s
         Ij343RSw1SaqO8kP+EhWnCqHtdhZur8L37DcBw1MhkM5KhFTdluje7/tznzBMefs2asr
         lxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703008783; x=1703613583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqHXsUzuWClKVHdDcXRwOKbkdcrm5H9v6SELG5butfI=;
        b=LFDWH+XARIfX/i0a01vyNgYRq65b3nZBvipddjTNtsrPe6Cnz/c9+UqigDaxfcbohK
         oGAtBDsgAR2xVmoXpTOk8pFFGD4bOv5l3lO0PN+2ci+OsowDb2gFDhgO0b9FMPWlRbSU
         bhdydBUrEWohNsKLwGq+9qdO61z31c8rPl4hHomiSXYX/Lm/ZcmkpvsVnBU94cMOUGGn
         ke4jK55mbq7XIJkRNNzChN1rZuM4uZkKeS0Nr3CXI+Gv/LYq8qk4jTJIYtsVV2g54ZN2
         C0pv+gNVUZNt3sxDuJARiMfx+3SGYKixKsDAs8g3VSVrmz/1VbnPrnOGHyzPnzSvyFUI
         6yvA==
X-Gm-Message-State: AOJu0YzY16xTqUAgpgn6lYPiq7nnX50H4yG5gHeMlK4AMQezw2t9cSbd
	sX7vLGe76mE77bQp2LSs/IfH0w==
X-Google-Smtp-Source: AGHT+IHTbL5R+BKsfjLA4+IL6EQF0An0d3vy+3YBRu4MG01xcYYLuWQyJRn7wEhHU1ArwUxfMgj3Vg==
X-Received: by 2002:a05:600c:1c1a:b0:40b:5e1c:af27 with SMTP id j26-20020a05600c1c1a00b0040b5e1caf27mr10072010wms.45.1703008782679;
        Tue, 19 Dec 2023 09:59:42 -0800 (PST)
Received: from [192.168.10.46] ([37.170.14.102])
        by smtp.googlemail.com with ESMTPSA id m39-20020a05600c3b2700b0040d23cea7bcsm1320165wms.1.2023.12.19.09.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 09:59:42 -0800 (PST)
Message-ID: <ffe8605b-3e71-4726-993b-8a5873263989@linaro.org>
Date: Tue, 19 Dec 2023 18:59:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] thermal: amlogic: Two cleanups
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
 kernel@pengutronix.de
References: <20231116112633.668826-1-u.kleine-koenig@pengutronix.de>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231116112633.668826-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/11/2023 12:26, Uwe Kleine-König wrote:
> Hello,
> 
> while rebasing my patch stack to v6.7-rc1 I spotted these two patch
> opportunities for the amlogic thermal driver.
> 
> Best regards
> Uwe
> 
> Uwe Kleine-König (2):
>    thermal: amlogic: Make amlogic_thermal_disable() return void
>    thermal: amlogic: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
> 
>   drivers/thermal/amlogic_thermal.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> base-commit: f31817cbcf48d191faee7cebfb59197d2048cd64

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


