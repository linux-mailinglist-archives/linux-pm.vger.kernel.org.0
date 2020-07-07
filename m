Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E82D216E19
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 15:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgGGNyj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 09:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgGGNyi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 09:54:38 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B175CC061755
        for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2020 06:54:38 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id t187so1172637vke.5
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2020 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S3jdzOO32cHlgwmkrkbUpdIm/1MzyDL/EIRbxMTEa5A=;
        b=Z7xophkPQOkh4ARlxVwFuQJQTBEkSwbOlfOmHHyVle/OWVRWv195/0w2f2t+18snII
         n3FQ2codAubRjrUSwmyf3H/bvuc0OsNnp3dke2n7VO6YXh/6U9sff01yJTCcBXB97N4O
         6B26hIolpF+/goAhq8UKgXegM8/9vMeegLeLdtHGeuWYpcRucq5jfbOcGwqaVg8ngSrA
         1JAP0gkX+J8Um4gTC2fymZhoWIPl9qMkepe+SA81ejzI+RbrXNzlK46JX9YIvPugCwKS
         f8ceM9b+8mKnMjWN+emWh7vUYj6LvvjD7sNWmzfTZebUC506AFLaUOgH5ESXowrLhRpq
         RYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S3jdzOO32cHlgwmkrkbUpdIm/1MzyDL/EIRbxMTEa5A=;
        b=QaQ2uhl/NkbkhJ1Et5W5jN4bWubYciiUh1eJiLufcxQozFsnpG+BtHTVjezD+NFZyd
         /QTqu9bMD8c71dKNOzBwLDgUzQNWcuWUOjOUuDOYWnuoctKMz1ydEtt3C2IWeuzAr2FM
         wUIPZKS+in61C0WMHVHqGfRq1tuWJFhrXo9rlfASyRXRZ7ZXodQNt/szl4h4Snpf32bi
         5dbgTL/u7SoRQLWtmfkzU2ksaNrbzn7+PxUnCmMcz1UWGsfPtJa7FgLOglQ+3dyLMalw
         BchObHdRjBGpJRFwa3yRGfoP8D7mPC8+qfkDw367CpvPHFv7b2y9PGbJAzRqlqmpfLnD
         zlSA==
X-Gm-Message-State: AOAM532XK94GPuFOJIdski0IbI6zuraGT1eW6PeKib3XvR7ph39hZ9vn
        ViS0J8i5r0/fcY4Sn4pKGllRnhfmVFEvZE7hvC4JPQ==
X-Google-Smtp-Source: ABdhPJw9SoRYf79I1P+jKjjZvaJuTnoqHslNrUEV0toooQ5NEaW+6rlt/daKxhkuVtAbPlSqKvED9krSaR3HLLT6Tbw=
X-Received: by 2002:a1f:1889:: with SMTP id 131mr29817788vky.59.1594130077760;
 Tue, 07 Jul 2020 06:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200624103247.7115-1-daniel.baluta@oss.nxp.com> <20200624103247.7115-2-daniel.baluta@oss.nxp.com>
In-Reply-To: <20200624103247.7115-2-daniel.baluta@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Jul 2020 15:54:01 +0200
Message-ID: <CAPDyKFr8BTkM2W_qbXK1KxtuoZC=uO14_uY9zCWvzfyU0h1a6Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM / domains: Introduce multi PM domains helpers
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        alsa-devel@alsa-project.org, dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 24 Jun 2020 at 12:33, Daniel Baluta <daniel.baluta@oss.nxp.com> wrote:
>
> From: Daniel Baluta <daniel.baluta@nxp.com>
>
> This patch introduces helpers support for multi PM domains.
>
> API consists of:
>
> 1) dev_multi_pm_attach - powers up all PM domains associated with a given
> device. Because we can attach one PM domain per device, we create
> virtual devices (children of initial device) and associate PM domains
> one per virtual device.
>
> 2) dev_multi_pm_detach - detaches all virtual devices from PM domains
> attached with.

Nit pick:
I suggest to rename the helpers into
dev_pm_domain_attach|detach_multi(), to be more consistent with
existing function names. It's a bit long I admit that, but I prefer
the consistency.

>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  drivers/base/power/common.c | 93 +++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   | 19 ++++++++
>  2 files changed, 112 insertions(+)
>
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index bbddb267c2e6..b0a4d0109810 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -228,3 +228,96 @@ void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd)
>         device_pm_check_callbacks(dev);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_domain_set);
> +
> +/**
> + * dev_multi_pm_attach - power up device associated power domains
> + * @dev: The device used to lookup the PM domains
> + *
> + * Parse device's OF node to find all PM domains specifiers. For each power
> + * domain found, create a virtual device and associate it with the
> + * current power domain.
> + *
> + * This function should typically be invoked by a driver during the
> + * probe phase, in the case its device requires power management through
> + * multiple PM domains.
> + *
> + * Returns a pointer to @dev_multi_pm_domain_data if successfully attached PM
> + * domains, NULL when the device doesn't need a PM domain or when single
> + * power-domains exists for it, else an ERR_PTR() in case of
> + * failures.
> + */
> +struct dev_multi_pm_domain_data *dev_multi_pm_attach(struct device *dev)
> +{
> +       struct dev_multi_pm_domain_data *mpd, *retp;
> +       int num_domains;
> +       int i;
> +
> +       num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
> +                                                "#power-domain-cells");
> +       if (num_domains < 2)
> +               return NULL;

dev_pm_domain_attach_* is typically wrapper functions, allowing
different types of PM domains to be supported. For example,
dev_pm_domain_attach() calls acpi_dev_pm_attach() and
genpd_dev_pm_attach(). While dev_pm_domain_attach_by_id() only calls
genpd_dev_pm_attach_by_id(), as there's no corresponding interface for
the acpi PM domain.

The above said, I don't think another layer should be needed here, but
there is something missing that makes this consistent with the
behaviour of the above mentioned functions.

How about adding a genpd OF helper ("of_genpd_num_domains(struct
device_node *)"), that deals with the above parsing and returns the
number of domains for the device? In this way, if
of_genpd_num_domains() returns an error code or zero, it's easier to
continue to try with other PM domain providers (if/when that is
supported).

> +
> +       mpd = devm_kzalloc(dev, sizeof(*mpd), GFP_KERNEL);
> +       if (!mpd)
> +               return ERR_PTR(-ENOMEM);
> +
> +       mpd->dev = dev;
> +       mpd->num_domains = num_domains;
> +
> +       mpd->virt_devs = devm_kmalloc_array(dev, mpd->num_domains,
> +                                           sizeof(*mpd->virt_devs),
> +                                           GFP_KERNEL);
> +       if (!mpd->virt_devs)
> +               return ERR_PTR(-ENOMEM);
> +
> +       mpd->links = devm_kmalloc_array(dev, mpd->num_domains,
> +                                       sizeof(*mpd->links), GFP_KERNEL);
> +       if (!mpd->links)
> +               return ERR_PTR(-ENOMEM);
> +
> +       for (i = 0; i < mpd->num_domains; i++) {
> +               mpd->virt_devs[i] = dev_pm_domain_attach_by_id(dev, i);
> +               if (IS_ERR(mpd->virt_devs[i])) {
> +                       retp = (struct dev_multi_pm_domain_data *)
> +                               mpd->virt_devs[i];
> +                       goto exit_unroll_pm;
> +               }
> +               mpd->links[i] = device_link_add(dev, mpd->virt_devs[i],
> +                                               DL_FLAG_STATELESS |
> +                                               DL_FLAG_PM_RUNTIME |
> +                                               DL_FLAG_RPM_ACTIVE);

As a suggestion to be a little bit more flexible, perhaps these bits
should be given as an in-parameter instead. Potentially we could then
also treat the in-parameter being zero, as that no device link should
be added.

Although, it's kind of hard to know as the users of this interface
aren't really widely known yet.

> +               if (!mpd->links[i]) {
> +                       retp = ERR_PTR(-ENOMEM);
> +                       dev_pm_domain_detach(mpd->virt_devs[i], false);
> +                       goto exit_unroll_pm;
> +               }
> +       }
> +       return mpd;
> +
> +exit_unroll_pm:
> +       while (--i >= 0) {
> +               device_link_del(mpd->links[i]);
> +               dev_pm_domain_detach(mpd->virt_devs[i], false);
> +       }
> +
> +       return retp;
> +}
> +EXPORT_SYMBOL(dev_multi_pm_attach);
> +

[...]

Kind regards
Uffe
