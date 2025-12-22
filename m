Return-Path: <linux-pm+bounces-39804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA65CD7219
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABB8D3034ED4
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53624342CB5;
	Mon, 22 Dec 2025 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjmJ8oqO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF36342C99;
	Mon, 22 Dec 2025 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435874; cv=none; b=hhlGksftGh9mAWiWbSmSH2oQmllyWRsqBuQXY2F4oX/x7NI3WULOwTb4/amaDHHGIYH4MMONJi38LFiNrSIYnGbRgOjQ4KiFNzwKhg7imPVWLiYsjnvVFrXwaCsvN/eWUXSVMRRg/vBlZ+YZ8b83irJ/T2h5mtN9b+O7vBgGP78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435874; c=relaxed/simple;
	bh=A7SNz9q7yp2vEKW0eobgIZMa2zwuCdXrNIqrsJKAul8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPiaK19JbCzv9+nrKYck8N7aLuSTCmxVDpTE1O4yT3os1mTKuS7RUo6XuZgjOE7gGTLNr/u+2c1dt+tP2AvkP2yWyvGUXTHsyr8y0jeUZ9hO6AdqnpzH804hZVvVXWXO+2mAR0TCj3E6FKWYO9zW+qevNZaK+0790+FoA1c93GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjmJ8oqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC25C4CEF1;
	Mon, 22 Dec 2025 20:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435873;
	bh=A7SNz9q7yp2vEKW0eobgIZMa2zwuCdXrNIqrsJKAul8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WjmJ8oqO9B+G7gioc2RZwDtYgW2O/k1Hz/jbwdCYb3c7EydJ4bfAof08lJIyJpVkX
	 2qBRNce9s0Igq7+O2ublz+VaA5cvn1fmGw47rKTStrLk1TLNYxqnNSx09CEiob153p
	 63z2yjjPCMgBB3HOz5xa2utBFCOgBuuJnPe7Sr/QxMCif6Fkis6ZVMdGUdjZnc0NvO
	 9FVtXM/jI27GN+8lL/zBb1tjqodIm0NhraEnjm4USJoqHaid0urDDE+Oz/eI2F1QBL
	 uXKNnYKxi8/KXTmtoPxwbhd02Uv5zwWguhO8fhyJz2zqLrJKB2FxH3AV84hnXp+a3e
	 /Ma7lnF8GY12g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Subject: [PATCH v1 08/23] watchdog: rz: Discard pm_runtime_put() return values
Date: Mon, 22 Dec 2025 21:07:46 +0100
Message-ID: <3340071.5fSG56mABF@rafael.j.wysocki>
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

Failing a watchdog stop due to pm_runtime_put() returning a negative
value is not particularly useful.

Returning an error code from pm_runtime_put() merely means that it has
not queued up a work item to check whether or not the device can be
suspended and there are many perfectly valid situations in which that
can happen, like after writing "on" to the devices' runtime PM "control"
attribute in sysfs for one example.  It also happens when the kernel is
configured with CONFIG_PM unset.

Accordingly, update rzg2l_wdt_stop() and rzv2h_wdt_stop() to simply
discard the return value of pm_runtime_put().

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
 drivers/watchdog/rzg2l_wdt.c |    4 +---
 drivers/watchdog/rzv2h_wdt.c |    4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -132,9 +132,7 @@ static int rzg2l_wdt_stop(struct watchdo
 	if (ret)
 		return ret;
 
-	ret = pm_runtime_put(wdev->parent);
-	if (ret < 0)
-		return ret;
+	pm_runtime_put(wdev->parent);
 
 	return 0;
 }
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -174,9 +174,7 @@ static int rzv2h_wdt_stop(struct watchdo
 	if (priv->of_data->wdtdcr)
 		rzt2h_wdt_wdtdcr_count_stop(priv);
 
-	ret = pm_runtime_put(wdev->parent);
-	if (ret < 0)
-		return ret;
+	pm_runtime_put(wdev->parent);
 
 	return 0;
 }




