Return-Path: <linux-pm+bounces-26853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4CCAAF066
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 03:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0220546809E
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 01:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1488175D53;
	Thu,  8 May 2025 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPNK+4bW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A00A175A5;
	Thu,  8 May 2025 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746666155; cv=none; b=jP70LKPJ+wAHJAWtJGxfpuZn23Ki6fdJH4uwpfbTp3KUNuEvyiYDrdlY+z18MfuWdQEQSgStd3jxrFNCFc3FbdCbiizZE6+n2cSqqfdt6VsrK7K5SjHCZeO9d6cRozy3Wm5vtuk9Ukz7AkEYbe41WKBv4WofQ+52rT/jXaugr9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746666155; c=relaxed/simple;
	bh=d4slsEd4cKmuSOAFsQWaXdJfASlTswsfHKp1hoC2dgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zr+VkmeTH4gPqsZ1Ws5GDDprU5Uva2V96H3UnwH85bb5jrdtIPvEG9IqematyiqQuZ07Tn4hlLfdzvpXsxQdpiyxNM9wA85xHSfWpFNKv9jbljz17gHFgWmjVPitznRtwLC2bV2xXnymxju8bZ6n8IHtbLfrv6tVX3TyzqlwSO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPNK+4bW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 320B5C4CEE7;
	Thu,  8 May 2025 01:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746666155;
	bh=d4slsEd4cKmuSOAFsQWaXdJfASlTswsfHKp1hoC2dgw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YPNK+4bWrL9bYqY5Uumx76t66XueUiJ9dU0C0G0Vb1j3AfZJwxSMexbfZOMWxtmnJ
	 jTOHchmCaYxOJaFeyy+/Hrbja7xPLJWmNBrXYcWzAmQpIaWyx8N4FODv4fF7KmvtQs
	 lxJp1WNtwjSQQmQYhl8c1PuojfndEJWEByKp8rZJs9KguHgZz3YBU0+pMPf6ub8C6V
	 yFXh+7rLS5cErfnG+RDFLpEmUx5Ub5luLuJXUTTR9j62ZZxPuv93BeYukEVEUSKuap
	 fNmxoQpDzhzi3ddbenV+T6twUmA6PXHYX/WvfAnbw8zY7waqXsvZibK+w1fma41wM8
	 27dpY4idyKufQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26647C3ABCA;
	Thu,  8 May 2025 01:02:35 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Wed, 07 May 2025 18:00:23 -0700
Subject: [PATCH v2 2/5] power: supply: core: add helper to get power supply
 given a fwnode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-batt_ops-v2-2-8d06130bffe6@google.com>
References: <20250507-batt_ops-v2-0-8d06130bffe6@google.com>
In-Reply-To: <20250507-batt_ops-v2-0-8d06130bffe6@google.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Sebastian Reichel <sre@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, 
 Pavel Machek <pavel@kernel.org>
Cc: Kyle Tso <kyletso@google.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-pm@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746666154; l=2859;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=n/LuhXwbMG+uq2FAx4zj5314rxmEnmyuEdKNHG3ZivU=;
 b=dTaz7OkB3YkPjDneIrBZe+0QEC+/53CmHhzD87wh4fYYWZ7UQ5H7LlQRrclRrlPHTp6tsTyXR
 iV8Z2mcwUyhCP0cZivtxXycLG8L081x/tLWCnn4Bz17G/s19koXnENJ
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Add a helper function power_supply_get_by_fwnode() to retrieve
power_supply given a valid fwnode reference.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 drivers/power/supply/power_supply_core.c | 30 ++++++++++++++++++++++++++++++
 include/linux/power_supply.h             |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 76c340b38015af0a67a0d91305e6242a8646bf53..ef6ba22b837b0b9463f9a3065425e2720f40b9eb 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -496,6 +496,36 @@ struct power_supply *power_supply_get_by_name(const char *name)
 }
 EXPORT_SYMBOL_GPL(power_supply_get_by_name);
 
+static int power_supply_match_device_by_fwnode(struct device *dev, const void *data)
+{
+	return dev->parent && dev_fwnode(dev->parent) == data;
+}
+
+/**
+ * power_supply_get_by_fwnode() - Search for power supply given a fwnode ref.
+ * @fwnode: fwnode reference
+ *
+ * If power supply was found, it increases reference count for the internal
+ * power supply's device. The user should power_supply_put() after use.
+ *
+ * Return: Reference to power_supply node matching the fwnode on success or
+ * NULL on failure.
+ */
+struct power_supply *power_supply_get_by_fwnode(struct fwnode_handle *fwnode)
+{
+	struct power_supply *psy = NULL;
+	struct device *dev = class_find_device(&power_supply_class, NULL, fwnode,
+					       power_supply_match_device_by_fwnode);
+
+	if (dev) {
+		psy = dev_get_drvdata(dev);
+		atomic_inc(&psy->use_cnt);
+	}
+
+	return psy;
+}
+EXPORT_SYMBOL_GPL(power_supply_get_by_fwnode);
+
 /**
  * power_supply_put() - Drop reference obtained with power_supply_get_by_name
  * @psy: Reference to put
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 6ed53b292162469d7b357734d5589bff18a201d0..a35b08bd368e9305554e1a608dc8e526983cfa12 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -801,10 +801,13 @@ extern void power_supply_unreg_notifier(struct notifier_block *nb);
 #if IS_ENABLED(CONFIG_POWER_SUPPLY)
 extern struct power_supply *power_supply_get_by_name(const char *name);
 extern void power_supply_put(struct power_supply *psy);
+extern struct power_supply *power_supply_get_by_fwnode(struct fwnode_handle *fwnode);
 #else
 static inline void power_supply_put(struct power_supply *psy) {}
 static inline struct power_supply *power_supply_get_by_name(const char *name)
 { return NULL; }
+static inline struct power_supply *power_supply_get_by_fwnode(struct fwnode_handle *fwnode)
+{ return NULL; }
 #endif
 #ifdef CONFIG_OF
 extern struct power_supply *power_supply_get_by_phandle(struct device_node *np,

-- 
2.49.0.987.g0cc8ee98dc-goog



