Return-Path: <linux-pm+bounces-3871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF96A853096
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 13:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876482854B8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 12:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DB03D994;
	Tue, 13 Feb 2024 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YMYtD1nz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB6E4CDE1
	for <linux-pm@vger.kernel.org>; Tue, 13 Feb 2024 12:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827636; cv=none; b=rOQK4fowXwZ/vtwkQcMubh08/snbr9hhElKLz4+sF/9VaQrWmJpPVQh7Xj0CMp36TafTtVZsSHLwLQuHONAL/weKmPQPV3b8zQpmqogadXMTEFbnPENAdeKrpgG5dFNaTBnkNfA76teL6NxV6xqsNW7a+sCLP+32kNEBVZnHYbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827636; c=relaxed/simple;
	bh=qUG8PR2r8UZ6lS80DR72SY9ifyJEWN2so7+GelRjNxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6L2czVIq6rwmozZ0ULjgtm26zIbFbIijHPEf6pPcy5iNyqdBDUpcJD3giatM1zNg/QYh9JtFKYMRFJDtSOzyAjTQ7mmS6aiUclAStyEYLawKbW25bZvO7Kj2OGouEfRH2BXLCVsVeHi1eJPZQAYlff6VgUjQzRebA7rMX3IdEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YMYtD1nz; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso453480276.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Feb 2024 04:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707827634; x=1708432434; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CQkSTMTNz7Lw479EGzO5uGlI3m6Qr+ts8Yhi4TuIF9s=;
        b=YMYtD1nz623uF5hA2py6rKKxyYq7VxopF9MUK+XPzG8kLIdC7spjdkDRQaipeEtiHn
         Xk/h+k2oc94W9x74bz/Q/LbiL1UnZ1eSgJVLieaJtJFtaMiHBebBkN72hHDB+kjKH06D
         PE5KHYDs6e9dt5mNNdaNUo0G5Jedz3PF/hn7TFC+CaXgZBYdPz2CbtTiEQhbAVAWO6TN
         HyWcn1JkNQNUaRM3DZLVG0CNox+J7V4PUIlOHR5Uk2E7HwXlDwHfVV92uSoV5mkrjQAG
         cWxVOyW8gALkuKcg80YPHIyIecQht31sO0+d7yfyt0+Z56SWqR49oLyVdGUyKyJzD166
         /whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707827634; x=1708432434;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQkSTMTNz7Lw479EGzO5uGlI3m6Qr+ts8Yhi4TuIF9s=;
        b=LbDCtSKVdDSLaaCHv+x3f0YdzFKzd0jkEAzWB17TGzuoNcZ5wGuR11lxLfFXmmBg5j
         ZL/HDNDhEcqH9Jq38D1Di/UnbhMkLduMJOkpZVHtoLUUaYcAXCOsVVbuW0jjnky/AL7o
         JrDTmjIaYUjDS1bQmZsjUhHcQUpaTlbA/fyMcSqKenSFLLNacYAMvWurdWvtC+hnE3H2
         lYPWKmncPbYMnNbWDEUCIZvW8Kz5Ijfpk4ehMxepqdlVqXP+BdCOpNlznjkggLFCsJAt
         bN3PpXX07dzPAIBAVQN6MNn46C+LddzkKRmKAEPjxEA33BvFeM9tiOiMj60b+VC+3tPK
         V10w==
X-Forwarded-Encrypted: i=1; AJvYcCVKXIG0DmlEyRDbJQytCX+d88XDqmVTSRBb2DJjGhM2ppEwM3tbg9tOcLm6Xl3HyCkjcY1VrOCM44CBlPpH3C4kod1ASb6tnS8=
X-Gm-Message-State: AOJu0Yxb89F2fKfWi6hy9UBnqIL3oODQy938eypKOw7a/lgS4zBrL7ix
	dVgvLCZsbxsEuirTDfuQ+22sJ2RI443Lvy05gYQ+3dh9kmMFZO3xpwmwlAsJXTa2O07RWS/lxLm
	8IggJ/ZbpMK7RHqwv3RS8D6aoDNl3glO7yTvmsA==
X-Google-Smtp-Source: AGHT+IEItpPRp0JDqmMU5LM1yDLksBo5Ixso4A65GTlcQpvHvL7IBDZ3JMq2DOMT684roeylKkqheTZzDc/B7oATafQ=
X-Received: by 2002:a25:db8b:0:b0:dc6:ba11:6edd with SMTP id
 g133-20020a25db8b000000b00dc6ba116eddmr10543179ybf.8.1707827634082; Tue, 13
 Feb 2024 04:33:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208202822.631449-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240208202822.631449-1-krzysztof.kozlowski@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 13 Feb 2024 13:33:18 +0100
Message-ID: <CAPDyKFr8rTEaJkQtvZwEsHiYz77hUGb7CvBw9oGfBOzxcWWV3g@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmdomain: constify of_phandle_args in xlate
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 21:28, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The xlate callbacks are supposed to translate of_phandle_args to proper
> provider without modifying the of_phandle_args.  Make the argument
> pointer to const for code safety and readability.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/core.c                     | 4 ++--
>  drivers/pmdomain/imx/scu-pd.c               | 2 +-
>  drivers/pmdomain/tegra/powergate-bpmp.c     | 2 +-
>  drivers/pmdomain/ti/ti_sci_pm_domains.c     | 2 +-
>  drivers/pmdomain/xilinx/zynqmp-pm-domains.c | 2 +-
>  include/linux/pm_domain.h                   | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 46331e71108a..ea4b29475206 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2266,7 +2266,7 @@ static DEFINE_MUTEX(of_genpd_mutex);
>   * to be a valid pointer to struct generic_pm_domain.
>   */
>  static struct generic_pm_domain *genpd_xlate_simple(
> -                                       struct of_phandle_args *genpdspec,
> +                                       const struct of_phandle_args *genpdspec,
>                                         void *data)
>  {
>         return data;
> @@ -2283,7 +2283,7 @@ static struct generic_pm_domain *genpd_xlate_simple(
>   * the genpd_onecell_data struct when registering the provider.
>   */
>  static struct generic_pm_domain *genpd_xlate_onecell(
> -                                       struct of_phandle_args *genpdspec,
> +                                       const struct of_phandle_args *genpdspec,
>                                         void *data)
>  {
>         struct genpd_onecell_data *genpd_data = data;
> diff --git a/drivers/pmdomain/imx/scu-pd.c b/drivers/pmdomain/imx/scu-pd.c
> index 891c1d925a9d..05841b0bf7f3 100644
> --- a/drivers/pmdomain/imx/scu-pd.c
> +++ b/drivers/pmdomain/imx/scu-pd.c
> @@ -393,7 +393,7 @@ static int imx_sc_pd_power_off(struct generic_pm_domain *domain)
>         return imx_sc_pd_power(domain, false);
>  }
>
> -static struct generic_pm_domain *imx_scu_pd_xlate(struct of_phandle_args *spec,
> +static struct generic_pm_domain *imx_scu_pd_xlate(const struct of_phandle_args *spec,
>                                                   void *data)
>  {
>         struct generic_pm_domain *domain = ERR_PTR(-ENOENT);
> diff --git a/drivers/pmdomain/tegra/powergate-bpmp.c b/drivers/pmdomain/tegra/powergate-bpmp.c
> index 179ed895c279..b0138ca9f851 100644
> --- a/drivers/pmdomain/tegra/powergate-bpmp.c
> +++ b/drivers/pmdomain/tegra/powergate-bpmp.c
> @@ -305,7 +305,7 @@ static void tegra_bpmp_remove_powergates(struct tegra_bpmp *bpmp)
>  }
>
>  static struct generic_pm_domain *
> -tegra_powergate_xlate(struct of_phandle_args *spec, void *data)
> +tegra_powergate_xlate(const struct of_phandle_args *spec, void *data)
>  {
>         struct generic_pm_domain *domain = ERR_PTR(-ENOENT);
>         struct genpd_onecell_data *genpd = data;
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index c091d569ecd5..9dddf227a3a6 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -85,7 +85,7 @@ static int ti_sci_pd_power_on(struct generic_pm_domain *domain)
>   * @data: genpd core data for all the powerdomains on the device
>   */
>  static struct generic_pm_domain *ti_sci_pd_xlate(
> -                                       struct of_phandle_args *genpdspec,
> +                                       const struct of_phandle_args *genpdspec,
>                                         void *data)
>  {
>         struct genpd_onecell_data *genpd_data = data;
> diff --git a/drivers/pmdomain/xilinx/zynqmp-pm-domains.c b/drivers/pmdomain/xilinx/zynqmp-pm-domains.c
> index 6fd514286d82..0b5831e5ba1b 100644
> --- a/drivers/pmdomain/xilinx/zynqmp-pm-domains.c
> +++ b/drivers/pmdomain/xilinx/zynqmp-pm-domains.c
> @@ -210,7 +210,7 @@ static void zynqmp_gpd_detach_dev(struct generic_pm_domain *domain,
>  }
>
>  static struct generic_pm_domain *zynqmp_gpd_xlate
> -                               (struct of_phandle_args *genpdspec, void *data)
> +                               (const struct of_phandle_args *genpdspec, void *data)
>  {
>         struct genpd_onecell_data *genpd_data = data;
>         unsigned int i, idx = genpdspec->args[0];
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index fb91770ba4ba..1a391ef1b6f8 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -349,7 +349,7 @@ static inline void dev_pm_genpd_resume(struct device *dev) {}
>  /* OF PM domain providers */
>  struct of_device_id;
>
> -typedef struct generic_pm_domain *(*genpd_xlate_t)(struct of_phandle_args *args,
> +typedef struct generic_pm_domain *(*genpd_xlate_t)(const struct of_phandle_args *args,
>                                                    void *data);
>
>  struct genpd_onecell_data {
> --
> 2.34.1
>

