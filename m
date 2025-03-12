Return-Path: <linux-pm+bounces-23942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3573BA5E88A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 00:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96D5173562
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 23:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F941F193C;
	Wed, 12 Mar 2025 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XglsKt5+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7AA1EEA37;
	Wed, 12 Mar 2025 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823000; cv=none; b=Bcg+89waA7S4o3gOLWMq+xLxEwt9OMej8Q2JUCxpK6uxdMDBl+T/UFTgLZheApAztQvHCtfQGilSWwU48O+otayZWp0gRuxfObLP6CxTSVsiIVHMpBBvKIISmicY/vhI2Nme6+j6o+f0j8vGAjrRC6MpF4eXjgQ24cghNpnn2xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823000; c=relaxed/simple;
	bh=niLXdakiu8gCvVpStbTgaYdWV2Af8Uh1SqC+JxDjLXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e81xrvZbpCKq5eVlJpe4vTI6JDZhZeZccZqRk5oJSPOFX9lknJaHAun2E059Dq5ulOqjW/mNUHwPzuMVtT12CvcA1QwY62jYMgop2iP+R6dAU3XGbzGI9S0mlcFCM+dl7qCeAnYdfLHIKdFOGIfeZNUlAYYz3+AXf8ljSwNaux0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XglsKt5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFECBC4CEF0;
	Wed, 12 Mar 2025 23:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741823000;
	bh=niLXdakiu8gCvVpStbTgaYdWV2Af8Uh1SqC+JxDjLXo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XglsKt5+7rP8QMyCPDFe2SEqnQQOqoLcBGek9Pr707FyyDJNerdPdBv2Z03GrDySp
	 JLn0aMEg9xLCBZJF3xaSZWPQJlLyx/YG1y1ACiLGLvp68X0M2D6+wEn/K+3G7QLXbu
	 y64P9Wr8hizdJaLiDUKI0im9fvn39luEJGmHqMliWfnQSuMcRdrsdkTUqxNGB1N/Qt
	 k8FqQxlDJB5HRSg66PwfAqoMsi0hQ4h1xDm4E/DkRdXTxNhW/jFUttE3R83DysYE+4
	 Y+1Fz6rrKkZQXRnzQ3Yc77Dgr89l0w95FUJAczlCMtdU0ScpiYqjliXV54wEde/8OK
	 l7QzT6XuYEvsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE092C28B30;
	Wed, 12 Mar 2025 23:43:19 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Wed, 12 Mar 2025 16:42:02 -0700
Subject: [PATCH 2/5] power: supply: core: add function to get supplies from
 fwnode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-batt_ops-v1-2-88e0bb3129fd@google.com>
References: <20250312-batt_ops-v1-0-88e0bb3129fd@google.com>
In-Reply-To: <20250312-batt_ops-v1-0-88e0bb3129fd@google.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Sebastian Reichel <sre@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, 
 Pavel Machek <pavel@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741822998; l=3979;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=UN1YhzvNxvK3QvtdEdK0hrzY0vn7uaEFCUiBkNIHAs8=;
 b=vD3Kw+ItD4Ub6LxGFQKj8W+L2dzxAs/jw3tiolbJe66WFIJz1ITx3ICBYCUKUzGOp1cnQM0wA
 xAFZbNBc2R6D7+1VJpksNLvRTIjDkIk4A1W88LLk1cwXy0dNouaFMDO
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Add a new helper function power_supply_get_by_fwnode_reference_array()
to retrieve a list of power_supplies associated with the fwnode's
property. The property can contain multiple nodes where each node is
associated with a power_supply. The list of power_supply objects will be
stored in an array supplied by the caller and the return value will
indicate the size of the resulting array.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 drivers/power/supply/power_supply_core.c | 60 ++++++++++++++++++++++++++++++++
 include/linux/power_supply.h             |  5 +++
 2 files changed, 65 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 76c340b38015af0a67a0d91305e6242a8646bf53..df1a52f85125748c4fdcb10687aa7ed2f626ded1 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -593,6 +593,66 @@ struct power_supply *devm_power_supply_get_by_phandle(struct device *dev,
 EXPORT_SYMBOL_GPL(devm_power_supply_get_by_phandle);
 #endif /* CONFIG_OF */
 
+static int power_supply_match_fwnode(struct device *dev, const void *data)
+{
+	return dev && dev->parent && dev->parent->fwnode == data;
+}
+
+/**
+ * power_supply_get_by_fwnode_reference_array() - Returns an array of power
+ * supply objects associated with each fwnode reference present in the property
+ * @fwnode: Pointer to fwnode to lookup property
+ * @property: Name of property holding references
+ * @psy: Resulting array of power_supply pointers. To be provided by the caller.
+ * @size: size of power_supply pointer array.
+ *
+ * If power supply was found, it increases reference count for the
+ * internal power supply's device. The user should power_supply_put()
+ * after usage.
+ *
+ * Return: On success returns the number of power supply objects filled
+ * in the @psy array.
+ * -EOVERFLOW when size of @psy array is not suffice.
+ * -EINVAL when @psy is NULL or @size is 0.
+ * -ENODATA when fwnode does not contain the given property
+ */
+int power_supply_get_by_fwnode_reference_array(struct fwnode_handle *fwnode,
+					       const char *property,
+					       struct power_supply **psy,
+					       ssize_t size)
+{
+	int ret, index, count = 0;
+	struct fwnode_reference_args args;
+	struct device *dev;
+
+	if (!psy || !size)
+		return -EINVAL;
+
+	for (index = 0; index < size &&
+	     !(ret = fwnode_property_get_reference_args(fwnode, property, NULL,
+							0, index, &args));
+	     ++index) {
+		dev = class_find_device(&power_supply_class, NULL, args.fwnode,
+					power_supply_match_fwnode);
+		fwnode_handle_put(args.fwnode);
+		if (!dev)
+			continue;
+
+		if (count > size)
+			return -EOVERFLOW;
+
+		psy[count] = dev_get_drvdata(dev);
+		atomic_inc(&psy[count]->use_cnt);
+		++count;
+	}
+
+	if (ret != -ENOENT)
+		return ret;
+
+	return index ? count : -ENODATA;
+}
+EXPORT_SYMBOL_GPL(power_supply_get_by_fwnode_reference_array);
+
 int power_supply_get_battery_info(struct power_supply *psy,
 				  struct power_supply_battery_info **info_out)
 {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 6ed53b292162469d7b357734d5589bff18a201d0..3f062607e5cd7c7f04384e34128ae0953e25d981 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -820,6 +820,11 @@ devm_power_supply_get_by_phandle(struct device *dev, const char *property)
 { return NULL; }
 #endif /* CONFIG_OF */
 
+extern int
+power_supply_get_by_fwnode_reference_array(struct fwnode_handle *fwnode,
+					   const char *property,
+					   struct power_supply **psy,
+					   ssize_t size);
 extern const enum power_supply_property power_supply_battery_info_properties[];
 extern const size_t power_supply_battery_info_properties_size;
 extern int power_supply_get_battery_info(struct power_supply *psy,

-- 
2.49.0.rc0.332.g42c0ae87b1-goog



