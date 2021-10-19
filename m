Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0C7433999
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 17:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhJSPE0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 11:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbhJSPE0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 11:04:26 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F729C061746
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 08:02:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l38-20020a05600c1d2600b0030d80c3667aso3374717wms.5
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bn0QP19v6GrWQNVWduIFqQTakGnl0xz+jG6sCa2Po48=;
        b=mB/yAFXyxSTwiEr4iyHntcbVdUZ3j0QBNO/WL4zFi+tH7hUBXgYR/XGTnhCTGgTpP7
         rj6cVG7AWo+nQx/tBWIYhkELKuQF6wdtJNx58R41YijOK7i75YRMbjISXpFPaefuR6/H
         jARNuJ4Tf/dtJXF71dvgWgoI86hFvVCnV6bywMz0dgd9NYRRd8Kw316JXc27dhNvGjES
         ekuTcChatId1hAJC8dnXQutv4z0PRoBqD0hi18BKiULSsEcQDF+MouJFCK/smCDwjHOT
         ERV6RUgl+2sSvCyueF7QRBEUOcZAeMJt2upBZ3a2Fk8yL4W9BTfVCVI1h5YLr7oTKPrb
         PiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bn0QP19v6GrWQNVWduIFqQTakGnl0xz+jG6sCa2Po48=;
        b=ojtUfP7anwqtc7DIBvvEO5hIQ6fUStCMk+g3nj4a8JfXL9DCRksHn9P8U37DiTVXCx
         KLxcLeFj7yfVQi1mFG/lanVzuP6ihHsGKno5hCs4GKTCyhvb86BXOcLS0ZQC8P1m7wU6
         GDLeKyyorbnabjjnRt5U0wRzemfvOeFvjEer27d1cFZu7U35TFZaSTNXy3vWemKByXaZ
         69VpRSABWd4bfSnWxv3QtvEVbRsUazbjk7zmQ2YPUbXN6wi0C7N86b84w8AE6Fhp8+vR
         O++S4MlYRPzex0UjwmgAMdt8c1XDCyk2YTXJ871wyzcasLWm9cbVKhZyslk3LOPsCHHE
         vzaQ==
X-Gm-Message-State: AOAM533s7h+RgkuAvANQn/b6qs1arbeBJeLuDhBM6VrZCeJ7XohqmBw4
        BTIqOzN4F2ZifaiOaQ5390Xi6g==
X-Google-Smtp-Source: ABdhPJy1zzKocg8ct7gw/dUU5Kl9v3mb3dfz1+R1W+KbarJVUsy0a11484Ln+Qr+aziuIEQl3dfpDA==
X-Received: by 2002:adf:a294:: with SMTP id s20mr45364959wra.34.1634655731514;
        Tue, 19 Oct 2021 08:02:11 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:4799:198d:b6ef:8da7])
        by smtp.gmail.com with ESMTPSA id h11sm14581468wrz.5.2021.10.19.08.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:02:10 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 2/2] thermal/core: Make deprecated cooling device state change from userspace
Date:   Tue, 19 Oct 2021 17:02:03 +0200
Message-Id: <20211019150203.2805738-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019150203.2805738-1-daniel.lezcano@linaro.org>
References: <20211019150203.2805738-1-daniel.lezcano@linaro.org>
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
cooling device is invalid and potentially dangerous.

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
index 1c4aac8464a7..730f1361dbef 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -610,6 +610,8 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
 	unsigned long state;
 	int result;
 
+	pr_warn_once("Setting cooling device state is deprecated\n");
+	
 	if (sscanf(buf, "%ld\n", &state) != 1)
 		return -EINVAL;
 
-- 
2.25.1

