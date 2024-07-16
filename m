Return-Path: <linux-pm+bounces-11181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA75D9333D3
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 23:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F73289CD6
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 21:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3CE770F5;
	Tue, 16 Jul 2024 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZzKBycZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCBB224D2;
	Tue, 16 Jul 2024 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721166505; cv=none; b=InI5vBosOdsr8wgDVt9578SOS6Atg1ekZ8Q1TeoauEcR0TDNYQyhNz2tBCEgO9EXg4W9CRi34nbxXP8fvb50xTFNX9OnXUwL/oF5A/LErXrJ3EHVZEyDpLw3wnfCKuGyDA4lw3TxMhn6dHDSxSUH3aIfGD1XsdW+vCYDr394m7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721166505; c=relaxed/simple;
	bh=/03veJJ18CFeaEDpWrM3IE9z8xd892V8TxX5ZFhZV98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jpRqQ779FRK214qJgpSQLqHa301PgVkcm+ckXd6/Jo16uJNm0DwyiriQjSom2zdi1a9w3Twc7KZ+V1A4P5iWLWK4IYbHKQQyRf9NOwyHVtIww5eClPucokTz7h2/qXxfzVuPGbmTADfgJrbRI5vxb21r8ar7arRXHAtco/6ht/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZzKBycZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE502C116B1;
	Tue, 16 Jul 2024 21:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721166504;
	bh=/03veJJ18CFeaEDpWrM3IE9z8xd892V8TxX5ZFhZV98=;
	h=From:To:Cc:Subject:Date:From;
	b=GZzKBycZ3xqZ2lsfqSReSxejKOObPhoNc7D6TcPMVwoVmMKB7bwqt4naOR34oCXPK
	 aBw5gKhTaT63M9+BMQQNAX194NiDkVUmOnQdv+njzIiqCjLy4wD2JPz5GtW8HckpPn
	 aLPB2mid/YuX5dOXSS+ZENheup3+JhmT2Is7mHzseyhc27JUSMYWtvpGqCkd4My2gD
	 gSww2IakpUYw/GPG/MjRJ1C5cuajVflvnnixbmeirCIkGPSA4tPNayKXzrxP1YQe5D
	 YQ38IjW696+96aGcB5rpQFIzVK6Mxmqms+ciEBJ3zt2pGN1Lg2naU5K53dln7o2ibb
	 wfTHzmyagVImQ==
From: Kees Cook <kees@kernel.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-pm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] interconnect: icc-clk: Add missed num_nodes initialization
Date: Tue, 16 Jul 2024 14:48:23 -0700
Message-Id: <20240716214819.work.328-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378; i=kees@kernel.org; h=from:subject:message-id; bh=/03veJJ18CFeaEDpWrM3IE9z8xd892V8TxX5ZFhZV98=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmluqnQmQ87HfSEbjFPpg5A22ZhF1jpnObToQ1r sCdtJQni5yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZpbqpwAKCRCJcvTf3G3A JqjED/96TKqtYdPMANtgTDXmpPpCfaPtWkBV6mgf0kdH0TQMEjWfpvzfkJDs+T+asURsHqt4fwo /yt/HTCKURs94/gphAN9aptmjd2qreCtscCax5xSn+9YLMKQtXq2VEmTQ5gO4DOPtb6ml7Gbkof rwkK0dnA+FPyyOPwpmWVc0ti31iVIHFzLPv9YrijlfJdNZQvdHBmmLjPxSxL/7VkO6yqRyI8X3J YTIVsz0Hb8VV4/Rc6RAULoeNI8vgvctBMzVN0ZYDTX1fiYu0Feifp/jAi7PqXE8Re0SX1dG42zV DRX/vyPk8yn7Pw4rfzx5HJ2yGEpoKgwA7ty8jv+vDmGyLeR/ZkG/9QmTNVxK9+XWoMYb9WPojOE Ovt8YGD126FlYGIDmrBm9/tQ4oRVuZbypLIHg76qguTvXLoC8jD7shDDwJ4djBTYg/dIxdcfuJR fgPQ+CXB04icxmpm5Vb6dE7SEfta7FhkQC0hNSgV42ehCJdbOYwPQnu8YzXUbaVaopFf/LJduqr QAp/RsnVXAkKwtJhvvtaq9Fn9mQ8hlkTvb2dMA3GEOfgkQut92BnKRC8QQ4R7/aLwyaOaxZUqaa epBnI0C1VMmzsbk2qkAaSZ8rLTM1FhizcP6OJTR8mTLrKhPqMUlDXX4J/B+xheJE86kIMzM6eCF KYZz2MTftmvX1
 ag==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

With the new __counted_by annotation, the "num_nodes" struct member must
be set before accessing the "nodes" array. This initialization was done
in other places where a new struct icc_onecell_data is allocated, but this
case in icc_clk_register() was missed. Set "num_nodes" after allocation.

Fixes: dd4904f3b924 ("interconnect: qcom: Annotate struct icc_onecell_data with __counted_by")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/interconnect/icc-clk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
index f788db15cd76..b956e4050f38 100644
--- a/drivers/interconnect/icc-clk.c
+++ b/drivers/interconnect/icc-clk.c
@@ -87,6 +87,7 @@ struct icc_provider *icc_clk_register(struct device *dev,
 	onecell = devm_kzalloc(dev, struct_size(onecell, nodes, 2 * num_clocks), GFP_KERNEL);
 	if (!onecell)
 		return ERR_PTR(-ENOMEM);
+	onecell->num_nodes = 2 * num_clocks;
 
 	qp = devm_kzalloc(dev, struct_size(qp, clocks, num_clocks), GFP_KERNEL);
 	if (!qp)
@@ -133,8 +134,6 @@ struct icc_provider *icc_clk_register(struct device *dev,
 		onecell->nodes[j++] = node;
 	}
 
-	onecell->num_nodes = j;
-
 	ret = icc_provider_register(provider);
 	if (ret)
 		goto err;
-- 
2.34.1


