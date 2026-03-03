Return-Path: <linux-pm+bounces-43517-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAHyAPQMp2kDcgAAu9opvQ
	(envelope-from <linux-pm+bounces-43517-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 17:31:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7436D1F3D73
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 17:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7463E30D2EC6
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 16:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0710B4D90AA;
	Tue,  3 Mar 2026 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="m1LTLaED"
X-Original-To: linux-pm@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A558B3BED69
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555098; cv=none; b=bB85VZUkyq4YoQUnE4YpdeTshvj8N7hGNlY5S1vEA+wXz/c92r/lpuYsrUfz+BY+5gaOTbf2jw6vxUVcrCTdBNE3i6naPovHMIqp7xp8RmGCUFAUs634oZuy5ZEbL1j/Z3v+nH4sTICX6bWMGTOB+XHrEieFr/B8sYUY5roRqMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555098; c=relaxed/simple;
	bh=dZlGgiNJR+pthvIMaRy0AOvoVGUKu3DW6sw/TqMaq0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OrBPL+voUYMyILOpP2oxc4ZEa8XY6KBUtSSOkyKRXlQ/CsZ+LzwqR1R66qxgTxj3vvSOwmBSHGtmPudT78MfABMde/a+rOnnJsGBC4ReVjhmEw9pebe80s81nzxA/byjNRgOOq7vvkKce29L99TGtsJb0rYWLQjPbxD3/SXBmNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=m1LTLaED; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 7f0f76d0-171d-11f1-8a98-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 7f0f76d0-171d-11f1-8a98-005056ab378f;
	Tue, 03 Mar 2026 17:24:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=hjIQKQc09Ty4ZuPFqA4sflWylIiFqAt4knIEFLnMnCk=;
	b=m1LTLaEDMcquFs9wNeD8FYDgUVxVNma60aNRZhLCN1PJSyPJ8JCGtt37J0ciOAr9qr4dXZgGaMYmm
	 /Yx+kSaaEWk/Q7Cr/wfkLFPV3Mm/QAr1rDKnNz9oDmykOIsuVO7LVZMYObrGrGhce6MfRtliYnL/fW
	 0lqSAC5a+5+Cg1UXdsh989MYvYfpoFJuJXaZbxP0DI7p2rM1ISKFWAyfRNIGRnNftclMp3Xrl7DhQ8
	 1WtJ/wPfea5oTGvWY6aYQAWSqAPCKr1Comk8b+kzqIT2Zkcd2hytY2PEqkMc7hfOZLwHJWy8bm5Prb
	 +RvAATtbtSAbgUnby0OaD/c91tySfFw==
X-KPN-MID: 33|BqWFPQ9as2TXmvPHpkgKx5Y4mtDAZ2Xi2ND1FU9f7qsVVoDVNVVOweDAJ7Tr6UZ
 fuDwi+xnQ6u5TNv+buoexJEF+OYS/fp8SeyLaFGbuKNU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|dgj/5kkFtGTPmsRMMHiCIDGNywtjsWsiXq9RcnZYjix+gQAt/BuSoTKXbqIfgYm
 hYRaUPIwuxQB0CCdSylDdmg==
Received: from daedalus.home (unknown [178.230.196.166])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 7bbec3ea-171d-11f1-bdab-005056ab1411;
	Tue, 03 Mar 2026 17:24:47 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org (open list:DEVICE FREQUENCY EVENT (DEVFREQ-EVENT)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] devfreq: change devfreq_event_class to a const struct
Date: Tue,  3 Mar 2026 17:25:04 +0100
Message-ID: <20260303162505.3748001-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7436D1F3D73
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	FREEMAIL_CC(0.00)[xs4all.nl,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-43517-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,xs4all.nl:dkim,xs4all.nl:email,xs4all.nl:mid,linuxfoundation.org:email]
X-Rspamd-Action: no action

The class_create() call has been deprecated in favor of class_register()
as the driver core now allows for a struct class to be in read-only
memory. Change devfreq_event_class to be a const struct class and drop
the class_create() call. Compile tested.

Link: https://lore.kernel.org/all/2023040244-duffel-pushpin-f738@gregkh/

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 drivers/devfreq/devfreq-event.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 179de3cf6d6c..9e183cd8818c 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -17,7 +17,13 @@
 #include <linux/list.h>
 #include <linux/of.h>
 
-static struct class *devfreq_event_class;
+static struct attribute *devfreq_event_attrs[];
+ATTRIBUTE_GROUPS(devfreq_event);
+
+static const struct class devfreq_event_class = {
+	.name		= "devfreq-event",
+	.dev_groups	= devfreq_event_groups
+};
 
 /* The list of all devfreq event list */
 static LIST_HEAD(devfreq_event_list);
@@ -321,7 +327,7 @@ struct devfreq_event_dev *devfreq_event_add_edev(struct device *dev,
 	edev->desc = desc;
 	edev->enable_count = 0;
 	edev->dev.parent = dev;
-	edev->dev.class = devfreq_event_class;
+	edev->dev.class = &devfreq_event_class;
 	edev->dev.release = devfreq_event_release_edev;
 
 	dev_set_name(&edev->dev, "event%d", atomic_inc_return(&event_no));
@@ -461,18 +467,15 @@ static struct attribute *devfreq_event_attrs[] = {
 	&dev_attr_enable_count.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(devfreq_event);
 
 static int __init devfreq_event_init(void)
 {
-	devfreq_event_class = class_create("devfreq-event");
-	if (IS_ERR(devfreq_event_class)) {
-		pr_err("%s: couldn't create class\n", __FILE__);
-		return PTR_ERR(devfreq_event_class);
-	}
+	int err;
 
-	devfreq_event_class->dev_groups = devfreq_event_groups;
+	err = class_register(&devfreq_event_class);
+	if (err)
+		pr_err("%s: couldn't create class\n", __FILE__);
 
-	return 0;
+	return err;
 }
 subsys_initcall(devfreq_event_init);

base-commit: d466c332e106fe666d1e2f5a24d08e308bebbfa1
-- 
2.53.0


