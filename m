Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BF3672A10
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 22:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjARVMm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 16:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjARVMU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 16:12:20 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2017613DA
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:11:33 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so2567988wmq.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCSbK/tUS4YMZH0NcLQxGFkztwrDFcL8VnBPGZktFY8=;
        b=xPY9/cO5/EuIVs4Cgywdqilx19aJ2ZwAnPWfnirCJG4lFggV0Tb+b9mheTBTeC6huW
         uUahlnhzRxpClnTTBHinSMDk8vc1ykObxIGduJ4/Bi5J9Zt657ed7U0HW7Ln7DFnQ8TU
         v5UUYzT2+UZjx8Phie1RHQaUQdNvQGfvHwklMMnhTgOKNPLBRcBtE3oGWHh5SovVdl43
         2a+ZAKuaCoS1UViHY+ljukwjO7xdJAJ2Eiy3xf/Fnh7/F8pLfJTEJUFtcD58xXujdbFj
         SNAX3QrB8xX2svHYV/FINCWrt02JyzknaHIVgJMVFRTXA8HWKugswWxff4psoameKk93
         zbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCSbK/tUS4YMZH0NcLQxGFkztwrDFcL8VnBPGZktFY8=;
        b=o726uPLY1dJViWLwYFDFBo8e1EuPMPmkLry1I9IonB4p23KX/0Qm/LuYiqqjIeXTgS
         j+xF/GLqzVwjcHAQSWZd0sxKdQuQYogDpAzkjP/mwZJqdBGvA/MxDKArEZ7msqv7HsT+
         KgWdPJ4myFPbOsuQ4zceBHzJdTqWi7UOfzJI55tNR1PX2tgNLdK4k0ZyMbj/YhfaQ3kG
         3lCJnpslF5aqAJzKUNEinUQ8TNA3ikyonJPZ3L+DTCRdG1OcAZY04+in3GwtkCpm6lDS
         kHkwgPLI8lug84meA+imFQDkvSvb4WQxX5PmY5FH5bgG1jmwrNGSWvBJL9ofgl3Id7y1
         EIHw==
X-Gm-Message-State: AFqh2kpHHOVLI2Ai5tOXts3JFEoD8T//VIFtIhchgJWeRvrOgh5ro7mh
        rAI5zd9oAtHpvoU5EhZM9lhSlw==
X-Google-Smtp-Source: AMrXdXsQlKfp9joAHrVTBIXGNJsySK0e6291IUNQXhbBxKS20zOHcKxK7DQbr9aI9LFWHEZSbP2Nyw==
X-Received: by 2002:a05:600c:3ba9:b0:3da:b40f:7a55 with SMTP id n41-20020a05600c3ba900b003dab40f7a55mr14931741wms.6.1674076292174;
        Wed, 18 Jan 2023 13:11:32 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c2cdb00b003d99da8d30asm3198835wmc.46.2023.01.18.13.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:11:31 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] thermal/core: Remove unneeded ida_destroy()
Date:   Wed, 18 Jan 2023 22:11:20 +0100
Message-Id: <20230118211123.111493-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118211123.111493-1-daniel.lezcano@linaro.org>
References: <20230118211123.111493-1-daniel.lezcano@linaro.org>
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

