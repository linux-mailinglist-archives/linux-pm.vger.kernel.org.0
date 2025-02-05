Return-Path: <linux-pm+bounces-21367-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2488EA284AB
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 07:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38601667F9
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 06:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD36228377;
	Wed,  5 Feb 2025 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="OztpeoIQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m49202.qiye.163.com (mail-m49202.qiye.163.com [45.254.49.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FA221517A;
	Wed,  5 Feb 2025 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738738430; cv=none; b=VpcYmCeesjgBdUORSqfhJCYwgp/xfI4NERZp+hPSDzpSpQRhdSw2ERlF+Ve7k7SM4HI9UuyQcs0X5wITHFpDjuRsedVAENy0xqIhArPxrSzHIgikR0GUDzYoEo0LpGPzFrCjIZZrt/Z6cjKdjfDsUw+csCQR30BdZFN4byjRzrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738738430; c=relaxed/simple;
	bh=yT2vByNZnLKMoecatN+Y+a/G5hoWbJR7ZL8sZCSE3Pc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pp+xTeio5FiqdEo0T2vlJe35o5uJ1qAl+lqdycPnVDLyvMRoTX1Vxtwl3ImprYEqnodZcOLf62j5EfQToevsyhVI5GQSUZj7XlVE2bNvqBxYJs8yoCW43VU4tcjQuLRZECfyK4Op0VJVXSpMRFiap13+iQtUS1GnsVBdDtcvsYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=OztpeoIQ; arc=none smtp.client-ip=45.254.49.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id a34e52b8;
	Wed, 5 Feb 2025 14:18:19 +0800 (GMT+08:00)
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
Subject: [PATCH v7 5/7] scsi: ufs: core: Export ufshcd_dme_reset() and ufshcd_dme_enable()
Date: Wed,  5 Feb 2025 14:15:54 +0800
Message-Id: <1738736156-119203-6-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
References: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ09ITVZOTR9LTx1NHRlMHkNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a94d4c26db509cckunma34e52b8
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MU06PCo6MjINDgtDODcpHCpJ
	L08KCglVSlVKTEhDTEhNSEtKS0xDVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlJQkg3Bg++
DKIM-Signature:a=rsa-sha256;
	b=OztpeoIQaadXhInVaxSz6SrW4MXIUqpglyw6hyB8h8SQrPlnunzycFFkxFC+wLbo0e58uU+GTGnvT9MlnCUnwTR8mWI8LBz2pURW7hdDWMhrnWMPiUPSwmvNM3Uu9/HJuvKdcYSNQCS8xYrNXbNYzRBjVVxzT0KYqI/ynUkA8kk=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=tQBe00/5+XR3AuyJ7x8v0mQNDVOcfg72dNI5pbcGOVo=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

These two APIs will be used by glue driver if they need a different
HCE process.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v7: None
Changes in v6:
- replace host drivers with glue drivers suggested by Mani
- add Main's review tag

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/ufs/core/ufshcd.c | 6 ++++--
 include/ufs/ufshcd.h      | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index cd404ad..d9cb60d 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4002,7 +4002,7 @@ static int ufshcd_dme_link_startup(struct ufs_hba *hba)
  *
  * Return: 0 on success, non-zero value on failure.
  */
-static int ufshcd_dme_reset(struct ufs_hba *hba)
+int ufshcd_dme_reset(struct ufs_hba *hba)
 {
 	struct uic_command uic_cmd = {
 		.command = UIC_CMD_DME_RESET,
@@ -4016,6 +4016,7 @@ static int ufshcd_dme_reset(struct ufs_hba *hba)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(ufshcd_dme_reset);
 
 int ufshcd_dme_configure_adapt(struct ufs_hba *hba,
 			       int agreed_gear,
@@ -4041,7 +4042,7 @@ EXPORT_SYMBOL_GPL(ufshcd_dme_configure_adapt);
  *
  * Return: 0 on success, non-zero value on failure.
  */
-static int ufshcd_dme_enable(struct ufs_hba *hba)
+int ufshcd_dme_enable(struct ufs_hba *hba)
 {
 	struct uic_command uic_cmd = {
 		.command = UIC_CMD_DME_ENABLE,
@@ -4055,6 +4056,7 @@ static int ufshcd_dme_enable(struct ufs_hba *hba)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(ufshcd_dme_enable);
 
 static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba)
 {
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 650ff23..31661a4 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1369,6 +1369,8 @@ extern int ufshcd_system_thaw(struct device *dev);
 extern int ufshcd_system_restore(struct device *dev);
 #endif
 
+extern int ufshcd_dme_reset(struct ufs_hba *hba);
+extern int ufshcd_dme_enable(struct ufs_hba *hba);
 extern int ufshcd_dme_configure_adapt(struct ufs_hba *hba,
 				      int agreed_gear,
 				      int adapt_val);
-- 
2.7.4


