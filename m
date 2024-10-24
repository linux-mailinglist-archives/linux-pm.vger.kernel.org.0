Return-Path: <linux-pm+bounces-16367-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 595209AE2B6
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7AC1F2182C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 10:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC5F1C2DA2;
	Thu, 24 Oct 2024 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d1J/JSyy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1771C0DE2
	for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729766182; cv=none; b=NoGDKs6d3OrZjXy0xeHE8xdZaOEY6GFcOqYPfLPqqEQga9lGXIUwIw8qeXE4L3t35xXq+4j7srRcV8kqb0hHY8/fp/90h15SpDfEWszyoGXKSp+LkopsiY8tB21pYkLLALfaemPrQYYlgdTVejE6+qn0R0ZzJI85GXs4P/25HGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729766182; c=relaxed/simple;
	bh=SeURXPNRtR8saK/e9SDz/zEg0KiVbRWzolUxUhzgr2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNjnJH75pnRBSG2p+hoY8FtGF75UMxTm8muGCmzDHwZRN6spdCqv1lDHXWaU4/zghl3xnU2hCWCC37LbILY+EUCb6qkLpfyJJwsz72Vx33njNQFJUb+iJ1oxAZvCJWPUq8RxHWNUrVz8gqCsc3kXIGt7A5rR5ydTcSGUQSZujOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d1J/JSyy; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d43a9bc03so505918f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 03:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729766178; x=1730370978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J2m6zXjeU4UBvItNkzUXHkJaeUZJVQOEVcMDTCkz29M=;
        b=d1J/JSyy05Qq1gy1qkPHgJedJMEylS6k+xbBB45QyYbpNy021hGi3THbz5IufsXGAz
         DtBF1l23lje4qvrL8OKcwPWIr2Akuh6l5bDcGR5DGqs8sCyaHoukjyUnsfKH3ghp61mG
         q5SqAXryei27z7bNuQ4PKo02uHXVXDH+txNAlrF85AWj2kC/m4KwzJXZyeK8my0NLC0F
         q9MsgaF7dLy/kjtuX0enrKClVc2SDyeUQ8ZVD+Nk79GyLbda9kxHYizEWhg/6BqlVXVb
         x0S36Nja+M25CXFKdPK4QXAX76WRaiNcQygdvWRovyZW/x7R4mgcoExvVhkt0Zv70hB4
         BZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729766178; x=1730370978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2m6zXjeU4UBvItNkzUXHkJaeUZJVQOEVcMDTCkz29M=;
        b=OTqTsW+tyAGpE8qDugSKzFZjS+FWi377ppyJzcYppo4RR1hLqQKoUyJKbBsx8xz794
         faPwmeOBbProuYG6kGhL1nKcXo3q6zWkng0HZvu7lfCMoDdp6JAgkgIWdlUojsoTKWG7
         VN4a0wSVlO6F8JLpJlpSHEebRLlr4+Dy/e69QA1pcffwf1gNJ9FVwmIuSM3GPTCbym9w
         iLU99hmyZhjXx2eWUwP9sVsZppR8xL30T3xTC9+VPbRa7tTHw5IgoWWyTL1WHxkimjWp
         SJJua5w7WAbQkPx76ONg8HOQadolfKyPHdX4IU/wSjfCCYsy87WiC28qIm/HLJvbpGSz
         Q1gw==
X-Forwarded-Encrypted: i=1; AJvYcCXXI2+RZ9n9W/9cnib72DK1hHJu+z9+uhXzFnTVnLWn55lDSfMZh3JaK3zEFHJZHem8aLAveRMnOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfETCLhQ2VHGmdIvymBYG6OmbA4k7zw2BVadPKohJHf/iXTIk/
	sDJ42oskcCl1LJHpj3DmDs7nqccrGcfw18Hwyqbvg0CBJ8YvrjpLRtUIq8XccwushhLTUxxK5wc
	7
X-Google-Smtp-Source: AGHT+IGS80KlgEPjWf5Mc+qBef5jgU/z0mA2I6rWelhiddK3iBRLjN4Mx0Eo2Dw2peFPZ3jVdeIPSA==
X-Received: by 2002:adf:fc4c:0:b0:37d:4ebe:164a with SMTP id ffacd0b85a97d-37efcf92731mr3710224f8f.50.1729766178421;
        Thu, 24 Oct 2024 03:36:18 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43186bd6894sm41366705e9.10.2024.10.24.03.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 03:36:18 -0700 (PDT)
Message-ID: <8b4659f0-5da7-4847-b5de-fad8ea57e967@linaro.org>
Date: Thu, 24 Oct 2024 12:36:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/thresholds: Fix thermal lock annotation issue
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241024102303.1086147-1-daniel.lezcano@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241024102303.1086147-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi,

please note this fix has been written on top of the thermal thresholds 
series, so I don't know how it conflicts if it is applied before

Thanks

   -- D.

On 24/10/2024 12:23, Daniel Lezcano wrote:
> When the thermal zone is unregistered (thermal sensor module being
> unloaded), no lock is held when flushing the thresholds. That results
> in a WARN when the lockdep validation is set in the kernel config.
> 
> This has been reported by syzbot.
> 
> As the thermal zone is in the process of being destroyed, there is no
> need to send a notification about purging the thresholds to the
> userspace as this one will receive a thermal zone deletion
> notification which imply the deletion of all the associated resources
> like the trip points or the user thresholds.
> 
> Split the function thermal_thresholds_flush() into a lockless one
> without notification and its call with the lock annotation followed
> with the thresholds flushing notification.
> 
> Please note this scenario is unlikely to happen, as the sensor drivers
> are usually compiled-in in order to have the thermal framework to be
> able to kick in at boot time if needed.
> 
> Link: https://lore.kernel.org/all/67124175.050a0220.10f4f4.0012.GAE@google.com
> Reported-by: syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/thermal_thresholds.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_thresholds.c b/drivers/thermal/thermal_thresholds.c
> index ea4aa5a2e86c..2888eabd3efe 100644
> --- a/drivers/thermal/thermal_thresholds.c
> +++ b/drivers/thermal/thermal_thresholds.c
> @@ -20,17 +20,22 @@ int thermal_thresholds_init(struct thermal_zone_device *tz)
>   	return 0;
>   }
>   
> -void thermal_thresholds_flush(struct thermal_zone_device *tz)
> +static void __thermal_thresholds_flush(struct thermal_zone_device *tz)
>   {
>   	struct list_head *thresholds = &tz->user_thresholds;
>   	struct user_threshold *entry, *tmp;
>   
> -	lockdep_assert_held(&tz->lock);
> -
>   	list_for_each_entry_safe(entry, tmp, thresholds, list_node) {
>   		list_del(&entry->list_node);
>   		kfree(entry);
>   	}
> +}
> +
> +void thermal_thresholds_flush(struct thermal_zone_device *tz)
> +{
> +	lockdep_assert_held(&tz->lock);
> +
> +	__thermal_thresholds_flush(tz);
>   
>   	thermal_notify_threshold_flush(tz);
>   
> @@ -39,7 +44,7 @@ void thermal_thresholds_flush(struct thermal_zone_device *tz)
>   
>   void thermal_thresholds_exit(struct thermal_zone_device *tz)
>   {
> -	thermal_thresholds_flush(tz);
> +	__thermal_thresholds_flush(tz);
>   }
>   
>   static int __thermal_thresholds_cmp(void *data,


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

