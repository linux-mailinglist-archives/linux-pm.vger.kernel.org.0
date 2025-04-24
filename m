Return-Path: <linux-pm+bounces-26149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471B0A9B816
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 21:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 511A47AE8D3
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 19:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E498C291144;
	Thu, 24 Apr 2025 19:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="HgquKewE"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0D928FFF9;
	Thu, 24 Apr 2025 19:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522111; cv=none; b=VjUj27YgmXtxmWFXakMh7rc6aLvIFTudp0jKhLIwOrqrpQrZ1Kut9e/y3uHTqrcbxPwmZeArDlRWtabCSlwsvec9ChxtX2aSaj46ktYeC1TG1GZ+GygJAWDCeox0fy08/D17Ji7BEN1qKnZOb51wXLeaNB25JEKXaV38+8pBnHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522111; c=relaxed/simple;
	bh=MXJMEGcub0Pkn94YJ1dkVrOGtDdLCPZ4lhu6EYPc490=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pK/FLYJXCvN+Lh1sOuqVAPbFwpvMC+xa1P2BqxQ1PfUSDlCvOoCJ5UbKs4sjScwsBIAiH6AuVh3qajlpISu5QrMx8xs2dLklgz5AGiTH4Z8enIGP9l6V+TRIGvOSzBKQctpOcDNU+fcq8FEAuowvoomdUq2koQQ1DcSZCOaDN/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=HgquKewE; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8DD19662FA9;
	Thu, 24 Apr 2025 20:13:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1745518400;
	bh=MXJMEGcub0Pkn94YJ1dkVrOGtDdLCPZ4lhu6EYPc490=;
	h=From:Subject:Date;
	b=HgquKewEpz2cqXvMVizho+Z1Jy93A6Ly98fsgbzHdYg8CTPl23+GKOzIzbW/OwSti
	 D2wl76I+v/vl/N+B3oS0aItCtZhce+fB5NSvIx77o4GhJtAZ2eSnWEtHmHuHfLkV4o
	 Nw4I/0S07qWnrz2qQDk5NP0EnyqZc0NcRI0UXYY2jvZ7rif7xPozmZJoG/UOqdNkGH
	 DWcPRqYdBlh7CAoKkCrZWkBgpEvYAwRpkD+fCGDs8DThQX1/Azb59TG03k2wgtvZ2C
	 rL/uCZZKQdqEyC8/3ivFFkz5eDEmUCtrthHU+oJzQYLZtZKlI/1uIHCqfdWlRGum/e
	 o12j3UqHwsvgg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Sanyog Kale <sanyog.r.kale@intel.com>, linux-sound@vger.kernel.org
Subject:
 [PATCH v1] soundwire: intel_auxdevice: Fix system suspend/resume handling
Date: Thu, 24 Apr 2025 20:13:19 +0200
Message-ID: <5891540.DvuYhMxLoT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedtudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeihuhhnghdqtghhuhgrnhdrlhhirghosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepphhivghrrhgvqdhlohhuihhsrdgsohhsshgrrhhtseh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The code in intel_suspend() and intel_resume() needs to be properly
synchronized with runtime PM which is not the case currently, so fix
it.

First of all, prevent runtime PM from triggering after intel_suspend()
has started because the changes made by it to the device might be
undone by a runtime resume of the device.  For this purpose, add a
pm_runtime_disable() call to intel_suspend().

Next, once runtime PM has been disabled, the runtime PM status of the
device cannot change, so pm_runtime_status_suspended() can be used
instead of pm_runtime_suspended() in intel_suspend().

Moreover, checking the runtime PM status of the device in intel_resume()
is pointless because the device is going to be resumed anyway and the
code running in the case when the pm_runtime_suspended() check in
intel_resume() returns 'true' is harmful.  Namely, calling
pm_runtime_resume() right after pm_runtime_set_active() has no effect
and calling pm_runtime_idle() on the device at that point is invalid
because the device is technically still suspended (it has not been
resumed yet).  Remove that code altogether along with the check leading
to it.

Finally, call pm_runtime_set_active() at the end intel_resume() to set
the runtime PM status of the device to "active" because it has just been
resumed and re-enable runtime PM for it after that.

Additionally, drop the setting of DPM_FLAG_SMART_SUSPEND from the
driver because it has never been necessary and should not have been
done.

This addresses a functional regression after commit bca84a7b93fd ("PM:
sleep: Use DPM_FLAG_SMART_SUSPEND conditionally") that effectively
caused the fatal pm_runtime_suspended() check in intel_resume() to
trigger.

Fixes: bca84a7b93fd ("PM: sleep: Use DPM_FLAG_SMART_SUSPEND conditionally")
Cc: 6.2+ <stable@vger.kernel.org> # 6.2+
Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Tested-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This change fixes an issue predating commit bca84a7b93fd that simply
uncovered the problem and it needs to be backported to 6.2 and later
kernels.

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




