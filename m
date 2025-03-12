Return-Path: <linux-pm+bounces-23944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C982A5E890
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 00:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C9116F5FB
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 23:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7581F30C0;
	Wed, 12 Mar 2025 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZISzBeAp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995B71F2365;
	Wed, 12 Mar 2025 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823000; cv=none; b=EA9YzRkJgYDZIUhzmio9j3ktAoNgE4/zmfMYPEHpahW3iwCNw/CnvSjOa2P+CSpC88gQ6I9CfGLIvpKV7tqzlZTl5R67GAwpPrZ88mH9hr/JdbllK0Rjhivs6550IK3rJgJUXRrI051Y/AiRUKGPc54nrwzjqE3Jj/OzNX+t1vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823000; c=relaxed/simple;
	bh=E5v/XCkriRHVV5hY1jR8ct4n8NfSUcEh1/6xiIrOVY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MxMiWJ0jSRYu2U2894Im5uEhxdWejN/oN/yMQPsUiGLs2BE6Ti7mCvHY4GH4b95kSJ324wMcKt8ip67WUR8YZplOW08ISMd9SMs/ZwKa8GFP/L6hUVyORKW14msjkR1nJO7gJwAkEw+SyFqVupZVdmBtpXA1t+RJhnW1ZDZOBFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZISzBeAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 235E4C4CEF8;
	Wed, 12 Mar 2025 23:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741823000;
	bh=E5v/XCkriRHVV5hY1jR8ct4n8NfSUcEh1/6xiIrOVY0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZISzBeAph3MXu8Miec7U3VJpgB85OJRzzeQbASn58IX7W+Y+2CeRR76GZ0P62rCxN
	 oae9KAZfyfCYgJfXXGvCj4S2yK6XSdXk1fyuLv2zNLWeCahIwjT6ybTLOkAXuFJB/+
	 CqhpIMqxlloIlmCt2V1zJrm8WBSrQvQnGKYeN3QOXby5Fn48/0OUlHBDOgMfncxC6I
	 A+27G8CctrIqQsh0PxXnUod66CNdxuJYTRRAstbHqzQHygOCnAid4W0qurCqX72Iq7
	 39LJzHi7MeV1IeZy+iDgg7dAqosPgmxK1wwL1qyRVL+X8JuAoh6HZ4ERGfjebiX7C1
	 ZMhfjz8wqB9qA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A4AC35FF1;
	Wed, 12 Mar 2025 23:43:20 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Wed, 12 Mar 2025 16:42:04 -0700
Subject: [PATCH 4/5] power: supply: core: add vendor and product id
 properties
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-batt_ops-v1-4-88e0bb3129fd@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741822998; l=4480;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=WB7hF38MSoLEIkU2YsxPBirWto+BRIJ7TH5NCLcfRho=;
 b=EWT2Ht0hfipThdfWM480odd5LY11wxpMaeF9baAMJmfW6Rude8XPWC/1GppVSHVAmIfmOf3tW
 i3yAwc4bPrgAVk2RXGgSaq0QQA0TIVckxCRI7IahanVK+nXpaoxj1Yh
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Add the following properties:
  * Vendor Identifier (VID): Assigned to the battery manufacturer by USB
    Implementers Forum (USB-IF).
  * Product Identifier (PID) assigned by the manufacturer to the
    battery.

This info is required by USB Type-C PD devices containing batteries.
This enables the USB Type C devices to respond to a Battery capacity
request from the port partner by querying for the PID & VID assigned to
the batteries. Refer to "USB Power Delivery Specification Rev3.1 v1.8"
Chapter 5.5 Battery_Capabilities Message.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 Documentation/ABI/testing/sysfs-class-power | 20 ++++++++++++++++++++
 Documentation/power/power_supply_class.rst  | 11 +++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  2 ++
 include/linux/power_supply.h                |  2 ++
 4 files changed, 35 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 2a5c1a09a28f91beec6b18ca7b4492093026bc81..b2f377efbf065f7674b8ce44df1bc447c2f1223d 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -822,3 +822,23 @@ Description:
 		Each entry is a link to the device which registered the extension.
 
 		Access: Read
+
+What:		/sys/class/power_supply/<supply_name>/usbif_vendor_id
+Date:		March 2025
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the vendor id assigned to the battery manufacturer by USB
+		Implementers Forum (USB-IF).
+
+		Access: Read
+		Valid values: 0x0-0xffff
+
+What:		/sys/class/power_supply/<supply_name>/usbif_product_id
+Date:		March 2025
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the product id assigned to the battery by the manufacturer
+		(associated with usbif_vendor_id).
+
+		Access: Read
+		Valid values: 0x0-0xffff
diff --git a/Documentation/power/power_supply_class.rst b/Documentation/power/power_supply_class.rst
index da8e275a14ffb9f84bae9ae1efc4720a55ea3010..6d0a6bcf501e719fa4454845b583a8b38d371bb4 100644
--- a/Documentation/power/power_supply_class.rst
+++ b/Documentation/power/power_supply_class.rst
@@ -213,6 +213,17 @@ TIME_TO_FULL
   seconds left for battery to be considered full
   (i.e. while battery is charging)
 
+USBIF_VENDOR_ID
+  Vendor ID (VID) assigned to manufacturer or device vendor associated with the
+  battery by USB Implementers Forum (USB-IF). This property is described in
+  "USB Power Delivery Specification Rev3.1 V1.8" Chapter 6.5.5 Battery
+  Capabilities, Section 6.5.5.1 Vendor ID (VID).
+USBIF_PRODUCT_ID
+  Product ID (PID) assigned to the battery, such that if the VID belongs to the
+  manufacturer then the PID will be designated by it. Similarly if the VID
+  belongs to the device vendor then the PID will be designated by it. This
+  property is described in "USB Power Delivery Specification Rev3.1 V1.8"
+  Chapter 6.5.5 Battery Capabilities, Section 6.5.5.2 Product ID (PID).
 
 Battery <-> external power supply interaction
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index edb058c19c9c44ad9ad97a626fc8f59e3d3735a6..534ed3cd049866fa747455bb6dae1ec2dc5e2da6 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -211,6 +211,8 @@ static struct power_supply_attr power_supply_attrs[] __ro_after_init = {
 	POWER_SUPPLY_ATTR(TIME_TO_EMPTY_AVG),
 	POWER_SUPPLY_ATTR(TIME_TO_FULL_NOW),
 	POWER_SUPPLY_ATTR(TIME_TO_FULL_AVG),
+	POWER_SUPPLY_ATTR(USBIF_VENDOR_ID),
+	POWER_SUPPLY_ATTR(USBIF_PRODUCT_ID),
 	POWER_SUPPLY_ENUM_ATTR(TYPE),
 	POWER_SUPPLY_ENUM_ATTR(USB_TYPE),
 	POWER_SUPPLY_ENUM_ATTR(SCOPE),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 3f062607e5cd7c7f04384e34128ae0953e25d981..86be5c79db6055611153aa206981cf3de87f1381 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -165,6 +165,8 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
 	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
 	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
+	POWER_SUPPLY_PROP_USBIF_VENDOR_ID,
+	POWER_SUPPLY_PROP_USBIF_PRODUCT_ID,
 	POWER_SUPPLY_PROP_TYPE, /* use power_supply.type instead */
 	POWER_SUPPLY_PROP_USB_TYPE,
 	POWER_SUPPLY_PROP_SCOPE,

-- 
2.49.0.rc0.332.g42c0ae87b1-goog



