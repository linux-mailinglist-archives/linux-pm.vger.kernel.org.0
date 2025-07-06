Return-Path: <linux-pm+bounces-30219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF101AFA642
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 17:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96908189AC1E
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 15:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78827287275;
	Sun,  6 Jul 2025 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="WpBgGGCF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC2D846F;
	Sun,  6 Jul 2025 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751817286; cv=none; b=Bu3GPjnt9G7s/dYVfLGN2tDCvtLawbCUZZUpRKwVLt3WdHmtJ3dD6iokr2E8jvv7OOFptxnJOSDt9QHGUosi7BZxPVMG8d1Ze1Z8FqXCYBcpQEUA3QXT+GvwPfBhrYjglGOfTox+U8r633aakmGUqEGLsrm3F0pQwnz67yL+Yog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751817286; c=relaxed/simple;
	bh=fzgZPmvyICN22YUTfz2+nBgVgTiZq7GyaHWCGVDWIwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qDwXCfPRUW8jjWcy/YrPJpcxext7q5IVCRorWB1lLJlmqdEcePw7fDhBZwbRLwbylde8niWwykiIXbaKOUg8Jm5OTa8G4gO/kD88X7GHqNoIHCu3R5YmTqNhk3Qe/cfOnUndKgFhl7mn/mJuWAU5t63Mq0kxiQnmqULGGWrFY/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=WpBgGGCF; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id YRYluars3Th6NYRYluaK11; Sun, 06 Jul 2025 17:45:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1751816744;
	bh=Usl6H/nBtIdNWk85VvCvQgapH1XWWJZiBzQZgQJqsc0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=WpBgGGCFmow0oQIz7lEbxTEUnoCkbYoEcfTdvX/txtOTWtzj8srDrSJmFh/sTMrxg
	 lcteRfLOmO+XuBK1WftkCUmOPbb6EUj/OpqOe10NI5Q3hQvFNeOZgkth1i5EE7XJC5
	 sRGw3La2irDJwYQ7MKbl/BMTRr6UJ+wgy96HhKcx187G7G9cqMAbQRlF/YBMC4Ij2h
	 kqBUQLRDeJ+c5P2TVhMpHSi3WgL+4NR3b14qMNxv/zfGYVHJD+e8lTALlQOa0CH4PG
	 f3eKwkV3ucYuQqWTfnrqE1QimImOtZUCo9QzmAoofhGCVsrT0gRIpjYiTMwr41goKE
	 Tgzz6j7HW3tJQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 06 Jul 2025 17:45:44 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH] pmdomain: amlogic: Constify struct meson_secure_pwrc_domain_data
Date: Sun,  6 Jul 2025 17:45:41 +0200
Message-ID: <e71abd8d75dd842690e5a11e38037bcf5feac189.1751816732.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct meson_secure_pwrc_domain_data' are not modified in these drivers.

Constifying these structures moves some data to a read-only section, so
increases overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   9248	    408	      0	   9656	   25b8	drivers/pmdomain/amlogic/meson-secure-pwrc.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   9344	    304	      0	   9648	   25b0	drivers/pmdomain/amlogic/meson-secure-pwrc.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/pmdomain/amlogic/meson-secure-pwrc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
index ff76ea36835e..e8bda60078c4 100644
--- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
+++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
@@ -342,32 +342,32 @@ static int meson_secure_pwrc_probe(struct platform_device *pdev)
 	return of_genpd_add_provider_onecell(pdev->dev.of_node, &pwrc->xlate);
 }
 
-static struct meson_secure_pwrc_domain_data meson_secure_a1_pwrc_data = {
+static const struct meson_secure_pwrc_domain_data meson_secure_a1_pwrc_data = {
 	.domains = a1_pwrc_domains,
 	.count = ARRAY_SIZE(a1_pwrc_domains),
 };
 
-static struct meson_secure_pwrc_domain_data amlogic_secure_a4_pwrc_data = {
+static const struct meson_secure_pwrc_domain_data amlogic_secure_a4_pwrc_data = {
 	.domains = a4_pwrc_domains,
 	.count = ARRAY_SIZE(a4_pwrc_domains),
 };
 
-static struct meson_secure_pwrc_domain_data amlogic_secure_a5_pwrc_data = {
+static const struct meson_secure_pwrc_domain_data amlogic_secure_a5_pwrc_data = {
 	.domains = a5_pwrc_domains,
 	.count = ARRAY_SIZE(a5_pwrc_domains),
 };
 
-static struct meson_secure_pwrc_domain_data amlogic_secure_c3_pwrc_data = {
+static const struct meson_secure_pwrc_domain_data amlogic_secure_c3_pwrc_data = {
 	.domains = c3_pwrc_domains,
 	.count = ARRAY_SIZE(c3_pwrc_domains),
 };
 
-static struct meson_secure_pwrc_domain_data meson_secure_s4_pwrc_data = {
+static const struct meson_secure_pwrc_domain_data meson_secure_s4_pwrc_data = {
 	.domains = s4_pwrc_domains,
 	.count = ARRAY_SIZE(s4_pwrc_domains),
 };
 
-static struct meson_secure_pwrc_domain_data amlogic_secure_t7_pwrc_data = {
+static const struct meson_secure_pwrc_domain_data amlogic_secure_t7_pwrc_data = {
 	.domains = t7_pwrc_domains,
 	.count = ARRAY_SIZE(t7_pwrc_domains),
 };
-- 
2.50.0


