Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89BD8129D8F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2019 05:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfLXExc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Dec 2019 23:53:32 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:56276 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfLXExc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2019 23:53:32 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191224045329epoutp0431bea23c627a4fd93f6f11f4fd53c8b3~jNZU9Rt7V0151501515epoutp04j
        for <linux-pm@vger.kernel.org>; Tue, 24 Dec 2019 04:53:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191224045329epoutp0431bea23c627a4fd93f6f11f4fd53c8b3~jNZU9Rt7V0151501515epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577163209;
        bh=+MavX6V0fSjJ2hx2U3IVU9tdN5bV0kJVEfSN65G9Bag=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=C3heL7nl4UxijwnhEm1TPnHxnNf4iNHNYDkqqobLrMyt1gNY5OEI5lVOVXChtndHC
         0AMRy+Y7HZgrelIaJ9I8Xa6rlwPF/ZqxvXW/Fn71Ml4iSHYU63Y+hFY5g3VY5dfdJu
         HLDPzkw5YtQ9vNiheljskseuLp9isEvMyGBixfQE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191224045329epcas1p42a371233a0b53f54f5646bd87c540bda~jNZUfho-80985109851epcas1p4F;
        Tue, 24 Dec 2019 04:53:29 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47hkPV5kBrzMqYks; Tue, 24 Dec
        2019 04:53:18 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.ED.48019.CB9910E5; Tue, 24 Dec 2019 13:53:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191224045316epcas1p4b27534f3200f57fad70cf52c8c867f48~jNZIpAXjO0962409624epcas1p4X;
        Tue, 24 Dec 2019 04:53:16 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191224045316epsmtrp1aafafc08d5ce3dc89e9b3781b14c4840~jNZIoK0vQ2686226862epsmtrp1h;
        Tue, 24 Dec 2019 04:53:16 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-eb-5e0199bc809e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.83.06569.CB9910E5; Tue, 24 Dec 2019 13:53:16 +0900 (KST)
Received: from [10.113.221.211] (unknown [10.113.221.211]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191224045316epsmtip23aeb6e6c62cf0571538c300231d08c55~jNZIXRGaY2283022830epsmtip25;
        Tue, 24 Dec 2019 04:53:16 +0000 (GMT)
Subject: Re: [RFC PATCH v3 7/7] drm: exynos: mixer: Add interconnect support
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        b.zolnierkie@samsung.com, krzk@kernel.org
From:   Inki Dae <inki.dae@samsung.com>
Message-ID: <6e8aa13a-c831-a7ee-70d3-f6b08fe6fbc3@samsung.com>
Date:   Tue, 24 Dec 2019 13:56:51 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191220115653.6487-8-a.swigon@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHve/1vT6MdW8V5cgShUdMJkmxD6i7qDCXGfOyEanxn2XJwBf6
        Bg39lb4WlJj4E2Q4RbJsQjfUEOM6KoqFGcDKHOKvEamdhjEGQtQwQS3xR9GoUVseRv77nHO+
        J/d7zr2XIbU36ETGbHNJTpto4ei5qjMXlut0gXqUrz/RpsMjhysQPl13isL/PP2fwkd6+ih8
        MzJJ40Pn/DQOBlvU2Dv8iML+O/0UvtH5C42f7O9BuC7YReDmnmE1/m+nl8Z1P4zTaz8Q/E3f
        0cJQf4AWRvZdJoTWY9uF0+F2QjjQ1oSEJ/4lRvXXJWuKJdEkOZMkW6HdZLYVZXNfbir4vMCw
        Us/r+Cz8CZdkE61SNrcu16hbb7ZEfXNJpaLFHU0ZRVnmVuSscdrdLimp2C67sjnJYbI4shxp
        smiV3baitEK7dRWv16cbosLNJcUVD4KUo2fxlq6LncQOdCu+GjEMsJkwETBVo7mMlm1HcP5K
        iFaCxwhGx5uQEkwhqAqfVFWjuOmOszUvZgrnEPj3t8y0TCJ49WMHiqkWsLlQuatFFSvEs28Q
        9B7/jYoFJDuIIFDTS8VUNLsMar0jdIw1bA48O+xXx1gVzXc/7KVjDheyX0FvRFQkH8LV+rvT
        NuLYLLjy9P60nGQTYPDuEULhpbD7959JxepxNXSNfabwOhh4MEUovAAmLrepFU6E8ZrKGS6D
        sfCYSlnMNphq2KJgBoS8phiS7HI41blCESdDx8sGpBw6H8KR7ylFrYGqSq0i4eBSaAApDHD9
        WC2tsACNzQfUB1GyZ9ZYnlmjeGaN4nl/8FGkakKLJIdsLZJk3pE5+6r9aPpBp+J2FOjL7UYs
        g7h5mpYLc/K1lFgqb7V2I2BILl7jc6J8rcYkbi2XnPYCp9siyd3IEF16LZm4sNAe/R42VwFv
        SM/IyMCZ/EoDz3MJGuZ56BstWyS6pBJJckjOd30EE5e4A6FGo1jliu9I8/17sGFjDt+3wVK5
        rTDPeHF9sneIeHHoo9Hb9QnPfjVH8KtLPsOYr7zaMLBp6tuPF0+klD8Knv9Dur3azCy6lpfi
        GW5Nj5A3q/ZUDGz+dPSnOaVtIS5/8OoXfw+7BTaUpReHyppfT5rHy+75wnv/DBA1f+X1m0vm
        cSq5WORTSacsvgUkAgvi5gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCSvO6emYxxBi92CVjcn9fKaLFxxnpW
        i+tfnrNazD9yjtXiytf3bBbT925iszh/fgO7xYq7H1ktNj2+xmpxedccNovPvUcYLWac38dk
        sfbIXXaL240r2CxmTH7J5sDvsWlVJ5vHnWt72Dzudx9n8ti8pN5j47sdTB59W1YxenzeJBfA
        HsVlk5Kak1mWWqRvl8CV0frmPGvBEcmKfUd3MTUw3hPpYuTkkBAwkdjd/4uxi5GLQ0hgN6NE
        98rXQA4HUEJCYstWDghTWOLw4WKIkreMEo8bPzCC9AoL+Ei0NW1gAUmICPxnlHjYdgxsELPA
        LUaJpl1TwKrApj7q0wGx2QRUJSauuM8GYvMK2El8n7eJHcRmAYofensaLC4qECHxfPsNRoga
        QYmTM5+wgNicApYSJ768BqtnFlCX+DPvEjOELS5x68l8JghbXqJ562zmCYxCs5C0z0LSMgtJ
        yywkLQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgRHppbWDsYTJ+IPMQpwMCrx
        8EYcZIgTYk0sK67MPcQowcGsJMK7uogxTog3JbGyKrUoP76oNCe1+BCjNAeLkjivfP6xSCGB
        9MSS1OzU1ILUIpgsEwenVAOj390VKjyVmi86DMsul3snq1wsDXZda7WLUcsi6+jjuON/VdzC
        ODuktSfW/3DonWsmyHedx5i9Yn/atn8xxapLHQ60BuaZVRp2WrzbWW49cXtv+9JnzBXZ7Rq3
        d7SsWMl42Lwk4Lef9LNNaSy9UkueL+qS+heaKsqYrSASPMUmS/PuoU4XKyWW4oxEQy3mouJE
        AAReOPzIAgAA
X-CMS-MailID: 20191224045316epcas1p4b27534f3200f57fad70cf52c8c867f48
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191220120146eucas1p22a7b0457be4f378b113f67dc25f2eba7
References: <20191220115653.6487-1-a.swigon@samsung.com>
        <CGME20191220120146eucas1p22a7b0457be4f378b113f67dc25f2eba7@eucas1p2.samsung.com>
        <20191220115653.6487-8-a.swigon@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

19. 12. 20. 오후 8:56에 Artur Świgoń 이(가) 쓴 글:
> From: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> This patch adds interconnect support to exynos-mixer. The mixer works
> the same as before when CONFIG_INTERCONNECT is 'n'.
> 
> Co-developed-by: Artur Świgoń <a.swigon@samsung.com>
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_mixer.c | 71 +++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
> index 6cfdb95fef2f..a7e7240a055f 100644
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
> @@ -931,6 +933,40 @@ static void mixer_disable_vblank(struct exynos_drm_crtc *crtc)
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
> +	if (!ctx->soc_path)
> +		return;
> +
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
> +	bandwidth = bandwidth / 4 * 5;
> +
> +	dev_dbg(ctx->dev, "exynos-mixer: safe bandwidth %ld Bps\n", bandwidth);
> +	icc_set_bw(ctx->soc_path, Bps_to_icc(bandwidth), 0);
> +}
> +
>  static void mixer_atomic_begin(struct exynos_drm_crtc *crtc)
>  {
>  	struct mixer_context *ctx = crtc->ctx;
> @@ -982,6 +1018,7 @@ static void mixer_atomic_flush(struct exynos_drm_crtc *crtc)
>  	if (!test_bit(MXR_BIT_POWERED, &mixer_ctx->flags))
>  		return;
>  
> +	mixer_set_memory_bandwidth(crtc);
>  	mixer_enable_sync(mixer_ctx);
>  	exynos_crtc_handle_event(crtc);
>  }
> @@ -1029,6 +1066,7 @@ static void mixer_disable(struct exynos_drm_crtc *crtc)
>  	for (i = 0; i < MIXER_WIN_NR; i++)
>  		mixer_disable_plane(crtc, &ctx->planes[i]);
>  > +	mixer_set_memory_bandwidth(crtc);

Your intention is to set peak and average bandwidth to 0 at disabling mixer device?

Thanks,
Inki Dae
