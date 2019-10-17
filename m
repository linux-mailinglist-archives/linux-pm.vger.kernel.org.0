Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88720DA3DA
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 04:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404255AbfJQCd7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 22:33:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43192 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392062AbfJQCd4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 22:33:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so594065pfo.10
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 19:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UJq/CVYJX0RnlIw74E+XHFRNzzyQAISbDxaoIMcdf0U=;
        b=nSZ2sD+r5thqiPHHfEK4zoSvn2SUHL3rmOfAda5L1xs6rsVyFp7G/PpAqq2TkCjxLN
         tcY8KFTw0MstjE2/na7h/RwYWi4aP0bYBJDlXwolUxKQS0SCF9rAf5YqUhyZVl0r8nQe
         tkFV0BY2md8wLeyJRHo9/VtZugu95XOKkGUTu8OlpIr0lrxmXgJPyI9/HGdWV29kUUiH
         F7upjYJYWTik7zA1c1xui2TWU+KUlub3MPd0bAmAYyeccFIP0sxuy7OxfsV4p3EQHWGd
         FiY+dg/AcKTRJ3OrrvyGXC2hIrXcwA4B2h+esHVbZlOQWnebnk6U0Q0SEFm9v9/r98bN
         upZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UJq/CVYJX0RnlIw74E+XHFRNzzyQAISbDxaoIMcdf0U=;
        b=KXETU6w4P7El0IZbZ2ZFKXdTcIC77P5V3rp5CQDLBgNoMxmUPIbQgdbvXa1pku7+r3
         y6mCdGEXqa8W/1fplyLMP8VAoNtgAHL8gpaCfXk5vsJRkDYJ5RUk4xnMit3YzbKDYXcv
         nAc1cPE1x3/8PWY8nRuWcrumzs90trubfXKCY4DOIdLlDY4DuOwuKN+pdokOtU0RpEtm
         n28f2dSHouPTGGaLmeSW0lye+TRtoZEYqZk9Riypygj2Ks4BP2Dc8VNxPQHO3mm6w9tP
         f9HLfiURMpb7GLJUQXt57nQNHO6cbPG2uhFMNumWU8uy38eeaznDyCvzXp/8d80cEKYU
         WaHQ==
X-Gm-Message-State: APjAAAVUXgYwfo67dV/URq8QRzkqPYQ76M6vUHhj53q4QXhTTzRe1J5L
        WrYgNjJeD3ebZutqT1iulf9Pug==
X-Google-Smtp-Source: APXvYqzCPZ/OrFSFpK9QWsauqiMWWRX3uUKle/8f4WUwPdjGLQF/szLF/2a3hyZDEr1+PbwXY3aNhA==
X-Received: by 2002:a17:90a:33a7:: with SMTP id n36mr1275383pjb.53.1571279634944;
        Wed, 16 Oct 2019 19:33:54 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id j10sm467532pfn.128.2019.10.16.19.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 19:33:54 -0700 (PDT)
Date:   Thu, 17 Oct 2019 08:03:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/17] cpufreq: tegra20: Use generic cpufreq-dt driver
 (Tegra30 supported now)
Message-ID: <20191017023352.dm5xj5ikh4lj6f56@vireshk-i7>
References: <20191015211618.20758-1-digetx@gmail.com>
 <20191015211618.20758-8-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015211618.20758-8-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-10-19, 00:16, Dmitry Osipenko wrote:
> Re-parenting to intermediate clock is supported now by the clock driver
> and thus there is no need in a customized CPUFreq driver, all that code
> is common for both Tegra20 and Tegra30. The available CPU freqs are now
> specified in device-tree in a form of OPPs, all users should update their
> device-trees.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/Kconfig.arm          |   4 +-
>  drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
>  drivers/cpufreq/tegra20-cpufreq.c    | 236 ++++++---------------------
>  3 files changed, 55 insertions(+), 187 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
