Return-Path: <linux-pm+bounces-16933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CB29BB052
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 10:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6781C21080
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 09:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED9C1AF0A0;
	Mon,  4 Nov 2024 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fyTzUEGq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m25477.xmail.ntesmail.com (mail-m25477.xmail.ntesmail.com [103.129.254.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5851ABEDC;
	Mon,  4 Nov 2024 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.254.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730714114; cv=none; b=AYSqSBS+tmZZTunhzwkOtGhEwsCYcW6MPMuznMzJG8aVQITCc6yizC0RTtxob8CNLgHVjFz94R4ARzuJ/eWSZcLs/9kNO/E0+sVVLPQTL8fMRUtWsrMFFeFTCQLnKY0HiXnIpkb3DVIkpklkecJZyqd92WBu62CDTMwJuEo3/UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730714114; c=relaxed/simple;
	bh=RHWO6iEQTDETJffGVpmIWYwT1WtB/IvuIvBOxzo+Osc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MCTGpf2/7e/vlgICiJnHdk1D63wSjvyUnp35taWyvA3wTcwHTuMQdvJBzSg26tTbwcLop1AzEt07c/d1/P88kkd84Fghh6pOY23L6rccSJ8Z6uhNFYpfOADnoSdeBPo1hOh3DiOMSmy19QPZuLQPxCcQCba8YY/3KgL+6GQ/uYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fyTzUEGq; arc=none smtp.client-ip=103.129.254.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1b5d898f;
	Mon, 4 Nov 2024 15:32:37 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Rob Herring <robh+dt@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	YiFeng Zhao <zyf@rock-chips.com>,
	Liang Chen <cl@rock-chips.com>,
	linux-scsi@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 1/7] scsi: ufs: core: Add UFSHCI_QUIRK_DME_RESET_ENABLE_AFTER_HCE
Date: Mon,  4 Nov 2024 15:31:55 +0800
Message-Id: <1730705521-23081-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1730705521-23081-1-git-send-email-shawn.lin@rock-chips.com>
References: <1730705521-23081-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh9MTFZIS0xPHR0fTBpDTUpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92f617072f09cckunm1b5d898f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Myo6EBw*ITIaLDoKQys0CE0V
	EQgwFA1VSlVKTEhLTEtOTk5DQktCVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlKTU03Bg++
DKIM-Signature:a=rsa-sha256;
	b=fyTzUEGqpD7cOV/gtR7q6BW8ZrIP2F7Il0l0fRmIWbpntGqeRNaY0xD3go56SRvQDKFp6+9Vn8/QTcR8aBbVlulPDUK1DAXd+5Dc9IpmHP4w03liGg+JBkB6ZXLYqRd1As27+Q5dHci7nSbjEv4mCiQfdHPoDhHPShTxzJaej+w=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=H80kBB4v9HnGpTZXw3/vIrv2TnnmcgYDzbgw9IhYzgg=;
	h=date:mime-version:subject:message-id:from;
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

Changes in v4:
- fix typo

Changes in v3: None
Changes in v2: None

 drivers/ufs/core/ufshcd.c | 17 +++++++++++++++++
 include/ufs/ufshcd.h      |  6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 7cab1031..4084bf9 100644
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
+	 * Do dme_reset and dme_enable if a UFS host controller needs
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
index a95282b..e939af8 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -685,6 +685,12 @@ enum ufshcd_quirks {
 	 * single doorbell mode.
 	 */
 	UFSHCD_QUIRK_BROKEN_LSDBS_CAP			= 1 << 25,
+
+	/*
+	 * This quirk needs to be enabled if host controller need to
+	 * do dme_reset and dme_enable after hce.
+	 */
+	UFSHCI_QUIRK_DME_RESET_ENABLE_AFTER_HCE		= 1 << 26,
 };
 
 enum ufshcd_caps {
-- 
2.7.4


