Return-Path: <linux-pm+bounces-32283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D75B24A19
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 15:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FA7583E28
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 13:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0762E4252;
	Wed, 13 Aug 2025 13:04:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B2D2D12F7;
	Wed, 13 Aug 2025 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090279; cv=none; b=jUg/bdzgJRyOrYpbEbO11VOiIgW7RJMvR/DamDbiDOKjLwXqkxmSmzfMNEmLZ+J8F7PIwVl3QjTaTCtiZJ83aYYkbrKvmE6fKQxZEbyz0euKvGelj5AXNFG0qgAPYc8upAXH4ArBJq0NNDgthCCjQBDmvoT7vCmr91c6ttSnV94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090279; c=relaxed/simple;
	bh=X8Cec3AIuOyMc1Jn46KaliDHqYIRqGtQWlpW8nU4jlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SAcAeamP7Np5vShCUE9NQmDXE4+TC+B3rry3EuXaHX6t1Tu2Pxra9CMMaQfLVBd1d5Koil6b76K+Xz4TajemTH+LabFljJ3qNJo6rpt5mIQTFN0DgR5sVc6LFc9jT0+aCxw0D+E63vhD1I21UHn4riKX9VJQmTw5hUHCfttpPA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48898C4CEEB;
	Wed, 13 Aug 2025 13:04:37 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] pmdomain: renesas: rcar-sysc: Make rcar_sysc_onecell_np __initdata
Date: Wed, 13 Aug 2025 15:04:24 +0200
Message-ID: <e20a848ff952924f8f58c335f9a0242cb2565921.1755090234.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rcar_sysc_onecell_np() is only used by functions marked __init, so it
can be freed when init memory is freed.

Fixes: c5ae5a0c61120d0c ("pmdomain: renesas: rcar-sysc: Add genpd OF provider at postcore_initcall")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pmdomain/renesas/rcar-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
index 4b310c1d35fa6bb5..2d4161170c63d07b 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-sysc.c
@@ -342,7 +342,7 @@ struct rcar_pm_domains {
 };
 
 static struct genpd_onecell_data *rcar_sysc_onecell_data;
-static struct device_node *rcar_sysc_onecell_np;
+static struct device_node *rcar_sysc_onecell_np __initdata = NULL;
 
 static int __init rcar_sysc_pd_init(void)
 {
-- 
2.43.0


