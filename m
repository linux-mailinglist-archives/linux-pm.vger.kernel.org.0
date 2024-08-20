Return-Path: <linux-pm+bounces-12506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8073A957C5D
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 06:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4FB21C23B54
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 04:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171A645C14;
	Tue, 20 Aug 2024 04:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="pb5GP14V"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149E52F5E;
	Tue, 20 Aug 2024 04:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724127607; cv=none; b=q6yhQJ7NPyt2llVoP2m0/QoWpQLo3EalG7EXDGmp2QD/GqfTQNI+aHPUOX3CJ2mw/PFQHR/th1zUnEzHIE3JRn6m1Jcv5QxqQ51raDWpKBXh1YgeOtecLqRdUvBxe0fh9DguR4JwmqlivFRBHIrgmLPQG9pQqZXogr9MYyvlriM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724127607; c=relaxed/simple;
	bh=ZudlhkBfQ0BwjRqg6u+viifztToroejZY1NZzXHOP20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VSVJwEctZADQ09kobp+1+FRxWWYgw+OEQkDyMVkKLwIN1Our+i8TaPgBzhxDp6DsDL13D/LIesY3+HCBUUpClqubyAoFU6nU5QZ0J4sWuavERchs4OXHzbtWvVLrldp2OA7kECP9eWSBl9yZHb0HdCEpz7hdCm/1ng4TjwS5mLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=pb5GP14V; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A22153F215;
	Tue, 20 Aug 2024 04:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724127110;
	bh=NPnIDwRkzJjOEruOcZJb3i9Ia0ap8ihLS7L3WjqbHZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=pb5GP14VL3QJlo0x60EcQTjFzHzksA5Hp4AlqHquAOoVjywLlsscHlmpWBSoQsFK7
	 1IBwkCprvBZtRZhFEBzwJL6ZMhlV8vpnCFPH5+g61cx+YV2nVVaZrSDGICJwwxPW8H
	 EYbhm/fjhQz3B2ef9ox2+4OkkItvjjymRsosSZmHOKLhsf0UUv25jUK3HnIqS93zz0
	 W7JNOAW3Vw2suTKTJM/2gwU0iP6plnrOgoYag/xLEJDmVxdExWykO5DdidwPAkTchI
	 Zs1rY5un2vipuw6UZtSnQgNTz1lSGmwxcsv1dgV0jr6UMJKeiuTHN8svP+JpsruOc9
	 TZgNLfNtAI9YA==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: jacob.jun.pan@linux.intel.com,
	lenb@kernel.org
Cc: artem.bityutskiy@linux.intel.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2] intel_idle: Disable C1E on Jasper Lake and Elkhart Lake
Date: Tue, 20 Aug 2024 12:11:28 +0800
Message-ID: <20240820041128.102452-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCIe ethernet throughut is sub-optimal on Jasper Lake and Elkhart Lake.

The CPU can take long time to exit to C0 to handle IRQ and perform DMA
when C1E is enabled.

So adjust intel_idle to use _CST when state_table is absent, and disable
C1E on those two platforms.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219023
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Allow the driver to use _CST when state_table is absent.

 drivers/idle/intel_idle.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 9aab7abc2ae9..ac1c6f4f9c7f 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1475,6 +1475,10 @@ static const struct idle_cpu idle_cpu_dnv __initconst = {
 	.use_acpi = true,
 };
 
+static const struct idle_cpu idle_cpu_tmt __initconst = {
+	.disable_promotion_to_c1e = true,
+};
+
 static const struct idle_cpu idle_cpu_snr __initconst = {
 	.state_table = snr_cstates,
 	.disable_promotion_to_c1e = true,
@@ -1538,6 +1542,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&idle_cpu_bxt),
 	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,	&idle_cpu_bxt),
 	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,	&idle_cpu_dnv),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT,       &idle_cpu_tmt),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,     &idle_cpu_tmt),
 	X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,	&idle_cpu_snr),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	&idle_cpu_grr),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	&idle_cpu_srf),
@@ -2075,7 +2081,7 @@ static void __init intel_idle_cpuidle_driver_init(struct cpuidle_driver *drv)
 
 	drv->state_count = 1;
 
-	if (icpu)
+	if (icpu && icpu->state_table)
 		intel_idle_init_cstates_icpu(drv);
 	else
 		intel_idle_init_cstates_acpi(drv);
@@ -2209,7 +2215,11 @@ static int __init intel_idle_init(void)
 
 	icpu = (const struct idle_cpu *)id->driver_data;
 	if (icpu) {
-		cpuidle_state_table = icpu->state_table;
+		if (icpu->state_table)
+			cpuidle_state_table = icpu->state_table;
+		else if (!intel_idle_acpi_cst_extract())
+			return -ENODEV;
+
 		auto_demotion_disable_flags = icpu->auto_demotion_disable_flags;
 		if (icpu->disable_promotion_to_c1e)
 			c1e_promotion = C1E_PROMOTION_DISABLE;
-- 
2.43.0


