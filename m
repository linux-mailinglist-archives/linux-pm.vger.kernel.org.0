Return-Path: <linux-pm+bounces-17179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ED39C16AC
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 07:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC0A1F242A4
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 06:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902081D0E25;
	Fri,  8 Nov 2024 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="GzqVrhrS"
X-Original-To: linux-pm@vger.kernel.org
Received: from ec2-44-216-146-168.compute-1.amazonaws.com (ec2-44-216-146-168.compute-1.amazonaws.com [44.216.146.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127721D0DC7;
	Fri,  8 Nov 2024 06:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.216.146.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731049094; cv=none; b=XCXCNYWPcoyquok9wl7h5OBxaJNawF7vkKYNZLoB7Fh3OwCCEwzvh9/rBfhs02BddSGYV9CFuK1s5eGX5L5LRLA1nTXFk/BuE/capVqqokRE7dbTfxEU3QaqVTTSW799XjgW4bEnYXp8bLRal7Wnk9rfuYX4ANBgsB0cXxjRses=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731049094; c=relaxed/simple;
	bh=16F52qozRA5Om2mVI2Cu8/oXiuSk+3JvsgSJAfwHlFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ILkR+mckmCQTiOTyD2a1BZup1/5BJG2gRIbTHVTH8L1f+vxLNT6wkcejoWuJHU+Yn/7Z7TWcWlnA+PCl4V2iPssUTMdeJzLUHw0mv1XQ2WYsWP0NPQ4Pw211WQMosL5a9KCn83ER7E1ml7BS6YzAbNgO8FFkbEaw8NusOVSo5+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=GzqVrhrS; arc=none smtp.client-ip=44.216.146.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 22d55ccc;
	Fri, 8 Nov 2024 14:57:59 +0800 (GMT+08:00)
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
Subject: [PATCH v5 5/7] scsi: ufs: core: Export ufshcd_dme_reset() and ufshcd_dme_enable()
Date: Fri,  8 Nov 2024 14:56:24 +0800
Message-Id: <1731048987-229149-6-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1731048987-229149-1-git-send-email-shawn.lin@rock-chips.com>
References: <1731048987-229149-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR1CTVYfT0IaTR0ZTUlNGk5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a930a90c14509cckunm22d55ccc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OSo6IRw4MzIZCioqUSgrK00x
	F0kwCxlVSlVKTEhKS09CS0NLTEhDVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlKS0s3Bg++
DKIM-Signature:a=rsa-sha256;
	b=GzqVrhrSU2Utj463fLTSS5yGJ+BtHdmPP1B1Ztdljdbf8Gnld1Aa5v1w/WtpiAUth/SlzoguaumLd0G59zigKXTVgyrITO9zbF/KKAtMVUxKNKXWel34MBXwND2vffI3QqRleeHxuV4jwfF4wsuHySsyDqhY6LOng5aZ99uxEb4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=pMAlr3pzhcf2KZDKp9eFnavRLAmIbHd/sKcZqBP9xAk=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

These two APIs will be used by host driver if they need a different
HCE process.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/ufs/core/ufshcd.c | 6 ++++--
 include/ufs/ufshcd.h      | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 24a32e2..9d1d56d 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4039,7 +4039,7 @@ static int ufshcd_dme_link_startup(struct ufs_hba *hba)
  *
  * Return: 0 on success, non-zero value on failure.
  */
-static int ufshcd_dme_reset(struct ufs_hba *hba)
+int ufshcd_dme_reset(struct ufs_hba *hba)
 {
 	struct uic_command uic_cmd = {
 		.command = UIC_CMD_DME_RESET,
@@ -4053,6 +4053,7 @@ static int ufshcd_dme_reset(struct ufs_hba *hba)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(ufshcd_dme_reset);
 
 int ufshcd_dme_configure_adapt(struct ufs_hba *hba,
 			       int agreed_gear,
@@ -4078,7 +4079,7 @@ EXPORT_SYMBOL_GPL(ufshcd_dme_configure_adapt);
  *
  * Return: 0 on success, non-zero value on failure.
  */
-static int ufshcd_dme_enable(struct ufs_hba *hba)
+int ufshcd_dme_enable(struct ufs_hba *hba)
 {
 	struct uic_command uic_cmd = {
 		.command = UIC_CMD_DME_ENABLE,
@@ -4092,6 +4093,7 @@ static int ufshcd_dme_enable(struct ufs_hba *hba)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(ufshcd_dme_enable);
 
 static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba)
 {
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 3f68ae3e4..b9733dc 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1360,6 +1360,8 @@ extern int ufshcd_system_thaw(struct device *dev);
 extern int ufshcd_system_restore(struct device *dev);
 #endif
 
+extern int ufshcd_dme_reset(struct ufs_hba *hba);
+extern int ufshcd_dme_enable(struct ufs_hba *hba);
 extern int ufshcd_dme_configure_adapt(struct ufs_hba *hba,
 				      int agreed_gear,
 				      int adapt_val);
-- 
2.7.4


