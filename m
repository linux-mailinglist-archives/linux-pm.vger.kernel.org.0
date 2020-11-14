Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142802B2E2F
	for <lists+linux-pm@lfdr.de>; Sat, 14 Nov 2020 16:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgKNPmc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Nov 2020 10:42:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42499 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgKNPmc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Nov 2020 10:42:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id l1so13615722wrb.9;
        Sat, 14 Nov 2020 07:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PrO8zrgJ3gvBSUp+SweUVPp30kkZs1tQ5BhIHJdVJfo=;
        b=H28fxNLPcPHok5WNxdLKjRnDmiMHupkAKiWJ8CmEZen4wdftUVuqIsjgVEYcvci9bd
         aPEUIrYa+qkrysq++rGacaPIY5ZHomA6JNCssvOWrmKA8xqPTNpIDy/ah1kH3AMbLYHN
         LVktgrXygSnasONaps29PAkjM/uze4aUy768mOWcnsY4/S6W2bS6sS99axWSjuPaRicq
         PplfELUhwsUGWWetP85fEq1luQckJ6PHTsPn/wtVelebhr2MYVoS0iIc85GxSsmxtr1p
         OUqlr0GErJLLPrgpPruQeSwYrL+KT/sawsS9jJ/9H+AAiN/C+UPzxWIVFs3f4joM2cJA
         OWSQ==
X-Gm-Message-State: AOAM531dxP3axbvSWS1wFMStLkLi62IoR/TOOztBD8YO6cUYxGqRRzdc
        HceuOdSSrKmlA+HFzlS/pzY=
X-Google-Smtp-Source: ABdhPJxsixStRZpfu+ROKa9+agmNLFBb2E78IpyswBNwtmauBjIC3Y9W+nEtEHk/WiAPf5usW7YVXw==
X-Received: by 2002:a5d:488b:: with SMTP id g11mr10702468wrq.210.1605368549958;
        Sat, 14 Nov 2020 07:42:29 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id o63sm13978032wmo.2.2020.11.14.07.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 07:42:28 -0800 (PST)
Date:   Sat, 14 Nov 2020 16:42:27 +0100
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
Subject: Re: [PATCH v8 08/26] memory: tegra30-emc: Continue probing if
 timings are missing in device-tree
Message-ID: <20201114154227.GB14208@kozik-lap>
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201111011456.7875-9-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 11, 2020 at 04:14:38AM +0300, Dmitry Osipenko wrote:
> EMC driver will become mandatory after turning it into interconnect
> provider because interconnect users, like display controller driver, will
> fail to probe using newer device-trees that have interconnect properties.
> Thus make EMC driver to probe even if timings are missing in device-tree.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra30-emc.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)

Thanks, applied 1-8.  For the rest I see discussion on going, so I guess
there will be a v9.

Best regards,
Krzysztof

