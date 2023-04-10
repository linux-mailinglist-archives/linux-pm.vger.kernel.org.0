Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EDB6DCC56
	for <lists+linux-pm@lfdr.de>; Mon, 10 Apr 2023 22:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDJUxs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Apr 2023 16:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjDJUxp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2023 16:53:45 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34FF210D
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 13:53:42 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v29so5552372wra.13
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 13:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681160021; x=1683752021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPfklvntaSAZNSstWZb9c9xIuh7wy5gv7laC1WOc6HM=;
        b=CNbSdHE8n1zV1HPzRdLK08lEvmMz/Kid8qJ/8adULTAra3QhdAdgSk4eHGV9zO7TmW
         oWjrs4f3ETu6O+96aPhnZ6Q61+FIGxTq7P2q1LMH6BuLH1tGqL7J5m8hL2EJwYcfVPmB
         6L3TFCl3sAP7+8wmSXHvX8cyCl6JXV+DnepvXSz7J7ts3uSUoAbB7roDO477PeGjZBrq
         B6UhPUI7bSVGwpPMPNawVS5xr9xsTzHINTVbnfJfS+KYyCjmqQiqKMa7/B+XTVzindJW
         i0Ly4fqWapIN5RdJQ67GyRLwIeA+K2atzBMK38N3Fu6RJZJUsMNs+X50dxpI0knuK8pN
         hU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681160021; x=1683752021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPfklvntaSAZNSstWZb9c9xIuh7wy5gv7laC1WOc6HM=;
        b=r1kBOpckYtVNvP4W2B3SZle2F5RyfKQytD8gmbvIK2kQ7x+ckfHMmCjW3kPJpnhCbq
         xvakN3PaVxrTCMnBm7R4mAnQ1VhOe/KyE/lbTXi70gliGvRVeux7hl4XA5NxLrYlb93X
         JW795MurDWYBFbWKsqNYS0SaCmtugoC6DHskIW1/1vFF9DwT6NnrkAlYhB+TGm7KwR7c
         +tS6gPlMqP2zORpkFOzWF4SWnXGDhVQYN1vs9EI5ltkARAwpsauM/qnYvDjCtb6mEY9E
         auwl2YY5T+9OBmY5EoRnAFgQS06eC9Tw0rkwDoDOVGAapL3xOfxlvRQDmdp9Cipk2Ym3
         ftKg==
X-Gm-Message-State: AAQBX9fKs2nG/o8w3Qa9RlRkd59AqBFkxLEy9lmR6xR6sXFtunWnmJDB
        RJKUrhIj02v2JTRpuyRuV2EpIA==
X-Google-Smtp-Source: AKy350aFfGmqz5nU83qM1fv+sU7tCyVxJ496+1K9KVy1xzlKLKyU5K5Dr7MTMmRg3cXmeAr5FguKsQ==
X-Received: by 2002:adf:dec2:0:b0:2ca:175b:d850 with SMTP id i2-20020adfdec2000000b002ca175bd850mr5111363wrn.11.1681160021173;
        Mon, 10 Apr 2023 13:53:41 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:2611:592:3b9e:d2ae])
        by smtp.gmail.com with ESMTPSA id e17-20020adffc51000000b002ef2e148d59sm11966789wrs.16.2023.04.10.13.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 13:53:40 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Sujith Thomas <sujith.thomas@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 4/7] thermal/drivers/menlow: Use thermal_zone_device()
Date:   Mon, 10 Apr 2023 22:53:02 +0200
Message-Id: <20230410205305.1649678-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410205305.1649678-1-daniel.lezcano@linaro.org>
References: <20230410205305.1649678-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to get the device associated with the thermal zone, let's use
the wrapper thermal_zone_device() instead of accessing directly the
content of the thermal zone device structure.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/intel/intel_menlow.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/intel_menlow.c b/drivers/thermal/intel/intel_menlow.c
index 5a6ad0552311..d720add918ff 100644
--- a/drivers/thermal/intel/intel_menlow.c
+++ b/drivers/thermal/intel/intel_menlow.c
@@ -422,7 +422,8 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
 
 	result = intel_menlow_add_one_attribute("aux0", 0644,
 						aux0_show, aux0_store,
-						&thermal->device, handle);
+						thermal_zone_device(thermal),
+						handle);
 	if (result)
 		return AE_ERROR;
 
@@ -436,7 +437,8 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
 
 	result = intel_menlow_add_one_attribute("aux1", 0644,
 						aux1_show, aux1_store,
-						&thermal->device, handle);
+						thermal_zone_device(thermal),
+						handle);
 	if (result) {
 		intel_menlow_unregister_sensor();
 		return AE_ERROR;
@@ -449,7 +451,8 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
 
 	result = intel_menlow_add_one_attribute("bios_enabled", 0444,
 						bios_enabled_show, NULL,
-						&thermal->device, handle);
+						thermal_zone_device(thermal),
+						handle);
 	if (result) {
 		intel_menlow_unregister_sensor();
 		return AE_ERROR;
-- 
2.34.1

