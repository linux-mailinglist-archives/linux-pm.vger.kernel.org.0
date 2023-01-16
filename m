Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618A666B694
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jan 2023 05:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjAPEWg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Jan 2023 23:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjAPEWf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Jan 2023 23:22:35 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FC47287
        for <linux-pm@vger.kernel.org>; Sun, 15 Jan 2023 20:22:33 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so6210055pjg.4
        for <linux-pm@vger.kernel.org>; Sun, 15 Jan 2023 20:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V4AipfI/iK8A9nWR8uHBzE1Au7+7lYwBA32fQTU1Bf4=;
        b=iBTRajiMLnDLPqFgeD7Gg8QtbQw7bUVHlt735KuJGhNsL9HKRc4q21YLfg8pyoZalb
         +4Ug+QvwqyGN3AwNBPWG5LVXAVGZcujttrTpXKwc/l3tIcprw1i2ThzMkuz10nC9J6uN
         K+gKHSHyviIpfJJEGr4z8eXTxUvUNFPvsgvXWv5ubZgChOu3cbla7XUxdW+CbcbK0n5g
         CyUEk/74X7D/AB4KnW9mDYd8Xcxgvm1FNu16rGawWXYKDsRQZ+6iTsJrFmYrRIA06zYp
         vM4ZNl57DO0szYooc/ltgTcNJCk8ObXCJ9e6d/Oqaq9lKYqxXcqQfloCtF0NS2tyRhOE
         9psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4AipfI/iK8A9nWR8uHBzE1Au7+7lYwBA32fQTU1Bf4=;
        b=KIlXxjlcDGy4afvfHe+dm9IInYZo7zieL9UFoTsq11P83V/NUhRIRMffebSc4Ti84V
         Avw1N2uoGfRkKi9k7pPBG/f8gl8T1wL57z4rwp8Ucw40mWBQ2CfSmaR8/OqXPCy12Nue
         owIa0Fgse/GGCbkg1+8HCxGyUVvigMMG2qgkHDutOwVZaW9K1iFv+HCh/7MU6LvYovAv
         J+FxJ9d7qLMwoyErrhTMCm9GJ0HiUgGFh5UF5StQ2T+HyljRFa0qezY2WVTWM7BUSqME
         QzJvHa6QxNQne+BLffjudyRhhK4yT6hE6wvbW1PsJDXYCQ2XPH//1ue1By4R0rsRCKQz
         vdTA==
X-Gm-Message-State: AFqh2kqq9Ej7Wd0iHBZv7re8IdfegMMT/WfIFe1Qs5aJwHjBSkA3BFGS
        ZAM7fLXA7usek8oavb3s5T9+ng==
X-Google-Smtp-Source: AMrXdXt6jwveiODO9LfqVVkItCEVb/PE9nw5AGhWXSZq37Psv3Cws5CAc28SwKEbgdFmGvXXXgfjmg==
X-Received: by 2002:a17:902:eb8d:b0:194:8292:b1a1 with SMTP id q13-20020a170902eb8d00b001948292b1a1mr7057535plg.66.1673842952922;
        Sun, 15 Jan 2023 20:22:32 -0800 (PST)
Received: from localhost ([122.172.81.45])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b001928c204428sm3095023pln.142.2023.01.15.20.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 20:22:32 -0800 (PST)
Date:   Mon, 16 Jan 2023 09:52:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] thermal/core: fix potential unbalanced put_device during
 register
Message-ID: <20230116042230.qyfyirm7nh4ozlk2@vireshk-i7>
References: <20221231210301.6968-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231210301.6968-1-caleb.connolly@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31-12-22, 21:03, Caleb Connolly wrote:
> Commit c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
> causes device_put() to be called if the get_max_state() callback fails
> during __thermal_cooling_device_register().
> 
> Fix the cleanup ordering to only call device_put() if initialization
> fails after the matching device_register() call.
> 
> Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Should it be like this instead ?

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index f17ab2316dbd..18db011d4d68 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -910,17 +910,15 @@ __thermal_cooling_device_register(struct device_node *np,

        ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
        if (ret)
-               goto out_kfree_type;
+               goto out_cdev_type;

        thermal_cooling_device_setup_sysfs(cdev);
        ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
-       if (ret) {
-               thermal_cooling_device_destroy_sysfs(cdev);
-               goto out_kfree_type;
-       }
+       if (ret)
+               goto out_cooling_dev;
        ret = device_register(&cdev->device);
        if (ret)
-               goto out_kfree_type;
+               goto out_put_device;

        /* Add 'this' new cdev to the global cdev list */
        mutex_lock(&thermal_list_lock);
@@ -939,11 +937,12 @@ __thermal_cooling_device_register(struct device_node *np,

        return cdev;

-out_kfree_type:
+out_put_device:
+       put_device(&cdev->device);
+out_cooling_dev:
        thermal_cooling_device_destroy_sysfs(cdev);
+out_cdev_type:
        kfree(cdev->type);
-       put_device(&cdev->device);
-       cdev = NULL;
 out_ida_remove:
        ida_free(&thermal_cdev_ida, id);
 out_kfree_cdev:

-- 
viresh
