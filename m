Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94572FF780
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 22:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbhAUVmj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 16:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbhAUVm3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 16:42:29 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314E9C06174A;
        Thu, 21 Jan 2021 13:41:49 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id q8so4652567lfm.10;
        Thu, 21 Jan 2021 13:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OwuZCb9ewdwlU+R/2zHWpei3yNvd7dd0S6nSVQta5DI=;
        b=fBXm2YJcCsvdZxWSnDxe/6wr+lLyhhW/ocizS5IVOEGEsxlADb/3eud4ZWJ1MG8YXL
         5NE9bDKTm8l2Z02uo7/iFyuCYTalmI4QI2Fdmb2Zmi78Myt1ipoJxjusnOIg7v/LvKK8
         Aj8LVwX8RvzchjEWZcLU+xpsVW9/XeQF87sDfB5diveC5sPCzjrAnw0IPL1nupN5bLwK
         FDjBUaUCN6kRGaEpGD2ajy5c03UI2swJEVXdO8TpcchZTilYpwrSSSGho87p65ZEgoQn
         /Yst5iGJaHO3tT3BaNAnfHWD2wSwoKECXWphYhMOmJMaIKUldWVDbCiN6hs+HZRu//Ar
         rDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OwuZCb9ewdwlU+R/2zHWpei3yNvd7dd0S6nSVQta5DI=;
        b=JefvMK/jpMuMNXDkJ2ZFBsn/Evf5QUZ75SmEOqghEbMRkSMyq2r4jBxPimnneaffZW
         fTz9m3ecM8NgXX91OC9uUv+wD52DvzciOUvb7b1Qqj6ktatCS9a93EkPRun56OCkXyVY
         P9aG9ZU07OIr8RQhi6Afob+pGu6aumUoTaVidUsmopuhM5I6NCHTljwt5BCIbrIFnYy3
         BohFIwd3hNTsArYmezH7/B5e9w5Lj0fZB1P1Z+OtEIPeXVnfbVPZP+vy9s8+XqYfeA1D
         4RkHqLmtOs9/pz5ZAjn9mphJx01lY05equI+bHxvWzePimJ+HLtVcgsQPBBbYA1qUZrx
         67kQ==
X-Gm-Message-State: AOAM532noOnO2P7/z5XtCVGvACd/NNJf8yIiMkYkPYJjmCAvCeR8QOUQ
        SFwt8hNQ7xoyC0KGtfS2Q5I=
X-Google-Smtp-Source: ABdhPJwUBFzNUJ46w/nJOtGCGRLB+ZGcj7SVGuZbwv03crhNkdJ1EaxnAm5+WhSafvSKthj5QXdsZg==
X-Received: by 2002:ac2:54ac:: with SMTP id w12mr629640lfk.514.1611265307783;
        Thu, 21 Jan 2021 13:41:47 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id g21sm75276lfb.263.2021.01.21.13.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 13:41:47 -0800 (PST)
Subject: Re: [PATCH 03/13] opp: Keep track of currently programmed OPP
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1611227342.git.viresh.kumar@linaro.org>
 <96b57316a2a307a5cc5ff7302b3cd0084123a2ed.1611227342.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b634343a-8005-fc35-e38b-bfeaa7310a70@gmail.com>
Date:   Fri, 22 Jan 2021 00:41:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <96b57316a2a307a5cc5ff7302b3cd0084123a2ed.1611227342.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.01.2021 14:17, Viresh Kumar пишет:
> @@ -1074,15 +1091,18 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  
>  	if (!ret) {
>  		ret = _set_opp_bw(opp_table, opp, dev, false);
> -		if (!ret)
> +		if (!ret) {
>  			opp_table->enabled = true;
> +			dev_pm_opp_put(old_opp);
> +
> +			/* Make sure current_opp doesn't get freed */
> +			dev_pm_opp_get(opp);
> +			opp_table->current_opp = opp;
> +		}
>  	}

I'm a bit surprised that _set_opp_bw() isn't used similarly to
_set_opp_voltage() in _generic_set_opp_regulator().

I'd expect the BW requirement to be raised before the clock rate goes UP.
