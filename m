Return-Path: <linux-pm+bounces-11545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9AF93F8FD
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C551C221F2
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 15:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F849156F20;
	Mon, 29 Jul 2024 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UfhArtS+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87BD156864
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265419; cv=none; b=PhqzkDXX5H/DlRWYG+kavXBuaNw5UU2TUpIxpjbKHaKZCGhOdJsFLgp/8BI/uF7sZHhqPNzZvL8oC8g4/nCDu1Rv/6SQut68ow4pelB+xoV2N85jZ/BjUT0CtrPHRx1u632fhzLEIfHHRTYJsdLlkmfbTRK4czf2WI7OAE5Vhmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265419; c=relaxed/simple;
	bh=Luu89QxJ9UUx/pMETY8/+y9F7kJjSWoxhcq37rD9X/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZb1lLgacE+F+m56JKE4leQTKSVoohYO2U/K72St5I4i9EAOQeul+wTCLafKS1LHfsOjrGT04pb/hB6V4BfrRmcxVvqOVTAOi6UaqV560BPHl/qKF5Jrc3laiS13DI89klqsjI0sejs6oQAtjlzLZbV5P/PLSC6IFT6Vbe9m4X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UfhArtS+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4281faefea9so5432395e9.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722265416; x=1722870216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvNWqKnvrqIzR2L2p9oPRLbv9hLOEbE07wjBN2Aeug4=;
        b=UfhArtS+Hi+VSJ/vjXQAsp2cGl2Vbc89Oofv5HcIJHxeTMXh1TA83CTgQ0q1y4/nOJ
         nOqziaQZqMgIulthsvyewumrGQJH2bqNE3meni3r2Eo2VCgj0WNm4OiNRXL5at3pfkQQ
         XQB4Tj+bCZIqkGNbLTxm+8XiCtk4XS817jnQmZTjZS7djDVfax72wRXp62EGhYDGMOF6
         /f6mMXxl6oDO+XrNQ8AGC/zOonoItMIx1JN+Pudxfjib9DkQr+HYp5BihjTv3WfYLp8f
         tsHscCTIhfqINOT/bwF8tOEWVdlJuZcQvJjif+mNMSDY67CHQjnnzwbqhS4DiWjBKk31
         xfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722265416; x=1722870216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvNWqKnvrqIzR2L2p9oPRLbv9hLOEbE07wjBN2Aeug4=;
        b=rDQg+gYODwl26fots/MEHQWF3ohoSajzxff24E12vQpyZYW1XhU+1c+/8BMGYyEFwx
         RgD529XJHoZDCPyjEeuftNy/ykAbTmA5Xc5Gqk5kktMvIAr1DxixUGxI3UEoXAz92ett
         rv5w1vXZtEKkEFDV3/ezxGAuulSbUaAXCbryu/wP1uBllopwWE0DGOdxTnkdZ3ojDdFc
         gTGeA2Zzs2xQWh6ii7lusBfDjw3Y4NAY7BeK3HAeQ77YKgR3c4h5BHW81cAWN8cukBkx
         ACDMzyovJSARxXv4Xd0zw4fBt9wJwf7MHwL63r0CnObBeoiatdfQP6NwdluhNl8lVQFu
         obbQ==
X-Gm-Message-State: AOJu0YyPKF/Fq//RQad49/EUuuFdE7D5a2N1Q7Pg986UAWLPsTsf8sH8
	dzIqjjYcZoqbw8XIVbUkUgKeoolRl35rbs6HOq4l3oAepefgzVrc0h7OyKogA/Y=
X-Google-Smtp-Source: AGHT+IE4AjIWNU/ddobgDHZC/WypkJsZhyEFA7I6jLUfPSURrbhofhvqMu9IYGrhpAjeRMvlH1P8Cg==
X-Received: by 2002:a5d:40cb:0:b0:368:445e:91cc with SMTP id ffacd0b85a97d-36b5cf0aa8cmr5376222f8f.21.1722265415868;
        Mon, 29 Jul 2024 08:03:35 -0700 (PDT)
Received: from mai.box.freepro.com (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863b45sm12652803f8f.107.2024.07.29.08.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 08:03:35 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v1 3/7] thermal/core: Connect the threshold with the core
Date: Mon, 29 Jul 2024 17:02:52 +0200
Message-ID: <20240729150259.1089814-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729150259.1089814-1-daniel.lezcano@linaro.org>
References: <20240729150259.1089814-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize, de-initialize and handle the threshold in the same place
than the trip points.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5cfa2a706e96..7d35815b56b8 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -599,6 +599,8 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 
 	handle_thermal_trip(tz, &way_up_list, &way_down_list, &low, &high);
 
+	thermal_thresholds_handle(tz, &low, &high);
+
 	thermal_zone_set_trips(tz, low, high);
 
 	list_sort(NULL, &way_up_list, thermal_trip_notify_cmp);
@@ -1569,6 +1571,10 @@ thermal_zone_device_register_with_trips(const char *type,
 			goto unregister;
 	}
 
+	result = thermal_thresholds_init(tz);
+	if (result)
+		goto remove_hwmon;
+
 	mutex_lock(&thermal_list_lock);
 	mutex_lock(&tz->lock);
 	list_add_tail(&tz->node, &thermal_tz_list);
@@ -1589,6 +1595,8 @@ thermal_zone_device_register_with_trips(const char *type,
 
 	return tz;
 
+remove_hwmon:
+	thermal_remove_hwmon_sysfs(tz);
 unregister:
 	device_del(&tz->device);
 release_device:
@@ -1677,6 +1685,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	thermal_set_governor(tz, NULL);
 
+	thermal_thresholds_exit(tz);
 	thermal_remove_hwmon_sysfs(tz);
 	ida_free(&thermal_tz_ida, tz->id);
 	ida_destroy(&tz->ida);
-- 
2.43.0


