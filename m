Return-Path: <linux-pm+bounces-20732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F520A17625
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 04:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626571886E90
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 03:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC69B154BF0;
	Tue, 21 Jan 2025 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="TqI8ohmn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m19731117.qiye.163.com (mail-m19731117.qiye.163.com [220.197.31.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B55B4689;
	Tue, 21 Jan 2025 03:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737428831; cv=none; b=GEVCP23zl5V75mDLisHd5GMHQz9/6Z6rtDR8roSb0lvT2b1zsh4aETKrwpE7qPhWJapfX9HB9YA2Vg51PsaSkhF3FrH0WCT7ALSf2KEFmQDWSSK0nBb+ANsSo6nRjvUTFk0YM8TpLkdqNF9NE/cUa6WxfMxmWVoOniXmbbQY1r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737428831; c=relaxed/simple;
	bh=f+IDDWbG1glBaknBQy6VGbP5zPws55M0TW6SPyPyZzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KPPXJLLGo8y8qDJs0uUmfXC7SZe1amROs1Y6mWfvYPrUhIOJ5ae3R47lEynfcSz9qXctSOGM9lMy5JeSzDoRWERu0bE7qh0uN/G/+5Ye/cc1sibq9iAMXvIOGGIN3Sfrbq/iCxQhBprb5o543SxS7vKZMaPcPQ6cCluK6xAYo9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=TqI8ohmn; arc=none smtp.client-ip=220.197.31.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 93fdcfc9;
	Tue, 21 Jan 2025 11:01:56 +0800 (GMT+08:00)
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
Subject: [PATCH v6 5/7] scsi: ufs: core: Export ufshcd_dme_reset() and ufshcd_dme_enable()
Date: Tue, 21 Jan 2025 11:00:25 +0800
Message-Id: <1737428427-32393-6-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1737428427-32393-1-git-send-email-shawn.lin@rock-chips.com>
References: <1737428427-32393-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRoYQlYaT0tNGU5PQxlOThhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a9486cf3f3a09cckunm93fdcfc9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBw6Gio5IjIKHjUwDgoMEhYN
	FSIwC1ZVSlVKTEhMT0lDTkpDSkxCVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlJTEk3Bg++
DKIM-Signature:a=rsa-sha256;
	b=TqI8ohmnyxhWLqD1UqvMHUDQC50neVHUoo/yIyD3lyqatb7ECjsy4gVzcatUt8pCx0CUABidLzivZnU133pKUOKpXRqy0hVa/AJmXIYKwlkoaj3nI1PTC5Sno+YQOXE8vzNGTKwembWHuK9cKKG6kHwGKc/kyWqNdF2cM22P3eI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=62/IbHd0Qh119ueWxg+T4V12ACYtk6xM2YlX/+9xZY0=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

These two APIs will be used by glue driver if they need a different
HCE process.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

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
index 6a26853..723080b 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4014,7 +4014,7 @@ static int ufshcd_dme_link_startup(struct ufs_hba *hba)
  *
  * Return: 0 on success, non-zero value on failure.
  */
-static int ufshcd_dme_reset(struct ufs_hba *hba)
+int ufshcd_dme_reset(struct ufs_hba *hba)
 {
 	struct uic_command uic_cmd = {
 		.command = UIC_CMD_DME_RESET,
@@ -4028,6 +4028,7 @@ static int ufshcd_dme_reset(struct ufs_hba *hba)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(ufshcd_dme_reset);
 
 int ufshcd_dme_configure_adapt(struct ufs_hba *hba,
 			       int agreed_gear,
@@ -4053,7 +4054,7 @@ EXPORT_SYMBOL_GPL(ufshcd_dme_configure_adapt);
  *
  * Return: 0 on success, non-zero value on failure.
  */
-static int ufshcd_dme_enable(struct ufs_hba *hba)
+int ufshcd_dme_enable(struct ufs_hba *hba)
 {
 	struct uic_command uic_cmd = {
 		.command = UIC_CMD_DME_ENABLE,
@@ -4067,6 +4068,7 @@ static int ufshcd_dme_enable(struct ufs_hba *hba)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(ufshcd_dme_enable);
 
 static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba)
 {
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index d7aca9e..e3fd40e 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1357,6 +1357,8 @@ extern int ufshcd_system_thaw(struct device *dev);
 extern int ufshcd_system_restore(struct device *dev);
 #endif
 
+extern int ufshcd_dme_reset(struct ufs_hba *hba);
+extern int ufshcd_dme_enable(struct ufs_hba *hba);
 extern int ufshcd_dme_configure_adapt(struct ufs_hba *hba,
 				      int agreed_gear,
 				      int adapt_val);
-- 
2.7.4


