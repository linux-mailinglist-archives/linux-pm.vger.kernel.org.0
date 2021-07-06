Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F98D3BD797
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 15:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhGFNVa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 09:21:30 -0400
Received: from foss.arm.com ([217.140.110.172]:42164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231880AbhGFNV2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Jul 2021 09:21:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 918AC1042;
        Tue,  6 Jul 2021 06:18:49 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.7.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5F5413F73B;
        Tue,  6 Jul 2021 06:18:47 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Chris.Redpath@arm.com, Beata.Michalska@arm.com,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, amit.kachhap@gmail.com
Subject: [RFC PATCH v2 4/6] thermal: Add interface to cooling devices to handle governor change
Date:   Tue,  6 Jul 2021 14:18:26 +0100
Message-Id: <20210706131828.22309-5-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210706131828.22309-1-lukasz.luba@arm.com>
References: <20210706131828.22309-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add interface to cooling devices to handle governor change, to better
setup internal needed structures or to cleanup them. This interface is
going to be used by thermal governor Intelligent Power Allocation (IPA).
which requires to setup monitoring mechanism in the cpufreq cooling
devices.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/thermal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index d296f3b88fb9..79c20daaf287 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -87,6 +87,7 @@ struct thermal_cooling_device_ops {
 	int (*get_requested_power)(struct thermal_cooling_device *, u32 *);
 	int (*state2power)(struct thermal_cooling_device *, unsigned long, u32 *);
 	int (*power2state)(struct thermal_cooling_device *, u32, unsigned long *);
+	int (*change_governor)(struct thermal_cooling_device *cdev, bool set);
 };
 
 struct thermal_cooling_device {
-- 
2.17.1

