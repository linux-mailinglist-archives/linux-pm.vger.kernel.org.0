Return-Path: <linux-pm+bounces-24010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7709CA60E0B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 10:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E2B17DCE7
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 09:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76841E04AC;
	Fri, 14 Mar 2025 09:59:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53541C861D;
	Fri, 14 Mar 2025 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946341; cv=none; b=LkehnUS8UqFxw8RTqTz3armxDU0zgh7RfsMMVnU4AuR2S4Iyvsux73HjO1AHt88bIC1EnlMdXwLRaMe70j6PjS38HzO9RmOPYkzVtBxJHyGJSCHD6xaR60l8OciODA7FTsKZ0d0qK9K2TSGU3ejuDgNMv8W8kIzC6/k35svpAHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946341; c=relaxed/simple;
	bh=K1h1MVAObFi6tQixkzWPt9YkRTLSw9dWUT3Z/rBoF4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LxRyUiCSZc0RRedXOZNPsGITqKqMvqH993AFqeT4uiwua/Uvh2zx7XO6jn1U+rphwaePOagIUkys83FcMBNMXLVjAhY6grKm00SK+3i65+zIauoONbrIKs2/gDVwoulzNNvkEBFwuVvj+z+6utv79+rqihDsADVCkYhm81hvhIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CB3E1424;
	Fri, 14 Mar 2025 02:59:09 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C7AC43F5A1;
	Fri, 14 Mar 2025 02:58:57 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-pm@vger.kernel.org,
	arm-scmi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Subject: [PATCH] pmdomain: arm: scmi_pm_domain: Remove redundant state verification
Date: Fri, 14 Mar 2025 09:58:51 +0000
Message-Id: <20250314095851.443979-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, scmi_pd_power() explicitly verifies whether the requested
power state was applied by calling state_get(). While this check could
detect failures where the state was not properly updated, ensuring
correctness is the responsibility of the SCMI firmware.

Removing this redundant state_get() call eliminates an unnecessary
round-trip to the firmware, improving efficiency. Any mismatches
between the requested and actual states should be handled by the SCMI
firmware, which must return a failure if state_set() is unsuccessful.

Additionally, in some cases, checking the state after powering off a
domain may be unreliable or unsafe, depending on the firmware
implementation.

This patch removes the redundant verification, simplifying the function
without compromising correctness.

Cc: Peng Fan <peng.fan@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>
Reported-and-tested-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/pmdomain/arm/scmi_pm_domain.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
index 86b531e15b85..2a213c218126 100644
--- a/drivers/pmdomain/arm/scmi_pm_domain.c
+++ b/drivers/pmdomain/arm/scmi_pm_domain.c
@@ -24,8 +24,7 @@ struct scmi_pm_domain {
 
 static int scmi_pd_power(struct generic_pm_domain *domain, bool power_on)
 {
-	int ret;
-	u32 state, ret_state;
+	u32 state;
 	struct scmi_pm_domain *pd = to_scmi_pd(domain);
 
 	if (power_on)
@@ -33,13 +32,7 @@ static int scmi_pd_power(struct generic_pm_domain *domain, bool power_on)
 	else
 		state = SCMI_POWER_STATE_GENERIC_OFF;
 
-	ret = power_ops->state_set(pd->ph, pd->domain, state);
-	if (!ret)
-		ret = power_ops->state_get(pd->ph, pd->domain, &ret_state);
-	if (!ret && state != ret_state)
-		return -EIO;
-
-	return ret;
+	return power_ops->state_set(pd->ph, pd->domain, state);
 }
 
 static int scmi_pd_power_on(struct generic_pm_domain *domain)
-- 
2.34.1


