Return-Path: <linux-pm+bounces-27537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67517AC19B5
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 03:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8662A4E7C94
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 01:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DFC1FBCAF;
	Fri, 23 May 2025 01:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCnfLJjJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777B42DCBE0;
	Fri, 23 May 2025 01:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747964383; cv=none; b=B7ve4QQSiVyxNKYUWoA9iFc5W42uRoOukoJaEkYsM7VTsjXQCyqeqPhIMJKem+AY1iQluAE+iGdme1dllbP/BXYVU4ykzY5p/Bc9b/MnypMJ5YPKb7uyZXREq/CsSL5W616bsQcGF4mHzIryvYCaH6lr1aY/MKEHj5uZwnBDg6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747964383; c=relaxed/simple;
	bh=D+uMpcIjU+XNGgExEF0M/EWM2T9xFedeFZkRfusIy5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nuh1K5HJC454sAaypXDFbV1aQDePlnPr6EyObvbhGrF3G2n5OFWR9wi5m4EMNpaL4UsOlD+Tnc6+wNjyThLJ20ixxZOd1q+giBWlQTmZOqGLhAi2w084E2Fx8EtorcIRGndDR5/kUdYixO6ZSNG02eI2qDqXNEY76Ms8yn3kdRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCnfLJjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06294C4CEEB;
	Fri, 23 May 2025 01:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747964383;
	bh=D+uMpcIjU+XNGgExEF0M/EWM2T9xFedeFZkRfusIy5E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gCnfLJjJ+URKp0B3x/JShT+dBQ6CHvhqs2OuZbrDGFQ2NWv3cFcwiraZcXTwrea7F
	 xkKytiRR1iSqeINV4OFtGX4pbP49iv3bEBvjR1RFDbiFR/KqzyBt8ezHPsk2YeKiOv
	 QAmB+I9GSL4VbkM50rhKbxf7hvoKuSqV1rdn0+br00McHJtyp+N/WttO0oh3oXVKvE
	 JdqxNWLSegIWXcgwzZSpj4cQIwA+Bj2/sy3NJueWYNpAqrQ2C5rpUFXpMVx5sugDdP
	 k9zrRceIKfEbhDiU/1wXhoy1WYXuXfWG6tjDgqWKbJ9k4Mb6EJuNHMcnlm7HGrsoNt
	 y3Og2Z2KdR+rQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4221C54F2E;
	Fri, 23 May 2025 01:39:42 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Fri, 23 May 2025 09:39:18 +0800
Subject: [PATCH 1/5] power: supply: core: add resistance power supply
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-qcom_battmgr_update-v1-1-2bb6d4e0a56e@oss.qualcomm.com>
References: <20250523-qcom_battmgr_update-v1-0-2bb6d4e0a56e@oss.qualcomm.com>
In-Reply-To: <20250523-qcom_battmgr_update-v1-0-2bb6d4e0a56e@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 kernel@oss.qualcomm.com, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747964381; l=2414;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=f6uhUoiZgOE/CV2wIB6Vwbi/lg0mxjoGmX0Qx7uMFHM=;
 b=HavpWuoflKPkvLhIXTCTWteE3MCnA7mz0fzb82RXZsFgESETNfNw2ByeyNax8y4mAlig1LSfN
 YnWlxV4c8TTDjW73aheEdDmchvfPruEN+IFVlXXbax9vPMrKgKR63G/
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Some battery drivers provide the ability to export resistance as a
parameter. Add resistance power supply property for that purpose.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 Documentation/ABI/testing/sysfs-class-power | 10 ++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 560124cc31770cde03bcdbbba0d85a5bd78b15a0..22a565a6a1c509461b8c483e12975295765121d6 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -552,6 +552,16 @@ Description:
 			Integer > 0: representing full cycles
 			Integer = 0: cycle_count info is not available
 
+What:		/sys/class/power_supply/<supply_name>/resistance
+Date:		May 2025
+Contact:	linux-arm-msm@vger.kernel.org
+Description:
+		Reports the resistance of the battery power supply.
+
+		Access: Read
+
+		Valid values: Represented in microohms
+
 **USB Properties**
 
 What:		/sys/class/power_supply/<supply_name>/input_current_limit
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index a438f7983d4f6a832e9d479184c7c35453e1757c..dd829148eb6fda5dcd7eab53fc70f99081763714 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -220,6 +220,7 @@ static struct power_supply_attr power_supply_attrs[] __ro_after_init = {
 	POWER_SUPPLY_ATTR(MANUFACTURE_YEAR),
 	POWER_SUPPLY_ATTR(MANUFACTURE_MONTH),
 	POWER_SUPPLY_ATTR(MANUFACTURE_DAY),
+	POWER_SUPPLY_ATTR(RESISTANCE),
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_ATTR(MODEL_NAME),
 	POWER_SUPPLY_ATTR(MANUFACTURER),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index c4cb854971f53a244ba7742a15ce7a5515da6199..de3e88810e322546470b21258913abc7707c86a7 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -174,6 +174,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
 	POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
 	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
+	POWER_SUPPLY_PROP_RESISTANCE,
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,

-- 
2.34.1



