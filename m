Return-Path: <linux-pm+bounces-36676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A484BBFE2A4
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 22:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37EC84F130E
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 20:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726CE2FB98F;
	Wed, 22 Oct 2025 20:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+s9AQBx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E502FB093;
	Wed, 22 Oct 2025 20:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164788; cv=none; b=KDEBRVGIIi6dKmp5OS1LLHN9EEmLaLhvqGyQJY0IgSjt7OCvwQQbzMFKgmWGLpQU3ioi6qZ+4X0nxYLwfgxCWXmr8H+YjyuAEA4UKd0aydD1ugUGmgQeeX0L2ojfreoM+6ui8I4l4M+WsFr5zDtsqmJPWkzQHYu6dEILStFaW3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164788; c=relaxed/simple;
	bh=M9V/qzjNV9mN1Mi9s/2rRl5V21fBrOMRkfAUifmSqPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=my1WbWpI38WbjYsunpa2mVWAK5tdCrSpvLdaHolWJrB4kEQOWPk/cePXmLMLelUjXnIa34VKvFpfo3NDbcGFAfgN8SUMu7LCihyShBA2wJWxGvkkyRgt3CSzuVfcmoptNUpNxYQrJqImoaLS850kn1fEWQC3nZrxnrZaB4LqQww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+s9AQBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEFEC4CEE7;
	Wed, 22 Oct 2025 20:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761164787;
	bh=M9V/qzjNV9mN1Mi9s/2rRl5V21fBrOMRkfAUifmSqPI=;
	h=From:To:Cc:Subject:Date:From;
	b=F+s9AQBxzV2KwnX6xgDMInxiEVpTRHPCBxkFvpuAr2gIaANglFqaIsbdtFNeDj01/
	 JC+NJe9ubrX3D/qJDCXco6fijLbzLa/0d9mTZq3co7lHJ+4OnW0Wyv9c+8RkWd87u3
	 NNlNZnPLt7EadJHXp4DALAKi28GcxPUIDAlnO+aGJQic/1XRfX6eCx/gUpN80GFvcq
	 LgkZsqfu0VE7FEcbHPcmZvpxfeo7RAJoMk3RhhtbSK9RCNPXTCIFxdUqAZZ6DxfBnt
	 cw2xDCK9KiaELlVWcYAYgTFiVy9X1qpXqh+CxXy2eGE4tbeLAWC/nEdajwWP6cbAZ4
	 Dl31dOGjX/T/A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>, Lukas Wunner <lukas@wunner.de>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject:
 [PATCH v1] PM: runtime: docs: Update pm_runtime_allow/forbid() documentation
Date: Wed, 22 Oct 2025 22:26:23 +0200
Message-ID: <12780841.O9o76ZdvQC@rafael.j.wysocki>
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

Drop confusing descriptions of pm_runtime_allow() and pm_runtime_forbid()
from Documentation/power/runtime_pm.rst and update the kerneldoc comments
of these functions to better explain their purpose.

Link: https://lore.kernel.org/linux-pm/08976178-298f-79d9-1d63-cff5a4e56cc3@linux.intel.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/power/runtime_pm.rst |   10 ----------
 drivers/base/power/runtime.c       |   17 +++++++++++++----
 2 files changed, 13 insertions(+), 14 deletions(-)

--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -480,16 +480,6 @@ drivers/base/power/runtime.c and include
   `bool pm_runtime_status_suspended(struct device *dev);`
     - return true if the device's runtime PM status is 'suspended'
 
-  `void pm_runtime_allow(struct device *dev);`
-    - set the power.runtime_auto flag for the device and decrease its usage
-      counter (used by the /sys/devices/.../power/control interface to
-      effectively allow the device to be power managed at run time)
-
-  `void pm_runtime_forbid(struct device *dev);`
-    - unset the power.runtime_auto flag for the device and increase its usage
-      counter (used by the /sys/devices/.../power/control interface to
-      effectively prevent the device from being power managed at run time)
-
   `void pm_runtime_no_callbacks(struct device *dev);`
     - set the power.no_callbacks flag for the device and remove the runtime
       PM attributes from /sys/devices/.../power (or prevent them from being
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1664,9 +1664,12 @@ EXPORT_SYMBOL_GPL(devm_pm_runtime_get_no
  * pm_runtime_forbid - Block runtime PM of a device.
  * @dev: Device to handle.
  *
- * Increase the device's usage count and clear its power.runtime_auto flag,
- * so that it cannot be suspended at run time until pm_runtime_allow() is called
- * for it.
+ * Resume @dev if already suspended and block runtime suspend of @dev in such
+ * a way that it can be unblocked via the /sys/devices/.../power/control
+ * interface, or otherwise by calling pm_runtime_allow().
+ *
+ * Calling this function many times in a row has the same effect as calling it
+ * once.
  */
 void pm_runtime_forbid(struct device *dev)
 {
@@ -1687,7 +1690,13 @@ EXPORT_SYMBOL_GPL(pm_runtime_forbid);
  * pm_runtime_allow - Unblock runtime PM of a device.
  * @dev: Device to handle.
  *
- * Decrease the device's usage count and set its power.runtime_auto flag.
+ * Unblock runtime suspend of @dev after it has been blocked by
+ * pm_runtime_forbid() (for instance, if it has been blocked via the
+ * /sys/devices/.../power/control interface), check if @dev can be
+ * suspended and suspend it in that case.
+ *
+ * Calling this function many times in a row has the same effect as calling it
+ * once.
  */
 void pm_runtime_allow(struct device *dev)
 {




