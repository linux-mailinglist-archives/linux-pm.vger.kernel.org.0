Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC2495D8DD
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 02:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfGCAaT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 20:30:19 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36825 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfGCAaT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 20:30:19 -0400
Received: by mail-ot1-f66.google.com with SMTP id r6so482027oti.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2019 17:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HSmdlx0BcLkwVvJMMcbiNqSwmfTBqTBKyoQRyhSM4Mk=;
        b=ZdCcRR9p8bDWsjMxFXXm6S4558zaXMfy+8D3arULI0lDP2PxqCYjzJIxE4Sx1aQkEb
         l6EoI8/UhYVVTI/u2zJ0zrCtXkr9ul+anIcIZ7ocBYmI7GQXYLOcPLt9CQE8duqfnpWg
         XSdHOVs1SjeAU5Ik7kq/iEDiiZParEqzuRnS2p6xCS3s5qaiMkUYmOllnkcaotIWBqBX
         ICruuD8tLM7UwPesYwye2iOPprTVcSmc7D1QVcrbDi1SHCkuJbBL4PjePDOhE7puohH+
         yCxKwi26DGln4k5kYWfAlybW/1GbtiiJrpjRqQCx2TQmBdbn+yWcD7jS2KIkLEHgsUHw
         QRjg==
X-Gm-Message-State: APjAAAX67TMeuGF+FJkwtIcH6oxyrQ0e3Oq5ddmvZkLk+FUpiI78XgXT
        vWjeklXhGEX2rt5v8Wgz8QH4OsJ/qHrn4ETHl9UmOQ==
X-Google-Smtp-Source: APXvYqz0CuFqzsYfwwipw8sThz3e17ZBEIFy/oxQ9CiOZR67gLLd893aarpAZSHOPovPtRSMUcMo/8KhliEKTHJ2Eu8=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr6057621otp.189.1562103855745;
 Tue, 02 Jul 2019 14:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <1561701029-3415-1-git-send-email-rui.zhang@intel.com> <1561701029-3415-5-git-send-email-rui.zhang@intel.com>
In-Reply-To: <1561701029-3415-5-git-send-email-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Jul 2019 23:44:04 +0200
Message-ID: <CAJZ5v0he3Qs_nZmTN9fcgVAnurwXOb+Dj+NnTvUqT8TCH3oNHQ@mail.gmail.com>
Subject: Re: [PATCH 04/13] intel_rapl: introduce struct rapl_private
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 28, 2019 at 7:50 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Introduce a new structure, rapl_private, to save the private data
> for different RAPL Interface.

The new structure is called rapl_priv in the patch.

Besides, I would call it rapl_if_priv to indicate that this related to
an interface.

Also, IMO there should be a kerneldoc comment for it.

> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl.c | 58 +++++++++++++++++++++----------------------
>  include/linux/intel_rapl.h    |  7 ++++++
>  2 files changed, 35 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index adb35ec..a804370 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -75,6 +75,8 @@ enum unit_type {
>         TIME_UNIT,
>  };
>
> +static struct rapl_priv rapl_msr_priv;

Please add a comment describing this variable and its role.

BTW, I'd rather call it rapl_if_msr.

> +
>  /* per domain data, some are optional */
>  #define NR_RAW_PRIMITIVES (NR_RAPL_PRIMITIVES - 2)
>
> @@ -155,17 +157,14 @@ static const char * const rapl_domain_names[] = {
>         "psys",
>  };
>
> -static struct powercap_control_type *control_type; /* PowerCap Controller */
> -static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */

Why do these things need to go into rapl_priv?

> -
>  /* caller to ensure CPU hotplug lock is held */
> -static struct rapl_package *rapl_find_package_domain(int cpu)
> +static struct rapl_package *rapl_find_package_domain(int cpu, struct rapl_priv *priv)
>  {
>         int id = topology_logical_die_id(cpu);
>         struct rapl_package *rp;
>
>         list_for_each_entry(rp, &rapl_packages, plist) {
> -               if (rp->id == id)
> +               if (rp->id == id && rp->priv->control_type == priv->control_type)
>                         return rp;
>         }
>
> @@ -1090,12 +1089,12 @@ static void rapl_update_domain_data(struct rapl_package *rp)
>
>  static void rapl_unregister_powercap(void)
>  {
> -       if (platform_rapl_domain) {
> -               powercap_unregister_zone(control_type,
> -                                        &platform_rapl_domain->power_zone);
> -               kfree(platform_rapl_domain);
> +       if (&rapl_msr_priv.platform_rapl_domain) {
> +               powercap_unregister_zone(rapl_msr_priv.control_type,
> +                                        &rapl_msr_priv.platform_rapl_domain->power_zone);
> +               kfree(rapl_msr_priv.platform_rapl_domain);
>         }
> -       powercap_unregister_control_type(control_type);
> +       powercap_unregister_control_type(rapl_msr_priv.control_type);
>  }
>
>  static int rapl_package_register_powercap(struct rapl_package *rp)
> @@ -1113,7 +1112,7 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
>                         nr_pl = find_nr_power_limit(rd);
>                         pr_debug("register package domain %s\n", rp->name);
>                         power_zone = powercap_register_zone(&rd->power_zone,
> -                                                       control_type,
> +                                                       rp->priv->control_type,
>                                                         rp->name, NULL,
>                                                         &zone_ops[rd->id],
>                                                         nr_pl,
> @@ -1140,7 +1139,7 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
>                 /* number of power limits per domain varies */
>                 nr_pl = find_nr_power_limit(rd);
>                 power_zone = powercap_register_zone(&rd->power_zone,
> -                                               control_type, rd->name,
> +                                               rp->priv->control_type, rd->name,
>                                                 rp->power_zone,
>                                                 &zone_ops[rd->id], nr_pl,
>                                                 &constraint_ops);
> @@ -1161,7 +1160,7 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
>          */
>         while (--rd >= rp->domains) {
>                 pr_debug("unregister %s domain %s\n", rp->name, rd->name);
> -               powercap_unregister_zone(control_type, &rd->power_zone);
> +               powercap_unregister_zone(rp->priv->control_type, &rd->power_zone);
>         }
>
>         return ret;
> @@ -1191,9 +1190,9 @@ static int __init rapl_register_psys(void)
>         rd->rpl[0].name = pl1_name;
>         rd->rpl[1].prim_id = PL2_ENABLE;
>         rd->rpl[1].name = pl2_name;
> -       rd->rp = rapl_find_package_domain(0);
> +       rd->rp = rapl_find_package_domain(0, &rapl_msr_priv);
>
> -       power_zone = powercap_register_zone(&rd->power_zone, control_type,
> +       power_zone = powercap_register_zone(&rd->power_zone, rapl_msr_priv.control_type,
>                                             "psys", NULL,
>                                             &zone_ops[RAPL_DOMAIN_PLATFORM],
>                                             2, &constraint_ops);
> @@ -1203,17 +1202,17 @@ static int __init rapl_register_psys(void)
>                 return PTR_ERR(power_zone);
>         }
>
> -       platform_rapl_domain = rd;
> +       rapl_msr_priv.platform_rapl_domain = rd;
>
>         return 0;
>  }
>
>  static int __init rapl_register_powercap(void)
>  {
> -       control_type = powercap_register_control_type(NULL, "intel-rapl", NULL);
> -       if (IS_ERR(control_type)) {
> +       rapl_msr_priv.control_type = powercap_register_control_type(NULL, "intel-rapl", NULL);
> +       if (IS_ERR(rapl_msr_priv.control_type)) {
>                 pr_debug("failed to register powercap control_type.\n");
> -               return PTR_ERR(control_type);
> +               return PTR_ERR(rapl_msr_priv.control_type);
>         }
>         return 0;
>  }
> @@ -1338,16 +1337,16 @@ static void rapl_remove_package(struct rapl_package *rp)
>                 }
>                 pr_debug("remove package, undo power limit on %s: %s\n",
>                          rp->name, rd->name);
> -               powercap_unregister_zone(control_type, &rd->power_zone);
> +               powercap_unregister_zone(rp->priv->control_type, &rd->power_zone);
>         }
>         /* do parent zone last */
> -       powercap_unregister_zone(control_type, &rd_package->power_zone);
> +       powercap_unregister_zone(rp->priv->control_type, &rd_package->power_zone);
>         list_del(&rp->plist);
>         kfree(rp);
>  }
>
>  /* called from CPU hotplug notifier, hotplug lock held */
> -static struct rapl_package *rapl_add_package(int cpu)
> +static struct rapl_package *rapl_add_package(int cpu, struct rapl_priv *priv)
>  {
>         int id = topology_logical_die_id(cpu);
>         struct rapl_package *rp;
> @@ -1361,6 +1360,7 @@ static struct rapl_package *rapl_add_package(int cpu)
>         /* add the new package to the list */
>         rp->id = id;
>         rp->lead_cpu = cpu;
> +       rp->priv = priv;
>
>         if (topology_max_die_per_package() > 1)
>                 snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH,
> @@ -1399,9 +1399,9 @@ static int rapl_cpu_online(unsigned int cpu)
>  {
>         struct rapl_package *rp;
>
> -       rp = rapl_find_package_domain(cpu);
> +       rp = rapl_find_package_domain(cpu, &rapl_msr_priv);
>         if (!rp) {
> -               rp = rapl_add_package(cpu);
> +               rp = rapl_add_package(cpu, &rapl_msr_priv);
>                 if (IS_ERR(rp))
>                         return PTR_ERR(rp);
>         }
> @@ -1414,7 +1414,7 @@ static int rapl_cpu_down_prep(unsigned int cpu)
>         struct rapl_package *rp;
>         int lead_cpu;
>
> -       rp = rapl_find_package_domain(cpu);
> +       rp = rapl_find_package_domain(cpu, &rapl_msr_priv);
>         if (!rp)
>                 return 0;
>
> @@ -1427,8 +1427,6 @@ static int rapl_cpu_down_prep(unsigned int cpu)
>         return 0;
>  }
>
> -static enum cpuhp_state pcap_rapl_online;
> -
>  static void power_limit_state_save(void)
>  {
>         struct rapl_package *rp;
> @@ -1538,7 +1536,7 @@ static int __init rapl_init(void)
>                                 rapl_cpu_online, rapl_cpu_down_prep);
>         if (ret < 0)
>                 goto err_unreg;
> -       pcap_rapl_online = ret;
> +       rapl_msr_priv.pcap_rapl_online = ret;
>
>         /* Don't bail out if PSys is not supported */
>         rapl_register_psys();
> @@ -1550,7 +1548,7 @@ static int __init rapl_init(void)
>         return 0;
>
>  err_unreg_all:
> -       cpuhp_remove_state(pcap_rapl_online);
> +       cpuhp_remove_state(rapl_msr_priv.pcap_rapl_online);
>
>  err_unreg:
>         rapl_unregister_powercap();
> @@ -1560,7 +1558,7 @@ static int __init rapl_init(void)
>  static void __exit rapl_exit(void)
>  {
>         unregister_pm_notifier(&rapl_pm_notifier);
> -       cpuhp_remove_state(pcap_rapl_online);
> +       cpuhp_remove_state(rapl_msr_priv.pcap_rapl_online);
>         rapl_unregister_powercap();
>  }
>
> diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
> index 9471603..d6a8547 100644
> --- a/include/linux/intel_rapl.h
> +++ b/include/linux/intel_rapl.h
> @@ -88,6 +88,12 @@ struct rapl_domain {
>         struct rapl_package *rp;
>  };
>
> +struct rapl_priv {
> +       struct powercap_control_type *control_type;
> +       struct rapl_domain *platform_rapl_domain;
> +       enum cpuhp_state pcap_rapl_online;
> +};
> +
>  /* maximum rapl package domain name: package-%d-die-%d */
>  #define PACKAGE_DOMAIN_NAME_LENGTH 30
>
> @@ -108,6 +114,7 @@ struct rapl_package {
>         /* Track active cpus */
>         struct cpumask cpumask;
>         char name[PACKAGE_DOMAIN_NAME_LENGTH];
> +       struct rapl_priv *priv;
>  };
>
>  #endif /* __INTEL_RAPL_H__ */
> --
> 2.7.4
>
