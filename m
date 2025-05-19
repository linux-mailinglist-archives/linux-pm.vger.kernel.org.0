Return-Path: <linux-pm+bounces-27350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8952DABC069
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 16:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A056D7A677E
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 14:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CD228151E;
	Mon, 19 May 2025 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M0sy/t8d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BC0278E75
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664404; cv=none; b=dhh+X3syeEnXspfIIK1LlP9RpMH8eAf+bx05CQp4se3NihYKYCvdE9mUgqqy/tWrNDzBu4hA61ggtsghZTP1j960PIEmeepMj/urRH5zRaP80AdWlAMmgLA2KRKLWRC6L0R6x4OSlpIaz4F+oxQyAejMmToIl+cJIxDygpykuKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664404; c=relaxed/simple;
	bh=2QhEeJN+QAQrXlpioyGsVmlzKPxs7y7V4R1J1hJ60dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZ3OPV4vGzr3fLcDZX0jnu7xdyG6/nlAdm9mPJbp/zrvuXNdiiYSjdGkXgkRcrEtWjcevIkoatHHFftIQIU+AuQn1kEpA/xw7VOBELzPzgtSDUjoXSh6LOPgmHeQOeqouQ4+s3zsJX7tMeTPyNBW9QB94wtdvnObTSSDFRBVjXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M0sy/t8d; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e7387d4a336so3694446276.2
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 07:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747664402; x=1748269202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VwQInU0BL1914wpsZlAYnKCHkRSUkFmFPhaLTIKOJvw=;
        b=M0sy/t8dBtiwJRpKhrbiD6kcliKEJ+A7otUNh4LpxnKirP144e0UD0dH8PVS1oel5n
         oWJyk4Wi+IIGXAMQrQq0+akRuZoO/c3H7EuCCuTT8chTn6z/bnXZgUb9U4SRKzMExaOa
         JM4PHo6qEY+MgqKeN78OTqHnO/MlW8sbfdWUzSC+AVy8X8Kf6wxNOrnbBp4oTx4GKO1J
         malKj/c6fo9Ovs/jT1e+/5Ntz1qqzZp7virlUH+mzQT3aJacqsZAk8LiiluxNpL2Pwk1
         CJeF98m1TSeeg/20VILLTu8dt/sZVKcqIjEWX61qXnwxETKJZBseC6XvwS+o0G37fV2y
         QkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747664402; x=1748269202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwQInU0BL1914wpsZlAYnKCHkRSUkFmFPhaLTIKOJvw=;
        b=lU2b3VAUO0L3Qi+1z3A0DJ1P4hRe2/h/FyW6od35B/U9eZyIYvNFdLdo+/lZn0Vu44
         TyoUn9pWxkQUMvvjhb7y0/1VqBcYUlNjZ/sEAE8CDZQS8C5ZzRsTJ+iOzS4v7GBdhIWh
         osxKb+4IUEyEX2oxBNTul1U1mmrq/Xh5dN8LINIoqb16kLx4/tiVNqBfUtyxtD5mTeGg
         6uLgcrIXR0j8UUFH0qtmWAHgAk56Izm9UTn6VRUAswHKR9yeOHTa7r47OGriX3Hf/HBC
         bAGbYG4YhZ5xrIkCKk0QLlag76ncFR/26M+HAVRxzpHZfG2qzkjfEJzAjt+f1TR6eN2N
         VdgA==
X-Forwarded-Encrypted: i=1; AJvYcCXq+fvGc7hl/cRN4mx+qwaxR5kwdCRblSkvErGhQEnqcwFmsQSSORIDtYNK1GHvESsjx+olTThqdg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yysoy498FuwhE+gifmjR1tp2q+CVdPzBjzEPfsP7XCnNK+MQMfL
	Tej2qA5JyCIRt6uFOZIY7MnJLXxvbqnI9iTMjVEIjQpdaztqJyzWfpgap9OgFhjE2PwMQssow2j
	q7xEAZtBMHLvtBpX/zkJKSXn+lEqfckMSRk7H66fSGA==
X-Gm-Gg: ASbGncvan/1rWrnQNokc3gzWVvL+zQTBct8k37v+579OkA44KnGph6NEBND0aVOo8tL
	bXQCf8F0k3jHJ0+IXPDxcAJw8HUUehFXpH3tug3wVgrZ51+6WZVxk85iW4s6pn9d2IjNkSx55tG
	C2iggzPriX1CygNxuzKlb/nCGuF0XevsULqA==
X-Google-Smtp-Source: AGHT+IGVX5yoYnItadKdZEWYQJ/USDnrDlwuwkIIEH6RYqaUPWRWklz3ss+nUUlHYUuwh48nx0lmjtA1sqsNK6i35fA=
X-Received: by 2002:a05:6902:140c:b0:e7b:5a74:f6d7 with SMTP id
 3f1490d57ef6-e7b6d715875mr16156878276.46.1747664401556; Mon, 19 May 2025
 07:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318230042.3138542-1-sbellary@baylibre.com> <20250318230042.3138542-3-sbellary@baylibre.com>
In-Reply-To: <20250318230042.3138542-3-sbellary@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 19 May 2025 16:19:25 +0200
X-Gm-Features: AX0GCFuLITcWApASOkr6vaKuGc_781MXCq425ewvVNK_o0ULs7kwJTkxaVmgo8s
Message-ID: <CAPDyKFq-0XEgw2SX_4JoGXnrCF+S_HYjEw8cG_RX+usWTEFg5A@mail.gmail.com>
Subject: Re: [PATCH 2/4] pmdomain: ti: Fix STANDBY handling of PER power domain
To: Sukrut Bellary <sbellary@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Russell King <linux@armlinux.org.uk>, 
	Rob Herring <robh@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, 
	Bajjuri Praneeth <praneeth@ti.com>, Raghavendra Vignesh <vigneshr@ti.com>, Bin Liu <b-liu@ti.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Mar 2025 at 00:00, Sukrut Bellary <sbellary@baylibre.com> wrote:
>
> Per AM335x TRM[1](section 8.1.4.3 Power mode), in case of STANDBY,
> PER domain should be ON. So, fix the PER power domain handling on standby.
>
> [1] https://www.ti.com/lit/ug/spruh73q/spruh73q.pdf
>
> Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/ti/omap_prm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/ti/omap_prm.c b/drivers/pmdomain/ti/omap_prm.c
> index b8ceb3c2b81c..7e36e675a8c6 100644
> --- a/drivers/pmdomain/ti/omap_prm.c
> +++ b/drivers/pmdomain/ti/omap_prm.c
> @@ -18,7 +18,9 @@
>  #include <linux/pm_domain.h>
>  #include <linux/reset-controller.h>
>  #include <linux/delay.h>
> -
> +#if IS_ENABLED(CONFIG_SUSPEND)
> +#include <linux/suspend.h>
> +#endif
>  #include <linux/platform_data/ti-prm.h>
>
>  enum omap_prm_domain_mode {
> @@ -88,6 +90,7 @@ struct omap_reset_data {
>  #define OMAP_PRM_HAS_RSTST     BIT(1)
>  #define OMAP_PRM_HAS_NO_CLKDM  BIT(2)
>  #define OMAP_PRM_RET_WHEN_IDLE BIT(3)
> +#define OMAP_PRM_ON_WHEN_STANDBY       BIT(4)
>
>  #define OMAP_PRM_HAS_RESETS    (OMAP_PRM_HAS_RSTCTRL | OMAP_PRM_HAS_RSTST)
>
> @@ -404,7 +407,8 @@ static const struct omap_prm_data am3_prm_data[] = {
>                 .name = "per", .base = 0x44e00c00,
>                 .pwrstctrl = 0xc, .pwrstst = 0x8, .dmap = &omap_prm_noinact,
>                 .rstctrl = 0x0, .rstmap = am3_per_rst_map,
> -               .flags = OMAP_PRM_HAS_RSTCTRL, .clkdm_name = "pruss_ocp"
> +               .flags = OMAP_PRM_HAS_RSTCTRL | OMAP_PRM_ON_WHEN_STANDBY,
> +               .clkdm_name = "pruss_ocp",
>         },
>         {
>                 .name = "wkup", .base = 0x44e00d00,
> --
> 2.34.1
>

