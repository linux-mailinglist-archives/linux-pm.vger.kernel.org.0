Return-Path: <linux-pm+bounces-17785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2462B9D2D98
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 19:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF6C283A09
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 18:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA381D4171;
	Tue, 19 Nov 2024 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="npSrPOzq"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AE01D318C;
	Tue, 19 Nov 2024 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039737; cv=none; b=oLonevMDAuuh8k4tQm4cDbhF0o6xfoMJTuSSMPYj2p/BYoSkcVaZCTd33VHaT3qybIwYwRSezdtDQLcBBXef8Lk1hctnUzqutQ/qh5rPmz8ii/D/FiLU8e3ZwUPEwO7mJLOHSfyZhmOh/xryJysOiHVaIq2KPRXrMe9UjCyPcJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039737; c=relaxed/simple;
	bh=eMAY9QhoCFacnRzY7PiNH5gsiAT0uv911oYuwR4P1RU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gI9t9eTmbb96bneCmBMcMnl+OeUUKoFLJkr06ohlxG/+TeYxF3NG1J9CPYRTuPxDveOagyy20wLTQHtPPT3+VVjCAGmxbgParhsSv/HGFvypwo4riAKhcQ/n0wzSdrIhRHQOsQdBbFdXIm44wRgHtZWC914cmFecjzMfnbd09So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=npSrPOzq; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 770BFA0827;
	Tue, 19 Nov 2024 19:08:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=fhXAKRdatN6V2ILwE66c
	PMcL/ll6oIIe5UPNDIhx0wY=; b=npSrPOzqCfoUityWkEm66SbTnrtwKnwsHe5W
	49gEdtOSEbysqg10UbzpdRN4SqzrPcP69TId0T8jENmvGW2TATzZalEne+bMfR8x
	Eczn9kcOrO6wZ5Yl+JUjwqPpRS/giuw57X85lyF3ss7+/PrgcMAdCYK6TjT9Wi/I
	x9R1k2IuYRN69bk6HD5oRiJThrffSEpH9td9so5Mgd09V7iuSAypOPQ/1vR61xN9
	pNOs5SmvDmMXX2/1P6cRRtyPHP6v9NiYiZQXTwCmFFmRJByDW1us6K+NzTwwEa0P
	82QRYL3SRTFVgJUUQJuHdhN+y7oe5sc90y1pZN86Xtr+m+f7yIU+lRx+UNi+1IOm
	pkMaWtpb8Dz+egavoant6M2MSJwQ7ZDMZT6U3NTlNndtoLeQgUeGeJ1Ded1PnN8O
	HTYMwokFI18hB7kUIzaneCHIjJ3AMKhFLtnepiJvEibA2hBiEVkNXmf0EMylxZvJ
	okSzrVCTM95RwmsaY2C3IS4HpgEby5Iz5JT2TCmf5KzEux2CbnKh5toSbRVPpM9D
	OLcGw1TNJbcRdc8rzgg9x67MyYh+G8gagfEgl4aS1s6FAB7XXgQy8+6PKyaoDdSm
	IKs+XlXN2StiWnUSAdDVwin5zGpRIgsAcUZ/dsLTIvlSFCzOIke6qvs2vuAqQcl8
	f0kI398=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Samuel
 Holland" <samuel@sholland.org>, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v5 6/8] power: ip5xxx_power: Fall back to Charge End bit if status register is absent
Date: Tue, 19 Nov 2024 19:07:38 +0100
Message-ID: <20241119180741.2237692-6-csokas.bence@prolan.hu>
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
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732039724;VERSION=7980;MC=966728988;ID=46211;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485560766B

On parts where there is no status register, check the Charge End
bit to set charging/not charging status. Fullness, trickle charge
status, discharging etc. cannot be determined from just this bit.

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---

Notes:
    New in v5

 drivers/power/supply/ip5xxx_power.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
index f47198731a0c..46b84fb696d7 100644
--- a/drivers/power/supply/ip5xxx_power.c
+++ b/drivers/power/supply/ip5xxx_power.c
@@ -271,6 +271,19 @@ static int ip5xxx_battery_get_status(struct ip5xxx *ip5xxx, int *val)
 	unsigned int rval;
 	int ret;
 
+	if (!ip5xxx->regs.charger.status) {
+		// Fall-back to Charging Ended bit
+		ret = ip5xxx_read(ip5xxx, ip5xxx->regs.charger.chg_end, &rval);
+		if (ret)
+			return ret;
+
+		if (rval == ip5xxx->chg_end_inverted)
+			*val = POWER_SUPPLY_STATUS_CHARGING;
+		else
+			*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		return 0;
+	}
+
 	ret = ip5xxx_read(ip5xxx, ip5xxx->regs.charger.status, &rval);
 	if (ret)
 		return ret;
-- 
2.34.1



