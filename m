Return-Path: <linux-pm+bounces-39789-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C41ADCD7165
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6B9F301275C
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C6D30BF62;
	Mon, 22 Dec 2025 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBJawlNz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F0230AD00;
	Mon, 22 Dec 2025 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435822; cv=none; b=ZpOtFpnym3dL5aYfKQCABkWUNNgQPKf4GE3i4Y1Htd4LXhy7D2TuHcPZPzOATEIVjiZv/Rao5zecTId8ghOBqkHVKc5cjDIwb5Yz9cI0o7e0xWIbgcFIg8/y1SZ4LpHj+BZSypx8PztoSW/F0AW/ROGIlX6t2Alc/ws7fvX1a1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435822; c=relaxed/simple;
	bh=5lTSXfHCh0kt1mgn/MN7svtqP53TiA+t0/Nndt/lKy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnh9OK86gAo0r4yEizlFYHRPyA9obracXEy02NDxLo9eYN9X4F4J1AVMwhxS7xqBbxrHUGy32PiWMVgjirZq384LJQyClAXezWkycJlhfoFUvcXSOSifd1OzxA+uv/9a9pP9qQbu0fYB54T1VRj6bVNYAWOKtltTj4hFtqKc61U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBJawlNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADD2C4CEF1;
	Mon, 22 Dec 2025 20:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435822;
	bh=5lTSXfHCh0kt1mgn/MN7svtqP53TiA+t0/Nndt/lKy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nBJawlNz7fMV/zbvpoYPVU9lgAjirjWl+4D29j/ucKxJcPkk28SmHCbHGUDOHJhO0
	 dAXovi2sYZFwgA8oXbBk7TtHxX8v0yfTSRbCdCiAn78Id64reiRr8GaEYbtDZt+iix
	 11n03SexnWuz4Bo8IFYyfD/A4v25q186abVzUUWg4EhAhxjeSfci4YOwLYq/gtiDdm
	 ajPuXnRK0QKsPYqB2g+KCIF0axByJ5oIhqIFeAe4aanFKTdxNItfp/iMB4R2TqwDCx
	 LEwqcDIFJnaZW2PovwyuvYBQG9KWOG9uh1TjPC3Gws/o2GQl5Dhxct/TgUrQjO9+jl
	 xNQtJoY4SjacA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>
Subject:
 [PATCH v1 23/23] PM: runtime: Change pm_runtime_put() return type to void
Date: Mon, 22 Dec 2025 21:36:25 +0100
Message-ID: <14387202.RDIVbhacDa@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The primary role of pm_runtime_put() is to decrement the runtime PM
usage counter of the given device.  It always does that regardless of
the value returned by it later.

In addition, if the runtime PM usage counter after decrementation turns
out to be zero, a work item is queued up to check whether or not the
device can be suspended.  This is not guaranteed to succeed though and
even if it is successful, the device may still not be suspended going
forward.

There are multiple valid reasons why pm_runtime_put() may not decide to
queue up the work item mentioned above, including, but not limited to,
the case when user space has written "on" to the device's runtime PM
"control" file in sysfs.  In all of those cases, pm_runtime_put()
returns a negative error code (even though the device's runtime PM
usage counter has been successfully decremented by it) which is very
confusing.  In fact, its return value should only be used for debug
purposes and care should be taken when doing it even in that case.

Accordingly, to avoid the confusion mentioned above, change the return
type of pm_runtime_put() to void.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm_runtime.h |   16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -545,22 +545,10 @@ static inline int pm_runtime_resume_and_
  *
  * Decrement the runtime PM usage counter of @dev and if it turns out to be
  * equal to 0, queue up a work item for @dev like in pm_request_idle().
- *
- * Return:
- * * 1: Success. Usage counter dropped to zero, but device was already suspended.
- * * 0: Success.
- * * -EINVAL: Runtime PM error.
- * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
- *            change ongoing.
- * * -EBUSY: Runtime PM child_count non-zero.
- * * -EPERM: Device PM QoS resume latency 0.
- * * -EINPROGRESS: Suspend already in progress.
- * * -ENOSYS: CONFIG_PM not enabled.
  */
-static inline int pm_runtime_put(struct device *dev)
+static inline void pm_runtime_put(struct device *dev)
 {
-	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
+	__pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
 }
 
 /**




