Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC8D433998
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 17:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhJSPEZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 11:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbhJSPEY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 11:04:24 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DF6C06161C
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 08:02:11 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y74-20020a1c7d4d000000b00322f53b9bbfso3083710wmc.3
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 08:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dMWZFxsiTx6gl0CFXfVaEgeXD66O9+HqBjAcLlM0fSM=;
        b=acSWg3P0WlR9gGIFl8bI5XZCiLAIe1j7mzf/xPqyZdvdnRqHgq+728of8crHDZ8odS
         996pzI/SVJVILPAKXFSLBB233+0imtXP8GVjiCzVeMelJPd1ffk32/d2YTxBGJ8v6qKP
         tVkBERIVuN4Zdk/UHvUl3xZc0BCWwlNhrrhVM9DHSqOHmrYNz7bftnDt+cqxiWjPtXGj
         AAf4gWtQPLrL4pT44GrEMJRztQIQCd6bu6A6nGQIU5IqRQepj9Lgb8AvO0OEpR+Hdwxf
         gagasKdUMWWeRBRSYbVhWP35FAUVB8XZJ3xT9XBGwnlo9qfAGIa/kk9BJKV8eLD28fHo
         ZZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dMWZFxsiTx6gl0CFXfVaEgeXD66O9+HqBjAcLlM0fSM=;
        b=OwXAER5bBDJWu55hAD7I/ijkmGdMpOPLa+vP/LaXVbo+LcutmQdiEQ4EXUHA323tFV
         IR2sOoTjcAltNKPKrIiT3UE7rrP0Twp3xK76ar09Mu0PLOXndNsq4ry/efCy0UBn0Y2a
         fuASeTPpXbZPTRKJWXyCRX/W1dwevlve3dvGD62nf4AuL2G/YJR8BO4AipgCcZdTWAXl
         HEYX87bNwNEGXFRx7NghPJW2H/u611EdckO5CqFV08o+hJT9NepaSe1tGqyzUtAELnh2
         wX83UbjlmM75q8nuuw7ETDmbYTn5akOY8EgSXIqVrPfHWHCMvi0GwGztTOW3M+/ly2DT
         IejA==
X-Gm-Message-State: AOAM532uE4giKN0fRYAP3g061D54imymrlVJuJ7NYyc56zdVATnfd4v+
        47MW6v6lOiE3pTYuBcsPihDYSA==
X-Google-Smtp-Source: ABdhPJwq2se/IZq7vwCsjff2ocsLBElQMnXuRFP4NIAw/yx8C6NoD3rOvuqQYGO1cYNEKH5kkWFJvA==
X-Received: by 2002:a05:600c:4f81:: with SMTP id n1mr6631340wmq.63.1634655730221;
        Tue, 19 Oct 2021 08:02:10 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:4799:198d:b6ef:8da7])
        by smtp.gmail.com with ESMTPSA id h11sm14581468wrz.5.2021.10.19.08.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:02:09 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 1/2] thermal/core: Make the userspace governor deprecated
Date:   Tue, 19 Oct 2021 17:02:02 +0200
Message-Id: <20211019150203.2805738-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The userspace governor is sending temperature when polling is active
and trip point crossed events. Nothing else.

AFAICT, this governor is used with custom kernels making the userspace
governor co-existing with another governor on the same thermal zone
because there was no notification mechanism, implying a hack in the
framework to support this configuration.

The new netlink thermal notification is able to provide more
information than the userspace governor and give the opportunity to
the users of this governor to replace it by a dedicated notification
framework.

The userspace governor will be removed as its usage is no longer
needed.

Add a warning message to tell the userspace governor is deprecated.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/gov_user_space.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/thermal/gov_user_space.c b/drivers/thermal/gov_user_space.c
index 82a7198bbe71..f4fe050e1cbc 100644
--- a/drivers/thermal/gov_user_space.c
+++ b/drivers/thermal/gov_user_space.c
@@ -15,6 +15,14 @@
 
 #include "thermal_core.h"
 
+static int user_space_bind(struct thermal_zone_device *tz)
+{
+	pr_warn("Userspace governor deprecated: use thermal netlink "	\
+		"notification instead\n");
+
+	return 0;
+}
+
 /**
  * notify_user_space - Notifies user space about thermal events
  * @tz: thermal_zone_device
@@ -43,5 +51,6 @@ static int notify_user_space(struct thermal_zone_device *tz, int trip)
 static struct thermal_governor thermal_gov_user_space = {
 	.name		= "user_space",
 	.throttle	= notify_user_space,
+	.bind_to_tz	= user_space_bind,
 };
 THERMAL_GOVERNOR_DECLARE(thermal_gov_user_space);
-- 
2.25.1

