Return-Path: <linux-pm+bounces-17783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2A49D2DDF
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 19:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5216DB326B9
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 18:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF5B1D1F63;
	Tue, 19 Nov 2024 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="YnsSL5DP"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B1A1D1732;
	Tue, 19 Nov 2024 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039735; cv=none; b=qS8d3+YzCVQiz+vj54LtI/SpcBTX/eRW3UFpixcjrTpCcrURBF9S8Be64Xu50F6oCeH7iuFuCLI61KseD/0h5FK49qwTO2h0w/zEmyl+TKGD7Cg8+VWG3zdpaQvaRkuQyVGDF2TVSOy/EYC+Mr3qdCAq+2sCwj6OuynYDY8zZp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039735; c=relaxed/simple;
	bh=QMtBfhtTlHfsdEoh3XM9jFRvdp24kjAxNb5VL/C0pyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c9fJJEQDHviGd/D9PAoOquO2k6hxqaY5ODuCii25BHZlKYN5d4TYmkvA9GvXbDIDbykxSYUVYuh851nGf3xTuTSraXujVRwyxqQHwbPb37XZc1CZZpjQGt+iqSW5PKAmD+a+h/iYOgVsChV4HacOMI1En8ruwgNG1JLzXwP2oL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=YnsSL5DP; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E32ACA07F6;
	Tue, 19 Nov 2024 19:08:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=isRLwKhaB9+ltdY1R8uG
	bDhQIkr6AiXSPgcO0Y4Qig0=; b=YnsSL5DP8yzXr9IsQ9WJeRbowmeCvznjy+9f
	qWU404k3vt9ysyS8cFc153QPOV+HWWuvOjZPuZSqYrGF5z6uNm3rousHCalfDT1u
	7ymhzNoc2G1fIzUsX8C/CQaLbZkTEqRlSE86ZhAHXnwRthbe4eLeVnYOrCF+tH6g
	klLhL1aQ/25Q6mt457nGdDhtFde00rPB+9ohOZhmzyCh2z8cifzNesWHU/HN3Gkz
	cGUNzJbEOYH3/Lskw3JfPURxrPV1vuI/nOpQHyXKMtaoIHZe+TT/q7R51ZaiJct5
	4H0dFFIfF+/0bKVldihYosrN3/oqQPzuTAlZqljgg9Y220jGy5HffmjVp7rpFa7I
	XpiK9iD4vQH4CfFjbJKkoj2MZC/0NdDERnMOKv37xe4vVPUDrBCuaXDW4loxzcEA
	z91116PlfvykLIDy4a2L9xVyvVV4Qh0vnNEelVZQspKHAbImhrC+0YlaZP4WcFnR
	T4xpYJmG6PRjkj4G46yT0NNwUQ/xoXCWRz6Tu88YbFSfPEUQHTKuXq8VofL0i2lb
	iLtunkEGkyZ5osmHXn0dZ1M57jbJVRBEA2sROo2hqiO2JiSOP1i/4WdaWwzsB5Bt
	tlKJoHLldYspQsOj6s+QC9ZxCJp/VsRYRDCOXuwiee8RRBuVpwONH/nh+A/wX2g3
	GncNBD8=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Samuel
 Holland" <samuel@sholland.org>, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v5 5/8] power: ip5xxx_power: Check for optional bits
Date: Tue, 19 Nov 2024 19:07:37 +0100
Message-ID: <20241119180741.2237692-5-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119180741.2237692-1-csokas.bence@prolan.hu>
References: <20241119180741.2237692-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732039724;VERSION=7980;MC=4034093558;ID=46210;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485560766B

Some parts may not have certain control bits. These bits
however may be non-essential to the system's operation,
as the default behaviour is the one we would set anyways,
or the bits are not applicable for said part (e. g. enabling
NTC on a part without an NTC pin, or one where it cannot
be disabled via registers anyways).

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/power/supply/ip5xxx_power.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
index f64767b81c3b..f47198731a0c 100644
--- a/drivers/power/supply/ip5xxx_power.c
+++ b/drivers/power/supply/ip5xxx_power.c
@@ -113,6 +113,7 @@ struct ip5xxx {
 	u8 chg_end_inverted;
 };
 
+#define REG_FIELD_UNSUPPORTED { .lsb = 1 }
 /* Register fields layout. Unsupported registers marked as { .lsb = 1 } */
 struct ip5xxx_regfield_config {
 	const struct reg_field charger_enable;
@@ -206,9 +207,11 @@ static int ip5xxx_initialize(struct power_supply *psy)
 	 * Disable shutdown under light load.
 	 * Enable power on when under load.
 	 */
-	ret = ip5xxx_write(ip5xxx, ip5xxx->regs.boost.light_load_shutdown.enable, 0);
-	if (ret)
-		return ret;
+	if (ip5xxx->regs.boost.light_load_shutdown.enable) {
+		ret = ip5xxx_write(ip5xxx, ip5xxx->regs.boost.light_load_shutdown.enable, 0);
+		if (ret)
+			return ret;
+	}
 	ret = ip5xxx_write(ip5xxx, ip5xxx->regs.boost.load_powerup_en, 1);
 	if (ret)
 		return ret;
@@ -231,9 +234,11 @@ static int ip5xxx_initialize(struct power_supply *psy)
 	 * Enable the NTC.
 	 * Configure the button for two presses => LED, long press => shutdown.
 	 */
-	ret = ip5xxx_write(ip5xxx, ip5xxx->regs.battery.ntc_dis, 0);
-	if (ret)
-		return ret;
+	if (ip5xxx->regs.battery.ntc_dis) {
+		ret = ip5xxx_write(ip5xxx, ip5xxx->regs.battery.ntc_dis, 0);
+		if (ret)
+			return ret;
+	}
 	ret = ip5xxx_write(ip5xxx, ip5xxx->regs.btn.wled_mode, 1);
 	if (ret)
 		return ret;
@@ -507,9 +512,12 @@ static int ip5xxx_battery_set_voltage_max(struct ip5xxx *ip5xxx, int val)
 	if (ret)
 		return ret;
 
-	ret = ip5xxx_write(ip5xxx, ip5xxx->regs.battery.vset_en, 1);
-	if (ret)
-		return ret;
+	/* Don't try to auto-detect battery type, even if the IC could */
+	if (ip5xxx->regs.battery.vset_en) {
+		ret = ip5xxx_write(ip5xxx, ip5xxx->regs.battery.vset_en, 1);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.34.1



