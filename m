Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE6012CE4D
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 10:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfL3Jf1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 04:35:27 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53002 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfL3Jf1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2019 04:35:27 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191230093525euoutp01cf222268f8121d6c57787c150b82839b~lHHMtW6390931709317euoutp01N
        for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2019 09:35:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191230093525euoutp01cf222268f8121d6c57787c150b82839b~lHHMtW6390931709317euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577698525;
        bh=Xypm1AJvMupF3z7nKOYeVDuwvHXqOAOdFl7YrwTD918=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cCcn6fejyXueb5UOEl5uzqv5Z2p0XgGZ0U8RwY4hNGAHFDvnetTQEoza6GiI9tgS3
         p85hSIIszSwoOfodTyVToyGy+XRTnT5BoHNRpfKU9FOEgasBBvNsc6AZJpBEbgfYqE
         +d6Aq2FeufUHHdeeNG2Z7pgMjImv5q0vVl2PVwnY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191230093525eucas1p27718806b19626b7b45579c53cd1f6948~lHHMWm6Uh2788427884eucas1p2H;
        Mon, 30 Dec 2019 09:35:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 59.09.60679.CD4C90E5; Mon, 30
        Dec 2019 09:35:25 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191230093524eucas1p171d0a5c805100c5cddc807a27c2f7657~lHHL8EVQj1988119881eucas1p1L;
        Mon, 30 Dec 2019 09:35:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191230093524eusmtrp2235b15ad248353efa1cbe6e829e56c25~lHHL2J17s0819408194eusmtrp2u;
        Mon, 30 Dec 2019 09:35:24 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-6f-5e09c4dc89c9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id ED.0F.08375.CD4C90E5; Mon, 30
        Dec 2019 09:35:24 +0000 (GMT)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20191230093523eusmtip1975ed3256410df9f51c198561a7c2d7d~lHHLE1W_J1785117851eusmtip1g;
        Mon, 30 Dec 2019 09:35:23 +0000 (GMT)
Message-ID: <43b0e5d3fc28c48e139c5fbc2120903d678904a0.camel@samsung.com>
Subject: Re: [RFC PATCH v3 7/7] drm: exynos: mixer: Add interconnect support
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     Inki Dae <inki.dae@samsung.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        b.zolnierkie@samsung.com, krzk@kernel.org
Date:   Mon, 30 Dec 2019 10:35:21 +0100
In-Reply-To: <6e8aa13a-c831-a7ee-70d3-f6b08fe6fbc3@samsung.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHObu7d3ejzesU/KG9HKgUpVaSBworCLqURAYRhForLyb5WLvq
        1IJsgfQgG67StlCzUPHtWqXDXjKzLF2hqGlm0Qul15gJZWm73oX99z3f3+/z/Z4DhybUvWQw
        nZaZzekztekaSiG9/ehn3+oxpzw52gy4tayZxENTn0hc4ewj8cCPbxQuvWujcMm4SYpdrhYZ
        rh1zk9j2bpDE/Y6rFPacdyJc5ronwY3OMRkePVlL4TLzBLXZj7XVnaHYV4MdFDt+rlvC3rxx
        gm392iZhi+11iPXYlu6S7VNsTOHS03I5fVTcAcXhopoBQucJzZu5/xYVIlPIWSSngYmBeuNr
        maDVTC2C6X6/s0jh1VMIjD0vKPHgQWA22ch/hKvyGSkOahC8N13ybX1E0NjehIQtJcNCYZeD
        EHQAEw9FxhapoClmE/SOTksEIJCZQPBh1jpPE8wIgo4LT+c7pEwYXHSfmaflXuLl8zmJ2L0K
        vvQUe5Nob4M//GkLEGyCWQanblkJIQcYtwxmH/YT4v5W6DB3+XQATHbbZaJeDHPtFb5MHj60
        j5MiXIjAVu30ARvgVd8vSigjmBXQ7IgS7S3w2dVKCjYwKhj+4i/eQQUlt0sJ0VbC6SK1KDXg
        uKISQQBj/aAvm4WqxmKZCYVaFt5i+e8tloXWSkTUoSAuh89I5fi1mZwhktdm8DmZqZGHsjJs
        yPvJns52T7Uhx++DnYihkWaRsqyUTlaT2lw+P6MTAU1oApUxifJktTJFm1/A6bP263PSOb4T
        hdBSTZByXdVEkppJ1WZzRzhOx+n/TSW0PLgQRZYq8jzteLnlprFa9WQPvRPlTz+eGfme+ybc
        PlESoTw+mRfWtTcpJetr9P5wyfo777NvLTJeDrLp3FV4ya+7caNV5epru10Gp/xHg2Eofq6O
        m9I1jFDXF4dYuURrcGxRyIXtdNiW8m0bwppidxyd8S+I8xgiXqYdsz9IyEl4NqyR8oe1a1YS
        el77F9SeV3VgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xu7p3jnDGGeyfJGOxccZ6VovrX56z
        Wsw/co7V4srX92wW0/duYrOYdH8Ci8X58xvYLVbc/chqsenxNVaLy7vmsFl87j3CaDHj/D4m
        i7VH7rJb3G5cwWYxY/JLNgd+j02rOtk87lzbw+Zxv/s4k8fmJfUeG9/tYPLo27KK0ePzJrkA
        9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jLbl
        V5gLPitW/N7/kLGBcYJ0FyMnh4SAicT5BWdYuxi5OIQEljJKnHu+ghUiISHxcf0NKFtY4s+1
        LjYQW0jgCaPErSYwm1fAQ6Lh6C5mEFtYwEeirWkDC4jNJmAvcfb2NyaQoSICrxglWid8YgZx
        mAXuMEo0fnwE1sEioCox5WMnmM0J1HHzwn8miDM+M0ocuLyeCSTBLKAp0br9NzvEGToSb0/1
        Aa3gAFotKPF3hzBEibxE89bZzBMYBWch6ZiFUDULSdUCRuZVjCKppcW56bnFhnrFibnFpXnp
        esn5uZsYgXG67djPzTsYL20MPsQowMGoxMM7YzpHnBBrYllxZe4hRgkOZiURXpMYzjgh3pTE
        yqrUovz4otKc1OJDjKZA/0xklhJNzgemkLySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp
        2ampBalFMH1MHJxSDYz5u11qb65Lln1++ym7vvzWlli1i10f3MvMNr1oXVRQ1j/ZfYXDozta
        t9ZHF/1bpHpP2DXSZ2dHKfPVk6ufbT+Q3bPJpd41favihY2xl+N3b7vRoXjn5rWHO7c8jq34
        t3Hdpj/3l7THGb37Vso6M/394/bYttjUtPS71+6eV1xWtPbK25oE9hXTlViKMxINtZiLihMB
        yMmhb+kCAAA=
X-CMS-MailID: 20191230093524eucas1p171d0a5c805100c5cddc807a27c2f7657
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191220120146eucas1p22a7b0457be4f378b113f67dc25f2eba7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191220120146eucas1p22a7b0457be4f378b113f67dc25f2eba7
References: <20191220115653.6487-1-a.swigon@samsung.com>
        <CGME20191220120146eucas1p22a7b0457be4f378b113f67dc25f2eba7@eucas1p2.samsung.com>
        <20191220115653.6487-8-a.swigon@samsung.com>
        <6e8aa13a-c831-a7ee-70d3-f6b08fe6fbc3@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Tue, 2019-12-24 at 13:56 +0900, Inki Dae wrote:
> Hi,
> 
> 19. 12. 20. 오후 8:56에 Artur Świgoń 이(가) 쓴 글:
> > From: Marek Szyprowski <m.szyprowski@samsung.com>
> > 
> > This patch adds interconnect support to exynos-mixer. The mixer works
> > the same as before when CONFIG_INTERCONNECT is 'n'.
> > 
> > Co-developed-by: Artur Świgoń <a.swigon@samsung.com>
> > Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  drivers/gpu/drm/exynos/exynos_mixer.c | 71 +++++++++++++++++++++++++--
> >  1 file changed, 66 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
> > index 6cfdb95fef2f..a7e7240a055f 100644
> > --- a/drivers/gpu/drm/exynos/exynos_mixer.c
> > +++ b/drivers/gpu/drm/exynos/exynos_mixer.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/component.h>
> >  #include <linux/delay.h>
> >  #include <linux/i2c.h>
> > +#include <linux/interconnect.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> >  #include <linux/kernel.h>
> > @@ -97,6 +98,7 @@ struct mixer_context {
> >  	struct exynos_drm_crtc	*crtc;
> >  	struct exynos_drm_plane	planes[MIXER_WIN_NR];
> >  	unsigned long		flags;
> > +	struct icc_path		*soc_path;
> >  
> >  	int			irq;
> >  	void __iomem		*mixer_regs;
> > @@ -931,6 +933,40 @@ static void mixer_disable_vblank(struct exynos_drm_crtc *crtc)
> >  	mixer_reg_writemask(mixer_ctx, MXR_INT_EN, 0, MXR_INT_EN_VSYNC);
> >  }
> >  
> > +static void mixer_set_memory_bandwidth(struct exynos_drm_crtc *crtc)
> > +{
> > +	struct drm_display_mode *mode = &crtc->base.state->adjusted_mode;
> > +	struct mixer_context *ctx = crtc->ctx;
> > +	unsigned long bw, bandwidth = 0;
> > +	int i, j, sub;
> > +
> > +	if (!ctx->soc_path)
> > +		return;
> > +
> > +	for (i = 0; i < MIXER_WIN_NR; i++) {
> > +		struct drm_plane *plane = &ctx->planes[i].base;
> > +		const struct drm_format_info *format;
> > +
> > +		if (plane->state && plane->state->crtc && plane->state->fb) {
> > +			format = plane->state->fb->format;
> > +			bw = mode->hdisplay * mode->vdisplay *
> > +							drm_mode_vrefresh(mode);
> > +			if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> > +				bw /= 2;
> > +			for (j = 0; j < format->num_planes; j++) {
> > +				sub = j ? (format->vsub * format->hsub) : 1;
> > +				bandwidth += format->cpp[j] * bw / sub;
> > +			}
> > +		}
> > +	}
> > +
> > +	/* add 20% safety margin */
> > +	bandwidth = bandwidth / 4 * 5;
> > +
> > +	dev_dbg(ctx->dev, "exynos-mixer: safe bandwidth %ld Bps\n", bandwidth);
> > +	icc_set_bw(ctx->soc_path, Bps_to_icc(bandwidth), 0);
> > +}
> > +
> >  static void mixer_atomic_begin(struct exynos_drm_crtc *crtc)
> >  {
> >  	struct mixer_context *ctx = crtc->ctx;
> > @@ -982,6 +1018,7 @@ static void mixer_atomic_flush(struct exynos_drm_crtc *crtc)
> >  	if (!test_bit(MXR_BIT_POWERED, &mixer_ctx->flags))
> >  		return;
> >  
> > +	mixer_set_memory_bandwidth(crtc);
> >  	mixer_enable_sync(mixer_ctx);
> >  	exynos_crtc_handle_event(crtc);
> >  }
> > @@ -1029,6 +1066,7 @@ static void mixer_disable(struct exynos_drm_crtc *crtc)
> >  	for (i = 0; i < MIXER_WIN_NR; i++)
> >  		mixer_disable_plane(crtc, &ctx->planes[i]);
> >  > +	mixer_set_memory_bandwidth(crtc);
> 
> Your intention is to set peak and average bandwidth to 0 at disabling mixer device?

Yes. In general, setting the requested bandwidth to zero means "do not override
the devfreq setting" because only constraints of type DEV_PM_QOS_MIN_FREQUENCY
are used (cf. patch 05 of this series). I will make sure to reflect that in the
commit message.

Moreover, this RFC does not really make use of the peak bandwidth (yet). It is
set to zero in this patch and ignored in patch 05 (cf. exynos_bus_icc_set()).
Only the average bandwidth is translated to a minimum frequency constraint,
overriding devfreq if necessary.

A possible modification to mixer_set_memory_bandwidth() could be:
- bandwidth = bandwidth / 4 * 5;
+ peak_bandwidth = bandwidth / 4 * 5;
in mixer_set_memory_bandwidth() plus some additional logic in exynos_bus_icc_set().

Best regards,
-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


