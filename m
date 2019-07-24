Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7A7736F8
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 20:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfGXSwk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 24 Jul 2019 14:52:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37810 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfGXSwk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 14:52:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so42524383wme.2;
        Wed, 24 Jul 2019 11:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3hQEInE7wPS7npsqDdyReFD8+DVG0G6gksarFiD+BUE=;
        b=p1QXjmSjibShYD8ZOl1TAGs1sAhM/9Y59m8s4PH/SNL0JLri/rNK6Ro6goiffhHlxA
         2WI7eVxfIJoCI8ZAQIluAteADtY9YRzlyOIaEz+c+1ekoDTtPb2dvn0gYiWMl1aE8qJ3
         eHnMEI3rjh/pZ3dKWzDBA8nfIF+wFFWxtgOJDAuREd2L4EYW8xGpSGxRUp8bO2XnJChJ
         vJ0lq7leBZu15G1ecw7uDvbuwY83/J9Z+i7BmVl0ifcWb7Z7UAcNIfBHrS55gEZkGx2U
         BqyIdDlrz3Xin5KC1U7TrEckWQ/Dw9hSHUPkqlqtTKfCMuNldTNlPnsdPrszjHKQi7YG
         DjIg==
X-Gm-Message-State: APjAAAUrbaHUuQcrFfPwL8KrSqmBYOybatflkWMpXNYOk9cnfgustWwj
        pDTtr0zCbU1KSsCfei1cTbA=
X-Google-Smtp-Source: APXvYqybZTUdLFKKpdj8xlUt1rpHKS6FMa+wFWKprezrQieSHRxtcvXpOkuvDUOeXbkAfzPmH5YXgQ==
X-Received: by 2002:a05:600c:10ce:: with SMTP id l14mr73562275wmd.118.1563994357830;
        Wed, 24 Jul 2019 11:52:37 -0700 (PDT)
Received: from kozik-lap ([194.230.155.239])
        by smtp.googlemail.com with ESMTPSA id w24sm37230033wmc.30.2019.07.24.11.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 11:52:36 -0700 (PDT)
Date:   Wed, 24 Jul 2019 20:52:34 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: Re: [RFC PATCH 11/11] drm: exynos: mixer: Add interconnect support
Message-ID: <20190724185234.GB14346@kozik-lap>
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
 <CGME20190723122029eucas1p2915f536d9ef43a7bd043a878a553439f@eucas1p2.samsung.com>
 <20190723122016.30279-12-a.swigon@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190723122016.30279-12-a.swigon@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 23, 2019 at 02:20:16PM +0200, Artur Świgoń wrote:
> From: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> This patch adds interconnect support to exynos-mixer. Please note that the
> mixer works the same as before when CONFIG_INTERCONNECT is 'n'.
> 
> Co-developed-by: Artur Świgoń <a.swigon@partner.samsung.com>
> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_mixer.c | 68 +++++++++++++++++++++++++--
>  1 file changed, 63 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
> index 7b24338fad3c..fb763854b300 100644
> --- a/drivers/gpu/drm/exynos/exynos_mixer.c
> +++ b/drivers/gpu/drm/exynos/exynos_mixer.c
> @@ -13,6 +13,7 @@
>  #include <linux/component.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> +#include <linux/interconnect.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
> @@ -97,6 +98,7 @@ struct mixer_context {
>  	struct exynos_drm_crtc	*crtc;
>  	struct exynos_drm_plane	planes[MIXER_WIN_NR];
>  	unsigned long		flags;
> +	struct icc_path		*soc_path;
>  
>  	int			irq;
>  	void __iomem		*mixer_regs;
> @@ -931,6 +933,37 @@ static void mixer_disable_vblank(struct exynos_drm_crtc *crtc)
>  	mixer_reg_writemask(mixer_ctx, MXR_INT_EN, 0, MXR_INT_EN_VSYNC);
>  }
>  
> +static void mixer_set_memory_bandwidth(struct exynos_drm_crtc *crtc)
> +{
> +	struct drm_display_mode *mode = &crtc->base.state->adjusted_mode;
> +	struct mixer_context *ctx = crtc->ctx;
> +	unsigned long bw, bandwidth = 0;
> +	int i, j, sub;
> +

Early exit if !ctx->soc_path, no need to figure out the bandwidth.
Optionally check it before calling mixer_set_memory_bandwidth() - should
not hurt readability.

> +	for (i = 0; i < MIXER_WIN_NR; i++) {
> +		struct drm_plane *plane = &ctx->planes[i].base;
> +		const struct drm_format_info *format;
> +
> +		if (plane->state && plane->state->crtc && plane->state->fb) {
> +			format = plane->state->fb->format;
> +			bw = mode->hdisplay * mode->vdisplay *
> +							drm_mode_vrefresh(mode);
> +			if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> +				bw /= 2;
> +			for (j = 0; j < format->num_planes; j++) {
> +				sub = j ? (format->vsub * format->hsub) : 1;
> +				bandwidth += format->cpp[j] * bw / sub;
> +			}
> +		}
> +	}
> +
> +	/* add 20% safety margin */
> +	bandwidth = 5UL * bandwidth / 4;
> +
> +	pr_info("exynos-mixer: safe bandwidth %ld Bps\n", bandwidth);

dev_dbg()

Best regards,
Krzysztof


