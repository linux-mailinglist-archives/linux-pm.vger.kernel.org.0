Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B355F4871
	for <lists+linux-pm@lfdr.de>; Tue,  4 Oct 2022 19:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJDR1a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Oct 2022 13:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiJDR1V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Oct 2022 13:27:21 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B84356B82
        for <linux-pm@vger.kernel.org>; Tue,  4 Oct 2022 10:27:19 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w18so13654511wro.7
        for <linux-pm@vger.kernel.org>; Tue, 04 Oct 2022 10:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3dYKf0qeHKGAU0Mki69uVmAl8R+LfwbHqZ8xsk7ums=;
        b=dII8QRZ6zhyQT9a2/PchBDxFaBAr8L5XyqNrbjTTidqs+PrVbzughtWLokmMb0b8ME
         CIgnXABDQqiBBkaLVbIRJiuvM5cNqSmVQz38ATAgqE3rLScurH7PajORNFe3zKp6PB0c
         UJ2LxGHu1a+T2ddxIcUTu6LfOsg4gnXCywMRwFFKaj3OZhoHEY2YROsghbybs3vTH7bl
         Af13qD2gR48X2LQIgMvDKLe7AfetnewxOIk7dRRa0TLoHncAuIdUSXCsQRgtX/PyG2Zq
         HMfSUI1a2k6T2gvYryRRTTPkXDv4UYh+KQj1TYxm0lZJb9zeadypDIY1my424slmLCex
         QbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3dYKf0qeHKGAU0Mki69uVmAl8R+LfwbHqZ8xsk7ums=;
        b=2kzQCp/aCfe355ydygFuJcSqPetJYZRdufoCjn0v5+y239ldzULvdzSgpxqQctXSGF
         Xmob+B00dk8wh+n/ODTev+OKUANnjUKKVIawPC5L93YivJWal2LRiiKhgfqGoMSKFLD1
         tvhZuEJhDWbGOwu5YgIXqv7BB4/bhkx5gQ2RXdU+rgNkPc5msbI8QZADu2rr5D5vSWzG
         5QmMV0FriU8E8UXYlmUOdt2KxyM6GNIUu0jXWJYg/ij496ncoNBo09PR376pDtNhjKdE
         fGBv9FDAj1CO/fE5Jhi8jwh5uXdgGQq2fwNvthwuUrZ7wWMK4aWpGBGQBXoWCqzjpcge
         eaGg==
X-Gm-Message-State: ACrzQf3evPzybB8nncOVcSKe8lC+NU4mpIl406yDZY+I9lSfjUEjUHAN
        yPVX8O5AmwvP/S8Tdhg6sBc49jZksZVKOA==
X-Google-Smtp-Source: AMsMyM4LXI8R1HuZNW+5VD6dycQqURSOfLBrLzAoKRh7h9K6VcQasQv31GKtfIo9sQgarr/piJKXsg==
X-Received: by 2002:a5d:4209:0:b0:22c:d5fd:1a06 with SMTP id n9-20020a5d4209000000b0022cd5fd1a06mr15858552wrq.508.1664904437688;
        Tue, 04 Oct 2022 10:27:17 -0700 (PDT)
Received: from mai.. ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm13060941wrc.62.2022.10.04.10.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:27:17 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH RFC 8/9] thermal/acpi: Remove active and enabled flags
Date:   Tue,  4 Oct 2022 19:26:57 +0200
Message-Id: <20221004172658.2302511-9-daniel.lezcano@linaro.org>
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

The 'active' field in the struct acpi_thermal_state is never used.

The 'enabled' field of the structure acpi_thermal_state_flags is
assigned but never used.

Remove them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 116e5cf19c5d..f530dbfa80db 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -117,14 +117,12 @@ struct acpi_thermal_state {
 	u8 critical:1;
 	u8 hot:1;
 	u8 passive:1;
-	u8 active:1;
 	u8 reserved:4;
 	int active_index;
 };
 
 struct acpi_thermal_state_flags {
 	u8 valid:1;
-	u8 enabled:1;
 	u8 reserved:6;
 };
 
@@ -1139,17 +1137,14 @@ static int acpi_thermal_resume(struct device *dev)
 	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		if (!tz->trips[i].flags.valid)
 			break;
-		tz->trips[i].flags.enabled = 1;
+
 		for (j = 0; j < tz->trips[i].devices.count; j++) {
 			result = acpi_bus_update_power(
 					tz->trips[i].devices.handles[j],
 					&power_state);
-			if (result || (power_state != ACPI_STATE_D0)) {
-				tz->trips[i].flags.enabled = 0;
+			if (result || (power_state != ACPI_STATE_D0))
 				break;
-			}
 		}
-		tz->state.active |= tz->trips[i].flags.enabled;
 	}
 
 	acpi_queue_thermal_check(tz);
-- 
2.34.1

