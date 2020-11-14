Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29B02B2E16
	for <lists+linux-pm@lfdr.de>; Sat, 14 Nov 2020 16:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgKNPhZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Nov 2020 10:37:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38229 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgKNPhY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Nov 2020 10:37:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id p8so13637423wrx.5;
        Sat, 14 Nov 2020 07:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U4GcyUn4reH1qm14U6D1eRhiaxWlGAP1uylSgn09bAE=;
        b=N/dNGD5Z/TLitKz9aSHpXkP3GTYUVw+1W6Rq3hQWxfIP3GWvPY6EZOAxc2LUIqUky7
         6naKA3qcuYJ1143pHBzw5fy1lRDZAtZasmZLLGZWX/fDwO70TZaMVqovtKZFabaSgadG
         9NKi7TQ6/INnGxkfmOEZkQbglqJR0A5K6RGJjk/dckwwHsi1Y1lr9eqIuB9rb/HPHmzs
         eXKktF9QLHkXZHBvsJmRqX5zx5Xnmx2ONbiWIChUmVtIvQr4960ohozM4qwFy5KNTu49
         ffR39zacLh/iE2g+sm4+PG3mltAx7q0Ud22SqcQ69Wntf4cWc6dl1bbJ9EIJ5Nd5eHDP
         1zbQ==
X-Gm-Message-State: AOAM531ucxvVQmhGjQulXqwemcEWz3YzxtCNkha6qdVNachzvi/oC+i6
        IJ6eqISNt/rRGI3DLcw+7EA=
X-Google-Smtp-Source: ABdhPJw0mkO/QYUuAF08ih8ZearlCSBP/PG2yE8LFV+wCVkmqDw3ltyDZtGgD02ccVTSEWvcip2lhg==
X-Received: by 2002:adf:82cc:: with SMTP id 70mr9939588wrc.74.1605368242190;
        Sat, 14 Nov 2020 07:37:22 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id a18sm13182992wmm.22.2020.11.14.07.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 07:37:21 -0800 (PST)
Date:   Sat, 14 Nov 2020 16:37:19 +0100
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
Subject: Re: [PATCH v8 02/26] memory: tegra20-emc: Use
 dev_pm_opp_set_clkname()
Message-ID: <20201114153719.GB4106@kozik-lap>
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201111011456.7875-3-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 11, 2020 at 04:14:32AM +0300, Dmitry Osipenko wrote:
> The dev_pm_opp_get_opp_table() shouldn't be used by drivers, use
> dev_pm_opp_set_clkname() instead.
> 
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra20-emc.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)

Thanks, applied.

Best regards,
Krzysztof

