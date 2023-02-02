Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3154B687A29
	for <lists+linux-pm@lfdr.de>; Thu,  2 Feb 2023 11:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjBBK2T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Feb 2023 05:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjBBK2S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2023 05:28:18 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0102C654
        for <linux-pm@vger.kernel.org>; Thu,  2 Feb 2023 02:28:16 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bk16so1217893wrb.11
        for <linux-pm@vger.kernel.org>; Thu, 02 Feb 2023 02:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9fd/EVephwRZl8a27MQolPx0SCPi7ZbqIhcNy0drk3Q=;
        b=IbevH9LssY/ncZPrz3XLuoF1WUTDgBmpm7l7H93Kckw3TpzVjO9BnyicZBN4Ghc8PQ
         EGnhMOVuuqHll8zdtGX4mU4582KUuy5NhxkCR99pUGrtkFaN+0GUeaizGAwC45PGxNYD
         bEGMbI90AXp33l8Jdl7gvufn2A0A7uw/bzmvxC0NkYQ4S/SVWeEDbPMW67MXfzsfqf2I
         jTCRwgn/NeZvPXv34YMB1lAIeKDqfVJN0dwls5IVy2g/I8dmYV3qJTWUdC3grzNvc2Fl
         MicIuRUZNqJUJF61C7PEELQjJuaXSOG6B1g19pK+fTcYJCZ1ai8t5N3L6LtfDD+Y21iK
         SzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fd/EVephwRZl8a27MQolPx0SCPi7ZbqIhcNy0drk3Q=;
        b=pGYXw8E9YwM/QQhD6Ucg9kK0pYwtO903tCI0dIJ9//6zmSOgN8fp+y2R2LFBQ8lcmp
         sDkhy+7ZQwuUZahsHzgMCAm8qXvLLj9eTBE/3ToXrFulyq6AUz4aO/lXZHh5HgGgyzWM
         +lM910+srhPnFxwz5Jvll7vIkSuKToM04UOTOU9DMovzfItKfqB7S+hiQkKFVuXPDNh3
         L1Q9MuSNrGaSssstGxBlo/T5uieotSNDcIO5B8+EhTQO7OnzHQslon8p2TPtD+O0H+cC
         gYgLvOQQxW1tx7oGByqPSCnLFcQBSIugFRf9IpBIpOAmpOnZhO8+0ow+ZyeD6V6X+8MS
         TvzA==
X-Gm-Message-State: AO0yUKXtaSu5aivmFcL7P7cR1IPGwZmgJu3XTf0N2U1orCNgS7P72b7Q
        7FnX65p8LDJBmKE+IyuGAZYZre/oEyDeOWtB
X-Google-Smtp-Source: AK7set+EZI6RfmE90YEkhx7B8wEw91rIBWePZ+A8N48lU8UzEE7tKXzi6k3i0H+2Pnopb9Wo4dTC6w==
X-Received: by 2002:adf:e192:0:b0:2bd:fa1d:5291 with SMTP id az18-20020adfe192000000b002bdfa1d5291mr5925705wrb.67.1675333695275;
        Thu, 02 Feb 2023 02:28:15 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:b82f:886:2209:1492])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb47000000b002ba2646fd30sm21444439wrs.36.2023.02.02.02.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 02:28:14 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] tools/lib/thermal: fix thermal_sampling_exit()
Date:   Thu,  2 Feb 2023 11:28:12 +0100
Message-Id: <20230202102812.453357-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
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

thermal_sampling_init() suscribes to THERMAL_GENL_SAMPLING_GROUP_NAME group
so thermal_sampling_exit() should unsubscribe from the same group.

Fixes: 47c4b0de080a ("tools/lib/thermal: Add a thermal library")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 tools/lib/thermal/sampling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/thermal/sampling.c b/tools/lib/thermal/sampling.c
index ee818f4e9654..70577423a9f0 100644
--- a/tools/lib/thermal/sampling.c
+++ b/tools/lib/thermal/sampling.c
@@ -54,7 +54,7 @@ int thermal_sampling_fd(struct thermal_handler *th)
 thermal_error_t thermal_sampling_exit(struct thermal_handler *th)
 {
 	if (nl_unsubscribe_thermal(th->sk_sampling, th->cb_sampling,
-				   THERMAL_GENL_EVENT_GROUP_NAME))
+				   THERMAL_GENL_SAMPLING_GROUP_NAME))
 		return THERMAL_ERROR;
 
 	nl_thermal_disconnect(th->sk_sampling, th->cb_sampling);
-- 
2.34.1

