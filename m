Return-Path: <linux-pm+bounces-18781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F8A9E8559
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 14:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7F716461A
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 13:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7390145B25;
	Sun,  8 Dec 2024 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="YUnWpuGK"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FB95A4D5;
	Sun,  8 Dec 2024 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733663751; cv=none; b=or3TyxR4Iyr1jNf1j1M1cx+okdwTh5H2Gr9ujx5QV8uCd5ydWv4I16Cp3N7tZo89GOnLlBlLY1OlOlPKSIKviyGgHvfh0ZoFzmf8Uk2y7p3QRNX8r1aYaeII58ebVyv3ncCIsfD5knx4M7X7K8ifbS8hVL36RKJbtlK93jSJ5is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733663751; c=relaxed/simple;
	bh=Zy+BiXCgJkXzmbZKNg4JIOZSni09+NJt26bJv765OeE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DWOeGox8h0cHPuDEIWJ59AsyNQVy1hrmGql3dfF9E8YvDgoaT+aoeJuWjq7f/sP6zevhI2PKyT4m9X9mD29PSfsHN/Wcg0MOQWT2eh+89wRUjJDz0ncWvoao/V/q5VYrtGUfFFUpdbv1mlye7HLa9JEWz2UG7CXL7LgQj9hCpQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=YUnWpuGK; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id D19C2A0ABF;
	Sun,  8 Dec 2024 14:15:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=g0j7uEQzEdIZe0t6bf6kIsjV47fqKToNQDecUmLy4A8=; b=
	YUnWpuGKYtOySFxuFCBGxvwcY0eX4vaufP/kui0yrTIQhYE7kcAq252q2WRwQWBn
	BIhM9umwFUUGsZERIWKgOGaTIObhcf0awUs5aIQffKMlmKcWed0RnSnJz1J5M3Xn
	qid6RiMAIRnMSwv5gwd3xYZ0fJoJJ1Ge8poRuM5AVW7bfMUg27HBJuSqmfGhB/3n
	xs1GYGJqQEM9hMAfxSU8Cwem6cq6+VRIdPejTHwHrmqQKJWciWkgBWA155xLOnW/
	G4/joorSMJmMJEm74bHNddGrdoK8O5Cg7QLoyiwF5HyDnBelq7QB6oBaJdsyjVuk
	+Yng+17nOaaqau0O1ULqTGQZr84eadX4FC8oITMI6VGBx8WTNYNuzN4xLb4vvXi0
	nT8hl5uyhHfOpJGehimpthAYsQgIjjztWEM2G9F6jZzpVMqGyk01aei9UPgtqsJr
	BxcP1h/YXM5vpOcE6JU3rwS/e+X9oPBjdPF0LRi3OM8qq9s9/opc1Gk9itxDCVap
	hBSWyzNwkqKZeV80JGKlKxIadU3VpU06CXiBWIhGJxUWyCT9QCB7pMhtTHFx7lnE
	a4leoj/vzLkKTryY52b6sjz/W7tZ5qamAjkY1bjA4PtipH4bJgFdlAqFWpgpBmCE
	D+pRytKQiRekhOC2PTnz8WrKnBAOrmRiEiKHE5HQa3s=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Kees Bakker <kees@ijzerbout.nl>, Samuel Holland <samuel@sholland.org>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] power: ip5xxx_power: Fix uninitialized variable read
Date: Sun, 8 Dec 2024 14:15:31 +0100
Message-ID: <20241208131532.1028581-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733663746;VERSION=7982;MC=3149856342;ID=289680;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485562766B

The check for whether a charger supports the requested
battery voltage was incorrectly added to the
`ip5xxx_battery_get_voltage_max()` function, instead of
`set_voltage_max()`. This commit fixes it.

Reported-by: Kees Bakker <kees@ijzerbout.nl>
Closes: https://lore.kernel.org/linux-kernel/b547c228-df70-4137-9e96-175923f62404@ijzerbout.nl/
Fixes: 8584bc5df539 ("power: ip5xxx_power: Allow for more parameters to be configured")
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/power/supply/ip5xxx_power.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
index 46f8eb7100c1..d076b4e46194 100644
--- a/drivers/power/supply/ip5xxx_power.c
+++ b/drivers/power/supply/ip5xxx_power.c
@@ -367,9 +367,6 @@ static int ip5xxx_battery_get_voltage_max(struct ip5xxx *ip5xxx, int *val)
 	if (ret)
 		return ret;
 
-	if (*val > ip5xxx->vbat_max)
-		return -EINVAL;
-
 	/*
 	 * It is not clear what this will return if
 	 * IP5XXX_CHG_CTL4_BAT_TYPE_SEL_EN is not set...
@@ -504,6 +501,9 @@ static int ip5xxx_battery_set_voltage_max(struct ip5xxx *ip5xxx, int val)
 	unsigned int rval;
 	int ret;
 
+	if (val > ip5xxx->vbat_max)
+		return -EINVAL;
+
 	switch (val) {
 	case 4200000:
 		rval = IP5XXX_BAT_TYPE_4_2V;
-- 
2.34.1



