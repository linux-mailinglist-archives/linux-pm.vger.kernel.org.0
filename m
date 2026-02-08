Return-Path: <linux-pm+bounces-42261-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA4QCA6aiGktsAQAu9opvQ
	(envelope-from <linux-pm+bounces-42261-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 15:13:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3E4108E40
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 15:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C6C93010BA8
	for <lists+linux-pm@lfdr.de>; Sun,  8 Feb 2026 14:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AB135504E;
	Sun,  8 Feb 2026 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4RC9Ahp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F34346780;
	Sun,  8 Feb 2026 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770560010; cv=none; b=OusP84FEUusQPJ/SIj+aIxbEt4CFVRO7piwIKpBgwYHUjb86jdhF+Ze3jI4Nor7xv++Sf7HmTmUNvqpV927L2tKKtMLg+EsN1X7I/XhBdRGZNZSgn3pn/5ThkiMKVqXq2at1NDZKgItZmMTR1WJ89hRD1Fqr3a2rDC+hPlgFVio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770560010; c=relaxed/simple;
	bh=m2gKDCHwQTBkgBjdnY4ayviTXv5mD4SQ4ouRKoiJ6H0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PxE6aQeatPCtfpzmoaMgJoAmhRJhBoHxft94DUWqNyxoX/aZzpv+AR+J9i7HOjOiKjPmID+vm56Cddn0/l3LtJMWAybB9SJktqsM2B+ZTTE3HpnBbY1ggpYXe13s3filbMT5qx3POfBxQSuoRpMmiX6UzHctHNUwwROjrILV+xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4RC9Ahp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6C9C19424;
	Sun,  8 Feb 2026 14:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770560010;
	bh=m2gKDCHwQTBkgBjdnY4ayviTXv5mD4SQ4ouRKoiJ6H0=;
	h=From:To:Cc:Subject:Date:From;
	b=B4RC9AhpjT8yHanv7suHyl5nkZa8spZTjFh0wftEOAh+4zi8+KnPhuEmHEHmy+/Ky
	 WgzShjVxYYUF6m3PKLOMUz73BubsCLpuiKfsAyF23KuW3DDkxKxfmcqJv1dMARYHEh
	 bngUsC7BxLyPr2T1a7R/fZLAKYuAbh6A2BEf2oigXzJc2apBejQLWcXptIo0gy0oSP
	 xaBVQxF+KiabYX3HUYSf6Yo/RystYLfRIPAw7DcaA69XtQiS1FKdQ3dsKYYq92a7Z0
	 oPSVNQFiYsn9nOOK0ywwsmudKKIf3Fkwgj8uNfHASi6TyRk753JgtEgDJe3yyGZSMh
	 lS7tbqMcWTRFg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Subject:
 [PATCH v2] ACPI: button: Call device_init_wakeup() earlier during probe
Date: Sun, 08 Feb 2026 15:13:26 +0100
Message-ID: <12854922.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42261-lists,linux-pm=lfdr.de];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B3E4108E40
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Calling device_init_wakeup() after installing a notify handler in which
wakeup events are signaled may cause a wakeup event to be missed if the
device is probed right before a system suspend.

To avoid this, move the device_init_wakeup() call in acpi_button_probe()
before the notify handler installation and add a corresponding cleanup
to the error path.

Also carry out wakeup cleanup for the button in acpi_button_remove()
because after that point the notify handler will not run for it and
wakeup events coming from it will not be signaled.

Fixes: 0d51157dfaac ("ACPI: button: Eliminate the driver notify callback")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Also clean up wakeup settings during remove.

---
 drivers/acpi/button.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -625,6 +625,8 @@ static int acpi_button_probe(struct plat
 		goto err_remove_fs;
 	}
 
+	device_init_wakeup(&pdev->dev, true);
+
 	switch (device->device_type) {
 	case ACPI_BUS_TYPE_POWER_BUTTON:
 		status = acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
@@ -655,11 +657,11 @@ static int acpi_button_probe(struct plat
 		lid_device = device;
 	}
 
-	device_init_wakeup(&pdev->dev, true);
 	pr_info("%s [%s]\n", name, acpi_device_bid(device));
 	return 0;
 
 err_input_unregister:
+	device_init_wakeup(&pdev->dev, false);
 	input_unregister_device(input);
 err_remove_fs:
 	acpi_button_remove_fs(button);
@@ -691,6 +693,8 @@ static void acpi_button_remove(struct pl
 	}
 	acpi_os_wait_events_complete();
 
+	device_init_wakeup(&pdev->dev, false);
+
 	acpi_button_remove_fs(button);
 	input_unregister_device(button->input);
 	kfree(button);




