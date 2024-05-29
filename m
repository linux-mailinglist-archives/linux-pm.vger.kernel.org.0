Return-Path: <linux-pm+bounces-8352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EFA8D32CB
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 11:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D84728344F
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 09:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041D9169AD9;
	Wed, 29 May 2024 09:19:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506F015B10C
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974357; cv=none; b=s4Ec/oX/RTCoR1BXzv/U/dY1Cw5wdO7kDPg1il6/L692z2MgXKUf81DsHYCDT0o103X1PHi6ytfVPsIaOdgL/uzrtoTxAPaTuqNL9vczdJnf09F4O5vNR2/9uxzjarMck/oJ8EP9u7Zs2jPXk7dyPhi/O6yDRLBua0nNypmOIuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974357; c=relaxed/simple;
	bh=+z7rlan5bSlBL10kfqykn34Zfbvs9qry8TjuxUsU1GA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q/bJDUjBNNnK+YEK4tenjZteLVx6xuxQTxAZYXiX/OqfnK4QS0z1OQW1n2Q7gFxXi2Kn4AH/7gaQ6CKjbcOx0FMmYmrXO18F/wcCnOA8rlv7FnipUWplU7ZKRBt9OTnLFGjOncWOG/m2IWvFU16xQ8ufDgLk62W58AXFj5y/ZEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:1b01:1838:131c:4de4])
	by baptiste.telenet-ops.be with bizsmtp
	id UxKE2C0083VPV9V01xKE1m; Wed, 29 May 2024 11:19:14 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sCFRn-00GG1d-RH;
	Wed, 29 May 2024 11:19:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sCFSk-008wDp-6T;
	Wed, 29 May 2024 11:19:14 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Lina Iyer <lina.iyer@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] pmdomain: core: Use genpd_is_irq_safe() helper
Date: Wed, 29 May 2024 11:19:12 +0200
Message-Id: <3cd8131b4f1284bdffa23a2b6a9a1e92fd17973e.1716973951.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the genpd_is_irq_safe() helper instead of open-coding the same
operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pmdomain/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 1eae7b2317897f0b..01cf17789621a04f 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2082,7 +2082,7 @@ static void genpd_free_data(struct generic_pm_domain *genpd)
 
 static void genpd_lock_init(struct generic_pm_domain *genpd)
 {
-	if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
+	if (genpd_is_irq_safe(genpd)) {
 		spin_lock_init(&genpd->slock);
 		genpd->lock_ops = &genpd_spin_ops;
 	} else {
-- 
2.34.1


