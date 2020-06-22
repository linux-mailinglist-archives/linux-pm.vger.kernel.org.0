Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D01203DB4
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 19:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgFVRUc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 13:20:32 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:33784 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729850AbgFVRUc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2020 13:20:32 -0400
Received: by mail-ej1-f65.google.com with SMTP id n24so18833673ejd.0;
        Mon, 22 Jun 2020 10:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jarz4soNYdNCTWcFh9oE63kyvCyOgjLwGQ/DSDrU5TA=;
        b=NbjLFjTqPrHPX5y6IFWGwtybYFeTdS3dhO8kuhOtaBeSx/phKXOIyGiIi6D/6Ti0em
         9OOify57O8euI+pOtaMg+rj5caiuB/8pvreTb/wDMKPK4b4L2c3B/Rhhe7vlv8fNrhEu
         G13qJOk3tjIRUkrp90WB+L6OsWpyyPbR5I33z5RFObs07fVQgjgtj6nElanuSPlDOgHn
         2Vt9BoxA/qxLYHHhzKUf9aDI0BejuNdiH40bUDYIUC3nQeXvhoQg0NSzg7Q8FUtZ/eIE
         2Y/znqHHOKL4/PKmZMjQV4fSyas6+AFQNHCmHClCAZRUyNx9yGzL8qgYo0XvcQl1sagY
         mlJQ==
X-Gm-Message-State: AOAM531mRWp96m+LqZA8vxquTAe9j81pLtB/neCVTrSg5b4iicJMOHCq
        Nmcr4X3zf8Cym/DgUJUe2l4f5TFB
X-Google-Smtp-Source: ABdhPJwzxTwfTjFxeq+MB+Nqd/xTAUpAhhoNhv9wr3u8MhzbO1NON9G9JC1z87Ulh8kSZ/cFJVfp0Q==
X-Received: by 2002:a17:906:9381:: with SMTP id l1mr17036497ejx.380.1592846430485;
        Mon, 22 Jun 2020 10:20:30 -0700 (PDT)
Received: from kozik-lap ([194.230.155.235])
        by smtp.googlemail.com with ESMTPSA id q3sm13106128eds.0.2020.06.22.10.20.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 10:20:29 -0700 (PDT)
Date:   Mon, 22 Jun 2020 19:20:26 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 3/4] ARM: exynos_defconfig: Enable big.LITTLE cpuidle
 driver
Message-ID: <20200622172026.GC4174@kozik-lap>
References: <20200616081230.31198-1-m.szyprowski@samsung.com>
 <CGME20200616081250eucas1p2de7110898dad050866d78cb5d5120422@eucas1p2.samsung.com>
 <20200616081230.31198-4-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616081230.31198-4-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 16, 2020 at 10:12:29AM +0200, Marek Szyprowski wrote:
> Enable big.LITTLE cpuidle driver, which can be used on Exynos-based
> Peach Pit/Pi Chromebooks.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)

I guess this should be enabled after adjusting the compatibles
in patch 2/4? If yes, then it will have to wait.

Best regards,
Krzysztof

> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 374fbff8eaa6..c928bc710c48 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -28,6 +28,7 @@ CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
>  CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
>  CONFIG_CPUFREQ_DT=y
>  CONFIG_CPU_IDLE=y
> +CONFIG_ARM_BIG_LITTLE_CPUIDLE=y
>  CONFIG_ARM_EXYNOS_CPUIDLE=y
>  CONFIG_VFP=y
>  CONFIG_NEON=y
> -- 
> 2.17.1
> 
