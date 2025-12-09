Return-Path: <linux-pm+bounces-39332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AE2CAF444
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 09:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B53C23009766
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 08:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DE12222C4;
	Tue,  9 Dec 2025 08:20:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C536B202963;
	Tue,  9 Dec 2025 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765268408; cv=none; b=dLqCsZIMgAcwwdA2vYHM45KfHZiniPnpN9ageYj69S2ChaP5FK6BMknhJ4uTEJIMeEFHiOIIvo/1H0/JSCIuXyQy2lcPJMDXWzTudNwfomZfY+bokXdpakjlB6dVJrE418AH4WPWDlCT5eJdXudLSIr4b/y+YRO3kwutfgz9jIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765268408; c=relaxed/simple;
	bh=Je31Vvn8gJ3ohzlZ2ypGKiH0qZ95j/Z4ZrUmZTsKYQY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DD08203XdlGyEEwRDy5oz20H8hOEJnVVptc4hNM1fETzFjqp9iZ/tC9bP42RAc74jfpgA1snOWleI4ix+wuTR6fncz4iRzLSxnIenkA9NXVXU15A8wRGfZEby2i0DJt264bOZ5XkaCteA2wPzTWu+p8S/z0te5yGi4aaBy2lu1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAC309qk2zdpTRcXAA--.1979S2;
	Tue, 09 Dec 2025 16:19:48 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: ulf.hansson@linaro.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] pmdomain: imx: Fix reference count leak in imx_gpc_probe()
Date: Tue,  9 Dec 2025 08:19:09 +0000
Message-Id: <20251209081909.24982-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC309qk2zdpTRcXAA--.1979S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Xr45Zr4xtr47XF48XrWUurg_yoW8JrW7pF
	W7GFWYkrWxGF47Kayktr18ZFy5K347A3yakr4UKayIvrn5tFyxXry5Z34jkwsIyFy8Ga15
	tr17KryrC3W29FJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUyE__UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoLA2k3qEfCLAAAsa

of_get_child_by_name() returns a node pointer with refcount incremented,
we should use the __free() attribute to manage the pgc_node reference.
This ensures automatic of_node_put() cleanup when pgc_node goes out of
scope, eliminating the need for explicit error handling paths and
avoiding reference count leaks.

Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

---
Change in V2:
- Use __free() attribute instead of explicit of_node_put() calls
---
 drivers/pmdomain/imx/gpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index f18c7e6e75dd..89d5d68c055d 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -403,7 +403,7 @@ static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap,
 static int imx_gpc_probe(struct platform_device *pdev)
 {
 	const struct imx_gpc_dt_data *of_id_data = device_get_match_data(&pdev->dev);
-	struct device_node *pgc_node;
+	struct device_node *pgc_node __free(pgc_node);
 	struct regmap *regmap;
 	void __iomem *base;
 	int ret;
-- 
2.34.1


