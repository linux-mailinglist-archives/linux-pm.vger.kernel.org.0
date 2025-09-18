Return-Path: <linux-pm+bounces-34940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC8FB82CB6
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 05:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B9A1C02FDA
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 03:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31DF248883;
	Thu, 18 Sep 2025 03:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxWZdn4s"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C752C24502C;
	Thu, 18 Sep 2025 03:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758167111; cv=none; b=p4gGK9pL9Ztfvr41XAAu21Wzcu0rDBfJeeO1uDc1vAujynAHNH2trAnY/WV68yzMV1yfC9Z5HPOrftOcI+6F4tIiioKQxAePUk0+EUxheLXxXuFayfNn6mIie1PhR4XlngYNai4F9lLj68VgHakxNg80dRsovzFhgvl6yQcYERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758167111; c=relaxed/simple;
	bh=ohLb1pQcyqq54/IPl2+21bp6stFKpzLqHJsHr73YJCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOHBFoaGi1EiOp2HgM3jCuE/4GRDhgZSYn251T4i8Nr8/8dCsb3/5yagzyDSANrXX2ymmRkhpSnLfw5bTg5eC1VkpHhCCbOlZ3RQevmPyPPKDYV6JYMoxK4grIfGv/c7fu8lDL5zS8lNEkoYeO0hEies9ydTAEUIBiFPrZAsxMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxWZdn4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FA7C4CEE7;
	Thu, 18 Sep 2025 03:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758167111;
	bh=ohLb1pQcyqq54/IPl2+21bp6stFKpzLqHJsHr73YJCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mxWZdn4sqxRIwFdN0SATC9yiyiwB+Hk/14gpQiSCOVuQUPHAeNkTZq2kye9TzhbNw
	 7xSMHBdjRSqLa6e57pE0Sebl08oxtUzD8df3wLc9ul/FwZLSpqZNo3PtSeBDJ7Karl
	 lklveXmCzkjLLgX+fKq92TnuEAzr7F5sntiLFv9V1wiVV3U+E9bZf4o7HkpamJDhWm
	 zLC1ks+4EGAhh9VlirXHw/Zf2a1lKUyeGMTYs6DRXJh8hdOSacpIO7y+fyfut1jcAM
	 4o8ZpjPzK8MEIIsC/4Ps9Aik2FmR4ZqiZKXZA3UidKkJJxDLOalhkcMt0a/B9Zi+Ge
	 D4Isez/jMzZiA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Merthan=20Karaka=C5=9F?= <m3rthn.k@gmail.com>,
	Eric Naim <dnaim@cachyos.org>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v8 3/4] usb: sl811-hcd: Add PM_EVENT_POWEROFF into suspend callbacks
Date: Wed, 17 Sep 2025 22:44:26 -0500
Message-ID: <20250918034427.3226217-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918034427.3226217-1-superm1@kernel.org>
References: <20250918034427.3226217-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the ACPI core uses hibernation callbacks for shutdown drivers
will receive PM_EVENT_POWEROFF and should handle it the same as
PM_EVENT_HIBERNATE would have been used.

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v8:
 * Break up series to 3 parts
v5:
 * Re-order
 * Add tags
v4:
 * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@kernel.org/
---
 drivers/usb/host/sl811-hcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index ea3cab99c5d4..5d6dba681e50 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1748,6 +1748,7 @@ sl811h_suspend(struct platform_device *dev, pm_message_t state)
 		break;
 	case PM_EVENT_SUSPEND:
 	case PM_EVENT_HIBERNATE:
+	case PM_EVENT_POWEROFF:
 	case PM_EVENT_PRETHAW:		/* explicitly discard hw state */
 		port_power(sl811, 0);
 		break;
-- 
2.51.0


