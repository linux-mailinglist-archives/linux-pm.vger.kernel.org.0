Return-Path: <linux-pm+bounces-152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A06467F6D31
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 08:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E690B20FFF
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 07:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385915247;
	Fri, 24 Nov 2023 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15497D44;
	Thu, 23 Nov 2023 23:50:45 -0800 (PST)
X-UUID: 1552beee8cc441bbb03aba778b822927-20231124
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:f220a046-a202-49f3-b93b-e8478b749bcf,IP:5,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-INFO: VERSION:1.1.32,REQID:f220a046-a202-49f3-b93b-e8478b749bcf,IP:5,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-10
X-CID-META: VersionHash:5f78ec9,CLOUDID:7462e7fc-4a48-46e2-b946-12f04f20af8c,B
	ulkID:231124155029R77NN2E6,BulkQuantity:0,Recheck:0,SF:44|66|38|24|17|19|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 1552beee8cc441bbb03aba778b822927-20231124
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2127809040; Fri, 24 Nov 2023 15:50:29 +0800
From: Kunwu Chan <chentao@kylinos.cn>
To: agross@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	sre@kernel.org,
	caleb.connolly@linaro.org
Cc: kunwu.chan@hotmail.com,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] power: supply: Fix null pointer dereference in smb2_probe
Date: Fri, 24 Nov 2023 15:50:21 +0800
Message-Id: <20231124075021.1335289-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kasprintf and devm_kzalloc return a pointer to dynamically
allocated memory which can be NULL upon failure.

Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/power/supply/qcom_pmi8998_charger.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/qcom_pmi8998_charger.c b/drivers/power/supply/qcom_pmi8998_charger.c
index 8acf63ee6897..9bb777406013 100644
--- a/drivers/power/supply/qcom_pmi8998_charger.c
+++ b/drivers/power/supply/qcom_pmi8998_charger.c
@@ -972,10 +972,14 @@ static int smb2_probe(struct platform_device *pdev)
 	supply_config.of_node = pdev->dev.of_node;
 
 	desc = devm_kzalloc(chip->dev, sizeof(smb2_psy_desc), GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
 	memcpy(desc, &smb2_psy_desc, sizeof(smb2_psy_desc));
 	desc->name =
 		devm_kasprintf(chip->dev, GFP_KERNEL, "%s-charger",
 			       (const char *)device_get_match_data(chip->dev));
+	if (!desc->name)
+		return -ENOMEM;
 
 	chip->chg_psy =
 		devm_power_supply_register(chip->dev, desc, &supply_config);
-- 
2.34.1


