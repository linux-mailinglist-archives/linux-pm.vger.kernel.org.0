Return-Path: <linux-pm+bounces-37889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99415C54BC3
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 23:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E3B14E2F34
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 22:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B942ED860;
	Wed, 12 Nov 2025 22:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzLvroSm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365E12D5C95;
	Wed, 12 Nov 2025 22:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762987235; cv=none; b=RujiGPdcZ5spQkCyHzt8Av7rwT9V2tL24zwUcVoMQnt69sEgy5lbrWS83g5SwUKEFt0UvVzTgJr3OEDuhgqKgV21teNYCugmrEcoDIp9fseIsQe/KLImYe4Stwygseb1DMs9pl6i7CKViItbAsFMAF1bcyS4Js6WOV+tUZddSwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762987235; c=relaxed/simple;
	bh=vMjuqv/6Epvwu+TrDCjqG+fGd18pE9xtaDD5a6rvOTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHId/UPM/kDB0bfrVNakIzbJSEUV8IU4iOnnlsoRJEdxvouMs58kF0k+VoBktmqOglIzgIknAPFa4sc0DncfpdWRsEwO6I/k/OZlv5GNqHqO/oKxHcZglLIdSfkn1UPbyYHOS4yxgEHd36mkeo1RwIza3WVKmgEj9s65JzzwhR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzLvroSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F22BC4CEF1;
	Wed, 12 Nov 2025 22:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762987235;
	bh=vMjuqv/6Epvwu+TrDCjqG+fGd18pE9xtaDD5a6rvOTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lzLvroSmbN2wCfjPYjyn2ynFQFBEnm7VsUic7XyziPKUHjUFuls4EY2ctnVyi6aSc
	 qYHRmuiJezi/ioH90Mnx8eG5pwb2DMirRefqDNWooXOh4fxyuEp4nJKlHsDDl0ZZwW
	 VmvUtc4uUYVjnYV+/ZtWVNV3bKe6Bm7mvvhZeMoTQwjAImCfLxCUWkWLnz6/Ofxf5J
	 Gy+LW4NTP1t8QxqmF2e3X99F4vutAlDKMKbKZx9TukXtShOBnfAaS1MLZlCiz4iIbb
	 54ohZ0qE5Hfa96/3KWWzEfnen95POJGJwPGT/wPshecJ66QJofaLjNM5/HM6CZt34M
	 CCPwAyR3i5L6w==
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
Subject: [PATCH v10 3/3] usb: sl811-hcd: Add PM_EVENT_POWEROFF into suspend callbacks
Date: Wed, 12 Nov 2025 16:40:25 -0600
Message-ID: <20251112224025.2051702-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112224025.2051702-1-superm1@kernel.org>
References: <20251112224025.2051702-1-superm1@kernel.org>
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
 drivers/usb/host/sl811-hcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index ea3cab99c5d40..5d6dba681e503 100644
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
2.43.0


