Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C851288A24
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 15:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387871AbgJIN7H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 09:59:07 -0400
Received: from foss.arm.com ([217.140.110.172]:51824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgJIN7E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Oct 2020 09:59:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 724091063;
        Fri,  9 Oct 2020 06:59:03 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.51.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ACF2C3F70D;
        Fri,  9 Oct 2020 06:59:01 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org,
        Dietmar.Eggemann@arm.com, lukasz.luba@arm.com,
        ionela.voinescu@arm.com
Subject: [PATCH v3 1/2] thermal: power allocator: change the 'k_i' coefficient estimation
Date:   Fri,  9 Oct 2020 14:58:49 +0100
Message-Id: <20201009135850.14727-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201009135850.14727-1-lukasz.luba@arm.com>
References: <20201009135850.14727-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Intelligent Power Allocation (IPA) is built around the PID controller
concept. The initialization code tries to setup the environment based on
the information available in DT or estimate the value based on minimum
power reported by each of the cooling device. The estimation will have an
impact on the PID controller behaviour via the related 'k_po', 'k_pu',
'k_i' coefficients and also on the power budget calculation.

This change prevents the situation when 'k_i' is relatively big compared
to 'k_po' and 'k_pu' values. This might happen when the estimation for
'sustainable_power' returned small value, thus 'k_po' and 'k_pu' are
small.

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index e566806f1550..aa35aa6c561c 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -132,6 +132,7 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
 	int ret;
 	int switch_on_temp;
 	u32 temperature_threshold;
+	s32 k_i;
 
 	ret = tz->ops->get_trip_temp(tz, trip_switch_on, &switch_on_temp);
 	if (ret)
@@ -157,8 +158,11 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
 		tz->tzp->k_pu = int_to_frac(2 * sustainable_power) /
 			temperature_threshold;
 
-	if (!tz->tzp->k_i || force)
-		tz->tzp->k_i = int_to_frac(10) / 1000;
+	if (!tz->tzp->k_i || force) {
+		k_i = tz->tzp->k_pu / 10;
+		tz->tzp->k_i = k_i > 0 ? k_i : 1;
+	}
+
 	/*
 	 * The default for k_d and integral_cutoff is 0, so we can
 	 * leave them as they are.
-- 
2.17.1

