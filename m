Return-Path: <linux-pm+bounces-39072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECDEC9B946
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 14:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 652DD4E4655
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114983164C2;
	Tue,  2 Dec 2025 13:21:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870F0158535
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764681706; cv=none; b=ILVYdIK9+70tUhpCyahgBCmIS6CNxWuAiP/KtaXMaK289wV/fA8JEBP328ehBkkSAMmM/4NDUSA3a5lkdDiG4x8hjpLsu8+kVsoJg6gbEC3ciwZ4RNxYjDyMG/aLLiwO/PrEWtNCHTDzkSuobxYMy9eVMIr5Y1qR+qNUENQDUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764681706; c=relaxed/simple;
	bh=X6h8rILKRfbKIuZ/42DX20qfhAjCc8dGdCsBmMS7EuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cMdqF+TFSNtzAaxGuLHlki683e4TNZE24ErSinQULuQbIHo6oJApRk6xkJXQhPXULt3EutdeyEAhQ2f9uWN2Vpmb/1iijrqvclmRzHOljpbkCIBqGuE8j13APQop0SCUNx9i0aevHYJlsLuSIutMa1KAGLPu4JyJXeT7RAxVS8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1vQQJu-0003pJ-No; Tue, 02 Dec 2025 14:21:30 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Tue, 02 Dec 2025 14:21:02 +0100
Subject: [PATCH v2 1/3] pmdomain: imx93-blk-ctrl: cleanup error path
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-v6-18-topic-imx93-blkctrl-v2-1-e73501034adc@pengutronix.de>
References: <20251202-v6-18-topic-imx93-blkctrl-v2-0-e73501034adc@pengutronix.de>
In-Reply-To: <20251202-v6-18-topic-imx93-blkctrl-v2-0-e73501034adc@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Frank Li <Frank.Li@nxp.com>, Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Call dev_err_probe() directly during return to make the code more
compact.

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/pmdomain/imx/imx93-blk-ctrl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
index e094fe5a42bf646c712f3eca4e66a313fa5a914c..2aa163aef8de4ee901b9cde76ce2aad246c8c08a 100644
--- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
@@ -240,10 +240,8 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
 	bc->num_clks = bc_data->num_clks;
 
 	ret = devm_clk_bulk_get(dev, bc->num_clks, bc->clks);
-	if (ret) {
-		dev_err_probe(dev, ret, "failed to get bus clock\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get bus clock\n");
 
 	for (i = 0; i < bc_data->num_domains; i++) {
 		const struct imx93_blk_ctrl_domain_data *data = &bc_data->domains[i];

-- 
2.47.3


