Return-Path: <linux-pm+bounces-39796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9C7CD7168
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C1E53000E9C
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438B833F377;
	Mon, 22 Dec 2025 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRzPKLRw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99E433EAED;
	Mon, 22 Dec 2025 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435846; cv=none; b=ms/YTdd8O6ms8NzUoKB/8R37nVeA5x66u3jsFRY9c5JIVqgQbwoldlyfEMB+eHRQFnYrZpVBVyPCnXsmbRoEfFDhN+eBLLDFeZZ8q104CSBrPYplJtLQEdmWiRVsTrul7wMJLTEDhUBToWcmc/lryDgNjuQU0R2jkcXspKhVmb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435846; c=relaxed/simple;
	bh=iQdJgtg4Gwz2lSRxzGktBO54K2bHu23khuPVHbtHoE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVRaBB1FSDZthifzWm6aNlTc+S0e/OETSxDjFk9Qw96KI3fvzM3CzDU6k4o/HB1VSh6lahYjmGKnCVAAIuJCnGsL9EBozFAttLcufT8bbwlExINDAsySwMwz+maqsdOrY0k7RqUKCgDUgt/Hy87jjHGvrQffPnDApnsQinjt6a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRzPKLRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FE7C4CEF1;
	Mon, 22 Dec 2025 20:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435845;
	bh=iQdJgtg4Gwz2lSRxzGktBO54K2bHu23khuPVHbtHoE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRzPKLRwZsHpPdjTj0L7tRZjY1CqaU/kx1M/OOlCAroI8idF1vLh2rNCgVsSStlgZ
	 5fT8Nii1s/B4V8Ekru8xKwlEpYpJJ2QB/OqRgpTTbbmnKn5yly7reGniWzNGssmCzV
	 Pvi2EzGBajdPcSKjmAZqiA3c+pv4eG6d3a7WqDvcHYgGnxAYhKAk7CDHlDlpsQkcST
	 zFmMpnDXbFJajEOdoBQ0RsCfgS2KY6vEUKjLXzgDp82Y7uvsyUcLmjI1synyDkbYtz
	 bO3o6RULEKddCTQc8vsv8QLwnOtNYP1Y9aT8WlqDPk9rNqGUVY3uTujzAu935hXREL
	 IWhRM8HKzcdiQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-omap@vger.kernel.org,
 linux-remoteproc@vger.kernel.org
Subject:
 [PATCH v1 16/23] hwspinlock: omap: Discard pm_runtime_put() return value
Date: Mon, 22 Dec 2025 21:24:19 +0100
Message-ID: <883243465.0ifERbkFSE@rafael.j.wysocki>
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

Failing driver probe due to pm_runtime_put() returning a negative value
is not particularly useful.

Returning an error code from pm_runtime_put() merely means that it has
not queued up a work item to check whether or not the device can be
suspended and there are many perfectly valid situations in which that
can happen, like after writing "on" to the devices' runtime PM "control"
attribute in sysfs for one example.  It also happens when the kernel
has been configured with CONFIG_PM unset.

Accordingly, update omap_hwspinlock_probe() to simply discard the
return value of pm_runtime_put().

This will facilitate a planned change of the pm_runtime_put() return
type to void in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch is part of a series, but it doesn't depend on anything else
in that series.  The last patch in the series depends on it.

It can be applied by itself and if you decide to do so, please let me
know.

Otherwise, an ACK or equivalent will be appreciated, but also the lack
of specific criticism will be eventually regarded as consent.

---
 drivers/hwspinlock/omap_hwspinlock.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -101,9 +101,7 @@ static int omap_hwspinlock_probe(struct
 	 * runtime PM will make sure the clock of this module is
 	 * enabled again iff at least one lock is requested
 	 */
-	ret = pm_runtime_put(&pdev->dev);
-	if (ret < 0)
-		return ret;
+	pm_runtime_put(&pdev->dev);
 
 	/* one of the four lsb's must be set, and nothing else */
 	if (hweight_long(i & 0xf) != 1 || i > 8)




