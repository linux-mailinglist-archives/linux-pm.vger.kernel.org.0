Return-Path: <linux-pm+bounces-22339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A17A3A738
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 20:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EE9188CAA3
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 19:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C631E5217;
	Tue, 18 Feb 2025 19:18:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B4A1E51F0
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 19:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906325; cv=none; b=O9YrOiRZdWVxCmnpHznWfaONzxQRN5EeQm5sZS2kZ6C/y8t6QwAnfJpn4B5yAldnHUX3BMOCGh3OuO5a7G3cU2Tmya6MQaQbJqK4Z5o0FPoQRJ/Zwi7l3yB+uScytQgDyirVcaGUicJR2avEyonwTNd2Ml1k7DPwFa9tHv8WEy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906325; c=relaxed/simple;
	bh=NYfwx10LSDctMdoVNvS9JCp6vYmsW9rdlEFhA5eQEGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oOK0qGD07ILMXLnMnu8ZShkeSYFLBL72XIw15OWp0DU9s9nt3ck2eqJOll7RLWAI4RYQBlHbpWbaDk+AiDv9irg1eyDO+ErZ6J/utAtQexl5iv9CDv6v97JewCHSpyizax1Y59wBdtI1bMiVKGyO/rUjX2qqnrDUt41OyJBbbR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tkT74-0001AE-PV; Tue, 18 Feb 2025 20:18:34 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tkT74-001dvB-0y;
	Tue, 18 Feb 2025 20:18:34 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tkT74-00BCDr-0m;
	Tue, 18 Feb 2025 20:18:34 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Tue, 18 Feb 2025 20:18:32 +0100
Subject: [PATCH] pmdomain: imx: gpcv2: use proper helper for property
 detection
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-gpcv2-of-property-present-v1-1-3bb1a9789654@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAAfdtGcC/x2MQQqAMAwEvyI5G7ABofgV8aBtqrm0pRVRpH83e
 JsZ2H2hchGuMHUvFL6kSooqpu/AHWvcGcWrAw00DmQs7tldhClgLilzOR8FrhxPNKMN1m+ByTv
 QvfYg9/89L6194i/+OmsAAAA=
X-Change-ID: 20250218-gpcv2-of-property-present-158f8dbfe2dc
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Starting with commit c141ecc3cecd7 ("of: Warn when of_property_read_bool()
is used on non-boolean properties"), probing the gpcv2 device on i.MX8M
SoCs leads to warnings when LOCKDEP is enabled.

Fix this by checking property presence with of_property_present as
intended.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/pmdomain/imx/gpcv2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index 958d34d4821b1be68d730ad345037b8f0a56c45a..105fcaf13a34c787b2d568bc64e7fee9bfc23393 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -1361,7 +1361,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 	}
 
 	if (IS_ENABLED(CONFIG_LOCKDEP) &&
-	    of_property_read_bool(domain->dev->of_node, "power-domains"))
+	    of_property_present(domain->dev->of_node, "power-domains"))
 		lockdep_set_subclass(&domain->genpd.mlock, 1);
 
 	ret = of_genpd_add_provider_simple(domain->dev->of_node,

---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20250218-gpcv2-of-property-present-158f8dbfe2dc

Best regards,
-- 
Ahmad Fatoum <a.fatoum@pengutronix.de>


