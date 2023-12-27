Return-Path: <linux-pm+bounces-1604-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC17381EE51
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 11:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C50283F25
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 10:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8988837143;
	Wed, 27 Dec 2023 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fqWLKCqA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF75544369
	for <linux-pm@vger.kernel.org>; Wed, 27 Dec 2023 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d5aa35b60so10043545e9.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Dec 2023 02:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703674059; x=1704278859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MlgTvlJqMJTSMAgZlyM/SdpxyUCvvDL0/QaBMMYPmM8=;
        b=fqWLKCqAIUrlBooOxbkIwWihKiNwEZuOTBOtAxrZwLTGFGQaLgTO2f5kV9h3jBsoe2
         N9fD338M90oz89b6tSSDRodsLwLvpeH0bPQ5pg09IWb/H4gP3E+87U7nV5bk6U5D+9/I
         CwJZviHPrUPo8eEA/Z5x9BtkDWDsbZIg0aMzEYUwJWNCoA6SoDXAgcRzo8ojuWVkRnFS
         BbHK46FWgSrNzaYxZ1oU1/4BKX2OCdt68fka+tEMIy5RvfBCuA9mcG0P2TTUBmnqgyRj
         agpypAEXZDrft8SQQD55dQr965RIHJf+PU78tKuZBhlIKKrpdLFuQYyyqdp0EZGXCkoG
         xZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703674059; x=1704278859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlgTvlJqMJTSMAgZlyM/SdpxyUCvvDL0/QaBMMYPmM8=;
        b=lmzi52Agcz8LkclcR1/U99b8JL13jbUK8QWxjFn9XS8nLFPZu5qrcLi6zHVpge6uwU
         V839HonA2VB/f1lrQhegYOHp1EJPVkY6SvQx0srXQZ1lCC9Ie5MGPCrrsPe+0Lqa2Fxb
         /9YP9sta84boJEkrsOl8cc0O1lMHIdaNl1oXn7IOIM6+211LCPFd6/ktb6os+4A1/PN8
         U/pMBlWlr241rlHxhOrBX/gORol4QzFhGnGZ3pPiVHAlRWDw1X2FuYIJCAL6WNNhULDF
         4CZ44sGxw9AoXEY5l2Nglu/ACEBfvdS5GT2tv4vNsG0dyv2Z7Z0ilAlJYgyVQFcOVGHB
         b0AQ==
X-Gm-Message-State: AOJu0Ywm5LqxEPqiwdwIzDxOHBTx/4H0jKNnpS752uL0Du+HQuwSaqJD
	MsjQAchLgfwYBL7T49fVdEZH+7FG16Lq1A==
X-Google-Smtp-Source: AGHT+IFbKXKT+wevKTLRZZAlgFNY60Qg5hIT2Sdi7sJMqq+4+SDgc6GuEnGfTZCpjtKirGEr35CyDA==
X-Received: by 2002:a05:600c:5405:b0:40d:2d25:b8ee with SMTP id he5-20020a05600c540500b0040d2d25b8eemr2312408wmb.171.1703674059167;
        Wed, 27 Dec 2023 02:47:39 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id j36-20020a05600c1c2400b0040d5bc2ea43sm3997602wms.31.2023.12.27.02.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 02:47:38 -0800 (PST)
Message-ID: <6a759144-2e0a-4d86-ae01-c67ebb347fd5@linaro.org>
Date: Wed, 27 Dec 2023 11:47:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] thermal/debugfs: Add thermal cooling device
 debugfs information
Content-Language: en-US
To: rjw@rjwysocki.net, lukasz.luba@arm.com
Cc: rui.zhang@intel.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20231227102643.2655651-1-daniel.lezcano@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231227102643.2655651-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/12/2023 11:26, Daniel Lezcano wrote:

[ ... ]

> +void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
>   {
> -	if (cdev->ops->set_cur_state(cdev, target))
> -		return;
> +	*delay_jiffies = msecs_to_jiffies(delay_ms);
> +	if (delay_ms > 1000)
> +		*delay_jiffies = round_jiffies(*delay_jiffies);
> +}

Please ignore this version. I forgot to remove this unrelated change 
from a previous test.

> +
> +static int thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev, int state)
> +{
> +	int ret;
>   
> -	thermal_notify_cdev_state_update(cdev->id, target);
> -	thermal_cooling_device_stats_update(cdev, target);
> +	/*
> +	 * No check is needed for the ops->set_cur_state as the
> +	 * registering function checked the ops are correctly set
> +	 */
> +	ret = cdev->ops->set_cur_state(cdev, state);
> +	if (!ret) {
> +		thermal_notify_cdev_state_update(cdev->id, state);
> +		thermal_cooling_device_stats_update(cdev, state);
> +		thermal_debug_cdev_state_update(cdev, state);
> +	}
> +
> +	return ret;

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


