Return-Path: <linux-pm+bounces-16187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C1C9A9A17
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 08:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E152860B0
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 06:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ED1811EB;
	Tue, 22 Oct 2024 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Z1l6JpDW"
X-Original-To: linux-pm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A748450EE;
	Tue, 22 Oct 2024 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579317; cv=none; b=k1R16Diio5fpu7pw+ygJmjsuD5hzzVoFsXu7cLgYBoM/c7RID62wkE1OruBsiW38n7HJ28fFByYvANP/IMK2QadetALnUQp7BEQNNcXV/kf6Pmc5D9AWhv39OYHOopCTgCV9fB1mRZLc39m8Oefqel04A2u9OQoncS3xlMjn3Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579317; c=relaxed/simple;
	bh=Q/m6JeHkE9NHRmu3I+Eg8Y5KqSdt7FPgW1BJMS1oWLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DrGrnTVT62L7FzTbRW5CD4iG/IqdVUCMWvRJCmuSK+6daVF9DvOGCgLCAw3YYtDkRmZP1sD/xYS9YN/snGwQGzpLkeFIc8sNnWWtV9gMUlgEHwKDWXQljqtGs7p678yQWV0GbmjfLVjb+2h2Ha9JUEUk+nRameA8Jx5Y59ZIbzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Z1l6JpDW; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-157-155-49.elisa-laajakaista.fi [91.157.155.49])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 215CF49E;
	Tue, 22 Oct 2024 08:40:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729579207;
	bh=Q/m6JeHkE9NHRmu3I+Eg8Y5KqSdt7FPgW1BJMS1oWLA=;
	h=From:Date:Subject:To:Cc:From;
	b=Z1l6JpDWrpUera0OMR4LUP2gafNWWrk2fX320xOmkU8YUA6Gl7QTaMhCIoZ0C2FPo
	 YJnlkPMYfrul+89mg4RO4m/WhLYdRAxWMRHbnAzwBlu7ud1IBoePMy+w7JHin+/ys4
	 dqS9DqHk/Hk+ZyqEJ3YL/qcyklrUFs4/NOFTbOWE=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 22 Oct 2024 09:41:30 +0300
Subject: [PATCH RFC] pmdomain: ti-sci: Set PD on/off state according to the
 HW state
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-tisci-pd-boot-state-v1-1-849a6384131b@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIABlJF2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAyMj3ZLM4uRM3YIU3aT8/BLd4pLEklRdY+PkNAOj1LQUY3MLJaDOgqL
 UtMwKsKnRSkFuzkqxtbUAEg/EnGoAAAA=
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, 
 vishalm@ti.com, sebin.francis@ti.com, d-gole@ti.com, 
 Devarsh Thakkar <devarsht@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4375;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=Q/m6JeHkE9NHRmu3I+Eg8Y5KqSdt7FPgW1BJMS1oWLA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnF0kt6AEWHMs+jTfYRAakF2U0Uqrtn+VgopsFa
 /z4rHlhUPSJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZxdJLQAKCRD6PaqMvJYe
 9YIiD/4uByZFHf/N4T/D0FM++g4zR+G38U4XJSs9Qmc0duIglDf/zb1tTeAhXGAzXv9YTAcX1BO
 kmPU3cx68Bq5mBjuCoq7tEwGbYHx+Dzf08V3M9lGfIzVGkFLtNNe827Za3lLmdN3w8udmgK4SUH
 ubV6G9IcfyXetf0DQBXNRCoCOZPMaaThW4nyNIprkkOAg2BckN7rKd54hDtKvZjPt38z/P8VKKg
 Skj8+OKlyu8hhbfbKXonO96YUuu34hD8+P+qHlkmeXtv2fw4j1jPEwteXCSAdYk6SIP4Uzd+uVt
 1CO+uxFEfevMH/6I3XINKl3WKmG8V6AQFibtb6TJkGM/JYxrPMYvjeGktzTUi5r6Pdv5uhDT9ls
 cwltLmKdmnNIbnNvhpsIcqGsCqsUYrmdLMLpirmYMxTu1Ne0WRUiXj2JUIVpOcYslVzDBxzKOo5
 473KtWB+UKENRCDKjJI2XBEB0aDLdInx8naNaene4PmuDoIORX47sTVxEwYDdedWCBKiQHILPot
 uYFwuGHW3cHmA8SWI8rZ/6Z7Y6Pk6inr6qzusR+FHRnn7inISndSKsf5YC6e7/D2ZBWytQoeJyI
 QQeRahv6E2suGlg7nloqs8WYDMFQJke9nire/rCOKqHsllmaDtzZhZXgRHds0VcTudey4rVeMTb
 eLJotADLNFX5M9A==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

At the moment the driver sets the power state of all the PDs it creates
to off, regardless of the actual HW state. This has two drawbacks:

1) The kernel cannot disable unused PDs automatically for power saving,
   as it thinks they are off already

2) A more specific case (but perhaps applicable to other scenarios
   also): bootloader enabled splash-screen cannot be kept on the screen.

The issue in 2) is that the driver framework automatically enables the
device's PD before calling probe() and disables it after the probe().
This means that when the display subsystem (DSS) driver probes, but e.g.
fails due to deferred probing, the DSS PD gets turned off and the driver
cannot do anything to affect that.

Solving the 2) requires more changes to actually keep the PD on during
the boot, but a prerequisite for it is to have the correct power state
for the PD.

The downside with this patch is that it takes time to call the 'is_on'
op, and we need to call it for each PD. In my tests with AM62 SK, using
defconfig, I see an increase from ~3.5ms to ~7ms. However, the added
feature is valuable, so in my opinion it's worth it.

The performance could probably be improved with a new firmware API which
returns the power states of all the PDs.

There's also a related HW issue at play here: if the DSS IP is enabled
and active, and its PD is turned off without first disabling the DSS
display outputs, the DSS IP will hang and causes the kernel to halt if
and when the DSS driver accesses the DSS registers the next time.

With the current upstream kernel, with this patch applied, this means
that if the bootloader enables the display, and the DSS driver is
compiled as a module, the kernel will at some point disable unused PDs,
including the DSS PD. When the DSS module is later loaded, it will hang
the kernel.

The same issue is already there, even without this patch, as the DSS
driver may hit deferred probing, which causes the PD to be turned off,
and leading to kernel halt when the DSS driver is probed again. This
issue has been made quite rare with some arrangements in the DSS
driver's probe, but it's still there.

So, because of the DSS hang issues, I think this patch is still an RFC.
Hopefully we can sort out all the issues, but this patch (or similar)
will be part of the solution so I'd like to get some acks/nacks/comments
for this. Also, this change might have side effects to other devices
too, if the drivers expect the PD to be on, so testing is needed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 1510d5ddae3d..14c51a395d7e 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -126,6 +126,23 @@ static bool ti_sci_pm_idx_exists(struct ti_sci_genpd_provider *pd_provider, u32
 	return false;
 }
 
+static bool ti_sci_pm_pd_is_on(struct ti_sci_genpd_provider *pd_provider,
+			       int pd_idx)
+{
+	bool is_on;
+	int ret;
+
+	if (!pd_provider->ti_sci->ops.dev_ops.is_on)
+		return false;
+
+	ret = pd_provider->ti_sci->ops.dev_ops.is_on(pd_provider->ti_sci,
+						     pd_idx, NULL, &is_on);
+	if (ret)
+		return false;
+
+	return is_on;
+}
+
 static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -161,6 +178,8 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				break;
 
 			if (args.args_count >= 1 && args.np == dev->of_node) {
+				bool is_on;
+
 				if (args.args[0] > max_id) {
 					max_id = args.args[0];
 				} else {
@@ -189,7 +208,10 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				pd->idx = args.args[0];
 				pd->parent = pd_provider;
 
-				pm_genpd_init(&pd->pd, NULL, true);
+				is_on = ti_sci_pm_pd_is_on(pd_provider,
+							   pd->idx);
+
+				pm_genpd_init(&pd->pd, NULL, !is_on);
 
 				list_add(&pd->node, &pd_provider->pd_list);
 			}

---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20241022-tisci-pd-boot-state-33cf02efd378

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


