Return-Path: <linux-pm+bounces-33649-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C09BB405EF
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 16:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE8C700F15
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 13:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0863101A8;
	Tue,  2 Sep 2025 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="co5TkIbW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BB22DAFD2;
	Tue,  2 Sep 2025 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821348; cv=none; b=u2/VkYKdzR6/b3KMQti7x21MfTyjMaMs9rYYrwOxndxX+3dwee6FKS/h5PYCslkFY3MZCCuozGuFKvDsDOh5gw86MseIqOS23ZIfBtjDLrBJayaklOQX9S4jAyOJCOowRDm/M+kqfHu+JaL9drqh/AefNxJzEaxR15bLkCiNrk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821348; c=relaxed/simple;
	bh=ewUq9QY7K9BxYzN78kiifFTRXsrTXUp38VqkddzAldc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aBqbFMfMwn6C4Ufd5J4PQ1Y/oMMac60TxhpnaxaNu2MUmiRavxazS40n5A8/njUfBNKw7qVz1fPAKDZixw9umTFxzHw3XHkIE1fC3cJO1ikIaIWJmxgqWJ6vkaL4OOtikkAUGQzQMJPzN/Q3XYxsSKjvQQdRyikMC7gKQXUDhe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=co5TkIbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1596C4CEED;
	Tue,  2 Sep 2025 13:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756821348;
	bh=ewUq9QY7K9BxYzN78kiifFTRXsrTXUp38VqkddzAldc=;
	h=From:To:Cc:Subject:Date:From;
	b=co5TkIbW+pjZ9k+QMo3plHwjUSJolbix6KDF4skAbC4X/LaxGwomjMWW32gLpr/wJ
	 jSs7G+f85FtuPtmfFT8CfqYrEeLe2TBWaTEq9tRAybP2sRXEi/6VYj7CqJIkt3I35U
	 R/WdfwBKCQK3kWQJbKOYlR8zQ72VKbNqniKuWrejeCZRszHEAYUEPHIMc6ekf6FqhT
	 7fKNi0NxBaIsXajcN7QzO80zEfTJxSrhiX1icU8Qq9jVWS9EFR0j8Ev8jrVzdDCV8A
	 xTf92hphBLNA/k/3Lo6/d+la/z7juuKgMsFWCc7Ukte5t8guhCNSC0BAHDc5y4JoQb
	 MKTFth/VWqYng==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Subject:
 [PATCH v1] PM: sleep: core: Clear power.must_resume in noirq suspend error
 path
Date: Tue, 02 Sep 2025 15:55:45 +0200
Message-ID: <3381776.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If system suspend is aborted in the "noirq" phase (for instance, due to
an error returned by one of the device callbacks), power.is_noirq_suspended
will not be set for some devices and device_resume_noirq() will return
early for them.  Consequently, noirq resume callbacks will not run for
them at all because the noirq suspend callbacks have not run for them
yet.

If any of them has power.must_resume set and late suspend has been
skipped for it (due to power.smart_suspend), early resume should be
skipped for it either, or its state may become inconsistent (for
instance, if the early resume assumes that it will always follow
noirq resume).

Make that happen by clearing power.must_resume in device_resume_noirq()
for devices with power.is_noirq_suspended clear that have been left in
suspend by device_suspend_late(), which will subsequently cause
device_resume_early() to leave the device in suspend and avoid
changing its state.

Fixes: 0d4b54c6fee8 ("PM / core: Add LEAVE_SUSPENDED driver flag")
Link: https://lore.kernel.org/linux-pm/5d692b81-6f58-4e86-9cb0-ede69a09d799@rowland.harvard.edu/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -720,8 +720,20 @@
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Out;
 
-	if (!dev->power.is_noirq_suspended)
+	if (!dev->power.is_noirq_suspended) {
+		/*
+		 * This means that system suspend has been aborted in the noirq
+		 * phase before invoking the noirq suspend callback for the
+		 * device, so if device_suspend_late() has left it in suspend,
+		 * device_resume_early() should leave it in suspend either in
+		 * case the early resume of it depends on the noirq resume that
+		 * has not run.
+		 */
+		if (dev_pm_skip_suspend(dev))
+			dev->power.must_resume = false;
+
 		goto Out;
+	}
 
 	if (!dpm_wait_for_superior(dev, async))
 		goto Out;




