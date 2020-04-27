Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCA81BA4D4
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 15:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgD0NhA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 09:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD0NhA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 09:37:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D44C0610D5
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 06:37:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 188so19564969wmc.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PLhKz75zqOwWLTLcSPmdm0Ulr5Q4AEFFNxwD79jqu3o=;
        b=ERaMD/awCf6+TF0e6g+Xgp2ou3ZyLJYgGhLx+A+EFm8umVaHjnOCQZV9CyYq8SJpz0
         TRn/hzD1Z9HwTd6rAxefimHcxrCUImC1DYSD5FOw6BqbYKhcSYJukqGg19UQz7z4oWDl
         kc8Sk+eUyjEJT4h2iQAsW8tp3MW//5TcdflcwJEvAHdroF+cDelzAmgcQarBFJK9P5X+
         pTSSUJKI+EEfrX9ZXodEf9dlFuVFX90EtUwYCgrknqFu7skWpxHHR/S1CeA/gTThrTXL
         KByN6+LfQ/Hyw6hgAgtGkccSRcJjSskwstYTD2uEmqvPhXpRPvZmcZQL73hVL2ECiYNm
         Fffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PLhKz75zqOwWLTLcSPmdm0Ulr5Q4AEFFNxwD79jqu3o=;
        b=ioMLm0rg5iXUT3NV8C4xnUS21jx3Cn1z/JxHZmEFsx2hcOI+48Ahrv8PpeApJ/xxhQ
         8BPvSAHIj7eIolGeTijpcnbvVv1vxE2Cib9Kk+HICVSUs9Ywk5ia/tKZtY6aiVO/xay3
         +EW/6D33v3pSnINOKhZDEkMwzdYyfSOa0HuynArt/hsFF2vTsG4Q2cg4PI92zX29949B
         gw5N1Mo0/xDkg3EmpziRzP452O0/Bo0+ttRAaktRib2yCTxHD48jir1dVlxMXdTt+rQQ
         gAuUdcX9RFUMJ0MYP+fO8Z5x7s2WhkMC406++WTl98ZBnKOE5pafbRn9QTG5u734A6iF
         HRPA==
X-Gm-Message-State: AGi0Pubir3xIWk/f+GRHwqA9EkT1RjlLaF0nlJZHbqUDFw53R1FlEhso
        OKa8CyZenUrZPPya4aY1lm9PFhZidoA=
X-Google-Smtp-Source: APiQypLT2wwYrVLOwutsbs/XphxiMT4WGy0G+YtgofN/gSUTsppmjK+I6X4aioSackLjrbi1Epq2fw==
X-Received: by 2002:a05:600c:220c:: with SMTP id z12mr25738786wml.84.1587994618599;
        Mon, 27 Apr 2020 06:36:58 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id b4sm21168349wrv.42.2020.04.27.06.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 06:36:58 -0700 (PDT)
Subject: Re: [RFC PATCH] cpuidle: Make cpuidle governor switchable to be the
 default behaviour
To:     Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org
References: <1587982637-33618-1-git-send-email-guohanjun@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <06ff344e-7abf-9eb6-9664-0e9f9d8d6bc7@linaro.org>
Date:   Mon, 27 Apr 2020 15:36:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587982637-33618-1-git-send-email-guohanjun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/04/2020 12:17, Hanjun Guo wrote:
> For now cpuidle governor can be switched via sysfs only when the
> boot option "cpuidle_sysfs_switch" is passed, but it's important
> to switch the governor to adapt to different workloads, especially
> after TEO and haltpoll governor were introduced.
> 
> Introduce a CONFIG option to make cpuidle governor switchable to be
> the default behaviour, which will not break the boot option behaviour.
> 
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/cpuidle/Kconfig | 9 +++++++++
>  drivers/cpuidle/sysfs.c | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index c0aeedd..c40cb40 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -47,6 +47,15 @@ config CPU_IDLE_GOV_HALTPOLL
>  config DT_IDLE_STATES
>  	bool
>  
> +config CPU_IDLE_SWITCH_GOV_IN_DEFAULT
> +	bool "Switch the CPU idle governor via sysfs at runtime in default behaviour"
> +	help
> +	  Make the CPU idle governor switchable at runtime, and make it as the
> +	  default behaviour even the boot option "cpuidle_sysfs_switch" is not
> +	  passed in cmdline.
> +
> +	  Say N if you unsure about this.

Well I wouldn't make this optional but just remove the sysfs_switch.

However, there is the '_ro' suffix when the option is not set. In order
to not break the existing tools, may be let both files co-exist and add
in the ABI/obselete the '_ro' file as candidate for removal ?


>  menu "ARM CPU Idle Drivers"
>  depends on ARM || ARM64
>  source "drivers/cpuidle/Kconfig.arm"
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index d3ef1d7..43701da 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -146,7 +146,7 @@ static DEVICE_ATTR(current_governor, 0644, show_current_governor,
>   */
>  int cpuidle_add_interface(struct device *dev)
>  {
> -	if (sysfs_switch)
> +	if (IS_ENABLED(CONFIG_CPU_IDLE_SWITCH_GOV_IN_DEFAULT) || sysfs_switch)
>  		cpuidle_attr_group.attrs = cpuidle_switch_attrs;
>  
>  	return sysfs_create_group(&dev->kobj, &cpuidle_attr_group);
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
