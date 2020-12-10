Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422C02D5A2E
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 13:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388019AbgLJMQa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 07:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733239AbgLJMQ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 07:16:28 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69DBC0611CC
        for <linux-pm@vger.kernel.org>; Thu, 10 Dec 2020 04:15:30 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id y23so5092199wmi.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Dec 2020 04:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SL5r1XlZ94aUm2Qc3ziNrEN/y8mm4mqU/uGHBbVacJ4=;
        b=i4zw3sa/dq3c28aSZyi5OnHK34vamDUVVSCV6CY8XxrU+XUdO3RT+mpYnXsaXu1bu5
         a80zutXQ/Y1muZPG7gR1tk++vAo0E3WV8tQQXbMm4hpm67i1/kh/K/zmwc16nm9/ipk8
         gce7ve5V0smygbfR6piPk7qGAacAABdma9Qu0h08wWhkj20YJSAIOl4LZBRt9cYk6up+
         nmgZF+QSi6vTUZ/qmk8Iv4vgv4MYLUi0x4JJrIA4fTMRZXGa2pkdRJhZ04JT+sZoisl/
         HlSACKXv0O5oDId7y0iXEPegmqvJXiRDCkZV2DbFgYUweySQyyTJ9OBaAblj7LNyxDuk
         LEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SL5r1XlZ94aUm2Qc3ziNrEN/y8mm4mqU/uGHBbVacJ4=;
        b=dBfU6l2CkzFCR3ECb99l+tuM5EnG3hm6lgAwK756VaRHjRsERpxmBjIm8ZQ/trZgbC
         DTLnWDAI05TaekTTEIcnOwyhzkslZJI25nBCUsn82VxqbLTkfBt1LcPyDfNmGCMYSPCs
         Fv2I7EiZk6TOx4FoUCqNqlNlgYf2jvmp3/izs3Q7KgKHUA3iqM/hF/fkPmvJ8WxpanQc
         vCZoKGBuAYuAy8Rt23IYTvqygRB38zi/orlV9O9On6nMZOl2M0mPjebXE5u5/ROjuksW
         vMMfkThrWbTCG9qFDy2tqXxoN/xetJfHXtsJ+bBDDT6U8Jf5mYb68+l0h0dcxp/CQlTW
         3GLQ==
X-Gm-Message-State: AOAM530UMSlz7dZE4c8DGF7r16NW1BUCIYZMQtJ0c9K85B4a5m6B4A6U
        5DtZV6GvkEFYLhKl8TFHqbzb7Rrujs3W2Q==
X-Google-Smtp-Source: ABdhPJx2RWeVI7qUg+ib+fl2n/Npn6imFO13zZdF7zj7PycVeQIFhJbn3dc0VCJx5eUvOgAqZC/RXg==
X-Received: by 2002:a1c:a583:: with SMTP id o125mr7787239wme.91.1607602529494;
        Thu, 10 Dec 2020 04:15:29 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-158-132.adsl.proxad.net. [82.252.158.132])
        by smtp.gmail.com with ESMTPSA id k6sm8412863wmf.25.2020.12.10.04.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 04:15:28 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     kai.heng.feng@canonical.com, lukasz.luba@arm.com,
        srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH 5/5] thermal/core: Remove notify ops
Date:   Thu, 10 Dec 2020 13:15:14 +0100
Message-Id: <20201210121514.25760-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201210121514.25760-1-daniel.lezcano@linaro.org>
References: <20201210121514.25760-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With the remove of the notify user in a previous patch, the ops is no
longer needed, remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 3 ---
 include/linux/thermal.h        | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cee0b31b5cd7..d7481fdf4e4c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -407,9 +407,6 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 
 	trace_thermal_zone_trip(tz, trip, trip_type);
 
-	if (tz->ops->notify)
-		tz->ops->notify(tz, trip, trip_type);
-
 	if (trip_type == THERMAL_TRIP_HOT && tz->ops->hot)
 		tz->ops->hot(tz);
 	else if (trip_type == THERMAL_TRIP_CRITICAL)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 125c8a4d52e6..7e051b4cf715 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -77,8 +77,6 @@ struct thermal_zone_device_ops {
 	int (*set_emul_temp) (struct thermal_zone_device *, int);
 	int (*get_trend) (struct thermal_zone_device *, int,
 			  enum thermal_trend *);
-	int (*notify) (struct thermal_zone_device *, int,
-		       enum thermal_trip_type);
 	void (*hot)(struct thermal_zone_device *);
 	void (*critical)(struct thermal_zone_device *);
 };
-- 
2.17.1

