Return-Path: <linux-pm+bounces-39793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 22076CD715F
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AABEA3001028
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ECA332905;
	Mon, 22 Dec 2025 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kouMa512"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1964B30AD00;
	Mon, 22 Dec 2025 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435836; cv=none; b=OvJIWgZTJh2fQa7rtfOYbarLeHC/rCEFW8P9q6Sm7YY7etv2O9BHFcM2ZFpNB5MKPVfMR9/da2EMExGOo4YCU9mv3lyy8ukUkURKs8dpZwgo8zByjBZcnPam7pTj5q+vG1DhINjpJQjooARCNeYurbCqFd9wLiouYgLi9ewzp/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435836; c=relaxed/simple;
	bh=avFh/5KlmZ4H2n0ov6fHQrLzx9Hy3EwavKTT+11CZD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WR3jHgUS5rLpZVwsxNMF9wmJomjm6ffVFkVRPoYRKs1nRz98KxVgNak0+sHsIGtXNCd1IeArV2SQRzkWIQnd0zZ80S/KCgktW+u+g5QYzKsxBptOH53SkWDAjnuIWXoRI3fTO7t+xL0U6yu8T4+z61x4SlRaZ57vAz7YtBdFnuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kouMa512; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D6AC4CEF1;
	Mon, 22 Dec 2025 20:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435835;
	bh=avFh/5KlmZ4H2n0ov6fHQrLzx9Hy3EwavKTT+11CZD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kouMa512U+X1QEd/IVdMhpqcLqsF3TSHlQfGnO04PKLkR9e22OHyMNG+ZFGa+31s5
	 cznAMCFqb/38WOVX62S0w+d9o7EkTNclBBvf+fMH1iFaouWkYRqoZF2RNQahK7xpeI
	 b3N37JeluyUOuvvkArvkY8K5i7htqIdWGTraSmRc1PjoATr6UOPKYrC9Zx7YAaPGSc
	 LM7tNjDCM+Er7rMHSbtWetLqlQmMCCimAUX0iAfXjAAzfKN7s9q4usQB8PF6Ct1cvc
	 qHr4DgmlSIHrEEZ0MlEGrQlOQvpbHdPP3lOGYrOtnDyjicaitt9pLhRykw++osF21s
	 MHnRXLrTuR95A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 imx@lists.linux.dev
Subject:
 [PATCH v1 19/23] pmdomain: imx: gpcv2: Discard pm_runtime_put() return value
Date: Mon, 22 Dec 2025 21:29:41 +0100
Message-ID: <15658107.tv2OnDr8pf@rafael.j.wysocki>
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
attribute in sysfs for one example.

Accordingly, update imx_pgc_domain_suspend() to simply discard the
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
 drivers/pmdomain/imx/gpcv2.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -1420,7 +1420,9 @@ static int imx_pgc_domain_suspend(struct
 
 static int imx_pgc_domain_resume(struct device *dev)
 {
-	return pm_runtime_put(dev);
+	pm_runtime_put(dev);
+
+	return 0;
 }
 #endif
 




