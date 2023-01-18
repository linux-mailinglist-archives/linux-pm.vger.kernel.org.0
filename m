Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B613867176A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 10:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjARJXL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 04:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjARJUm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 04:20:42 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3FD75A36
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 00:38:41 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id k13so3607741plg.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 00:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8AmeTIEVUx58Wbd0penu0pGx5Sd8zIQKSjU9tMK1s0=;
        b=fcxxGLXsEhMz1dXR+sW8vGv8hQhFw2nTQq3bG8GW3oPm2WHJOcpNSJCfv6N/Pd5EfF
         gQ7D6TVNnPHDZy2ZAFJBUkDYUA4OV3g2boYlEUnb7XmEpc4oLQb8+I2u3tCJwcyxdskl
         LFYSh8C9+77hbu/5JRCd78RbnRRkWNWLsYefs5nv4hvgIEW/BDKra5AhbQjCuaG4aFLe
         NusRmWiND9VbcJsssJtE/p6ieuXjGVCNEyZNFuZzGcGYFZLKZgD9INuvtCeK3M0ZBQRQ
         zL2nx0F2yUhh5Ek4w13rYMU2yBKI3aoK/d2v/f9wvCsYlhZw/iWHpkiyYuzXbrZrNVYS
         n6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8AmeTIEVUx58Wbd0penu0pGx5Sd8zIQKSjU9tMK1s0=;
        b=A57znhH6q8ULLiBpPzasKHiV8FlTQrVfzw7ATDd3nGwLgNGq2Kyt8MFq3zQCn2AN3G
         Jp1IMHE0yQLUOzSnWWLAZPMCd5FS0V00MYj++FnWBNuKJ57Br2vLPFxqIaOxnye8QVGQ
         UgVgbAf27Fb0Wn9P8Z9NSP40c3ottqvDaVpbMS4zgBJIgMHjOsD3bU2cWPIrEyf/pYn6
         iy8fCuvIEPQUuzyQuAcczx6SCOE/qDge+tc2oVUQ6gGXVOcdXwGVMRBcZZIdlErE9rvT
         61TfcXbJGAReG4QQ6HtH0T9ED+KXKYUvauAguQwsK8VrwFzn7+0MyrIadwFYDX3Kkii2
         FurQ==
X-Gm-Message-State: AFqh2krsdTlrdx8yArLje/cwOUVauncKMkPQgKq3JT/1mJ0wsHrLxv7g
        pIaT+qFxvJYZIDxFfD2BR2fz6w==
X-Google-Smtp-Source: AMrXdXtPjHYpN5DQbvFwLPlpgG7s1EXXuufzxx093G1OB5KnHQTwUfhTgapAMC1qsnVH4q63TuGbfQ==
X-Received: by 2002:a05:6a20:ba90:b0:a6:7529:7c99 with SMTP id fb16-20020a056a20ba9000b000a675297c99mr6357612pzb.5.1674031121455;
        Wed, 18 Jan 2023 00:38:41 -0800 (PST)
Received: from localhost ([122.172.81.45])
        by smtp.gmail.com with ESMTPSA id a20-20020aa794b4000000b0058bb0b8750csm9713730pfl.88.2023.01.18.00.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 00:38:40 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] thermal: core: Use device_unregister() instead of device_del/put()
Date:   Wed, 18 Jan 2023 14:08:26 +0530
Message-Id: <b31022f186287075f60f42facde01b3b42b06d7d.1674030722.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1674030722.git.viresh.kumar@linaro.org>
References: <cover.1674030722.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Lets not open code device_unregister() unnecessarily.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/thermal_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 1fb109a97ff6..9fb37c5d9c4f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1109,8 +1109,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 
 	mutex_unlock(&thermal_list_lock);
 
-	device_del(&cdev->device);
-	put_device(&cdev->device);
+	device_unregister(&cdev->device);
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
 
-- 
2.31.1.272.g89b43f80a514

