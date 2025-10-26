Return-Path: <linux-pm+bounces-36835-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 138BCC0A2E0
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 06:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029963A9F31
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 05:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EF326E702;
	Sun, 26 Oct 2025 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+oPqEmo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5661F418F;
	Sun, 26 Oct 2025 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761455358; cv=none; b=cz4bYLeG2tAR4li1MLiIuBOx40QtmtcLj+AKys52uz93XrUnqOGBG7t1XQzCjbz9gbgszJPX/4Tg6X0eRKrbfyQRwAvT/5YYh1MWwN4bIxcg6TzQM+Cb01+7IoonRuKgUXnsRsLyJ2rHv76EEXlkyuFACAlUXQTWY3toz+DB9lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761455358; c=relaxed/simple;
	bh=6P7UqqCzlyOrQjDXavwBSKKqhOj7y6n2US3KKU6dV2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbX5vc5+Qrfu4G2CqNX+DrnW+fL2LI48KWLf72/IlGjJEeIQsSHxxNNNMSbzrmM7JHjdGwAQt81vgJqzY/xyG6OUJQ6gARHUSrSzbiIe5fOP45j4LQLZYAH/TUXiSwK2OwBsxAhBeOGu1JyFTHDGcsUIjc2S6XR5kYUxnrV4+sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+oPqEmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73FAC4CEF7;
	Sun, 26 Oct 2025 05:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761455358;
	bh=6P7UqqCzlyOrQjDXavwBSKKqhOj7y6n2US3KKU6dV2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n+oPqEmo+oJrANUSyNz/Sc9HkLlz14pJrlP1zd3weAYd6S6maksa5FDP8dt0hyKYm
	 lzsvH5vdQZ7uLBvtXY68KwsrtnqBVNyVcXr4UZzy1Ywxw3TEZzxoaWDTvOzwzdNNrw
	 dfJ0w1ytk+e7VoVXMtQRM98p1DL8xgsoa1mJVneOw+W8vadmjag3AjE6FuDDibvCRH
	 EiwowUjWMa17KqRmknQs9HrcpH5Hne81OLxuQPt+BZeAKG/h/BQZwEtPhfx4WmOf6k
	 oDThk0RcBeHdbTJ/AkDl2PFQEPKmpNaU8DJTyxtadQAcQ1hRLvirAk4WBVZdkUc6ze
	 0HGuJw98seLsg==
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
Subject: [PATCH v9 3/4] usb: sl811-hcd: Add PM_EVENT_POWEROFF into suspend callbacks
Date: Sun, 26 Oct 2025 00:09:04 -0500
Message-ID: <20251026050905.764203-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026050905.764203-1-superm1@kernel.org>
References: <20251026050905.764203-1-superm1@kernel.org>
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


