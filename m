Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D071287F0C
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 01:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgJHXXZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 19:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730939AbgJHXXZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 19:23:25 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E0AC0613D4
        for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2020 16:23:24 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z1so8337441wrt.3
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2020 16:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3EtKmKMy3vG8i3h8NClcxP5zyMtCd9LJjxAVLf9GMYQ=;
        b=bJ876ZGyQ9SPlHdrPZbdemybrbsKrafGpMMela3/WxH/fFzPWEtY16uq61ogRFXtyd
         0jXWiFV94Puw0OvdeqqlJCnQpv+eDeQneNXpZfq3jrnRBVBCBAqaS2oEl7cPB68LNOEz
         izWppDmNLm05MJDjO2HvyqIKCLEHz9crTHwXHraK6YVoc65g18FYY6tKaBwqU/nNCzJm
         zZE2gaevKL9ZYbEEp+z7zADUsG1nkBcy/skduLDiHmjKneMdH2F6JNTAAvwBTGGAwYYc
         D7GddT1ShWiakiZmuziySZlC11TvfpRBVSwyFMk1LFAwVFOh/4h+hmHIrE14ne7mDIB9
         61vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3EtKmKMy3vG8i3h8NClcxP5zyMtCd9LJjxAVLf9GMYQ=;
        b=fNztWLpta/w+/Pnd4DxBmy4dNwBsKeuWVjtAUqpCXhudIfEywAHAlP5RS8hzCCczp4
         jt0Au1q+2PZIj15zn36JpC/5/QuV5G1PcTvNy35QV4zVkumxT0pEZfIoJE4psVFcGSK4
         VDMGO9WBnoCzuUeN3HVu538ho8rbSAEtKl0Dpec//A8nBZ/q2J7uFKfIiDLe98sVT6wL
         wU5OSujGmtH8mmtwYC8aVZjJy1DAw7HAjOBFJtUAXGzD8atdUSq4lj5rtZp/4UyfJeqn
         xwhamMrU+1WIdphuCJGP9zFuYN+7w/+31Du3tZE0g4lPC9X9yYqiKc6RdsPXN/oDVQRX
         zQjA==
X-Gm-Message-State: AOAM5334bM+Kie5QXvqjFYYdzFjhNFmmwwAGQKpJCiwFwl5Fo5QvmjjC
        EfVrlPEAVhMUBggg9gYHzbOVjA==
X-Google-Smtp-Source: ABdhPJxIXqFQj7qMPz5xQdrQsmT3y3a8g6giamxY4mF3euvwh/OmVP7cA7oWsihHSt+aI6DDeuodSA==
X-Received: by 2002:adf:bc14:: with SMTP id s20mr12488513wrg.220.1602199403185;
        Thu, 08 Oct 2020 16:23:23 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:bcbd:c839:6352:ebcd? ([2a01:e34:ed2f:f020:bcbd:c839:6352:ebcd])
        by smtp.googlemail.com with ESMTPSA id v128sm8820729wme.2.2020.10.08.16.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 16:23:22 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: ti-soc-thermal: Enable addition power
 management
To:     Adam Ford <aford173@gmail.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc:     aford@beaconembedded.com, kernel test robot <lkp@intel.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200911123157.759379-1-aford173@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6acd7e51-0c77-fa30-9e8c-d2cf727e512c@linaro.org>
Date:   Fri, 9 Oct 2020 01:23:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911123157.759379-1-aford173@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/09/2020 14:31, Adam Ford wrote:
> The bandgap sensor can be idled when the processor is too, but it
> isn't currently being done, so the power consumption of OMAP3
> boards can elevated if the bangap sensor is enabled.
> 
> This patch attempts to use some additional power management
> to idle the clock to the bandgap when not needed.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Tested-by: Andreas Kemnade <andreas@kemnade.info> # GTA04
> ---

[ ... ]

> -	/* First thing is to remove sensor interfaces */
> +	cpu_pm_unregister_notifier(&bgp->nb);
> +
> +	/* Remove sensor interfaces */
>  	for (i = 0; i < bgp->conf->sensor_count; i++) {
>  		if (bgp->conf->sensors[i].unregister_cooling)
>  			bgp->conf->sensors[i].unregister_cooling(bgp, i);
> @@ -1150,9 +1167,43 @@ static int ti_bandgap_suspend(struct device *dev)
>  	if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
>  		clk_disable_unprepare(bgp->fclock);
>  
> +	bgp->is_suspended = true;

Is this flag really needed?




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
