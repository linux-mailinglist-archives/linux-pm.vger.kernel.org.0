Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690D429D7F5
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 23:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733224AbgJ1W1Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 18:27:16 -0400
Received: from foss.arm.com ([217.140.110.172]:40028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733219AbgJ1W1P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Oct 2020 18:27:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A81C519F6;
        Wed, 28 Oct 2020 07:09:29 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.12.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC01E3F66E;
        Wed, 28 Oct 2020 07:09:26 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vireshk@kernel.org, robh+dt@kernel.org
Cc:     sboyd@kernel.org, nm@ti.com, rafael@kernel.org,
        sudeep.holla@arm.com, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, lukasz.luba@arm.com
Subject: [PATCH 4/4] firmware: arm_scmi/perf: Mark sustainable OPP
Date:   Wed, 28 Oct 2020 14:08:47 +0000
Message-Id: <20201028140847.1018-5-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028140847.1018-1-lukasz.luba@arm.com>
References: <20201028140847.1018-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Mark sustainable OPP frequency based on previously received value from
the firmware.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 82fb3babff72..a8f3fa1d7f1e 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -669,6 +669,16 @@ static int scmi_dvfs_device_opps_add(const struct scmi_handle *handle,
 			return ret;
 		}
 	}
+
+	if (dom->sustained_freq_khz) {
+		/* The sustained frequency is always in kHz */
+		freq = dom->sustained_freq_khz * 1000;
+		ret = dev_pm_opp_set_sustainable_opp_freq(dev, freq);
+		if (ret)
+			dev_warn(dev, "failed to add sustainable freq=%lu %d\n",
+				 freq, ret);
+	}
+
 	return 0;
 }
 
-- 
2.17.1

