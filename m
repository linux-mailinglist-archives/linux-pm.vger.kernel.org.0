Return-Path: <linux-pm+bounces-29421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 741C7AE60DE
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 11:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A306192597D
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 09:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EBF2571A2;
	Tue, 24 Jun 2025 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="R/Xm4ubo"
X-Original-To: linux-pm@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5AF17A31C
	for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750757493; cv=none; b=MrhrPSsa6HoiIWiLueN9iwfyXkRaA8MI9rzYPLjhEr6dRzv1oBsCdEi+2cCuvNs6VAB4w02qsZnrJt6TNrbO10kNHH31mIRbXgG5mYldes55BDnl/1rGhhkGAialZqHefVjKi6KpuptG+ifz33hR5fND57RMQRqN/0HLHkY0G7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750757493; c=relaxed/simple;
	bh=qGfxV/jrMLwzef8fCQdikIYaBsH2iBdg3OXQAwlJcGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AN1a7PSYNAJioUhFtQ1Aufh2nw85JpyWx7InKyO3M9cBx2cb8aFp81/chKMFnnTPqkupryrkeo/O7llWWZin5U2pehCFtfhNNiLaSCsiXUudiltFXkVdmK40NWTr9nX4BYHXn5bM1CBzRJnVnvTEVCkKgqg+cyesydF9W+KRpyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=R/Xm4ubo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=T7jXis08JelnyZlwgNxwTs4cs4/CTOJSw3Bz1clNg9k=; t=1750757491; x=1751967091; 
	b=R/Xm4uboGefHr3Sb7f/0UiXjEC0isNcbfP7ECgd6r4Nbykgki3+p3Kr6ax9HdfZMDh05tWefk0v
	P3Aw90lHKSVi2I0g/xO4Hk61EfbNlsHuvL+v8Er7o1SJAEAUa1K3FZRK7tfqO42YgVXIG0J6cBhC8
	kzJUO8ZFJBMci7L+sWQ2Wekts415GytrPOasRRJcElzN8RxeeLK61CtzrRXqG3xOOIaqNvxmRwLev
	e/HswXFulfiysldEgiyKnqlAe4tK1U5lTldZdSKD9XrYGrASIIPJG7jOY3noavI2rZ4OPEAlJfR/Y
	w0tibuSl+LbvelRdu6jkICtMG4y+psFkWypg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uTzzi-00000008jFV-2QXs;
	Tue, 24 Jun 2025 11:31:13 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Hans de Goede <hansg@kernel.org>
Subject: [PATCH] thermal: use a custom lock class for intel x86_pkg_temp
Date: Tue, 24 Jun 2025 11:30:01 +0200
Message-ID: <20250624093001.1359961-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
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

Benjamin
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 2 ++
 drivers/thermal/thermal_core.c               | 7 +++++++
 include/linux/thermal.h                      | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 3fc679b6f11b..ac219d3f688e 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -310,6 +310,7 @@ static int pkg_temp_thermal_trips_init(int cpu, int tj_max,
 
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
+	struct lock_class_key x86_pkg_temp_class;
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
index 17ca5c082643..2a34af9cd02a 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1657,6 +1657,13 @@ struct thermal_zone_device *thermal_tripless_zone_device_register(
 }
 EXPORT_SYMBOL_GPL(thermal_tripless_zone_device_register);
 
+void thermal_zone_set_lock_class(struct thermal_zone_device *tz,
+				 struct lock_class_key *lock_class)
+{
+	lockdep_set_class_and_name(&tz->lock, lock_class, tz->type);
+}
+EXPORT_SYMBOL_GPL(thermal_zone_set_lock_class);
+
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
 {
 	return tzd->devdata;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 0b5ed6821080..c39a1fe49c86 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -240,6 +240,9 @@ struct thermal_zone_device *thermal_tripless_zone_device_register(
 					const struct thermal_zone_device_ops *ops,
 					const struct thermal_zone_params *tzp);
 
+void thermal_zone_set_lock_class(struct thermal_zone_device *tz,
+				 struct lock_class_key *lock_class);
+
 void thermal_zone_device_unregister(struct thermal_zone_device *tz);
 
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
@@ -290,6 +293,10 @@ static inline struct thermal_zone_device *thermal_tripless_zone_device_register(
 					const struct thermal_zone_params *tzp)
 { return ERR_PTR(-ENODEV); }
 
+static inline void thermal_zone_set_lock_class(struct thermal_zone_device *tz,
+					       struct lock_class_key *lock_class)
+{ }
+
 static inline void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 { }
 
-- 
2.49.0


