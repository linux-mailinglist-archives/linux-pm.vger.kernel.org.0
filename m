Return-Path: <linux-pm+bounces-32272-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DD4B248D2
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 13:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC07883AD3
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 11:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBC22FE57C;
	Wed, 13 Aug 2025 11:47:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E392D46D7;
	Wed, 13 Aug 2025 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085638; cv=none; b=VPN/uqGxR0vG2yra2BrrYeLRFXyXAEppxVxKz2TocNCazuF/fvapJW/g3EE+LbwlGv10yBb861I/h9JQkL1KDqa7yRfNo0A4nzudVrH+Ur1EvrUtITiMXY0N6G1P2jCMaTm4gVU0rD2zANlkVduKAIG+mwvUFbsnE6DiRp3sWZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085638; c=relaxed/simple;
	bh=yzyxKCq8ohEEWFAOfDp9+fs8K7yk3TJK2uiyQ5chs2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gr+LMc+fc3Mm1bW2qZoZRvP1UtNGjApZOzY87gf2Ta3wuVIZsXk0h+9W0i9N9GtKbzIKvfNpoMVAgOBvTNcE9DcPYO2q9EmZV/vX7TriN2Mq/BOlHTShmWMRKuv6PlDlTG/vr5D2ePJWkytM7aGBoOpN8P8uIANIfMIK6bASpnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 895BE12FC;
	Wed, 13 Aug 2025 04:47:08 -0700 (PDT)
Received: from pluto.guest.local (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DE6D3F738;
	Wed, 13 Aug 2025 04:47:13 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 8/8] powercap: arm_scmi: Enable multiple constraints support
Date: Wed, 13 Aug 2025 12:46:09 +0100
Message-ID: <20250813114609.1305571-9-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250813114609.1305571-1-cristian.marussi@arm.com>
References: <20250813114609.1305571-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize the domains with all the discovered available constraints,
making available multiple per-domain constraints when the platform has
advertised support for multiple concurrent power limits.

CC: "Rafael J. Wysocki" <rafael@kernel.org>
CC: linux-pm@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/powercap/arm_scmi_powercap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index de2dc1f6f2a9..559767e143b0 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -2,7 +2,7 @@
 /*
  * SCMI Powercap support.
  *
- * Copyright (C) 2022 ARM Ltd.
+ * Copyright (C) 2022-2025 ARM Ltd.
  */
 
 #include <linux/device.h>
@@ -311,7 +311,7 @@ static int scmi_powercap_register_zone(struct scmi_powercap_root *pr,
 
 	z = powercap_register_zone(&spz->zone, scmi_top_pcntrl, spz->info->name,
 				   parent ? &parent->zone : NULL,
-				   &zone_ops, 1, &constraint_ops);
+				   &zone_ops, spz->info->num_cpli, &constraint_ops);
 	if (!IS_ERR(z)) {
 		spz->height = scmi_powercap_get_zone_height(spz);
 		spz->registered = true;
-- 
2.47.0


