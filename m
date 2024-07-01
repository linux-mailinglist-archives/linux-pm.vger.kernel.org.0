Return-Path: <linux-pm+bounces-10302-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FA291E91C
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 22:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC292829B6
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 20:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E9E16F0E1;
	Mon,  1 Jul 2024 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="NXYBi3ru"
X-Original-To: linux-pm@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-217.smtpout.orange.fr [193.252.23.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D4185934;
	Mon,  1 Jul 2024 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864136; cv=none; b=AzspceaoIHzY2YsPqrM1k5Mjf85N4nn9Fwf5Aq6KKcEBKWG+LLOyd8KrNhxAm+fphwxQVgExIRamb3eSkTdBNhkZM6XY8uMioVveOCjX1vX5f2iNTbjM3rKVTpedh4SYDDbhh9gSAmLYcDpIA1hCwOqzm4azA29mmFkMLahm2uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864136; c=relaxed/simple;
	bh=jQdOwtAk9sV1JIpaAlSIWJ8MY68481iecsUhvG2Hxgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gHBTLQgflNVACQ43BNSEqjsm+QjvDXgwUXt3z2wfCLDWmhH6yliuZ6eH/1ZcUJKYN1H3yVHsnfpBKVB9St8zQKfK56quwPEE0OkhDlM0VSGwpMBsIemLUGT5Y6c2JitODrLGCyu6f4tvyLbeeVhKk7TZhvawriPHSRQzGWLz2tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=NXYBi3ru; arc=none smtp.client-ip=193.252.23.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.. ([77.131.3.81])
	by smtp.orange.fr with ESMTPA
	id ON5TsnKqM3PPAON5UsfK1q; Mon, 01 Jul 2024 21:53:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1719863602;
	bh=vMCou+9uf+uUUkz293F72Wo3DfglK/VKpyr7CR/9w3U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=NXYBi3ruSXep/nOHyr+39Y8bVRoQF5zRRgVKeRE8wLAKdSURmXLuOLqLtoeEsboPF
	 N6AsQOovL4wUDg0jNvKE9klGF1eYYaBC2KRGO/smC/Hb6FvGLz5EK5yHT/bSb+yTls
	 nbKfFEjqfavg8m0Q41i7KL/YmYOBR2ImU/8Kjf2xBFvmkSa76Acd78iwQAdknj5DGE
	 cadz5geCbOHj4IvlYkiib9bSlNicnSZfNZdKjFgROt3FJCOc4waI9wKcetGq4sP+d5
	 GKh/MQ7jM1gU1YkbNk8k6s4xFG5gbus7a+L/JktoNlPL+x7WF0J0dENDlY1td0OtV5
	 ixu41dYZWgGPA==
X-ME-Helo: fedora..
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 01 Jul 2024 21:53:22 +0200
X-ME-IP: 77.131.3.81
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
Subject: [PATCH] pmdomain: amlogic: Constify struct meson_secure_pwrc_domain_desc
Date: Mon,  1 Jul 2024 21:53:16 +0200
Message-ID: <871d6b708de8bb42e1fabd8a601dc9a9a217cf00.1719863475.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct meson_secure_pwrc_domain_desc' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   4909	   4072	      0	   8981	   2315	drivers/pmdomain/amlogic/meson-secure-pwrc.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   8605	    392	      0	   8997	   2325	drivers/pmdomain/amlogic/meson-secure-pwrc.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.

The .is_off() function is *always* set as pwrc_secure_is_off(), so it could
make sense to remove this function pointer and call pwrc_secure_is_off()
directly when needed.
This would save some memory and useless indirection.

I leave it as-is because it is maybe here for future use.
---
 drivers/pmdomain/amlogic/meson-secure-pwrc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
index df5567418226..62857482f874 100644
--- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
+++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
@@ -46,7 +46,7 @@ struct meson_secure_pwrc_domain_desc {
 
 struct meson_secure_pwrc_domain_data {
 	unsigned int count;
-	struct meson_secure_pwrc_domain_desc *domains;
+	const struct meson_secure_pwrc_domain_desc *domains;
 };
 
 static bool pwrc_secure_is_off(struct meson_secure_pwrc_domain *pwrc_domain)
@@ -110,7 +110,7 @@ static int meson_secure_pwrc_on(struct generic_pm_domain *domain)
 	.parent = __parent,			\
 }
 
-static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
+static const struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
 	SEC_PD(DSPA,	0),
 	SEC_PD(DSPB,	0),
 	/* UART should keep working in ATF after suspend and before resume */
@@ -137,7 +137,7 @@ static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
 	SEC_PD(RSA,	0),
 };
 
-static struct meson_secure_pwrc_domain_desc a4_pwrc_domains[] = {
+static const struct meson_secure_pwrc_domain_desc a4_pwrc_domains[] = {
 	SEC_PD(A4_AUDIO,	0),
 	SEC_PD(A4_SDIOA,	0),
 	SEC_PD(A4_EMMC,	0),
@@ -155,7 +155,7 @@ static struct meson_secure_pwrc_domain_desc a4_pwrc_domains[] = {
 	SEC_PD(A4_AO_IR,	GENPD_FLAG_ALWAYS_ON),
 };
 
-static struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
+static const struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
 	SEC_PD(C3_NNA,		0),
 	SEC_PD(C3_AUDIO,	0),
 	SEC_PD(C3_SDIOA,	0),
@@ -172,7 +172,7 @@ static struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
 	SEC_PD(C3_VCODEC,	0),
 };
 
-static struct meson_secure_pwrc_domain_desc s4_pwrc_domains[] = {
+static const struct meson_secure_pwrc_domain_desc s4_pwrc_domains[] = {
 	SEC_PD(S4_DOS_HEVC,	0),
 	SEC_PD(S4_DOS_VDEC,	0),
 	SEC_PD(S4_VPU_HDMI,	0),
@@ -184,7 +184,7 @@ static struct meson_secure_pwrc_domain_desc s4_pwrc_domains[] = {
 	SEC_PD(S4_AUDIO,	0),
 };
 
-static struct meson_secure_pwrc_domain_desc t7_pwrc_domains[] = {
+static const struct meson_secure_pwrc_domain_desc t7_pwrc_domains[] = {
 	SEC_PD(T7_DSPA,		0),
 	SEC_PD(T7_DSPB,		0),
 	TOP_PD(T7_DOS_HCODEC,	0, PWRC_T7_NIC3_ID),
-- 
2.45.2


