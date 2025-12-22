Return-Path: <linux-pm+bounces-39798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDE6CD71DD
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E906309B1A4
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F7033E35F;
	Mon, 22 Dec 2025 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDNjrtjS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD1330EF7E;
	Mon, 22 Dec 2025 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435852; cv=none; b=HX8gO1NSH+94ot3ODs2V0w5IFw4oLYSangSZyhrV/zIqoAYiWe6u6Ytr5Phcd+u/V4mMNK9kDuKxWLye+xwM1en9GqpDpCGtQM6b6R3huKxOmXlUA1QUCJnkLJJdu0WE2yoCLrEN6Tfp3B2uGe8zdOO9hHBOTIyMwmrTxhD9RsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435852; c=relaxed/simple;
	bh=XKskJ1WTC783Bb/i1qvF+S49G7qTzXEfIkrjc3VCGY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCdQXnZJFF7OOb62jeYpaSyFV6CAJs7g1mVGaxzvbZc+lhZX1IaTpvijjWmvhVMzlXtO6FCOZxjJRSSjC6eVqrR/7n1P17NmH/DhWlifa3dy2ijIT71YxZfLWx5LMMtVa3OULEIJrS+tf/7q+F5pZwr5uWF5uzNosYuN5D9CRu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDNjrtjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8990FC4CEF1;
	Mon, 22 Dec 2025 20:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435852;
	bh=XKskJ1WTC783Bb/i1qvF+S49G7qTzXEfIkrjc3VCGY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDNjrtjSl5HwmzTYqtefnbMM1MLC65/aOjPLzkJN1b7Foaa2a+vsEIVLAYUxyXMEZ
	 24f6LtwDPTbox3Elz+TA5HuetZY2Zbe2fiDwaVs4PnmHJ/VOaeng+BS+evRCvHEdiq
	 phi2uMM3MByq3MZGootCC5i/z96V5u9OhM8gxuApXU7ilmY5OfHPrAolPLMdkwbOZl
	 MHEbP5mwtWfK2f90NYd2+QNJR8YysQ64+IDCBD+ZqT1Ete6noeZgLbK14uH7Qjc1AZ
	 ZRUdwdATHvB19tni+3bi2gF7O4/4c2iyiNA1mgL2TJ3wfSfZGHAdkPx1eRc/jK1BTw
	 AZZj55ht/L+4Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject:
 [PATCH v1 14/23] phy: rockchip-samsung-dcphy: Discard pm_runtime_put() return
 value
Date: Mon, 22 Dec 2025 21:21:30 +0100
Message-ID: <2281919.Icojqenx9y@rafael.j.wysocki>
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

Passing pm_runtime_put() return value to the callers is not particularly
useful.

Returning an error code from pm_runtime_put() merely means that it has
not queued up a work item to check whether or not the device can be
suspended and there are many perfectly valid situations in which that
can happen, like after writing "on" to the devices' runtime PM "control"
attribute in sysfs for one example.  It also happens when the kernel is
configured with CONFIG_PM unset.

Accordingly, update samsung_mipi_dcphy_exit() to simply discard the
return value of pm_runtime_put() and always return success to the
caller.

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
 drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
@@ -1508,7 +1508,9 @@ static int samsung_mipi_dcphy_exit(struc
 {
 	struct samsung_mipi_dcphy *samsung = phy_get_drvdata(phy);
 
-	return pm_runtime_put(samsung->dev);
+	pm_runtime_put(samsung->dev);
+
+	return 0;
 }
 
 static const struct phy_ops samsung_mipi_dcphy_ops = {




