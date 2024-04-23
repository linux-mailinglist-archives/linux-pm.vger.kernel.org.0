Return-Path: <linux-pm+bounces-6938-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D528AF2D6
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 17:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A1B7B21EBD
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 15:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C68613C9C0;
	Tue, 23 Apr 2024 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4szvGkP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8719913C909
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713887645; cv=none; b=ggQd8FZEtc8Nv+PX13vQmcAMMsW8JFWyqEPZsoudH+umYJdQ603+EhvVvFjkosFBqgDu1rldpP2W/06etB3c6eh2SgI8svk+5fcNlGj7QVTekVUUwjjiNHi1WSbrJ3jFmgLOBkIF1jPiaYZ8rTDFk8H/PyoGuuhdN6MjJSXl/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713887645; c=relaxed/simple;
	bh=C5UlS40Lj64kNIZeroZB47fFAcckHAyVp9/5HKyct18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DT+Hv+/uDmHhpWBvDDQQ3yj04DL/JmnvyoxUCzky2H3ZO8IhaknRN7r5HxePr3M8upsrPUx9172Fv1WPZSQOoU0QhaoxtjP7aXeurtgWdtTAcbEHPo17HXZSRSkAguV1msv+vfC0nrKFt2LuxWul1tItb1Y9RIUyFzupeOVmyHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O4szvGkP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4187c47405aso39573105e9.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 08:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713887642; x=1714492442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NpNVeMNI0zhMHr5M+F/mpBgTbhMgDo8XS8DJotHxgz8=;
        b=O4szvGkPXJ7ozB99qQudcAZABQqJ+amaR6D2C2KuCsoALvmCli5e1/tpIeqRwSy9ri
         GaDNCWT+DxPMBIf+zQNl8vv80dTqhBJWsOv2eUjyc0gSAVg5HjpB80LmWUM8vJuACPNU
         DCwcI5xjygxSBY71bwGD+LVRcIhWO45DcxL4itMMS/BfCa6jjI9oAKZJ2KWynOzXTgPd
         nS6PckYr3wVqEnI8228/rEttFmi2KUVx+uGnoa6KkafG4k/D9Jui+hPV+etyuoLZW8JT
         RmkJXjVSd7+hH5puYW1KBhSqfL4JEK2KhmOP/VMqR9d6/vH2a9ciuhzaW8FVqzHcfzaU
         aDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713887642; x=1714492442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NpNVeMNI0zhMHr5M+F/mpBgTbhMgDo8XS8DJotHxgz8=;
        b=AbH3974cgaaGqohHj/qi4rdP19FlUOp0dUiiNPYicGkLFaCjO6RFcFrHLhX/+WKT2X
         h0Rh2lvwAM2TgRjZWxa80jul8B8v5YnJDRaG5dHoblbbPft4cV8utSBIBdQWPDi4FE0s
         ZW7kl8At1p22qlnZ3lBFJ90NbgW/BEz79vivJbhdYOQiH66tq3NK9UMDczHNjW9vcS/Q
         FLVTOEgfvxck7Nn7j9B3hskX/gmOMSl9XCyVvk4IDMKzUViT8Ad2qxw1URGjINE0gPZN
         c4oba+GTp0mKOhNivAqFipFjpfybmiL0QooviMQlicviPrQZB36xP0bXq/GFj8hR/vtZ
         1Afw==
X-Forwarded-Encrypted: i=1; AJvYcCU9p77r/9IniiBS452W0qiqr6AKLKfUr9jg8KCKqXPD8S0aFb5JfW9SomJSUW6WDdxomGOuHaGs6yIkYIVJ1XUbisUEP3c/Lsc=
X-Gm-Message-State: AOJu0Yx1DqQsRWyPuZ5leF/Te+GcBtv1uXZm/pw0U14XVH7hwpHf4ewS
	DsA+3y0NHiR0mlO7MT9vfbVoK2nY/y8e8BKypT02/eVYYFnQiOKvW9EfKI+ftX4=
X-Google-Smtp-Source: AGHT+IHdE+Wm4m/cocldAys8NHvvOZCFU+9AyQ/eZ0kTvGgInE+LGQ4742ob7bo1ZHHdRrRUFuywfQ==
X-Received: by 2002:adf:ff8e:0:b0:34a:56e7:5cc4 with SMTP id j14-20020adfff8e000000b0034a56e75cc4mr9372212wrr.2.1713887641816;
        Tue, 23 Apr 2024 08:54:01 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id y5-20020adfe6c5000000b003436cb45f7esm14854289wrm.90.2024.04.23.08.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:54:01 -0700 (PDT)
Message-ID: <113a6baa-faea-4249-8e99-6bd420599513@linaro.org>
Date: Tue, 23 Apr 2024 17:54:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] thermal/debugfs: Avoid excessive updates of trip
 point statistics
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <4918025.31r3eYUQgx@kreacher> <4890052.GXAFRqVoOG@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4890052.GXAFRqVoOG@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/04/2024 15:09, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since thermal_debug_update_temp() is called before invoking
> thermal_debug_tz_trip_down() for the trips that were crossed by the
> zone temperature on the way up, it updates the statistics for them
> as though the current zone temperature was above the low temperature
> of each of them.  However, if a given trip has just been crossed on the
> way down, the zone temperature is in fact below its low temperature,
> but this is handled by thermal_debug_tz_trip_down() running after the
> update of the trip statistics.
> 
> The remedy is to call thermal_debug_update_temp() after
> thermal_debug_tz_trip_down() has been invoked for all of the
> trips in question, but then thermal_debug_tz_trip_up() needs to
> be adjusted, so it does not update the statistics for the trips
> that has just been crossed on the way up, as that will be taken
> care of by thermal_debug_update_temp() down the road.
> 
> Modify the code accordingly.
> 
> Fixes: 7ef01f228c9f ("thermal/debugfs: Add thermal debugfs information for mitigation episodes")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


