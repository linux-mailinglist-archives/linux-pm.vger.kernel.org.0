Return-Path: <linux-pm+bounces-38148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A40C6724F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 04:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 36F1C3623FB
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 03:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E65832AAAB;
	Tue, 18 Nov 2025 03:24:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E89F329364;
	Tue, 18 Nov 2025 03:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763436250; cv=none; b=H0fQ3RBgKM0eP4BN3brLeTHzlAgdF2A3Jit0/wlu562T/ZaAjDSV6kV/Eo+QK3b9bCsk2Qno38JRiwzo5SAWQ+d06a9keiUYkbr4kwoipDwbN+jBAh3Lg/mxjEaq2pSy+0hZrdd2FDgtwfXXOowCNxvEEuloRqPJcFF+i63ybqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763436250; c=relaxed/simple;
	bh=m28yP26adj4bqeovQGwr1yJsiyJEiV8n8Y/Y/4BZhEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EKL6pssTWYZ2zIylAIDeVge4ROWG5RbEYKZ9oJQFz/9/CUr+8z8nkrMmIXnPlEZXD9+LcL6yEI9hgfz+RzJV8HTrbSLjRduD7FruMnDl6o3J31erj6TaLo5oqvKxF9Ia5lpPkSYl6OVri7HHzcohF7r/6PIVmZCjTFKF0obEPus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 06585cb0c42e11f0a38c85956e01ac42-20251118
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:72e47358-2147-4ad5-9f61-42ef41f9c03c,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:e7adeed6dafbaac007f2009b5af0c864,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:0|15|50,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 06585cb0c42e11f0a38c85956e01ac42-20251118
X-User: luriwen@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luriwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 741734572; Tue, 18 Nov 2025 11:24:00 +0800
From: Riwen Lu <luriwen@kylinos.cn>
To: myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v1 2/2] PM: devfreq: handle invalid parameters gracefully in simpleondemand
Date: Tue, 18 Nov 2025 11:23:39 +0800
Message-Id: <20251118032339.2799230-2-luriwen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251118032339.2799230-1-luriwen@kylinos.cn>
References: <20251118032339.2799230-1-luriwen@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of returning -EINVAL when upthreshold > 100 or upthreshold <
downdifferential, fall back to default threshold values to ensure the
governor continues functioning.

Additionally, the validation is now scoped to the if (data) block,
preventing unnecessary checks when no user data is provided, while the
fallback mechanism ensures reliability with invalid configurations.

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
---
 drivers/devfreq/governor_simpleondemand.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index b4d7be766f33..7205891d2ec6 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -36,10 +36,15 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 			dfso_upthreshold = data->upthreshold;
 		if (data->downdifferential)
 			dfso_downdifferential = data->downdifferential;
+
+		if (dfso_upthreshold > 100 ||
+		    dfso_upthreshold < dfso_downdifferential) {
+			dfso_upthreshold = DFSO_UPTHRESHOLD;
+			dfso_downdifferential = DFSO_DOWNDIFFERENTIAL;
+			pr_debug("Invalid thresholds, using defaults: up = %u, down = %u\n",
+				dfso_upthreshold, dfso_downdifferential);
+		}
 	}
-	if (dfso_upthreshold > 100 ||
-	    dfso_upthreshold < dfso_downdifferential)
-		return -EINVAL;
 
 	/* Assume MAX if it is going to be divided by zero */
 	if (stat->total_time == 0) {
-- 
2.25.1


