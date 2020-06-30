Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B4D20FBF3
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 20:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgF3SpB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jun 2020 14:45:01 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43715 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgF3SpB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2020 14:45:01 -0400
Received: by mail-ot1-f65.google.com with SMTP id 95so8599136otw.10
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2020 11:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d587Tri7YqxIGDjNRL0ZDsNMGBm9HnMbdfINVOzflP8=;
        b=N5VEi4vn/phe1hYgQLEvqYZcYSe4VSPkjGVXfyEambvxcX0wB0XWBBY3PZeTODyX92
         FKkKO7Kvij2Kw4iyqW9L2Vcts145XP2NPa/shjC0oc+hcHgauT4MmQF8U20dE7vg0b4Q
         /zlyO/iPEB1MI5gKpBfNxcL8MrPIeV8hI5SF1f7Is5Ijhf1V/OhnODiYCFO9Mgg8MEUO
         HQ+UDMUxSBvccX+UC25quqimT4H49cOg0JR02Vy0kJ9mHO7+MVUq/w5XZO3pNT53boka
         /B5I95NikW/NWSuX/VbKxvXFRgiPl/DaHpiS5JNvDqbeq8SptIGeBawtXltLa399ylLi
         4xWA==
X-Gm-Message-State: AOAM533ISBKfVnQR/zFQtsCtB5X4kJVtrqBj1Duk8M723t4VxQYiL9n0
        dQcZsajJcBIKRp58H0pRxf0TUQRjuIJCfN8zXBk=
X-Google-Smtp-Source: ABdhPJzUKEhJ36zegLUocaizwyJLErqDY24v8xjZIcAE7DGPcVuQXdXLU966lYSrpkXMIzwIuRyR6jthFg72AIKN5A4=
X-Received: by 2002:a9d:1c82:: with SMTP id l2mr1736399ota.167.1593542700054;
 Tue, 30 Jun 2020 11:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200629053450.12392-1-rui.zhang@intel.com>
In-Reply-To: <20200629053450.12392-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Jun 2020 20:44:49 +0200
Message-ID: <CAJZ5v0hNe2xoEF1nu3Y1hij67vOOne_v-eCJTf_ZSgFT3mVrKA@mail.gmail.com>
Subject: Re: [PATCH] powercap/intel_rapl: add support for Sapphire Rapids
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 29, 2020 at 8:57 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> RAPL on SPR behaves similar to HSW server, except that SPR uses a fixed
> energy unit (1 Joule) for the PSYS RAPL domain.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 61a63a16b5e7..b739ce4f390d 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -93,6 +93,7 @@ struct rapl_defaults {
>         u64 (*compute_time_window)(struct rapl_package *rp, u64 val,
>                                     bool to_raw);
>         unsigned int dram_domain_energy_unit;
> +       unsigned int psys_domain_energy_unit;
>  };
>  static struct rapl_defaults *rapl_defaults;
>
> @@ -533,12 +534,23 @@ static void rapl_init_domains(struct rapl_package *rp)
>                 for (j = 0; j < RAPL_DOMAIN_REG_MAX; j++)
>                         rd->regs[j] = rp->priv->regs[i][j];
>
> -               if (i == RAPL_DOMAIN_DRAM) {
> +               switch (i) {
> +               case RAPL_DOMAIN_DRAM:
>                         rd->domain_energy_unit =
>                             rapl_defaults->dram_domain_energy_unit;
>                         if (rd->domain_energy_unit)
>                                 pr_info("DRAM domain energy unit %dpj\n",
>                                         rd->domain_energy_unit);
> +                       break;
> +               case RAPL_DOMAIN_PLATFORM:
> +                       rd->domain_energy_unit =
> +                           rapl_defaults->psys_domain_energy_unit;
> +                       if (rd->domain_energy_unit)
> +                               pr_info("Platform domain energy unit %dpj\n",
> +                                       rd->domain_energy_unit);
> +                       break;
> +               default:
> +                       break;
>                 }
>                 rd++;
>         }
> @@ -919,6 +931,14 @@ static const struct rapl_defaults rapl_defaults_hsw_server = {
>         .dram_domain_energy_unit = 15300,
>  };
>
> +static const struct rapl_defaults rapl_defaults_spr_server = {
> +       .check_unit = rapl_check_unit_core,
> +       .set_floor_freq = set_floor_freq_default,
> +       .compute_time_window = rapl_compute_time_window_core,
> +       .dram_domain_energy_unit = 15300,
> +       .psys_domain_energy_unit = 1000000000,
> +};
> +
>  static const struct rapl_defaults rapl_defaults_byt = {
>         .floor_freq_reg_addr = IOSF_CPU_POWER_BUDGET_CTL_BYT,
>         .check_unit = rapl_check_unit_atom,
> @@ -978,6 +998,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,         &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,           &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,         &rapl_defaults_core),
> +       X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &rapl_defaults_spr_server),
>
>         X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,     &rapl_defaults_byt),
>         X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,        &rapl_defaults_cht),
> --

Applied as 5.9 material, thanks!
