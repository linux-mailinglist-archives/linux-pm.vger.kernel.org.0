Return-Path: <linux-pm+bounces-1064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A11A8110CB
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 13:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24DA12815DB
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 12:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAE028DCB;
	Wed, 13 Dec 2023 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzxUdnVc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674F7CF
	for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 04:13:34 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-336417c565eso279080f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 04:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702469613; x=1703074413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=itOaiy93IE/Oi6dMo6HICWXrGEv+UyQ/qj9qyPZPCTI=;
        b=TzxUdnVcAGZyDE7aYTDCJG6I8+hoohg1CWfT+OuwxYD+lLWez8DqiQWBWq8Fm8Cga8
         BF+fPu9Ayu9HbMn6ESP3ptoFaGytSlZBXiyqAWBKbwT51IR+EEKuzPrwg/OSYY+oaZ77
         pJ2poqy/X+86bC74YxVada1+EzRNe9A5P9JunjWmmFos+V6IHTiPoCVGVePRxFJqDLCh
         pVCKRjxP0viH4yhWz6w7IlYDSeTdbdNLG+bvKcivxoMJqTtBe2asFK/HbWBPRtJ1eAa3
         PBS1CXF7aO38vQuXBh8ZVbLGO4x8uQqFJJSCGB+ApYmqraeqxSro4hT+IKhrcf3giyju
         JsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702469613; x=1703074413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itOaiy93IE/Oi6dMo6HICWXrGEv+UyQ/qj9qyPZPCTI=;
        b=W8H4Q1XMPGuIXduOnqtwzQ5p1C+7PvWfbGT/E1WAtcIZB3cTGOfMrpBihsm9t7avNE
         pMvyMp74K/YvCTyWmdtE3fCvRl36ll3+bNYNcVCW+ZHfM8WhkJ1A8Ib4xxFZK81Qhjxg
         jwVr//7OR5RXU+1Y1FgQWcfm52nMQSxnpauU02zAHDwu5aSj3KahA2eMUuGveqKirpgp
         DMGZQAWrJu+tRGF9/vNHfBXJI1I8QxIFEEzwEwXRwDhLT8XNyLooVkOFBqUcRMo4P//J
         kyNH6Lm8yODaMZViYQxovuSMn/dnZzMxLV06/uawo+PXA+a/+MWPQBuJxOhJqArW4Nrb
         xudA==
X-Gm-Message-State: AOJu0YxLRuwMQtfAzzu2rfJV1mcuq/HYXwMW8DqAKHZv/KmI5grlU9sa
	B5TvlcNiELM1cD8eJXdtcHTmOTRilW4P5co84yE=
X-Google-Smtp-Source: AGHT+IHBVhZ856MZTBC5mOJutrT1OZrSe6h1yPpkPxqc4M4ZwxuWH5d46WF0/Hk0NPQHpI9BVcoRzQ==
X-Received: by 2002:adf:fc0b:0:b0:336:3843:ab7a with SMTP id i11-20020adffc0b000000b003363843ab7amr395500wrr.115.1702469612760;
        Wed, 13 Dec 2023 04:13:32 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.gmail.com with ESMTPSA id g3-20020adff403000000b003335ddce799sm13224614wro.103.2023.12.13.04.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 04:13:32 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/core: Check get_temp ops is present when registering a tz
Date: Wed, 13 Dec 2023 13:13:22 +0100
Message-Id: <20231213121322.2486967-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initially the check against the get_temp ops in the
thermal_zone_device_update() was put in there in order to catch
drivers not providing this method.

Instead of checking again and again the function if the ops exists in
the update function, let's do the check at registration time, so it is
checked one time and for all.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 625ba07cbe2f..964f26e517f4 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -437,11 +437,6 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 	if (atomic_read(&in_suspend))
 		return;
 
-	if (WARN_ONCE(!tz->ops->get_temp,
-		      "'%s' must not be called without 'get_temp' ops set\n",
-		      __func__))
-		return;
-
 	if (!thermal_zone_device_is_enabled(tz))
 		return;
 
@@ -1289,7 +1284,7 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (!ops) {
+	if (!ops || !ops->get_temp) {
 		pr_err("Thermal zone device ops not defined\n");
 		return ERR_PTR(-EINVAL);
 	}
-- 
2.34.1


