Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC68422EB69
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 13:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgG0Lqn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 07:46:43 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34612 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgG0Lqm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 07:46:42 -0400
Received: by mail-ot1-f65.google.com with SMTP id a26so3280164otf.1;
        Mon, 27 Jul 2020 04:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LixXBR5QB4B4B2dlSqjvE7yV8s/5PUUdoGbLghccjvM=;
        b=UG2CmXgwwDPih4OFwa07kR+5NHty3jUJ2WT8/exvZQ0wr0cBqC0rKmeXQZ2KBMTNKk
         W0kVf7mVDoLGrCoFwhYisAqRxW+vMlMjlEnU6Uj4CdVe/c2CYvVeY1yzR2KBe79SbN9k
         xoCCtuNS1NbGwBSHy9w/ImTKCiWQ7ceojl7abhG9fBweFPFRePXYPGwmBRCj524H9G88
         GpNXSgFWFRiLNIqpe2grh/XWcywOg+xSrK1dlAv4/PE9FWRXK0zHhT3djY9NYvdtKW39
         elLbflMn1PnJTQLuKoGi2GRSlYJtwosl0KTMrb3slDMnM2zOEYGgnLNTo+/RY9rgf5l+
         J1/A==
X-Gm-Message-State: AOAM533OAS7x5OHOluk6muY79etehQokD5ZKI1u6hxv344qq7YZ4QqLO
        wLtRGvJfjfY2tFTCtAGsgj0mYIWaeQa0ieLIOgw=
X-Google-Smtp-Source: ABdhPJwcj2xIU8TePVY8f9netmoBO2sCD+2eZlpxSl9+YNPHPHvRnzwOYyqxeCbyc/9ccTAixekyM6OwyUy5Ysl5do8=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr20033351oth.262.1595850401093;
 Mon, 27 Jul 2020 04:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <1594921495-519-1-git-send-email-sumeet.r.pawnikar@intel.com>
In-Reply-To: <1594921495-519-1-git-send-email-sumeet.r.pawnikar@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jul 2020 13:46:12 +0200
Message-ID: <CAJZ5v0jQp2sHyzFKZu4ZL2HyN+kVax960+n2epTxBZbbZuZo8Q@mail.gmail.com>
Subject: Re: [PATCH v3] powercap: Add Power Limit4 support
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 16, 2020 at 7:38 PM Sumeet Pawnikar
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

Queued up as 5.9 material ->

> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> Co-developed-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

-> with this tag removed, because the only case in which you can
include an S-o-b from someone else is when you also add a From:
pointing to that person.  IOW, you add a From: with a matching S-o-b
from someone else and you can add your own S-o-b to that.

In this particular case, the C-d-b tag is sufficient to make a record
of somebody else's contribution to a patch carrying a From: header
that points to you (ie. your patch).

> Reviewed-and-tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> Changes in v3:
>  - Addressed review comments from Srinivas.
>
> Changes in v2:
>  - Addressed review comments from Rafael.
>  - Made the commit message more clearer.
>  - Updated powercap documentation.
> ---
>  Documentation/power/powercap/powercap.rst |   15 +++++---
>  drivers/powercap/intel_rapl_common.c      |   54 +++++++++++++++++++++++++++--
>  drivers/powercap/intel_rapl_msr.c         |   15 ++++++++
>  include/linux/intel_rapl.h                |    5 ++-
>  4 files changed, 81 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/power/powercap/powercap.rst b/Documentation/power/powercap/powercap.rst
> index 7ae3b44c7624..e75d12596dac 100644
> --- a/Documentation/power/powercap/powercap.rst
> +++ b/Documentation/power/powercap/powercap.rst
> @@ -167,11 +167,13 @@ For example::
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
> +power limits and the sizes of the time windows. Note that time window
> +is not applicable to peak power. Here, constraint_j_* attributes
> +correspond to the jth constraint (j = 0,1,2).
>
>  For example::
>
> @@ -181,6 +183,9 @@ For example::
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
> index d5487965bdfe..d2a2627507a9 100644
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
> +       const struct x86_cpu_id *id = x86_match_cpu(pl4_support_ids);
>         int ret;
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
