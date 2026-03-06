Return-Path: <linux-pm+bounces-43812-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLjELYLZqmkZXwEAu9opvQ
	(envelope-from <linux-pm+bounces-43812-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 14:41:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE9F221ED9
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 14:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19E67308B6D6
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 13:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCC42FF65B;
	Fri,  6 Mar 2026 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="qA1vwIdq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx-relay16-hz2.antispameurope.com (mx-relay16-hz2.antispameurope.com [83.246.65.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC742FD1D0
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=83.246.65.158
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772803866; cv=pass; b=AMF71EWExWHa0UsyxT7qof0n3E2jecWASGvZh9OEx/czqVVlgl8RZHEdB/TeC+BjeydiTKpZVoxrB7XPYPrldBIDuwXsONc2AL/8772gKi/rF4kdCxiKyWiaCCxx7j/sykSrR95y7n0lUXu/AzrgXRQPr74G7oY2F0O7WrVjzBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772803866; c=relaxed/simple;
	bh=B/SKEbLB4NeJQ0DcfcoWtnek2upih7gnEx/OxsXc/+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fBHRM5tEBuqPhJ8K3pdEwPoj4R4KH/Mhi2MJdvhrTGk8A4c7OUw43CfsL/3LuTFH73UAR6HB8Hb/kVcxQlkGOLua+IjXRLSRFNBo3hm+oFJnMju3/QhpcGjq07heTX9ob1QAYjVr8NNiGHuYPMrzR6Rrss77NEfZ8L4/Dbb9IWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com; spf=fail smtp.mailfrom=ew.tq-group.com; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=qA1vwIdq reason="key not found in DNS"; arc=pass smtp.client-ip=83.246.65.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate16-hz2.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=fail header.from=ew.tq-group.com orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=gMn+Wn5KfqDQbXMRtFszp3dqdpP1E1pimM9ejWQhJD0=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1772803830;
 b=JFWfoVYrHTyRgb6mKOtgydPoSy4S0kZjNhS3qTgjfcR6zs20NX5SxSf3FxPw4LBijFNArQb5
 ziRn/lUNdgnqK3r1+0wbJ7AdMBdGvzOuyoDmntH/G3C3USEukp/BXBs9s6bxHMjCAMOS2CGNs+4
 co7pe93aIJaTOg0pjMeAmxAvSuIXeW5k4JP0dmSijYEjWw9KprslAq2VjdwH8Oki5bgoYvEh1Qx
 WImnIB3fexVeD2N80lrbA16ufIS/t985/e6xyIxj+lHl9Ao5Np476MG+UHQZOvnS2nxKPf7NhOw
 A3ebC/fifZoX9GT3eGsK6SbZYnno9FbIWxAZLEJFLSCGg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1772803830;
 b=D4criSh6jmaORncMeTYAqOxDw2LoeERFdg0eo3UtBK8+njhCGiW/KDM8cq++mroCNvKRdgFc
 BJliU9x1pcXCIs5CN9lgG4O86TVgYvyB/PLqwyCn/e7vUeuaRrvPahbo8msOl5i/e+KXAyIMQAC
 09dAvcc8I4VPDKutuDc6X+i5r4ltfeq2DYv6ZOtiH1DcH5kwrNWOd0ZvCtbyFUTDp1iiV9QhN91
 uDYhR+n9ts/UWqdCZB9Wj2AJ2O3QyJ8TwPrV+fv1CwEnBp6G7DWaB69BvKs1L5U8+mcyaESER+P
 jTuILY9ClmbgC3aqmyTJI+y8vsr0GAowrBhea/FnFWlAw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay16-hz2.antispameurope.com;
 Fri, 06 Mar 2026 14:30:29 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 51FE65A124D;
	Fri,  6 Mar 2026 14:30:19 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] thermal/drivers/imx91: Add hwmon support
Date: Fri,  6 Mar 2026 14:30:16 +0100
Message-ID: <20260306133017.3189979-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-pm@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay16-hz2.antispameurope.com with 4fS6j80YhXz29jgJ
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:61a3c465b03ebe9e8bdf6da1c36a1fa1
X-cloud-security:scantime:1.357
DKIM-Signature: a=rsa-sha256;
 bh=gMn+Wn5KfqDQbXMRtFszp3dqdpP1E1pimM9ejWQhJD0=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1772803829; v=1;
 b=qA1vwIdqGPuFAF6IWuGxqk90U6eQpD7TEqJEE9BqlqcUQc+BsAz8cU0+9ZLACpVA6e1+c6W9
 T4HyqerrO3fAemx02nWKxhX7aCftbc4rcPt28gJb93fYs5cjIJjOzSiKOv2AyHacebbOU0Ho9V7
 t4Myu55xkjSNQbB5boF7op7K1T7YD3kSzaU+vyAVrW36WTupcAt0i16DkgFfXD4OhOMkCMNcUAt
 h22pqwC8HmIO+Qcr/Uq9yRGfV5Y86mMynRX6BPc/CzreBmPnphohmNe+Z3CCVnVFslbrUfKx2dR
 LeLV/i1j1nQwFxnx7Y8GLzRxxgcS4gss/GeP/iJ9G1JuA==
X-Rspamd-Queue-Id: BBE9F221ED9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[ew.tq-group.com : SPF not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ew.tq-group.com:~];
	RCPT_COUNT_TWELVE(0.00)[13];
	R_DKIM_PERMFAIL(0.00)[ew.tq-group.com:s=hse1];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43812-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,intel.com,arm.com,nxp.com,pengutronix.de,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.stein@ew.tq-group.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.981];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,tq-group.com:email,ew.tq-group.com:mid]
X-Rspamd-Action: no action

Expose thermal readings as a HWMON device, so that it could be
accessed using lm-sensors.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/thermal/imx91_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
index 9b20be03d6dec..25915bb702bea 100644
--- a/drivers/thermal/imx91_thermal.c
+++ b/drivers/thermal/imx91_thermal.c
@@ -17,6 +17,8 @@
 #include <linux/thermal.h>
 #include <linux/units.h>
 
+#include "thermal_hwmon.h"
+
 #define REG_SET					0x4
 #define REG_CLR					0x8
 #define REG_TOG					0xc
@@ -318,6 +320,8 @@ static int imx91_tmu_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(tmu->tzd),
 				     "failed to register thermal zone sensor\n");
 
+	devm_thermal_add_hwmon_sysfs(dev, tmu->tzd);
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
-- 
2.43.0


