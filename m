Return-Path: <linux-pm+bounces-8730-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4358FF2AE
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 18:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1481C20EEC
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 16:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD44198845;
	Thu,  6 Jun 2024 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LrmS2OSU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B3043ACB
	for <linux-pm@vger.kernel.org>; Thu,  6 Jun 2024 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691946; cv=none; b=kQumir4RYzGXfOqWnuIIAG/gkIiHMrkKZm7bkQ073qUX9wTqyWBv/1YKhyMQDu2vW5VqGyFgjiOOlK4YXJUTb5q+z7tLD/CZZuSKuWto62JTqu52ePzVVSfbedTjmaW4NN0UsAI69HMlHSzmkCPvz5fwzXRWLi3JC9akUv3KrTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691946; c=relaxed/simple;
	bh=0sUhzePxA5ILJh6kcxhT9jhNMheNOJsBhpMUA+zrAr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FU3QaZUEqZY2OiRKpRYjqPHvAqShmgEPlPIT7vVFtCAmF55GyXHr3wYrjB7aiPn4Yu3IwevrZbb46Kb937gPHOlyM88W4P719lDcSt7kk++0n8jmaOR25lX8XZd4PVwW8+airos8lw5pW8OtQzob4DaRAZ8HMLKVB9IPbeI13lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LrmS2OSU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4215b0bffe1so7076875e9.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Jun 2024 09:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717691943; x=1718296743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXdSRq/xXQtY4fK65pJyyKeGGdpvh+lT4zYhLPfTB4c=;
        b=LrmS2OSUCUbTBiodfAgWSYWBnMDqVBYu654UCCncw8BnmKEab2fmtG3UBUnMs/iZ4U
         Y6rR4or+YvlJn3ET8aiaNNIMcJh8yC2MqGvhYuFS9fM/aGPSHmwYXKdaSbKfCFfsOdU2
         mdkhX48BAncBwkaRhRb3JlYBtUyqkoz+iL6HwJpYZEvxVScQtXMKno38jZpOzuLt0leq
         w50y1EQSsgPA0+YNZK36o9GjH8ixnSawCSVNUnzlLZRqCJGYBm5bHo7Ciyt6E0SG2HS7
         vVzeFAOPa7hESOy3Zaa0LmlnB1sHGLAsWo63dAkbMTRo7r2iM9HXh7mr0oFH1CJR//B0
         vUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717691943; x=1718296743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXdSRq/xXQtY4fK65pJyyKeGGdpvh+lT4zYhLPfTB4c=;
        b=HXN50NZ4niGx2f5h+Ah0jtqxMnKECwvzo2kxzwZQgSRZVnrxJBuYXsmRcK+xN2bbvB
         hKn1HRQEQIXwCFn99GlyuNCjFgxdQIOvXbBBCx+lrZqabcKiazCNQG9HQqKuEJKCMeAg
         Wv88DgqhA6ys4gD3ZqbohJ8NzS5qYnvrRfQkQm0m92PxWmjOyDFnxhrl5khxPg71kdKa
         5rfK6J92qS2+7HHGZzHahwXGpGJ/MjDLvpQhDp8qnMpR7s/pJ17p7jB4JqneeaBWAP1M
         XzikvEPMFz4InTGLQcdKXE1zQ0wksm6PT8bTVwKxtHhP54leGn03nIAhuhZLHmHCy049
         FNiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOGIeAVLHf9OphqhPo9Ge75cUibb775ty9Cf1FCifJHOnvHCrw0Alp9GDp638tWLKMRYwx5T/+EFN0KMp3syB3uInJwKJ7+tw=
X-Gm-Message-State: AOJu0YyZX0COGeaWXCmAtuw8y0A1fN2ioaEB4eDwRG7eE1sOuxTTd0J3
	euiYfSVU8ZSVhJcZrXeyc8ec2K/uLUcf95A5yutPs11mUqGHEKxSanMT7H5CRT1gqKFosM1Kpez
	GZwk=
X-Google-Smtp-Source: AGHT+IFtjI2uG5kxWT0xfMI3B/djVg1/Aj63CZXkzzrEcegz3u68SQVBpTCW8tUcw72ZesSgllhIjA==
X-Received: by 2002:adf:ed52:0:b0:355:b9d2:4667 with SMTP id ffacd0b85a97d-35efea6fa89mr211455f8f.29.1717691943486;
        Thu, 06 Jun 2024 09:39:03 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:f9a9:3740:b905:9995? ([2a05:6e02:1041:c10:f9a9:3740:b905:9995])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35ef5d4a827sm1984629f8f.36.2024.06.06.09.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 09:39:03 -0700 (PDT)
Message-ID: <a5476bdb-da6f-40d5-baa9-fa2caea72e3d@linaro.org>
Date: Thu, 6 Jun 2024 18:39:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: core: Do not fail cdev registration because
 of invalid initial state
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, Laura Nao <laura.nao@collabora.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <6056838.lOV4Wx5bFT@kreacher>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6056838.lOV4Wx5bFT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/06/2024 18:08, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is reported that commit 31a0fa0019b0 ("thermal/debugfs: Pass cooling
> device state to thermal_debug_cdev_add()") causes the ACPI fan driver
> to fail probing on some systems which turns out to be due to the _FST
> control method returning an invalid value until _FSL is first evaluated
> for the given fan.  If this happens, the .get_cur_state() cooling device
> callback returns an error and __thermal_cooling_device_register() fails
> as uses that callback after commit 31a0fa0019b0.
> 
> Arguably, _FST should not return an invalid value even if it is
> evaluated before _FSL, so this may be regarded as a platform firmware
> issue, but at the same time it is not a good enough reason for failing
> the cooling device registration where the initial cooling device state
> is only needed to initialize a thermal debug facility.
> 
> Accordingly, modify __thermal_cooling_device_register() to avoid calling
> thermal_debug_cdev_add() instead of returning an error if the initial
> .get_cur_state() callback invocation fails.
> 
> Fixes: 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to thermal_debug_cdev_add()")
> Closes: https://lore.kernel.org/linux-acpi/20240530153727.843378-1-laura.nao@collabora.com
> Reported-by: Laura Nao <laura.nao@collabora.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2:
>     * Instead of making the thermal debug code effectively ignore the invalid
>       initial cooling device state, simply don't register thermal debugfs for
>       a cooling device if its initial state returned by the driver's
>       .get_cur_state() is invalid (Daniel).
> 
> Laura, please test this one even though I don't see why it wouldn't work for
> you if the v1 did.
> 
> ---
>   drivers/thermal/thermal_core.c |    5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1001,7 +1001,7 @@ __thermal_cooling_device_register(struct
>   
>   	ret = cdev->ops->get_cur_state(cdev, &current_state);
>   	if (ret)
> -		goto out_cdev_type;
> +		current_state = ULONG_MAX;

Why not move the section ? So we end up below.

>   
>   	thermal_cooling_device_setup_sysfs(cdev);
>   
> @@ -1016,7 +1016,8 @@ __thermal_cooling_device_register(struct
>   		return ERR_PTR(ret);
>   	}
>   
> -	thermal_debug_cdev_add(cdev, current_state);
> +	if (current_state <= cdev->max_state)
> +		thermal_debug_cdev_add(cdev, current_state);

	ret = cdev->ops->get_cur_state(cdev, &current_state);
	if (!ret)
		thermal_debug_cdev_add(cdev, current_state);

Additionally a comment here to explain why get_cur_state can fail and 
telling it is up to the driver to fix its routine?


>   	/* Add 'this' new cdev to the global cdev list */
>   	mutex_lock(&thermal_list_lock);
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


