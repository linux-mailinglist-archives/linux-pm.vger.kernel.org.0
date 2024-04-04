Return-Path: <linux-pm+bounces-5933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E42A898AE6
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 17:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAB11F2D868
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 15:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF9B12C7FA;
	Thu,  4 Apr 2024 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JPx4GUnY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC424E1CF
	for <linux-pm@vger.kernel.org>; Thu,  4 Apr 2024 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243796; cv=none; b=d9HCOBkqj3g4QcifauFgeAf6Dshymcmfb2hkwSyQRY+SyJoJ885vKwCFqqmG+9lOTqGHnxDwEpd5kV5tRyoE2ZtYeXe1a8pEt2wBgfvoIH/jt4JE7hlAscxvBbnwlNs5ZhlTBwyl6fZQSd3eq4xSanSTcKigxpXoWmuseuMR4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243796; c=relaxed/simple;
	bh=9MkKX+3kBMH19o8dPP7/p0dh5ccoNvunQHFXL3tCCzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1belY1OLlYBMPM5YP1gWNFUIpRrLUh7eON0Sh/hYZcJWfh+Hl/JB4iKIfb77/SyFgPZtS3Usxev0JL1BlbeaSyO5PzP3V6aU2UbkXqYARWFGSDStGhXSLXrRveBb9udKC6clEt4p82x2nMN7X2s3fo8hPIl3Me4EsLTVu3cgb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JPx4GUnY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4162b74f2a1so4333625e9.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Apr 2024 08:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712243793; x=1712848593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JadJf1yHiM3agA//2OvneRIfLrToVBQS2kX3ZvyjY2U=;
        b=JPx4GUnYW8pShjn4vePM/q2qlgJCWGE5aB8vSzSeLuNe+2Q9PqgxzFk+JECTtDWWFn
         RuAYWj+cWoWkWWPasagxlVf3WuMnoRixv32DssBjMaz1Efy+vdfQUAfm1oKe9yNtaox2
         9cUfLDbg1pJ0uuB1kyoKHT6FMWwFBM8mnS6REZkW4SQa/1PkWnLdG/B/MzomEJMBoiPH
         VMDBSUbF063tDCedhF5B8regUVY0nPOCJNt/sgeQYgnIkLZu305wSRmoJThAkTo9qRnY
         ShcYrxxUX9vvGIkEgvyLqWN/FK5QA/dkZNuqpuNMbsKFqyQKKgN6c8rY9GzUCmI1ErAo
         ye5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712243793; x=1712848593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JadJf1yHiM3agA//2OvneRIfLrToVBQS2kX3ZvyjY2U=;
        b=O6KNdZ/UmMtsbc6vptXaEjr0kBYWvXKPFatP3y80+69u8xdBJ0/qyvrfrmNLz30N+Q
         a5bQQb3pyiY7OEltYgalrvn73xyz1HSswY80E3i3krUhye0/wKFp1fm7aJuIOm7JGRHZ
         lJZMHH831thV+IYxeDPbzZ2tM1bq1xt4Sl/2Az21QFVTHefhLYsNSVZ6ufRUFngeQniE
         54nzNbguyCvWgv6ww6rF/1nPHXxSGJVdlJb42Ve8akYpfPkOsAtSvG9HGvmBLnbc7M59
         5Xj8bgI1AjIAZT6i1NcCNIpLdxnLHV6MWb9rLoZGWnukGpnZ/rrkygbIL9w7Gu09EqQw
         uXdw==
X-Forwarded-Encrypted: i=1; AJvYcCU/Z2T0Ae650pDcmBzYQjm7Cpp8OAp6Cwy0BJrWqlTzwcWAsdgFnEcINBdKI2CiZcU4vdm2MESMuc8SinA8rawFBF6AP9oDObU=
X-Gm-Message-State: AOJu0YyDsjA3gZgbwpGA5xiFoLmRllVyvlat69nZKWW0BXQaPy5jVe8+
	FEAbh1fOjlu7nZbmVPSqncQFrTVKgyaxqlF+eos71lXZ3pHE6boa7wAsQ+pr9hE=
X-Google-Smtp-Source: AGHT+IHGzZnEGQ65V0RqdcQeBjbSGhJ1sZ8RB12ktW1XRjg9KxwbStdZLcCDqoNbiATje9p9j5Hj4w==
X-Received: by 2002:a05:600c:3016:b0:415:67ac:3245 with SMTP id j22-20020a05600c301600b0041567ac3245mr52794wmh.28.1712243793225;
        Thu, 04 Apr 2024 08:16:33 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id j10-20020a05600c488a00b004161ea7ed6dsm2914260wmp.38.2024.04.04.08.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 08:16:32 -0700 (PDT)
Message-ID: <aab10d22-b1a1-45e9-85bc-a4334aa6c497@linaro.org>
Date: Thu, 4 Apr 2024 17:16:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] arm64: dts: mediatek: mt8188: add default
 thermal zones
Content-Language: en-US
To: Nicolas Pitre <nico@fluxnic.net>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20240402032729.2736685-1-nico@fluxnic.net>
 <20240402032729.2736685-16-nico@fluxnic.net>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240402032729.2736685-16-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Nico,

a few comments about this description.

On 02/04/2024 05:25, Nicolas Pitre wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Inspired by the vendor kernel but adapted to the upstream thermal
> driver version.

[ ... ]

> +	thermal_zones: thermal-zones {
> +		cpu-little0-thermal {
> +			polling-delay = <1000>;

Except if I'm wrong, the driver supports the interrupt mode, so it not 
necessary to poll constantly when there is no mitigation. You can remove 
the line and everywhere else.

> +			polling-delay-passive = <250>;

As little CPU, 200ms or 150ms may be more adequate.

> +			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU0>;
> +
> +			trips {
> +				cpu_little0_alert: trip-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};

You may want to add a 'hot' trip point in between, so the userspace can 
be notified and take an action before reaching 'critical' (like 
unplugging a CPU)

> +				cpu_little0_crit: trip-crit {
> +					temperature = <100000>;
> +					hysteresis = <2000>;

critical is a point of no return. Hysteresis does not make sense.

These comments apply to all thermal zones.

[ .. ]

> +		cpu_big0-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <250>;

Same comments as the little but may be an even lower value. eg. 100ms.

> +			thermal-sensors = <&lvts_mcu MT8188_MCU_BIG_CPU0>;
> +
> +			trips {
> +				cpu_big0_alert: trip-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_big0_crit: trip-crit {
> +					temperature = <100000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_big0_alert>;
> +					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};

[ ... ]

> +		gpu1-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <250>;
> +			thermal-sensors = <&lvts_ap MT8188_AP_GPU1>;
> +
> +			trips {
> +				gpu1_alert: trip-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				gpu1_crit: trip-crit {
> +					temperature = <100000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		gpu2-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <250>;
> +			thermal-sensors = <&lvts_ap MT8188_AP_GPU2>;
> +
> +			trips {
> +				gpu2_alert: trip-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				gpu2_crit: trip-crit {
> +					temperature = <100000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};

You can add a devfreq cooling device for the GPU here.

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


