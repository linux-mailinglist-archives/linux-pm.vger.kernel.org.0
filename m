Return-Path: <linux-pm+bounces-43486-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDs8GgXcpmnRXwAAu9opvQ
	(envelope-from <linux-pm+bounces-43486-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 14:03:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DB81EFD13
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 14:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79ABE303A936
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 12:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD30A35E959;
	Tue,  3 Mar 2026 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="G3F49INs"
X-Original-To: linux-pm@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379D535E947
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772542749; cv=none; b=aqr+tO0AxRHGoBM+w3eSnoWHnd2jRp1GIpvwEZn/Z9kdS3Q11WexKDfU6CKAC7HSckk3iE9r1wan1M8dPtcE0khqFNMUNkInNX9hSuRWicnqjP86is9p7srzNU94qVrBU+3zYtKqFw+tzCMtIxPn3hHiw5nC3REaoc8fmg12fMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772542749; c=relaxed/simple;
	bh=jCkmEf8crPyr76/z5IV3pbKbhmAc8MFwTSLiKtnDMjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OtnD/9TNU9MOU1qEbw1x5IUzEPBc6Gzmae5U5+M/DPI7gVwNAy/gX8rPDXt4JROz+akonnKpHKGZ4Qa64PgdTHlHlw/oel6TGrE41CyWRhX772WjggKY6BKrfPrHLwT7L8HW2w/t4Ul/B/6II5BATZoXJr58sTYC+Ld27M7vzvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=G3F49INs; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: c2469769-1700-11f1-969b-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c2469769-1700-11f1-969b-005056abbe64;
	Tue, 03 Mar 2026 13:59:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=TxnaUJXOl/lvwlgC9cHqxHBw5mL0eV8RXWHVOARkZuQ=;
	b=G3F49INszGDNveNcXoHRSmA2hRXx6GlVwcmW6rZgjOY6kkSNM7YZr74PrJhnB6o0M+ou0fLvlTTES
	 vWvz3ynQRbmi/SCRBgmVqWhV/abFTufXVhJyzygWaycW6/zjIuqgt56pp7ZOEeAsf6DtwzsxACj1Qf
	 Pv9D3dVEoY3MFOmrKWoBr5LJ7mq98zXuCwyEEQI8rjruERv2g/6sbw/S215wYf1Zuc6OVAZGs+w0uJ
	 ULzkm1OGLh9pJZhhARuwrkGbX3iS2a3O+hzBTTr39EbEm9++FAFdMuQfAMONF1QoE4V7G1jgg5O+1n
	 Vq1SAEM+Z0LFsfcSZRYSuigLrFldQng==
X-KPN-MID: 33|MIhv6Tr+KHyPEw9mxak4PnwrKkm0vwZ/tN+zdTw3URHeK8Zws+lJOKOesJPq+dI
 F8dPNftYPLtoWhc1iIrlBugXr7Z0anep+oWaSZUikWHM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|nyki5os/9ZqBUixMOt5dzUw24oacS6lG0IspIKRvKWoYci1xmtjg0yY9TsCbhAW
 UO4l1t3pnRXYd9PcvCkNFvQ==
Received: from daedalus.home (unknown [178.230.196.166])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id bf0fdb49-1700-11f1-8011-005056ab7447;
	Tue, 03 Mar 2026 13:59:05 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org (open list:DEVICE FREQUENCY (DEVFREQ)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] devfreq: change devfreq_class to a const struct
Date: Tue,  3 Mar 2026 13:59:08 +0100
Message-ID: <20260303125909.3523053-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C1DB81EFD13
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43486-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[xs4all.nl,linuxfoundation.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:query timed out];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email]
X-Rspamd-Action: no action

The class_create() call has been deprecated in favor of class_register()
as the driver core now allows for a struct class to be in read-only
memory. Change devfreq_class to be a const struct class and drop the
class_create() call. This is compile tested only.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 drivers/devfreq/devfreq.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index c0a74091b904..f2298f8e3224 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -36,7 +36,13 @@
 #define IS_SUPPORTED_FLAG(f, name) ((f & DEVFREQ_GOV_FLAG_##name) ? true : false)
 #define IS_SUPPORTED_ATTR(f, name) ((f & DEVFREQ_GOV_ATTR_##name) ? true : false)
 
-static struct class *devfreq_class;
+static struct attribute *devfreq_attrs[];
+ATTRIBUTE_GROUPS(devfreq);
+
+static const struct class devfreq_class = {
+	.name		= "devfreq",
+	.dev_groups	= devfreq_groups
+};
 static struct dentry *devfreq_debugfs;
 
 /*
@@ -830,7 +836,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	mutex_init(&devfreq->lock);
 	mutex_lock(&devfreq->lock);
 	devfreq->dev.parent = dev;
-	devfreq->dev.class = devfreq_class;
+	devfreq->dev.class = &devfreq_class;
 	devfreq->dev.groups = profile->dev_groups;
 	devfreq->dev.release = devfreq_dev_release;
 	INIT_LIST_HEAD(&devfreq->node);
@@ -1807,7 +1813,6 @@ static struct attribute *devfreq_attrs[] = {
 	&dev_attr_trans_stat.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(devfreq);
 
 static ssize_t polling_interval_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
@@ -2019,19 +2024,20 @@ DEFINE_SHOW_ATTRIBUTE(devfreq_summary);
 
 static int __init devfreq_init(void)
 {
-	devfreq_class = class_create("devfreq");
-	if (IS_ERR(devfreq_class)) {
+	int err;
+
+	err = class_register(&devfreq_class);
+	if (err) {
 		pr_err("%s: couldn't create class\n", __FILE__);
-		return PTR_ERR(devfreq_class);
+		return err;
 	}
 
 	devfreq_wq = create_freezable_workqueue("devfreq_wq");
 	if (!devfreq_wq) {
-		class_destroy(devfreq_class);
+		class_unregister(&devfreq_class);
 		pr_err("%s: couldn't create workqueue\n", __FILE__);
 		return -ENOMEM;
 	}
-	devfreq_class->dev_groups = devfreq_groups;
 
 	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
 	debugfs_create_file("devfreq_summary", 0444,

base-commit: d466c332e106fe666d1e2f5a24d08e308bebbfa1
-- 
2.53.0


