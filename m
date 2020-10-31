Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB512A1773
	for <lists+linux-pm@lfdr.de>; Sat, 31 Oct 2020 13:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgJaMrW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sat, 31 Oct 2020 08:47:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33696 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgJaMrW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Oct 2020 08:47:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id b8so9354247wrn.0;
        Sat, 31 Oct 2020 05:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+gL7Op3KIBpBphNR+C9mEgS569nJZM4vxaFbpSVbwWo=;
        b=e1CO85PondYAc5m6el2DSQmEwZHO1oDLOLBz2z5xYIEvTaNlbZ/CPoYjgfysCqqqJ7
         61kFMUF/ravAji82JG9Apl+8HPUcN4PuIGtaRW8HsC6DDM2+edjTRBZHNONm381itmcP
         JfkumnSZXSUtGrjw8Y6DJWOLOhXjFYAkeGqAahxxRa2hZcroXfDS9E5u3RUvVvqC7c4V
         s/ER6xw9t1rkyDrxpN/C7M2z6Kro1LN4Ql1OUhQMB0Ii6oYDAUBaQNQi/Yo7A5pEmIZG
         jxCByusNC3LIcUKK1dbfjT9eq9fSbumzao4zV07OLbEvxWTxEO8fSMEG6HgXV37kQhDu
         iufA==
X-Gm-Message-State: AOAM530LJ7dgTN4fqmdAwTxWCFJ4FfW2fXM+/v9GsIdWtYnWTnO0QYJP
        Ycy+4Joa7NMiT9pnBNJoma8=
X-Google-Smtp-Source: ABdhPJw1A1ifmpqW7/JFaic2H98/NtqftCnqT8ZvJegvWDAd8dPgFRVj/GRP3niiuT1wpM0cIHmxrA==
X-Received: by 2002:adf:9204:: with SMTP id 4mr1764068wrj.241.1604148440070;
        Sat, 31 Oct 2020 05:47:20 -0700 (PDT)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id 4sm14367078wrp.58.2020.10.31.05.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 05:47:18 -0700 (PDT)
Date:   Sat, 31 Oct 2020 13:47:17 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     georgi.djakov@linaro.org, cw00.choi@samsung.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 6/6] drm: exynos: mixer: Add interconnect support
Message-ID: <20201031124717.GE9399@kozik-lap>
References: <20201030125149.8227-1-s.nawrocki@samsung.com>
 <CGME20201030125308eucas1p14ae969ae1d5549d422c478aa54d3311e@eucas1p1.samsung.com>
 <20201030125149.8227-7-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201030125149.8227-7-s.nawrocki@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 30, 2020 at 01:51:49PM +0100, Sylwester Nawrocki wrote:
> This patch adds interconnect support to exynos-mixer. The mixer works
> the same as before when CONFIG_INTERCONNECT is 'n'.
> 
> For proper operation of the video mixer block we need to ensure the
> interconnect busses like DMC or LEFTBUS provide enough bandwidth so
> as to avoid DMA buffer underruns in the mixer block. I.e we need to
> prevent those busses from operating in low perfomance OPPs when
> the mixer is running.
> In this patch the bus bandwidth request is done through the interconnect
> API, the bandwidth value is calculated from selected DRM mode, i.e.
> video plane width, height, refresh rate and pixel format.
> 
> The bandwidth setting is synchronized with VSYNC when we are switching
> to lower bandwidth. This is required to ensure enough bandwidth for
> the device since new settings are normally being applied in the hardware
> synchronously with VSYNC.
> 
> Co-developed-by: Artur Świgoń <a.swigon@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v7:
>  - fixed incorrect setting of the ICC bandwidth when the mixer is
>    disabled, now the bandwidth is set explicitly to 0 in such case.
> 
> Changes for v6:
>  - the icc_set_bw() call is now only done when calculated value for
>    a crtc changes, this avoids unnecessary calls per each video frame
>  - added synchronization of the interconnect bandwidth setting with
>    the mixer VSYNC in order to avoid buffer underflow when we lower
>    the interconnect bandwidth when the hardware still operates with
>    previous mode settings that require higher bandwidth. This fixed
>    IOMMU faults observed e.g. during switching from two planes to
>    a single plane operation.
> 
> Changes for v5:
>  - renamed soc_path variable to icc_path
> ---
>  drivers/gpu/drm/exynos/exynos_mixer.c | 146 ++++++++++++++++++++++++++++++++--
>  1 file changed, 138 insertions(+), 8 deletions(-)


[...]

> @@ -1223,19 +1330,33 @@ static int mixer_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	const struct mixer_drv_data *drv;
>  	struct mixer_context *ctx;
> +	struct icc_path *path;
>  	int ret;
>  
> +	/*
> +	 * Returns NULL if CONFIG_INTERCONNECT is disabled.

You could add here:
or if "interconnects" property does not exist.

Best regards,
Krzysztof
