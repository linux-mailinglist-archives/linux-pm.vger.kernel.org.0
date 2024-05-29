Return-Path: <linux-pm+bounces-8353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A65018D32CF
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 11:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6211E284278
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 09:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0A215B10C;
	Wed, 29 May 2024 09:20:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80157169AE6
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974426; cv=none; b=tR77xt7qoxQz2LIEPuJe8NVpF8oIldsvnsCEOFP2/qxQLmwrnjzpPPFPrKWhhyNvOW0NS8fd2UP4EJ8AJzllsacc7B2Mq/pTW0i3u2UDpFVZBmPnTajNI9HoD3Akm7FXGQqKQ8q18d++zAC1lQuQSB3siZ1h+jnuiL3wk0ZjZi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974426; c=relaxed/simple;
	bh=uowYDMqIB1KmJevzx4fTL6lHelcSpl7NP7eoM23uqFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K49pRHUcYehYfnUMwcdyK/54RVqzgtJ3hYyep9EX9uFwgXom3wGD6kWWrx0qZsx4DDQObBzqc7tYAFZgAcACR8XjDx7Xqma2g4ugJXc4Te1rtuG0sh6EABXJVncJvqr6rzGg/RvTc/gPoKyKxUwi3R2CyLuMRsbNAdH8XUmhJ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:1b01:1838:131c:4de4])
	by albert.telenet-ops.be with bizsmtp
	id UxLM2C0043VPV9V06xLM7B; Wed, 29 May 2024 11:20:21 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sCFSs-00GGAG-Q4;
	Wed, 29 May 2024 11:20:21 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sCFTp-008wFX-6j;
	Wed, 29 May 2024 11:20:21 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] pmdomain: renesas: rmobile-sysc: Use for_each_child_of_node_scoped()
Date: Wed, 29 May 2024 11:20:20 +0200
Message-Id: <5e684d7b236904e5f79324a5e5357c2930f7402d.1716974368.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the scoped variant of for_each_child_of_node() to simplify cleanup
handling.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pmdomain/renesas/rmobile-sysc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/renesas/rmobile-sysc.c b/drivers/pmdomain/renesas/rmobile-sysc.c
index cc1f6f8b7a746850..5a1d2da465fb2c6f 100644
--- a/drivers/pmdomain/renesas/rmobile-sysc.c
+++ b/drivers/pmdomain/renesas/rmobile-sysc.c
@@ -237,9 +237,7 @@ static int __init rmobile_add_pm_domains(void __iomem *base,
 					 struct device_node *parent,
 					 struct generic_pm_domain *genpd_parent)
 {
-	struct device_node *np;
-
-	for_each_child_of_node(parent, np) {
+	for_each_child_of_node_scoped(parent, np) {
 		struct rmobile_pm_domain *pd;
 		u32 idx = ~0;
 
@@ -248,10 +246,8 @@ static int __init rmobile_add_pm_domains(void __iomem *base,
 		}
 
 		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
-		if (!pd) {
-			of_node_put(np);
+		if (!pd)
 			return -ENOMEM;
-		}
 
 		pd->genpd.name = np->name;
 		pd->base = base;
-- 
2.34.1


