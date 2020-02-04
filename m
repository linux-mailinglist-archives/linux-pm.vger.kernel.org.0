Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0BE151E38
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2020 17:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgBDQXJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Feb 2020 11:23:09 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:40341 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgBDQXJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Feb 2020 11:23:09 -0500
Received: by mail-vk1-f195.google.com with SMTP id c129so5333492vkh.7
        for <linux-pm@vger.kernel.org>; Tue, 04 Feb 2020 08:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ea6CDByKgSbDMkqbEgMOnAWDJppEuzPTacXPBXjbpgg=;
        b=lXCbSwzxafLM6raSAdWogoEHnO/mTBZD3bcocFBdYquY+ylaHskUaAIPOpm5ZF4vfe
         5G+IMeYmCFkLMv2064sPCqXmUD5JjEVGGnhFN4QptJL9Ffy0ppVxkro0Qb+pTTlyo3gX
         qzYbZsN7wrNsiOQKPuhW3cv1pUnsW9CbWE53RSyVpL9YQITT1a+Rfr0M1d1LwwgDrf0C
         RT04I35DZYseJxv8/qZx96j89aQhI8gcRQTByB5eGO1Pxz+rB1R7rZH5FEhk+VualXt7
         eB/RTzHU+uERuUQ1xAP7Xf7Q4fdYZwhhSYjJ1HdbJ4kTHqHylJaNzyc1oFsXNYNAGzLl
         Oz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ea6CDByKgSbDMkqbEgMOnAWDJppEuzPTacXPBXjbpgg=;
        b=d2YuL8QxlwL3BkSj9MmZa6vgArEfML96fn7V3jZ9wi0KMXnVH0zzcJ9JYyoSS++wbE
         8KaBcu3I1iflAgcYlaH5QEmT9dNGG4ERYPG75NSFoNQWupVGNlEHZjbptIDTq7MN10kt
         plWNyAjWkfwS7cetKIT3RQqjx0tFQGspPuFUGT+U/h56RpD/fugXcleEyux2rlYiCKJk
         Z4BLvlVv88DyZUZp+XARczyan6/htKYNfeee2fQXiYJNgtVUjhrQc5wSbISEMlarnhlm
         LLQ7+Om2IrP6reDYXn0OTtBnA1XPGdV5iFsdrbG91A5Y/JzZgv4g3cF5VF9PFBAh4jiH
         cZjw==
X-Gm-Message-State: APjAAAWK055BBJDqogbeGL33l0vm+lxBXkjVk3HmVGLTfIPuLW+hZaGz
        1RUCEV0cAu+uCWaPNOk55SykJ3hWviO51qM5cYJptE0N
X-Google-Smtp-Source: APXvYqxWM9fd6TMYJGwvNp5QFj5S6ty/tZWeIxo/riCcbo9OzCBtnZc9dh8yM76cDOmNEVNYb5HxComQmEn6RDn1Zd0=
X-Received: by 2002:a1f:914b:: with SMTP id t72mr18118471vkd.101.1580833387699;
 Tue, 04 Feb 2020 08:23:07 -0800 (PST)
MIME-Version: 1.0
References: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org> <1574254593-16078-4-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1574254593-16078-4-git-send-email-thara.gopinath@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Feb 2020 17:22:31 +0100
Message-ID: <CAPDyKFozvt-LdxwkCB9C+t-mR-CZ37HigsB88z9Tj_SzKfRBLg@mail.gmail.com>
Subject: Re: [Patch v4 3/7] thermal: core: Allow cooling devices to register a parent.
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 20 Nov 2019 at 13:56, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> With introduction of power domain warming devices, devices that control the
> power domain are registered as the parent of the cooling device so that the
> device-genpd hierarchy in kernel is maintained intact. To enable this,
> introduce a new API thermal_of_cooling_device_parent_register that takes a
> parent device pointer as input. Also, modify
> __thermal_cooling_device_register to register parent of a newly created
> cooling device, if specified.

I am not sure I understand the reasons why you need this, can you
please elaborate?

I remember we talked about using a "parent" device to deal with device
attaching to PM domains (genpd). However, since the DT bindings for
"warming devices" was concluded to consist by a single property
("#cooling-cells") as a part of the PM domain provider node, this
seems not to be needed.

By looking at patch 4/7, you are attaching devices via
of_genpd_add_device() and I don't see any need for using a "parent" in
there.

Can $subject patch be dropped or what am I missing?

Kind regards
Uffe

>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 22 +++++++++++++++++++---
>  include/linux/thermal.h        | 15 +++++++++++++++
>  2 files changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index d4481cc..912ba75 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -947,6 +947,7 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
>   */
>  static struct thermal_cooling_device *
>  __thermal_cooling_device_register(struct device_node *np,
> +                                 struct device *parent,
>                                   const char *type, void *devdata,
>                                   const struct thermal_cooling_device_ops *ops)
>  {
> @@ -979,6 +980,8 @@ __thermal_cooling_device_register(struct device_node *np,
>         cdev->ops = ops;
>         cdev->updated = false;
>         cdev->device.class = &thermal_class;
> +       if (parent)
> +               cdev->device.parent = parent;
>         cdev->devdata = devdata;
>         thermal_cooling_device_setup_sysfs(cdev);
>         dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
> @@ -1024,7 +1027,8 @@ struct thermal_cooling_device *
>  thermal_cooling_device_register(const char *type, void *devdata,
>                                 const struct thermal_cooling_device_ops *ops)
>  {
> -       return __thermal_cooling_device_register(NULL, type, devdata, ops);
> +       return __thermal_cooling_device_register(NULL, NULL, type,
> +                                                devdata, ops);
>  }
>  EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
>
> @@ -1048,10 +1052,22 @@ thermal_of_cooling_device_register(struct device_node *np,
>                                    const char *type, void *devdata,
>                                    const struct thermal_cooling_device_ops *ops)
>  {
> -       return __thermal_cooling_device_register(np, type, devdata, ops);
> +       return __thermal_cooling_device_register(np, NULL, type, devdata, ops);
>  }
>  EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
>
> +struct thermal_cooling_device *
> +thermal_of_cooling_device_parent_register(struct device_node *np,
> +                                         struct device *parent,
> +                                         const char *type, void *devdata,
> +                                         const struct
> +                                         thermal_cooling_device_ops *ops)
> +{
> +       return __thermal_cooling_device_register(np, parent, type,
> +                                                devdata, ops);
> +}
> +EXPORT_SYMBOL_GPL(thermal_of_cooling_device_parent_register);
> +
>  static void thermal_cooling_device_release(struct device *dev, void *res)
>  {
>         thermal_cooling_device_unregister(
> @@ -1088,7 +1104,7 @@ devm_thermal_of_cooling_device_register(struct device *dev,
>         if (!ptr)
>                 return ERR_PTR(-ENOMEM);
>
> -       tcd = __thermal_cooling_device_register(np, type, devdata, ops);
> +       tcd = __thermal_cooling_device_register(np, NULL, type, devdata, ops);
>         if (IS_ERR(tcd)) {
>                 devres_free(ptr);
>                 return tcd;
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index e45659c..ac5f268 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -448,6 +448,11 @@ struct thermal_cooling_device *
>  thermal_of_cooling_device_register(struct device_node *np, const char *, void *,
>                                    const struct thermal_cooling_device_ops *);
>  struct thermal_cooling_device *
> +thermal_of_cooling_device_parent_register(struct device_node *np,
> +                                         struct device *parent,
> +                                         const char *, void *, const struct
> +                                         thermal_cooling_device_ops *);
> +struct thermal_cooling_device *
>  devm_thermal_of_cooling_device_register(struct device *dev,
>                                 struct device_node *np,
>                                 char *type, void *devdata,
> @@ -508,6 +513,16 @@ static inline struct thermal_cooling_device *
>  thermal_of_cooling_device_register(struct device_node *np,
>         char *type, void *devdata, const struct thermal_cooling_device_ops *ops)
>  { return ERR_PTR(-ENODEV); }
> +
> +static inline struct thermal_cooling_device *
> +thermal_of_cooling_device_parent_register(struct device_node *np,
> +                                         struct device *parent,
> +                                         const char *, void *, const struct
> +                                         thermal_cooling_device_ops *)
> +{
> +       return ERR_PTR(-ENODEV);
> +}
> +
>  static inline struct thermal_cooling_device *
>  devm_thermal_of_cooling_device_register(struct device *dev,
>                                 struct device_node *np,
> --
> 2.1.4
>
