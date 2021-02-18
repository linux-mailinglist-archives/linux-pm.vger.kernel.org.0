Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B648E31F22D
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 23:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBRWVX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 17:21:23 -0500
Received: from foss.arm.com ([217.140.110.172]:56294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229983AbhBRWVT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Feb 2021 17:21:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECFE71042;
        Thu, 18 Feb 2021 14:20:29 -0800 (PST)
Received: from ubuntu.arm.com (unknown [10.57.43.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DE8623F73D;
        Thu, 18 Feb 2021 14:20:27 -0800 (PST)
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        vireshk@kernel.org, cristian.marussi@arm.com
Cc:     morten.rasmussen@arm.com, chris.redpath@arm.com,
        ionela.voinescu@arm.com, nicola.mazzucato@arm.com
Subject: [PATCH v8 1/3] scmi-cpufreq: Remove deferred probe
Date:   Thu, 18 Feb 2021 22:23:24 +0000
Message-Id: <20210218222326.15788-2-nicola.mazzucato@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210218222326.15788-1-nicola.mazzucato@arm.com>
References: <20210218222326.15788-1-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The current implementation of the scmi_cpufreq_init() function returns
-EPROBE_DEFER when the OPP table is not populated. In practice the
cpufreq core cannot handle this error code.
Therefore, fix the return value and clarify the error message.

Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 491a0a24fb1e..c0345120a7d5 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -155,8 +155,10 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 
 	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
 	if (nr_opp <= 0) {
-		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
-		ret = -EPROBE_DEFER;
+		dev_err(cpu_dev, "%s: No OPPs for this device: %d\n",
+			__func__, ret);
+
+		ret = -ENODEV;
 		goto out_free_opp;
 	}
 
-- 
2.27.0

