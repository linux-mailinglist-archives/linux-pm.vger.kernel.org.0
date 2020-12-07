Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3EF2D191D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 20:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgLGTGh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 14:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgLGTGg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 14:06:36 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DADDC06179C
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 11:05:56 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id a12so7043898wrv.8
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2020 11:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UI14tg3SGBkYGbg6Pqk9K057841s9DbKHhwnpKgE5MI=;
        b=pKx+MyG41dms/4j23nNZ3/iUylLDFBjR6zjZE8BchspCPgUCDWcLc90uB9rE36O+Ez
         aqf4pfnfMht4Yqb0boRP3IrxsjsESBQWS4bYeBWdE/R32M4YVuvue32iyiELLGguaFLj
         4qTlZGeC2LMHE34f/F3/rH6KunfXyouDgDMtLLiiQMrrc+CAxUujKIaJDpwj1T1D0nbN
         2ZfvWQmpLgTBbMiUbJAm/Vgexa9N4jWfjRqsGY5Zy+97OqkEaxkMtgJ7XLekrEL4d4eJ
         sCWizb1v4PT0IpMtWhLEBPulI9/VTu7UDTKykoyAzkbQuHyD7npY9LHg5FAs6tPJnDLA
         YLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UI14tg3SGBkYGbg6Pqk9K057841s9DbKHhwnpKgE5MI=;
        b=hIGTtTlIBATQryu9gyDZYsl+i+TIP6eWaT2B/ex+hBBmM+NgmOyehmcXyi7Uy/E+no
         eDJozEKKbhhz2dFH24V0Csc3d1YF58iyleRwB0VVVig9QA+qDVvGV6dxccvS/Z6pQOH0
         E8ur32lvo3r/A5F2TiZA3V1KY1RiQ+FVVRRMmxeSBfmBodd8rE/k1Y2/4dQMOPfk045v
         NxGydrtLjZaKODEHd0sVzs6F6HPs+i8WzIyDLxtyEyrKDpAgDigwqUW4mPLtR1IBGVA9
         jlxbXNK7St9tEOBLrYjLqH8ih/HKjOnZQzhOulJfD3LgjpW06z1OQpfUBqfpnT3SHcuL
         mHDA==
X-Gm-Message-State: AOAM531j5spmyvX1pjzCpnsKuRlxhSSJHwtYlyw3j1LcKzR8+4ENh+i6
        ERXOdbRVuhF3hKJLd2uf5l3zAg==
X-Google-Smtp-Source: ABdhPJxHlboYN9ZsdYwuXvc9ho5FJzzeaFH+p3W6D13RLecafmX6lJtPJUz5zSyorCxNVdOaBSedOw==
X-Received: by 2002:a5d:634d:: with SMTP id b13mr21597532wrw.310.1607367954657;
        Mon, 07 Dec 2020 11:05:54 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-158-132.adsl.proxad.net. [82.252.158.132])
        by smtp.gmail.com with ESMTPSA id e17sm6252886wrw.84.2020.12.07.11.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:05:53 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thermal/core: Emit a warning if the thermal zone is updated without ops
Date:   Mon,  7 Dec 2020 20:05:30 +0100
Message-Id: <20201207190530.30334-1-daniel.lezcano@linaro.org>
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

As the check is done in thermal_zone_get_temperature() via the
update_temperature() function, it is pointless to have the check and
the WARN in the thermal_zone_device_update() function. Just remove the
check and let the next call to raise the warning.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 90e38cc199f4..1bd23ff2247b 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -448,17 +448,17 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 	monitor_thermal_zone(tz);
 }
 
-static void update_temperature(struct thermal_zone_device *tz)
+static int update_temperature(struct thermal_zone_device *tz)
 {
 	int temp, ret;
 
 	ret = thermal_zone_get_temp(tz, &temp);
 	if (ret) {
 		if (ret != -EAGAIN)
-			dev_warn(&tz->device,
-				 "failed to read out thermal zone (%d)\n",
-				 ret);
-		return;
+			dev_warn_once(&tz->device,
+				      "failed to read out thermal zone (%d)\n",
+				      ret);
+		return ret;
 	}
 
 	mutex_lock(&tz->lock);
@@ -469,6 +469,8 @@ static void update_temperature(struct thermal_zone_device *tz)
 	trace_thermal_temperature(tz);
 
 	thermal_genl_sampling_temp(tz->id, temp);
+
+	return 0;
 }
 
 static void thermal_zone_device_init(struct thermal_zone_device *tz)
@@ -553,11 +555,9 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 	if (atomic_read(&in_suspend))
 		return;
 
-	if (!tz->ops->get_temp)
+	if (update_temperature(tz))
 		return;
 
-	update_temperature(tz);
-
 	thermal_zone_set_trips(tz);
 
 	tz->notify_event = event;
-- 
2.17.1

