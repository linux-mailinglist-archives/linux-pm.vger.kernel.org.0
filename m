Return-Path: <linux-pm+bounces-26854-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 882BBAAF068
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 03:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B39987C14
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 01:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22DC189F5C;
	Thu,  8 May 2025 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3XYQq57"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1A9208D0;
	Thu,  8 May 2025 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746666155; cv=none; b=o/opnrqq0Vj4UK9T5ECALmL7+3lfL+jk27jpAlpDX3okzYR43x3Nr41wdC2vvOzyNKW4kvyFWF4ulQ/JiRQO5HjpLv73CjpxxWqQ6qHyHI+Wsmxsrw4M2SuK57ijnrhL4C+r9kz0yE04XDO/wyt91k/xrLdEfJU5YmZi/rJ8f/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746666155; c=relaxed/simple;
	bh=/7YObtV03/PH0CZkIklZ+NjmOVa5AkOnBVyqgm4mkLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JTQvDBmmLwVyhUgLo/rW/OLzLRHIBQ51n6/XpEFDJwAsrN22MO8Rs4jLKh/PKDx+NZRmJv9BCdCFDaOLeGrD2hsoWZ4bYYUsJbmGz39YfITkktHGf5ecTPLEhXjfH94f1X4hVNBHGgRbGnEQ5NsrgOwLAXwipn7xIW5RpXU5Llk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3XYQq57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E4E8C4CEFA;
	Thu,  8 May 2025 01:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746666155;
	bh=/7YObtV03/PH0CZkIklZ+NjmOVa5AkOnBVyqgm4mkLY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=N3XYQq57EQanZ0lGH4IfohlciKYAzxUIuXUM1a/Jlj7QQuWHeDLVQ4RPcHwecMQBR
	 1/5kZFJ0/Dt96jkfeEitgtGioByy7sz+v03Eu85gWLNr/ZclRfYNQS2Q7dXxgM18jP
	 1T7cKl35lLrqrH/Hd0cfxIisxEgjgc6Be86q3Bq6y3IRSdYuNcUKRlo7qNpYde4j3+
	 pA16L+j90wI6v7widpuUQ/5Ln1AGPmS2AKM0F0X/QyTLxd8RDV4qzucvqp6lke14Q1
	 JefYMj5im5BKG1WUwuCUN4La3tOdKR7l9oWkUbWUUGvs2/UPBZ28n+IqMghqBc0dkY
	 Z0MKIh1/5skIg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460A5C3ABC6;
	Thu,  8 May 2025 01:02:35 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Wed, 07 May 2025 18:00:25 -0700
Subject: [PATCH v2 4/5] power: supply: core: add vendor and product id
 properties
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-batt_ops-v2-4-8d06130bffe6@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746666154; l=4662;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=g9p/DCU+bGgdFEAH/ycTnIAAglqng7UgwLdvZfFI4iw=;
 b=Yz1RUaHYwcb+mtpsdlRbZycn+wl+0jQ9bh7UaEA2QIuNOyFQIc6NuhyTAOLMs6jeypEDdXsYd
 NUTZ8vjF+LJBaA7Zzp/r+mHGOgXh7QxsTX/iShsM5v+JAT4FQ/mOZTV
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
 Documentation/ABI/testing/sysfs-class-power | 19 +++++++++++++++----
 Documentation/power/power_supply_class.rst  | 11 +++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  2 ++
 include/linux/power_supply.h                |  2 ++
 4 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 2a5c1a09a28f91beec6b18ca7b4492093026bc81..5495e82885b2294cdfd5ace0e7e5fcbeadfccb5f 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -814,11 +814,22 @@ Description:
 		Access: Read
 		Valid values: 1-31
 
-What:		/sys/class/power_supply/<supply_name>/extensions/<extension_name>
-Date:		March 2025
+What:		/sys/class/power_supply/<supply_name>/usbif_vendor_id
+Date:		May 2025
 Contact:	linux-pm@vger.kernel.org
 Description:
-		Reports the extensions registered to the power supply.
-		Each entry is a link to the device which registered the extension.
+		Reports the vendor id assigned to the battery manufacturer by USB
+		Implementers Forum (USB-IF).
 
 		Access: Read
+		Valid values: 0x0-0xffff
+
+What:		/sys/class/power_supply/<supply_name>/usbif_product_id
+Date:		May 2025
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
index a35b08bd368e9305554e1a608dc8e526983cfa12..100eb559dcede938595ffbf83bc5ef3645a5a172 100644
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
2.49.0.987.g0cc8ee98dc-goog



