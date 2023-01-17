Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5152366D563
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jan 2023 05:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbjAQEhA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Jan 2023 23:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbjAQEg7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2023 23:36:59 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672A122DE1
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2023 20:36:57 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id q64so31130173pjq.4
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2023 20:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dtSp/ye/K6snLKwOFBdROoR/C0mh3/eIV4a4nEEJzec=;
        b=NrFwlsom/Br0x/ahm3qp4cVTkeitF67/nSUDrAcBaK3ABWRBwJ7G09M4cwqoQ3DebQ
         izBaXen29nWZE6j0MjnYWKOKekgLXoiTf+zeoc9oxrxOpQPBCwAVqlEWV8vXg8gfIb4q
         qACQPXa5m2sMYjZ/4aXbhvu2oxsh5AIufkiOyAH/zEXHiFrAsiH6+xHSvPhvGWDmiM8p
         TRLlazOjqVZSRUTNrLYCWCEnWOpCyx9T6LIz1x2sG7vqmnKHI8wAbQCDd80mLZZb0M7/
         hRdPlSEQLKwBNCnfR1ni5DVOu2piNdPmo2jffRz7FAwjw2iunIZwP4T6qRPSMyTenBvM
         WlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtSp/ye/K6snLKwOFBdROoR/C0mh3/eIV4a4nEEJzec=;
        b=MfgTBwXLyBUKJxln3/a6z2r3gvxyt+T6YqwU38VT0kco3eacNzpc7VMa5q+5lQA/rk
         kJ4AGtuwyDuTxhhiLjnzHRKels09u8CMYd+eNweaKkUOo35m7uVgHGXKEhJemhR501xl
         eHU1WpOheek/1pQUMVES5PwQTJszfWiSg+pGIYEtuHawclZ9Q9KoLyJZ4KrtunRpdJd3
         KArCGeBfZMmcfGFcjMmgFLoF0iS7ETlewaSAA9oy7O55kjIxZenYeSNifC6Z7Lc1Lcg0
         OavlfQ1K7cZdEEVwfyL5Gi6AtG7We/OkUexfvsnO9WFkY9QXc4rSWEjCF5tIm8THNSP5
         sOeQ==
X-Gm-Message-State: AFqh2koK3qYKj2Cnr0BE4MY2JbYCYA80o3oU656QjsL5DCEiYvH4Gdgb
        i3nIGzfLwaAXGbo2b6HazfQgbQ==
X-Google-Smtp-Source: AMrXdXsbAZMFcNZFKRiiOJ5NfpRqndDlHlW7nmzttWmrUGz+RTNJXse7z5kTwXVBaM1m5udGju2gXA==
X-Received: by 2002:a05:6a20:54aa:b0:b6:99c7:9283 with SMTP id i42-20020a056a2054aa00b000b699c79283mr2522823pzk.12.1673930216884;
        Mon, 16 Jan 2023 20:36:56 -0800 (PST)
Received: from localhost ([122.172.81.45])
        by smtp.gmail.com with ESMTPSA id 35-20020a631563000000b0044ed37dbca8sm16367808pgv.2.2023.01.16.20.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 20:36:55 -0800 (PST)
Date:   Tue, 17 Jan 2023 10:06:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3] thermal/core: fix error paths in
 __thermal_cooling_device_register()
Message-ID: <20230117043653.4n2dfruh36x4uazj@vireshk-i7>
References: <20230112154721.452292-1-caleb.connolly@linaro.org>
 <20230116042326.l3kyd55lbw4dfocm@vireshk-i7>
 <24afe142-f835-29af-fca6-d00e864b0c82@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24afe142-f835-29af-fca6-d00e864b0c82@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-01-23, 20:38, Yang Yingliang wrote:
> The 'cdev' will be freed after calling put_device(), it can not be accessed
> anymore.

I surely missed the class's release callback :(

How about this then, it clears this in a better way, i.e. what entity
is responsible for what exactly. This can be divided in a few patches
for sure.

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index f17ab2316dbd..5555bf827a0f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -774,6 +774,9 @@ static void thermal_release(struct device *dev)
        } else if (!strncmp(dev_name(dev), "cooling_device",
                            sizeof("cooling_device") - 1)) {
                cdev = to_cooling_device(dev);
+               thermal_cooling_device_destroy_sysfs(cdev);
+               kfree(cdev->type);
+               ida_free(&thermal_cdev_ida, cdev->id);
                kfree(cdev);
        }
 }
@@ -910,17 +913,18 @@ __thermal_cooling_device_register(struct device_node *np,

        ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
        if (ret)
-               goto out_kfree_type;
+               goto out_cdev_type;

        thermal_cooling_device_setup_sysfs(cdev);
        ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
+       if (ret)
+               goto out_cooling_dev;
+       ret = device_register(&cdev->device);
        if (ret) {
-               thermal_cooling_device_destroy_sysfs(cdev);
-               goto out_kfree_type;
+               /* thermal_release() handles rest of the cleanup */
+               put_device(&cdev->device);
+               return ret;
        }
-       ret = device_register(&cdev->device);
-       if (ret)
-               goto out_kfree_type;

        /* Add 'this' new cdev to the global cdev list */
        mutex_lock(&thermal_list_lock);
@@ -939,11 +943,10 @@ __thermal_cooling_device_register(struct device_node *np,

        return cdev;

-out_kfree_type:
+out_cooling_dev:
        thermal_cooling_device_destroy_sysfs(cdev);
+out_cdev_type:
        kfree(cdev->type);
-       put_device(&cdev->device);
-       cdev = NULL;
 out_ida_remove:
        ida_free(&thermal_cdev_ida, id);
 out_kfree_cdev:
@@ -1104,11 +1107,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)

        mutex_unlock(&thermal_list_lock);

-       ida_free(&thermal_cdev_ida, cdev->id);
-       device_del(&cdev->device);
-       thermal_cooling_device_destroy_sysfs(cdev);
-       kfree(cdev->type);
-       put_device(&cdev->device);
+       device_unregister(&cdev->device);
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);

-- 
viresh
