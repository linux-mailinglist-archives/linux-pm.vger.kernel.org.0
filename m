Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDC2337A7D
	for <lists+linux-pm@lfdr.de>; Thu, 11 Mar 2021 18:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCKRJh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 12:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhCKRJb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Mar 2021 12:09:31 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25F8C061574;
        Thu, 11 Mar 2021 09:09:30 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 184so3095632ljf.9;
        Thu, 11 Mar 2021 09:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JZLX+51qCO+D0XtLUqXKV4U4rxkLlmXtaKMDR2qBmkI=;
        b=N8yEpV2wJdxl0mTU0lt9qDm3UUS6E2LjfFu7HiF+vjL1m+V47I3fi/h+7mYKW4orlx
         v36LOjufIIme1ynswKfS/pLVgdBJaL5ekTD6hyL6+6lTs3Gwh6cZ4X/iIx6O8C0FNk5j
         /oLch8CdtaWqkRE/rvrw7GOVSgjTNcvGzjDkPhETP3GTvjJ0hYEockwPHerLj7LWNAMn
         0ew4PS1CwxeTG76i3J3gVSbethXjj1sBkcAnPbTy40CpE5nIDewSTjWngDo7yQjXh0Df
         I//6R0/SVLWzBqvub2UmYFtMAiwphF0JA26yjVb/s1s39TBS28Ks6Kpipc2aoBFnLaNv
         FclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JZLX+51qCO+D0XtLUqXKV4U4rxkLlmXtaKMDR2qBmkI=;
        b=AFoq+J7lso2ztnyBVo/PVnug2r/akZNi4lSxi7qeMVpagRyrGmeJRKbowbenSfcyZM
         ioGRVFbo6k04+uGbggNAAmGqXWQ93w+vRuVQ4u5L1Z4w2vy0wRh3k/9DBlC2tD4kZgny
         nf05WGoRWshJ4XbcYWVkpw8CfJkpdznb3jmq2u5Zr5tv7dWA314I36TvLM2I1i1VuzI8
         QNWbNc3XhW7viU0JA4Dn8nmSNsYV7kGkiaJu2CIBTn0IM2zaYpdqvORlphHFe1dCijom
         GIVj8dgRgklkQCh1sFPOwq7ADDfHJgMB3rs+gJwKVTsXTURI5OUQ8Uxh2zUWZypdY164
         wrLQ==
X-Gm-Message-State: AOAM531AviJ3i4GYFtPIfG54Gdnt1D3skgXgOjwIO8ttBx3LpG/2klMx
        eFBG3wbKcxQjiRFexFdTp1I=
X-Google-Smtp-Source: ABdhPJzxuJ5tEZpY6/cDEv5+DNkGhimlDj9cfTSIHFaolLmiEVy/HtDkNFvkyOjjwJxZ5fJTQIeidQ==
X-Received: by 2002:a2e:9ad0:: with SMTP id p16mr5496097ljj.414.1615482569201;
        Thu, 11 Mar 2021 09:09:29 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id y22sm995715lfg.133.2021.03.11.09.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 09:09:28 -0800 (PST)
Subject: Re: [PATCH v14 0/2] Add memory bandwidth management to NVIDIA Tegra
 DRM driver
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20210311170606.7543-1-digetx@gmail.com>
Message-ID: <be8ed07b-3301-f64f-a599-9bba40d42288@gmail.com>
Date:   Thu, 11 Mar 2021 20:09:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210311170606.7543-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

11.03.2021 20:06, Dmitry Osipenko пишет:
> This series adds memory bandwidth management to the NVIDIA Tegra DRM driver,
> which is done using interconnect framework. It fixes display corruption that
> happens due to insufficient memory bandwidth.
> 
> Changelog:
> 
> v14: - Made improvements that were suggested by Michał Mirosław to v13:
> 
>        - Changed 'unsigned int' to 'bool'.
>        - Renamed functions which calculate bandwidth state.
>        - Reworked comment in the code that explains why downscaled plane
>          require higher bandwidth.
>        - Added round-up to bandwidth calculation.
>        - Added sanity checks of the plane index and fixed out-of-bounds
>          access which happened on T124 due to the cursor plane index.
> 
> v13: - No code changes. Patches missed v5.12, re-sending them for v5.13.
> 
> Dmitry Osipenko (2):
>   drm/tegra: dc: Support memory bandwidth management
>   drm/tegra: dc: Extend debug stats with total number of events
> 
>  drivers/gpu/drm/tegra/Kconfig |   1 +
>  drivers/gpu/drm/tegra/dc.c    | 362 ++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/tegra/dc.h    |  19 ++
>  drivers/gpu/drm/tegra/drm.c   |  14 ++
>  drivers/gpu/drm/tegra/hub.c   |   3 +
>  drivers/gpu/drm/tegra/plane.c | 127 ++++++++++++
>  drivers/gpu/drm/tegra/plane.h |  15 ++
>  7 files changed, 541 insertions(+)
> 

Michał, please let me know if v14 looks good to you. I'll appreciate
yours r-b, thanks in advance.
