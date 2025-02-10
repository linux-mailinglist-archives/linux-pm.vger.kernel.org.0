Return-Path: <linux-pm+bounces-21672-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F71BA2EAB6
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 12:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A3227A755C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 11:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7924D1DCB24;
	Mon, 10 Feb 2025 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="GAFqrH1e"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B197B189B80;
	Mon, 10 Feb 2025 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185819; cv=none; b=W1DoJJDpe+Ys3FD/17B3rKi6QocXggKW8OH42MFPNQoXUpjqrLfSmdT4jquPUdJW9cI4QJ1SwUuDTFUZaIXGwMHa1MPxNqKupmrSZnEvHSpzXTfrsEwYaCcdEekZAWsQMM2kEaJXaJD5zo8pwdMH0PU9FF5J3Ulujo6L9PLELAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185819; c=relaxed/simple;
	bh=hMjK0JKCLQkifVL6xcp5SP3Txd+JKmmgLvrhO1+qQ0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmfyA5lAZUdptISsv5FBRZHVNkFuLBMDi2hX3TwAKJ0aLzGz2yOgC6sSKF6TWNGaopS3qAbmh8/Y9M4ACSrjcgQo2cCOh8JzsmgY4UjzkfD9R3o5HeofulprA8yokH6oKT3W/PMvNXXUEXoZqSRAVRv1mzMIe1qqkV2TOOcjkZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=GAFqrH1e; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id C1890A02BF;
	Mon, 10 Feb 2025 12:10:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ZlOzh0yVdNtO9Xo4eTT0
	ptUq5hK7+DDJWK0WMdAATE0=; b=GAFqrH1evk66NxRf3/YewN2xSc53tCOm5eWC
	lFuB9kpi3PmgVNu4aTUSDh5rPuikor09B48MesKU93jJ1Uviynnz516MAmwrFVgG
	G4q4Xta1orK1z0UmN30wEpLglURVCxPX4slE1NjmmQ0U/OKXr+Y0ZYwlWsomW4MU
	liJ0wUNNBiGE3+kFjTsZu8PS7XUvRva+bHR0rQGDtkKg8GLy/386ucLkNDRERQdY
	lRlDWVbg2GEMIY+H4BUC9ehoqj7OlD3NEkhqm8oF/fQBI+BpMDdIzQNOP9vSJkzp
	TuRTPQ7l1mPdfokTLwnlERsBRmrD1J6Gjy/zkDeOB8yuNZPwGQQVWYP7Std0fyBv
	WxIGjqmd/8j4YQN6gfN3bZiYN7m39MmmYFqLHvA5NzGPjgG/tRARvA21upwza1Pd
	r5Rd7rSsGJYdUmIjNfYO2J8lu2L6PmQVfTbXGggaDW8XN5h2tYYavAP5uHPZuQ+a
	+UFwUjaWSMCs/zUhMunXto21cxPF9zRigVkexRdIRx2kFio9fai4ZWYuzKdO2IKe
	TY5meJlg6HmrudrCGrsvFr8AL6qRoLigseiMRbxbhVN1FOqeDWRXMpNICz90Zsec
	o9BU4H5LlphUga1qCkeriLB7wnXeyAMycyr8S60threi4AWoVyejAujXOslJQR+/
	HM9jrj4=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Danilo
 Krummrich" <dakr@kernel.org>
Subject: [PATCH for-6.14 v4 1/2] pm: runtime: Add new devm functions
Date: Mon, 10 Feb 2025 12:10:06 +0100
Message-ID: <20250210111008.248929-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210111008.248929-1-csokas.bence@prolan.hu>
References: <20250210111008.248929-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1739185813;VERSION=7985;MC=360642531;ID=637652;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485261776A

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
2.48.1



