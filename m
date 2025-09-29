Return-Path: <linux-pm+bounces-35552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F20BA907B
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 13:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D3F189F914
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 11:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED6B3002DB;
	Mon, 29 Sep 2025 11:32:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC69580604;
	Mon, 29 Sep 2025 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145563; cv=none; b=nGpyORSEm0sCHL/uwgoMAmdlH1zKqxxinEj7SlBSe7/N3IA/WbPKlRUuZLYj0wv2KGNihhI4uRxl1TriBAjGSZJ3es/N4lezCJx8XTkzzG+Kln2dLkUkN43PW7ug1LHkgy4D8bOAjJfl4AFtX7BknfmO3Q6VNn0UX1nrg9xIMbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145563; c=relaxed/simple;
	bh=j1hgruf19Bk7TIvpnDeT1bG+zMoRrOYhbdPE2oVnSB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRSNHnk2hY7sJc9FH+JvpL8qGnSRuPEpSjLt8/nbMcq9sbivwyGmJaU7ReCZ5Z2FdCeAYIQrfGryAS/i4Ev7GqeO92efXUcvNBm9WVNvn0CQGDHQD2ziJ/YoLSs8sHO9swwOa9pyJbtm0Xgb5tKru2tiK0KBwXzlEpskZK79hwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowADnihRTbtpoCQfACA--.2097S2;
	Mon, 29 Sep 2025 19:32:37 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH v2] power: supply: rt5033_charger: Fix device node reference leaks
Date: Mon, 29 Sep 2025 19:32:34 +0800
Message-ID: <20250929113234.1726-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20250929031536.2274-1-vulab@iscas.ac.cn>
References: <20250929031536.2274-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnihRTbtpoCQfACA--.2097S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW5JF17KryfuFyrKry7Awb_yoW8Jw43pr
	95AFZIvr4DGr4Utayjy3ZrCFW5KF45ArW0kr10k34aywn3Xay7Jry5tFsxZry8AryfGF4I
	qr1aqr4IgF45CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU0iiSUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAcAA2jaLgfoOgAAsB

The device node pointers `np_conn` and `np_edev`, obtained from
of_parse_phandle() and of_get_parent() respectively, are not released.
This results in a reference count leak.

Add of_node_put() calls after the last use of these device nodes to
properly release their references and fix the leaks.

Fixes: 8242336dc8a8 ("power: supply: rt5033_charger: Add cable detection and USB OTG supply")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>

---
Changes in v2:
  - Resend to the correct maintainer and mailing list.
---
 drivers/power/supply/rt5033_charger.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
index 2fdc58439707..de724f23e453 100644
--- a/drivers/power/supply/rt5033_charger.c
+++ b/drivers/power/supply/rt5033_charger.c
@@ -701,6 +701,8 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 	np_conn = of_parse_phandle(pdev->dev.of_node, "richtek,usb-connector", 0);
 	np_edev = of_get_parent(np_conn);
 	charger->edev = extcon_find_edev_by_node(np_edev);
+	of_node_put(np_edev);
+	of_node_put(np_conn);
 	if (IS_ERR(charger->edev)) {
 		dev_warn(charger->dev, "no extcon device found in device-tree\n");
 		goto out;
-- 
2.50.1.windows.1


