Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3087C396387
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 17:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbhEaPUO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 11:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbhEaPRV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 11:17:21 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8DEC035433;
        Mon, 31 May 2021 07:11:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id g17so11012799wrs.13;
        Mon, 31 May 2021 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AIjiXQgx7FWz0JkATZyG5fSCXhacRqcixlM/KFusILo=;
        b=gR4eIVe6z1B1V7G8FlLeEfNs7u6igycqfpCxQ75B9VubkFodmpUkOaoMCXQ4Zb9Ddx
         AR1APh8kdpq/ubV/6jpsIV6G7ZtlhbuFUdVqCgXGDoYRmFClNwlm18gTZBU9jnDs8kIG
         w2on7dDZx+1pazEnxVAvVpSRiDDxex9nUyKgeE93E64a/GfG8EUKa+K78BoLnNBzeP49
         kxnVqPE3N4uxt0EegLGqBswS4L21oVXyKqqITC+Su/GsORZViOtOzYCAk8Ivzob+Pmyz
         BxRKFuafOdL/IiI0zDyzhmSdb9M1XuXEL0kJUeti4WycJmJx8H0z6BHSAjiFKE/m3DG+
         uvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AIjiXQgx7FWz0JkATZyG5fSCXhacRqcixlM/KFusILo=;
        b=XE0maH0rTw7Oe3IPRqWCEpS1JgYYuG/4i6ZS2MLmMAkkkMqHBT+hnchs4Pgi+hJevV
         acKG9usIupaj9G2gvb+QAI/IUiR35ldZrlT2UfnuauQU2F0NB9SlLOkCkqJbqs2mXUhd
         saE4MDDbCu6fegls/mgzW//lYU2Yp/9Kns6lcCuEvTo9Uy0FOcwtB6R7pDBxVgG5W/ei
         8VqlM+OQUPr7RnQCreMS/1OF4etv7TCfSM9xW9ASw1V8TdNfc6iaww5qmQ3cIcM+bXyC
         UneJ/G4g3o1fvXuhTiqBnXtOu7GT2QZn5SLNyY0UbjNnjIKFvEtuHuN2lf8q5kfZQ/8K
         ORdA==
X-Gm-Message-State: AOAM532liEPh7N/F9q2ZQtLbui7dNjWCOAURGFRKdhUT5Epr7hyeJnFl
        2fLzhrb/lqLL4NB1uJ0EFd8=
X-Google-Smtp-Source: ABdhPJww9rCZ42lw+eUK5RSQAl0WzIrrsMfuz3xlNuebFpWzqMStHtaShdjJ1FOdW+v7tWxIXOFYFA==
X-Received: by 2002:a5d:4287:: with SMTP id k7mr9213415wrq.98.1622470307828;
        Mon, 31 May 2021 07:11:47 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id o6sm7328692wre.73.2021.05.31.07.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 07:11:46 -0700 (PDT)
Date:   Mon, 31 May 2021 16:13:21 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v17 1/2] drm/tegra: dc: Support memory bandwidth
 management
Message-ID: <YLTvAVvWY0KcOx8s@orome.fritz.box>
References: <20210510232709.1349-1-digetx@gmail.com>
 <20210510232709.1349-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qCPCAX+azklwClYR"
Content-Disposition: inline
In-Reply-To: <20210510232709.1349-2-digetx@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qCPCAX+azklwClYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 11, 2021 at 02:27:08AM +0300, Dmitry Osipenko wrote:
> Display controller (DC) performs isochronous memory transfers, and thus,
> has a requirement for a minimum memory bandwidth that shall be fulfilled,
> otherwise framebuffer data can't be fetched fast enough and this results
> in a DC's data-FIFO underflow that follows by a visual corruption.
>=20
> The Memory Controller drivers provide facility for memory bandwidth
> management via interconnect API. Let's wire up the interconnect API
> support to the DC driver in order to fix the distorted display output
> on T30 Ouya, T124 TK1 and other Tegra devices.
>=20
> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/tegra/Kconfig |   1 +
>  drivers/gpu/drm/tegra/dc.c    | 352 ++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/tegra/dc.h    |  14 ++
>  drivers/gpu/drm/tegra/drm.c   |  14 ++
>  drivers/gpu/drm/tegra/hub.c   |   3 +
>  drivers/gpu/drm/tegra/plane.c | 116 +++++++++++
>  drivers/gpu/drm/tegra/plane.h |  15 ++
>  7 files changed, 515 insertions(+)
>=20
[...]
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
[...]
> @@ -2011,7 +2143,215 @@ static void tegra_crtc_atomic_flush(struct drm_cr=
tc *crtc,
>  	value =3D tegra_dc_readl(dc, DC_CMD_STATE_CONTROL);
>  }
> =20
> +static bool tegra_plane_is_cursor(const struct drm_plane_state *state)
> +{
> +	const struct tegra_dc_soc_info *soc =3D to_tegra_dc(state->crtc)->soc;
> +	const struct drm_format_info *fmt =3D state->fb->format;
> +	unsigned int src_w =3D drm_rect_width(&state->src) >> 16;
> +	unsigned int dst_w =3D drm_rect_width(&state->dst);
> +
> +	if (state->plane->type !=3D DRM_PLANE_TYPE_CURSOR)
> +		return false;
> +
> +	if (soc->supports_cursor)
> +		return true;
> +
> +	if (src_w !=3D dst_w || fmt->num_planes !=3D 1 || src_w * fmt->cpp[0] >=
 256)
> +		return false;

Technically there could be some random overlay window that matches these
conditions and is erroneously detected as being a cursor. I wonder if we
should add a field to a plane that marks it as being used as cursor for
the cases where we don't support a hardware cursor.

[...]
> diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
> index 29f19c3c6149..db10af097033 100644
> --- a/drivers/gpu/drm/tegra/dc.h
> +++ b/drivers/gpu/drm/tegra/dc.h
> @@ -15,6 +15,8 @@
> =20
>  struct tegra_output;
> =20
> +#define TEGRA_DC_LEGACY_PLANES_NUM	7
> +
>  struct tegra_dc_state {
>  	struct drm_crtc_state base;
> =20
> @@ -23,6 +25,8 @@ struct tegra_dc_state {
>  	unsigned int div;
> =20
>  	u32 planes;
> +
> +	unsigned long plane_peak_bw[TEGRA_DC_LEGACY_PLANES_NUM];

Why can we not store this peak bandwidth value within the plane state? I
know that this isn't exactly per-plane data because it depends on the
state of other planes, but that doesn't really prevent the value to live
within the plane state. The plane state is, after all, part of the
global state, and hence any such state needs to be considered within the
context of that global atomic state.

I suppose that might make it a little bit more difficult to get at the
data, but I think the end result would be less confusing than having an
array here with potentially unused fields. It would also get rid of the
need to look up planes by their per-CRTC index.

>  };
> =20
>  static inline struct tegra_dc_state *to_dc_state(struct drm_crtc_state *=
state)
> @@ -33,6 +37,12 @@ static inline struct tegra_dc_state *to_dc_state(struc=
t drm_crtc_state *state)
>  	return NULL;
>  }
> =20
> +static inline const struct tegra_dc_state *
> +to_const_dc_state(const struct drm_crtc_state *state)
> +{
> +	return to_dc_state((struct drm_crtc_state *)state);
> +}
> +
>  struct tegra_dc_stats {
>  	unsigned long frames;
>  	unsigned long vblank;
> @@ -66,7 +76,9 @@ struct tegra_dc_soc_info {
>  	unsigned int num_overlay_formats;
>  	const u64 *modifiers;
>  	bool has_win_a_without_filters;
> +	bool has_win_b_vfilter_mem_client;
>  	bool has_win_c_without_vert_filter;
> +	bool plane_tiled_memory_bandwidth_x2;
>  };
> =20
>  struct tegra_dc {
> @@ -152,6 +164,8 @@ int tegra_dc_state_setup_clock(struct tegra_dc *dc,
>  			       struct drm_crtc_state *crtc_state,
>  			       struct clk *clk, unsigned long pclk,
>  			       unsigned int div);
> +void tegra_crtc_atomic_post_commit(struct drm_crtc *crtc,
> +				   struct drm_atomic_state *state);
> =20
>  /* from rgb.c */
>  int tegra_dc_rgb_probe(struct tegra_dc *dc);
> diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
> index d76bcb6c5622..a10513d7f2e0 100644
> --- a/drivers/gpu/drm/tegra/drm.c
> +++ b/drivers/gpu/drm/tegra/drm.c
> @@ -24,6 +24,7 @@
>  #include <asm/dma-iommu.h>
>  #endif
> =20
> +#include "dc.h"
>  #include "drm.h"
>  #include "gem.h"
> =20
> @@ -63,6 +64,17 @@ static const struct drm_mode_config_funcs tegra_drm_mo=
de_config_funcs =3D {
>  	.atomic_commit =3D drm_atomic_helper_commit,
>  };
> =20
> +static void tegra_atomic_post_commit(struct drm_device *drm,
> +				     struct drm_atomic_state *old_state)
> +{
> +	struct drm_crtc_state *old_crtc_state __maybe_unused;
> +	struct drm_crtc *crtc;
> +	unsigned int i;
> +
> +	for_each_old_crtc_in_state(old_state, crtc, old_crtc_state, i)
> +		tegra_crtc_atomic_post_commit(crtc, old_state);
> +}
> +
>  static void tegra_atomic_commit_tail(struct drm_atomic_state *old_state)
>  {
>  	struct drm_device *drm =3D old_state->dev;
> @@ -82,6 +94,8 @@ static void tegra_atomic_commit_tail(struct drm_atomic_=
state *old_state)
>  	} else {
>  		drm_atomic_helper_commit_tail_rpm(old_state);
>  	}
> +
> +	tegra_atomic_post_commit(drm, old_state);
>  }
> =20
>  static const struct drm_mode_config_helper_funcs
> diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
> index bfae8a02f55b..f1bbc5991854 100644
> --- a/drivers/gpu/drm/tegra/hub.c
> +++ b/drivers/gpu/drm/tegra/hub.c
> @@ -358,6 +358,9 @@ static int tegra_shared_plane_atomic_check(struct drm=
_plane *plane,
>  	struct tegra_dc *dc =3D to_tegra_dc(new_plane_state->crtc);
>  	int err;
> =20
> +	plane_state->peak_memory_bandwidth =3D 0;
> +	plane_state->avg_memory_bandwidth =3D 0;
> +

Since ICC isn't supported yet on Tegra186 and later, does it even make
sense to initialize these?

Thierry

--qCPCAX+azklwClYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC07v4ACgkQ3SOs138+
s6GGjhAAiGZK4l8fizM/LuWEruaWYR+N8fhxskHevsfd7OHuXkzxKyfl+pJ9MoSS
RkVGhtbDqq/wEUm0kZRKRqQl7EZxUCBWZwx0TRi0sJI5FR29hLlgW6UCGEbL8mn3
7wWXDeUbHavliTd+3KABmnzCLM/q60bgSAKPS33HWQeoIox7yxElTaNJEh1yJOaN
WDl+eZdAbgLEY5L2h3b/SwaIRZ2ar/rtMc3Ix2yv8SzTMRiHdqeY7aHl/IgjVpT8
7f8tf0a4hBteixEPKCSUe0fUCuhjdXuoI17vvGBJxEkP9hOwI9GkoLjFa4/WZiC9
n3N5NyaR7HK1XkT6NgOJ8XZEZkOtrrKgVgsiyUrT7mlnhlsl14/bRmpovOip/XwU
1Nqzuml0bHVWar2F/2eBHBca0SyKSisTMsUoSIGjJ4PTysccD36TiuOtfBo87LeS
UU1RXEIAmp+7TNmAJ7XudfwWk4afsWkPwxIacehXL6BSSGSM8a214nvTvY80WZiD
XVpQeMFYxUVp3JLiACwycwTwqZRg5ST2vArNjMhcaaiq19eyTzUwoh0GuPIkc5ne
ChrgnFLEf89h+64mk4BHCviULdaUvwFfgI7iwZ9Wp07ebe4zqm2zdN2EbMNy23aB
1AorQ09Z+QAFYVq0k84NDzWWWRCvFvYNP3gnT8brEt5NVK85sP0=
=Zq3i
-----END PGP SIGNATURE-----

--qCPCAX+azklwClYR--
