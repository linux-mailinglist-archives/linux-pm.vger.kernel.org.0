Return-Path: <linux-pm+bounces-24502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B982FA70D7F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 00:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31CE4171A17
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 23:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C68C26A089;
	Tue, 25 Mar 2025 23:13:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5C61A76AE
	for <linux-pm@vger.kernel.org>; Tue, 25 Mar 2025 23:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742944397; cv=none; b=qTze6p1Z8k7l7A85xuEia7fJlMMALFFAUiXKIAJdGv4dXLyM9Y/s8HIcqGfD1AClxNdt5w0nS/ViJwBySEQ/+T2+AvK3f3DT7TjJ5wz/JvhTUDztRowZXeBKCThGuOKUHS9U+kWNBSxRq6/q6HOTC7B5RYnG11mhxxUYA4VCaWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742944397; c=relaxed/simple;
	bh=6sWe4aERWUOwF2kMuXLU8LvEYbl0kzYPUBnM6PECUCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ee+daY1keruq2fidkCvqINAQecbFVgph3/S5VKjD49PQAolFkF8hgNbSFOYYgFsTILBPOHW/mAQrK3PK3MqssXncSwWGEyE47b52bM/h6qHRf0WKX7u8GDFm9umEPZRpn6m/ZURk+WWWb/TTYEadoJozCVBHaajs3beLm1GL0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1txDSI-00064Z-Iw; Wed, 26 Mar 2025 00:13:10 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1txDSH-001eeV-2h;
	Wed, 26 Mar 2025 00:13:10 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1txDSI-00EnBh-0e;
	Wed, 26 Mar 2025 00:13:10 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Wed, 26 Mar 2025 00:13:02 +0100
Subject: [PATCH] pmdomain: core: only disable unused domains after
 genpd_power_off_unused has passed
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-pmdomain_core-v1-1-c35d342f934f@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAH0442cC/x3MQQqAIBBA0avIrBNsIhddJSImHWsWqShEEN09a
 fkW/z9QuQhXmNQDhS+pkmJD3ylwB8WdtfhmQIOjGdDqfPp0ksTVpcLab0gYcHOGLLQmFw5y/79
 5ed8P7uLmbl8AAAA=
X-Change-ID: 20250326-pmdomain_core-db2a2f2bc0a6
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2082;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=6sWe4aERWUOwF2kMuXLU8LvEYbl0kzYPUBnM6PECUCQ=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBn4ziFtimtaQcE1/vOM8ozsEGLCHzBIR84o84rl
 ZNmG+HicNmJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZ+M4hQAKCRC/aVhE+XH0
 qxqoD/0fYbHVaTyk1VaoE1STd9h0jVBzj06s8McsPu+0U529mgqj8JSgI5tF2bJL5goyZY5iENy
 WPauj95AWjTflGx/kqplVf3wLpd+Czf6u69EzTfD06eF4YfQw++L9CDBkCgQyX1fspBCkLsmP9e
 MXKH2HxSyYZpsFbl5Btuuhx9a9fJ9egojS9sFIhD3uRm6S4HXbgZek8zea+kSPMoa2xWrkadbzc
 6WyJX8MHvgIH9uQGmqURS53M6Z6NMzjedDnTbI+YxnRERfw3YQlYhhUNIvoBj1RpY6oAGnmdrAF
 GPCeLNNRZ52ryAWucE7SWYabFbsb0eos7Ftz9JS6EZh+OzhD3XCYUlVipoCQi+OQEoiBL2t6/OW
 Nu25aOxyYF8nUK/MGPD6rn9k3SIOHgpVP+I+MKR103kD424kpG7R7aYB8+lIurm3IAdEbJYuDL8
 6rGkWKCj+hOXmGku3icNcVPyHulgCMYaIUkvZqJXeCJbnP8Q/4nXWU0sZ9QAapsnAjvYspB729n
 uoUikdt4Qibd2O2DUIDpNUf2MeCoNKD6s0sGGsbJn4DCDNe+60qLHyzJsw77c6suLYj2NhgrmUa
 6isLiBgUjg8ZxZaldDBEj9r2p3CEydkrsz/uzCCRuf6o0vU0VfrIfam7jZyakk8Lj8PuxZCMkwv
 8rFb0OXnJZ8PFFA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

If the genpd_power_off_unsused late_initcall did not pass yet, skip any
genpd_power_off call. During the boot phase possible domain consumers
could show up, so it is not helpful to disable and enable the power
domains during that time.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/pmdomain/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 6c94137865c9b568666fb296e20e8669574a9576..493eee39e726abd62df8b8def047434871d15125 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -44,6 +44,8 @@ static DEFINE_IDA(genpd_ida);
 static LIST_HEAD(gpd_list);
 static DEFINE_MUTEX(gpd_list_lock);
 
+static bool genpd_power_off_unused_passed;
+
 struct genpd_lock_ops {
 	void (*lock)(struct generic_pm_domain *genpd);
 	void (*lock_nested)(struct generic_pm_domain *genpd, int depth);
@@ -1023,6 +1025,14 @@ static void genpd_power_off_work_fn(struct work_struct *work)
 
 	genpd = container_of(work, struct generic_pm_domain, power_off_work);
 
+	/*
+	 * If the genpd_power_off_unsused late_initcall did not pass yet
+	 * skip any genpd_power_off call since we are still in boot phase
+	 * where possible pw domain consumers could show up.
+	 */
+	if (!genpd_power_off_unused_passed)
+		return;
+
 	genpd_lock(genpd);
 	genpd_power_off(genpd, false, 0);
 	genpd_unlock(genpd);
@@ -1249,6 +1259,8 @@ static int __init genpd_power_off_unused(void)
 		return 0;
 	}
 
+	genpd_power_off_unused_passed = true;
+
 	pr_info("genpd: Disabling unused power domains\n");
 	mutex_lock(&gpd_list_lock);
 
@@ -3272,6 +3284,8 @@ EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
 
 static int __init genpd_bus_init(void)
 {
+	genpd_power_off_unused_passed = false;
+
 	return bus_register(&genpd_bus_type);
 }
 core_initcall(genpd_bus_init);

---
base-commit: b3c623b9a94f7f798715c87e7a75ceeecf15292f
change-id: 20250326-pmdomain_core-db2a2f2bc0a6

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


