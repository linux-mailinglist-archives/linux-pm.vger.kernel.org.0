Return-Path: <linux-pm+bounces-29427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96571AE665C
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 15:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B404016FF3B
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 13:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEDB29994E;
	Tue, 24 Jun 2025 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="N7pwSC/O"
X-Original-To: linux-pm@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F52D2BEC24
	for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750771480; cv=none; b=u8LyVAFrWKZ1ndYfhEPZdhs3b+bzx22aM4rzU0C9f5QynK9YPRosL0UiEEeO5i+e1GIF0S8Gm8mXPxft+pDp7OFMn1Vb/YlKMnLWrpQIzv6L6OVBsC6XcyHTuaIVtN1/QdFSI5EkOYV04uY0fg3oYLT7fwyHhYjlcnUv2KtkP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750771480; c=relaxed/simple;
	bh=7kCRqllTb/FGpaNg90Pj937+g19NQCsDq5Cg8MUzwIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+GuIro52Rnt4KbjqdcCw3qMC2tkbDO/tFt93+zAWuo5kZPuOoPgYeK4S/EiGK9tat38J2QNwzcWTz4IHHLF93ZYURl5URWHwDVl6PNbGp2Oak8Dd7DIuXgXl82DQfL4pc1kCGr8r3PSDiEaq/4SXBMqEytHNwaEbbnXjawzlVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=N7pwSC/O; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=O9/uArJCSbWFklG/BkaREY2/55E+T8Cj4Lckvkogrp4=; t=1750771479; x=1751981079; 
	b=N7pwSC/ORdAC4l6Iz/HCyctV6C0e/dKVzQgz1rNFRpB1xFxCENbiGp893lEtptZRntslvQOkPJs
	64WBni/LR0g84OuCe/GUa9kBcVUe5/u9PBFCps2TpKAToZFEfb4SErLzQpvHy6ulGudIHGQ4OwdSd
	+G4FD1+eVIGo5wtClI41NUDEcyVh+7uhvB+Evlg3xJJy3dq69qmFhAQjtHPtP5yYPVtbJzVNZmM0w
	hAiIOzPShahPfZFvUvPvMV3Xwu3nB5BmBU/5J5/PJsI8YJ/MjOTOPVVNbdDZ2WD3wfPmEpP9AXhac
	4Rn0ucLWKPlY+M3uYhVh4WhcGltUVtRcLEUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uU3db-00000008rdG-0I5Y;
	Tue, 24 Jun 2025 15:24:35 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Hans de Goede <hansg@kernel.org>
Subject: [PATCH v2] thermal: use a custom lock class for intel x86_pkg_temp
Date: Tue, 24 Jun 2025 15:24:06 +0200
Message-ID: <20250624132406.1485407-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The intel driver has code paths that will take the tz->lock while the
cpuhp_state-up lock is held. As the cpuhp_state-up lock is used in other
code paths, it may happen that lockdep detects possible deadlocks
through unrelated thermal zone devices.

Fix these false positives by using a separate lockdep class for the
x86_pkg_temp thermal device.

Reported-by: Hans de Goede <hansg@kernel.org>
Closes: https://lore.kernel.org/linux-pm/e9d7ef79-6a24-4515-aa35-d1f2357da798@kernel.org/
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

Hi,

I believe that this should solve the lockdep warning that Hans was
seeing. That said, I have not tested it much.

v2:
- Fix function name
- Mark lock class variable static

Benjamin
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 2 ++
 drivers/thermal/thermal_core.c               | 7 +++++++
 include/linux/thermal.h                      | 8 ++++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 3fc679b6f11b..15d3c904eaa3 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -310,6 +310,7 @@ static int pkg_temp_thermal_trips_init(int cpu, int tj_max,
 
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
+	static struct lock_class_key x86_pkg_temp_class;
 	struct thermal_trip trips[MAX_NUMBER_OF_TRIPS] = { 0 };
 	int id = topology_logical_die_id(cpu);
 	u32 eax, ebx, ecx, edx;
@@ -349,6 +350,7 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 		err = PTR_ERR(zonedev->tzone);
 		goto out_kfree_zonedev;
 	}
+	thermal_zone_device_set_lock_class(zonedev->tzone, &x86_pkg_temp_class);
 	err = thermal_zone_device_enable(zonedev->tzone);
 	if (err)
 		goto out_unregister_tz;
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 17ca5c082643..ff5c2e01904a 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1657,6 +1657,13 @@ struct thermal_zone_device *thermal_tripless_zone_device_register(
 }
 EXPORT_SYMBOL_GPL(thermal_tripless_zone_device_register);
 
+void thermal_zone_device_set_lock_class(struct thermal_zone_device *tz,
+					struct lock_class_key *lock_class)
+{
+	lockdep_set_class_and_name(&tz->lock, lock_class, tz->type);
+}
+EXPORT_SYMBOL_GPL(thermal_zone_device_set_lock_class);
+
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
 {
 	return tzd->devdata;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 0b5ed6821080..3cb4cf60b66d 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -240,6 +240,9 @@ struct thermal_zone_device *thermal_tripless_zone_device_register(
 					const struct thermal_zone_device_ops *ops,
 					const struct thermal_zone_params *tzp);
 
+void thermal_zone_device_set_lock_class(struct thermal_zone_device *tz,
+					struct lock_class_key *lock_class);
+
 void thermal_zone_device_unregister(struct thermal_zone_device *tz);
 
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
@@ -290,6 +293,11 @@ static inline struct thermal_zone_device *thermal_tripless_zone_device_register(
 					const struct thermal_zone_params *tzp)
 { return ERR_PTR(-ENODEV); }
 
+static inline void
+thermal_zone_device_set_lock_class(struct thermal_zone_device *tz,
+				   struct lock_class_key *lock_class)
+{ }
+
 static inline void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 { }
 
-- 
2.50.0


