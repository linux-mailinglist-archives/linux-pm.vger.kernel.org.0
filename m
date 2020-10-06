Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7BB284B85
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 14:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgJFMUv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 08:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgJFMUv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 08:20:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2384C0613D1
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 05:20:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l11so2707862wmh.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 05:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xF/1RSp7bqmtycW1zGKYYAA7v8YwsJOV1VWvLd51HvY=;
        b=JNyxWDqWBJo/CJXTGKT3YpwfrRWtPB4ugqyRr1olCTfp3iwejoyRXJ+MNVy5D+F6t7
         fdTkqXxeWNNoa97xO2nzoK/DwcjRHBtG3ICdkcaBK47O2ri8wGfGGCNdtoZD9SARwm5D
         LTrKwFRg0j23t6TkXX/7XfecgS9QeYbUtC22nKTabsE5b9LrairpLN1lqhWjvJ0Dc5rM
         WzS+mafPqZJV/d/5Rkt+BYrtTFrIrCSDdvyu3oRJ4WNPWq9botdJXVmhqz1c/09yZZj2
         gnegKviwWZ0ygOWa9lM4sOGjWVldp83ar7kFclo2/HEUX7ZAAq/3VT+xYXBv+UROX8NZ
         nR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xF/1RSp7bqmtycW1zGKYYAA7v8YwsJOV1VWvLd51HvY=;
        b=JoAOtmA73Dqw+VbZMjOmJaPgrvwSK/CKoGkKv5RVPB/ZB/w12dzFWdgilObQBH9dV0
         n12Jj5bRrprXc+W1Ig5Nv5hIG5dOLXwOKQmK3EF9RT+i9jgj/EhX3eCsTcUAZeq3oRpt
         /usavVeUmgfDsBZZzISLgNH57fpfU5s5k1Lle2hMVldaKputOYovlb1l0QCdT18UDEWN
         6+tLwxcIBfOclbFXsYKZ+nbAc7Iv0Jk+TLyPWtUzJS/u+q8K2AiG5fGRbR+TVGuGM3G4
         BKvge6clQwAfRkNGYuoqqDuS1pupEqiMPEfqM2u8HdYV+VqNfLZFxk7zWawlgU7cYe03
         Dm8A==
X-Gm-Message-State: AOAM5301r6DekO/yJOOGcb9wsuti/XoJ4CIdYeOTocBy+0FR2TkD9kf6
        fDv5hwiGjwdzEb18bKVz5Dm2FQ==
X-Google-Smtp-Source: ABdhPJzvP7GVBRXo9QjGkkWJc/k26ot9SDmzIJoB2oPy+E2mruOf7vHdeBnkofFpvhOLjKe/bdpYLQ==
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr4412406wmc.62.1601986849332;
        Tue, 06 Oct 2020 05:20:49 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-130-8.adsl.proxad.net. [82.252.130.8])
        by smtp.gmail.com with ESMTPSA id s19sm3742521wmc.41.2020.10.06.05.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 05:20:48 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 1/4] units: Add Watt units
Date:   Tue,  6 Oct 2020 14:20:21 +0200
Message-Id: <20201006122024.14539-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201006122024.14539-1-daniel.lezcano@linaro.org>
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As there are the temperature units, let's add the Watt macros definition.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/units.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/units.h b/include/linux/units.h
index aaf716364ec3..92c234e71cab 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -4,6 +4,10 @@
 
 #include <linux/kernel.h>
 
+#define MILLIWATT_PER_WATT	1000L
+#define MICROWATT_PER_MILLIWATT	1000L
+#define MICROWATT_PER_WATT	1000000L
+
 #define ABSOLUTE_ZERO_MILLICELSIUS -273150
 
 static inline long milli_kelvin_to_millicelsius(long t)
-- 
2.17.1

