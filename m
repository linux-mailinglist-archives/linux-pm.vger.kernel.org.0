Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0622B2E2B
	for <lists+linux-pm@lfdr.de>; Sat, 14 Nov 2020 16:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgKNPlj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Nov 2020 10:41:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46891 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgKNPlj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Nov 2020 10:41:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id d12so13601832wrr.13;
        Sat, 14 Nov 2020 07:41:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M/dyPhuPN1ylbbCL1nqjLjRIL2BGGv8TuzcmItQtAuY=;
        b=Y2NyBFT9kZ7AlsSWeRbH4fIQEYiD6U/qbnYMxkn35VV/nZYXHZc/yKDmGvDRM2rUKy
         YaISgkhwTCBUt5gxaSASgbvRqhii6YYnVU+ZkFiLbl8uNxQMAGF6IJVXxT8M+wInslLM
         8jqn0mHsd11kEnvfxQAe+mWzIpYgXr7R++GDoz7YBKvbOTNwE3qmiUNTqI+7M1UUcbXY
         XFo/rdZDDcmW5YHGBUzz4/Z0wyneOFl65up2lmG1FKDIKMXRb1SPNl7smNtqJvhzMG3V
         W7wqy6ViXOa18OJxd7Bm3uKakZcfQGRP7jr+B0fUWzwfr1sbui7eFHRJ0JedRDjpZplf
         /UBg==
X-Gm-Message-State: AOAM530LU6fWbGnyWSxnjUkXAjJQZguPqFxKeP6j+AsOIJWv+6v3WntW
        kB0t2wV2/4EfaI61bGkTFwE=
X-Google-Smtp-Source: ABdhPJxMdLC6s1dYf9/3LViJKERBHe9LMFojMg41WquQy+ijj5ielzyRoKNOocoUGVSnkHUHHT/eZg==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr9985338wrn.212.1605368496352;
        Sat, 14 Nov 2020 07:41:36 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id h62sm15335452wrh.82.2020.11.14.07.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 07:41:34 -0800 (PST)
Date:   Sat, 14 Nov 2020 16:41:33 +0100
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
Subject: Re: [PATCH v8 07/26] memory: tegra30-emc: Make driver modular
Message-ID: <20201114154133.GA14208@kozik-lap>
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-8-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201111011456.7875-8-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 11, 2020 at 04:14:37AM +0300, Dmitry Osipenko wrote:
> Add modularization support to the Tegra30 EMC driver, which now can be
> compiled as a loadable kernel module.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/Kconfig       |  2 +-
>  drivers/memory/tegra/mc.c          |  3 +++
>  drivers/memory/tegra/tegra30-emc.c | 17 ++++++++++++-----

Thanks, applied.

Best regards,
Krzysztof

