Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88D42D766A
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 14:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406014AbgLKNTE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 08:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406096AbgLKNSi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 08:18:38 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7B1C0613CF
        for <linux-pm@vger.kernel.org>; Fri, 11 Dec 2020 05:17:58 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r7so8999492wrc.5
        for <linux-pm@vger.kernel.org>; Fri, 11 Dec 2020 05:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pTsb6QBizLruQ4SvEPGcUMH+feyQGOx2SNhiTZ6A7sk=;
        b=BzU7C30N+YcYwkp2ex51D28fxZp48WXRt3da/89karVc7nkPSQhS8XlV/xSa4Fez4e
         4eu4B9UkufaXX/oOfYsACQi4bB6874NUMWJu8PFGXjGBtp9hTn13U0Yh3n2hAfXMJDyG
         ZSEyAuJptY3InH5ff3BJ1OqS9iVmbDkVyuw4VxJs/PQg/LVRK4kFVRcIWv2jykzy3YCK
         5ZoW8oBLsOVZKgU15idzMl1WXoZdqosYOY7ZhQJbVE0oOxN2Pcgtg/Xg1yPChXXZFbgy
         07LZxXMRdpbjb+ufmcPFdZ/obsyEwOnonOFY5GZ9ZO11Kiw8x8luQ0PXSBBW1lAi9APT
         HTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pTsb6QBizLruQ4SvEPGcUMH+feyQGOx2SNhiTZ6A7sk=;
        b=n9JppNDvbmAvGm0phAEh9moRES/d1DOJ2FSQ/ahbmhG9awbbOfUL+XZ0Rv7opS/sLO
         1U77/XA1tq2p2DV9MUFP5slnPnsjSb172gj/E3aWznPx12XqaTXwQLNijXDobJR4Bg5E
         9leY/1G34mOkPeXZRpSsYYDp+tevHCkftwy8spufP0ckipA9aHdOMF5TLmdFjGSqPhtc
         7q4VTqYaqAxOB1FUmfW0Vn7nDjQtEJEex7Ip2flybptGCVkY7uhlbFII9wFvpPoP7l8b
         LU+FykDqIwmhzpqFUmvnrEWibj6EfE1ALNuZXLNfYBs2Ily5dkpfAgzDDmZQcMp8Hrme
         1Ldw==
X-Gm-Message-State: AOAM532YqA0f3TSbsjjyhbSOB07uaPv5qsr/vR3Aawl+mGBy5YgyduPs
        YLCeplhG37MXqP16I/KUfLn3oQ==
X-Google-Smtp-Source: ABdhPJwZSQdwUi/HyQh/NNTpkHJs9H+AQNSI8zWb+io8+EqtMHVKyqk1cgo2bflY2HyA/k9j6o+A9g==
X-Received: by 2002:adf:f101:: with SMTP id r1mr1891369wro.112.1607692677022;
        Fri, 11 Dec 2020 05:17:57 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:fc92:290c:960a:52ef? ([2a01:e34:ed2f:f020:fc92:290c:960a:52ef])
        by smtp.googlemail.com with ESMTPSA id e16sm16318909wra.94.2020.12.11.05.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 05:17:56 -0800 (PST)
Subject: Re: [PATCH] thermal/core: Make 'forced_passive' as obsolete candidate
To:     rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        amitk@kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>
References: <20201208153046.297456-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cc2085ca-ada9-d616-eed5-3496889da3bb@linaro.org>
Date:   Fri, 11 Dec 2020 14:17:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201208153046.297456-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/12/2020 16:30, Daniel Lezcano wrote:
> The passive file in sysfs forces the usage of a passive trip point set
> by the userspace when a broken BIOS does not provide the mitigation
> temperature for such thermal zone. The hardware evolved a lot since
> 2008 as a good thermal management is no longer an option.
> 
> Linux on the other side also provides now a way to load fixed ACPI
> table via the option ACPI_TABLE_UPGRADE, so additionnal trip point
> could be added there.
> 
> Set the option obsolete and plan to remove it, so the corresponding
> code can be removed from the core code and allow more cleanups the
> thermal framework deserves.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Is there any concern about this change ?

>  Documentation/ABI/obsolete/sysfs-thermal-passive | 13 +++++++++++++
>  drivers/thermal/thermal_sysfs.c                  |  2 ++
>  2 files changed, 15 insertions(+)
>  create mode 100644 Documentation/ABI/obsolete/sysfs-thermal-passive
> 
> diff --git a/Documentation/ABI/obsolete/sysfs-thermal-passive b/Documentation/ABI/obsolete/sysfs-thermal-passive
> new file mode 100644
> index 000000000000..2510724cc165
> --- /dev/null
> +++ b/Documentation/ABI/obsolete/sysfs-thermal-passive
> @@ -0,0 +1,13 @@
> +What:		/sys/class/thermal/thermal_zone*/passive
> +Date:		December 2008
> +KernelVersion:	2.6.28
> +Contact:	Daniel Lezcano <daniel.lezcano@linaro.org>
> +Description:
> +
> +  The passive file in sysfs forces the usage of a passive trip point
> +  set by the userspace when a broken BIOS does not provide the
> +  mitigation temperature for such thermal zone. However, the Linux
> +  kernel evolved a lot since 2008 as well as the hardware and it is
> +  able to manage correctly the thermal envelope. It does also provide
> +  a way to load fixed ACPI table via the option ACPI_TABLE_UPGRADE, so
> +  additionnal trip point could be added there.
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 0866e949339b..578099b520b1 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -232,6 +232,8 @@ passive_store(struct device *dev, struct device_attribute *attr,
>  	if (state && state < 1000)
>  		return -EINVAL;
>  
> +	pr_warn("%s: Consider the 'passive' option obsolete\n", tz->type);
> +
>  	if (state && !tz->forced_passive) {
>  		if (!tz->passive_delay)
>  			tz->passive_delay = 1000;
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
