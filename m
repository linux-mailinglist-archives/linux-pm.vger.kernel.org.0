Return-Path: <linux-pm+bounces-39803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01294CD7213
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23A14303271D
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50199342507;
	Mon, 22 Dec 2025 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cs+8tfcx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1861A34217C;
	Mon, 22 Dec 2025 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435871; cv=none; b=jYSOiEyC/3GTWR0LP49lENVqJc3azwSu2cf88VCxDbxozAngmh50u0cedZIl+SYFW+YqJsu/iYECSmFd1SRwe4v8139V9t0azG/a4yBxWESNfVsJUsPTH9kJjdEPt6f2Iir1AGYRgGvTpQpVN9C8ky1yTTvIGd5DNjYlHAg//KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435871; c=relaxed/simple;
	bh=dIVwkRqszkrtobADCV4HvCOD1D2symsz0wPe25EtYZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzR/+X/xQ3r8z9djt1OulCMSyyyyudTK5o2k1lypzHf2tEPwj/wTDprcG9n8oaR8mTOkKPeNsVEQl8ncQPiyjDNY0bVki4Pqh8CQzEj1d5Y0Ez9+35DjxhRkB370paVaqJobFDOVQyT+cWHhuo3Du4WsH6QghqVG4Rw55fGKHZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cs+8tfcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C003C4CEF1;
	Mon, 22 Dec 2025 20:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435870;
	bh=dIVwkRqszkrtobADCV4HvCOD1D2symsz0wPe25EtYZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cs+8tfcxY3o1jw+pL957kVPnoEy7rGNDjtJY+bBM/EMbaa7WzOsO3bsEyESt+GoRc
	 MUHf/vncS8mJX79JRhHOmx8Rw9kRyINt+DNRwpnezAw9NPo0oOQqiXSzr7Mu/U8+Sd
	 038N1aABraXgdFA43N/LidV1HCULw/DQJjBak8Seg6ky2uSRbnauY7y8tTw8kO1+6f
	 l/zR3R0C+TuIXUMMm30gTQf7s4vCsRd7uDuj97h0qdi8syNYvVWc/LHuzWZljZsJh7
	 aSIu8VxXoV0XiisuRPabe3eCsMJ34yO1uvTSWMBfX6X0Ih9jduyt5bFPdw6tpWq2Gu
	 Ty7oBB71X6D1Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Subject:
 [PATCH v1 09/23] watchdog: rzv2h_wdt: Discard pm_runtime_put() return value
Date: Mon, 22 Dec 2025 21:09:22 +0100
Message-ID: <1867890.VLH7GnMWUR@rafael.j.wysocki>
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

Failing device probe due to pm_runtime_put() returning an error is not
particularly useful.

Returning an error code from pm_runtime_put() merely means that it has
not queued up a work item to check whether or not the device can be
suspended and there are many perfectly valid situations in which that
can happen, like after writing "on" to the devices' runtime PM "control"
attribute in sysfs for one example.  It also happens when the kernel is
configured with CONFIG_PM unset.

Accordingly, update rzt2h_wdt_wdtdcr_init() to simply discard the return
value of pm_runtime_put() and return success to the caller after
invoking that function.

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
 drivers/watchdog/rzv2h_wdt.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -268,9 +268,7 @@ static int rzt2h_wdt_wdtdcr_init(struct
 
 	rzt2h_wdt_wdtdcr_count_stop(priv);
 
-	ret = pm_runtime_put(&pdev->dev);
-	if (ret < 0)
-		return ret;
+	pm_runtime_put(&pdev->dev);
 
 	return 0;
 }




