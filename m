Return-Path: <linux-pm+bounces-42570-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DiZJ97rjWnG8gAAu9opvQ
	(envelope-from <linux-pm+bounces-42570-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 16:03:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9448612EBEC
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 16:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31054300C7D6
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 15:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DEF29CE9;
	Thu, 12 Feb 2026 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XeRW6ThW"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A3635CB8B
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770908559; cv=none; b=gmt7N7HItf56RVvxpqDW8ytQSzMFDUBqqy5h40rwpuBLFjJeEb6VgCxrgh/IA0sCJrQu+LkXU6cL0uAduIiDOVRZol5JPnZzl6T78d2pXdWt5wzevX91Bmku2Gn5c1lIEz92gFRvNZ0BTHyk7cBN6/+g1dfYb0QDKgacJOT5q14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770908559; c=relaxed/simple;
	bh=KGoIt/rmuQQGAOXrojB20wdBDHiojDND21u6VlQsnhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ty6kLZ+NtTOxnB+3soA4RI0i8gnp3FMFb+N1dtf8NADdEnuEV5bhjj13z6+AWI9te34UB8VR2E7CKG4ilMDNjSrsUFaq+HLsGYjfRmsVbnV8Njh+zmITuAw8/5n6dAgXGu2mXuX6EK7JEhVEN7ItEiddjCIxe2nrZRAL8e3yt+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XeRW6ThW; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=S0almpWJIOmyEv6VSqYTcS2yRIN/gY920tBGs7TdzE4=; b=XeRW6ThWK0s3rjldMHx4Mkm4KT
	2leO8FJL2XjBjJxgKUcJuw0iFABOSb/uWJkvcBGXMiLP+LHz0U0vkEzdeDL6/0lSALyoZ9RVJST3b
	k/Q3c+HBFaUZgTi4okIGKc2Pyuv0ECEzk4aQm48Bi12lpg2jB8nNu9vw2RU+TxwHOuTKS51xPVBAC
	Dmc7hIy9rksi50QQFTN73WqP1xRswPi0iPz3wKvFrvjQjRYEoDz2Jh6xXUfI0RBIZPf1ngppV6hN7
	AWig7TQXo3Wpy1RBVTrLAhBo5Nm+3lG6GDIG4b1YCIfUMwYoGM/dAco/3aeNeqzKwjLc2YkFVV9Gr
	+PCxzvQQ==;
Received: from [187.36.210.68] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256) (Exim)
	id 1vqYCy-00HZH1-0K; Thu, 12 Feb 2026 16:02:20 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>
Cc: linux-pm@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH] pmdomain: bcm: bcm2835-power: Fix broken reset status read
Date: Thu, 12 Feb 2026 11:49:44 -0300
Message-ID: <20260212150039.67117-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42570-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,broadcom.com,gmx.net];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mcanal@igalia.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[igalia.com:-];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9448612EBEC
X-Rspamd-Action: no action

bcm2835_reset_status() has a misplaced parenthesis on every PM_READ()
call. Since PM_READ(reg) expands to readl(power->base + (reg)), the
expression:

    PM_READ(PM_GRAFX & PM_V3DRSTN)

computes the bitwise AND of the register offset PM_GRAFX with the
bitmask PM_V3DRSTN before using the result as a register offset, reading
from the wrong MMIO address instead of the intended PM_GRAFX register.
The same issue affects the PM_IMAGE cases.

Fix by moving the closing parenthesis so PM_READ() receives only the
register offset, and the bitmask is applied to the value returned by
the read.

Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains under a new binding.")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---

Hi,

Most likely this bug went unnoticed as there is no in-tree driver
currently calling reset_control_status() on the BCM2835 reset
controller. Although I'm sending a fix to the .status callback, another
possibility would be removing the implementation of this callback
considering that (1) it's broken and (2) it's not used.

I'd appreciate your feedback about the most suitable option.

Best regards,
- Maíra

---

 drivers/pmdomain/bcm/bcm2835-power.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/bcm2835-power.c
index 1d29addfe036..0450202bbee2 100644
--- a/drivers/pmdomain/bcm/bcm2835-power.c
+++ b/drivers/pmdomain/bcm/bcm2835-power.c
@@ -580,11 +580,11 @@ static int bcm2835_reset_status(struct reset_controller_dev *rcdev,
 
 	switch (id) {
 	case BCM2835_RESET_V3D:
-		return !PM_READ(PM_GRAFX & PM_V3DRSTN);
+		return !(PM_READ(PM_GRAFX) & PM_V3DRSTN);
 	case BCM2835_RESET_H264:
-		return !PM_READ(PM_IMAGE & PM_H264RSTN);
+		return !(PM_READ(PM_IMAGE) & PM_H264RSTN);
 	case BCM2835_RESET_ISP:
-		return !PM_READ(PM_IMAGE & PM_ISPRSTN);
+		return !(PM_READ(PM_IMAGE) & PM_ISPRSTN);
 	default:
 		return -EINVAL;
 	}
-- 
2.52.0


