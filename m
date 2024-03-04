Return-Path: <linux-pm+bounces-4660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E66870CD8
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 22:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F2E2898E5
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 21:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CE778B47;
	Mon,  4 Mar 2024 21:29:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22142C689
	for <linux-pm@vger.kernel.org>; Mon,  4 Mar 2024 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587748; cv=none; b=WJFtoK+clnvkB4MQjSbV21r/PuG7X8Fa3ArxNVUJuVqjnTCo2j+TtLxwigZZyNofuyTFgQ8RvT5w5R/2+TXscLjUgCYSn5Izy2zAlbgwwRT5s39GWlYN5CLGaXNXN8XMpaKWSLXKUM6Tgxg2br8n0QAY0gI08kOsPXvEYvwkbW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587748; c=relaxed/simple;
	bh=R9sXnYv3VfRGcrZ5/KZOGdZaFSWQmEEW5PecCI0UwYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKi4zOgkxygtyomryVc9Zg3lI2NQE7w2lYoAhQb0CXj+PzGUiZTJyoXemPElcsWt636e1yJOvabDiH7rEnp98hxRdiDL0n6fqrmgC4LIK1KgCaKUidnHDW9Vi+o1GF7iwjo3yF1/e0C/GmoQSMupNP/Qq/4fUo9rw/f2tYnvLmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhFrl-0002hd-8k; Mon, 04 Mar 2024 22:28:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhFrk-004QhS-GL; Mon, 04 Mar 2024 22:28:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhFrk-00H4uN-1L;
	Mon, 04 Mar 2024 22:28:56 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 3/5] PM / devfreq: mtk-cci: Convert to platform remove callback returning void
Date: Mon,  4 Mar 2024 22:28:41 +0100
Message-ID:  <fbc7b0a577de0c0fc46cf1b9e1a03a9c46bf79e0.1709587301.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709587301.git.u.kleine-koenig@pengutronix.de>
References: <cover.1709587301.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1957; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=R9sXnYv3VfRGcrZ5/KZOGdZaFSWQmEEW5PecCI0UwYU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl5j0KB0prRkwFiMOZlnfNuNGvP6+/rMnxv/n7N Rmyl6mVSe6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeY9CgAKCRCPgPtYfRL+ TjNaB/9VL/XniiKx+uwHc1n1ORgvJTG3GMwQkthaAmp6NBA7F9+JeNaXgtRvl59DQZC8L7KrFyz P5xxfmwd9/SrqLwyOjlYWVp7VTiWVwIUil+TSfKbclPOoJtue895UU9sTr9MzG8H5WXFmEflXxU Q1uQCZ/tsrq9oiJW8wlESgE5ftBzjo37qa5yFSCqC/Oj2TIN+m4xGUJlLmpnzvops+1CpFfdsck IWWx+YFUUDtp0jJf/In7RhQMkwXbTLWppXoUfY4JWifAMEBHYKyfA0F7euWxvPJh5Prk2ZCK5nQ Ionn2GSnLV5jqXltxa6FI2/q72Zc/IDm7wIUSVt2oaG8ZucS
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/devfreq/mtk-cci-devfreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
index 11bc3d03494c..7ad5225b0381 100644
--- a/drivers/devfreq/mtk-cci-devfreq.c
+++ b/drivers/devfreq/mtk-cci-devfreq.c
@@ -392,7 +392,7 @@ static int mtk_ccifreq_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mtk_ccifreq_remove(struct platform_device *pdev)
+static void mtk_ccifreq_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_ccifreq_drv *drv;
@@ -405,8 +405,6 @@ static int mtk_ccifreq_remove(struct platform_device *pdev)
 	regulator_disable(drv->proc_reg);
 	if (drv->sram_reg)
 		regulator_disable(drv->sram_reg);
-
-	return 0;
 }
 
 static const struct mtk_ccifreq_platform_data mt8183_platform_data = {
@@ -432,7 +430,7 @@ MODULE_DEVICE_TABLE(of, mtk_ccifreq_machines);
 
 static struct platform_driver mtk_ccifreq_platdrv = {
 	.probe	= mtk_ccifreq_probe,
-	.remove	= mtk_ccifreq_remove,
+	.remove_new = mtk_ccifreq_remove,
 	.driver = {
 		.name = "mtk-ccifreq",
 		.of_match_table = mtk_ccifreq_machines,
-- 
2.43.0


