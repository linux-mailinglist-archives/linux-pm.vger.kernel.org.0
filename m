Return-Path: <linux-pm+bounces-25347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52652A87919
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 09:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065361712C0
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 07:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8198D25A358;
	Mon, 14 Apr 2025 07:35:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88C1259C9D
	for <linux-pm@vger.kernel.org>; Mon, 14 Apr 2025 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616145; cv=none; b=UW5lDbmaEgcW3gRq46TMueRMM026UgdfyV9Gtf8tV9/PgeGzwOWZgRDakKb8L7B5VS54IQTwUTjFVX31VNmWKHhfK0GCJA0RB9dhbGsRXmiw/CjsFUI+my9n98iWwNzgaJ5rzgWMKzyV0EiiyF9KjKRxHnkd15ZKjxZM4DSbQBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616145; c=relaxed/simple;
	bh=Ou2vOurVWHondECFpfTMtcoZVsobG8aP/abnWazjfsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ojppz+fJj/Tf6iiacph7H9FcdijYH2JxcQxJlwplZ+8BxXk6wA4P8XRpjVilVp4rLiT9BPRGH5n7hqKpgzaefHAlbevom9KlR2HmjPZKiUKkwlLWMFxi9H5Q/iDF6EySI9cVcz44V/v2rQkMIKkdrVaMkqWGP7LblVFsAlvRcyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1u4ELw-0002p3-QH; Mon, 14 Apr 2025 09:35:36 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1u4ELv-000DDx-2u;
	Mon, 14 Apr 2025 09:35:35 +0200
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1u4ELv-00BnLF-2i;
	Mon, 14 Apr 2025 09:35:35 +0200
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Mon, 14 Apr 2025 09:35:31 +0200
Subject: [PATCH v3] docs: ABI: replace mcroce@microsoft.com with new Meta
 address
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-fix-mcroce-mail-bounce-v3-1-0aed2d71f3d7@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAMK6/GcC/4XNQQ6DIBAF0Ks0rEvDIKJ01Xs0XSiOSlLBgBIb4
 92LJl01TXfzJ3/erCSgNxjI9bQSj9EE42wK2flEdF/ZDqlpUiaccQEcFG3NQgftnUY6VOZJazf
 bNGe8VIyBVILlJB2PHlPzgO+PlHsTJudfx58I+/YvGYECFSpVQNaSSXYb0Xbz5J01y6VBsruRf
 6yccSh+WjxZWKqiFTXkuvy2tm17AyCCJoINAQAA
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
get_maintainers.pl picks off the stale address from the file otherwise

[1]: https://lore.kernel.org/all/20241219-hw_protection-reboot-v1-6-263a0c1df802@pengutronix.de/
---
Changes in v3:
- drop RFC prefix
- Link to v2: https://lore.kernel.org/r/20250217-fix-mcroce-mail-bounce-v2-1-e897f4b15c80@pengutronix.de

Changes in v2:
- Added Matteo's Acked-by 
- Link to v1: https://lore.kernel.org/r/20241219-fix-mcroce-mail-bounce-v1-1-4912116b6060@pengutronix.de
---
 Documentation/ABI/stable/sysfs-block          |  2 +-
 Documentation/ABI/testing/sysfs-kernel-reboot | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 3879963f0f01e5f291e40bb7cf3fb638e7a61d6b..11545c9e2e93f2a15637cef6309d875c4ce8e385 100644
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
index e117aba46be0e8d3cdff3abfb678f8847a726122..52571fd5ddba517b86bed8867fe6b84c8ed7a6b9 100644
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
@@ -9,25 +9,25 @@ Description:	Interface to set the kernel reboot behavior, similarly to
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
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20241219-fix-mcroce-mail-bounce-328900169405

Best regards,
-- 
Ahmad Fatoum <a.fatoum@pengutronix.de>


