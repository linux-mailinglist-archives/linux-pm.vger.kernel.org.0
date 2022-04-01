Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1F74EF6E9
	for <lists+linux-pm@lfdr.de>; Fri,  1 Apr 2022 17:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345236AbiDAPq6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Apr 2022 11:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351322AbiDAPom (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 11:44:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B254A103BAF
        for <linux-pm@vger.kernel.org>; Fri,  1 Apr 2022 08:19:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so3703429wmb.4
        for <linux-pm@vger.kernel.org>; Fri, 01 Apr 2022 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1NdprsVhjM+s7BsGf7u7DDEuZ12Z3WnLtb7OSPBuoMg=;
        b=ZUGfuwiDrHqDp/g+ojAICJE50HXT1l3XtK+fv1OSahrfDPU2Zt2RQYWbq8A0w2lJNL
         +sFt75rhKvamqqTn9JSXBy0AGr/bXt6MctiPhJE1UJpI7289KVTr2PVoYbQ1V/AEfN6s
         RWU4nOaG50fRhtQkLcZtGcNb/OQh3z/WgWnwOtaZ6O4bJ9MtGgjhNu0gAUFFpLH9gNKj
         HBijFXOL8QbQrLkRQ6xHoo5k7D8l/qN8bLf0nDmLeAFQ7L5oxEksIWIhLNI5+xGC4Uzj
         sKMDrryt7KtIUF5W469O6wmCAiK9Cz9jj7iqxJIWCt7nnmxjsGOvS0UUDP8qQlgqF33a
         ZsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1NdprsVhjM+s7BsGf7u7DDEuZ12Z3WnLtb7OSPBuoMg=;
        b=yzlXP1GaeeVfZQjGUKtwMCfSxvLTrVRfitvHcxl99ELwtxwFzxABmiwESsCUfBqyBN
         A6yCIgAsJghxRNkcPUQlTIX7JeFyrneWDQeu+kH4c9TkVkn+6nhgcQewoawwQiJkFJGl
         hb1fJGdO7xXRpgunC1xnPFYTZw+7nMKLOX7JVtoHAA5rhjLe6JG7f7PdunRA2izpwTxb
         Id0ZqAZaG29ulIBhjPT+lkoR04c2KJBL39Q7oIuAgkRImTGUtis+0fSZIo0D/wZp5QkF
         f1jduPgfUWBtdvKX+6wUiyBHcugBO2uYFgAe9TJr7UMkjizvhOP0gdtNsP/msnzH6HTt
         kpSw==
X-Gm-Message-State: AOAM5334ddp0XdORWOs91PRPxeWPKHReDb5OMmniIgZQjwy58sqq0n9a
        Zo1pKdigLn8UrlvfkdOGe0E=
X-Google-Smtp-Source: ABdhPJxWdEWV/WBcQuJBXwUksy9heBFiyV/941WD4rUO4S72+XqTeSc9/wX+CbzvXnE6ozc/uQQqNA==
X-Received: by 2002:a05:600c:4408:b0:388:a042:344f with SMTP id u8-20020a05600c440800b00388a042344fmr9024136wmn.52.1648826345742;
        Fri, 01 Apr 2022 08:19:05 -0700 (PDT)
Received: from localhost.localdomain ([37.164.133.248])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b001f049726044sm2276101wrv.79.2022.04.01.08.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 08:19:05 -0700 (PDT)
From:   Massimiliano Minella <massimiliano.minella@gmail.com>
X-Google-Original-From: Massimiliano Minella <massimiliano.minella@se.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Massimiliano Minella <massimiliano.minella@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v2] thermal: k3: Add hwmon support
Date:   Fri,  1 Apr 2022 17:13:51 +0200
Message-Id: <20220401151656.913166-1-massimiliano.minella@se.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Massimiliano Minella <massimiliano.minella@gmail.com>

Expose the thermal sensors on K3 AM654 as hwmon devices, so that
temperatures could be read using lm-sensors.

Signed-off-by: Massimiliano Minella <massimiliano.minella@gmail.com>
---
Changes in v2:
 * use devm_thermal_add_hwmon_sysfs instead of devm_add_action_or_reset

 drivers/thermal/k3_bandgap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 35f41e8a0b75..5d0b3ffc6f46 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -16,6 +16,8 @@
 #include <linux/thermal.h>
 #include <linux/types.h>
 
+#include "thermal_hwmon.h"
+
 #define K3_VTM_DEVINFO_PWR0_OFFSET		0x4
 #define K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK	0xf0
 #define K3_VTM_TMPSENS0_CTRL_OFFSET	0x80
@@ -219,6 +221,9 @@ static int k3_bandgap_probe(struct platform_device *pdev)
 			ret = PTR_ERR(data[id].tzd);
 			goto err_alloc;
 		}
+
+		if (devm_thermal_add_hwmon_sysfs(data[id].tzd))
+			dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
 	}
 
 	platform_set_drvdata(pdev, bgp);

base-commit: 31035f3e20af4ede5f1c8162068327ea0b35a96e
-- 
2.25.1

