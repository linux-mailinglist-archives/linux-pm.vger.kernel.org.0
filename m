Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06E12F959F
	for <lists+linux-pm@lfdr.de>; Sun, 17 Jan 2021 22:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbhAQVtq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 16:49:46 -0500
Received: from sender11-of-o51.zoho.eu ([31.186.226.237]:21172 "EHLO
        sender11-of-o51.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbhAQVtp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 16:49:45 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1610920135; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=RPQODZVz2LCAHCSLHehY6mdIQolV4jP55AqPvfh7dz7obnIAV74iifmpgQJUc9Q9TI2qjan9wAUdBgfpIhwgJLqsXLP6IqHciVQCQN4OOin4aAcTMoqr2i9+EC/q3CHmzw/mUbM48NdHhwGvDfZDRepuIdtZIN+V77ac0qlc+z0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1610920135; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=/iqAgMNp+FlnJhzzH8xC5dIrusI6dNUJwgOXRb8KHSM=; 
        b=SPLoYxWNIFBZAlpzeCp3jyzkhm8tP+Kh4ZML6QZrDF9nBfqNZ+giW4rLCa473vB9hb+PvhmQS/PpbF8BTzx6gWOMZxvTN+3kSYCoci78SQinwezQraP5jxbOfR//S7AHdyoTPAa7Of6fNn2s8eg33TWZQBPRIZPW/Zfs+7hBeSQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=philipp@uvos.xyz;
        dmarc=pass header.from=<philipp@uvos.xyz> header.from=<philipp@uvos.xyz>
Received: from localhost.localdomain (ip-95-222-215-9.hsi15.unitymediagroup.de [95.222.215.9]) by mx.zoho.eu
        with SMTPS id 1610920133704549.3530334433713; Sun, 17 Jan 2021 22:48:53 +0100 (CET)
Date:   Sun, 17 Jan 2021 22:48:53 +0100
From:   Carl Philipp Klemm <philipp@uvos.xyz>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 5/5] power: supply: cpcap-charger: Add usleep to cpcap
 charger to avoid usb plug bounce
Message-Id: <20210117224853.3602368391c9785e74748239@uvos.xyz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adds 80000 us sleep when the usb cable is plugged in to hopefully avoid
bouncing contacts.

Upon pluging in the usb cable vbus will bounce for some time, causing cpcap to
dissconnect charging due to detecting an undervoltage condition. This is a
scope of vbus on xt894 while quickly inserting the usb cable with firm force,
probed at the far side of the usb socket and vbus loaded with approx 1k:
http://uvos.xyz/maserati/usbplug.jpg.

As can clearly be seen, vbus is all over the place for the first 15 ms or so
with a small blip at ~40 ms this causes the cpcap to trip up and disable
charging again.

The delay helps cpcap_usb_detect avoid the worst of this. It is, however, still
not ideal as strong vibrations can cause the issue to reapear any time during
charging. I have however not been able to cause the device to stop charging due
to this in practice as it is hard to vibrate the device such that the vbus pins
start bouncing again but cpcap_usb_detect is not called again due to a detected
disconnect/reconnect event.

Signed-off-by: Carl Philipp Klemm <philipp@uvos.xyz>
---
 drivers/power/supply/cpcap-charger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index be7d1da7a5a5..3e5fbdbdd645 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -650,6 +650,9 @@ static void cpcap_usb_detect(struct work_struct *work)
 		return;
 	}
 
+	/* Delay for 80ms to avoid vbus bouncing when usb cable is plugged in */
+	usleep_range(80000, 120000);
+
 	/* Throttle chrgcurr2 interrupt for charger done and retry */
 	switch (ddata->status) {
 	case POWER_SUPPLY_STATUS_CHARGING:
-- 
2.29.2
