Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE956A751C
	for <lists+linux-pm@lfdr.de>; Wed,  1 Mar 2023 21:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCAURA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Mar 2023 15:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjCAUQU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2023 15:16:20 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765B551F84
        for <linux-pm@vger.kernel.org>; Wed,  1 Mar 2023 12:15:57 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p16so9366575wmq.5
        for <linux-pm@vger.kernel.org>; Wed, 01 Mar 2023 12:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677701757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FS5MMzUrtYY5N2w5QCadh2L/6Lyuv9jfcaqNKoRqTRU=;
        b=OePQtLOGe7LDEC9FRQ7V9NVHHpJaS6nf3PuVfwUJDUS7IiBldmApsOZaHqqQCwCxXg
         QlNTNnxk3BjgSzbPhIksEuI6IXQmlfigT05KUDIUi77jL+mdq4OXGTO1jc/oRehRdFWD
         1V5jTlEIfV45SPZE1nMmCKWE7PjZ/4J8jYkA+bKzuA//LRY9CtLMhzZbeB2bb3sieGaY
         AKGEBgvstFbgJI8VNqtqNh2LL9EtvGklrwrX/h2PmHSFSkbinhgUypa70/PUTTwUhAEm
         yKT3e6Mun+cowZXLiMHAqU+cHD1uN+BDHEZWDY0NQ0g5VECQSmxG6bR+qO5e1y4+x8Pm
         yIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677701757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FS5MMzUrtYY5N2w5QCadh2L/6Lyuv9jfcaqNKoRqTRU=;
        b=2DgG5IiYBi2Q3kcKBB5z/cbsHr4XT0vxMv9kX65Gu7H/BD6vdACguXLcz4PdXvXa5Y
         cUz0Xtogra2uehA5+nABNPiNkWNc3+uDxgrhJRL7Cm2ryPsHX5D6kbapg105shzOf/dl
         TKWiSaWgpYqr6JbWIYf4wEOIx4n5F7rvdEE8YsOjga5u8TeKtDkU32kpbmhgaJ+kJmiT
         oCmZRkJP0cjjvFCDcgnZWWps5IZ7LJXCy8XR15SV4mtOcE5sEMZCKhVkx6LulMsefY7/
         +qw4rmQkkbt0bfCQYtMHQIz9SGjqidC5PUxjxm8v32ZCEckC2uYEqJTeEY/0uqFsIllV
         Gn/Q==
X-Gm-Message-State: AO0yUKXbe71rOSaYusPS7SGThrgU3Juo8T8q8xU+mTgzTq0U2/ZsK8e6
        g0745wdeoLeBuKTRNsGqEG/QBw==
X-Google-Smtp-Source: AK7set9/48B3UkJzRbD9ghUuPOZUq417aVxqF4bZ/zrpzF6PhFApIvpjoxt3GWWtJuYzeCOE4ikdug==
X-Received: by 2002:a05:600c:1716:b0:3eb:2e66:9 with SMTP id c22-20020a05600c171600b003eb2e660009mr6538243wmn.30.1677701752097;
        Wed, 01 Mar 2023 12:15:52 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6ffe:ce4f:bd31:1e6d])
        by smtp.gmail.com with ESMTPSA id x16-20020a1c7c10000000b003e70a7c1b73sm576546wmc.16.2023.03.01.12.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:15:51 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org (open list:ACER ASPIRE ONE
        TEMPERATURE AND FAN DRIVER)
Subject: [PATCH v5 18/18] thermal/drivers/acerhdf: Remove pointless governor test
Date:   Wed,  1 Mar 2023 21:14:46 +0100
Message-Id: <20230301201446.3713334-19-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
References: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal zone parameter specifies the bang-bang governor.

The Kconfig selects the bang-bang governor. So it is pointless to test
if the governor was set for the thermal zone assuming it may not have
been compiled-in.

Remove the test and prevent another access into the thermal internals.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Peter Kaestle <peter@piie.net>
---
 drivers/platform/x86/acerhdf.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 61f1c3090867..71b9c1f922d9 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -697,13 +697,6 @@ static int __init acerhdf_register_thermal(void)
 	if (ret)
 		return ret;
 
-	if (strcmp(thz_dev->governor->name,
-				acerhdf_zone_params.governor_name)) {
-		pr_err("Didn't get thermal governor %s, perhaps not compiled into thermal subsystem.\n",
-				acerhdf_zone_params.governor_name);
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
-- 
2.34.1

