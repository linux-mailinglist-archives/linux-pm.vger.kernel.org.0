Return-Path: <linux-pm+bounces-39810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B15CD71AA
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3AF7301E99C
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1399346E42;
	Mon, 22 Dec 2025 20:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTwr/dB/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C6B346AE4;
	Mon, 22 Dec 2025 20:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435897; cv=none; b=pznJucdxdM8c7rW1ItD+WOdYGH1EzzsEweL9RVwV6TSmQUQsc7+2c+IBQRjcLBrkSaUqcuePrfniPiLxzMziuHxaNo6nOBCKO+xopRek3V5bJ93UmLoblDtnvq9xTnKqVFhsH4jGlzSh6Hgjz8ofS1H+kbpHQ6BlR0Xqlr86jc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435897; c=relaxed/simple;
	bh=Gz8Io9XC6+UjwbiiJL2DyXYIAqa83xHO+FqGoRbQK8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BtOE49UXNhYharuL6sf4qo/9TczFMT+bJ7sGF6+/EESmIEjfcv1IsOB/U21jWdhoAVinBBfVMXpdi4TWwEVR0OqRrhYGoRahE0fH3tG2NWJRod3VFMGO5oBOfiwCfh9sIF0x89OAxcrln0YI7zqre4ekXidDhUY7zV4zf9ry+t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTwr/dB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A35C116D0;
	Mon, 22 Dec 2025 20:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435897;
	bh=Gz8Io9XC6+UjwbiiJL2DyXYIAqa83xHO+FqGoRbQK8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NTwr/dB/li3oA3kyNXRH3p+iMqOOhSPE+Vdg/h1yxc0CovR8dULsJKI7oquyaek5b
	 N/Jb1qP5THwOHO+OwsR6SmMH5NVeH7MOnR+od/axg34u7WpSos7tbCqzLWxpLeJnvf
	 B5b43bDi+eYuiXldgnzLnhqAU9klDCPh/xLb5GQsrBaEQZFqwoFnkCFF7PmSiYMHbA
	 U5yXsfxx5c+aH3P5kXRIW7HQ5Fcd1rmavcs2uVt42HHV4uYARnZ2B0wWWQAHCGHzwK
	 zsVE5Qu/LwHvccJ3Ar4tgT0wsnhwqFG5eKKq8GThX5f2M+Yem8ZpO0HqhiI5x8C0n8
	 uTWY9mP0vUUug==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v1 02/23] USB: core: Discard pm_runtime_put() return value
Date: Mon, 22 Dec 2025 20:52:33 +0100
Message-ID: <5058509.GXAFRqVoOG@rafael.j.wysocki>
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

To allow the return type of pm_runtime_put() to be changed to void in the
future, modify usb_autopm_put_interface_async() to discard the return
value of pm_runtime_put().

That value is merely used in a debug comment printed by the function in
question and it is not a particularly useful piece of information
because pm_runtime_put() does not guarantee that the device will be
suspended even if it successfully queues up a work item to check
whether or not the device can be suspended.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch is part of a series, but it doesn't depend on anything else
in that series.  The last patch in the series depends on it.

It can be applied by itself and if you decide to do so, please let me
know.

Otherwise, an ACK or equivalent will be appreciated, but also the lack
of specific criticism will be eventually regarded as consent.

---
 drivers/usb/core/driver.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1810,13 +1810,11 @@ EXPORT_SYMBOL_GPL(usb_autopm_put_interfa
 void usb_autopm_put_interface_async(struct usb_interface *intf)
 {
 	struct usb_device	*udev = interface_to_usbdev(intf);
-	int			status;
 
 	usb_mark_last_busy(udev);
-	status = pm_runtime_put(&intf->dev);
-	dev_vdbg(&intf->dev, "%s: cnt %d -> %d\n",
-			__func__, atomic_read(&intf->dev.power.usage_count),
-			status);
+	pm_runtime_put(&intf->dev);
+	dev_vdbg(&intf->dev, "%s: cnt %d\n",
+			__func__, atomic_read(&intf->dev.power.usage_count));
 }
 EXPORT_SYMBOL_GPL(usb_autopm_put_interface_async);
 




