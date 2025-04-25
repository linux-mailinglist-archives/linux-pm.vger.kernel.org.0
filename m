Return-Path: <linux-pm+bounces-26178-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B86A9C213
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 10:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E08172F77
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 08:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69375235341;
	Fri, 25 Apr 2025 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hVkobYMX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566C321D5B7
	for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571075; cv=none; b=pTmWCseUhuT3uSoNqvl2tMy4g+ohPSpKOOvvm5731QktKcoY4Q/KgDtfRDrNkk7de8Ev20H5Y12mZFU4UnjvsRNK1B6+Kx03x7gbUrkYfQ2SRIisB62Nvo2f1tXP837T0oMhbflYn6TO3G1lnJDh/+A8j5CF2P4GdyRAFsI3HXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571075; c=relaxed/simple;
	bh=FZWopE76g0GdqxKuvbnNQTyrmos3s+r/hLBaM//0J34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzsN8++V02xamkpVV9fqBxCsbeKuckPbEtSh02CnZzRO9iOTDVMa1iInr6GdIYvlDsaC96z34aYlEWwX/Qxvw7rgwUPF/swHIkl2SImYy12RI2pp6qiJAJ+W1Qr/JkoQvm2mc/GuG1IV48GmrlfL2iG3kj02lEHA2RnR1OeC6VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hVkobYMX; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70814384238so19319157b3.0
        for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 01:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745571072; x=1746175872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9GQfk+3zeIIKzUeHjqMJCPYPGJndG19Wjdr7pJZStAA=;
        b=hVkobYMXDPiGMDjrjO7scyTWDArd2qmoCtMyq2jqguhhyfh+TBehTlYtGX5nBdP9gZ
         5tvSaZ2xv/pT1UjquWN3DYTemJeA18gxIJIDe8xe7w4u5rPF8eiVpLsysBSm9mkxWozI
         YScMuxZul5uxgnY1aCDP/W9Wb6v6tL5fGAveneUsjxQrm8V0oF/Kui6K307JIi6zIw+S
         wfOdn5t06jqvhqasacc866HygSRwE1XtPI7UbjwYMH56riZEbsu9XKO4q3HS3R7z9eAd
         rV4zjFNcgX4w7rlr3OHLM2l4N1pEUa1xVhAzCZTJGwf7dvnDvo7sew44GXoi50Qbo/EX
         LSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745571072; x=1746175872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GQfk+3zeIIKzUeHjqMJCPYPGJndG19Wjdr7pJZStAA=;
        b=B5FK0iRxBDHf5DtMQbQw5f1RhaGPW1nkk3t1RO7xCp0XfaB1Y3rGrAFp5DENTVKagy
         fcwpTyL36V9lEUkapSzdNJ7GjK6EVzp8GnLhC0LdLWaQoU+1yH3QoJqd8CpHd60uoZKO
         /TZByNgDICnkJKQtyH/5PQUpihIfSDhjvuEu73rlTHQ5MSSPl7GkN7x6atRLd0cJJFEI
         C9s3zLtcTKM/PHkrvfxHdvNkt0EadGQVaUJH6hFrxA96t0+L4ih5LLnwlGo2hd3sVSBR
         nq9qFS2/1pXYR9Qf7ZpzWlRJLWjlIOvSZDQ17xYMLscPjxydIrXkMezxxfjDBtXiOldr
         SuSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNRd3NhDfpS0O9v3/LE2lbsAsHBlsKXZrd3LwlVDPpVKBX9xcGZ6AaZZjU7+DD5yePW3rh7bjctw==@vger.kernel.org
X-Gm-Message-State: AOJu0YySN/lwQcVb75kv7Tr7z/wb+0nAZQkVu/Bo972PQD90ibAYe0FG
	cHxLSVH4aFxWuFwLR8YdnOm0yqw9FfQ+H/JfcMA2RtUewneqNY8CqXg+itNE6pe4wcmcL3PC3Pv
	b9KR6GrgYv5041uSC5MmtlLoErq+tsI+gExLbug==
X-Gm-Gg: ASbGncv5AOqyAovxu+7Afy/xGkhcIJyiJwV2DAL7Z5w+Ifs6uXvW0LMPwc79xyfeCf2
	i8TUZ/++XsV1um+8mPJbIrOzi+uMUEG+IDiuO3hlQHjoQXDQTX32ILLVo2r6VU/PRKQFpIuhmrJ
	LuoWXy4gOMsVMNK3BwLuYXnDc=
X-Google-Smtp-Source: AGHT+IE4B65BDpklwFJDxIOPbJ0Hzq8wAs89aXC+F3ZxVBmeN5cyfnzySlvgMFu/NcYkSePA20evRaUlepPFtsP+koI=
X-Received: by 2002:a05:6902:2807:b0:e72:8658:5839 with SMTP id
 3f1490d57ef6-e7316881e05mr2063821276.32.1745571072238; Fri, 25 Apr 2025
 01:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250414185316eucas1p2c2dbd33788d9141773546f7a479ac288@eucas1p2.samsung.com>
 <20250414-apr_14_for_sending-v2-0-70c5af2af96c@samsung.com> <20250414-apr_14_for_sending-v2-3-70c5af2af96c@samsung.com>
In-Reply-To: <20250414-apr_14_for_sending-v2-3-70c5af2af96c@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 Apr 2025 10:50:35 +0200
X-Gm-Features: ATxdqUExFbuTIHs9dJyH7CbSVLWAZOfs6hMxjA5h2peJwwEgi8V0avo5M5kQ388
Message-ID: <CAPDyKFqX5cjQe3-MX3W9wMoQW3gzwSvb0QMf-_sTJuq_TeGsCg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] pmdomain: thead: Add GPU-specific clock and reset
 handling for TH1520
To: Michal Wilczynski <m.wilczynski@samsung.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	m.szyprowski@samsung.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

+ Bartosz

On Mon, 14 Apr 2025 at 20:53, Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
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
> This sequence is SoC-specific and must be abstracted away from the
> Imagination GPU driver, which expects only a standard single reset
> interface. Following discussions with kernel maintainers [1], this
> logic is placed inside a PM domain, rather than polluting the clock or
> reset frameworks, or the GPU driver itself.

Speaking about special sequences for power-on/off devices like this
one, that's a known common problem. We actually have a generic
subsystem for this now, drivers/power/sequencing/*.

Perhaps it's worth having a look at that, it should allow us to
abstract things, so the GPU driver can stay more portable.

Kind regards
Uffe

>
> To support this, the TH1520 PM domain implements `attach_dev` and
> `detach_dev` callbacks, allowing it to dynamically acquire clock and
> reset resources from the GPU device tree node at runtime. This allows to
> maintain the separation between generic drivers and SoC-specific
> integration logic.
>
> As a result, the PM domain not only handles power sequencing but also
> effectively acts as the SoC specific "glue driver" for the GPU device,
> encapsulating all TH1520-specific clock and reset management.
>
> This approach improves maintainability and aligns with the broader
> direction of treating PM domains as lightweight SoC-specific power
> management drivers [2].
>
> [1] - https://lore.kernel.org/all/CAPDyKFqsJaTrF0tBSY-TjpqdVt5=6aPQHYfnDebtphfRZSU=-Q@mail.gmail.com/
> [2] - https://osseu2024.sched.com/event/1ej38/the-case-for-an-soc-power-management-driver-stephen-boyd-google
>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  drivers/pmdomain/thead/th1520-pm-domains.c | 199 +++++++++++++++++++++++++++++
>  1 file changed, 199 insertions(+)
>
> diff --git a/drivers/pmdomain/thead/th1520-pm-domains.c b/drivers/pmdomain/thead/th1520-pm-domains.c
> index f702e20306f469aeb0ed15e54bd4f8309f28018c..75412efb195eb534c2e8ff10ced65ed4c4d2452c 100644
> --- a/drivers/pmdomain/thead/th1520-pm-domains.c
> +++ b/drivers/pmdomain/thead/th1520-pm-domains.c
> @@ -5,10 +5,13 @@
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
> @@ -16,6 +19,15 @@ struct th1520_power_domain {
>         struct th1520_aon_chan *aon_chan;
>         struct generic_pm_domain genpd;
>         u32 rsrc;
> +
> +       /* PM-owned reset */
> +       struct reset_control *clkgen_reset;
> +
> +       /* Device-specific resources */
> +       struct device *attached_dev;
> +       struct clk_bulk_data *clks;
> +       int num_clks;
> +       struct reset_control *gpu_reset;
>  };
>
>  struct th1520_power_info {
> @@ -61,6 +73,177 @@ static int th1520_pd_power_off(struct generic_pm_domain *domain)
>         return th1520_aon_power_update(pd->aon_chan, pd->rsrc, false);
>  }
>
> +static int th1520_gpu_init_consumer_clocks(struct device *dev,
> +                                          struct th1520_power_domain *pd)
> +{
> +       static const char *const clk_names[] = { "core", "sys" };
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
> +static int th1520_gpu_init_consumer_reset(struct device *dev,
> +                                         struct th1520_power_domain *pd)
> +{
> +       int ret;
> +
> +       pd->gpu_reset = reset_control_get_exclusive(dev, NULL);
> +       if (IS_ERR(pd->gpu_reset)) {
> +               ret = PTR_ERR(pd->gpu_reset);
> +               pd->gpu_reset = NULL;
> +               return dev_err_probe(dev, ret, "Failed to get GPU reset\n");
> +       }
> +
> +       return 0;
> +}
> +
> +static int th1520_gpu_init_pm_reset(struct device *dev,
> +                                   struct th1520_power_domain *pd)
> +{
> +       pd->clkgen_reset = devm_reset_control_get_exclusive(dev, "gpu-clkgen");
> +       if (IS_ERR(pd->clkgen_reset))
> +               return dev_err_probe(dev, PTR_ERR(pd->clkgen_reset),
> +                                    "Failed to get GPU clkgen reset\n");
> +
> +       return 0;
> +}
> +
> +static int th1520_gpu_domain_attach_dev(struct generic_pm_domain *genpd,
> +                                       struct device *dev)
> +{
> +       struct th1520_power_domain *pd = to_th1520_power_domain(genpd);
> +       int ret;
> +
> +       /* Enforce 1:1 mapping - only one device can be attached. */
> +       if (pd->attached_dev)
> +               return -EBUSY;
> +
> +       /* Initialize clocks using the consumer device */
> +       ret = th1520_gpu_init_consumer_clocks(dev, pd);
> +       if (ret)
> +               return ret;
> +
> +       /* Initialize consumer reset using the consumer device */
> +       ret = th1520_gpu_init_consumer_reset(dev, pd);
> +       if (ret) {
> +               if (pd->clks) {
> +                       clk_bulk_put(pd->num_clks, pd->clks);
> +                       kfree(pd->clks);
> +                       pd->clks = NULL;
> +                       pd->num_clks = 0;
> +               }
> +               return ret;
> +       }
> +
> +       /* Mark device as platform PM driver managed */
> +       device_platform_resources_set_pm_managed(dev, true);
> +       pd->attached_dev = dev;
> +
> +       return 0;
> +}
> +
> +static void th1520_gpu_domain_detach_dev(struct generic_pm_domain *genpd,
> +                                        struct device *dev)
> +{
> +       struct th1520_power_domain *pd = to_th1520_power_domain(genpd);
> +
> +       /* Ensure this is the device we have attached */
> +       if (pd->attached_dev != dev) {
> +               dev_warn(dev,
> +                        "tried to detach from GPU domain but not attached\n");
> +               return;
> +       }
> +
> +       /* Remove PM managed flag when detaching */
> +       device_platform_resources_set_pm_managed(dev, false);
> +
> +       /* Clean up the consumer-owned resources */
> +       if (pd->gpu_reset) {
> +               reset_control_put(pd->gpu_reset);
> +               pd->gpu_reset = NULL;
> +       }
> +
> +       if (pd->clks) {
> +               clk_bulk_put(pd->num_clks, pd->clks);
> +               kfree(pd->clks);
> +               pd->clks = NULL;
> +               pd->num_clks = 0;
> +       }
> +
> +       pd->attached_dev = NULL;
> +}
> +
> +static int th1520_gpu_domain_start(struct device *dev)
> +{
> +       struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
> +       struct th1520_power_domain *pd = to_th1520_power_domain(genpd);
> +       int ret;
> +
> +       /* Check if we have all required resources */
> +       if (pd->attached_dev != dev || !pd->clks || !pd->gpu_reset ||
> +           !pd->clkgen_reset)
> +               return -ENODEV;
> +
> +       ret = clk_bulk_prepare_enable(pd->num_clks, pd->clks);
> +       if (ret)
> +               return ret;
> +
> +       ret = reset_control_deassert(pd->clkgen_reset);
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
> +       ret = reset_control_deassert(pd->gpu_reset);
> +       if (ret)
> +               goto err_assert_clkgen;
> +
> +       return 0;
> +
> +err_assert_clkgen:
> +       reset_control_assert(pd->clkgen_reset);
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
> +       /* Check if we have all required resources and if this is the attached device */
> +       if (pd->attached_dev != dev || !pd->clks || !pd->gpu_reset ||
> +           !pd->clkgen_reset)
> +               return -ENODEV;
> +
> +       reset_control_assert(pd->gpu_reset);
> +       reset_control_assert(pd->clkgen_reset);
> +       clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
> +
> +       return 0;
> +}
> +
>  static struct generic_pm_domain *th1520_pd_xlate(const struct of_phandle_args *spec,
>                                                  void *data)
>  {
> @@ -99,6 +282,22 @@ th1520_add_pm_domain(struct device *dev, const struct th1520_power_info *pi)
>         pd->genpd.power_off = th1520_pd_power_off;
>         pd->genpd.name = pi->name;
>
> +       /* there are special callbacks for the GPU */
> +       if (pi == &th1520_pd_ranges[TH1520_GPU_PD]) {
> +               /* Initialize the PM-owned reset */
> +               ret = th1520_gpu_init_pm_reset(dev, pd);
> +               if (ret)
> +                       return ERR_PTR(ret);
> +
> +               /* No device attached yet */
> +               pd->attached_dev = NULL;
> +
> +               pd->genpd.dev_ops.start = th1520_gpu_domain_start;
> +               pd->genpd.dev_ops.stop = th1520_gpu_domain_stop;
> +               pd->genpd.attach_dev = th1520_gpu_domain_attach_dev;
> +               pd->genpd.detach_dev = th1520_gpu_domain_detach_dev;
> +       }
> +
>         ret = pm_genpd_init(&pd->genpd, NULL, true);
>         if (ret)
>                 return ERR_PTR(ret);
>
> --
> 2.34.1
>

