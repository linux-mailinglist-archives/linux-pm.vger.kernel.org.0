Return-Path: <linux-pm+bounces-39975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AD074CE522D
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 16:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D145300286B
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961C22D130C;
	Sun, 28 Dec 2025 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jRB8Vix5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3F6238C0A
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766937111; cv=none; b=ZxdIp5o3NotScVTUboZpAR0FS4RGR2iueEuRRE90FiEe+sGjQUOkZ4g2G73FFeXpkPje7U8FJTk+tCwBzRw/dhW7Ag2sI3rPzUcEPOyulPAx4HwMr0WQltqmbORaBioGUgGshPKLLRLoWP6lsWBRYQIiMV722b+lOPSKvoctXy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766937111; c=relaxed/simple;
	bh=Bkavqw10CnB9Sonw91bjgCl8Du/CzS1634r7L7bue2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQj8MRQ2G9yxdWRit7+cNBUv3EZatZ+ljyazjzd+aFOEsTAxKTWaq3idAP7NYQwSGg01gU+WstWIq3Oe4rwwyhTbkxOwCzXHqVnGhII+wjqr2tyEY7o/siEUFb66Z4+xYZkfEJWV7vI+GiZaPQ8GhatWlJF2JqjE7UIR0keCZGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jRB8Vix5; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5942b58ac81so7018494e87.2
        for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 07:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766937108; x=1767541908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xDt2nU/HCGuLKi4YQDj2IaYM1PBWLEa/ggxeMOrlmyU=;
        b=jRB8Vix5SUdD0H2nrMady1nzSBAF4AOYCsr40neia5s51XYopy5Sdw3kaaReLa/vwG
         1duHP4sth6/GD4k0eQC+c7x470sc4UnlEIFI9HOikDzggckyOgCORVeIn1DZvSzEaVTx
         78s6wiJS26u6Br3vqwuH7eb4zzYryntdZgmx09Kl6o4hZduhGNY3VcCzmN2B1+qzgUqP
         6eKcZOYAVkrnKFJqJi36Jh7ys/KSLhfXgAuDsqpkDwYjsgKDq8RVIzgTH0FaQ6x4zamt
         oWSZK4e0l8MVRENU4KJ0nVu9OAbDKm8Zb00qfzN+W3aYX2qABktIT3Nq48F4hZdiR3u6
         KZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766937108; x=1767541908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDt2nU/HCGuLKi4YQDj2IaYM1PBWLEa/ggxeMOrlmyU=;
        b=c+qkFAmU2A8a7uoRJUKZKyRpcIHtnpPl5mNiovR1zy06vr5SydyxcvY7Q6ZzKzP0ZN
         sDdX9YfjidwNDMCnUn5kKXTs3YY0PPfQTOyd4ohlpegVtWjzyI1UGrluTGYS7DBxwaLe
         d+QegrO+PXzqlNoZMm95HsmOD4lIe3wtDG0OFJBEZ+HAydzp+Usffl71dlWqCNXZNu5m
         Y0sWkSFykrTPjFlu9V7e8AOE+Nxwv7xNYA8ZIZRRCmT2NsFLgE1MGU8u0tAhut07qPWV
         G0bAmkoEDDxnErTpLRY55t8B6mFtWxDbF+L30klekT0uc4JX7Rduc3ZdC0n9TyMzuwhC
         xzkw==
X-Forwarded-Encrypted: i=1; AJvYcCUx62Uu2Z7NGFmhdtQ2IqXGLr5Kl0MgvRGae/V3BK1ETr+iBF6akQby6jsR32ihrlY+5zFAXutiXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyV7jDN5ejabd6DguAFR909pKNmZKt/q94xfujHR42fGV2IxbIU
	ZEcRRArFG+2wvt136JOHLMXAV5fG/cUCnKWbts6uR0lmOXYyuZSB1jXkWBDKyo4PA8tShmu11UA
	dtaciulBt0JWxmE0ZVeKIaArzV3P7CB08Nv+w/SaOKQ==
X-Gm-Gg: AY/fxX5CT85Jjy0e9K3WkI+1KJHOSpPfNPvH4nnNhFGrdMq63CbapYkLAaBjapDKmKz
	08ujYwpIfhck7+ehVpM53uT+ci9tpT3epVzKumc3WtEgJAOc6gAAAODSPMXAMpqmvaU2LmwCTHQ
	xODucf0NiCMaWu71jNG4d08kgb25N9YIsgdCgkGNhskqU+JiC7AqL/xiNb+Xc5GllBjf56QGb78
	CmOKPyxVUuXDSJlE8xQ8AX6FRK7ICysf2n3SvTllNPTEtwjLrAK/xoqsLt+PC01UeCtEIra3eec
	g7lMOl8=
X-Google-Smtp-Source: AGHT+IGU1N8QBbdq+8B2sBGxa7sL3yjutJLHsa+eD4d/4O/IOXbvlkTxqF+kvhbF6vdkbcVRxjuHnPzltz+HFIkKUD8=
X-Received: by 2002:a05:6512:124f:b0:599:105a:67ce with SMTP id
 2adb3069b0e04-59a17d727c3mr8952951e87.9.1766937107517; Sun, 28 Dec 2025
 07:51:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128041722.3540037-1-macpaul.lin@mediatek.com>
In-Reply-To: <20251128041722.3540037-1-macpaul.lin@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Sun, 28 Dec 2025 16:51:11 +0100
X-Gm-Features: AQt7F2rKehWvSimlxiGz9Dfw_4j8BvE8_7xLSPYZyFy88f7zjPyzLM7SIUxe60A
Message-ID: <CAPDyKFranQ=UU5waLcw27E4SG30bps80DmGs+zZs6N9=iZa_zg@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: mtk-pm-domains: improve spinlock recursion
 fix in probe with correcting reference count
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Chen-Yu Tsai <wenst@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Weiyi Lu <Weiyi.Lu@mediatek.com>, Jian Hui Lee <jianhui.lee@canonical.com>, 
	Irving-CH Lin <Irving-CH.Lin@mediatek.com>, conor@kernel.org, krzk@kernel.org, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Bear Wang <bear.wang@mediatek.com>, 
	Pablo Sun <pablo.sun@mediatek.com>, Ramax Lo <ramax.lo@mediatek.com>, 
	Macpaul Lin <macpaul@gmail.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, Stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Nov 2025 at 05:17, Macpaul Lin <macpaul.lin@mediatek.com> wrote:
>
> Remove scpsys_get_legacy_regmap(), replacing its usage with
> of_find_node_with_property().  Explicitly call of_node_get(np) before each
> of_find_node_with_property() to maintain correct node reference counting.
>
> The of_find_node_with_property() function "consumes" its input by calling
> of_node_put() internally, whether or not it finds a match.
> Currently, dev->of_node (np) is passed multiple times in sequence without
> incrementing its reference count, causing it to be decremented multiple times
> and risking early memory release.
>
> Adding of_node_get(np) before each call balances the reference count,
> preventing premature node release.
>
> Fixes: c1bac49fe91f ("pmdomains: mtk-pm-domains: Fix spinlock recursion in probe")
> Cc: Stable@vger.kernel.org
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Tested-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Applied for fixes, thanks!

Kind regards
Uffe



> ---
>  drivers/pmdomain/mediatek/mtk-pm-domains.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
>
> Changes for v2:
>  - Rewording commit message.
>  - Add Fixes: and Tested-by: tag, thanks.
>
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index 80561d27f2b2..f64f24d520dd 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -984,18 +984,6 @@ static void scpsys_domain_cleanup(struct scpsys *scpsys)
>         }
>  }
>
> -static struct device_node *scpsys_get_legacy_regmap(struct device_node *np, const char *pn)
> -{
> -       struct device_node *local_node;
> -
> -       for_each_child_of_node(np, local_node) {
> -               if (of_property_present(local_node, pn))
> -                       return local_node;
> -       }
> -
> -       return NULL;
> -}
> -
>  static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *scpsys)
>  {
>         const u8 bp_blocks[3] = {
> @@ -1017,7 +1005,8 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
>          * this makes it then possible to allocate the array of bus_prot
>          * regmaps and convert all to the new style handling.
>          */
> -       node = scpsys_get_legacy_regmap(np, "mediatek,infracfg");
> +       of_node_get(np);
> +       node = of_find_node_with_property(np, "mediatek,infracfg");
>         if (node) {
>                 regmap[0] = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg");
>                 of_node_put(node);
> @@ -1030,7 +1019,8 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
>                 regmap[0] = NULL;
>         }
>
> -       node = scpsys_get_legacy_regmap(np, "mediatek,smi");
> +       of_node_get(np);
> +       node = of_find_node_with_property(np, "mediatek,smi");
>         if (node) {
>                 smi_np = of_parse_phandle(node, "mediatek,smi", 0);
>                 of_node_put(node);
> @@ -1048,7 +1038,8 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
>                 regmap[1] = NULL;
>         }
>
> -       node = scpsys_get_legacy_regmap(np, "mediatek,infracfg-nao");
> +       of_node_get(np);
> +       node = of_find_node_with_property(np, "mediatek,infracfg-nao");
>         if (node) {
>                 regmap[2] = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg-nao");
>                 num_regmaps++;
> --
> 2.45.2
>

