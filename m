Return-Path: <linux-pm+bounces-22255-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFD6A38DA0
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 21:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FB71893F39
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 20:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846BC239595;
	Mon, 17 Feb 2025 20:45:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E668323958A
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 20:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739825122; cv=none; b=UpgnrP8EptJaiaqnr5xofk9BGDzKV9JPNOAOMNsJ4muCXfuk10dYYmyAVyGyZV3S2yMIDOnKIMWwKBjys44sPFJI/X1m6E22sp6wUxo2pokRDgiJOONtkXHzfynauoNO5iE6exaxq3MMe+vV92mN7cF2xBuberjlESP4lIvcHks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739825122; c=relaxed/simple;
	bh=igOAyOe0a93PQhLLZM99D+X4R+n8FIOx6J9OuZIDARU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=neGTngWMxuOTl3+leTImhJGM2HLn9YhoFWXPR61nnbHPrS52BrH1RzAueXMoOTavcrrH/yuT3i0R0QJfem0WVSKMcDCf62XXZw2dFBuQEY21a/DvdQKA8BdPbyODGlBatu9UPyzJu8GO19n0eZtPGnbClY9xopx/dYz08uNakkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk7zP-0000iy-6L; Mon, 17 Feb 2025 21:45:15 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk7zO-001TGu-0c;
	Mon, 17 Feb 2025 21:45:14 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk7zO-000cxJ-0Q;
	Mon, 17 Feb 2025 21:45:14 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Mon, 17 Feb 2025 21:45:03 +0100
Subject: [PATCH RFC v2] docs: ABI: replace mcroce@microsoft.com with new
 Meta address
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-fix-mcroce-mail-bounce-v2-1-e897f4b15c80@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAM6fs2cC/4VNSwrCMBC9Spm1kUyswbgSBA/gVrroZ2wHbFKSt
 lRK7+7QC7h7/7dCosiU4JqtEGnmxMELMYcM6q70LSluhIPRJkeDTr15UX0dQ02qL/mjqjB5wSd
 zcVqjdbk+g5SHSJLch1/wfNyhELHjNIb43c9m3K1/uzMqVLmTCNrKaqtvA/l2GmPwvBwbgmLbt
 h/pRhTBxgAAAA==
X-Change-ID: 20241219-fix-mcroce-mail-bounce-328900169405
To: Matteo Croce <teknoraver@meta.com>, Jens Axboe <axboe@kernel.dk>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-block@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

The Microsoft email address is bouncing:

    550 5.4.1 Recipient address rejected: Access denied.

So let's replace it with Matteo's current mail address.

Acked-by: Matteo Croce <teknoraver@meta.com>
Link: https://lore.kernel.org/all/BYAPR15MB2504E4B02DFFB1E55871955DA1062@BYAPR15MB2504.namprd15.prod.outlook.com/
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
I ran into this while submitting a series[1] touching sysfs-kernel-reboot
and b4/get_maintainers.pl picked off the stale address from the file.

[1]: https://lore.kernel.org/all/20241219-hw_protection-reboot-v1-6-263a0c1df802@pengutronix.de/
---
Changes in v2:
- Added Matteo's Acked-by 
- Link to v1: https://lore.kernel.org/r/20241219-fix-mcroce-mail-bounce-v1-1-4912116b6060@pengutronix.de
---
 Documentation/ABI/stable/sysfs-block          |  2 +-
 Documentation/ABI/testing/sysfs-kernel-reboot | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 0cceb2badc836b8cbdade543deff71edef0e3da1..ee1bbb4dfd4ea65fc0aa13c03a5205b8d5816ecf 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -77,7 +77,7 @@ Description:
 
 What:		/sys/block/<disk>/diskseq
 Date:		February 2021
-Contact:	Matteo Croce <mcroce@microsoft.com>
+Contact:	Matteo Croce <teknoraver@meta.com>
 Description:
 		The /sys/block/<disk>/diskseq files reports the disk
 		sequence number, which is a monotonically increasing
diff --git a/Documentation/ABI/testing/sysfs-kernel-reboot b/Documentation/ABI/testing/sysfs-kernel-reboot
index 837330fb251134ffdf29cd68f0b2a845b088e5a0..fb2d21acc6627ee340a3c8327261d5727ad63e15 100644
--- a/Documentation/ABI/testing/sysfs-kernel-reboot
+++ b/Documentation/ABI/testing/sysfs-kernel-reboot
@@ -1,7 +1,7 @@
 What:		/sys/kernel/reboot
 Date:		November 2020
 KernelVersion:	5.11
-Contact:	Matteo Croce <mcroce@microsoft.com>
+Contact:	Matteo Croce <teknoraver@meta.com>
 Description:	Interface to set the kernel reboot behavior, similarly to
 		what can be done via the reboot= cmdline option.
 		(see Documentation/admin-guide/kernel-parameters.txt)
@@ -9,24 +9,24 @@ Description:	Interface to set the kernel reboot behavior, similarly to
 What:		/sys/kernel/reboot/mode
 Date:		November 2020
 KernelVersion:	5.11
-Contact:	Matteo Croce <mcroce@microsoft.com>
+Contact:	Matteo Croce <teknoraver@meta.com>
 Description:	Reboot mode. Valid values are: cold warm hard soft gpio
 
 What:		/sys/kernel/reboot/type
 Date:		November 2020
 KernelVersion:	5.11
-Contact:	Matteo Croce <mcroce@microsoft.com>
+Contact:	Matteo Croce <teknoraver@meta.com>
 Description:	Reboot type. Valid values are: bios acpi kbd triple efi pci
 
 What:		/sys/kernel/reboot/cpu
 Date:		November 2020
 KernelVersion:	5.11
-Contact:	Matteo Croce <mcroce@microsoft.com>
+Contact:	Matteo Croce <teknoraver@meta.com>
 Description:	CPU number to use to reboot.
 
 What:		/sys/kernel/reboot/force
 Date:		November 2020
 KernelVersion:	5.11
-Contact:	Matteo Croce <mcroce@microsoft.com>
+Contact:	Matteo Croce <teknoraver@meta.com>
 Description:	Don't wait for any other CPUs on reboot and
 		avoid anything that could hang.

---
base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
change-id: 20241219-fix-mcroce-mail-bounce-328900169405

Best regards,
-- 
Ahmad Fatoum <a.fatoum@pengutronix.de>


