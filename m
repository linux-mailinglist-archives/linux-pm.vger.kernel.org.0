Return-Path: <linux-pm+bounces-26321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 973B9A9EFD9
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 13:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1C23BE789
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 11:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7689263F52;
	Mon, 28 Apr 2025 11:56:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF3B1CD213
	for <linux-pm@vger.kernel.org>; Mon, 28 Apr 2025 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841414; cv=none; b=sjUE6CirqC77km+Syc+0zkn3yFc6ru0PgA0m1EyXBOrWjskMciVmC7DYyaBUbSmqhfKK3QV1HzOr+4U07pc1t6yJRMIkGHj+3D5WEQY6YpDjlsG1l0jTs3Bl7DjqsxsUJovFFd/4ePtauX8udoAknygHL1ORTC+qin49uRxNkkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841414; c=relaxed/simple;
	bh=1j9Q9kgQUWse/o+zJq0jmjKW3JS0XwJpa9IMv5SRAVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RyOzhbZw8tUmzmfbjGDqG0vI5rMctAE2dRBO7FCIIK6KwcVG/3oydmAX3AewGx+or55DOep3+U6FZMHT9Jd5Sx3Y/doRAEjovcdMRMKwiFEkvechTE8W65raM46/lmxZNDxeG2Av+YECGmesAB6tCg3Ckcpfy8qstoJXDJCIAlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4ZmMP90hzkz4x3ks
	for <linux-pm@vger.kernel.org>; Mon, 28 Apr 2025 13:56:45 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b9c4:1670:abc0:a1fc])
	by michel.telenet-ops.be with cmsmtp
	id ibwc2E0084Aed8c06bwco7; Mon, 28 Apr 2025 13:56:36 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1u9N6B-00000000F7P-0oNs;
	Mon, 28 Apr 2025 13:56:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1u9Mxl-00000006xAj-2x3k;
	Mon, 28 Apr 2025 13:47:53 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] pmdomain: renesas: rcar: Remove obsolete nullify checks
Date: Mon, 28 Apr 2025 13:47:52 +0200
Message-ID: <107f2bf9f13b29f0f623d2959a5347ec151fb089.1745840768.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All nullify users and helpers were removed, but the R-Car SYSC drivers
still checked for nullified domains.  Remove the obsolete checks.

Fixes: c8d87704444a8ac7 ("pmdomain: renesas: rcar-sysc: Remove rcar_sysc_nullify() helper")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pmdomain/renesas/rcar-gen4-sysc.c | 5 -----
 drivers/pmdomain/renesas/rcar-sysc.c      | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/drivers/pmdomain/renesas/rcar-gen4-sysc.c b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
index 66409cff2083fcd8..e001b5c25bed0051 100644
--- a/drivers/pmdomain/renesas/rcar-gen4-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
@@ -338,11 +338,6 @@ static int __init rcar_gen4_sysc_pd_init(void)
 		struct rcar_gen4_sysc_pd *pd;
 		size_t n;
 
-		if (!area->name) {
-			/* Skip NULLified area */
-			continue;
-		}
-
 		n = strlen(area->name) + 1;
 		pd = kzalloc(sizeof(*pd) + n, GFP_KERNEL);
 		if (!pd) {
diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
index dce1a6d37e80127d..047495f54e8adc0d 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-sysc.c
@@ -396,11 +396,6 @@ static int __init rcar_sysc_pd_init(void)
 		struct rcar_sysc_pd *pd;
 		size_t n;
 
-		if (!area->name) {
-			/* Skip NULLified area */
-			continue;
-		}
-
 		n = strlen(area->name) + 1;
 		pd = kzalloc(sizeof(*pd) + n, GFP_KERNEL);
 		if (!pd) {
-- 
2.43.0


