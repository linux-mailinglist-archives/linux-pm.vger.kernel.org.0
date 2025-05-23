Return-Path: <linux-pm+bounces-27538-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CECFCAC19B6
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 03:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373E71C040DA
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 01:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC301FF1CF;
	Fri, 23 May 2025 01:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkM+5yDS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777E32DCBF4;
	Fri, 23 May 2025 01:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747964383; cv=none; b=uhyuz54H1mfWpA1UK3Zc1XEmvnKszUM0h/gQbXRdRq/mUdlz7o2/1Ke9GwZhAPbFyXBTEEHgQz18VhHqyf2sNlPocgX/nZFFnzY+SBDwklvPE0CVVpa7F1n+ex/07aqWyrEfl6eikTMR3XnkIGwGbBb+WM3k7q3SzUvmLoxnZCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747964383; c=relaxed/simple;
	bh=BuAnjRUfiZkIyG1T0GsVaYITt5f2u03IOqolF0n/F0o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i2Z0tqRs5lzxp+G23u2D+APNiLMZ3cAsVQPX1wiZ99mtP4RfYkz1sZ9hqbmMJtGM9rKem6UrVXzchnIOD2YcJRfWqyDfJM6G78CmhjQxZO22daOEZJlhTPakP2qb61zpHIrcIBNMB8pXCUcdBCEL91Mz7MCPu9DYmk23lFD3gvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkM+5yDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F22B2C4CEE4;
	Fri, 23 May 2025 01:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747964383;
	bh=BuAnjRUfiZkIyG1T0GsVaYITt5f2u03IOqolF0n/F0o=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=pkM+5yDSEmW55r8TgXILhwY5A8UfZ5KUMefRL+ZkcjMgDKbkf1jhqzm8R9gFSOOVD
	 QLzOOP3wPFQtIg384nQ3909O7uH9mQ8Ckxj9yfvMZ4nwGpM1fN/m/YRhjd4Pkiairx
	 KVg0QJ+R0eLEkYMRtwRlOx8dMXfPhC1aJ71BR5bDHEohGlDo/7Qjx5XVmKZPao9BLB
	 MAH4I9c9VuyTIlu9GlpTx15eWxi7KbpSj+RaOLWfd4kkxTmyUmh4BDmXgIzPFpQr+K
	 ncuk1fQSRIm/gdFEYw1Aq5XVQHVwiEI24K28KL4aRnftdVK5hZEe+u0Gjniw2VYwhD
	 orRG1tOFTTC4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D516CC54ED0;
	Fri, 23 May 2025 01:39:42 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Subject: [PATCH 0/5] power: supply: Add several features support in
 qcom-battmgr driver
Date: Fri, 23 May 2025 09:39:17 +0800
Message-Id: <20250523-qcom_battmgr_update-v1-0-2bb6d4e0a56e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMXRL2gC/x3MTQqAIBBA4avErBPMmBZdJSJMJ5uF/ahFIN09a
 fkt3ssQKTBF6KsMgW6OvG8FTV2BWfXmSLAtBiUVSlRSnGb306xT8i5M12F1ItFi11iDqjMSoZR
 HoIWf/zqM7/sBQy+3umUAAAA=
X-Change-ID: 20250520-qcom_battmgr_update-3561dc526c05
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 kernel@oss.qualcomm.com, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747964381; l=1544;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=BuAnjRUfiZkIyG1T0GsVaYITt5f2u03IOqolF0n/F0o=;
 b=c0WUixK9b9fxeYtk5G88417BMhrAC/WNVf04Y+Xs7UgkXbCBJZefFaiBnKKxhqb2ADCpBfIkQ
 b8fjIrU7KaFD3ZGGC2oK+RB+4pY62m630Uw+prokvzuyEhtOSnBzv3h
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

Add following features in qcom-battmgr drivers as the battery management
firmware has provided such capabilities:
 - Add resistance power supply property in core driver and qcom-battmgr
   driver to get battery resistance
 - Add state_of_health power supply property in core driver and
   qcom-battmgr driver to get battery health percentage
 - Add charge control start/end threshold control by using
   charge_control_start_threshold and charge_control_end_threshold power
   supply properties

The changes have been tested on QRD8650 device based on qcom/linux.git
for-next commit f8d04825b12f42ec8198dee1ab4654792f9ac231.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
Fenglin Wu (5):
      power: supply: core: add resistance power supply property
      power: supply: core: Add state_of_health power supply property
      power: supply: qcom_battmgr: Add resistance power supply property
      power: supply: qcom-battmgr: Add state_of_health power supply property
      power: supply: qcom-battmgr: Add charge control support

 Documentation/ABI/testing/sysfs-class-power |  20 +++
 drivers/power/supply/power_supply_sysfs.c   |   2 +
 drivers/power/supply/qcom_battmgr.c         | 213 +++++++++++++++++++++++++++-
 include/linux/power_supply.h                |   2 +
 4 files changed, 236 insertions(+), 1 deletion(-)
---
base-commit: b1d8766052eb0534b27edda8af1865d53621bd6a
change-id: 20250520-qcom_battmgr_update-3561dc526c05

Best regards,
-- 
Fenglin Wu <fenglin.wu@oss.qualcomm.com>



