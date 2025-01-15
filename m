Return-Path: <linux-pm+bounces-20497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37088A1280D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 17:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EE7188BE1A
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ABC16DECB;
	Wed, 15 Jan 2025 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="PI74K4vy"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE6114F12D;
	Wed, 15 Jan 2025 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956979; cv=none; b=rlsNxW0QAkoCzUgJsu5iA7rPFTd/ZSFtRXDbj3Y1vwQ3ycbkX5ubs2xnxCZdqX/f1HwgKJjd+RhItcnHFGGbkhSvTbIYhO8CW/euPH0XI2lNuHiF2qfgtP0IrbaT0jT1c7dcEeZRAHzvVxK2mhi4yVMK0KL3LaQlwaJw0EeA9g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956979; c=relaxed/simple;
	bh=lkic8j+SMxOU3XLWEexi01K46tUhYr1mvLUvm+kAN8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5jh8sbpSPLLuQ+D4YmIdxoStJegvSTD3do+/m3fD1jGzs9BTUvsGhwhnPaSLuuE2VeQJfPH8r7mHFuwHFWIMqO2JH/OUESgHlTyNvPcXUuaQxf8QWhc4zVeSHqPKYKLdNwT1fMy/kn9BhsOXgmSv+Jzy6bydljgl0KMeti/yds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=PI74K4vy; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 36F09A087A;
	Wed, 15 Jan 2025 17:02:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=OdOKTTKoBkRw2qI2a3fK
	Jbn7RnYioij+mv7jrByPp7M=; b=PI74K4vytHlWnFtcfaRP8LDT89PaLFOQ0t/2
	4UFTSVvh/PyO7Ouly96fH3bMQCK8e1CPH7UZo0/AdDCO064mrMLEdhc8XMWY+ePk
	185NySwiZLF698xVRw11sSmP86TjFA2xT/jZPKQ603AG8Nt0uQhU1t9rtYSTPszb
	qceslXwkT6Nsk4hRy5ZsQfKc0z9LgK4ZUIbcuMD/B7DUTyxJihZEu7LsBrVuUCY0
	S4dsw4sZ3KyULIBtOr96dQrn5xkbAyw//nuk6s7UBlzn2GSUDdTTAi8mvVe5V2jr
	CVP1Qb7ThBrz2mxUZDTRPOHaxRkW4T2wRegTCFZvdp0GY/tC6Goshypw+gyw0+EZ
	eZte40TaomgpMRygs6HmHGtAUj+PIywCl2g0XXIoPbmdVplgREV9m6uL84XQ6dqN
	rvCtf78SCT+ue6EkFnsbO9+nnAEUvxExuhadQTf26lpEiqmrGpj+ZgJLlMTFB7gs
	XTjpRTJPYabU/uZLZJY+6gbgf6cusv0sWlCE21PYcTRosxooA5Msf7rAUbfVJQA4
	xlb4biIcBbvS8mFz7fX85KqEnr4V7yTYcq9Fi8+kXw6bMufLf+Ijxe2INMPHugGw
	v4vWigHu4DG1wCInp52Kx1BcQAOdUyj3PRORJMtQR+wbjMik167IVqyc64To6lzG
	M+EUI9w=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/4] pm: runtime: Add new devm functions
Date: Wed, 15 Jan 2025 17:02:39 +0100
Message-ID: <20250115160244.1102881-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115160244.1102881-1-csokas.bence@prolan.hu>
References: <20250115160244.1102881-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1736956967;VERSION=7983;MC=3933488075;ID=287148;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94852647067

Add `devm_pm_runtime_set_active()` and
`devm_pm_runtime_get_noresume()` for
simplifying common use cases in drivers.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/base/power/runtime.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/pm_runtime.h   |  4 ++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 2ee45841486b..f0a6c64bec19 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1545,6 +1545,24 @@ void pm_runtime_enable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
+static void pm_runtime_set_suspended_action(void *data)
+{
+	pm_runtime_set_suspended(data);
+}
+
+/**
+ * devm_pm_runtime_set_active - devres-enabled version of pm_runtime_set_active.
+ *
+ * @dev: Device to handle.
+ */
+int devm_pm_runtime_set_active(struct device *dev)
+{
+	pm_runtime_set_active(dev);
+
+	return devm_add_action_or_reset(dev, pm_runtime_set_suspended_action, dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_runtime_set_active);
+
 static void pm_runtime_disable_action(void *data)
 {
 	pm_runtime_dont_use_autosuspend(data);
@@ -1567,6 +1585,24 @@ int devm_pm_runtime_enable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(devm_pm_runtime_enable);
 
+static void pm_runtime_put_noidle_action(void *data)
+{
+	pm_runtime_put_noidle(data);
+}
+
+/**
+ * devm_pm_runtime_get_noresume - devres-enabled version of pm_runtime_get_noresume.
+ *
+ * @dev: Device to handle.
+ */
+int devm_pm_runtime_get_noresume(struct device *dev)
+{
+	pm_runtime_get_noresume(dev);
+
+	return devm_add_action_or_reset(dev, pm_runtime_put_noidle_action, dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_runtime_get_noresume);
+
 /**
  * pm_runtime_forbid - Block runtime PM of a device.
  * @dev: Device to handle.
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index d39dc863f612..d7eca86150b8 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -93,7 +93,9 @@ extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device_link *link);
 extern void pm_runtime_release_supplier(struct device_link *link);
 
+int devm_pm_runtime_set_active(struct device *dev);
 extern int devm_pm_runtime_enable(struct device *dev);
+int devm_pm_runtime_get_noresume(struct device *dev);
 
 /**
  * pm_suspend_ignore_children - Set runtime PM behavior regarding children.
@@ -276,7 +278,9 @@ static inline void __pm_runtime_disable(struct device *dev, bool c) {}
 static inline void pm_runtime_allow(struct device *dev) {}
 static inline void pm_runtime_forbid(struct device *dev) {}
 
+static inline int devm_pm_runtime_set_active(struct device *dev) { return 0; }
 static inline int devm_pm_runtime_enable(struct device *dev) { return 0; }
+static inline int devm_pm_runtime_get_noresume(struct device *dev) { return 0; }
 
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable) {}
 static inline void pm_runtime_get_noresume(struct device *dev) {}
-- 
2.48.0



