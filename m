Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918444336F0
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 15:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhJSNYs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 09:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbhJSNYr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 09:24:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22C3C06161C
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 06:22:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i12so47625079wrb.7
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 06:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NyXqSkaflhBOynk4JWAviQc2FGe0plZLbAljyNgc/ec=;
        b=IDuuBE5PJerEEsGkVNmK1+tAQyD4dB+lr9gR+1qkb+lhNgdvXpetUM11Su0KE6R9l+
         L2h27iM+9IOUexOR1P3LHrQ0En/xgYOe9pehIShvJTV7AYDJKIvrCVERAf1nuHnf0dv8
         XJ67alCfJn73ZliZmb3T96DeRp+adqydw85bAJCiTFAzNezJ0o9Lw5uXIRt1LO6H2VHz
         uGNzV/N335T2B9s7CggH+zt43b+f97uqyt8cnAt56nJr/7AsERl1OTffFq+2qUWMA/5T
         WgVParlC3dwhgqwkxjyn97a0Lw1jVzZtDn9xllErJq0kbYFhwiPG/syL181CGG/LXN1j
         R+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NyXqSkaflhBOynk4JWAviQc2FGe0plZLbAljyNgc/ec=;
        b=hvxW2+bZ9Tks/zDVjqpxPXJv7rX1vwqnoUjNeGaWsNFAxyOdNAgEshuUONgI9qU4AC
         iITxjPhkJBDefnBAcfvlCT8qvTZgEpzLh6xkUE8VvoNrjkPdQklMLmJvcR7JEDwfsuTg
         pFIrHXY+YZKvMl1xlQy/R1TqOc7Fd5oWavBvYAGhSrILGegdGr06l2QLlYfG1kpGBTD0
         qTnKccox/coJfcpD5Mu1avqoZ5Xil+6eppbFtsNhJcdfBshgz2JX8yLUG/zk0rmXM1MT
         V0t7lAI940szHvpUlmlu5hLDqDx99ubFWZ33MKgdo6MOolH8mzcJDdw7cIDmuX2Ft56x
         xAkQ==
X-Gm-Message-State: AOAM5323biHm7xZBrcAJnl4PNt1mj+oPZtjEvCR1Ak3cyyxYxP6FrpN3
        Aja3oUnYs3KKo195r8wgFhD6XA==
X-Google-Smtp-Source: ABdhPJw3mH8IQAVcUb7en9F6AMw4ZI56RiK1Hh3nknPOaRj77lWZA8sRkfin940w3x4oYcyYQ0MQDw==
X-Received: by 2002:adf:d84d:: with SMTP id k13mr44624008wrl.276.1634649753408;
        Tue, 19 Oct 2021 06:22:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:c590:9206:d20a:23bd])
        by smtp.gmail.com with ESMTPSA id n7sm14982426wra.37.2021.10.19.06.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:22:32 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH 2/2] thermal/core: Make deprecated cooling device state change from userspace
Date:   Tue, 19 Oct 2021 15:22:11 +0200
Message-Id: <20211019132211.2792475-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019132211.2792475-1-daniel.lezcano@linaro.org>
References: <20211019132211.2792475-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cooling devices have their cooling device set_cur_state
read-writable all the time in the sysfs directory, thus allowing the
userspace to act on it.

The thermal framework is wrongly used by userspace as a power capping
framework by acting on the cooling device opaque state. This one then
competes with the in-kernel governor decision.

We have seen in out-of-tree kernels, a big number of devices which are
abusely declaring themselves as cooling device just to act on their
power.

The role of the thermal framework is to protect the junction
temperature of the silicon. Letting the userspace to play with a
cooling device is wrong and potentially dangerous.

The powercap framework is the right framework to do power capping and
moreover it deals with the aggregation via the dev pm qos.

As the userspace governor is marked deprecated and about to be
removed, there is no point to keep this file writable also in the
future.

Emit a warning and deprecate the interface.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 1c4aac8464a7..3f4ea3a283ae 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -610,6 +610,8 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
 	unsigned long state;
 	int result;
 
+	WARN_ON_ONCE(1, "Setting cooling device state is deprecated\n");
+	
 	if (sscanf(buf, "%ld\n", &state) != 1)
 		return -EINVAL;
 
-- 
2.25.1

