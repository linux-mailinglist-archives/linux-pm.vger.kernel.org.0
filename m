Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D2F2A9BF3
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 19:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgKFSXx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 13:23:53 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:41347 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgKFSXx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 13:23:53 -0500
Received: by mail-ej1-f67.google.com with SMTP id cw8so3224100ejb.8;
        Fri, 06 Nov 2020 10:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VrtMo5QUA/nKWHwa7QShX9sskM8VzXmSoKz6iFABVM4=;
        b=VyarLe8yvVTEfHTz60IsFuHY5d45LTCjYwlLyp4KFRaOhI5/hjzYZJ3WzuIENDVh45
         vH8vcFFNvq2aKMUpJqauQKAdWcMN7L1gbFgeA7u4kbO8TFFXy+hHG29+xxVZbrqSAVp3
         +5BxfGhiPRLxlCGdkDvEIEbTwfFtVvdm6u7+2vDvWFLRXDz5hMbRDaXW290rNrH7KpHG
         sTjpLr0uNSmRyeoar5I7UZUm0tHLVOltmU2vCpNmzuxfjx+Nbs70mLfIdusXqq2iEp5b
         FEIhXrcHz3lhc7xthTkdH4qPILKKrm/5NkXEhmZw6dnZslD1Sib4t2T8eJjfvc+btb68
         JsVg==
X-Gm-Message-State: AOAM530mz5nvZYiV+bF8GeF3HrigOFlKXYbR9dAGbNxoPT4MC+QG+8ra
        ecoJO3xK+s0rtykTSpezuFE=
X-Google-Smtp-Source: ABdhPJz6AB5PsPwDbMjubDY9JAv0hJ/crPkYae53nwFImXuU12ckKjyRf/L3QnKSb1WD92Gg1VLlVw==
X-Received: by 2002:a17:906:e15:: with SMTP id l21mr3438494eji.509.1604687030667;
        Fri, 06 Nov 2020 10:23:50 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id m27sm1476520eji.64.2020.11.06.10.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:23:49 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:23:47 +0100
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 01/47] clk: tegra: Export Tegra20 EMC kernel symbols
Message-ID: <20201106182347.GA65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:37PM +0300, Dmitry Osipenko wrote:
> We're going to modularize Tegra EMC drivers and some of the EMC-clock
> driver symbols need to be exported, let's export them.
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clk/tegra/clk-tegra20-emc.c | 3 +++
>  1 file changed, 3 insertions(+)

Thanks, applied.

I'll keep all Tegra patches on separate branch and I can provide
a stable tag for other tree. Just let me know.

Best regards,
Krzysztof

