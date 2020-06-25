Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34901209F0E
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 15:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404740AbgFYNBr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 09:01:47 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46804 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403941AbgFYNBq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 09:01:46 -0400
Received: by mail-oi1-f194.google.com with SMTP id l63so4826008oih.13;
        Thu, 25 Jun 2020 06:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2icDRYz6LCocHPmA9S+VxzWoVlHPW9OJQIvHEkg1sZg=;
        b=OKDEj/KDsa4aFFL5UebRjyJNoTCsBPEF9Lbmd0Y82jx6VwMMewTXO5DvZn8GSwQn6y
         rPqsU6GDZJBy7cgLZrLt3OP4eKegfyv0noctvrt7LA7whDpPiO7eZDkTTM9NvT5Ji+Wz
         woWcCn1ZSvPfMevjiwM7rchbOInnny06U46xSXsqZ1vcQUHTLDseCVBdwWYpxlCM8eTm
         +dSYFyAIHD2Hna3DuSaU2E5HadotPEAIE7uo9xH1Lk9WmbYG5v1AqsaAiyXlDVXFahVS
         ul+R2bkIBcqAtsPsoW+lsGS5E90teqDcwqslWkJ8d1aER12wbisQz+IEknbw1Ofg+G3A
         esjA==
X-Gm-Message-State: AOAM532pPKJ+juWFM3aFDpnZzvA1kS5SQt+1PafjArbXKcfKqVM4V/yK
        OmxAcf368sjtwDvXX0TWL5WXZbNKlcluDAi1vOkr/CFsx6c=
X-Google-Smtp-Source: ABdhPJytARzeUr1WTTWIvM8tmc0ujcsB80KTHtAfZHCBLyBvHMkvkyK/hmPWp7CQPjCa9oXR9NhjqFpebcpRgno+wsY=
X-Received: by 2002:aca:4a89:: with SMTP id x131mr2101193oia.103.1593090104530;
 Thu, 25 Jun 2020 06:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <1592837693-24814-1-git-send-email-sumeet.r.pawnikar@intel.com>
In-Reply-To: <1592837693-24814-1-git-send-email-sumeet.r.pawnikar@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Jun 2020 15:01:33 +0200
Message-ID: <CAJZ5v0i_+w=n9SpRmjCZ5HbFL4bRXqj-cXNbi_HDDjidyOqPpg@mail.gmail.com>
Subject: Re: [PATCH] powercap: Add Power Limit4 support
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 22, 2020 at 4:48 PM Sumeet Pawnikar
<sumeet.r.pawnikar@intel.com> wrote:
>
> Add power limit4 (PL4) support for only mobile processor peak power.
> This is similar to VR Icc-Max limit, but works on Power instead of current.

This assumes the reader to know what the "VR Icc-Max limit" is and how
it is handled which need not be the case in principle, so it calls for
some more information.

> This limit should be used in order to protect the system from instantaneous
> power draw.

The purpose of the change appears to be to expose the PL4 to user
space via the powercap RAPL interface in sysfs, so it should be
explained what user space can expect to get from it and how to operate
it at least briefly.

> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>

The patch has some coding style issues related to comments.  Please
clean that up.

> ---
>  drivers/powercap/intel_rapl_common.c |   52 ++++++++++++++++++++++++++++++++--
>  drivers/powercap/intel_rapl_msr.c    |   15 ++++++++++
>  include/linux/intel_rapl.h           |    5 +++-
>  3 files changed, 69 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index eb328655bc01..8dad17fd4abb 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -42,6 +42,8 @@
>  #define POWER_HIGH_LOCK         BIT_ULL(63)
>  #define POWER_LOW_LOCK          BIT(31)
>
> +#define POWER_LIMIT4_MASK              0x1FFF
> +
>  #define TIME_WINDOW1_MASK       (0x7FULL<<17)
>  #define TIME_WINDOW2_MASK       (0x7FULL<<49)
>
> @@ -85,6 +87,7 @@ enum unit_type {
>
>  static const char pl1_name[] = "long_term";
>  static const char pl2_name[] = "short_term";
> +static const char pl4_name[] = "peak_power";
>
>  #define power_zone_to_rapl_domain(_zone) \
>         container_of(_zone, struct rapl_domain, power_zone)
> @@ -340,6 +343,9 @@ static int set_power_limit(struct powercap_zone *power_zone, int cid,
>         case PL2_ENABLE:
>                 rapl_write_data_raw(rd, POWER_LIMIT2, power_limit);
>                 break;
> +       case PL4_ENABLE:
> +               rapl_write_data_raw(rd, POWER_LIMIT4, power_limit);
> +               break;
>         default:
>                 ret = -EINVAL;
>         }
> @@ -374,6 +380,9 @@ static int get_current_power_limit(struct powercap_zone *power_zone, int cid,
>         case PL2_ENABLE:
>                 prim = POWER_LIMIT2;
>                 break;
> +       case PL4_ENABLE:
> +               prim = POWER_LIMIT4;
> +               break;
>         default:
>                 put_online_cpus();
>                 return -EINVAL;
> @@ -443,6 +452,12 @@ static int get_time_window(struct powercap_zone *power_zone, int cid,
>         case PL2_ENABLE:
>                 ret = rapl_read_data_raw(rd, TIME_WINDOW2, true, &val);
>                 break;
> +       case PL4_ENABLE:
> +               /* Time window parameter is not applicable for PL4 entry
> +                * so assigining '0' as default value.
> +                */
> +               val = 0;
> +               break;
>         default:
>                 put_online_cpus();
>                 return -EINVAL;
> @@ -486,6 +501,9 @@ static int get_max_power(struct powercap_zone *power_zone, int id, u64 *data)
>         case PL2_ENABLE:
>                 prim = MAX_POWER;
>                 break;
> +       case PL4_ENABLE:
> +               prim = MAX_POWER;
> +               break;
>         default:
>                 put_online_cpus();
>                 return -EINVAL;
> @@ -495,6 +513,10 @@ static int get_max_power(struct powercap_zone *power_zone, int id, u64 *data)
>         else
>                 *data = val;
>
> +       /* As a generalization rule, PL4 would be around two times PL2. */
> +       if (rd->rpl[id].prim_id == PL4_ENABLE)
> +               *data = *data * 2;
> +
>         put_online_cpus();
>
>         return ret;
> @@ -527,12 +549,21 @@ static void rapl_init_domains(struct rapl_package *rp)
>                 rd->id = i;
>                 rd->rpl[0].prim_id = PL1_ENABLE;
>                 rd->rpl[0].name = pl1_name;
> -               /* some domain may support two power limits */
> -               if (rp->priv->limits[i] == 2) {
> +
> +               /* The PL2 power domain is applicable for limits two
> +                * and limits three
> +                */
> +               if (rp->priv->limits[i] >= 2) {
>                         rd->rpl[1].prim_id = PL2_ENABLE;
>                         rd->rpl[1].name = pl2_name;
>                 }
>
> +               /* Enable PL4 domain if the total power limits are three */
> +               if (rp->priv->limits[i] == 3) {
> +                       rd->rpl[2].prim_id = PL4_ENABLE;
> +                       rd->rpl[2].name = pl4_name;
> +               }
> +
>                 for (j = 0; j < RAPL_DOMAIN_REG_MAX; j++)
>                         rd->regs[j] = rp->priv->regs[i][j];
>
> @@ -590,6 +621,8 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
>                             RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
>         PRIMITIVE_INFO_INIT(POWER_LIMIT2, POWER_LIMIT2_MASK, 32,
>                             RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
> +       PRIMITIVE_INFO_INIT(POWER_LIMIT4, POWER_LIMIT4_MASK, 0,
> +                               RAPL_DOMAIN_REG_PL4, POWER_UNIT, 0),
>         PRIMITIVE_INFO_INIT(FW_LOCK, POWER_LOW_LOCK, 31,
>                             RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
>         PRIMITIVE_INFO_INIT(PL1_ENABLE, POWER_LIMIT1_ENABLE, 15,
> @@ -600,6 +633,8 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
>                             RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
>         PRIMITIVE_INFO_INIT(PL2_CLAMP, POWER_LIMIT2_CLAMP, 48,
>                             RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
> +       PRIMITIVE_INFO_INIT(PL4_ENABLE, POWER_LIMIT4_MASK, 0,
> +                               RAPL_DOMAIN_REG_PL4, ARBITRARY_UNIT, 0),
>         PRIMITIVE_INFO_INIT(TIME_WINDOW1, TIME_WINDOW1_MASK, 17,
>                             RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
>         PRIMITIVE_INFO_INIT(TIME_WINDOW2, TIME_WINDOW2_MASK, 49,
> @@ -1254,6 +1289,7 @@ void rapl_remove_package(struct rapl_package *rp)
>                 if (find_nr_power_limit(rd) > 1) {
>                         rapl_write_data_raw(rd, PL2_ENABLE, 0);
>                         rapl_write_data_raw(rd, PL2_CLAMP, 0);
> +                       rapl_write_data_raw(rd, PL4_ENABLE, 0);
>                 }
>                 if (rd->id == RAPL_DOMAIN_PACKAGE) {
>                         rd_package = rd;
> @@ -1362,6 +1398,13 @@ static void power_limit_state_save(void)
>                                 if (ret)
>                                         rd->rpl[i].last_power_limit = 0;
>                                 break;
> +                       case PL4_ENABLE:
> +                               ret = rapl_read_data_raw(rd,
> +                                                POWER_LIMIT4, true,
> +                                                &rd->rpl[i].last_power_limit);
> +                               if (ret)
> +                                       rd->rpl[i].last_power_limit = 0;
> +                               break;
>                         }
>                 }
>         }
> @@ -1392,6 +1435,11 @@ static void power_limit_state_restore(void)
>                                         rapl_write_data_raw(rd, POWER_LIMIT2,
>                                             rd->rpl[i].last_power_limit);
>                                 break;
> +                       case PL4_ENABLE:
> +                               if (rd->rpl[i].last_power_limit)
> +                                       rapl_write_data_raw(rd, POWER_LIMIT4,
> +                                           rd->rpl[i].last_power_limit);
> +                               break;
>                         }
>                 }
>         }
> diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
> index d5487965bdfe..83c76454623e 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -28,6 +28,7 @@
>
>  /* Local defines */
>  #define MSR_PLATFORM_POWER_LIMIT       0x0000065C
> +#define MSR_VR_CURRENT_CONFIG          0x00000601
>
>  /* private data for RAPL MSR Interface */
>  static struct rapl_if_priv rapl_msr_priv = {
> @@ -123,13 +124,27 @@ static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
>         return ra->err;
>  }
>
> +/* List of verified CPUs. */
> +static const struct x86_cpu_id pl4_support_ids[] = {
> +       { X86_VENDOR_INTEL, 6, INTEL_FAM6_TIGERLAKE_L, X86_FEATURE_ANY },
> +       {}
> +};
> +
>  static int rapl_msr_probe(struct platform_device *pdev)
>  {
>         int ret;
> +       const struct x86_cpu_id *id = x86_match_cpu(pl4_support_ids);
>
>         rapl_msr_priv.read_raw = rapl_msr_read_raw;
>         rapl_msr_priv.write_raw = rapl_msr_write_raw;
>
> +       if (id) {
> +               rapl_msr_priv.limits[RAPL_DOMAIN_PACKAGE] = 3;
> +               rapl_msr_priv.regs[RAPL_DOMAIN_PACKAGE][RAPL_DOMAIN_REG_PL4] =
> +                       MSR_VR_CURRENT_CONFIG;
> +               pr_info("PL4 support detected.\n");
> +       }
> +
>         rapl_msr_priv.control_type = powercap_register_control_type(NULL, "intel-rapl", NULL);
>         if (IS_ERR(rapl_msr_priv.control_type)) {
>                 pr_debug("failed to register powercap control_type.\n");
> diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
> index efb3ce892c20..3582176a1eca 100644
> --- a/include/linux/intel_rapl.h
> +++ b/include/linux/intel_rapl.h
> @@ -29,6 +29,7 @@ enum rapl_domain_reg_id {
>         RAPL_DOMAIN_REG_PERF,
>         RAPL_DOMAIN_REG_POLICY,
>         RAPL_DOMAIN_REG_INFO,
> +       RAPL_DOMAIN_REG_PL4,
>         RAPL_DOMAIN_REG_MAX,
>  };
>
> @@ -38,12 +39,14 @@ enum rapl_primitives {
>         ENERGY_COUNTER,
>         POWER_LIMIT1,
>         POWER_LIMIT2,
> +       POWER_LIMIT4,
>         FW_LOCK,
>
>         PL1_ENABLE,             /* power limit 1, aka long term */
>         PL1_CLAMP,              /* allow frequency to go below OS request */
>         PL2_ENABLE,             /* power limit 2, aka short term, instantaneous */
>         PL2_CLAMP,
> +       PL4_ENABLE,             /* power limit 4, aka max peak power */
>
>         TIME_WINDOW1,           /* long term */
>         TIME_WINDOW2,           /* short term */
> @@ -65,7 +68,7 @@ struct rapl_domain_data {
>         unsigned long timestamp;
>  };
>
> -#define NR_POWER_LIMITS (2)
> +#define NR_POWER_LIMITS (3)
>  struct rapl_power_limit {
>         struct powercap_zone_constraint *constraint;
>         int prim_id;            /* primitive ID used to enable */
> --
> 1.7.9.5
>
