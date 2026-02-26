Return-Path: <linux-pm+bounces-43230-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMNrNiPgn2lLegQAu9opvQ
	(envelope-from <linux-pm+bounces-43230-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 06:54:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CD21A1227
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 06:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17E0730C31D2
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 05:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487D738B7CC;
	Thu, 26 Feb 2026 05:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nJ5EzEGh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B9E38A73F
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 05:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772085202; cv=none; b=BHNVXgkcnKTUPHHuQYDIRTcF8rns+zcQm3mcG+mkgNwtBsBXYuLxnd5K4JofjVu09BzQhFGRTdp3Vw5ZjjRIi5KH0A2O428H+wVayVpNyyzE+ZyOopkkjkySLyoPrGyQTD0T4D6tQUC+G0VMCrMf0y5TJeXevSZa3L61EvjeA/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772085202; c=relaxed/simple;
	bh=5PZ8CggFuOHWg9Rc+M/mGjcAtyt2FOwDfgn4r8JYe38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a5tyZKLmtOGLrnLF5l/LjlYzvq1dJ1FkVt98VL45cMOS4MKlxDZQQFy05zKZz0uUYCfv8dJbPqYSAxw59G5zVdagZmXUMFD5CEU22FYiJeb4t/SZTygtRjmee5/2i6S8ApQCtRsupvpb2mib8jSe0eaIj3IFxWgthlskz43MMqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nJ5EzEGh; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdd40c0c5bso311455eec.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 21:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772085200; x=1772690000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LkHfgITQ7X2diSbprSgbvJHo2GTsX0M8Rs/FPJ/8x+8=;
        b=nJ5EzEGhJv6NmwB4nf2mwyPuJnrPiy9O22MdUKN8QI4muUNlT996WHs8KJMUlxtE8N
         cFiKEUk7NBspLKBA68rdwRDIo274+R4Y35st47VUzHp/w/g74+2eKCSVg9EilehRf+Gv
         DBwNtd2hPuFFC73XhB1iIcNzEDj/lETGUdsz76shNWHU6JNoniZ0kbx0yvChQfG+xQZ5
         +Qw5oYDr3m5neNpLtGKbVG/VECbaXPWAcR5YUdoZ353SoIV4NNnLntRvFi57UoDNxoZ1
         vhVzXlUenosXwYTLrM57wCNZY9sJrKDbsSVHKqeXR0lM5mzrivLBhO4JYYb1sKYpPP9j
         /78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772085200; x=1772690000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkHfgITQ7X2diSbprSgbvJHo2GTsX0M8Rs/FPJ/8x+8=;
        b=H1re2BTV4m3KKqndTdjrvNFVGjOUI+1Z1AESeYgMsM+oQOXP9BwGSF9lnkeoKGU+V9
         D/LS60f5No7/jV3sVCEcMEFQ0XtlROxT0d6iRnucRwNDKyEFqG3VKhmuNImv1gQtvlTb
         b79b5wqdoSBAOuTkK+EQSUJ2+zMQ0rTA5Uerv8EIiexvlMF3Iela3bmUHnz5bhUi+ZXV
         wz7fBJUPqD1njB6MqSYc6SsdSp05MgzY5Yh7vdEH43Q+IQEU9DX0GFY3jJ/dRdWRrAVD
         JXvBCzI9gk8keaxv38xMyb5DlHKxXm0UqPy63WfSXNz+T8m8sF1MdoadoP95S5FjLHQc
         aLpw==
X-Forwarded-Encrypted: i=1; AJvYcCXb6JvJ0J4C2NVcGoka4m8lNmexchYClkLU4DuJ/g5Mx97z7i9mbDBdVj3IL8lz1jmCrgxeLMAKBA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7O0xV9v2hxuytjgF4Gpr3R3ZEANCFWRMHSutLY/R6xyzUl5ks
	Z+MMHR7EGQqaoAgNniPzYFeG3AvmhQhwabCi9RuYKZvfLX2rYkIC0mtlytuZifxips9wLbN9sa2
	90j6YIQ==
X-Received: from dlbuy16.prod.google.com ([2002:a05:7022:1e10:b0:127:32c4:b97b])
 (user=badhri job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4384:b0:11a:fec5:d005
 with SMTP id a92af1059eb24-12789c76961mr613663c88.10.1772085199939; Wed, 25
 Feb 2026 21:53:19 -0800 (PST)
Date: Thu, 26 Feb 2026 05:53:10 +0000
In-Reply-To: <20260226055311.2591357-1-badhri@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226055311.2591357-1-badhri@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226055311.2591357-3-badhri@google.com>
Subject: [PATCH v1 2/3] power: supply: Add PD SPR AVS support to USB type enum
From: Badhri Jagan Sridharan <badhri@google.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Badhri Jagan Sridharan <badhri@google.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Sunil Dhamne <amitsd@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43230-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[badhri@google.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40CD21A1227
X-Rspamd-Action: no action

Add two new members to the power_supply_usb_type to represent the
USB Power Delivery (PD) Standard Power Range (SPR) Adjustable Voltage
Supply (AVS) charging types:

POWER_SUPPLY_USB_TYPE_PD_SPR_AVS: For devices supporting only the
PD SPR AVS type.

POWER_SUPPLY_USB_TYPE_PD_PPS_SPR_AVS: For devices that support both
PD Programmable Power Supply (PPS) and PD SPR AVS.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/power/supply/power_supply_sysfs.c | 2 ++
 include/linux/power_supply.h              | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index dd3a48d72d2b..f30a7b9ccd5e 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -70,6 +70,8 @@ static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] = {
 	[POWER_SUPPLY_USB_TYPE_PD]		= "PD",
 	[POWER_SUPPLY_USB_TYPE_PD_DRP]		= "PD_DRP",
 	[POWER_SUPPLY_USB_TYPE_PD_PPS]		= "PD_PPS",
+	[POWER_SUPPLY_USB_TYPE_PD_SPR_AVS]	= "PD_SPR_AVS",
+	[POWER_SUPPLY_USB_TYPE_PD_PPS_SPR_AVS]	= "PD_PPS_SPR_AVS",
 	[POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID]	= "BrickID",
 };
 
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 360ffdf272da..7a5e4c3242a0 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -210,6 +210,9 @@ enum power_supply_usb_type {
 	POWER_SUPPLY_USB_TYPE_PD,		/* Power Delivery Port */
 	POWER_SUPPLY_USB_TYPE_PD_DRP,		/* PD Dual Role Port */
 	POWER_SUPPLY_USB_TYPE_PD_PPS,		/* PD Programmable Power Supply */
+	/* PD Standard Power Range Adjustable Voltage Supply */
+	POWER_SUPPLY_USB_TYPE_PD_SPR_AVS,
+	POWER_SUPPLY_USB_TYPE_PD_PPS_SPR_AVS,	/* Supports both PD PPS + SPR AVS */
 	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
 };
 
-- 
2.53.0.414.gf7e9f6c205-goog


