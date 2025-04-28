Return-Path: <linux-pm+bounces-26331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4F8A9F9EA
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 21:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4701A865F9
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 19:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58D12951B5;
	Mon, 28 Apr 2025 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="MKzT0PgA"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481837083A;
	Mon, 28 Apr 2025 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869822; cv=none; b=TQU/8IXcI0uRdby+/RNOUsPDgaBIMqEWDQDtJ1AyKOlrYoYjMV0slZYaquS/D0GZ9NgqGdObZhyXv7GwSWECFqExfxJXWnuodkev9RULvShmyo/ElZbRxbFpUDk+NgpDcrvbotwTbADS3/IMM3unJqSdo/vG6Cxc9bUjQHAqVU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869822; c=relaxed/simple;
	bh=rH7/HZOg7f1c+2LCP+NbsDn3L5NWlRBCV/YsyucQqgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Um0mqmw31vOhI55PQkw8+yOYgZEpwyLvHcz9AbMwunk3IWTyhYFpa8BVcMADk+brycP4rr6RiOuUeKqmCGH0inhNPrYM5K23cQlgvXlibvhmX2wgvn5zbTHKAyr1qyEPImYiOKs3dFyWa5iFZJdGUkRbR6mA67xztd7azwdWAUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=MKzT0PgA; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 75F5566509C;
	Mon, 28 Apr 2025 21:50:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1745869808;
	bh=rH7/HZOg7f1c+2LCP+NbsDn3L5NWlRBCV/YsyucQqgI=;
	h=From:Subject:Date;
	b=MKzT0PgAJ4hSY2XBtf0JmfdNzpA2j45RxysfZm5APE3hZnytAkmhOHdcLUfeNemcK
	 F4Pspqp+cYmoNxklzy1VFoNdXpMLmH2yJw3YV0rGa+dqM4Jkw4+gFf9eF/uhPCPydP
	 2fPbNIlWaQRzfnyxKeQnxXZMl4OSZHrW2ixuIoYPGx1llq1C/tjFwJQ0nSVX+gGBFV
	 Lf/MR7BQvW42lyTh4IBWp8EcFd4BSao9HL1zHFllyT3Oc98uF/mS1nuSrfXlMcBFVK
	 aUCe/rOzGw5OvgtCc0cTVLwfrs9D9Yh4lFudwWHgdnYmQpB7drtpr87YYV1u+2LHdb
	 GuRX9PVGGtJeA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Vinod Koul <vkoul@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, linux-sound@vger.kernel.org
Subject:
 [PATCH v2] soundwire: intel_auxdevice: Fix system suspend/resume handling
Date: Mon, 28 Apr 2025 21:50:07 +0200
Message-ID: <12680420.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedukeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppedvudejrdduudegrdefgedrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedruddugedrfeegrdduledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpihgvrhhrvgdqlhhouhhishdrsghoshhsrghrtheslhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeihuhhnghdqtghhuhgrnhdrlhhirghosehlihhnuhigrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Before commit bca84a7b93fd ("PM: sleep: Use DPM_FLAG_SMART_SUSPEND
conditionally") the runtime PM status of the device in intel_resume()
had always been RPM_ACTIVE because setting DPM_FLAG_SMART_SUSPEND had
caused the core to call pm_runtime_set_active() for that device during
the "noirq" resume phase.  For this reason, the pm_runtime_suspended()
check in intel_resume() had never triggered and the code depending on
it had never run.  That had not caused any observable functional issues
to appear, so effectively the code in question had never been needed.

After commit bca84a7b93fd the core does not call pm_runtime_set_active()
for all devices with DPM_FLAG_SMART_SUSPEND set any more and the code
depending on the pm_runtime_suspended() check in intel_resume() runs if
the device is runtime-suspended prior to a system-wide suspend
transition.  Unfortunately, when it runs, it breaks things due to the
attempt to runtime-resume bus->dev which most likely is not ready for a
runtime resume at that point.

It also does other more-or-less questionable things.  Namely, it
calls pm_runtime_idle() for a device with a nonzero runtime PM usage
counter which has no effect (all devices have nonzero runtime PM
usage counters during system-wide suspend and resume).  It also calls
pm_runtime_mark_last_busy() for the device even though devices cannot
runtime-suspend during system-wide suspend and resume (because their
runtime PM usage counters are nonzero) and an analogous call is made
in the same function later.  Moreover, it sets the runtime PM status
of the device to RPM_ACTIVE before activating it.

For the reasons listed above, remove that code altogether.

On top of that, add a pm_runtime_disable() call to intel_suspend() to
prevent the device from being runtime-resumed at any point after
intel_suspend() has started to manipulate it because the changes
made by that function would be undone by a runtime-suspend of the
device.

Next, once runtime PM has been disabled, the runtime PM status of the
device cannot change, so pm_runtime_status_suspended() can be used
instead of pm_runtime_suspended() in intel_suspend().

Finally, make intel_resume() call pm_runtime_set_active() at the end to
set the runtime PM status of the device to "active" because it has just
been activated and re-enable runtime PM for it after that.

Additionally, drop the setting of DPM_FLAG_SMART_SUSPEND from the
driver because it has no effect on devices handled by it.

Fixes: bca84a7b93fd ("PM: sleep: Use DPM_FLAG_SMART_SUSPEND conditionally")
Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Tested-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: New changelog

Since it fixes a recent regression in 6.15-rc, I can route it through the
PM tree unless that would be a major concern.

---
 drivers/soundwire/intel_auxdevice.c |   36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -353,9 +353,6 @@
 	/* use generic bandwidth allocation algorithm */
 	sdw->cdns.bus.compute_params = sdw_compute_params;
 
-	/* avoid resuming from pm_runtime suspend if it's not required */
-	dev_pm_set_driver_flags(dev, DPM_FLAG_SMART_SUSPEND);
-
 	ret = sdw_bus_master_add(bus, dev, dev->fwnode);
 	if (ret) {
 		dev_err(dev, "sdw_bus_master_add fail: %d\n", ret);
@@ -640,7 +637,10 @@
 		return 0;
 	}
 
-	if (pm_runtime_suspended(dev)) {
+	/* Prevent runtime PM from racing with the code below. */
+	pm_runtime_disable(dev);
+
+	if (pm_runtime_status_suspended(dev)) {
 		dev_dbg(dev, "pm_runtime status: suspended\n");
 
 		clock_stop_quirks = sdw->link_res->clock_stop_quirks;
@@ -648,7 +648,7 @@
 		if ((clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) ||
 		    !clock_stop_quirks) {
 
-			if (pm_runtime_suspended(dev->parent)) {
+			if (pm_runtime_status_suspended(dev->parent)) {
 				/*
 				 * paranoia check: this should not happen with the .prepare
 				 * resume to full power
@@ -715,7 +715,6 @@
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
-	int link_flags;
 	int ret;
 
 	if (bus->prop.hw_disabled || !sdw->startup_done) {
@@ -724,23 +723,6 @@
 		return 0;
 	}
 
-	if (pm_runtime_suspended(dev)) {
-		dev_dbg(dev, "pm_runtime status was suspended, forcing active\n");
-
-		/* follow required sequence from runtime_pm.rst */
-		pm_runtime_disable(dev);
-		pm_runtime_set_active(dev);
-		pm_runtime_mark_last_busy(dev);
-		pm_runtime_enable(dev);
-
-		pm_runtime_resume(bus->dev);
-
-		link_flags = md_flags >> (bus->link_id * 8);
-
-		if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE))
-			pm_runtime_idle(dev);
-	}
-
 	ret = sdw_intel_link_power_up(sdw);
 	if (ret) {
 		dev_err(dev, "%s failed: %d\n", __func__, ret);
@@ -761,6 +743,14 @@
 	}
 
 	/*
+	 * Runtime PM has been disabled in intel_suspend(), so set the status
+	 * to active because the device has just been resumed and re-enable
+	 * runtime PM.
+	 */
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	/*
 	 * after system resume, the pm_runtime suspend() may kick in
 	 * during the enumeration, before any children device force the
 	 * master device to remain active.  Using pm_runtime_get()




