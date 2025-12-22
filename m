Return-Path: <linux-pm+bounces-39797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE029CD71D4
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 899C4308CDE2
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7379533E34E;
	Mon, 22 Dec 2025 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDK1d+Rm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F4A33EB01;
	Mon, 22 Dec 2025 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435849; cv=none; b=jqo3dK2CQoOub8SVNUctJM5qXnZ31YWSft7o7lNPCxBL2X6ZvwTkbqgG0i8KWwLfFvte4+b2Txa2zDaes8wnAb1mIrNhtftRiqNX5xsI/IBFlw4E5S9Y5rpjoSj4pfGin9pRcnz8XJo1i7048aGSl8CKr8P/TBJLOsNEN2CHTZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435849; c=relaxed/simple;
	bh=BalUs0JaXGi9OEmgkh/o3sCoR/ci4kiU4w+LxMxmaAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=seGEOw5ZVvnDKXxl6JMx+j88yZrjVZpcQecc6RHDF5DMkhI/QyL78n9CfFjV29Z6ZiwYoX7F3Ddllq3Q0UYfDqmBjgf9m76DVqGBlVqfl791mZURabfkNUtjBiIoelWC61U3hrDJBsKBFfedmfJjbdJQJ5R7yCVTYDkzB4v+xR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDK1d+Rm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0D2C4CEF1;
	Mon, 22 Dec 2025 20:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435848;
	bh=BalUs0JaXGi9OEmgkh/o3sCoR/ci4kiU4w+LxMxmaAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tDK1d+RmL8Ni+b6WPepahaEUjZSB/6ml5cMNbGjTiBbyH8ObLOC5d045kwGj/7fUC
	 70kB8IGIJ1+9R5e6v4U/A9JUdHi7Ohf77QfqjFrUmHCwtGpo1drxX6yKt8YzczHhUV
	 kG6bxFPosM9kY/d/3XwWKK8XnDFqep7wIMxiroHAz90hJJpYJGO4ykb0H1XTvnEZOj
	 jyC81TBJhOyhnSVbNjir/8dhy0ABmzU8gm5mGcqW+6bxwO6b7VS0MqiDBWJZBL56N7
	 dRrgKXOdod1uMxBGZ5iji/wk7JrpIZ3r/IbpFnfTgYK3vgtYVqlBi7/rwSNhvQ9QZs
	 Zv84rZAqDQtow==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, linux-phy@lists.infradead.org
Subject: [PATCH v1 15/23] phy: core: Discard pm_runtime_put() return values
Date: Mon, 22 Dec 2025 21:22:48 +0100
Message-ID: <2556645.jE0xQCEvom@rafael.j.wysocki>
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

The PHY core defines phy_pm_runtime_put() to return an int, but that
return value is never used.  It also passes the return value of
pm_runtime_put() to the caller which is not very useful.

Returning an error code from pm_runtime_put() merely means that it has
not queued up a work item to check whether or not the device can be
suspended and there are many perfectly valid situations in which that
can happen, like after writing "on" to the devices' runtime PM "control"
attribute in sysfs for one example.

Modify phy_pm_runtime_put() to discard the pm_runtime_put() return
value and change its return type to void.  Also drop the redundant
pm_runtime_enabled() call from there.

No intentional functional impact.

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
 drivers/phy/phy-core.c  |    9 +++------
 include/linux/phy/phy.h |    7 ++-----
 2 files changed, 5 insertions(+), 11 deletions(-)

--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -190,15 +190,12 @@ int phy_pm_runtime_get_sync(struct phy *
 }
 EXPORT_SYMBOL_GPL(phy_pm_runtime_get_sync);
 
-int phy_pm_runtime_put(struct phy *phy)
+void phy_pm_runtime_put(struct phy *phy)
 {
 	if (!phy)
-		return 0;
+		return;
 
-	if (!pm_runtime_enabled(&phy->dev))
-		return -ENOTSUPP;
-
-	return pm_runtime_put(&phy->dev);
+	pm_runtime_put(&phy->dev);
 }
 EXPORT_SYMBOL_GPL(phy_pm_runtime_put);
 
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -232,7 +232,7 @@ static inline void *phy_get_drvdata(stru
 #if IS_ENABLED(CONFIG_GENERIC_PHY)
 int phy_pm_runtime_get(struct phy *phy);
 int phy_pm_runtime_get_sync(struct phy *phy);
-int phy_pm_runtime_put(struct phy *phy);
+void phy_pm_runtime_put(struct phy *phy);
 int phy_pm_runtime_put_sync(struct phy *phy);
 int phy_init(struct phy *phy);
 int phy_exit(struct phy *phy);
@@ -312,11 +312,8 @@ static inline int phy_pm_runtime_get_syn
 	return -ENOSYS;
 }
 
-static inline int phy_pm_runtime_put(struct phy *phy)
+static inline void phy_pm_runtime_put(struct phy *phy)
 {
-	if (!phy)
-		return 0;
-	return -ENOSYS;
 }
 
 static inline int phy_pm_runtime_put_sync(struct phy *phy)




