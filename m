Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A562B2E1F
	for <lists+linux-pm@lfdr.de>; Sat, 14 Nov 2020 16:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgKNPiy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Nov 2020 10:38:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35362 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgKNPix (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Nov 2020 10:38:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id k2so13667921wrx.2;
        Sat, 14 Nov 2020 07:38:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bGIWjARNGCjg4NP+VD6dyg4ApWY+eQPPEpsbecbmVBo=;
        b=tFvKmnzWEg1vVNn6aV89SJLG7QlW5I04TpR7Z/Z6IFTOy9aVO07VRwRs8I25D6nhGJ
         D0zXiTIVzdBFT5ug4LsQYie2m98F0EJs0xr0hbWY3r9n9idY2T8ptWme9EI3OpVk56do
         2Lq+TvSlqLlChi/nkuHeI3+U3FU3tKEye/ZQ+/CnqULIUVJoAWo3ZewcCGi7lhYA76yA
         LQe+8HtZwtbpj2VajQSJjXq6Jwt1To8KbubBUrgpa+18HOhgrWkvJT0XrSESAyRj9wo6
         poTtF38QHRbvCaMbjHc1F2zMFGGCxx8kDiYjkhnXIwI0xdB+BYhLcqMFqrUxAIWkhq/d
         rZkQ==
X-Gm-Message-State: AOAM533S9RLNhmiJzKDJ/zBHkSUquALyyZywtevm4Sl1xYHKf0hLMD99
        TSRXW5a9y5nP0BZw2pnoiGw=
X-Google-Smtp-Source: ABdhPJxJvYknJaUlxNiibFWrUy4cuh3/wj0hltEkjtmzWA6PtzjOdXhNljLDhmNynimSgflk1aBKLg==
X-Received: by 2002:a5d:690c:: with SMTP id t12mr9950928wru.405.1605368330328;
        Sat, 14 Nov 2020 07:38:50 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id y10sm15568325wru.94.2020.11.14.07.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 07:38:49 -0800 (PST)
Date:   Sat, 14 Nov 2020 16:38:47 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 04/26] memory: tegra20-emc: Add devfreq support
Message-ID: <20201114153847.GE4106@kozik-lap>
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201111011456.7875-5-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 11, 2020 at 04:14:34AM +0300, Dmitry Osipenko wrote:
> Add devfreq support to the Tegra20 EMC driver. Memory utilization
> statistics will be periodically polled from the memory controller and
> appropriate minimum clock rate will be selected by the devfreq governor.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/Kconfig       |  3 +-
>  drivers/memory/tegra/tegra20-emc.c | 90 ++++++++++++++++++++++++++++++
>  2 files changed, 92 insertions(+), 1 deletion(-)

Thanks, applied.

Best regards,
Krzysztof

