Return-Path: <linux-pm+bounces-7841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B2B8C4F7C
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29F26B20F4C
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7230140360;
	Tue, 14 May 2024 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0A7MTGe+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oTUs1qbG"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD7213FD89
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681946; cv=none; b=Yg9t8zxxIxBR7a+BcuHSyDzMf1cBGT4QJxE3tPxBJ1QMB7YSTi1vSFwNvpTIJZITRjCMNly+tDi3gzWcpe1qqp3dtJAqYat5igA3ZZ1PG/Vl/F3RlsZTCm46TiGlAxTi3CkkLgtPYNtHUSkY2Pwkl2TSAZ+C8X7hKIeRrmmYBUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681946; c=relaxed/simple;
	bh=2weViA/Qnnlrxg0O/Y/JsH/2hah4B1+Xq/PG8DR1bCk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=gpuRlKVMzhLN3liS+PcUaSvP8BfbboA45LY5umlcwH7ldi2Mf/XCABHRmG7u98RxssFPCkv5ZM0CO43bxfHPdwMk6GoOj037chTKMPAGFSl5UDtCMaM1hG0L4jz3cAoCQR+zffBcZ1XIuXXA+Q4AAQpiH80YpYIquMYdzjm7eYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0A7MTGe+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oTUs1qbG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=W7zAWUf4H1sGKiMEZoWZz6t42g5Li+EbCb2U0rp+7Jo=;
	b=0A7MTGe+Q68DZt4gyHqQ+31W2xqaPM4d7OJUBkR9JC6/l7oE/kn8lfl+ICRD6BgYL+p8L5
	XpF96ArubM6yOf/IRlyp86HbSc2PqofWQwxYj5b46AjQULE8eLD6wx9doz4hvezmUt18OK
	GL9dIsnJEJqw337kc6SA5C3Kf+vgG9Q7er7KUYB2XhRm19iMYvRyeKE+R2TTtLRtFki85l
	a/nE+8S8ZL23NObH477afolPAfFikl8uGRIZt3LBKpvX78eHtkLcb1peojXxWZtTKGMknp
	QzQGiyHBb8Ae7BMBuQ8Nqep3Mrx/vM27iC9PDBNXT2pbToH3NeQzoBJeNgc3Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=W7zAWUf4H1sGKiMEZoWZz6t42g5Li+EbCb2U0rp+7Jo=;
	b=oTUs1qbG9dFcqy+Q81mDSh9vAPAsyENFREUamRHmcFT+mqqcIpbrLUpI6iTT6cL4t02fom
	9NrEMo68cWTNQ7Dw==
From: "thermal-bot for Stanislaw Gruszka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal: netlink: Rename thermal_gnl_family
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, rui.zhang@intel.com,
 daniel.lezcano@linaro.org, amitk@kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193770.10875.17318498581456869530.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     afdaff3706918b7414e0741c4c5c20a12726a207
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//afdaff3706918b7414e0741c4c5c20a12726a207
Author:        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
AuthorDate:    Fri, 23 Feb 2024 16:59:41 +01:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Wed, 27 Mar 2024 14:50:26 +01:00

thermal: netlink: Rename thermal_gnl_family

Almost all thermal netlink structures use thermal_genl prefix.
Change thermal_gnl_family name accordingly for consistency.

No functional impact.

Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_netlink.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index d407130..bef14ce 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -70,12 +70,12 @@ struct param {
 
 typedef int (*cb_t)(struct param *);
 
-static struct genl_family thermal_gnl_family;
+static struct genl_family thermal_genl_family;
 static BLOCKING_NOTIFIER_HEAD(thermal_genl_chain);
 
 static int thermal_group_has_listeners(enum thermal_genl_multicast_groups group)
 {
-	return genl_has_listeners(&thermal_gnl_family, &init_net, group);
+	return genl_has_listeners(&thermal_genl_family, &init_net, group);
 }
 
 /************************** Sampling encoding *******************************/
@@ -92,7 +92,7 @@ int thermal_genl_sampling_temp(int id, int temp)
 	if (!skb)
 		return -ENOMEM;
 
-	hdr = genlmsg_put(skb, 0, 0, &thermal_gnl_family, 0,
+	hdr = genlmsg_put(skb, 0, 0, &thermal_genl_family, 0,
 			  THERMAL_GENL_SAMPLING_TEMP);
 	if (!hdr)
 		goto out_free;
@@ -105,7 +105,7 @@ int thermal_genl_sampling_temp(int id, int temp)
 
 	genlmsg_end(skb, hdr);
 
-	genlmsg_multicast(&thermal_gnl_family, skb, 0, THERMAL_GENL_SAMPLING_GROUP, GFP_KERNEL);
+	genlmsg_multicast(&thermal_genl_family, skb, 0, THERMAL_GENL_SAMPLING_GROUP, GFP_KERNEL);
 
 	return 0;
 out_cancel:
@@ -279,7 +279,7 @@ static int thermal_genl_send_event(enum thermal_genl_event event,
 		return -ENOMEM;
 	p->msg = msg;
 
-	hdr = genlmsg_put(msg, 0, 0, &thermal_gnl_family, 0, event);
+	hdr = genlmsg_put(msg, 0, 0, &thermal_genl_family, 0, event);
 	if (!hdr)
 		goto out_free_msg;
 
@@ -289,7 +289,7 @@ static int thermal_genl_send_event(enum thermal_genl_event event,
 
 	genlmsg_end(msg, hdr);
 
-	genlmsg_multicast(&thermal_gnl_family, msg, 0, THERMAL_GENL_EVENT_GROUP, GFP_KERNEL);
+	genlmsg_multicast(&thermal_genl_family, msg, 0, THERMAL_GENL_EVENT_GROUP, GFP_KERNEL);
 
 	return 0;
 
@@ -590,7 +590,7 @@ static int thermal_genl_cmd_dumpit(struct sk_buff *skb,
 	int ret;
 	void *hdr;
 
-	hdr = genlmsg_put(skb, 0, 0, &thermal_gnl_family, 0, cmd);
+	hdr = genlmsg_put(skb, 0, 0, &thermal_genl_family, 0, cmd);
 	if (!hdr)
 		return -EMSGSIZE;
 
@@ -622,7 +622,7 @@ static int thermal_genl_cmd_doit(struct sk_buff *skb,
 		return -ENOMEM;
 	p.msg = msg;
 
-	hdr = genlmsg_put_reply(msg, info, &thermal_gnl_family, 0, cmd);
+	hdr = genlmsg_put_reply(msg, info, &thermal_genl_family, 0, cmd);
 	if (!hdr)
 		goto out_free_msg;
 
@@ -691,7 +691,7 @@ static const struct genl_small_ops thermal_genl_ops[] = {
 	},
 };
 
-static struct genl_family thermal_gnl_family __ro_after_init = {
+static struct genl_family thermal_genl_family __ro_after_init = {
 	.hdrsize	= 0,
 	.name		= THERMAL_GENL_FAMILY_NAME,
 	.version	= THERMAL_GENL_VERSION,
@@ -718,10 +718,10 @@ int thermal_genl_unregister_notifier(struct notifier_block *nb)
 
 int __init thermal_netlink_init(void)
 {
-	return genl_register_family(&thermal_gnl_family);
+	return genl_register_family(&thermal_genl_family);
 }
 
 void __init thermal_netlink_exit(void)
 {
-	genl_unregister_family(&thermal_gnl_family);
+	genl_unregister_family(&thermal_genl_family);
 }

