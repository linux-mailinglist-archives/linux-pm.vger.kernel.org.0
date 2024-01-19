Return-Path: <linux-pm+bounces-2388-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D16832D23
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 17:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 031CDB21264
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 16:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6937954BDC;
	Fri, 19 Jan 2024 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NAJTTu4w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00953C465
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705681768; cv=none; b=da5vrf7CXC6xVW9EI8CSK3DVJxc8MfRU9DSxRqrynzFCxVFUY7LsmiIpYvyF4Zx0kwPquRbn7YfUKxdKonsgwJscOQreKvdlAEuGDPSxcItIzknFePGxIzltOnMQ1VF1l42kTQjWs7R/nPXzUEhLQUWltutQmMthP0zko2Jn+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705681768; c=relaxed/simple;
	bh=kf0ra9hDOxRlKUU+DBVnsfrSK6drgtR1mR7xCwBEP2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJkwEkye9Jh7+J5ZLjEEYxdJv3Z6ltOO7tvS5K1hGStCmx1FaMkm8bmtIImER/08r54u+R15mAxmXoB7x1+vstoNmUr1ueWli0mBea0/UTCpZ9wUYGZv/K7IBpEe2KEnfoBnD2jwCtB1SVyZbgUoWaQfiXEmH+Kutgfyc74/c0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NAJTTu4w; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e880121efso10005095e9.3
        for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 08:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705681765; x=1706286565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/CaE8BW/0x+FuwZHFXzmTcmJlmVjBphT+MvAIY/JXo=;
        b=NAJTTu4wvt3hJ/fHDKvlcrkwAuz8hIIsjc1lzAURbpAqwWzEvZ9btvRYjZAsEekn0/
         PORTXFNjFSrwKp6MBU1PKidxs9CTC62GWlVNqX/cFCX9eX/EtxyZ7BAP2zPx5sQZ5Znn
         9KDzEwXjmlnuq8L7eQXRAur/87aPucOyzFiKX9tAPrLSCF3h7nbjIj0yEuOCjckzmJj2
         syyVNVusVRtcOy1FNLPYshpLnsA3RRvjDorSWhrwb17L/+qQX1ytf9KCNYepDJunN0gz
         iFAbDOZI/3TPrx67qpRxzu6SngJCU28sViUCVkV1CTE8G/itbk7jQy/fVobGXZnxgc58
         Hnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705681765; x=1706286565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/CaE8BW/0x+FuwZHFXzmTcmJlmVjBphT+MvAIY/JXo=;
        b=iTYzA0VRldYICbVtnkYOAggt4kIlvmepAIsffSaF9zSaVjb5Pa0LJFRABbxMTRlFhP
         vODjzNeIf0ogzn9HpRY6ywZO3imds3SIJY9e1weanLu1kICj3rYEF3hmI3TaPMZ7uqo2
         BrlTbb+3kBdcj/A0aXBzT9tKkh+k6b4PmED4PzLBHu4Hu2DlctHQ14w6bFZTa+og8H7R
         PJtOqvbOuf5EbRwnr3aIASThrtTtMUrjvswZLVuCy4FWMo/8ZILhL3mIJYS2UYnyZDHN
         xaP5CBWX/nLE8UbGYkNe/LJMFgzuhPMRYRIP+AXpFcyGQ45h/lpdwiaHXD6nG1MZGjAH
         0oog==
X-Gm-Message-State: AOJu0YyVtVtKFCpDxqgiptCc3zmRTeC8u5JxyFR3f2yY3rr5NF1tyFTR
	pV2q4EBkacITrVueckVh5GKg5rGbwGDQ+LhfRHiQ8RxNXgNd4ivhSyCKjhhNy84=
X-Google-Smtp-Source: AGHT+IH/0qVE7xvzWcEcZZvIHagZE0SjBm8aoCpb3s/wgYdz0JS/WBkFaCu6n8/2/COueHG8+C1JRQ==
X-Received: by 2002:a05:600c:12d3:b0:40e:6639:6708 with SMTP id v19-20020a05600c12d300b0040e66396708mr14512wmd.49.1705681764781;
        Fri, 19 Jan 2024 08:29:24 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:80ec:9cf:f853:831a? ([2a05:6e02:1041:c10:80ec:9cf:f853:831a])
        by smtp.googlemail.com with ESMTPSA id f18-20020a05600c155200b0040d87100733sm29805088wmg.39.2024.01.19.08.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 08:29:24 -0800 (PST)
Message-ID: <9d8100dd-11a8-482f-83a1-85bfc34f1746@linaro.org>
Date: Fri, 19 Jan 2024 17:29:23 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] thermal/drivers/mediatek/lvts_thermal: allow early
 empty sensor slots
Content-Language: en-US
To: Nicolas Pitre <nico@fluxnic.net>, linux-pm@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
References: <20240111223020.3593558-1-nico@fluxnic.net>
 <20240111223020.3593558-9-nico@fluxnic.net>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240111223020.3593558-9-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Nico,

On 11/01/2024 23:30, Nicolas Pitre wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Some systems don't always populate sensor controller slots starting
> at slot 0.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index b20b70fd36..473ef91ea3 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -112,6 +112,7 @@ struct lvts_ctrl_data {
>   	struct lvts_sensor_data lvts_sensor[LVTS_SENSOR_MAX];
>   	int hw_tshut_temp;
>   	int num_lvts_sensor;
> +	int skipped_sensors;
>   	int offset;
>   	int mode;
>   };
> @@ -555,6 +556,7 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
>   					const struct lvts_ctrl_data *lvts_ctrl_data)
>   {
>   	struct lvts_sensor *lvts_sensor = lvts_ctrl->sensors;
> +
>   	void __iomem *msr_regs[] = {
>   		LVTS_MSR0(lvts_ctrl->base),
>   		LVTS_MSR1(lvts_ctrl->base),
> @@ -569,7 +571,7 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
>   		LVTS_IMMD3(lvts_ctrl->base)
>   	};
>   
> -	int i;
> +	int i, skip;
>   
>   	for (i = 0; i < lvts_ctrl_data->num_lvts_sensor; i++) {
>   
> @@ -604,8 +606,9 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
>   		/*
>   		 * Each sensor has its own register address to read from.
>   		 */
> +		skip = lvts_ctrl_data->skipped_sensors;
>   		lvts_sensor[i].msr = lvts_ctrl_data->mode == LVTS_MSR_IMMEDIATE_MODE ?
> -			imm_regs[i] : msr_regs[i];
> +			imm_regs[i + skip] : msr_regs[i + skip];

Overall the series look ok but this changes is hard to understand.

Could you propose a different approach to have the resulting code easier 
to understand ?


>   		lvts_sensor[i].low_thresh = INT_MIN;
>   		lvts_sensor[i].high_thresh = INT_MIN;

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


