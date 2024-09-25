Return-Path: <linux-pm+bounces-14655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44FA9855B5
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 10:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210681C2353B
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 08:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C33915C158;
	Wed, 25 Sep 2024 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="pOyL/GN0";
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="DT5QwhE7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2710915B13B;
	Wed, 25 Sep 2024 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727253682; cv=none; b=t1qJdLqIH15QK0W2U5FJZN8KZhNORs8Q8RHm61G+TUDX9CgZAGTqlF7zCFGDrmZHQo29R17+wu4NDKaHA9mR6afjVu8KmL8z37yNy9Llm2robl9b+o6gPkdrB4xmjJlk25pyprr4Bgr/2J+kbwfBhTiSFltePr0kG+g43ucmxOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727253682; c=relaxed/simple;
	bh=vBaqOcqNj5T8LS+byp35Q9FBu8zSFtnOCozZvMA2qho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIEEJR409xKA6D5xNVxXEij8J51UaJs/AYqoH6aGnhYi/2cAK5Q4JWt3aWhS0+DLewcPGLDolftSiNhMUYakQ7IMSRE6KQJuIeT/kcsFqGxmpapI7EMHeMGubeNiH1ktDhGYkZV4WxZRs4WFxkNY7u098OOtQl35u7IyJSqtjD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=pOyL/GN0; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=DT5QwhE7; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1727253676;
	bh=UJkrD0miLp4a4Zo5g/VtOZ4P325J6Pf+4p1AvxxqzUU=; l=1043;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=pOyL/GN0j/K5Iz5x/+oDSQhv1br5pwjC5WGby67bD3DwloEhRlGz8OsfhpMqgQ2Wz
	 MzgkZxG9isWyXT2Ge+TQbTBGdZJjgSz1xJHgbKwkqMtZ2225JT2Gp4aS4nvoQRJMjA
	 yCAV1j0brdPN6g/Gxc4vxGusZBj6ozspZDsW0eB6eEHYvaYt/Kfb/jiF3U0E33DkDY
	 ShZL7TWaoEUoMFwekH5gLkyu8pz3PmlZcEcUCB0D9N8W5jkdKHJWl++cNjt65Xg6X9
	 i2pj8fg5hymEv7Ab1tmBfbDYrTkzCOQsBCk2RWOQhEzp5uMGnExlSAGwOyCufl/dM5
	 WnY4odeV2sgJw==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(3190222:0:AUTH_RELAY)
	(envelope-from <prvs=1995EE0AA0=cy_huang@richtek.com>); Wed, 25 Sep 2024 16:41:12 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1727253672;
	bh=UJkrD0miLp4a4Zo5g/VtOZ4P325J6Pf+4p1AvxxqzUU=; l=1043;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=DT5QwhE7lQ1DyTT3P3HcPX1g8t7uWCdNXhi7TToRmZuj0jD/WW7lUTPWDejwEUkKI
	 v0nxaOyVWOZRi7Fbs96LFPq43YXP+i2P4s+VCP3WORUGgIVlNqsRks4n/b2MXParPt
	 y5paYjaYWrAuzOLxkL71Ml6wdA+KwuYCbnZeurQ94RkvugsFv9jZtC7PTeYKX1W6IF
	 DBnWJV8f/7fI6P3zgv6vdBAYbse+Zh+M2wAK/Jzom8ScziRPBl5fjmoYtw/UAFvYm4
	 vAxR+S0yv9As7SMixlVb96bikTqPuShCP2B7sSBuuORzd9TW9VMBUEeFtE3CrNRvXz
	 F/IcShwkh6qUA==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(1322961:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 25 Sep 2024 16:33:17 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Sep
 2024 16:33:16 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Wed, 25 Sep 2024 16:33:16 +0800
From: <cy_huang@richtek.com>
To: 'Lucas Tsai ' <lucas_tsai@richtek.com>, Sebastian Reichel <sre@kernel.org>
CC: ChiYuan Huang <cy_huang@richtek.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] power: supply: rt9471: Fix wrong WDT function regfield declaration
Date: Wed, 25 Sep 2024 16:32:58 +0800
Message-ID: <f862e23f220612f01fabb6d8e76cfaf63756c22b.1727252762.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1727252762.git.cy_huang@richtek.com>
References: <cover.1727252762.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

Fix F_WDT and F_WDT_RST wrong regfield declaration.

Fixes: 4a1a5f6781d8 ("power: supply: rt9471: Add Richtek RT9471 charger driver")
Reported-by: Lucas Tsai <lucas_tsai@richtek.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/power/supply/rt9471.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/rt9471.c b/drivers/power/supply/rt9471.c
index c04af1ee89c6..730b252b4900 100644
--- a/drivers/power/supply/rt9471.c
+++ b/drivers/power/supply/rt9471.c
@@ -153,8 +153,8 @@ struct rt9471_chip {
 };
 
 static const struct reg_field rt9471_reg_fields[F_MAX_FIELDS] = {
-	[F_WDT]		= REG_FIELD(RT9471_REG_TOP, 0, 0),
-	[F_WDT_RST]	= REG_FIELD(RT9471_REG_TOP, 1, 1),
+	[F_WDT]		= REG_FIELD(RT9471_REG_TOP, 0, 1),
+	[F_WDT_RST]	= REG_FIELD(RT9471_REG_TOP, 2, 2),
 	[F_CHG_EN]	= REG_FIELD(RT9471_REG_FUNC, 0, 0),
 	[F_HZ]		= REG_FIELD(RT9471_REG_FUNC, 5, 5),
 	[F_BATFET_DIS]	= REG_FIELD(RT9471_REG_FUNC, 7, 7),
-- 
2.34.1


