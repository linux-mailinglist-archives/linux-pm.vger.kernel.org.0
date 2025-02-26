Return-Path: <linux-pm+bounces-23032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA00A46DF7
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 22:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1A33ACAC1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 21:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE3925A65F;
	Wed, 26 Feb 2025 21:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3MWJMQv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3FE2253FD
	for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 21:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606893; cv=none; b=u0wTEzJOtlkkECRgSznAmYzhBnhYKg0b+cn0HuGtrimrQyaQ0YUrxojQxZJGLYLxZGfL5JHyAzHXw+/vV//5oQyVHiQVQTNyLOZre0XZyi+Loe6RdjFjwOvhLH+i0z5x2RClwAi5/rbgiNNxn5Z1Y5U+kxtLV+Q+kMIyDhW2PHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606893; c=relaxed/simple;
	bh=1DRX+n6ujHDSSW/muvL+Oc9k1dtXaNUM47XFNRpJJKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbILDSI5gU+vG07VWCiL5LW0Sg7v+WP6wHnglHta5sFTKkPwjS17ZeQMJ0yaAsCjKOTOe6xWwsdUy8djl2+syv4v6VG7sx12cqwrJ+1ic4pm8uSDsfpdOeB5D8Jm5Zoq3yu8qySWtHP1Z+99we95GuS5UrrOI1GHzNVJy8bNRYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E3MWJMQv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4399d14334aso2800415e9.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 13:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740606889; x=1741211689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eq8gRk4XBu+/hRpz+bqnE1JgXk2J9JWrinMC3/G5BEY=;
        b=E3MWJMQvPBAwKqH/XD8vlK3NpSfNIp143iV8xnVWpTFFMOJz8/IvuloC29y+aRclTw
         C5fFz7jku5eyGRlAg0PS2FNaRni/E6dmshNZcwKM317nq+3tCVuyeS1F8zopJbRWsxZK
         qzIKPSqOyUZEhv9BktmEC/lUZRsKSvfv/JMp2kFCZaEQTDvwCcyG/pkCW4jgfmk7hjeO
         w2TNI+B7DNhSLgI5LDGNUVc+QpSIJntMo83yT8PJ+BSm5NKGNW7yyFjp41Lb5SbzDzSh
         rBEdHLq5aDN40k2OABJfF3qoFZolnabCXbaCXeiINSS+1GqrXeupHasboMIRJS1IgtQz
         ApPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740606889; x=1741211689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eq8gRk4XBu+/hRpz+bqnE1JgXk2J9JWrinMC3/G5BEY=;
        b=dKEE6qHpBvQ6L8odDBUE9B+BAIUDF4//PBh2qzu2awBPnRDrB2tEvidE/F1+BzqJxd
         jCdraqyYV6lnppwuevxTFpdfrmzkFHbSmCwi3C4C6iNAdyyiQLck0e9XyETaWSFP3yo4
         8fLfCJnNaJLaaFw1fItDcZLXkFxVIf2HHVhkhgN3rhjdSg9XloRfsrI8xZynvXUokHz+
         3i+DVfSTmw2+sEPUvmKbjQ9rvgXdjgokrsIZX+a4mZ2Z8cSqHszMW6Hm5lIzgDReDNbn
         tgWxf2gk2UXlsecZOXFuGb7TjrVu4Uc5jfZXOrmT+aKMqLybOUbDmRUJcOhKl5TISEeg
         PusQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9KR5NWJ4l57WejViy4x/1yp8ejsUjB6FQ/551JmfLsas2TNCZtiuW0yh+FNsIuVIW4bWxm4Awyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyijme0SrAX5JYzzpSpWmDsnAnAWTxzqMtNwrcUgFuh3xalI4LE
	NKiraRVVvtl9Qy4maUCCYhGYAcSaJ4F6ngi4MTgAJ6YLoVL9pqQucv2Nx19v2Lc=
X-Gm-Gg: ASbGnctPK5Xh4G2QWecVeSMSqbAZtoj/t8Tcc+NP8oFkJRINmXA/du/HYib9tdKkVxL
	ZAeMwkXfp/TT6TZHVhjhEzYVbjcoR6IGXoz9CBYI6JIAlDxlIvgbjMO1GwRmGNv6b99KAfhq9kw
	UxPJSMCj62sNYDrmxqpn+u0BhWxc0KHpjQHlziD2COkOY2vrpq/DlSaqy68DNIllErCDxJ6HIUF
	Zt932jOp2SekQqUpLhoSlZKr3o/opi+czn8iB5hcZqAZ+Q0K9T0Q1x3eOtNO5FV90ZqnxSQ8wDi
	3ohDCqtg/wuxFvSwyS35/677rYMmF/xHrcJP6bHBAt5ZfN2onlCqa6YTJlKL7c65DA==
X-Google-Smtp-Source: AGHT+IHhsFL+pj6OMWN3D2F6NIOmEF1QIihEQmaH+QhUH5bAqp8gOxbsoe/yEiSSRrYlfkmP/mngBQ==
X-Received: by 2002:a5d:5886:0:b0:390:d62c:ecd8 with SMTP id ffacd0b85a97d-390d62cf1d8mr3926088f8f.29.1740606889502;
        Wed, 26 Feb 2025 13:54:49 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-390e47a6a5esm93410f8f.35.2025.02.26.13.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 13:54:49 -0800 (PST)
Message-ID: <5e75ed4a-4aeb-45ab-a41b-4498f364a57f@linaro.org>
Date: Wed, 26 Feb 2025 22:54:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dts: arm64: mediatek: mt8188: add more thermal trip
 points
To: Nicolas Pitre <nico@fluxnic.net>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Nicolas Pitre <npitre@baylibre.com>
References: <696pn9r7-63r9-r2pp-rq18-471269pss1nr@syhkavp.arg>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <696pn9r7-63r9-r2pp-rq18-471269pss1nr@syhkavp.arg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Matthias, Angelo,

I noticed Nicolas sent this patch but you were not in the recipients.


On 07/02/2025 21:31, Nicolas Pitre wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Provide the "switch on" thermal trip point to be used by the power
> allocator governor.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> index 338120930b..262eab8fd3 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -472,6 +472,12 @@ cpu-little0-thermal {
>   			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU0>;
>   
>   			trips {
> +				cpu_little0_switch_on: trip-switch-on {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
>   				cpu_little0_alert0: trip-alert0 {
>   					temperature = <85000>;
>   					hysteresis = <2000>;
> @@ -510,6 +516,12 @@ cpu-little1-thermal {
>   			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU1>;
>   
>   			trips {
> +				cpu_little1_switch_on: trip-switch-on {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
>   				cpu_little1_alert0: trip-alert0 {
>   					temperature = <85000>;
>   					hysteresis = <2000>;
> @@ -548,6 +560,12 @@ cpu-little2-thermal {
>   			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU2>;
>   
>   			trips {
> +				cpu_little2_switch_on: trip-switch-on {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
>   				cpu_little2_alert0: trip-alert0 {
>   					temperature = <85000>;
>   					hysteresis = <2000>;
> @@ -586,6 +604,12 @@ cpu-little3-thermal {
>   			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU3>;
>   
>   			trips {
> +				cpu_little3_switch_on: trip-switch-on {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
>   				cpu_little3_alert0: trip-alert0 {
>   					temperature = <85000>;
>   					hysteresis = <2000>;
> @@ -624,6 +648,12 @@ cpu-big0-thermal {
>   			thermal-sensors = <&lvts_mcu MT8188_MCU_BIG_CPU0>;
>   
>   			trips {
> +				cpu_big0_switch_on: trip-switch-on {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
>   				cpu_big0_alert0: trip-alert0 {
>   					temperature = <85000>;
>   					hysteresis = <2000>;
> @@ -658,6 +688,12 @@ cpu-big1-thermal {
>   			thermal-sensors = <&lvts_mcu MT8188_MCU_BIG_CPU1>;
>   
>   			trips {
> +				cpu_big1_switch_on: trip-switch-on {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
>   				cpu_big1_alert0: trip-alert0 {
>   					temperature = <85000>;
>   					hysteresis = <2000>;


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

