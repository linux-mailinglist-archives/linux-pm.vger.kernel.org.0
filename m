Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7FF2343CE
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 11:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbgGaJ7g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 05:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732075AbgGaJ7g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2020 05:59:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA403C061574
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2020 02:59:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q76so7475418wme.4
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2020 02:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=39y7P5Gwjtd3AnR6h3PLwZ8s2R2z4M9PxJEGWiapqVU=;
        b=gMBcfMGPW7ErBYTjBzW9QJveMfkgYy+NHBk+SKKkE3vKX6tn6MYhI5L9eaKWiCyrdT
         dpdxpJHinGrmrxPUESyzm42z/NBEQiFWdbEnpE1i9XCy7F3Bq6MdcMODWuhs70/YnNkm
         ki/EwEm6VNZJlhL6QTfSro3pePGkWLwPxHhweAuFvbMMHVKF5FaluqeHAWlhqN6ZKipk
         k3fR+QMmx1+gGaakLPIJ+GqWYoirAt0rEuK6jQQ4z2GkfH4RhHmHMFkmT80EaUBVRrf9
         dOB+yFdrvGIhzZt7yeSqOrXuPo/PihoNrsY1n5qO2BpPPhLlazO9ZUuTJ/OVGxL00hKj
         B2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=39y7P5Gwjtd3AnR6h3PLwZ8s2R2z4M9PxJEGWiapqVU=;
        b=DkIvaidb14HnEZyeqT8xvP+f3h4XQW6HDzfu9R0lLHsTMPKSdm9gFLoaago/1HRrDm
         KKhR4BkCiDE8vdLmxzTbjuUBiBvMEcGXbv2/dB+vzWxmD2FILczihWGrCsLBpkyenLlB
         ZnGxWLnuk44MYSY65KGAqCafZuvvKgM5LxfUYMVgaA8qtSG+eDPKxbsnFn5NaAp/Bab1
         UtXjyDJyJYR6MK139Tp6gIZYuasKfIA0cLqIJAQGNEoyYnoL28Z10faNYCo18HORS8Ju
         u+vHWkmJBYufaW99+5l/LI8hivSXb4NOq/vzu+D5b6V/qyhMtvTb2jp8v1fVsjAXpGOd
         LTJQ==
X-Gm-Message-State: AOAM532fvDcy1LFIHgIy6UnPhn9v9gz/qa20SxxoWNZUpQ5loEwkCtmR
        19J5nDO+KTdnNH5RdCFRnkKq0Q==
X-Google-Smtp-Source: ABdhPJwX7zxARepQDDTP7uSmPjHKWK16wvj2up1Cti71adU9OAdqJiNWJ5CPpT1ecG7IJPqtGWIxxQ==
X-Received: by 2002:a7b:c242:: with SMTP id b2mr3336543wmj.90.1596189574501;
        Fri, 31 Jul 2020 02:59:34 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e484:a7d1:6931:9059? ([2a01:e34:ed2f:f020:e484:a7d1:6931:9059])
        by smtp.googlemail.com with ESMTPSA id s125sm12875748wmf.14.2020.07.31.02.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 02:59:33 -0700 (PDT)
Subject: Re: [PATCH] thermal: mediatek: Fix missing selection
To:     Henry Yen <henry.yen@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Steven Liu <steven.liu@mediatek.com>,
        Michael Kao <michael.kao@mediatek.com>,
        Arnd Bergmann <arnd.bergmann@linaro.org>
References: <1596096304-16422-1-git-send-email-henry.yen@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <69a4b653-9f47-63f1-7eb0-4880bf19497a@linaro.org>
Date:   Fri, 31 Jul 2020 11:59:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596096304-16422-1-git-send-email-henry.yen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Henry,

cc'ing Arnd

On 30/07/2020 10:05, Henry Yen wrote:
> Mediatek thermal driver is compatible with multiple platforms.
> Some of the platforms (e.g., MT2701) requires to enable
> MEDIATEK_MT6577_AUXADC option. If lacks the config, the driver
> will not be able to read correct temperature.
> 
> To fix it, select missing MEDIATEK_MT6577_AUXADC config.

The description states there is a dependency for some platforms not all
of them.

The change will select the option every time for any mediatek platform
or compile test.

I don't think it is the place to select the option.

> Signed-off-by: Henry Yen <henry.yen@mediatek.com>
> ---
>  drivers/thermal/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 3eb2348e5242..3a37f674f7f3 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -409,6 +409,7 @@ config MTK_THERMAL
>  	depends on NVMEM || NVMEM=n
>  	depends on RESET_CONTROLLER
>  	default y
> +	select MEDIATEK_MT6577_AUXADC
>  	help
>  	  Enable this option if you want to have support for thermal management
>  	  controller present in Mediatek SoCs
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
