Return-Path: <linux-pm+bounces-27539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83FDAC19BA
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 03:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD2B4E7B36
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 01:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B861120103A;
	Fri, 23 May 2025 01:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XONZ0LxU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8420A2DCC05;
	Fri, 23 May 2025 01:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747964383; cv=none; b=a3/7qL6Iuib8tTjwtjw9gZ2REOSP6n36JrmKeiwso6MsXFcgE85Ap69Byqqss2qYuSjj6e6auwcAC4GuImb9PB+B6ncssjr7nUV//zK6CmI/+B01mInC4R0iTGl1bHh8DUHtaBxt4/Pw/tapQHJF0XJgEZS5btreoi0upnySegk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747964383; c=relaxed/simple;
	bh=D4LvA7UrfCTe8VeKBExXVK+cUwdzdAgvCjBwbtio6bU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t/uoG4FewDYJMI6XsWr/syC2GXoXn85JxEpz8lin5ppsKAw1vlQoom1MqcL6U3Wy/R7iDqlukrtYGBeVu93CsBtUQl6BPzYsfupRh2YvovWFbWLQMyhoS3HzDypP4de8+qzK83H8qA++PYeArkUtAYRGXJtaHsxWR0USZI+I5Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XONZ0LxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15A14C4AF09;
	Fri, 23 May 2025 01:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747964383;
	bh=D4LvA7UrfCTe8VeKBExXVK+cUwdzdAgvCjBwbtio6bU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XONZ0LxUe1TSJGXI1LHRCjKjMuYNV6JeOY9stPxUvIOGa3+yKt3ZzXJJAU0flCySf
	 4SfZrjCl4xzTQDXSy6Xln830oXDdnUE6EvfUsT8keU/DIzYqNZVTEJ/PAIpqkEnZBL
	 uCnxGEss6A05Of67slmau9phxF39C9J4V/AyxrARLJcf4+COxF6IsBFEpt3JMbNlU8
	 ScUo5LBojnoT+s6jp9SaEs/lqSkPENE02DYbatz2P0iN/S2qMhinjCUQvmnSolFe/I
	 BQYZCwPinp4FHsrZ1EAivJTcVRNi770Il1po1dOZ+D1WS4esBupwoR4LbUzzG6j6+A
	 RslTavHFoZ0Ng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C68C54ED1;
	Fri, 23 May 2025 01:39:42 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Fri, 23 May 2025 09:39:19 +0800
Subject: [PATCH 2/5] power: supply: core: Add state_of_health power supply
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-qcom_battmgr_update-v1-2-2bb6d4e0a56e@oss.qualcomm.com>
References: <20250523-qcom_battmgr_update-v1-0-2bb6d4e0a56e@oss.qualcomm.com>
In-Reply-To: <20250523-qcom_battmgr_update-v1-0-2bb6d4e0a56e@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 kernel@oss.qualcomm.com, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747964381; l=2318;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=4T4hHb+n7mzpuwhjLl1QDUEn8r857rZ0TUShtny5/Kc=;
 b=Bz8qghEKK5oMDE3AeLx76B583WLtBjd/hk5oy/Wa5T6/VcPDmTFcA00v/latAHggWExfgeQB5
 Nec2/clnNAGAM/iZPDWY9DXKeFUKISUWIVhhQW40N7NR+sAgAw46x+u
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Add state_of_health power supply property to represent battery
health percentage.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 Documentation/ABI/testing/sysfs-class-power | 10 ++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 22a565a6a1c509461b8c483e12975295765121d6..74e0d4d67467500c3cd62da3ae0b2e4a67e77680 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -562,6 +562,16 @@ Description:
 
 		Valid values: Represented in microohms
 
+What:		/sys/class/power_supply/<supply_name>/state_of_health
+Date:		May 2025
+Contact:	linux-arm-msm@vger.kernel.org
+Description:
+		Reports battery power supply state of health in percentage.
+
+		Access: Read
+
+		Valid values: 0 - 100 (percent)
+
 **USB Properties**
 
 What:		/sys/class/power_supply/<supply_name>/input_current_limit
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index dd829148eb6fda5dcd7eab53fc70f99081763714..12af0d0398822ff23d8970f6bdc8e3ef68081a1d 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -221,6 +221,7 @@ static struct power_supply_attr power_supply_attrs[] __ro_after_init = {
 	POWER_SUPPLY_ATTR(MANUFACTURE_MONTH),
 	POWER_SUPPLY_ATTR(MANUFACTURE_DAY),
 	POWER_SUPPLY_ATTR(RESISTANCE),
+	POWER_SUPPLY_ATTR(STATE_OF_HEALTH),
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_ATTR(MODEL_NAME),
 	POWER_SUPPLY_ATTR(MANUFACTURER),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index de3e88810e322546470b21258913abc7707c86a7..dd0108940231352ac6c6f0fa962d1ea904d81c7a 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -175,6 +175,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
 	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
 	POWER_SUPPLY_PROP_RESISTANCE,
+	POWER_SUPPLY_PROP_STATE_OF_HEALTH,
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,

-- 
2.34.1



