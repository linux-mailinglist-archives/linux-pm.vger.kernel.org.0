Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4D35F485F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Oct 2022 19:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJDR1T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Oct 2022 13:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJDR1Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Oct 2022 13:27:16 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2563B5E67F
        for <linux-pm@vger.kernel.org>; Tue,  4 Oct 2022 10:27:10 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so7960957wmq.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Oct 2022 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aN4DlCPGos4eyvhsW5aRQQoXE+IjMULxnKXbP9xGXDQ=;
        b=MdmC3bD5Oh/cdnenOJ4NEb7GbyqpiNsMH7lGhHBrJLpw1yx3byvR93U+jh5z5iOGlD
         b75aU6vU6F+rMmSPGydOKObwpCVCDvk4V3cXM3dkSMsMwN+9IOC1PUKvngNyj3VyNUpz
         mbogigJ/uimDvPP1hrK0nKkB3d6L0saIiCbnyboPbICRqVt0z8Tj2Je3BJh7fGnuLMox
         EH0m4+fuYDfz1MxQD8ycqeuWcAWwC/J2d+GXy0+rbaxPbfmUTBOzdZc5VTK81+scNSv/
         ctRFKpPCJtg/dRvu5uyCmIjXoqBpFVPiYdnrrPaeUIQ8vzlpFgr1SQhqJFzXEFr2pUWz
         JM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aN4DlCPGos4eyvhsW5aRQQoXE+IjMULxnKXbP9xGXDQ=;
        b=pBVYLKWXgv9dTfcdYoWMFWRRVjE1go5KhUq7f7+XuV1HrQHQOGLGLB5B6xQ89QVgnQ
         o5yzfLQnn6drOIazplWZheBu4T4s+jGE/hU68DEcpqOU8oxBzpl/1KylVAs3sbIpMH47
         ln0s7eQB3M6laRFYq4jvZTsPoBW17cASP85kl25KeitP8ItQTi0pFe9n0NyKXAi4dJLw
         xOODhqJgLbaz6ZcM32WlAu9f0UZpJU5fFJovAzHSUXGdxJuqvmXT68mCzoPX31A4wo7t
         T2w8qPPbBa67yWpS1ymNneXPNVytESRVY55gM2PTE1I6iqfZ8ZxVxP8xeMOTsnzXhX+M
         rvHw==
X-Gm-Message-State: ACrzQf38EDRdQCSPjUETPuQrQGxDnrjanh/qsyxXSdwih86Rsx2IrMtF
        KIi8QjzrvAbN0ryXhXV+jjYGhA==
X-Google-Smtp-Source: AMsMyM4fewkyF1YEUvyBECAFoXHpF17NNPpniY1oejie64eK+YzJln4WINw1gXXB15BLecFQmz7z5A==
X-Received: by 2002:a05:600c:1d2a:b0:3b4:6e31:92da with SMTP id l42-20020a05600c1d2a00b003b46e3192damr559571wms.103.1664904429185;
        Tue, 04 Oct 2022 10:27:09 -0700 (PDT)
Received: from mai.. ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm13060941wrc.62.2022.10.04.10.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:27:08 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH RFC 2/9] thermal/acpi: Change to a common acpi_thermal_trip structure
Date:   Tue,  4 Oct 2022 19:26:51 +0200
Message-Id: <20221004172658.2302511-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004172658.2302511-1-daniel.lezcano@linaro.org>
References: <12068304.O9o76ZdvQC@kreacher>
 <20221004172658.2302511-1-daniel.lezcano@linaro.org>
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

Do not differentiate hot, critical, passive and active trip
points. Use a single acpi_thermal_trip structure.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index b2e73e45c6d6..9620128f05d2 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -119,36 +119,13 @@ struct acpi_thermal_state_flags {
 	u8 reserved:6;
 };
 
-struct acpi_thermal_critical {
-	struct acpi_thermal_state_flags flags;
-	unsigned long temperature;
-};
-
-struct acpi_thermal_hot {
-	struct acpi_thermal_state_flags flags;
-	unsigned long temperature;
-};
-
-struct acpi_thermal_passive {
+struct acpi_thermal_trip {
 	struct acpi_thermal_state_flags flags;
+	struct acpi_handle_list devices;
 	unsigned long temperature;
 	unsigned long tc1;
 	unsigned long tc2;
 	unsigned long tsp;
-	struct acpi_handle_list devices;
-};
-
-struct acpi_thermal_active {
-	struct acpi_thermal_state_flags flags;
-	unsigned long temperature;
-	struct acpi_handle_list devices;
-};
-
-struct acpi_thermal_trips {
-	struct acpi_thermal_critical critical;
-	struct acpi_thermal_hot hot;
-	struct acpi_thermal_passive passive;
-	struct acpi_thermal_active active[ACPI_THERMAL_MAX_ACTIVE];
 };
 
 struct acpi_thermal_flags {
@@ -166,10 +143,10 @@ struct acpi_thermal {
 	volatile u8 zombie;
 	struct acpi_thermal_flags flags;
 	struct acpi_thermal_state state;
-	struct acpi_thermal_critical critical;
-	struct acpi_thermal_hot hot;
-	struct acpi_thermal_passive passive;
-	struct acpi_thermal_active active[ACPI_THERMAL_MAX_ACTIVE];
+	struct acpi_thermal_trip critical;
+	struct acpi_thermal_trip hot;
+	struct acpi_thermal_trip passive;
+	struct acpi_thermal_trip active[ACPI_THERMAL_MAX_ACTIVE];
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
 	int kelvin_offset;	/* in millidegrees */
-- 
2.34.1

