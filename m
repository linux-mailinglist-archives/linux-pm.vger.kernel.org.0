Return-Path: <linux-pm+bounces-12647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21774959FE2
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 16:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A9D1F22092
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 14:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687BA1B251A;
	Wed, 21 Aug 2024 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nz19C+Ia"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7721AF4F3
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250564; cv=none; b=rPatpbfqWq7I6s2C4kADPCS3gIlx3yTRTBK477Tq+0uVs4zti2ekZaKuQ4kg5fmOI5Ah1oxLchLXemBW9clTqKSOvbKO3WQBlY8FSaKTIO3UigflkYih8dOUzl+2oYi9phadyH6c6878hC61IWOoNWKQeBfrPqRYEa04ba6SEl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250564; c=relaxed/simple;
	bh=OsLjo/8OT4/j0mipyKG5ySkrd19FNuVjFeBqzdUKW+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBiqu3e79xUtMh/EomA49r21MJ0IvnIm3bWYKQjYtFblC19rabGi+bj7sQ5pSaZQHxSuYoqVRRMSoRVrvLJ8EvtGY3fIjXEgykziT785/cIJVN3yC9f0rexvyIO//VgYJP5IXFyXzOIIq2jcxUnC8aKi57SSDfpXoPyoNlav28A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nz19C+Ia; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-371b2e95c34so2495206f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 07:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724250560; x=1724855360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G1Am1BTqF5PzPzIs8w03C4Elv0VQqVhSuJokYbLBi4o=;
        b=Nz19C+IaWI8ZiQSol1t9mRQhPLVHvr9JbHR51kE7B5PsDB/R9LgH400vcCoXmWYgj0
         /GuPiNCJl4CL+b8AbYHB+O4gdg5RZVT89yBMu5m1XBVmMXKET10bdaOAuK0IIAaEuRbr
         hLjuynCp2sl1TS0R2iuzVTzK3Usiv45QavucQGEGUn1rKR8DSuYxPWD/3H4sWjC2xwpv
         boMlOy3aMpOjuqL53WiBEU4sn7OkDLWveP3nCP+9PdsZ4Ik0VasehlM8DkBXcoAQ96Ab
         s6wWC/amnd7ksdxTj6afApOWo+VX9FXGwOdziroySOq9eOGiwSWXKG5mAtQqD+wqtmoO
         M3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724250560; x=1724855360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1Am1BTqF5PzPzIs8w03C4Elv0VQqVhSuJokYbLBi4o=;
        b=NIDKsrWA2gxvDwselnbPE7q3UHIov+zf52D1FFSbMDoETLyAjVhPoXdTHWJq/T5G6a
         RvmQUrHV3o5a0cQ8KCBV7Dslmo5khwO1fvyRdt5Tt9GyH2eGYym0UsaUF+UXY7rlUh+T
         bYVbAIpTegQXYyvaFOx83FUgAd7CO0exsChAzZo0dhZlK3dM1SJkbyjg6uo8Xo+Y+uiB
         Q1BR6xNoAaCDzmrpBIFH4dcSNDFj8XIU2KRXcAnbN+zPUdxj78X59VKsOFNm/PmWo6eR
         QhRZBu0do0l8P4LeqCKm3/v98MAnTD+o78GagxZuiSsZ2o6EP3v1Ix0IRS4cH4XLp5r4
         6q7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQqb0NygsF0xyazEgDkHkS/aOU5K2BHJuFe8URQZ5b8TKI6frhtKvHRK25MokdrIByXu7SB5TjNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/38Bld9wFOyaItkbWw6WXONzYGMfKlETACTWWRSnUrMMrkh87
	vUXpIYhtWT2hECkmEhhHUmLQ7NbYAJJjMgnwi8KWemX27+1Dz3T0WFAE+XmHwAZjAc9IbflDEVA
	D
X-Google-Smtp-Source: AGHT+IF0Sshvp4+jgqCMsklf6SpvECgUEs0VXN4h1ifK5nbUiy5UlhHd2JHpBFS1jvekPXf+oKrG0g==
X-Received: by 2002:a05:6000:4598:b0:371:6fc7:dac1 with SMTP id ffacd0b85a97d-372fd828601mr1662131f8f.61.1724250559493;
        Wed, 21 Aug 2024 07:29:19 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42abed91158sm27526805e9.8.2024.08.21.07.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 07:29:18 -0700 (PDT)
Message-ID: <ae0bec37-f800-4824-914c-34bf41d2a775@linaro.org>
Date: Wed, 21 Aug 2024 16:29:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/14] thermal: core: Clean up trip bind/unbind
 functions
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <1831773.TLkxdtWsSY@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1831773.TLkxdtWsSY@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 18:33, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make thermal_bind_cdev_to_trip() take a struct cooling_spec pointer
> to reduce the number of its arguments, change the return type of
> thermal_unbind_cdev_from_trip() to void and rearrange the code in
> thermal_zone_cdev_binding() to reduce the indentation level.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3: Subject fix
> 
> v1-> v2: No changes
> 
> ---
>   drivers/thermal/thermal_core.c |   54 +++++++++++++++--------------------------
>   1 file changed, 21 insertions(+), 33 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -757,15 +757,7 @@ struct thermal_zone_device *thermal_zone
>    * @tz:		pointer to struct thermal_zone_device
>    * @trip:	trip point the cooling devices is associated with in this zone.
>    * @cdev:	pointer to struct thermal_cooling_device
> - * @upper:	the Maximum cooling state for this trip point.
> - *		THERMAL_NO_LIMIT means no upper limit,
> - *		and the cooling device can be in max_state.
> - * @lower:	the Minimum cooling state can be used for this trip point.
> - *		THERMAL_NO_LIMIT means no lower limit,
> - *		and the cooling device can be in cooling state 0.
> - * @weight:	The weight of the cooling device to be bound to the
> - *		thermal zone. Use THERMAL_WEIGHT_DEFAULT for the
> - *		default value
> + * @c:		cooling specification for @trip and @cdev

s/c/cspec/ at least :)

Other than that

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

