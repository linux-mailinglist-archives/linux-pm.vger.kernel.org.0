Return-Path: <linux-pm+bounces-17780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6659D2D91
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 19:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5BA2839AE
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 18:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555A11D1F44;
	Tue, 19 Nov 2024 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="bc4gvqLz"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD001CF7BE;
	Tue, 19 Nov 2024 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039734; cv=none; b=fAMoQ1R+cxtFLfsEy+zGDk8gjIVuV4YNj5QOdyZsXQnZka58uZSSF6UlOqNutBP/ft5a7T1/bHwiNCuTTtxkSgT5BZCILzKPzwt95TfMlFJQ8r70p0EhBL0jpoTNUBp7Rbv8Vm//Sdxy+58y15/jy/ThMteJjllC4oZbVLA9K8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039734; c=relaxed/simple;
	bh=sK0kWk+8VYxo38aU63eiYOmeLS96q4K2u2uUzpGH55g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnNztlO4sLzJstFm3mGlX51akPFPsJ5Qxh9kV3+LHWBLlfZyG93La0xTYjccmQuyZICpqp6YIIdhhcrSfj+Z/ARPc2A9tZ9lqFPFo8jNV/ui8poqReLCbN4ot5/c9AdSwfvbnNgWbkps/jFP4u035P9qO6lJzEt+C0tZpoYl/fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=bc4gvqLz; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id C75BDA03A7;
	Tue, 19 Nov 2024 19:08:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=270OS3AUGIEnFR7GA4rh
	i6oZuXf4WByJ/XiZ6z+upJg=; b=bc4gvqLzbVFWqe+IC4gS0BSPTyUDFM5IFyL9
	YioQwbmm0yzLmIa+PPN+CAsM/eGIaPbdyhBCleLgvkJLp1XokLmcwHnrYtQh/uQO
	PwgtPP6vtmj0WsLhPcyf3NKkd7ejeIXPSFcYaM+Vz5b06ke0Vin7R64Bb7O82ohF
	QdOZVjdLwjUOLZMoSPxW8NoUKwoDXqOee7F2EeDoY21CIWCLqiEiClcx0yVSL52A
	ROS5R2Ns2Ni/sPlQ9h7pcooZs07Dep6kVlWb7EN43/pM6nDi1hHv/Y95lksyZVTH
	hfMKLYAs01kjuVUuINa9EOclCs+q6QEDsZY+yQkauDtymBPIoFYoAOphYgvmAaS8
	wJ1bJeN+P/u4E7RXk21nTpqZaP2kTsT6BRAEfwE5mkBbx0NsCQwZw6icINmjULk+
	3agx/SwRRrECMkKyL7w8HZrKwj2hvumeXYFjVdKeDVU6T2U6ALe1Y6RWMsyLINfw
	4DehlzHllnN2T2gX03whnKdnd8x7apcAIU2sBk94jfoeCgqS2ECReUUUilP+gHl7
	PvvMTKgKBaLwsJ/0e1/6qcW0IW9/Xp8wIg89kH92zBuM6HADYz1zUMa8eut83i3Q
	RCTrB9BQ9UxuSvlOst5UrFtk06oO3/P/DZMixSsyI0vgFMwuawHfa+z+oGwgbcUr
	upawQ+k=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: Sebastian Reichel <sebastian.reichel@collabora.com>, Samuel Holland
	<samuel@sholland.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v5 2/8] power: ip5xxx_power: Fix return value on ADC read errors
Date: Tue, 19 Nov 2024 19:07:34 +0100
Message-ID: <20241119180741.2237692-2-csokas.bence@prolan.hu>
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
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732039722;VERSION=7980;MC=2672693322;ID=46207;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485560766B

If ADC read returns an error, the return value was silently ignored,
execution continued and an uninitialized value and a return code of 0
was passed back to userspace. The only exception was
POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT, which bailed out correctly.
Fix returns for the other cases as well.

Fixes: 75853406fa27 ("power: supply: Add a driver for Injoinic power bank ICs")

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/power/supply/ip5xxx_power.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
index 2d4435881a9e..41d91504eb32 100644
--- a/drivers/power/supply/ip5xxx_power.c
+++ b/drivers/power/supply/ip5xxx_power.c
@@ -395,18 +395,24 @@ static int ip5xxx_battery_get_property(struct power_supply *psy,
 
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		ret = ip5xxx_battery_read_adc(ip5xxx, &ip5xxx->regs.battery.adc.volt, &raw);
+		if (ret)
+			return ret;
 
 		val->intval = 2600000 + DIV_ROUND_CLOSEST(raw * 26855, 100);
 		return 0;
 
 	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
 		ret = ip5xxx_battery_read_adc(ip5xxx, &ip5xxx->regs.battery.adc.open_volt, &raw);
+		if (ret)
+			return ret;
 
 		val->intval = 2600000 + DIV_ROUND_CLOSEST(raw * 26855, 100);
 		return 0;
 
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		ret = ip5xxx_battery_read_adc(ip5xxx, &ip5xxx->regs.battery.adc.curr, &raw);
+		if (ret)
+			return ret;
 
 		val->intval = DIV_ROUND_CLOSEST(raw * 149197, 200);
 		return 0;
-- 
2.34.1



