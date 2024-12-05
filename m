Return-Path: <linux-pm+bounces-18622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 289C89E5623
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 14:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82761884F8C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 13:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34815219A97;
	Thu,  5 Dec 2024 13:00:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B90217725
	for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2024 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403621; cv=none; b=CkJzv43szz8MYMiZZxqZqXHvi0+GOtbPYE3BGuq9vJKK9Sf6y1uREkL/oVcIouyr8UOC9i9c492wG/LOYvNbUDGv2QuXBg6y2XkCRiKLJmvY5qPNrkDuIKSdyWkBR8byi4I8RGtgvaFNMF9Aia+I6IYMdJzFcGVNGxtGUM6G4RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403621; c=relaxed/simple;
	bh=3ljln5UJe9l7irWjhFzX4xeezfaZfOuGZXhOz28tv20=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e1fIFpSHv/0AdM/5tgFt4fgp/zyNOJ3fXbwHxn0SOAXPiFVQuDQhaK+FSOlw8eQ89+RcPfyu8oIiwi9RULt3QJZastDEQX55TS+UQPsfSYX0xKTKteU0vKnzHgL95OqiCa88YQsVK5UFh4LZRaK4FC+QyEN7CHN1vhiKpkQPuSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b16a:6561:fa1:2b32])
	by laurent.telenet-ops.be with cmsmtp
	id l10H2D0083EEtj20110HeS; Thu, 05 Dec 2024 14:00:17 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tJBSq-000LP1-AE;
	Thu, 05 Dec 2024 14:00:17 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tJBSr-00EQH8-1S;
	Thu, 05 Dec 2024 14:00:17 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Saravana Kannan <saravanak@google.com>
Cc: linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] pmdomain: renesas: rcar-sysc: Drop fwnode_dev_initialized() call
Date: Thu,  5 Dec 2024 14:00:15 +0100
Message-Id: <087ef57d899c93f45ceffb8f9c5df3ad850b1e85.1733403513.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of commit bab2d712eeaf9d60 ("PM: domains: Mark fwnodes when their
powerdomain is added/removed") in v5.12, the pmdomain core takes care of
marking the fwnode initialized, so there is no need to repeat it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pmdomain/renesas/rcar-sysc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
index b99326917330f5f1..dce1a6d37e80127d 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-sysc.c
@@ -434,8 +434,6 @@ static int __init rcar_sysc_pd_init(void)
 	}
 
 	error = of_genpd_add_provider_onecell(np, &domains->onecell_data);
-	if (!error)
-		fwnode_dev_initialized(of_fwnode_handle(np), true);
 
 out_put:
 	of_node_put(np);
-- 
2.34.1


