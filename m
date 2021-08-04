Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A682F3E0761
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 20:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240229AbhHDSPl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 14:15:41 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:40642 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbhHDSPZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 14:15:25 -0400
Received: by mail-oi1-f180.google.com with SMTP id q6so3843728oiw.7;
        Wed, 04 Aug 2021 11:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+qN+VCmwgCS/5Ol3jJuuBqh2EGP1sunj3rYRAOLVrY=;
        b=Lvi3IIzYQaXEwrSZxkUt9OtGk3DpQvEK6I176CH5f1+YKTrZEmtqoD3KwTKeibiCsH
         TjZVO48ONMOf8n5n9MBgBXBW4bOorBAfZwANl0bDMggTUoqo0RVq/HC8m9Pt6QWpRLpv
         pp7MTubtGLD48t02tOoJwiXmybgvTHqhB8N0A6Sjez5YeeYX1Q7vJI1icUURQ6Gz/LU8
         myIK6UWhynRhwoISDkpdaNb5GRuhrzu8QTNtkq1ukic0o1CNKqvEEV+l0BYPDjvaUt4H
         mEw1wSESf4gef76gxAagSRwrUsz3RjCTISPyZSnLgUR2msT2FoWVr3WhuzZSfPeBRQqs
         q6uw==
X-Gm-Message-State: AOAM531ODGqvy1mMjxsQSn8/hPPhTeKpOzTE4wIUyjrthcA74Xs4+2CY
        /MCC5EvGqjZbpXkhm3dO4HojXePlaTYp7X1FuK4=
X-Google-Smtp-Source: ABdhPJzdMMPGPMSRSc8J9oxsfBiuelMcOQd01HJSK746pNJab7JNLMNi3HKVqZy5pCQclOv7xRAKAgQ1HBZXs7h6/B0=
X-Received: by 2002:a05:6808:198c:: with SMTP id bj12mr564906oib.71.1628100910674;
 Wed, 04 Aug 2021 11:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210803141621.780504-1-bigeasy@linutronix.de> <20210803141621.780504-19-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-19-bigeasy@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Aug 2021 20:14:59 +0200
Message-ID: <CAJZ5v0gsS+v23yMBnOV8GTiCF9OaXSLffJn1p+K3kJaQQkzEcw@mail.gmail.com>
Subject: Re: [PATCH 18/38] powercap: intel_rapl: Replace deprecated
 CPU-hotplug functions.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 3, 2021 at 4:17 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> The functions get_online_cpus() and put_online_cpus() have been
> deprecated during the CPU hotplug rework. They map directly to
> cpus_read_lock() and cpus_read_unlock().
>
> Replace deprecated CPU-hotplug functions with the official version.
> The behavior remains unchanged.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/powercap/intel_rapl_common.c | 50 ++++++++++++++--------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 73cf68af97700..7c0099e7a6d72 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -158,16 +158,16 @@ static int get_energy_counter(struct powercap_zone *power_zone,
>         /* prevent CPU hotplug, make sure the RAPL domain does not go
>          * away while reading the counter.
>          */
> -       get_online_cpus();
> +       cpus_read_lock();
>         rd = power_zone_to_rapl_domain(power_zone);
>
>         if (!rapl_read_data_raw(rd, ENERGY_COUNTER, true, &energy_now)) {
>                 *energy_raw = energy_now;
> -               put_online_cpus();
> +               cpus_read_unlock();
>
>                 return 0;
>         }
> -       put_online_cpus();
> +       cpus_read_unlock();
>
>         return -EIO;
>  }
> @@ -216,11 +216,11 @@ static int set_domain_enable(struct powercap_zone *power_zone, bool mode)
>         if (rd->state & DOMAIN_STATE_BIOS_LOCKED)
>                 return -EACCES;
>
> -       get_online_cpus();
> +       cpus_read_lock();
>         rapl_write_data_raw(rd, PL1_ENABLE, mode);
>         if (rapl_defaults->set_floor_freq)
>                 rapl_defaults->set_floor_freq(rd, mode);
> -       put_online_cpus();
> +       cpus_read_unlock();
>
>         return 0;
>  }
> @@ -234,13 +234,13 @@ static int get_domain_enable(struct powercap_zone *power_zone, bool *mode)
>                 *mode = false;
>                 return 0;
>         }
> -       get_online_cpus();
> +       cpus_read_lock();
>         if (rapl_read_data_raw(rd, PL1_ENABLE, true, &val)) {
> -               put_online_cpus();
> +               cpus_read_unlock();
>                 return -EIO;
>         }
>         *mode = val;
> -       put_online_cpus();
> +       cpus_read_unlock();
>
>         return 0;
>  }
> @@ -317,7 +317,7 @@ static int set_power_limit(struct powercap_zone *power_zone, int cid,
>         int ret = 0;
>         int id;
>
> -       get_online_cpus();
> +       cpus_read_lock();
>         rd = power_zone_to_rapl_domain(power_zone);
>         id = contraint_to_pl(rd, cid);
>         if (id < 0) {
> @@ -350,7 +350,7 @@ static int set_power_limit(struct powercap_zone *power_zone, int cid,
>         if (!ret)
>                 package_power_limit_irq_save(rp);
>  set_exit:
> -       put_online_cpus();
> +       cpus_read_unlock();
>         return ret;
>  }
>
> @@ -363,7 +363,7 @@ static int get_current_power_limit(struct powercap_zone *power_zone, int cid,
>         int ret = 0;
>         int id;
>
> -       get_online_cpus();
> +       cpus_read_lock();
>         rd = power_zone_to_rapl_domain(power_zone);
>         id = contraint_to_pl(rd, cid);
>         if (id < 0) {
> @@ -382,7 +382,7 @@ static int get_current_power_limit(struct powercap_zone *power_zone, int cid,
>                 prim = POWER_LIMIT4;
>                 break;
>         default:
> -               put_online_cpus();
> +               cpus_read_unlock();
>                 return -EINVAL;
>         }
>         if (rapl_read_data_raw(rd, prim, true, &val))
> @@ -391,7 +391,7 @@ static int get_current_power_limit(struct powercap_zone *power_zone, int cid,
>                 *data = val;
>
>  get_exit:
> -       put_online_cpus();
> +       cpus_read_unlock();
>
>         return ret;
>  }
> @@ -403,7 +403,7 @@ static int set_time_window(struct powercap_zone *power_zone, int cid,
>         int ret = 0;
>         int id;
>
> -       get_online_cpus();
> +       cpus_read_lock();
>         rd = power_zone_to_rapl_domain(power_zone);
>         id = contraint_to_pl(rd, cid);
>         if (id < 0) {
> @@ -423,7 +423,7 @@ static int set_time_window(struct powercap_zone *power_zone, int cid,
>         }
>
>  set_time_exit:
> -       put_online_cpus();
> +       cpus_read_unlock();
>         return ret;
>  }
>
> @@ -435,7 +435,7 @@ static int get_time_window(struct powercap_zone *power_zone, int cid,
>         int ret = 0;
>         int id;
>
> -       get_online_cpus();
> +       cpus_read_lock();
>         rd = power_zone_to_rapl_domain(power_zone);
>         id = contraint_to_pl(rd, cid);
>         if (id < 0) {
> @@ -458,14 +458,14 @@ static int get_time_window(struct powercap_zone *power_zone, int cid,
>                 val = 0;
>                 break;
>         default:
> -               put_online_cpus();
> +               cpus_read_unlock();
>                 return -EINVAL;
>         }
>         if (!ret)
>                 *data = val;
>
>  get_time_exit:
> -       put_online_cpus();
> +       cpus_read_unlock();
>
>         return ret;
>  }
> @@ -491,7 +491,7 @@ static int get_max_power(struct powercap_zone *power_zone, int id, u64 *data)
>         int prim;
>         int ret = 0;
>
> -       get_online_cpus();
> +       cpus_read_lock();
>         rd = power_zone_to_rapl_domain(power_zone);
>         switch (rd->rpl[id].prim_id) {
>         case PL1_ENABLE:
> @@ -504,7 +504,7 @@ static int get_max_power(struct powercap_zone *power_zone, int id, u64 *data)
>                 prim = MAX_POWER;
>                 break;
>         default:
> -               put_online_cpus();
> +               cpus_read_unlock();
>                 return -EINVAL;
>         }
>         if (rapl_read_data_raw(rd, prim, true, &val))
> @@ -516,7 +516,7 @@ static int get_max_power(struct powercap_zone *power_zone, int id, u64 *data)
>         if (rd->rpl[id].prim_id == PL4_ENABLE)
>                 *data = *data * 2;
>
> -       put_online_cpus();
> +       cpus_read_unlock();
>
>         return ret;
>  }
> @@ -1358,7 +1358,7 @@ static void power_limit_state_save(void)
>         struct rapl_domain *rd;
>         int nr_pl, ret, i;
>
> -       get_online_cpus();
> +       cpus_read_lock();
>         list_for_each_entry(rp, &rapl_packages, plist) {
>                 if (!rp->power_zone)
>                         continue;
> @@ -1390,7 +1390,7 @@ static void power_limit_state_save(void)
>                         }
>                 }
>         }
> -       put_online_cpus();
> +       cpus_read_unlock();
>  }
>
>  static void power_limit_state_restore(void)
> @@ -1399,7 +1399,7 @@ static void power_limit_state_restore(void)
>         struct rapl_domain *rd;
>         int nr_pl, i;
>
> -       get_online_cpus();
> +       cpus_read_lock();
>         list_for_each_entry(rp, &rapl_packages, plist) {
>                 if (!rp->power_zone)
>                         continue;
> @@ -1425,7 +1425,7 @@ static void power_limit_state_restore(void)
>                         }
>                 }
>         }
> -       put_online_cpus();
> +       cpus_read_unlock();
>  }
>
>  static int rapl_pm_callback(struct notifier_block *nb,
> --

Applied as 5.15 material, thanks!
