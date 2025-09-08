Return-Path: <linux-pm+bounces-34135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 100C8B4874F
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 10:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A6F162EC7
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC89E1E492D;
	Mon,  8 Sep 2025 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lex4U7Hd"
X-Original-To: linux-pm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB21DF74F;
	Mon,  8 Sep 2025 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320517; cv=none; b=NZtOm3gxtujrjEiEhyzrUIa1E9P+0rNIiPf0gSjsikJ4ls7C9vMl9Hbg0JCi+wtzGTAMZEurXcMa8wLTRHxzZ00IUI6N+vJXzkZSasL8MEeg91m31p21+IZ0d4umvoXGc7xSNDZ2NsB764s9dqVM68jOYSp0URp+hYfCZl3bxa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320517; c=relaxed/simple;
	bh=xYSeXkJfiwVH3skhZqIrcMwVdOlYQJKB6ePleXJDBNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rQUwKw1cFHsoK58kAe91baiePGoQqxgdu/v3hG5FSzgkc/mqiuqvXEx+FE45wnFeKINruaulZpwNXMVnjmk6wUmhiyzO30jkViYRdNw4UpHq58/epfo2U7YImk4snAh1EKwSj94i3Fty0CB7GIttBFBnQlvvrnnoxbNgKp+BGgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=lex4U7Hd; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CC345316;
	Mon,  8 Sep 2025 10:34:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1757320441;
	bh=xYSeXkJfiwVH3skhZqIrcMwVdOlYQJKB6ePleXJDBNw=;
	h=From:Date:Subject:To:Cc:From;
	b=lex4U7HdKxgYJGf7HGJAciQYZSb1rgqh+G/keJHaGd2LLePyTIi+YZe+/6QoH5jeB
	 2FQ1fhBtmqoj5kBo/A7pZWh2Rh8Dk5lerlIeNXzvjqNHohxnDesb8PhW6GotYiK5Sk
	 XJNI0pq5hYKYUB1gD1+lbagJXcPXPizy7pqNMips=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 08 Sep 2025 11:34:54 +0300
Subject: [PATCH RFC v2] pmdomain: ti-sci: Set PD on/off state according to
 the HW state
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-tisci-pd-boot-state-v2-1-a1a4173cf859@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIAC6VvmgC/32NQQrCMBBFryKzdqRJilZXguAB3EoXaTK1s7BTM
 qEopXc39AAu3//89xdQSkwKl90CiWZWlrGA3e8gDH58EXIsDLaytamsxcwaGKeInUhGzT4TOhf
 6ylIf3amBspwS9fzZrE943G/QlnBgzZK+29NstuqvdDZosKnP/uia2jjTXTmSVxk78SkegryhX
 df1B4bdRZTCAAAA
X-Change-ID: 20241022-tisci-pd-boot-state-33cf02efd378
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, 
 vishalm@ti.com, sebin.francis@ti.com, d-gole@ti.com, 
 Devarsh Thakkar <devarsht@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4796;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=xYSeXkJfiwVH3skhZqIrcMwVdOlYQJKB6ePleXJDBNw=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBovpU879HW7BB7stY8DuvDl41ZiSLcKl3CxmePj
 QVMNF/M/F2JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaL6VPAAKCRD6PaqMvJYe
 9cKxD/0aVmp4OqwAf5mVBddGeEFrbrByqyhsYqXkRCg4vWDw6nr30JoiD7ODia6uF61inq24mVn
 IXoyJX45R67sUoOq128blS6uKZ6Oc86qAd/c0B4WYG6m5x1kcwvuKL+MEqn3fX04Ptb1rjd64Pa
 alLFiCX0JbqULXB9IjSna7NgyC/dkri1fOj8wnP3rlMKOIjPmQEP9X3M8Ib7IjB9Kxc900FVcND
 CtbXPbEfBCGmQBTx94O3jUN8R/Y/oTLPXdxRg4QMdyhaf3dglKi/Esu2sMHHto+V0RstmuVtHRw
 3bIMT4+41Ue+t6kyG/Yki77biUAmIhW3F05iF3Hf2y8GnLzh01oNhXqvYrYqEjFEQ+Ec129VrKV
 X/SQ4i1XiVCfU1yc7PzxDwggMOHr+lShIMs6lNHlM1/cXz0KSsuupCMENjavx56Efa8RmbD4arl
 /bHXiKnL8noLCIBIPYQRvr4Vo0crZmEbm5Z/adiP1mKS2TSEkGndmpevX+EYJdH0IB1wL+LkQ0J
 rXCcVohSHL4l3WF/qnMkDQthRMk4zcRzZti4Jg5QTmh5aswN/LO/HJJ5zG+a6C0qhaFITYARmJ+
 ZZDZ/D7sTaiJQ7+03lMFlN91LtifjZIiHLOY6oo/Z5iU2GmYhr2bbYxjjNArjKX39TvRTEddD3w
 wE4wJlAEUQtP0fg==
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

With recent change from Ulf (e.g. commit 13a4b7fb6260 ("pmdomain: core:
Leave powered-on genpds on until late_initcall_sync")), the sync state
mechanism comes to rescue. It will keep the power domains enabled, until
the drivers have probed, or the sync-state is triggered via some other
mechanism (e.g. manually by the boot scripts).

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v2:
- Clarify the current state wrt. sync state in the patch description
- Rebase to current upstream
- No other changes
- Link to v1: https://lore.kernel.org/r/20241022-tisci-pd-boot-state-v1-1-849a6384131b@ideasonboard.com
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 82df7e44250b..e5d1934f78d9 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -200,6 +200,23 @@ static bool ti_sci_pm_idx_exists(struct ti_sci_genpd_provider *pd_provider, u32
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
@@ -231,6 +248,8 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 						   index, &args)) {
 
 			if (args.args_count >= 1 && args.np == dev->of_node) {
+				bool is_on;
+
 				of_node_put(args.np);
 				if (args.args[0] > max_id) {
 					max_id = args.args[0];
@@ -264,7 +283,10 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				    pd_provider->ti_sci->ops.pm_ops.set_latency_constraint)
 					pd->pd.domain.ops.suspend = ti_sci_pd_suspend;
 
-				pm_genpd_init(&pd->pd, NULL, true);
+				is_on = ti_sci_pm_pd_is_on(pd_provider,
+							   pd->idx);
+
+				pm_genpd_init(&pd->pd, NULL, !is_on);
 
 				list_add(&pd->node, &pd_provider->pd_list);
 			} else {

---
base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
change-id: 20241022-tisci-pd-boot-state-33cf02efd378

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


