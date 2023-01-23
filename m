Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936C3677FB4
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jan 2023 16:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjAWP2X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Jan 2023 10:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjAWP2V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Jan 2023 10:28:21 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CE01A483
        for <linux-pm@vger.kernel.org>; Mon, 23 Jan 2023 07:28:19 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso10869005wmc.4
        for <linux-pm@vger.kernel.org>; Mon, 23 Jan 2023 07:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCSbK/tUS4YMZH0NcLQxGFkztwrDFcL8VnBPGZktFY8=;
        b=uyaRiBmICBscn5Hvad+35Hy9+6kvUZMcyuWmCN6ldtS0KNu7c9HY0LDYJ1AwewYgDM
         kb1h3iTr1di9kumeJgH/g/EPDztoTRFe1XSTlaVGtE2RJPmYA44NTD9n7wMpjq9YDi1Z
         in66J8z9Iyik0qM/+Om942KRYa9f51CJCwvtgz70+lSy1iLyjriGJ1JtYcub70DLj+eg
         7ocU9iGyG7B6EaBa/T08NMVjCJbY1D3xRgceevr58wqeALKg5DC6vNoE7OTT4M3R+fGF
         kimqAwIxO8upbHfOXwxyy7Y7lr1OOONEItI/YFZiZH67Jr9flZoDYyTbQRhkO5x4hs60
         464g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCSbK/tUS4YMZH0NcLQxGFkztwrDFcL8VnBPGZktFY8=;
        b=tcREZBQiZx1j+sNKmwyvliKzI4yRNUKM+6mmB+zD070rp0wXm/uoB70w+Ao9OW7570
         /ca16BQ3T0dMmV3A61KM2AYpR3T+/2OY01m3vACTtAXccw4ynKjWIrX4mQAyreWVV0+I
         SYTcqpo7r5pAvUqBAf+TCY1zjwNkwJJzeqKYHJMNSGJ9ZW8GsYheOvlCWBuuL3xUd/B7
         aJUa4oGUF5qnaNiYnkao+4UvtULgxGl2iKfEQugM6nMoRTkx5UL0yTVvFwdhbRoD5yfc
         ttjJSe56KqnGXGbUu+pqwc0tm9VSKdCKRffhEvca7Z4vIHOHh7QGJowL/KtehqIV1AOX
         jjRQ==
X-Gm-Message-State: AFqh2korNoR+CUr5TQ+xvlXGkOmC73uuHp8YqlHc4LqZZrv8PgmyucVB
        rLjye3jMnH4ohDn2mGcawllSnxlGPEbY2BVy
X-Google-Smtp-Source: AMrXdXvwGIAq3D7pbn5/Gf5ZWWv5J71Ul+DVWq6kr4bpvl7s/tCVcYw/R9t45Yt6u13NEhgoTrNkSw==
X-Received: by 2002:a05:600c:510d:b0:3da:f719:50cd with SMTP id o13-20020a05600c510d00b003daf71950cdmr23287652wms.18.1674487697983;
        Mon, 23 Jan 2023 07:28:17 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id t13-20020a1c770d000000b003db1ca20170sm10673096wmi.37.2023.01.23.07.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:28:17 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 2/3] thermal/core: Remove unneeded ida_destroy()
Date:   Mon, 23 Jan 2023 16:27:55 +0100
Message-Id: <20230123152756.4031574-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123152756.4031574-1-daniel.lezcano@linaro.org>
References: <20230123152756.4031574-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As per documentation for the ida_destroy() function: "If the IDA is
already empty, there is no need to call this function."

The thermal framework is in the init sequence, so the ida was not yet
used and consequently it is empty in case of error.

There is no need to call ida_destroy(), let's remove the calls.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index fddafcee5e6f..fad0c4a07d16 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1624,8 +1624,6 @@ static int __init thermal_init(void)
 unregister_netlink:
 	thermal_netlink_exit();
 error:
-	ida_destroy(&thermal_tz_ida);
-	ida_destroy(&thermal_cdev_ida);
 	mutex_destroy(&thermal_list_lock);
 	mutex_destroy(&thermal_governor_lock);
 	return result;
-- 
2.34.1

