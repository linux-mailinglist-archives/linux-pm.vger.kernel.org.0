Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88685765CC
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 19:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiGOROq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 13:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiGOROp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 13:14:45 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB213DF2E
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 10:14:43 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id e69so9504445ybh.2
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 10:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6lgkGF27ppP4xIoTblKRaWHla5PJC44YCQpQrJaz3s=;
        b=fEgpW8YjkuiNdzC9ilB//9WCGQgORjqMicLz0vjje1VmKCh68GmFoDKvCMhz0ScHdx
         9W+4s4N2QdyIUNQI7H5Tuq1Xqa7Y+fRd39rSmYfHWCCFj+xvH59FP3QHoC+3Jyz17NBG
         RdLMRld9Nuyrhkz+7A0fZ+FFsTnRCUnQQc+6BWW4LwnrxIN1NNHurvC/YZEi8TC9RJ6V
         E5zYtWwUcEUXd2+Lc+zItePLBS4KQUGiFpqHsbHrVbSB2+IQh+PU+Qh9CC59vAu89QIl
         5nkWAf2ORA4Xj9F+pIPsSKwg0/ePMZwZSjaFFS9c2AEBiJG4UhiTystwnRc89A8EiVzP
         e7gw==
X-Gm-Message-State: AJIora9o2IXStmRawtKGbN6UwQuLNz4/jgLZB+OlFi8g1/l723OOaq+W
        BVrO5EkxWcScnK25CNpoYo9VbIeGSdDwM31SJxU+TFFFwDA=
X-Google-Smtp-Source: AGRyM1vkNSQ21QZqsZulKBGy+2qDPlxNJXA3x9Y2UbUz7ve46Qb54484FtDud/JneW0b1sgy/XWSOgmJqLB1ZDEY+ls=
X-Received: by 2002:a25:664f:0:b0:66c:d0f4:36cc with SMTP id
 z15-20020a25664f000000b0066cd0f436ccmr14544906ybm.482.1657905283136; Fri, 15
 Jul 2022 10:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220707062112.308239-1-windhl@126.com>
In-Reply-To: <20220707062112.308239-1-windhl@126.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jul 2022 19:14:31 +0200
Message-ID: <CAJZ5v0iOF3n98byY5C4zAjM=AbxDiUHF9vqEp78i6_jg8M5MqQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Fix refcount bugs in __thermal_cooling_device_register()
To:     Liang He <windhl@126.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Thu, Jul 7, 2022 at 8:21 AM Liang He <windhl@126.com> wrote:
>
> For each new reference of 'device_node', we should increase its
> refcount. Otherwise, there will be premature free.
>
> For example, in drivers\thermal\tegra\soctherm.c, the function
> soctherm_init_hw_throt_cdev() will use for_each_child_of_node() to
> iterate its child device_node which will be then passed into
>  __thermal_cooling_device_register(). As for_each_xxx OF APIs will
> automatically increase and decrease the refcount of 'device_node',
> we should use additional of_node_get() to record the new refernece.

reference

>
> NOTE, we should also call the corresponding of_node_put() in fail path
> or when the *_unregister() function is called.

The NOTE in capitals above is somewhat confusing.  I would just say
"Accordingly, the corresponding of_node_put() needs to be run in the
error code path and on cooling device unregistration."

>
> Fixes: a116b5d44f14 ("thermal: core: introduce thermal_of_cooling_device_register")
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  I cannot confirm, in *_unregister, we should put of_node_put() in or
> out of the *_lock/*_unlock functions. Please check it carefully.

This doesn't matter too much AFAICS.

Please note that the of_node_put() can still "leak" into the critical
section through the "unlock" operation, because the latter is not a
full memory barrier.

Moreover, dropping the reference means that the object in question
won't be used any more by the holder of that reference and it is no
reason I can see why it would be necessary to hold the lock while
doing that.

>  drivers/thermal/thermal_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index cdc0552e8c42..c459e2958b7b 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -919,7 +919,7 @@ __thermal_cooling_device_register(struct device_node *np,
>
>         mutex_init(&cdev->lock);
>         INIT_LIST_HEAD(&cdev->thermal_instances);
> -       cdev->np = np;
> +       cdev->np = of_node_get(np);
>         cdev->ops = ops;
>         cdev->updated = false;
>         cdev->device.class = &thermal_class;
> @@ -947,6 +947,7 @@ __thermal_cooling_device_register(struct device_node *np,
>         return cdev;
>
>  out_kfree_type:
> +       of_node_put(cdev->np);
>         thermal_cooling_device_destroy_sysfs(cdev);
>         kfree(cdev->type);
>         put_device(&cdev->device);
> @@ -1111,6 +1112,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>
>         mutex_unlock(&thermal_list_lock);
>
> +       of_node_put(cdev->np);

Could this be done right before the
thermal_cooling_device_destroy_sysfs() below?  Then the sequence would
be completely analogous to the error code path above.

>         ida_simple_remove(&thermal_cdev_ida, cdev->id);
>         device_del(&cdev->device);
>         thermal_cooling_device_destroy_sysfs(cdev);
> --

Overall, this looks like a genuine fix to me.

Daniel, what do you think?
