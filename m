Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114A666B695
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jan 2023 05:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjAPEXd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Jan 2023 23:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjAPEXb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Jan 2023 23:23:31 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D775C7287
        for <linux-pm@vger.kernel.org>; Sun, 15 Jan 2023 20:23:29 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 7-20020a17090a098700b002298931e366so32308pjo.2
        for <linux-pm@vger.kernel.org>; Sun, 15 Jan 2023 20:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SLyCf/2IeGmlUFEcOK2lG2NqJZ2XAd5PySxNT8i4ADQ=;
        b=PLi4bgdR2DWWkoJfDfBl0ImQlFv7KGJhElSG2dU2uNSNebHqzvbiXsWy1p/WJ6u4G4
         Lu0FSZ8wTTRnvHa5GgteOSmAfi7lkfiER1UVDfhEki7fZA3+QyveJ3SsB3ECZoHVC4dE
         vfcwyZX6Z9UH/mmX+hLkiMJQ4W0qTkgtmHDFz2V3Lp6ahS9N+HwWpIxc4LtplQGPtLHf
         qS23GwTRj/eldsMNY5+GVaOW7TZydlHgs0VUQBsA9u/08HgJMdhxMtIoHA0fO6ypMKf/
         FrhC1Jj2u2PWjs2gtQAg7oEzl+PIGBpFqboj9R6zxBqr2Ra1OmbiwnowRjzFdL9G/kB4
         TIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLyCf/2IeGmlUFEcOK2lG2NqJZ2XAd5PySxNT8i4ADQ=;
        b=00JVK4FFMB6gyHUwOCcuqSqd6ywCchHT9RNUHKb+MkKn8Gd5c7AGGDpWDJdWEnZ69P
         ZKhuQa2c/qLwJl8xFL2r2ZfDyAlVXOLDHBVqkakapALcVr1HRYLcqn++GuUkspnGlfNm
         MBFqss+e9TgenULNb7EadwGiia8T/o4vX/Gu7rnjKm/wnWSBrQ2uou0qZM4+NspyTY1j
         jQaHI57V7DIFbc7utzE/rP19p65Sab3Jy4s7/2/i/KjX/8r/tcCOXLCe//nkCKWMcTmF
         Akdv6vs7iV91SQHOT7mfLWy+qIfCt8qc0j8EtekD4lCZKAo4byYpbJssZ+cMmenczrrF
         EuVg==
X-Gm-Message-State: AFqh2kopXnjurGA3lb7JHkrKZaRjCKj9WRZZNFBqhTZvN3B8La6A+d5+
        +6arj0rT2D45dqlTSbpHshXFcg==
X-Google-Smtp-Source: AMrXdXs2pNiWZLZJS/un7xGFUgkuErFhkXMzBxPghg4xg97k4tnGqHcJsCKZbQZ55KDlmnY6FOomTQ==
X-Received: by 2002:a17:902:a984:b0:192:9a7d:c38a with SMTP id bh4-20020a170902a98400b001929a7dc38amr62881986plb.9.1673843009407;
        Sun, 15 Jan 2023 20:23:29 -0800 (PST)
Received: from localhost ([122.172.81.45])
        by smtp.gmail.com with ESMTPSA id y12-20020a170902e18c00b00192a1dfa711sm11487791pla.258.2023.01.15.20.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 20:23:28 -0800 (PST)
Date:   Mon, 16 Jan 2023 09:53:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3] thermal/core: fix error paths in
 __thermal_cooling_device_register()
Message-ID: <20230116042326.l3kyd55lbw4dfocm@vireshk-i7>
References: <20230112154721.452292-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112154721.452292-1-caleb.connolly@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-01-23, 15:47, Caleb Connolly wrote:
> There is in invalid call to thermal_cooling_device_destroy_sysfs() and
> another to put_device() in the error paths here. Fix them.
> 
> Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Changes since v2:
>  * Rework and simplify into one patch following Yang's suggestions.
> 
> V2: https://lore.kernel.org/all/20230103171811.204196-1-caleb.connolly@linaro.org/
> ---
>  drivers/thermal/thermal_core.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Replied to an earlier version by mistake. Should it be like this ?

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
