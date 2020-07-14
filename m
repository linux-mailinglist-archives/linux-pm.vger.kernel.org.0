Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA5521F259
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 15:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgGNNV2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 09:21:28 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39228 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbgGNNV2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 09:21:28 -0400
Received: by mail-oi1-f194.google.com with SMTP id w17so13878235oie.6;
        Tue, 14 Jul 2020 06:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAR6nZ3vrxk00e2tiFDYBTPoLzv4YScoeCt03nO/dJQ=;
        b=RFSKgR9f1mRJlF+4vnlpH18mWi2RRMDxT21dxKVmkPVzrvf/M5xTP1c8Df3jr0k61Y
         xT5+hwT+ZwmasASQaxpBM7FtEwF0z29y1+hDlF+hT1RMEnWJ4gMtp9EvvSuubbWgdfnf
         oaxvJd74Zp6EC8ISdqXY7IFEyi9CnKeowLnUar5S9LP0opAfvbO6AvtvVJAjAOezmfDi
         6b0eZHF+INwvP8d5v26zi0hFB/UgCUKliWH4kzog0qTySMZHO/+vfC7MHQU41EpFc9sW
         0lWtqCcthB7QKCHPRJu9rCdXynksFQwNJ+ZqSayXOWEovJ5JDlN1MQr4OJx7TKpDcDdH
         31Vw==
X-Gm-Message-State: AOAM531ZlgQ6K/uSysbVEUWENiTbDNiY4TiiPbaaDqrlgaPar4cXHSVc
        dbnEIl1QLBGJ6PYxrfO3CvInSlE/OG1DSlymN2k=
X-Google-Smtp-Source: ABdhPJyeP8GMQ2rBW//UCT7JAzGyu3K0u3DvSE8VDgwQaqeA3HFcebGWYEe/KhhLCjcWEyOAJX/QSCtTy7jIcU/MBpk=
X-Received: by 2002:a54:4e87:: with SMTP id c7mr3752610oiy.110.1594732886448;
 Tue, 14 Jul 2020 06:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <1594715306-10411-1-git-send-email-sumeet.r.pawnikar@intel.com>
In-Reply-To: <1594715306-10411-1-git-send-email-sumeet.r.pawnikar@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Jul 2020 15:21:14 +0200
Message-ID: <CAJZ5v0hYv5TsAWduzaoErS2a2r6dn9vq2t_s4EJ47U7Dz-C50w@mail.gmail.com>
Subject: Re: [PATCH v2] powercap: Add Power Limit4 support
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 10:22 AM Sumeet Pawnikar
<sumeet.r.pawnikar@intel.com> wrote:
>
> Modern Intel Mobile platforms support power limit4 (PL4), which is
> the SoC package level maximum power limit (in Watts). It can be used
> to preemptively limits potential SoC power to prevent power spikes
> from tripping the power adapter and battery over-current protection.
> This patch enables this feature by exposing package level peak power
> capping control to userspace via RAPL sysfs interface. With this,
> application like DTPF can modify PL4 power limit, the similar way
> of other package power limit (PL1).
> As this feature is not tested on previous generations, here it is
> enabled only for the platform that has been verified to work,
> for safety concerns.

Thanks for the better changelog!

> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

But why is the Rui's S-o-b under your patch?

Is it there because Rui has contributed to the patch?  If so, you
should have used the Co-developed-by tag instead.

Srinivas, does the patch look good to you?

> ---
> Changes in v2:
>  - Addressed review comments from Rafael.
>  - Made the commit message more clearer.
>  - Updated powercap documentation.
> ---
>  Documentation/power/powercap/powercap.rst |   14 +++++---
>  drivers/powercap/intel_rapl_common.c      |   54 +++++++++++++++++++++++++++--
>  drivers/powercap/intel_rapl_msr.c         |   15 ++++++++
>  include/linux/intel_rapl.h                |    5 ++-
>  4 files changed, 80 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/power/powercap/powercap.rst b/Documentation/power/powercap/powercap.rst
> index 7ae3b44c7624..b3af059b6d5d 100644
> --- a/Documentation/power/powercap/powercap.rst
> +++ b/Documentation/power/powercap/powercap.rst
> @@ -167,11 +167,12 @@ For example::
>  package-0
>  ---------
>
> -The Intel RAPL technology allows two constraints, short term and long term,
> -with two different time windows to be applied to each power zone.  Thus for
> -each zone there are 2 attributes representing the constraint names, 2 power
> -limits and 2 attributes representing the sizes of the time windows. Such that,
> -constraint_j_* attributes correspond to the jth constraint (j = 0,1).
> +Depending on different power zones, the Intel RAPL technology allows
> +one or multiple constraints like short term, long term and peak power,
> +with different time windows to be applied to each power zone.
> +All the zones contain attributes representing the constraint names,
> +power limits and the sizes of the time windows. Such that,
> +constraint_j_* attributes correspond to the jth constraint (j = 0,1,2).
>
>  For example::
>
> @@ -181,6 +182,9 @@ For example::
>         constraint_1_name
>         constraint_1_power_limit_uw
>         constraint_1_time_window_us
> +       constraint_2_name
> +       constraint_2_power_limit_uw
> +       constraint_2_time_window_us
>
>  Power Zone Attributes
>  =====================
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 61a63a16b5e7..a8bcc58d61f0 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -39,6 +39,8 @@
>  #define POWER_HIGH_LOCK         BIT_ULL(63)
>  #define POWER_LOW_LOCK          BIT(31)
>
> +#define POWER_LIMIT4_MASK              0x1FFF
> +
>  #define TIME_WINDOW1_MASK       (0x7FULL<<17)
>  #define TIME_WINDOW2_MASK       (0x7FULL<<49)
>
> @@ -82,6 +84,7 @@ enum unit_type {
>
>  static const char pl1_name[] = "long_term";
>  static const char pl2_name[] = "short_term";
> +static const char pl4_name[] = "peak_power";
>
>  #define power_zone_to_rapl_domain(_zone) \
>         container_of(_zone, struct rapl_domain, power_zone)
> @@ -337,6 +340,9 @@ static int set_power_limit(struct powercap_zone *power_zone, int cid,
>         case PL2_ENABLE:
>                 rapl_write_data_raw(rd, POWER_LIMIT2, power_limit);
>                 break;
> +       case PL4_ENABLE:
> +               rapl_write_data_raw(rd, POWER_LIMIT4, power_limit);
> +               break;
>         default:
>                 ret = -EINVAL;
>         }
> @@ -371,6 +377,9 @@ static int get_current_power_limit(struct powercap_zone *power_zone, int cid,
>         case PL2_ENABLE:
>                 prim = POWER_LIMIT2;
>                 break;
> +       case PL4_ENABLE:
> +               prim = POWER_LIMIT4;
> +               break;
>         default:
>                 put_online_cpus();
>                 return -EINVAL;
> @@ -440,6 +449,13 @@ static int get_time_window(struct powercap_zone *power_zone, int cid,
>         case PL2_ENABLE:
>                 ret = rapl_read_data_raw(rd, TIME_WINDOW2, true, &val);
>                 break;
> +       case PL4_ENABLE:
> +               /*
> +                * Time window parameter is not applicable for PL4 entry
> +                * so assigining '0' as default value.
> +                */
> +               val = 0;
> +               break;
>         default:
>                 put_online_cpus();
>                 return -EINVAL;
> @@ -483,6 +499,9 @@ static int get_max_power(struct powercap_zone *power_zone, int id, u64 *data)
>         case PL2_ENABLE:
>                 prim = MAX_POWER;
>                 break;
> +       case PL4_ENABLE:
> +               prim = MAX_POWER;
> +               break;
>         default:
>                 put_online_cpus();
>                 return -EINVAL;
> @@ -492,6 +511,10 @@ static int get_max_power(struct powercap_zone *power_zone, int id, u64 *data)
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
> @@ -524,12 +547,22 @@ static void rapl_init_domains(struct rapl_package *rp)
>                 rd->id = i;
>                 rd->rpl[0].prim_id = PL1_ENABLE;
>                 rd->rpl[0].name = pl1_name;
> -               /* some domain may support two power limits */
> -               if (rp->priv->limits[i] == 2) {
> +
> +               /*
> +                * The PL2 power domain is applicable for limits two
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
> @@ -587,6 +620,8 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
>                             RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
>         PRIMITIVE_INFO_INIT(POWER_LIMIT2, POWER_LIMIT2_MASK, 32,
>                             RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
> +       PRIMITIVE_INFO_INIT(POWER_LIMIT4, POWER_LIMIT4_MASK, 0,
> +                               RAPL_DOMAIN_REG_PL4, POWER_UNIT, 0),
>         PRIMITIVE_INFO_INIT(FW_LOCK, POWER_LOW_LOCK, 31,
>                             RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
>         PRIMITIVE_INFO_INIT(PL1_ENABLE, POWER_LIMIT1_ENABLE, 15,
> @@ -597,6 +632,8 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
>                             RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
>         PRIMITIVE_INFO_INIT(PL2_CLAMP, POWER_LIMIT2_CLAMP, 48,
>                             RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
> +       PRIMITIVE_INFO_INIT(PL4_ENABLE, POWER_LIMIT4_MASK, 0,
> +                               RAPL_DOMAIN_REG_PL4, ARBITRARY_UNIT, 0),
>         PRIMITIVE_INFO_INIT(TIME_WINDOW1, TIME_WINDOW1_MASK, 17,
>                             RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
>         PRIMITIVE_INFO_INIT(TIME_WINDOW2, TIME_WINDOW2_MASK, 49,
> @@ -1252,6 +1289,7 @@ void rapl_remove_package(struct rapl_package *rp)
>                 if (find_nr_power_limit(rd) > 1) {
>                         rapl_write_data_raw(rd, PL2_ENABLE, 0);
>                         rapl_write_data_raw(rd, PL2_CLAMP, 0);
> +                       rapl_write_data_raw(rd, PL4_ENABLE, 0);
>                 }
>                 if (rd->id == RAPL_DOMAIN_PACKAGE) {
>                         rd_package = rd;
> @@ -1360,6 +1398,13 @@ static void power_limit_state_save(void)
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
> @@ -1390,6 +1435,11 @@ static void power_limit_state_restore(void)
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
