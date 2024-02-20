Return-Path: <linux-pm+bounces-4167-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D88085C543
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 20:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A5D285C11
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 19:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4237314A4E1;
	Tue, 20 Feb 2024 19:56:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94CB14AD2B
	for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458965; cv=none; b=tl187LHywMFoi+DyRZs8UjBBFfaLii5Z2kEOHC2oLu7yWgLpcwgH22aPeoW7CLCZaV9kev+rPXfdmEXKPC7vvsjVtry31J6A/sDtjlnN2OWY/ZeCgxzaMryuzDX1p2C9EboYjUebwGfJGX/6UlLdE3WhySF2JWZhrWma/RD1df4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458965; c=relaxed/simple;
	bh=D5vhBstpcCoK1NqmG/Ng08m1JoYZgUtCGb/jUTKIQ7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CeYsUioLPZdctg6MYdB/0x/de1fpHlz95G3HjgyE2ym29JJZO1Pww5j1sZpXvNSTmRFpSR5tCI/KPwY7axQKiD4v5UpGVhFuOrBUmJlIzy/XswjeIIVBxZo9BH6yH5nbMfnhyyG7+7Z04Qa2EzBSOol0B1H3S9lvU2ee36Mz60E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:a66f:1f5b:42c8:e3c5])
	by xavier.telenet-ops.be with bizsmtp
	id pXvu2B00J1N8lK501Xvulp; Tue, 20 Feb 2024 20:55:54 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rcWDS-001BcU-3N;
	Tue, 20 Feb 2024 20:55:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rcWDa-009jV3-B3;
	Tue, 20 Feb 2024 20:55:54 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Andrew Davis <afd@ti.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] power: reset: rmobile-reset: Map correct MMIO resource
Date: Tue, 20 Feb 2024 20:55:53 +0100
Message-Id: <3b267fb1b303f63248934a1a77bee319e1c44879.1708458882.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The registers related to reset generation are located in the second
register block.  However, the conversion to device life-cycle managed
ioremap function accidentally changed the mapping to the first register
block.

Fixes: 0867276eb12230a5 ("power: reset: rmobile-reset: Use devm_platform_ioremap_resource() helper")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/power/reset/rmobile-reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/rmobile-reset.c b/drivers/power/reset/rmobile-reset.c
index 80265608c18e0a20..14682cd59e618d5f 100644
--- a/drivers/power/reset/rmobile-reset.c
+++ b/drivers/power/reset/rmobile-reset.c
@@ -33,7 +33,7 @@ static int rmobile_reset_probe(struct platform_device *pdev)
 {
 	int error;
 
-	sysc_base2 = devm_platform_ioremap_resource(pdev, 0);
+	sysc_base2 = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(sysc_base2))
 		return PTR_ERR(sysc_base2);
 
-- 
2.34.1


