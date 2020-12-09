Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2315B2D4581
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 16:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgLIPfh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 10:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730251AbgLIPfh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 10:35:37 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534C0C0613CF
        for <linux-pm@vger.kernel.org>; Wed,  9 Dec 2020 07:34:57 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id c1so2197352wrq.6
        for <linux-pm@vger.kernel.org>; Wed, 09 Dec 2020 07:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9lzHda3DkRGsaAMWdU4VLGvm72yuNdC03lUHj7g0BKQ=;
        b=GhhAbALhf3of5VkM2LzUNsHuJej/dySMGdw+z4MhNerh+DyFl2VMiQPQUKh+LaYUmI
         VpJhaNHjrf/rXuhqRsIUFXqGRMyBc6xDLtKhYCXxFumdI6xus4ampbKpcW20dT21uhzo
         NzBSm6B/tkCCC+Jw2zUB1nHjRbrennKfbarqT5q41Echd4XojfMpSnYvtDXTDIc8lL9X
         Jw4nuFMB49N82BkXjTUHAhxnZABYDRwvuiDR4greQsliJsT3hp/tR1x8VgoJOqECP4jD
         HLR1s/5OJyl0P6PJ16FWcE7y5ASg2d+foQGcIDjmcH2rXRL3Pn4thGD3T4wgEXWp5RUs
         wkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9lzHda3DkRGsaAMWdU4VLGvm72yuNdC03lUHj7g0BKQ=;
        b=Jet81tER1zP/esnpCpWEbek3nry2EerECyefFpyM2kbAasgT7O4aZjnnu1ADrD+r9i
         WQo4Wk61XR6Vu3c534HuFm37bbzyouGrbm6wacfZ210seiQVkRt0nuKm85+tnBKRn9NL
         vyRlESjTStHxhEK7on1GeZymC6SNqJgg2hnkU42e2J2ZHV7maf6ZKR0HPomXZajO2tc8
         ubOypRzkXbdrRJIUxUYyAiZBgqpovMXLS6uv7F6DLVCFktGHBJcw9t7v6jzTOW6DyKLz
         LGShWlby55mV53S8H8YVMaVrggwYEJQWxoqvaJRvSzeNg1fukOlXX43UJNEHg2jKxlmf
         E4IQ==
X-Gm-Message-State: AOAM533LDs1TPksJ4u1TEovYM+5/c8IccUHkQ8UoSQQokvUPJPZ+2yp7
        cCs3NH1gPhAve9dQ3W4lKdxYVA==
X-Google-Smtp-Source: ABdhPJwMMEV5xlT/R6GGJNxJr+haT149CRPQ8WSzZh1u8ASFibjqhff9sF5ZEHnkRZ4dAoBB8NWUEg==
X-Received: by 2002:a5d:5604:: with SMTP id l4mr3317757wrv.127.1607528095968;
        Wed, 09 Dec 2020 07:34:55 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-158-132.adsl.proxad.net. [82.252.158.132])
        by smtp.gmail.com with ESMTPSA id l8sm4208382wmf.35.2020.12.09.07.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 07:34:55 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, srinivas.pandruvada@linux.intel.com,
        kai.heng.feng@canonical.com
Subject: [PATCH RFC 1/4] thermal/core: Emit a warning if the thermal zone is updated without ops
Date:   Wed,  9 Dec 2020 16:34:37 +0100
Message-Id: <20201209153440.27643-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The actual code is silently ignoring a thermal zone update when a
driver is requesting it without a get_temp ops set.

That looks not correct, as the caller should not have called this
function if the thermal zone is unable to read the temperature.

That makes the code less robust as the check won't detect the driver
is inconsistently using the thermal API and that does not help to
improve the framework as these circumvolutions hide the problem at the
source.

In order to detect the situation when it happens, let's add a warning
when the update is requested without the get_temp() ops set.

Any warning emitted will have to be fixed at the source of the
problem: the caller must not call thermal_zone_device_update if there
is not get_temp callback set.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index dee40ff41177..afc02e7d1045 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -548,7 +548,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 	if (atomic_read(&in_suspend))
 		return;
 
-	if (!tz->ops->get_temp)
+	if (WARN_ONCE(!tz->ops->get_temp, "'%s' must not be called without "
+		      "'get_temp' ops set\n", __FUNCTION__))
 		return;
 
 	update_temperature(tz);
-- 
2.17.1

