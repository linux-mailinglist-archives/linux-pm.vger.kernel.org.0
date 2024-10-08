Return-Path: <linux-pm+bounces-15321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8421F99476D
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 13:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE981F212B3
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 11:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D421D8DFB;
	Tue,  8 Oct 2024 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="HRYrF1OG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m92248.xmail.ntesmail.com (mail-m92248.xmail.ntesmail.com [103.126.92.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41511D4141;
	Tue,  8 Oct 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.92.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387715; cv=none; b=gNRqOsnq3fK5AUDilR6xnvcBg8QKaXmjcAigTgwtS4J2hFLlotFMGq4N0uAo0FDtD3hW+AJcgXk0ty+m5IGdc8w+pqDXApdu1/lLVxdtcZscIGU9enXJMGDvmSGvZNGXg1c2SFOHBx2k2Z6Mxn4y1CLxnW3o5B7nB4SJYmOuTl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387715; c=relaxed/simple;
	bh=S6XkNkmuedD1pQiaxwUmsamoq7LhM5melxm3Vc1eKDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MHs0HvDaKGlb2Djz3wqmSGvc4gN9vomFE6rhU3RD3QnqEIVv4bNel3GUNjHBSC+7TD50n5HnDyVje9UTgywW5ovexflM/kghupoPDurpkRVvibHaOZNd4d7MutiQR1U4vh12YQEL90QoTEZlp8SrP6YZJQfkcGIbJE8kZwQng6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=HRYrF1OG; arc=none smtp.client-ip=103.126.92.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=HRYrF1OGMwGO2XCvcjO7vadF6OFvDsh/Ue7CpxudlEzsKrt1kuwoGsQw/zm3nrOPRuIITH7Rns0atrp3Q9tJ0LF2jEPXelDJLPv8jlOg/jTgSm5UCe3KE4qOicBCwB9l4D2An2mdIbI7hp0lK3YRTi/MZhG3S8E2bv10ej/Ua+M=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=nOR0BMICsxKcbiEHiB0O1t4LWarRiz326TLSWeKN3ho=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 83B8052075A;
	Tue,  8 Oct 2024 14:16:07 +0800 (CST)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Rob Herring <robh+dt@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	YiFeng Zhao <zyf@rock-chips.com>,
	Liang Chen <cl@rock-chips.com>,
	linux-scsi@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 1/5] scsi: ufs: core: Add UFSHCI_QUIRK_DME_RESET_ENABLE_AFTER_HCE
Date: Tue,  8 Oct 2024 14:15:26 +0800
Message-Id: <1728368130-37213-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1728368130-37213-1-git-send-email-shawn.lin@rock-chips.com>
References: <1728368130-37213-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhhCS1ZDTE9LS01MHx8dSkNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a926ac54e3703afkunm83b8052075a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nkk6TRw4MzIZFBYwNzYCDTga
	AjMwChdVSlVKTElDSE1DSk1CS01JVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU9IQkk3Bg++
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

HCE on Rockchip SoC is different from both of ufshcd_hba_execute_hce()
and UFSHCI_QUIRK_BROKEN_HCE case. It need to do dme_reset and dme_enable
after enabling HCE. So in order not to abuse UFSHCI_QUIRK_BROKEN_HCE, add
a new quirk UFSHCI_QUIRK_DME_RESET_ENABLE_AFTER_HCE, to deal with that
limitation.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 drivers/ufs/core/ufshcd.c | 17 +++++++++++++++++
 include/ufs/ufshcd.h      |  6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 7cab1031..4868099 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4819,6 +4819,7 @@ static int ufshcd_hba_execute_hce(struct ufs_hba *hba)
 {
 	int retry_outer = 3;
 	int retry_inner;
+	int ret;
 
 start:
 	if (ufshcd_is_hba_active(hba))
@@ -4865,6 +4866,22 @@ static int ufshcd_hba_execute_hce(struct ufs_hba *hba)
 	/* enable UIC related interrupts */
 	ufshcd_enable_intr(hba, UFSHCD_UIC_MASK);
 
+	/*
+	 * Do dme_reset and dme_enable if a UFS host controller need
+	 * this procedure to actually finish HCE.
+	 */
+	if (hba->quirks & UFSHCI_QUIRK_DME_RESET_ENABLE_AFTER_HCE) {
+		ret = ufshcd_dme_reset(hba);
+		if (!ret) {
+			ret = ufshcd_dme_enable(hba);
+			if (ret)
+				dev_err(hba->dev,
+					"Failed to do dme_enable after HCE.\n");
+		} else {
+			dev_err(hba->dev, "Failed to do dme_reset after HCE.\n");
+		}
+	}
+
 	ufshcd_vops_hce_enable_notify(hba, POST_CHANGE);
 
 	return 0;
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index a95282b..73b888f 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -685,6 +685,12 @@ enum ufshcd_quirks {
 	 * single doorbell mode.
 	 */
 	UFSHCD_QUIRK_BROKEN_LSDBS_CAP			= 1 << 25,
+
+	/*
+	 * This quirks needs to be enabled if host controller need to
+	 * do dme_reset and dme_enable after hce.
+	 */
+	UFSHCI_QUIRK_DME_RESET_ENABLE_AFTER_HCE		= 1 << 26,
 };
 
 enum ufshcd_caps {
-- 
2.7.4


