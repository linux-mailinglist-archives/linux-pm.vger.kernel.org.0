Return-Path: <linux-pm+bounces-20449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E96A11411
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 23:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556D03A4CBB
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 22:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A60220E6E7;
	Tue, 14 Jan 2025 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="FRleWv8I"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C033213253;
	Tue, 14 Jan 2025 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736893779; cv=none; b=kpmOAcqZCPfWkAGxNmZ45A4irIQkbX+VlrWqc9D7eC1m9F78T9XNRaOy3Eqh1B5lid40CosFOsERXK5QVvEzh9XCS2ZZe+r+QUAvsnl1Qmqjg1N5o80UlukdM3QMJ5LmY0ibkht9ZhREDaot8P3W97TE2g6VbyYR0vdNiYkuhDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736893779; c=relaxed/simple;
	bh=okXrC0Q2F7t7R4sjHRZAyUMjawXUgUxTEyQQ209nKnk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DrvMr8x1wBhSO6UKZJ5etJgVgoyw27xV701qIu9L6lrRKHWB+bcugCILbuJa4AEV2LGASnf0IeScgsj0+2GNhhFzJrdsj6sltzkhHM4GF73TPq+AZ1XuxMq44tkRcPCe4qxhBZSzOdDBMX/UPdXV6n1r/qzXP0vV8mK7ayadr58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=FRleWv8I; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E0770A0A58;
	Tue, 14 Jan 2025 23:29:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=AboIwWn+X7QHZlmT8GZISKWGgjj8isdTcqMO2RDs+10=; b=
	FRleWv8IED4UaR9Ga03mEVScNWfVgu8BOSMVbtcNIgpWGSB5HHhQgOWYW8xK+VaS
	YXQJcQoX+pQWqfgXr21NRuyXCY031Hhhhatxl0IZ21GpoKYCWbVl2s1bA4mvKXhp
	ow3jweyRMCpW/GEqFbp1nSbP8hR24NGnDUrE6WHV5cl7/q0QwA2pMADXtrz64yMn
	lEfCo24TRxw63rHX0HW7HbnWNqycY3TObhZ/k2jXCWVegQbaXYkgXp4O2wcQArZ5
	jIXJearPP842h0Kmt7Yw33eVcd1kSLMYcpLjP1+ppPfh24jxxXRVU4hzLt4Vh+X0
	VgajeocM6C0xj/C9SlTShL0sJpzDcTVEZSQ0QAycJiDsTMPF/OO4/rGIQOAzvZGh
	ymaJSbx4uUoA0NUrVYPw4w8Y+qFiaZt6TYF0X7kfIg/hRcCihHyimduffgAJcLaQ
	QIhdnCMb3HlbjT0eJa6q6H2r+YV5mMVBusjKIA1uZUJItz3BLSkXtDqeVCL6kHfv
	3WKisZbTF4sY2ZNUh6MPBvGQ5a8Xh6ZaldnO0y5gNCrVD9fn8pu9BpyqEKVvXn6D
	/Tq8WsiXOQ1IkJZT4sZeJEp8mLTIxucIaVFqcYXqxyyhTgUv5+fxxg6ibqT/hja6
	hyGr76UnGMCfwc+S5ksmeuzMrBbumhuC8TsMKcQFnCQ=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] pm: runtime: Add new devm functions
Date: Tue, 14 Jan 2025 23:28:49 +0100
Message-ID: <20250114222851.1023194-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1736893771;VERSION=7983;MC=1846261166;ID=279910;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94852647165

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
index d39dc863f612..3a0e03534621 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -93,7 +93,9 @@ extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device_link *link);
 extern void pm_runtime_release_supplier(struct device_link *link);
 
+extern int devm_pm_runtime_set_active(struct device *dev);
 extern int devm_pm_runtime_enable(struct device *dev);
+extern int devm_pm_runtime_get_noresume(struct device *dev);
 
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



