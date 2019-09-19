Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9CAB717F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 04:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388328AbfISCSa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 22:18:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45541 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388321AbfISCS3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2019 22:18:29 -0400
Received: by mail-qt1-f196.google.com with SMTP id c21so2259018qtj.12
        for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2019 19:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CdiCEHMKk566XZjegQIR8gg3RICYYDFYb1Lqktv3Klc=;
        b=iAArHRRBTsV5yhKp9vUFsoOfflBPOmyRZtdEhLbpeyK61kwCKweRNYjzy+Zy04Crif
         HiQRJ6OaVxKNDg2sZQYLsCbBqPvUnIzBGL55Z0Sl9m4djlYd5UziTnkdP4RIjwxIKsn3
         Njc1vxS5Ih18BLZw6HVukX/o+mwgBsM3T7aStWKIPQprYDBmcrptPEuPEsO9RVWiLSpJ
         P4h1Kl2YSps2naPRH0TObYDVJLLFxfJWieojb0rPfXketj96TOb1vrh0s0V4rJeiuhHB
         oA3PHt5FM97ORUkV9rziVHeuWb/JXxXwztlcaORgYLLwhrov8bOpgv2xd5vHAvT4h5U4
         L66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CdiCEHMKk566XZjegQIR8gg3RICYYDFYb1Lqktv3Klc=;
        b=mZIJ8m91BcqPIZilwvlb0XMOySDVMJx88fQt/KcLS0DhHrS1Pr9TcOCqC6LuJ4YrvT
         gj+Ql8BfuCMZkjbifSYNDUMcj3Bt0ira2zsmusQqzqUc57g3Kdq/VCmR3vdRJQfoAtid
         94zvbxeGQTHyxIcGTDzQII9ZwItjfdjC/lAKALYJzXsPP/I78QoYh8lYoDv468SbbCGg
         2N02wZRoEZIeQKolv8lSsoiRawfizoBqjmWjmtWk4444ZeFF27yLV74MpjPmIm25ALuJ
         ln+NWQHUn16uhqRsbeQfUULJqeOhDfkCGPCTHdzJzzB8g0D7338H21cNMqixKi6OncQv
         H0KQ==
X-Gm-Message-State: APjAAAVmDlCxk3TOUe+FVC7352SVI+pd7o4u5+ulmxLsNfQTzIZB3t70
        HIY1+Jxe4Os3VCRZ6vtg2ZSpRw==
X-Google-Smtp-Source: APXvYqw2+kxRJ8EJ3nEnCluvCd7E46yWcBFu61Ab8biFE5LJvvb+8aL1yzz26d5V+Nb0YUs+87vKkg==
X-Received: by 2002:a0c:f712:: with SMTP id w18mr4600436qvn.244.1568859508633;
        Wed, 18 Sep 2019 19:18:28 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id o52sm5261275qtf.56.2019.09.18.19.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 19:18:27 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] thermal: of-thermal: Extend thermal dt driver to support bi-directional monitoring of a thermal trip point.
Date:   Wed, 18 Sep 2019 22:18:22 -0400
Message-Id: <1568859503-19725-4-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1568859503-19725-1-git-send-email-thara.gopinath@linaro.org>
References: <1568859503-19725-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce of_thermal_get_trip_monitor_type to return the direction
of monitoring of a thermal trip point. Also translate the DT information
regarding trip point monitor direction into the thermal framework.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/of-thermal.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index dc5093b..a5f6fdc 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -377,6 +377,20 @@ static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 	return 0;
 }
 
+static int of_thermal_get_trip_monitor_type
+				(struct thermal_zone_device *tz, int trip,
+				 enum thermal_trip_monitor_type *type)
+{
+	struct __thermal_zone *data = tz->devdata;
+
+	if (trip >= data->ntrips || trip < 0)
+		return -EDOM;
+
+	*type = data->trips[trip].monitor_type;
+
+	return 0;
+}
+
 static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 				    int *temp)
 {
@@ -401,6 +415,7 @@ static struct thermal_zone_device_ops of_thermal_ops = {
 	.set_trip_temp = of_thermal_set_trip_temp,
 	.get_trip_hyst = of_thermal_get_trip_hyst,
 	.set_trip_hyst = of_thermal_set_trip_hyst,
+	.get_trip_monitor_type = of_thermal_get_trip_monitor_type,
 	.get_crit_temp = of_thermal_get_crit_temp,
 
 	.bind = of_thermal_bind,
@@ -809,6 +824,7 @@ static int thermal_of_populate_trip(struct device_node *np,
 {
 	int prop;
 	int ret;
+	bool is_monitor_falling;
 
 	ret = of_property_read_u32(np, "temperature", &prop);
 	if (ret < 0) {
@@ -830,6 +846,12 @@ static int thermal_of_populate_trip(struct device_node *np,
 		return ret;
 	}
 
+	is_monitor_falling = of_property_read_bool(np, "monitor-falling");
+	if (is_monitor_falling)
+		trip->monitor_type = THERMAL_TRIP_MONITOR_FALLING;
+	else
+		trip->monitor_type = THERMAL_TRIP_MONITOR_RISING;
+
 	/* Required for cooling map matching */
 	trip->np = np;
 	of_node_get(np);
-- 
2.1.4

