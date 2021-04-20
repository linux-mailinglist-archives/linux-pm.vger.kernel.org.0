Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42558365C01
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 17:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhDTPTI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 11:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbhDTPTI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 11:19:08 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73703C06138A
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 08:18:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id y204so19004529wmg.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 08:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y1sA+aQaPXL3h/YxiPjTBbVYUS1bVeZ4E2z5caxyFkY=;
        b=SiOBPrzDeT9AymLJHMv9IvbQ7nLqL+nb1TKmYCV7VsfPhLlQOf0Ww3Z7aLhbBJJ2J7
         OYvZhXQ2PcccyOWO889NYZlaih9v/nwWiBt4R8QDJ9WAUu6PFOx6lXbSn2vhmGZG2Rqz
         /WQHdpc3pzD6MdrnGs7eCwtXUKYxT3AmLCM/durulne/9yAQRHQT6v7P1snV//B0aYZl
         yuEmfxLSyWQfFs9S3gZdyRzZbLiSmAyb8hJrEpZsVaWDZ8fzRee3usTVLMSAFMmg143v
         4NnQjh8JjZg47o7chfVQCx3x4f5SYume8hTOPnxwWj1ehak2ZwymmKRyIlHlEwZWgpc1
         H4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y1sA+aQaPXL3h/YxiPjTBbVYUS1bVeZ4E2z5caxyFkY=;
        b=bil2xY6cR1oyycf4V/mbV7GGqVEWwwvpWZVwR1s+nD5kPA/6pDEnKvH/zU+ManN/cV
         pG3o7Q6CF3fd1BBY5W5sUkFeKuxdntVywS2T80wYN4HI96R0H4aqtFe9Zos+lSHzp93I
         9GR3gSj8nKXbpNBejAd6Vl5sz5ED9eLeGF5C51Zdcvc4Lm3Ux/gUy22TSOP+R7DM6Cnh
         EPrzxodHXVpyS8RElRpL/9AyjZu+OnWn6A1R1uo+OpDvu/Z31jcD29K77M4av/Fq6OVx
         wSQybbh8Bv2YcfZAD/TUOIFtYO5pZKILsdDryiXprKjV7JU0ZOpLVBSvt3cutPK+wiD3
         68bQ==
X-Gm-Message-State: AOAM531iJCVkBYbeQLNQ/Q19ItPNCE61NNXrxQH5Hi/vrWTyRp5vknmQ
        at5Js+sufjyZVzZCyWzmB4OBSg==
X-Google-Smtp-Source: ABdhPJzFfivd1nUbTvbvbC/OCYxG9scaAcwLUaIOksi07Sgc8P8VNa66lkMFWne4o74qEbgTCSBKyQ==
X-Received: by 2002:a7b:c303:: with SMTP id k3mr5130906wmj.100.1618931914021;
        Tue, 20 Apr 2021 08:18:34 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a079:f96:da87:2d00? ([2a01:e34:ed2f:f020:a079:f96:da87:2d00])
        by smtp.googlemail.com with ESMTPSA id m15sm24797766wrx.32.2021.04.20.08.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 08:18:33 -0700 (PDT)
Subject: Re: Aw: Re: [PATCH] thermal: mediatek: add sensors-support
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210320080646.49615-1-linux@fw-web.de>
 <f4329b1a-02e0-aad5-55bd-82d30a38fc55@linaro.org>
 <trinity-4a3f024e-c01d-44e4-a884-530135853d33-1618930770250@3c-app-gmx-bs72>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b38c3539-c864-67b3-95e8-9b652cf6fcbf@linaro.org>
Date:   Tue, 20 Apr 2021 17:18:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <trinity-4a3f024e-c01d-44e4-a884-530135853d33-1618930770250@3c-app-gmx-bs72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Frank,

On 20/04/2021 16:59, Frank Wunderlich wrote:
> Hi,
> 
>> Gesendet: Dienstag, 20. April 2021 um 14:07 Uhr
>> Von: "Daniel Lezcano" <daniel.lezcano@linaro.org>
> 
>> No #ifdef in C file.
> ...
> 
>> devm_thermal_add_hwmon_sysfs() ?
> 
> based on your comments this should be enough/right?
> 
> #if IS_ENABLED(CONFIG_THERMAL_HWMON)
>     tzdev->tzp->no_hwmon = false;>     ret = devm_thermal_add_hwmon_sysfs(tzdev);
>     if (ret)
>         dev_err(&pdev->dev, "error in thermal_add_hwmon_sysfs");
> #endif
> 
> if yes i send out v2, at least it works on my device

just the following lines should work:

	ret = devm_thermal_add_hwmon_sysfs(tzdev);
	if (ret)
		dev_err(&pdev->dev, "error in thermal_add_hwmon_sysfs");


The no_hwmon usage is a bit fuzzy in the thermal core code.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
