Return-Path: <linux-pm+bounces-35226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5A6B9643B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 16:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE0D44E2EFE
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43262741B6;
	Tue, 23 Sep 2025 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pHxBtCsi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23A023D7D0
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637492; cv=none; b=P6VS+RMbJCnKAZR1TwOqeJUhOQwKzoSwv1tOuT8WTgxnbqStVo0Vs1y/kAYp2WgXBVxliho0qbnpMVXhNFH5y+4+HsOS5ZlJVwDe8OxMLK+QyM2/gPtJfcyZQ1GxPXlmbUXS1e4/Jz0R8o9l9w90yeqIVCpbJ9rM0AvQ5lOimuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637492; c=relaxed/simple;
	bh=eWihz0z0JIQWHYGwcOUGrAJbU4ImufZBgs86/4aLMoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHLARZTRNHQJNdJnToopt51rQVPnFw3SSA6OcSkz35CRxKIHrxrpYGsIWp5jDr0TJhbCq9rwtJAt8fbpmFxCymGO70Xq00uPwyQolm+5dDrmk6gUCU6WyCKaQYg6EaISVvkrvyT7UjqpJqvMUhr31cdrlC5GPmBI1GXcpaGvNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pHxBtCsi; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d601859f5so44272547b3.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 07:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758637489; x=1759242289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1tUpBb6qulXCWAadHVOQRFgdDFu6TKGouRDpRCguBiA=;
        b=pHxBtCsiBu6wl15vhgceu5NmjwRm+WSuT4nmlU5xbJbgXM1CC+V7h0looIg2TWOXi2
         OWbJKH1lsLgMoGVbgtowHpn3x5VR9zXRAapC47D4/fspdZm2gIhOVgcI6ZKlS8M8k9X3
         VB/82nY+g6zZu6cl7Th7tFTxCw5fq8fUZbrG9PdIl1xYFyWTVyijyjYlo0AMV4OQvmXM
         a60l/I7BMwPBgKOdDQTAhP7YZi42jfEgLQ/xbu1cWGA5vEWDiwl3n+reIX5MbaB8Re/k
         kzPhghDlKOruwJvtm0xM4q5U8imEjK+Mq7gpxqKfmnNG6ugZJrJ8zItWjQFI38DShext
         h+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758637489; x=1759242289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tUpBb6qulXCWAadHVOQRFgdDFu6TKGouRDpRCguBiA=;
        b=tflcNk8i430ikzatFqQyDw4f5GtHpo2zoF4eZM3laP2hJSN4ht8pM5GIhMgigzzxU+
         Zf6rV3jwoBeiyRQaogPWBF7gSkOULQG3G74fT1jm0d6kPgLqlPOoB0tUL6SJ3bGrSNH8
         Lh4IB+1yzyL5HhxqN/mNHT87Qt4qAdBiZBG4zUXxxTrdht2urKzwBAbl8V9qta8w+/Zp
         eV34NQBU8YRd2VVK4rulnxOFTr7m+XusIjTUzMcYY5xi3ADRzA1r5c71iy7FsViFo3jf
         c/GPKx9LBzUGx3ZsMpJW0N1ri65EoQwhRhaY1Um8xLm5PPsVVXqVjisOzY2vsOrzeW0D
         cqCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNmoPf7GpfLvI2fHjcQdUnYBDxRPOmyY83zFAjDtNP/7DgZQ/+B/gooeiTi7nW6zD86ng27+OepA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5aKPPso0eDfe+3/RVAiI/BxLeuTeotXkQ07AvP23/V7Y4Sx/G
	cPCmu2Ke+o/+xeJ9MSCPHIMaHXXKRxTkUyk9qaCMuhBBOziEI8eerFtlvH9xcJgdbMjLrR7JuoA
	yq0K54l45qBwjr2Kk9pHiOnhQAc8iDyPqVl7SPXN/5Q==
X-Gm-Gg: ASbGncsYPZn/zfTdp0FUmkde0G9qZV29xTWRUHz4nMWl6QaDzT+xkLaIIHXSDB980q/
	nY1LfK0Yz18Hb75MkxLnJWqjp0uXGO4AMAewChBIO/9ZnZyQLGF/KQu9o0+gLi52beLYLUBCYWr
	ihT9aMAmAORL0jnGPxEqIWDkeN7osG5NU3YT1A+6CURINzrEibsYEOQOnuYOIhmr+3LN8YCvl45
	nezU/gPjgYbQmlbPL4=
X-Google-Smtp-Source: AGHT+IF1FCtcjMSOAGh57xMvLkahzg1nEGPiVoAht6L/S8rmvuZxjp7LQD0zrTATTe5JO0aUrJTq9dOrEPI1k3shK8c=
X-Received: by 2002:a05:690c:5511:20b0:720:5fbc:20c2 with SMTP id
 00721157ae682-758a5393f77mr18808297b3.36.1758637489554; Tue, 23 Sep 2025
 07:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923-mt8196-gpufreq-v4-0-6cd63ade73d6@collabora.com> <20250923-mt8196-gpufreq-v4-8-6cd63ade73d6@collabora.com>
In-Reply-To: <20250923-mt8196-gpufreq-v4-8-6cd63ade73d6@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 23 Sep 2025 16:24:13 +0200
X-Gm-Features: AS18NWC-sVzrTkGqH5gpcO5QSqPC0ul4k36msuT8kehXNT5ngXXnGDzn6xEf6ew
Message-ID: <CAPDyKFpLNJRRxWPm2Eye+Fs8go-LNwWGzPUPPKmNVJkyK5N3Dw@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] pmdomain: mediatek: Add support for MFlexGraphics
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 13:41, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> Various MediaTek SoCs use GPU integration silicon named "MFlexGraphics"
> by MediaTek. On the MT8196 and MT6991 SoCs, interacting with this
> integration silicon is required to power on the GPU.
>
> This glue silicon is in the form of an embedded microcontroller running
> special-purpose firmware, which autonomously adjusts clocks and
> regulators.
>
> Implement a driver, modelled as a pmdomain driver with a
> set_performance_state operation, to support these SoCs.
>
> The driver also exposes the actual achieved clock rate, as read back
> from the MCU, as common clock framework clocks, by acting as a clock
> provider as well.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/pmdomain/mediatek/Kconfig            |  16 +
>  drivers/pmdomain/mediatek/Makefile           |   1 +
>  drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c | 928 +++++++++++++++++++++++++++
>  3 files changed, 945 insertions(+)

[...]

> +
> +static int mtk_mfg_set_performance(struct generic_pm_domain *pd,
> +                                  unsigned int state)
> +{
> +       struct mtk_mfg *mfg = mtk_mfg_from_genpd(pd);
> +
> +       /*
> +        * Occasionally, we're asked to set OPPs when we're off. This will fail,
> +        * so don't do it at all. We do foo != GENPD_STATE_ON instead of !foo
> +        * as to not depend on the actual value of the enum.
> +        */
> +       if (mfg->pd.status != GENPD_STATE_ON)
> +               return 0;

Returning 0 here, means that we may end up never restoring the
performance state for a device and its genpd, when the device is
getting runtime resumed. In genpd_runtime_resume() we are calling
genpd_restore_performance_state() before calling genpd_power_on().
This is deliberate, see commit ae8ac19655e0.

That said, I think we need to manage the restore in the ->power_on()
callback. In principle, it means we should call
mtk_mfg_set_oppidx(mfg, genpd->performance_state) from there.

> +
> +       return mtk_mfg_set_oppidx(mfg, state);
> +}
> +
> +static int mtk_mfg_power_on(struct generic_pm_domain *pd)
> +{
> +       struct mtk_mfg *mfg = mtk_mfg_from_genpd(pd);
> +       int ret;
> +
> +       ret = regulator_bulk_enable(mfg->variant->num_regulators,
> +                                   mfg->gpu_regs);
> +       if (ret)
> +               return ret;
> +
> +       ret = clk_prepare_enable(mfg->clk_eb);
> +       if (ret)
> +               goto err_disable_regulators;
> +
> +       ret = clk_bulk_prepare_enable(mfg->variant->num_clks, mfg->gpu_clks);
> +       if (ret)
> +               goto err_disable_eb_clk;
> +
> +       ret = mtk_mfg_eb_on(mfg);
> +       if (ret)
> +               goto err_disable_clks;
> +
> +       ret = mtk_mfg_power_control(mfg, true);
> +       if (ret)
> +               goto err_eb_off;
> +
> +       return 0;
> +
> +err_eb_off:
> +       mtk_mfg_eb_off(mfg);
> +err_disable_clks:
> +       clk_bulk_disable_unprepare(mfg->variant->num_clks, mfg->gpu_clks);
> +err_disable_eb_clk:
> +       clk_disable_unprepare(mfg->clk_eb);
> +err_disable_regulators:
> +       regulator_bulk_disable(mfg->variant->num_regulators, mfg->gpu_regs);
> +
> +       return ret;
> +}

[...]

Note, I intend to have a bit closer look at this soon, but I just
observed the issue I pointed out above from my first quick look.

Kind regards
Uffe

