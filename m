Return-Path: <linux-pm+bounces-903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DA380D42B
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 18:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE391C21716
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 17:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B564E62E;
	Mon, 11 Dec 2023 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kxUlaD6M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF2693
	for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2023 09:39:29 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so44917845e9.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2023 09:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702316368; x=1702921168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yy7vRtXjcFGxV/6rqekBGURy24lF8v5udfGSmbUqfVE=;
        b=kxUlaD6MHALeF0TXjcg/MsmXW6BqiUE3f19p/0t5ZQvt8fMTYlJrIq8F6QXyAIFg4U
         ZH3EiUSKp7ZcVaEGL/GCHInNvE8MJubUOJ9g5jmYjULWfITvgg0TDhkhctvq4zTVkpQX
         uLC4GgwWIds3s+uOKw9CLDvIM1NHeaCXlNRQ7GIwJou24Pd8JqRYxJPjt+yhTBt9kXNS
         3u93ui9giAsyuLmXTUQmzqZK9mfUPzfyd65LJSW8A0orwIsY846p/zohLYjLkrscds9H
         /Ep+IfgLoPpQYr9ZssAqSA2AmoavqVXKKajydT1yjP6jrNa9Ltw/NOVZmj5/rwnFhQ0f
         ERXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702316368; x=1702921168;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yy7vRtXjcFGxV/6rqekBGURy24lF8v5udfGSmbUqfVE=;
        b=W+kymsvGncj72V37IR3RpjBe9WJv5tgEwQLlRK2GEqNV53qAxmgVwWj5pqNMygrl8f
         boDiU8lMjgjtoyT6IQJd7kkXr344cSeqobY9F7ekcN+8B61i0rNpfaJYQlKeMWbNdPtr
         0i9a72kOSndqC5OdhqxsJx8QTYK4N29Oif5v12cETot7ST2hlAKwBmdWfEEc4nD7yXOL
         V0vGFLom0tgAt0NQxei/6mRs8UQ7Je46EGysCdklr8lqhK8LqfGUvjahd/U07Ni+6oXF
         OX8ShQ4BD5lqLDifZeByykC/WCqmktftnvNoKERis8AG9+t2R/8v0mGo1TEMZqQSilw5
         q1Yw==
X-Gm-Message-State: AOJu0YyGHfLqZJoOh1iNegwU4w8nZf2L3iTJdEXtSJ+nfoE4p3Kefq48
	ZXheT4z9dIFFNNS1sy1JVgRfyQ==
X-Google-Smtp-Source: AGHT+IFKKn02YZnDQaXPtO1z5yFKVke+da9MLmnSbQKfW/EzVDLPVXpfXt9JqlrR/nH7qZ06w8nOzQ==
X-Received: by 2002:a05:600c:4f11:b0:40b:5e21:cc29 with SMTP id l17-20020a05600c4f1100b0040b5e21cc29mr2351948wmq.84.1702316367804;
        Mon, 11 Dec 2023 09:39:27 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id a19-20020a05600c349300b004064cd71aa8sm13606491wmq.34.2023.12.11.09.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 09:39:27 -0800 (PST)
Message-ID: <03944e4e-d57d-4442-b38d-e36e20cb5ae3@linaro.org>
Date: Mon, 11 Dec 2023 18:39:26 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] thermal: Drop redundant and confusing
 device_is_registered() checks
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <1880915.tdWV9SEqCh@kreacher> <8315317.T7Z3S40VBb@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <8315317.T7Z3S40VBb@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/12/2023 20:19, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Multiple places in the thermal subsystem (most importantly, sysfs
> attribute callback functions) check if the given thermal zone device is
> still registered in order to return early in case the device_del() in
> thermal_zone_device_unregister() has run already.
> 
> However, after thermal_zone_device_unregister() has been made wait for
> all of the zone-related activity to complete before returning, it is
> not necessary to do that any more, because all of the code holding a
> reference to the thermal zone device object will be waited for even if
> it does not do anything special to enforce this.
> 
> Accordingly, drop all of the device_is_registered() checks that are now
> redundant and get rid of the zone locking that is not necessary any more
> after dropping them.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

[ ... ]

> @@ -132,11 +120,6 @@ trip_point_temp_store(struct device *dev
>   
>   	mutex_lock(&tz->lock);
>   
> -	if (!device_is_registered(dev)) {
> -		ret = -ENODEV;
> -		goto unlock;
> -	}
> -
>   	trip = &tz->trips[trip_id];
>   
>   	if (temp != trip->temperature) {
> @@ -162,23 +145,12 @@ trip_point_temp_show(struct device *dev,
>   		     char *buf)
>   {
>   	struct thermal_zone_device *tz = to_thermal_zone(dev);
> -	int trip_id, temp;
> +	int trip_id;
>   
>   	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
>   		return -EINVAL;
>   
> -	mutex_lock(&tz->lock);
> -
> -	if (!device_is_registered(dev)) {
> -		mutex_unlock(&tz->lock);
> -		return -ENODEV;
> -	}
> -
> -	temp = tz->trips[trip_id].temperature;
> -
> -	mutex_unlock(&tz->lock);
> -
> -	return sprintf(buf, "%d\n", temp);
> +	return sprintf(buf, "%d\n", tz->trips[trip_id].temperature);

Without the lock, could the trip_temp_store() make the value change 
while we read it?

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


