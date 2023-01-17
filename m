Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C18966DF03
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jan 2023 14:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjAQNjn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Jan 2023 08:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjAQNjk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jan 2023 08:39:40 -0500
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1AF59C6
        for <linux-pm@vger.kernel.org>; Tue, 17 Jan 2023 05:39:38 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id m21so45090050edc.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Jan 2023 05:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=530YtqvO0BjruoQ9aNyLROGRGrWGgv42VGG3bkVoSJ4=;
        b=Rd9kz7iEmx1vvvCCnasno2Z2SucmtIorYvtq8lhVTx6oHqkBFAjxeBAcaBvyiEGzgA
         giSHDSlnm2BRe5DoG0Lji2KJl00GpUwrxeCmuehylQj+0FRp23Xvjyo3MMAfaomQpR97
         bQz4F49qSMxIynuyM1D0tQ39UydmoIyWEeSMAVjBkw0SRH85X8aScwcHocnork3zKGsV
         +BAsMuFHCFr5mvuyw7V8NFTk0SKoncFXEt229efi8hCu0FJls9b8CZC/+jXdIZdxp5w8
         XGqb17PQtG/TSa0nzdxnBmhJSl3jj+6usKbfWDzVcENbL7O8isXIygpmmzZZVhfJ0TO8
         toVg==
X-Gm-Message-State: AFqh2koZB1UshXRS7k0lsbFHw5lYM7LiJFkHA78feSaP01M3q9fvFcPO
        ZW8sLNX4AP4LAF2gPW3u+Hth9PMr9skZG9ODdv4=
X-Google-Smtp-Source: AMrXdXuf7YpD/le5byrrpsdNnD8FzBVMcrxpwXRcA6himy5wyal9mldLFLUZG582pu9UKXi85DI6KSw24fkvQdYGv1s=
X-Received: by 2002:a05:6402:ea2:b0:46a:b1a9:c34e with SMTP id
 h34-20020a0564020ea200b0046ab1a9c34emr450873eda.212.1673962777549; Tue, 17
 Jan 2023 05:39:37 -0800 (PST)
MIME-Version: 1.0
References: <20230112154721.452292-1-caleb.connolly@linaro.org>
 <20230116042326.l3kyd55lbw4dfocm@vireshk-i7> <24afe142-f835-29af-fca6-d00e864b0c82@huawei.com>
 <20230117043653.4n2dfruh36x4uazj@vireshk-i7>
In-Reply-To: <20230117043653.4n2dfruh36x4uazj@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jan 2023 14:39:26 +0100
Message-ID: <CAJZ5v0ihaNHneyRwd8nWYUhGKGRpHrVFi7gJsp_g9MX=oLc9Eg@mail.gmail.com>
Subject: Re: [PATCH v3] thermal/core: fix error paths in __thermal_cooling_device_register()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 17, 2023 at 5:36 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 16-01-23, 20:38, Yang Yingliang wrote:
> > The 'cdev' will be freed after calling put_device(), it can not be accessed
> > anymore.
>
> I surely missed the class's release callback :(
>
> How about this then, it clears this in a better way, i.e. what entity
> is responsible for what exactly. This can be divided in a few patches
> for sure.

It looks good to me, but then I haven't caught the release bug too.

> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index f17ab2316dbd..5555bf827a0f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -774,6 +774,9 @@ static void thermal_release(struct device *dev)
>         } else if (!strncmp(dev_name(dev), "cooling_device",
>                             sizeof("cooling_device") - 1)) {
>                 cdev = to_cooling_device(dev);
> +               thermal_cooling_device_destroy_sysfs(cdev);
> +               kfree(cdev->type);
> +               ida_free(&thermal_cdev_ida, cdev->id);
>                 kfree(cdev);
>         }
>  }
> @@ -910,17 +913,18 @@ __thermal_cooling_device_register(struct device_node *np,
>
>         ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
>         if (ret)
> -               goto out_kfree_type;
> +               goto out_cdev_type;
>
>         thermal_cooling_device_setup_sysfs(cdev);
>         ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
> +       if (ret)
> +               goto out_cooling_dev;
> +       ret = device_register(&cdev->device);
>         if (ret) {
> -               thermal_cooling_device_destroy_sysfs(cdev);
> -               goto out_kfree_type;
> +               /* thermal_release() handles rest of the cleanup */
> +               put_device(&cdev->device);
> +               return ret;
>         }
> -       ret = device_register(&cdev->device);
> -       if (ret)
> -               goto out_kfree_type;
>
>         /* Add 'this' new cdev to the global cdev list */
>         mutex_lock(&thermal_list_lock);
> @@ -939,11 +943,10 @@ __thermal_cooling_device_register(struct device_node *np,
>
>         return cdev;
>
> -out_kfree_type:
> +out_cooling_dev:
>         thermal_cooling_device_destroy_sysfs(cdev);
> +out_cdev_type:
>         kfree(cdev->type);
> -       put_device(&cdev->device);
> -       cdev = NULL;
>  out_ida_remove:
>         ida_free(&thermal_cdev_ida, id);
>  out_kfree_cdev:
> @@ -1104,11 +1107,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>
>         mutex_unlock(&thermal_list_lock);
>
> -       ida_free(&thermal_cdev_ida, cdev->id);
> -       device_del(&cdev->device);
> -       thermal_cooling_device_destroy_sysfs(cdev);
> -       kfree(cdev->type);
> -       put_device(&cdev->device);
> +       device_unregister(&cdev->device);
>  }
>  EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
>
> --
> viresh
