Return-Path: <linux-pm+bounces-14834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A9C987921
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 20:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080731C21702
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 18:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA36F16131A;
	Thu, 26 Sep 2024 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="KuodYhZL"
X-Original-To: linux-pm@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-73.smtpout.orange.fr [80.12.242.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA4C1534E6;
	Thu, 26 Sep 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727375648; cv=none; b=OYIUEvV+hFqgtrV0qLxnnLPJvUUlI1Vn0RiSazqQlf9ORajuDmMZDnUQZTuEiJ1LAWx9XzfeJ/C+0b4zjtI+38KplxJQg+MaojDneEtMEUrkr59zqPL2wILiVewafEJzFIT/DgvHKDE7jcgJmMacOTUg87CoOylkY4PumPx4mgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727375648; c=relaxed/simple;
	bh=3iuHCMpCaY/5WFrJneLSrvAgOGDV6yGyGWwA8luU3GI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NubtrGF1sQM1N3vwrf+EUrg8PRKm/v/eBB2zxceTiMIclKzvruKWMJAZGS0JyrOaOUSTFjisic9d9BdXbD3sGqDjv01w2e4WFwfFbOosCAxgj0tvG7wmfd3r1/5yAWJx7Nwp16j3gCeEZaC1/R3Aj12L0zjgT5Im9CBW1f3Oisk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=KuodYhZL; arc=none smtp.client-ip=80.12.242.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id ttJMsN3PhfghUttJMstZV4; Thu, 26 Sep 2024 20:33:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1727375637;
	bh=3QlM06zztQktN3NIJ4DxdnB67HniBEmCvi/NMR3NrVA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=KuodYhZLbK4ZwM/vRiKVcRr+eCUZHWcwycWMRPW63AFa5JtMzyAhZ9aOCFOpkvq9A
	 Z3PCZBnRBd5eLqYNbVvCCcUfSBjq0Y8xjfe6JIUqxl2PJjs8IJOqd2lsBNN2wiNAdN
	 7KgSUgrYFEhT/8eyy9bkLTQXVUiZP46KifQwWNMtS0KVQyZmoGIwty/mQVVQ7G4OXM
	 7z/WfWuuj9haGD92O2WG4Rb8uB4/fsMqD2QnTRE6ClNg97AggiRis54/Ty0I8YTKSZ
	 OoaHlyz5fZ4+86NlJr6hUj0sv6GjNQtsdBGuQPiBOr70cIP6C5ooN0Xz4GxPel+C6E
	 u5ZKrk24ih9yA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 26 Sep 2024 20:33:57 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org
Subject: [PATCH] interconnect: Remove a useless kfree_const() usage
Date: Thu, 26 Sep 2024 20:33:49 +0200
Message-ID: <06630f9ec3e153d0e7773b8d97a17e7c53e0d606.1727375615.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"path->name" is allocated in of_icc_get_by_index() using kasprintf(), so
there is no point in using kfree_const() to free it.

Switch to the more standard kfree() to free this.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

This is not a bug fix.
kfree_const() works fine here, but is useless. It is equivalent to kfree().

Before commit 1597d453289b3 ("interconnect: Add of_icc_get_by_index()
helper function"), using kfree_const() was needed.

For the records, this patch is a clean-up effort related to discussions at:
  - https://lore.kernel.org/all/ZvHurCYlCoi1ZTCX@skv.local/
  - https://lore.kernel.org/all/20240924050937.697118-1-senozhatsky@chromium.org/
---
 drivers/interconnect/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 7e9b996b47c8..8a993283da82 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -808,7 +808,7 @@ void icc_put(struct icc_path *path)
 	mutex_unlock(&icc_bw_lock);
 	mutex_unlock(&icc_lock);
 
-	kfree_const(path->name);
+	kfree(path->name);
 	kfree(path);
 }
 EXPORT_SYMBOL_GPL(icc_put);
-- 
2.46.1


