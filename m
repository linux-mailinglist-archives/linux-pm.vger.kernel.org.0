Return-Path: <linux-pm+bounces-25001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC92A822A3
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 12:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B273E8A33E7
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 10:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6F125D552;
	Wed,  9 Apr 2025 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2ClEn4i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837D925D8FD
	for <linux-pm@vger.kernel.org>; Wed,  9 Apr 2025 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195626; cv=none; b=hmWzlzeFH51hBjg1lDok6tgUWikKgsBIlcqES7Kb9JfbUhIslL0pcGG2GQrxQGDwFVGoN6wa+IX/3arMUPq3QouzbpnzMS69lLrEs1W3fva5lIJuXqIibXSEuIPEFc3oFUXWqVdMeESJoTc7jsf3Z8N8Np/oifLxBJqJYsaHV8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195626; c=relaxed/simple;
	bh=m4Va46OtnmnAHRcSLsZlTiRU5ke7iLxP4nopo7OMND8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4evxbcPg8AAsTUA+FadpIjhdt3T1bjCzndYk9EkHcx4FaR5wBzM2c7KgE/dRUsc9cqPsFkleIIMkm39991Vhus3o0WN1wLFhrm0MvGc768C27tgmI3nluKyQOyamQ+YWuIR33KANPw6B0tdgkGzEtANpqWqctzKKQfzVHHMUsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D2ClEn4i; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-702628e34f2so5541307b3.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Apr 2025 03:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744195623; x=1744800423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ug1/Rx9R3a7L/ACPQ03wXzk3pC2LRXFr7H0a//DFfV4=;
        b=D2ClEn4iLQPJIv6iecAbKk0EiX4xuWIy25VcMJJbipPcdXTirKrH3NaeP4Ru43+fPp
         LzyEatedRp31UM76ZPKJ7obXXTFt3by3h7gwuwoRvW+duvK02s6tiF1oHst9vBE1p2TD
         OJ6DZgaiUNhGhTKEq4aHJgXF5LGMDFPBLfVbWJuLhaSdTXeAqnkLihq0xWHuTAB/8ris
         LyA0KRdHJ8TlDz5n/o0siFtUaV6CPiWuqE0UnKJPEw1rkpmqpum19rCa8UmH5l9/Oizv
         4CfunijP5WYpnUdJNXFXr/pIaUxsngfa/QUs+kaF98ilX9LIzTBk5AubK9r0qIG6QrPR
         I6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744195623; x=1744800423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ug1/Rx9R3a7L/ACPQ03wXzk3pC2LRXFr7H0a//DFfV4=;
        b=KG/vw3zV/53nFhv2O/t7srC4gyGU4gCbnfCDG/CPyAo+Z6COwvUnUImDeaRvSSxOwA
         imv38l763wb5zIQJo4UWWNQA3DR+XFuz4Bd0nKMHJ6yfOWjBaw2MfJhGFJss9WF81RAV
         cvv7M+oyL0iSE9/NhE92zcEp4nhmVsHviCxcjw0j0oAow2iIR/g/BYsKAoibW29SmtdD
         7OcLMNvtrYrYpJy2WOBfrtQfH2pbM9rqxTQg3Qwz8OLJqg+O7Vq+EreqxPPjmA+EFG9C
         LPxFBRjZZ+PqBke/vfzBY+Wle4v620RPKaimzi9fqWVEVrxxNYx66RpRVcagdckl+qNK
         C5LA==
X-Forwarded-Encrypted: i=1; AJvYcCWG3si4aAzGH6i+Jlyf2Dgu25zcKVaYPobRyU9Yj6XslINFu293YqX+iYH3qy7UXVgM6fXKcWJiFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmLXj4lGb+CGLLsxoWrHVG1SMSn/RMW9X8Exr5fbrBrtIrd3CN
	OE4ez8zUS7JyetgsrUM20x6epe+VPDi148DJGq2b/83gshw0gkt2XVp/cBgAIJYAjXXrmVfiscz
	hYB1xAc+HOwyn/jtnkU9XwZ27Q6zg/f0IXAIlYw==
X-Gm-Gg: ASbGncs6hQ0xs055toBrooj0hmThy+q7DUqHo0k2jZ6wkx5BPlXSy3pLchQCN2lUZlr
	34jXZjQZ1StkfUf8F9hjtHMeU1+RM9m1Mi5RNRxVyzQGH1Adse8F/86U/1u7p58ySHnSGoJxbJR
	ldrFY6Q4E+MAEQmd3lkhj8KcE=
X-Google-Smtp-Source: AGHT+IGLd51JNY7rKV6DKAjjcFIJNQXnQmEroecayzdKgQX36GYPDaf36afd9Jqfjo6bT//7LWckn6OcAbTZ+MentbY=
X-Received: by 2002:a05:690c:b92:b0:6fe:bf32:a427 with SMTP id
 00721157ae682-70538d993f8mr41204337b3.0.1744195623423; Wed, 09 Apr 2025
 03:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250409093031eucas1p1ee277da31b7de9a16f6b7345df6a89ab@eucas1p1.samsung.com>
 <20250409093025.2917087-1-m.wilczynski@samsung.com> <20250409093025.2917087-3-m.wilczynski@samsung.com>
In-Reply-To: <20250409093025.2917087-3-m.wilczynski@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Apr 2025 12:46:26 +0200
X-Gm-Features: ATxdqUGnjrckU6XxZcEHMsxQfLuVOyOu_RZdVP-4RZ3RcySv_EDwyCFMIW9CLPg
Message-ID: <CAPDyKFoyfu2n_JfUy7PRZf1gMEZ3KKAdykjnWhS0L+wkYhbEmA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] pmdomain: thead: Add GPU-specific clock and reset
 handling for TH1520
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, 
	guoren@kernel.org, wefu@redhat.com, p.zabel@pengutronix.de, 
	m.szyprowski@samsung.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Apr 2025 at 11:30, Michal Wilczynski <m.wilczynski@samsung.com> wrote:
>
> Extend the TH1520 power domain driver to manage GPU related clocks and
> resets via generic PM domain start/stop callbacks.
>
> The TH1520 GPU requires a special sequence to correctly initialize:
> - Enable the GPU clocks
> - Deassert the GPU clkgen reset
> - Delay for a few cycles to satisfy hardware requirements
> - Deassert the GPU core reset
>
> This sequence is SoC-specific and needs to be abstracted away from the
> Imagination GPU driver, which expects a standard single reset line.
> Following discussions with kernel maintainers, this logic is placed
> inside a PM domain instead of polluting the clock or reset frameworks,
> or the GPU driver itself [1].
>
> Managing this inside a generic power domain allows better coordination
> of clocks, resets, and power state, and aligns with the direction of
> treating PM domains as SoC-specific "power management drivers".
>
> [1] - https://lore.kernel.org/all/CAPDyKFqsJaTrF0tBSY-TjpqdVt5=6aPQHYfnDebtphfRZSU=-Q@mail.gmail.com/
>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  drivers/pmdomain/thead/th1520-pm-domains.c | 119 +++++++++++++++++++++
>  1 file changed, 119 insertions(+)
>
> diff --git a/drivers/pmdomain/thead/th1520-pm-domains.c b/drivers/pmdomain/thead/th1520-pm-domains.c
> index f702e20306f4..aa85c3954c39 100644
> --- a/drivers/pmdomain/thead/th1520-pm-domains.c
> +++ b/drivers/pmdomain/thead/th1520-pm-domains.c
> @@ -5,17 +5,29 @@
>   * Author: Michal Wilczynski <m.wilczynski@samsung.com>
>   */
>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/firmware/thead/thead,th1520-aon.h>
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> +#include <linux/reset.h>
>
>  #include <dt-bindings/power/thead,th1520-power.h>
>
> +#define TH1520_GPU_RESET_IDX 0
> +#define TH1520_GPU_CLKGEN_RESET_IDX 1
> +
>  struct th1520_power_domain {
>         struct th1520_aon_chan *aon_chan;
>         struct generic_pm_domain genpd;
>         u32 rsrc;
> +
> +       struct clk_bulk_data *clks;
> +       int num_clks;
> +       struct reset_control_bulk_data *resets;
> +       int num_resets;
> +
>  };
>
>  struct th1520_power_info {
> @@ -61,6 +73,99 @@ static int th1520_pd_power_off(struct generic_pm_domain *domain)
>         return th1520_aon_power_update(pd->aon_chan, pd->rsrc, false);
>  }
>
> +static int th1520_gpu_init_clocks(struct device *dev,
> +                                 struct th1520_power_domain *pd)
> +{
> +       static const char *const clk_names[] = { "gpu-core", "gpu-sys" };
> +       int i, ret;
> +
> +       pd->num_clks = ARRAY_SIZE(clk_names);
> +       pd->clks = devm_kcalloc(dev, pd->num_clks, sizeof(*pd->clks), GFP_KERNEL);
> +       if (!pd->clks)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < pd->num_clks; i++)
> +               pd->clks[i].id = clk_names[i];
> +
> +       ret = devm_clk_bulk_get(dev, pd->num_clks, pd->clks);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to get GPU clocks\n");
> +
> +       return 0;
> +}
> +
> +static int th1520_gpu_init_resets(struct device *dev,
> +                                 struct th1520_power_domain *pd)
> +{
> +       static const char *const reset_names[] = { "gpu", "gpu-clkgen" };
> +       int i, ret;
> +
> +       pd->num_resets = ARRAY_SIZE(reset_names);
> +       pd->resets = devm_kcalloc(dev, pd->num_resets, sizeof(*pd->resets),
> +                                 GFP_KERNEL);
> +       if (!pd->resets)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < pd->num_resets; i++)
> +               pd->resets[i].id = reset_names[i];
> +
> +       ret = devm_reset_control_bulk_get_exclusive(dev, pd->num_resets,
> +                                                   pd->resets);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to get GPU resets\n");
> +
> +       return 0;
> +}
> +
> +static int th1520_gpu_domain_start(struct device *dev)
> +{
> +       struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
> +       struct th1520_power_domain *pd = to_th1520_power_domain(genpd);
> +       int ret;
> +
> +       ret = clk_bulk_prepare_enable(pd->num_clks, pd->clks);
> +       if (ret)
> +               return ret;
> +
> +       ret = reset_control_deassert(pd->resets[TH1520_GPU_CLKGEN_RESET_IDX].rstc);
> +       if (ret)
> +               goto err_disable_clks;
> +
> +       /*
> +        * According to the hardware manual, a delay of at least 32 clock
> +        * cycles is required between de-asserting the clkgen reset and
> +        * de-asserting the GPU reset. Assuming a worst-case scenario with
> +        * a very high GPU clock frequency, a delay of 1 microsecond is
> +        * sufficient to ensure this requirement is met across all
> +        * feasible GPU clock speeds.
> +        */
> +       udelay(1);
> +
> +       ret = reset_control_deassert(pd->resets[TH1520_GPU_RESET_IDX].rstc);
> +       if (ret)
> +               goto err_assert_clkgen;
> +
> +       return 0;
> +
> +err_assert_clkgen:
> +       reset_control_assert(pd->resets[TH1520_GPU_CLKGEN_RESET_IDX].rstc);
> +err_disable_clks:
> +       clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
> +       return ret;
> +}
> +
> +static int th1520_gpu_domain_stop(struct device *dev)
> +{
> +       struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
> +       struct th1520_power_domain *pd = to_th1520_power_domain(genpd);
> +
> +       reset_control_assert(pd->resets[TH1520_GPU_RESET_IDX].rstc);
> +       reset_control_assert(pd->resets[TH1520_GPU_CLKGEN_RESET_IDX].rstc);
> +       clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
> +
> +       return 0;
> +}
> +
>  static struct generic_pm_domain *th1520_pd_xlate(const struct of_phandle_args *spec,
>                                                  void *data)
>  {
> @@ -99,6 +204,20 @@ th1520_add_pm_domain(struct device *dev, const struct th1520_power_info *pi)
>         pd->genpd.power_off = th1520_pd_power_off;
>         pd->genpd.name = pi->name;
>
> +       /* there are special callbacks for the GPU */
> +       if (pi == &th1520_pd_ranges[TH1520_GPU_PD]) {
> +               ret = th1520_gpu_init_clocks(dev, pd);

Assuming both the clocks and the reset are really resources that
belong to the GPU, I would suggest to use two callbacks for the genpd
in question to implement the get/put of the clocks and reset from
there.

pd->genpd->attach_dev
pd->genpd->detach_dev

> +               if (ret)
> +                       return ERR_PTR(ret);
> +
> +               ret = th1520_gpu_init_resets(dev, pd);
> +               if (ret)
> +                       return ERR_PTR(ret);
> +
> +               pd->genpd.dev_ops.start = th1520_gpu_domain_start;
> +               pd->genpd.dev_ops.stop = th1520_gpu_domain_stop;
> +       }
> +
>         ret = pm_genpd_init(&pd->genpd, NULL, true);
>         if (ret)
>                 return ERR_PTR(ret);
> --
> 2.34.1
>

Kind regards
Uffe

