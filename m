Return-Path: <linux-pm+bounces-38363-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CE6C79149
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 13:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D18CD364107
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 12:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DE133291F;
	Fri, 21 Nov 2025 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AyMBh7tX"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FC4314D31;
	Fri, 21 Nov 2025 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763729540; cv=none; b=F3sinYRxTZL0ZY45a8Fyz4ljgdJw1kEBOXtIK5pIsbN3BBPQtzGph6Tm+ODVV9tFO1B7Da6QdcUVVvjZ3mWOK0+QZ0BGe+HuAQV4S5vZqUi5uOyD0pjdloubN4bDWbcsYnA5knSPkn5G6daSry1fXJ5DhSc2kG8gkaDBGC0pRBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763729540; c=relaxed/simple;
	bh=shy6MzZU9wcGSmhy1yW9Nhob1xPf/NK+z+tKPMSJ5GI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q5msTrnsbFbDxZiAeqk0QITIh50y5HrXAleJaxF5Hrm4WDVjvmfsdASTHJFm9HeiLFEmTXYHP/O/JDZMNXN/9+ybIZhHaAjI4jlAj71yCAIqrj/uPRcpCRsUskGQIT9IbjBRsYKMdxJYdZNFtNz0P3dZhCm6kD18pM5Jpm1x6Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AyMBh7tX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763729535;
	bh=shy6MzZU9wcGSmhy1yW9Nhob1xPf/NK+z+tKPMSJ5GI=;
	h=From:To:Cc:Subject:Date:From;
	b=AyMBh7tX30idUdyAD6WcSGT9101hU8/GehXpTKZrFjBIrHEBgcOepR41BQxtSQil3
	 RKrnt0IHGoE4U1VqUqR1qm7SRSkASqugtDQ01z2uGhCTt72XruFPR6PW1Xlno/stOx
	 1J5sJIsSXLaVlNFL66WNpvf8O/g06c2kOLRxum+6Jpu6rCazmthu1+/BDgGULXcAVX
	 6P1NG0mWTWjETlGGoHudNJFND+dgduviIN7Gl2IYjV601X+Hh8S5TV2dFNF/5OgtHg
	 fXBAIwQp9Vo+OwmAcBWcV2+wu4Ul/wUJNlczp0OGxEVd8IjUyKIDSKDFG9+wAEe75I
	 6gBc3HBsT9nvw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0381D17E0222;
	Fri, 21 Nov 2025 13:52:14 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: ulf.hansson@linaro.org
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	nfraprado@collabora.com,
	irving-ch.lin@mediatek.com,
	wenst@chromium.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	robh@kernel.org,
	krzk@kernel.org,
	conor@kernel.org,
	kernel@collabora.com
Subject: [PATCH - URGENT] pmdomains: mtk-pm-domains: Fix spinlock recursion in probe
Date: Fri, 21 Nov 2025 13:52:12 +0100
Message-ID: <20251121125212.43093-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some reason, of_find_node_with_property() is creating a spinlock
recursion issue along with fwnode_count_parents(), and this issue
is making all MediaTek boards unbootable.

As of kernel v6.18-rc6, there are only three users of this function,
one of which is this driver.

Migrate away from of_find_node_with_property() by adding a local
scpsys_get_legacy_regmap_node() function, which acts similarly to
of_find_node_with_property(), and calling the former in place of
the latter.

This resolves the following spinlock recursion issue:

[    1.773979] BUG: spinlock recursion on CPU#2, kworker/u24:1/60
[    1.790485]  lock: devtree_lock+0x0/0x40, .magic: dead4ead, .owner: kworker/u24:1/60, .owner_cpu: 2
[    1.791644] CPU: 2 UID: 0 PID: 60 Comm: kworker/u24:1 Tainted: G        W           6.18.0-rc6 #3 PREEMPT
[    1.791649] Tainted: [W]=WARN
[    1.791650] Hardware name: MediaTek Genio-510 EVK (DT)
[    1.791653] Workqueue: events_unbound deferred_probe_work_func
[    1.791658] Call trace:
[    1.791659]  show_stack+0x18/0x30 (C)
[    1.791664]  dump_stack_lvl+0x68/0x94
[    1.791668]  dump_stack+0x18/0x24
[    1.791672]  spin_dump+0x78/0x88
[    1.791678]  do_raw_spin_lock+0x110/0x140
[    1.791684]  _raw_spin_lock_irqsave+0x58/0x6c
[    1.791690]  of_get_parent+0x28/0x74
[    1.791694]  of_fwnode_get_parent+0x38/0x7c
[    1.791700]  fwnode_count_parents+0x34/0xf0
[    1.791705]  fwnode_full_name_string+0x28/0x120
[    1.791710]  device_node_string+0x3e4/0x50c
[    1.791715]  pointer+0x294/0x430
[    1.791718]  vsnprintf+0x21c/0x5bc
[    1.791722]  vprintk_store+0x108/0x47c
[    1.791728]  vprintk_emit+0xc4/0x350
[    1.791732]  vprintk_default+0x34/0x40
[    1.791736]  vprintk+0x24/0x30
[    1.791740]  _printk+0x60/0x8c
[    1.791744]  of_node_release+0x154/0x194
[    1.791749]  kobject_put+0xa0/0x120
[    1.791753]  of_node_put+0x18/0x28
[    1.791756]  of_find_node_with_property+0x74/0x100
[    1.791761]  scpsys_probe+0x338/0x5e0
[    1.791765]  platform_probe+0x5c/0xa4
[    1.791770]  really_probe+0xbc/0x2ac
[    1.791774]  __driver_probe_device+0x78/0x118
[    1.791779]  driver_probe_device+0x3c/0x170
[    1.791783]  __device_attach_driver+0xb8/0x150
[    1.791788]  bus_for_each_drv+0x88/0xe8
[    1.791792]  __device_attach+0x9c/0x1a0
[    1.791796]  device_initial_probe+0x14/0x20
[    1.791801]  bus_probe_device+0xa0/0xa4
[    1.791805]  deferred_probe_work_func+0x88/0xd0
[    1.791809]  process_one_work+0x1e8/0x448
[    1.791813]  worker_thread+0x1ac/0x340
[    1.791816]  kthread+0x138/0x220
[    1.791821]  ret_from_fork+0x10/0x20

Fixes: c29345fa5f66 ("pmdomain: mediatek: Refactor bus protection regmaps retrieval")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

This might not be the best fix to perform, and I have Cc'ed Rob and
Krzysztof for them to have a look at the spinlock recursion issue,
as I think it either has to be fixed, or the affected function has
to be removed (or both, actually - in any case, if not fixed, this
could backfire, and I'm not sure that the only function that shows
this issue is just only of_find_node_with_property() or if others
also do; at least, nothing else on MediaTek machines as of now).

Counting that this makes *all* MediaTek machines to be unbootable,
I'd prefer this fix to get merged immediately - so that it lands
in v6.18 (which is at rc6 at the time of writing).

That - because I think that resolving the source of this issue will
take a bit of time and research - and I really don't want the LTS
kernel to be broken on all MediaTek devices.

Note: When I initially tested the commit pointed out in the Fixes
tag, it was working with no spinlock recursion - I don't clearly
remember what kernel version was that, but I think it was some
linux-next around v6.16 or v6.17.

 drivers/pmdomain/mediatek/mtk-pm-domains.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 407b4a7aba10..721224c89865 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -1006,6 +1006,18 @@ static void scpsys_domain_cleanup(struct scpsys *scpsys)
 	}
 }
 
+static struct device_node *scpsys_get_legacy_regmap(struct device_node *np, const char *pn)
+{
+	struct device_node *local_node;
+
+	for_each_child_of_node(np, local_node) {
+		if (of_property_present(local_node, pn))
+			return local_node;
+	}
+
+	return NULL;
+}
+
 static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *scpsys)
 {
 	const u8 bp_blocks[3] = {
@@ -1027,7 +1039,7 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
 	 * this makes it then possible to allocate the array of bus_prot
 	 * regmaps and convert all to the new style handling.
 	 */
-	node = of_find_node_with_property(np, "mediatek,infracfg");
+	node = scpsys_get_legacy_regmap(np, "mediatek,infracfg");
 	if (node) {
 		regmap[0] = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg");
 		of_node_put(node);
@@ -1040,7 +1052,7 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
 		regmap[0] = NULL;
 	}
 
-	node = of_find_node_with_property(np, "mediatek,smi");
+	node = scpsys_get_legacy_regmap(np, "mediatek,smi");
 	if (node) {
 		smi_np = of_parse_phandle(node, "mediatek,smi", 0);
 		of_node_put(node);
@@ -1058,7 +1070,7 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
 		regmap[1] = NULL;
 	}
 
-	node = of_find_node_with_property(np, "mediatek,infracfg-nao");
+	node = scpsys_get_legacy_regmap(np, "mediatek,infracfg-nao");
 	if (node) {
 		regmap[2] = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg-nao");
 		num_regmaps++;
-- 
2.51.2


