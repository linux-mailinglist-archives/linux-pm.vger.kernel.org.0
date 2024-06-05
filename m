Return-Path: <linux-pm+bounces-8649-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B384E8FD056
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 16:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D261F2504C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 14:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A62319D8BE;
	Wed,  5 Jun 2024 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="cXg/Qwk3"
X-Original-To: linux-pm@vger.kernel.org
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D8F53BE;
	Wed,  5 Jun 2024 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596162; cv=none; b=bNKNikUKwUG9R4UYT8wC7iABafZciS1fOD6RW6EWIYG90JPwbhmJh54yuqpppxLJrC1pScR8I4DSVePWgLTek8bnWcrMh/LeclzwVHrPffUNNzMaNHewlmUzD1sma5a3FJoCJnloRA/iE/F+D6NZhegRHSv0i2YPrTMbMrWz0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596162; c=relaxed/simple;
	bh=4tC7k/l/xaI7nEusPHODhnaab9GGYBzhfIcMqHGnSBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rHNVbpyAjtZx79G3YWoLiK46xE9+kE63H57kYoltZLG0s/Vq7ny5CFoYvOcL9pP6uuBUdftM5eZLpe8Pvu0zg6c8MJF+GF7pW2ReWUyd+Kc3ZxlGpMLpZ7D7JyfnS4aFcBaVTtIKtcSKKV9FTTuKk2kXiFODVzhFAXesPXngsi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=cXg/Qwk3; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 9DD8A403AB;
	Wed,  5 Jun 2024 18:54:08 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1717595649; bh=4tC7k/l/xaI7nEusPHODhnaab9GGYBzhfIcMqHGnSBw=;
	h=From:Date:Subject:To:Cc:From;
	b=cXg/Qwk3EzhoriIdpzqlP9fr/j5w5TSKi2y+BLTN05Yb1R66oancKd2aVtZfLAPNE
	 RIh+pmYIZzlpds+8Y4nnlJbGEJ9kKmIk9/5YeCznbE3CMbJTFe/Q4dtikUaeBfFo2A
	 2A/DB/m91qECmc99dZRBM2P0H5+wTgLnLBSwuQ7D/mtixWENP1lADWn1r53wK21Zda
	 LlNOY/nP9e0CoC/tHxQmOGNf4BDsDtsOg7SYMhvZXEcIn3A56URDThQw3FPQEg8TRY
	 eW8EGidml8b/3lsFFsNblFnR9UoYfJiHi+jGFwxVHpJ4BmmZyBg/1Sjy839Snm+0GA
	 /4x29iZnZG4rg==
From: Nikita Travkin <nikita@trvn.ru>
Date: Wed, 05 Jun 2024 18:53:27 +0500
Subject: [PATCH] power: supply: rt5033: Bring back i2c_set_clientdata
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-rt5033-null-clientdata-v1-1-558d710eeb4d@trvn.ru>
X-B4-Tracking: v=1; b=H4sIANZtYGYC/x3MwQqFIBBA0V+JWb+BKbWiX3m0kJxqQCzUIoj+P
 Wl5FvfekDgKJxiqGyKfkmQLBfWvgmm1YWEUVwwNNZpaMhizIaUwHN7j5IVDdjZbVJ1Wru2dIW2
 hxHvkWa5v/B+f5wXkdU1kaAAAAA==
To: Sebastian Reichel <sre@kernel.org>, Andrew Davis <afd@ti.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Raymond Hackley <raymondhackley@protonmail.com>, 
 Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1247; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=4tC7k/l/xaI7nEusPHODhnaab9GGYBzhfIcMqHGnSBw=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBmYG39B7ZCwIhVYTdCPuf4mGkF+mxAOWBxH+Xz5
 zozxiJIb0SJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZmBt/QAKCRBDHOzuKBm/
 dY2VD/41zDgPzecjjbDCgZ5DKznW8U4I9X1N6D5K3rzsr+HvrUS5xcLURkwj57tgGHSrN0u6mLa
 GXMzKqPPrOukvnPoflzrDgEUy18eSOYJBELjQeRL+MEJkZRfnKRr7F4E9JaL5bgrCEwpJLFNIaS
 GDa7iS1QT7klCd9kmh0unlIsvgDMlL5q3us/VwciXD6DaqJFirU/psUcU+LN3tDtMu/W+niGwWz
 htRoNwP4oS7Gs5g8NFc/CMxGHmYglsDFIwwBo7Ksl31njzyC7UWVxKDvKo1k6NU+diuF4hysVI2
 rZhXk2y4/0EfIMrAdN0YEpq0JoJzqotCXhDheeDhnOAsmWoWDhepGJYP3wxEKGwxM06O1IrTipf
 LW+/ZpS+bLlId89jNrNeC0DbiWF0LyIgMfXCZxilEIiZHYpjhTJFDPqpAFWRaRoCWT9oLquwxi3
 SD2ir2YTniNnQAPLAf6ynZiWu6dDzylzOAor4EoXdq0mWUd6Atv1bshu6Cx6iBiKWZMMp97oVau
 xYyTflXOd32lzHyadKJLspIlPwJXDiRf0alXW3lJ4scgtDx1TYCtSUOAvZjqy1tLX9a2CiCGF/n
 hXUBokUhtb6h33M+jG7hWjaFfh2OHF4lHez8r2jPkMLQRv9IjnjaHHmfHR17SXMzO17WW44NJQh
 EUm5pB2cbPckL7g==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75

Commit 3a93da231c12 ("power: supply: rt5033: Use devm_power_supply_register() helper")
reworked the driver to use devm. While at it, the i2c_set_clientdata
was dropped along with the remove callback. Unfortunately other parts
of the driver also rely on i2c clientdata so this causes kernel oops.

Bring the call back to fix the driver.

Fixes: 3a93da231c12 ("power: supply: rt5033: Use devm_power_supply_register() helper")
Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 drivers/power/supply/rt5033_battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply/rt5033_battery.c
index 32eafe2c00af..7a27b262fb84 100644
--- a/drivers/power/supply/rt5033_battery.c
+++ b/drivers/power/supply/rt5033_battery.c
@@ -159,6 +159,7 @@ static int rt5033_battery_probe(struct i2c_client *client)
 		return -EINVAL;
 	}
 
+	i2c_set_clientdata(client, battery);
 	psy_cfg.of_node = client->dev.of_node;
 	psy_cfg.drv_data = battery;
 

---
base-commit: 234cb065ad82915ff8d06ce01e01c3e640b674d2
change-id: 20240605-rt5033-null-clientdata-3743d68d504a

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>


