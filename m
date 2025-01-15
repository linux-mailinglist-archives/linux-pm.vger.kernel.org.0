Return-Path: <linux-pm+bounces-20483-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8066FA122CE
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 12:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5091881914
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 11:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9028E213E6F;
	Wed, 15 Jan 2025 11:39:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986FF20F968;
	Wed, 15 Jan 2025 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941177; cv=none; b=n+Ue3pd+dxWUcjeRYktkgELGXSsW3xELEZBCXiNVeT/UdPc+T0j4RgKrWpP5yh8N5JXw1PgDCwv8Csu9zQphxmH0BjLhZDGoVanldJu6IwzEQ6mv50h7u4PqwANeWeTEN+0ZOuYgjWjopjKBrlu/A18QpGW5WX60+6ME7wpAqHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941177; c=relaxed/simple;
	bh=fU9LjpnWlPykGUfJlYWRMdEruVigf7TQ5gejulzm53g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dT78UGC6kHeOFGdY3eCuSB4Jck1923GpG71F9iPXdtGrnDvDSKz+QZ9+QKXEvk88/SMDGafjW3EnX8qWt0Di/P42j5r1OWN3m28tbvEohNuR+/nzZaOPO4rr/ZpzHdhxld1rKkiulKPmmMHKhsbmvWWHbou/8ueBmslsgpW7LlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AC6512FC;
	Wed, 15 Jan 2025 03:40:03 -0800 (PST)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C75EF3F63F;
	Wed, 15 Jan 2025 03:39:33 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: arm-scmi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] pmdomain: arm: scmi_pm_domain: Send an explicit request to set the current state
Date: Wed, 15 Jan 2025 11:39:31 +0000
Message-Id: <20250115113931.1181309-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a system with multiple active SCMI agents, one agent(other than OSPM/
Linux or bootloader) would request to turn on a shared power domain
before the Linux boots/initialise the genpds. So when the Linux boots
and gets the power state as already ON, it just registers the genpd with
a default ON state.

However, when the driver that needs this shared power domain is probed
genpd sees that the power domain status is ON and never makes any SCMI
call to power it up which is correct. But, since Linux didn't make an
explicit request to turn on the shared power domain, the SCMI platform
firmware will not know if the OSPM agent is actively using it.

Suppose the other agent that requested the shared power domain to be
powered ON requests to power it OFF as it no longer needs it, the SCMI
platform firmware needs to turn it off if there are no active users of
it which in the above scenaro is the case.

As a result of SCMI platform firmware turning off the resource, OSPM/
Linux will crash the moment as it expects the shared power domain to be
powered ON.

Send an explicit request to set the current state when setting up the
genpd power domains so that OSPM registers its vote in the power domain
state with the SCMI platform firmware.

The other option is to not read the state and set the genpds as default
OFF, but it can't handle the scenario on certain platforms where SCMI
platform keeps all the power domains turned ON by default for faster boot
(or any other such variations) and expect the OSPM to turn off the unused
domains if power saving is required.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://lore.kernel.org/all/Z4aBkezSWOPCXcUh@bogus
Reported-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Reported-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/pmdomain/arm/scmi_pm_domain.c | 8 ++++++++
 1 file changed, 8 insertions(+)

Hi Ulf,

We need your feedback or suggestions for better solution on this matter.
Let us know if we can do something better with the genpd's help to resolve
this issue.

Regards,
Sudeep

diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
index a7784a8bb5db..86b531e15b85 100644
--- a/drivers/pmdomain/arm/scmi_pm_domain.c
+++ b/drivers/pmdomain/arm/scmi_pm_domain.c
@@ -96,6 +96,14 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 			continue;
 		}
 
+		/*
+		 * Register the explicit power on request to the firmware so
+		 * that it is tracked as used by OSPM agent and not
+		 * accidentally turned off with OSPM's knowledge
+		 */
+		if (state == SCMI_POWER_STATE_GENERIC_ON)
+			power_ops->state_set(ph, i, state);
+
 		scmi_pd->domain = i;
 		scmi_pd->ph = ph;
 		scmi_pd->name = power_ops->name_get(ph, i);
-- 
2.34.1


