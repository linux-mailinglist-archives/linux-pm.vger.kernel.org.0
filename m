Return-Path: <linux-pm+bounces-16575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4C69B31AB
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 14:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D081C21667
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6B61DD0E5;
	Mon, 28 Oct 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QRJt2rVQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174991DC18F
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122122; cv=none; b=BAME4oA3cOATCHHTYg5vB70sz+WpQDdrU/0bxztA8/L7/JYXaLQSvIxBoTVNIeUfn/y3937Dp97RXK2KZ5EEgf7Mn+5YSjiRyDq3GgE8PsFRIghxq2G1TYzJeSkSq5/MAWXVrGkmP2v3M4JKEbQugncjGFQLVeLSVRwLtJvaUdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122122; c=relaxed/simple;
	bh=RBeBzMmvK34PNPhhtb5HQD8f/GMEXSn61Z4rg5hsvc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iY3AGgZxq/UDzU3TXwocErs2KYds/xGjWAX4pGQTqwPoaHbm7DVgfMsZFqW/Ea0QTL8oU6K/L4+4v8AMPN/EaiMODYq+8cGVkzpJ5Z6SjyVUOrkMpC1ikJrwI0Io/PVSL35rNfjhQD9lD5UqQTiK8ZAM0yi4lTyknhl5vqSX5ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QRJt2rVQ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e9ba45d67fso33961777b3.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 06:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730122119; x=1730726919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ODHQvvFv62Zx/xb7/IaX9zhCggWHAAlTCQGt9XP7bv8=;
        b=QRJt2rVQ7Zwjm9fdMkbPBExQdC3Y9GGQhzxqtB9ApdEm3U6WS2HiCpxqURX22e3iXT
         PZR12pMDl2HLzP1c9vNMtzNIgxHy/dQGW/U63pwbBiS55Ao6VqOck3lQHKIF10NEIqgU
         2328tg12Pi6vL2GB/gS+FA4pOk8+XRXXaPsOx6J32C9uTIPGrUnjwsQtpL40g6oJr3jz
         OBX2Ppbx2bU1OtLsLkXyMNZTMVDRrTasE3nfCMZWjeVH24T7ujWysUlPnEXG8aTXExFA
         Y2DwhPEr6EQ2MoVQpBgpj8fun9w6JJs9YQaWqbIMsP6m+Dlux8q+7ZtzfMyHDwC7IGgp
         GZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730122119; x=1730726919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODHQvvFv62Zx/xb7/IaX9zhCggWHAAlTCQGt9XP7bv8=;
        b=QpniEyYDJ8HuHeRNJLwNra/sRCDQkn+dPyx7SD7QKJ18FfeEWM695xEhHjwmjMJVmA
         doJAeEeiGbNG9x2uQDYMNccng+v5OSPQr7VHjmeY8GTZ3gCb5mImDgNalz3lF3wQ/3gq
         K5cOE2OU+GhJ6JpWaeC1GH/P/zCn/qcVYFSNrKAOtfJ1jKVpHTKiHYmQZsG9o/ljvahP
         Hw9G4rjWkvWxMBewhgrzYLh9vuUsvhM3e2j3b4b4LsWK41172I2nNLUP+Euf8a/gtihq
         MlXE6hiueFRRy4cmNo5GCyCiw+kPMktA01HobYGlnmxumbCabyMTR/xaS81tJjVFF4qO
         h18Q==
X-Forwarded-Encrypted: i=1; AJvYcCVV7vYG/6b76bF4PlFNFJXOCtCuErkslUkQMdoWcIu6Ks+FmIcVpWZ+99+/bxoMnvldJNhmiCWw7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZefTZzuNJXros2YyJiay8CfyG8Wc7I/fPY99pNtd23jR1R8Zq
	onmxbakzSnz4rpPReMpt3wQlRk17nnYIoV9qzSWwVgqOQ1vzPByu/CfdLgkgiy7FRjjNAezQTKK
	dg98dU2zZ3Dn4NQRdsDRA621m1jHwXSiex8meJw==
X-Google-Smtp-Source: AGHT+IFh/cJQhvJy2qy0gX3xlkp0CbLK8TXymrBa9x8XNk/di4wG/TzrWy42DG2ickeR3FscqmzTTLIBVMvxckF62og=
X-Received: by 2002:a05:690c:ec7:b0:6e2:1527:4447 with SMTP id
 00721157ae682-6e9d8994a3amr76420097b3.1.1730122118910; Mon, 28 Oct 2024
 06:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023102148.1698910-1-quic_sibis@quicinc.com> <20241023102148.1698910-4-quic_sibis@quicinc.com>
In-Reply-To: <20241023102148.1698910-4-quic_sibis@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Oct 2024 14:28:02 +0100
Message-ID: <CAPDyKFrVopgySevDVZtkZdHBBxiiVNh73VOXLqaHfXs9MyiZ+w@mail.gmail.com>
Subject: Re: [PATCH V4 3/4] pmdomain: core: Fix debugfs node creation failure
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, jassisinghbrar@gmail.com, 
	dmitry.baryshkov@linaro.org, linux-kernel@vger.kernel.org, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, johan@kernel.org, konradybcio@kernel.org, 
	linux-pm@vger.kernel.org, tstrudel@google.com, rafael@kernel.org, 
	Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 12:22, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>
> The domain attributes returned by the perf protocol can end up
> reporting identical names across domains, resulting in debugfs
> node creation failure. Fix this failure by ensuring that pm domains
> get a unique name using ida in pm_genpd_init.
>
> Logs: [X1E reports 'NCC' for all its scmi perf domains]
> debugfs: Directory 'NCC' with parent 'pm_genpd' already present!
> debugfs: Directory 'NCC' with parent 'pm_genpd' already present!
>
> Reported-by: Johan Hovold <johan+linaro@kernel.org>
> Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
> Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>
> v3:
> * Update device names only when a name collision occurs [Dmitry/Ulf]
> * Drop Johan's T-b from "fix debugfs node creation failure"
>
>  drivers/pmdomain/core.c   | 65 ++++++++++++++++++++++++++++++---------
>  include/linux/pm_domain.h |  1 +
>  2 files changed, 51 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 76490f0bf1e2..756ed0975788 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -7,6 +7,7 @@
>  #define pr_fmt(fmt) "PM: " fmt
>
>  #include <linux/delay.h>
> +#include <linux/idr.h>
>  #include <linux/kernel.h>
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
> @@ -23,6 +24,9 @@
>  #include <linux/cpu.h>
>  #include <linux/debugfs.h>
>
> +/* Provides a unique ID for each genpd device */
> +static DEFINE_IDA(genpd_ida);
> +
>  #define GENPD_RETRY_MAX_MS     250             /* Approximate */
>
>  #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)         \
> @@ -189,7 +193,7 @@ static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
>
>         if (ret)
>                 dev_warn_once(dev, "PM domain %s will not be powered off\n",
> -                               genpd->name);
> +                             dev_name(&genpd->dev));
>
>         return ret;
>  }
> @@ -274,7 +278,7 @@ static void genpd_debug_remove(struct generic_pm_domain *genpd)
>         if (!genpd_debugfs_dir)
>                 return;
>
> -       debugfs_lookup_and_remove(genpd->name, genpd_debugfs_dir);
> +       debugfs_lookup_and_remove(dev_name(&genpd->dev), genpd_debugfs_dir);
>  }
>
>  static void genpd_update_accounting(struct generic_pm_domain *genpd)
> @@ -731,7 +735,7 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>         genpd->states[state_idx].power_on_latency_ns = elapsed_ns;
>         genpd->gd->max_off_time_changed = true;
>         pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
> -                genpd->name, "on", elapsed_ns);
> +                dev_name(&genpd->dev), "on", elapsed_ns);
>
>  out:
>         raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON, NULL);
> @@ -782,7 +786,7 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
>         genpd->states[state_idx].power_off_latency_ns = elapsed_ns;
>         genpd->gd->max_off_time_changed = true;
>         pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
> -                genpd->name, "off", elapsed_ns);
> +                dev_name(&genpd->dev), "off", elapsed_ns);
>
>  out:
>         raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_OFF,
> @@ -1941,7 +1945,7 @@ int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb)
>
>         if (ret) {
>                 dev_warn(dev, "failed to add notifier for PM domain %s\n",
> -                        genpd->name);
> +                        dev_name(&genpd->dev));
>                 return ret;
>         }
>
> @@ -1988,7 +1992,7 @@ int dev_pm_genpd_remove_notifier(struct device *dev)
>
>         if (ret) {
>                 dev_warn(dev, "failed to remove notifier for PM domain %s\n",
> -                        genpd->name);
> +                        dev_name(&genpd->dev));
>                 return ret;
>         }
>
> @@ -2014,7 +2018,7 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
>          */
>         if (!genpd_is_irq_safe(genpd) && genpd_is_irq_safe(subdomain)) {
>                 WARN(1, "Parent %s of subdomain %s must be IRQ safe\n",
> -                               genpd->name, subdomain->name);
> +                    dev_name(&genpd->dev), subdomain->name);
>                 return -EINVAL;
>         }
>
> @@ -2089,7 +2093,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>
>         if (!list_empty(&subdomain->parent_links) || subdomain->device_count) {
>                 pr_warn("%s: unable to remove subdomain %s\n",
> -                       genpd->name, subdomain->name);
> +                       dev_name(&genpd->dev), subdomain->name);
>                 ret = -EBUSY;
>                 goto out;
>         }
> @@ -2199,6 +2203,23 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
>         }
>  }
>
> +static bool genpd_name_present(const char *name)
> +{
> +       bool ret = false;
> +       const struct generic_pm_domain *gpd;
> +
> +       mutex_lock(&gpd_list_lock);
> +       list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
> +               if (!strcmp(dev_name(&gpd->dev), name)) {
> +                       ret = true;
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&gpd_list_lock);
> +
> +       return ret;
> +}
> +
>  /**
>   * pm_genpd_init - Initialize a generic I/O PM domain object.
>   * @genpd: PM domain object to initialize.
> @@ -2226,6 +2247,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>         genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
>         genpd->device_count = 0;
>         genpd->provider = NULL;
> +       genpd->device_id = -ENXIO;
>         genpd->has_provider = false;
>         genpd->accounting_time = ktime_get_mono_fast_ns();
>         genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
> @@ -2266,7 +2288,18 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>                 return ret;
>
>         device_initialize(&genpd->dev);
> -       dev_set_name(&genpd->dev, "%s", genpd->name);
> +
> +       if (!genpd_name_present(genpd->name)) {
> +               dev_set_name(&genpd->dev, "%s", genpd->name);
> +       } else {
> +               ret = ida_alloc(&genpd_ida, GFP_KERNEL);
> +               if (ret < 0) {
> +                       put_device(&genpd->dev);
> +                       return ret;
> +               }
> +               genpd->device_id = ret;
> +               dev_set_name(&genpd->dev, "%s_%u", genpd->name, genpd->device_id);
> +       }

If we can't assume that the genpd->name is unique, I think we need to
hold the gpd_list_lock over this entire new section, until we have
added the new genpd in the gpd_list. I am not sure we really want this
as it could hurt (theoretically at least) boot/probing on systems
where a lot of genpds are being used.

That said, I would suggest we go for Dmitry's suggestion to make this
genpd provider specific. Let's add a new genpd flag that genpd
providers can set, if they need an ida to be tagged on to their
device-name. Then we should set that flag for SCMI perf/power domains.

[...]

Kind regards
Uffe

