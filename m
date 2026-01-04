Return-Path: <linux-pm+bounces-40167-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B53E3CF0DA7
	for <lists+linux-pm@lfdr.de>; Sun, 04 Jan 2026 12:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B636C30056C6
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jan 2026 11:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C303A2877E8;
	Sun,  4 Jan 2026 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCr1Msa1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA304A3E;
	Sun,  4 Jan 2026 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767527623; cv=none; b=P74ku0zIbwA8DxDsWnu5uKJzx8yDtDiOYubEd60tTpTiQWcZVer4RfidDR6gwVSVN24TI+6ZxCiyT6+KHqJyFpPapvhpSeyxHUBrJMoJ3aXO3W4mb76gFVxISpE5xmEzdfPh+lz1f21UIQiU2vSWF8KvBm1iAjr1kPtRVYzYkAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767527623; c=relaxed/simple;
	bh=AIprCMecqfWvn68c5BFxnum4U31MRe9S40v01yZYSHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gJ8xBzN2FnmRHRBgKmZxJFsNTCxWN1v8895RAqK+e206bxPUW1/4sauFpPEO4S/m1c0rhSO5oO/ziRmFjoc+TqSjM4HHek2WG5h5n8cryBQ9uFkkvKmHXk79PdsxIgxJhwAfsiun+ajyL+AxY2oU3W66ApQKKYV7KdpBsI+jy+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCr1Msa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC281C4CEF7;
	Sun,  4 Jan 2026 11:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767527623;
	bh=AIprCMecqfWvn68c5BFxnum4U31MRe9S40v01yZYSHA=;
	h=From:To:Cc:Subject:Date:From;
	b=JCr1Msa18TAtDoNH856kGTE3S0BaMMbRGJaiFeOIvSrDvHB78FOIy4354A7DwkG0H
	 y4WZfdUdWqHW5uXCmWdW/Z31i57wRagcwMh9YEZaQtpBJbi0RueNn8yISX03VUq6I0
	 uB8cQ/vmNeVtZfK94UTOD16RU7C3ahVliokQoPwidLmVoZRZoQMfnPNe3G6KEAbkfY
	 xQpMsgodFfhH77DhRoPgOOnzdsECFg179R2+Ov4GKGHEFbsyu+DsqVL28TbCBh1zXg
	 YNuUeywEsLZWYj82UYonlCVjlXeknHbmgVvYjUFwzaeDJ32HWugmti1LNc9WUlVVlr
	 /ryxdv7c7ML8w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: linux-tegra@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-clk@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Dmitry Osipenko <digetx@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1] clk: tegra: Adjust callbacks in tegra_clock_pm
Date: Sun, 04 Jan 2026 12:53:36 +0100
Message-ID: <5088794.31r3eYUQgx@rafael.j.wysocki>
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

System suspend and resume callbacks run after the core has bumped
up the runtime PM usage counters of all devices, so these callbacks
need not worry about runtime PM reference counting.

Accordingly, to eliminate useless overhead related to runtime PM
usage counter manipulation, set the suspend callback pointer in
tegra_clock_pm to pm_runtime_resume() and do not set the resume
callback in it at all.

This will also facilitate a planned change of the pm_runtime_put()
return type to void in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch is requisite for converting pm_runtime_put() into a void
function.

If you decide to pick it up, please let me know.

Otherwise, an ACK or equivalent will be appreciated, but also the lack
of specific criticism will be eventually regarded as consent.

---
 drivers/clk/tegra/clk-device.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/tegra/clk-device.c
+++ b/drivers/clk/tegra/clk-device.c
@@ -175,7 +175,7 @@ unreg_clk:
  * perspective since voltage is kept at a nominal level during suspend anyways.
  */
 static const struct dev_pm_ops tegra_clock_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_resume_and_get, pm_runtime_put)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_resume, NULL)
 };
 
 static const struct of_device_id tegra_clock_match[] = {




