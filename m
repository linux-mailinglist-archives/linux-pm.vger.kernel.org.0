Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB772D04CE
	for <lists+linux-pm@lfdr.de>; Sun,  6 Dec 2020 13:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgLFMim (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Dec 2020 07:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgLFMim (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Dec 2020 07:38:42 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2A3C0613D1
        for <linux-pm@vger.kernel.org>; Sun,  6 Dec 2020 04:38:01 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r3so9965200wrt.2
        for <linux-pm@vger.kernel.org>; Sun, 06 Dec 2020 04:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XptJK1kJZCCNiHTchuzcwvQbCAcodgoNqQmzzWdVmdo=;
        b=ouYefsCpglGL2mE8NfS9LtSfpVgVSRPlT+WOB6HdXcmKvSZok0M4GFXimO6se6kA9W
         hodFaRZazQrAjhF6hS70NQ2WRCs7YEwxVAWfu3VsF3nlXjx33fN/cicjSFr3VVJM991A
         d/z3kah1juL0UTPW50/bmF1PDBJxzPzRe3hTbPooPyWASejsaBz3YorhZUJJ0W81Bz8+
         7JP9JnHo8qGugGde35nKeCFGRNrNoHaRAm0RHv3G8BLCvJ65Omx64VO8P3wP9o2zQ88L
         jtiRrxEaO0BZonhTrxASJivO4CZORkTAR1wzdVq3ttP9udPUxSeabX6XLOILzy2IVxma
         tDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XptJK1kJZCCNiHTchuzcwvQbCAcodgoNqQmzzWdVmdo=;
        b=J+cAZa28BRpHu0lxyn0naJ5sLvd14qNoAykRhihlrZWXyQciu9/jYXt1EYt34pW2k8
         HuVL5fREPYxegdgyyjfMGXEndgjpLTQuEx/fbxp0/t1jnisFehnKn7dqJAxW5N44vhLA
         Kzt+vo2WGy9MQJz2We4GvaCVvB6saxBogRFdAyQgl2PodT6WvCLrxsv7RFOowliL49cO
         5PB2bwz2Xkx7SLIBor24Px6FCQfQAfL+wRFvw6iD+srHAXKwI+Fmr/5zMGhSW06Ce7uH
         AE8HSWqBtBGrO+Hy9TDn+Q14exZBFBNu8juLuPFcR6K+nQr03l4LQ78hVqlhK3onGvcz
         ptSg==
X-Gm-Message-State: AOAM5311D21hHaAmn1OYaSlwLRLUb4unV1Srtgl3989YpmO9YcVZqh+s
        xmBz/GwSMwum3W7UJ7uY5Jnn4g==
X-Google-Smtp-Source: ABdhPJzuYUxbQn+kz7+SXM3X5IUOYUL9LT3Qb8sE1MX/h1aki0+r1TukFu6UuszlKlVhjjSUjgjSDw==
X-Received: by 2002:a5d:4149:: with SMTP id c9mr5777775wrq.271.1607258280111;
        Sun, 06 Dec 2020 04:38:00 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-158-132.adsl.proxad.net. [82.252.158.132])
        by smtp.gmail.com with ESMTPSA id l3sm11047356wrr.89.2020.12.06.04.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 04:37:59 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, Len Brown <lenb@kernel.org>
Subject: [PATCH RFD] thermal: core: Browse the trip points in reverse order and exit
Date:   Sun,  6 Dec 2020 13:37:53 +0100
Message-Id: <20201206123753.28440-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When reading the code it is unclear if the loop is there to handle one
trip point or all the trip points above a certain temperature.

With the current code, the throttle function is called for every trip
point crossed and it is ambiguous if that is made on purpose.

Even digging into the history up to April, 16th 2015, the initial git
import of the acpi implementation of the loop before being converted
into a generic code, it is unclear if all trip points must be handled
or not.

When the code was intially written, was it assuming there can be only
one passive or active trip point ?

The cooling effect of the system will be very different depending on
how this loop is considered.

Even the IPA governor is filtering out multiple trip points to stick
to one value. Was the code to accomodate with a bogus loop and based
on the multiple non-critical trip points ?

Another example: arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
defines 7 passive trip points, each of them mapped to the *same*
cooling device but with different min-max states. That means the
handle trip points loop will go through all these seven trip points
and change the state of the cooling device seven times.

On the other hand, a thermal zone can have two different cooling
devices mapped to two trip points, shall we consider having both
cooling devices acting together when the second trip point is crossed
(eg. 1st trip point: cpufreq cooling device + 2nd trip point: fan), or
the second cooling device takes over the first one ? IOW, combine the
cooling effects or not ?

Depending on the expected behavior, the loop can be done in the
reverse order and exit after processing the highest trip point.

Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9d6a7b7f8ab4..d745b62a63af 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -562,8 +562,9 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 
 	tz->notify_event = event;
 
-	for (count = 0; count < tz->trips; count++)
-		handle_thermal_trip(tz, count);
+	for (count = tz->trips - 1; count >= 0; count--)
+		if (handle_thermal_trip(tz, count))
+			break;
 
 	monitor_thermal_zone(tz);
 }
-- 
2.17.1

