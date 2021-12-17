Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F25478F4B
	for <lists+linux-pm@lfdr.de>; Fri, 17 Dec 2021 16:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbhLQPOn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Dec 2021 10:14:43 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:38780 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbhLQPOn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Dec 2021 10:14:43 -0500
Received: by mail-ot1-f52.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso3239414ota.5
        for <linux-pm@vger.kernel.org>; Fri, 17 Dec 2021 07:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xTuwY3PbDvP9iqG/cAFniJ1/kM+vz26Bsuakdk5QNhI=;
        b=DKQJ4pIDkYIz1A6nDlWF32zyXppNe5AJbAFMEBZ43ZVOcPYIU+mI8ufR8vQHDY+RmV
         IdIaw8qfa+1om9T48hElxG/Lhqs/NSPeC2SThLgA8AjHImB9Klu2cE/6e1TrwIMTHoV6
         0JKAJPQsQ/Il3xH8nyG7+9eagoYW5Cmml7QIQcLphsqP6FETh7NQ7V5ZknUQhuS5CmzT
         Ey22zgX3DVfGhya5Jp/c30TU9gt8DlTcV+ThuI+umOZNrW1FXQ4AmRUMrLLE29ccqyrR
         BHuHiHkVPiBt85Sh69d+Uqwtr8IT4RvJ816d293AIq+/K9ItVDoDH5VN/4bzvaBPTahy
         zCaw==
X-Gm-Message-State: AOAM532AJ6JJk/I2wLNyUnD/alX9xXbSiYPdtBTLTT6hKllvFbboGSW0
        oj7WcLFudwreDOdlReWTkW0R/igqTd3z9CNMlMZEKx9B
X-Google-Smtp-Source: ABdhPJzI1nFYXa/QN2/RAdMQiUqtC3ZofyKPuJ2AJ4pkpwqS0e+bLtAmM2uh0hwrP5lSp/4Kz0oUFleh77jCy1l35v4=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr2545695otu.254.1639754082484;
 Fri, 17 Dec 2021 07:14:42 -0800 (PST)
MIME-Version: 1.0
References: <20211207131734.2607104-1-rui.zhang@intel.com>
In-Reply-To: <20211207131734.2607104-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Dec 2021 16:14:31 +0100
Message-ID: <CAJZ5v0i6rkF0Yx7ZNqzBLH8dHvogPzQWbmavA579idBT6ets1g@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: support different layout of Psys
 PowerLimit Register
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>, dana.alkattan@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 7, 2021 at 6:19 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On SPR, the Psys domain Power Limit Register has a different layout.
>
> Enhance the code to support different Psys PL register layout.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Reported-and-tested-by: Alkattan Dana <dana.alkattan@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 61 +++++++++++++++++++++++++++-
>  include/linux/intel_rapl.h           |  6 +++
>  2 files changed, 65 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 7c0099e7a6d7..07611a00b78f 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -61,6 +61,20 @@
>  #define PERF_STATUS_THROTTLE_TIME_MASK 0xffffffff
>  #define PP_POLICY_MASK         0x1F
>
> +/*
> + * SPR has different layout for Psys Domain PowerLimit registers.
> + * There are 17 bits of PL1 and PL2 instead of 15 bits.
> + * The Enable bits and TimeWindow bits are also shifted as a result.
> + */
> +#define PSYS_POWER_LIMIT1_MASK       0x1FFFF
> +#define PSYS_POWER_LIMIT1_ENABLE     BIT(17)
> +
> +#define PSYS_POWER_LIMIT2_MASK       (0x1FFFFULL<<32)
> +#define PSYS_POWER_LIMIT2_ENABLE     BIT_ULL(49)
> +
> +#define PSYS_TIME_WINDOW1_MASK       (0x7FULL<<19)
> +#define PSYS_TIME_WINDOW2_MASK       (0x7FULL<<51)
> +
>  /* Non HW constants */
>  #define RAPL_PRIMITIVE_DERIVED       BIT(1)    /* not from raw data */
>  #define RAPL_PRIMITIVE_DUMMY         BIT(2)
> @@ -97,6 +111,7 @@ struct rapl_defaults {
>                                     bool to_raw);
>         unsigned int dram_domain_energy_unit;
>         unsigned int psys_domain_energy_unit;
> +       bool spr_psys_bits;
>  };
>  static struct rapl_defaults *rapl_defaults;
>
> @@ -669,12 +684,51 @@ static struct rapl_primitive_info rpi[] = {
>                             RAPL_DOMAIN_REG_PERF, TIME_UNIT, 0),
>         PRIMITIVE_INFO_INIT(PRIORITY_LEVEL, PP_POLICY_MASK, 0,
>                             RAPL_DOMAIN_REG_POLICY, ARBITRARY_UNIT, 0),
> +       PRIMITIVE_INFO_INIT(PSYS_POWER_LIMIT1, PSYS_POWER_LIMIT1_MASK, 0,
> +                           RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
> +       PRIMITIVE_INFO_INIT(PSYS_POWER_LIMIT2, PSYS_POWER_LIMIT2_MASK, 32,
> +                           RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
> +       PRIMITIVE_INFO_INIT(PSYS_PL1_ENABLE, PSYS_POWER_LIMIT1_ENABLE, 17,
> +                           RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
> +       PRIMITIVE_INFO_INIT(PSYS_PL2_ENABLE, PSYS_POWER_LIMIT2_ENABLE, 49,
> +                           RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
> +       PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW1, PSYS_TIME_WINDOW1_MASK, 19,
> +                           RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
> +       PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW2, PSYS_TIME_WINDOW2_MASK, 51,
> +                           RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
>         /* non-hardware */
>         PRIMITIVE_INFO_INIT(AVERAGE_POWER, 0, 0, 0, POWER_UNIT,
>                             RAPL_PRIMITIVE_DERIVED),
>         {NULL, 0, 0, 0},
>  };
>
> +static enum rapl_primitives
> +prim_fixups(struct rapl_domain *rd, enum rapl_primitives prim)
> +{
> +       if (!rapl_defaults->spr_psys_bits)
> +               return prim;
> +
> +       if (rd->id != RAPL_DOMAIN_PLATFORM)
> +               return prim;
> +
> +       switch (prim) {
> +       case POWER_LIMIT1:
> +               return PSYS_POWER_LIMIT1;
> +       case POWER_LIMIT2:
> +               return PSYS_POWER_LIMIT2;
> +       case PL1_ENABLE:
> +               return PSYS_PL1_ENABLE;
> +       case PL2_ENABLE:
> +               return PSYS_PL2_ENABLE;
> +       case TIME_WINDOW1:
> +               return PSYS_TIME_WINDOW1;
> +       case TIME_WINDOW2:
> +               return PSYS_TIME_WINDOW2;
> +       default:
> +               return prim;
> +       }
> +}
> +
>  /* Read primitive data based on its related struct rapl_primitive_info.
>   * if xlate flag is set, return translated data based on data units, i.e.
>   * time, energy, and power.
> @@ -692,7 +746,8 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
>                               enum rapl_primitives prim, bool xlate, u64 *data)
>  {
>         u64 value;
> -       struct rapl_primitive_info *rp = &rpi[prim];
> +       enum rapl_primitives prim_fixed = prim_fixups(rd, prim);
> +       struct rapl_primitive_info *rp = &rpi[prim_fixed];
>         struct reg_action ra;
>         int cpu;
>
> @@ -738,7 +793,8 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
>                                enum rapl_primitives prim,
>                                unsigned long long value)
>  {
> -       struct rapl_primitive_info *rp = &rpi[prim];
> +       enum rapl_primitives prim_fixed = prim_fixups(rd, prim);
> +       struct rapl_primitive_info *rp = &rpi[prim_fixed];
>         int cpu;
>         u64 bits;
>         struct reg_action ra;
> @@ -981,6 +1037,7 @@ static const struct rapl_defaults rapl_defaults_spr_server = {
>         .compute_time_window = rapl_compute_time_window_core,
>         .dram_domain_energy_unit = 15300,
>         .psys_domain_energy_unit = 1000000000,
> +       .spr_psys_bits = true,
>  };
>
>  static const struct rapl_defaults rapl_defaults_byt = {
> diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
> index 93780834fc8f..9f4b6f5b822f 100644
> --- a/include/linux/intel_rapl.h
> +++ b/include/linux/intel_rapl.h
> @@ -58,6 +58,12 @@ enum rapl_primitives {
>         THROTTLED_TIME,
>         PRIORITY_LEVEL,
>
> +       PSYS_POWER_LIMIT1,
> +       PSYS_POWER_LIMIT2,
> +       PSYS_PL1_ENABLE,
> +       PSYS_PL2_ENABLE,
> +       PSYS_TIME_WINDOW1,
> +       PSYS_TIME_WINDOW2,
>         /* below are not raw primitive data */
>         AVERAGE_POWER,
>         NR_RAPL_PRIMITIVES,
> --

Applied (with some edits in the subject and changelog) as 5.17 material, thanks!
