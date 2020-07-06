Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC9C2155ED
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jul 2020 12:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgGFKz6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 06:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgGFKz4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2020 06:55:56 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540EEC08C5E0
        for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2020 03:55:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j4so37891742wrp.10
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2020 03:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p8WFiVjLmVPpS5PevlndhZ530MlitNcSeEqWsFmmzog=;
        b=tdUENaMxbiMgqVZasWVjkRfwQNdqnLloHmBbOr49mJNB+adoIjkDhmGJ7bGy3a60Xg
         AcpdS0+usLiP2VP/JkKC87xOOZNgcDONdOZWyf0MAh8FoCTx0V+3Hvn31RBNQrylno5F
         D7U1+PSOVbuq0GNmR3q4qv8R/38bAcnUH3ml6CP+B5Obmx/SxrkDobMIIFb5GHJ8rfJX
         eFiqyQqpb1HV0MsKe5vLMpMriprgCucbFfxz4ZinRMg/LR3fl6i8US5eSMLPVQrbP11o
         BDV8+6GxLgLLkjCEo+Rczp8QvGDzKxJNc+4doxpuzwuttUTfICGeJmjLijhcAZ4jHHuO
         rbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p8WFiVjLmVPpS5PevlndhZ530MlitNcSeEqWsFmmzog=;
        b=NwuOwjlrE7X6zbxCT6bkS3vYxcaq3GYl5oCCYeykXFkzYfF9gihE00tJR3FgC0H7JI
         GDACY+uOCntA+qMXYvx96ckFzrlHYX7xlYtpbke1n5WLwSGt9rppEn054U+c2ZHbdEdk
         +60+rsXHQAm3eIkY7NmPhHdWBRaifGzP9BYTf3KaKY1/Aasm7EAQN1vwHxuvO0HDj/6w
         bqlE3j5hB+yVp42mkVeQCOk25bSKFITIc07Byg03+Sk9tS4bPEn7GDhmz6ukDKPoSHgE
         feP6sHtOYw3/1suO2GY8hVqA4n05Oqx2cGDavpB8rK3rB+JVbnFsGLAh571EFd57t6gF
         J5ag==
X-Gm-Message-State: AOAM531+P1XqH4tV37/uSUbIb8svrq9crmHTcswL2yLilyUMvzkEDQWC
        K459gc1a0sbQDie4Vh7ZK8wD2Q==
X-Google-Smtp-Source: ABdhPJx0kiz7FATk9/QGSysaSxTuOpqlkgP56bxqmGPBRnPslVMvQbpUKDhoyhSLBmyuLgcILd/3EQ==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr47091458wrt.174.1594032952963;
        Mon, 06 Jul 2020 03:55:52 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.gmail.com with ESMTPSA id a22sm22931481wmj.9.2020.07.06.03.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:55:52 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 2/4] thermal: core: Get thermal zone by id
Date:   Mon,  6 Jul 2020 12:55:36 +0200
Message-Id: <20200706105538.2159-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706105538.2159-1-daniel.lezcano@linaro.org>
References: <20200706105538.2159-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The next patch will introduce the generic netlink protocol to handle
events, sampling and command from the thermal framework. In order to
deal with the thermal zone, it uses its unique identifier to
characterize it in the message. Passing an integer is more efficient
than passing an entire string.

This change provides a function returning back a thermal zone pointer
corresponding to the identifier passed as parameter.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/thermal_core.c | 14 ++++++++++++++
 drivers/thermal/thermal_core.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9caaa0b6d662..5fae1621fb01 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -668,6 +668,20 @@ int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
 	return ret;
 }
 
+struct thermal_zone_device *thermal_zone_get_by_id(int id)
+{
+	struct thermal_zone_device *tz = NULL;
+
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(tz, &thermal_tz_list, node) {
+		if (tz->id == id)
+			break;
+	}
+	mutex_unlock(&thermal_list_lock);
+
+	return tz;
+}
+
 void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
 					  const char *cdev_type, size_t size)
 {
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 71d88dac0791..4f8389efaa62 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -50,6 +50,8 @@ int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
 int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
 			      void *thermal_governor);
 
+struct thermal_zone_device *thermal_zone_get_by_id(int id);
+
 struct thermal_attr {
 	struct device_attribute attr;
 	char name[THERMAL_NAME_LENGTH];
-- 
2.17.1

