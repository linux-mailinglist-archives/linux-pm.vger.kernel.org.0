Return-Path: <linux-pm+bounces-30229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8D8AFA85A
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 01:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F7F3B2C69
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 23:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B643B202F87;
	Sun,  6 Jul 2025 23:27:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5C8F5E;
	Sun,  6 Jul 2025 23:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751844422; cv=none; b=e0CDBXprJCVo+Rd/xVc9fX4jXo1zD/KrK42Fd9QWYXYL1o7OEZdWhUJ0Z6LwIjXCa6PJmZ89uzXgiosMlakVZQzu+7OAifvYp9Fk0PNszbecPTrmiWkS6940tjn6KPHwQSC+vylR6jczwK1qyPgkULGmIVih24xasN4TA2aCaBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751844422; c=relaxed/simple;
	bh=9lxGfmcUISozwu5W56EDirysK3lXO8hUwKf67tfvces=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mXWo1gIgFSqHY9CP8/yBJU0+xJQ0xQsayAz8x505cKCm3vQl1O4ugBvjeBAkmyZrRJ3keA2vUeQCEKnoWzMRtNoZkmwIFvXNoWJzu5usIUPGj2Dnf8TJt/RZCfl3dghBOAp2i4RO96I0ZTgXj5xmiwXxMn7/8XqrBnLGudmGgDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48E6C4CEED;
	Sun,  6 Jul 2025 23:27:01 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id C3119180F14; Mon, 07 Jul 2025 01:26:59 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 07 Jul 2025 01:26:58 +0200
Subject: [PATCH] power: supply: core: fix static checker warning
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-fix-psy-static-checker-warning-v1-1-42d555c2b68a@collabora.com>
X-B4-Tracking: v=1; b=H4sIAEEGa2gC/x2NQQqDQAwAvyI5NxCXtkK/UjzEbNRQ2Eoi1SL+v
 UuPc5iZA0LdNODRHOD6sbB3qdBeGpCZy6RouTIkSjfqqMPRdlzii7HyaoIyq7zUcWMvViYc78x
 CNKRrzlAji2s1/oNnf54/3TcT5nAAAAA=
X-Change-ID: 20250707-fix-psy-static-checker-warning-f6aac00b24dd
To: Sebastian Reichel <sre@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hans de Goede <hansg@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=9lxGfmcUISozwu5W56EDirysK3lXO8hUwKf67tfvces=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBoawZD/YC+HXdf88AA+n/i6LFRetAV0P6P48i5Z
 F6eQRV+7r+JAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCaGsGQwAKCRDY7tfzyDv6
 msPYD/wP1xG6JHwI+jEm2VNDIBGITXPK6BvlQvMua5qaEzW7jKlIZFz9pl+xqttQOV4NQ4dL17i
 9NfChzAB/+Q1b0s5eG/KXMzEAROGF+UuAracYjYx7qoI4JZ2nKoJx70No8PV6YIq6j55w9GbX9n
 BmW8iI9E5hvtvJtWaqgzJsm8amn/kAzmYFRGl+tN84mh1hj1eleHgn4VWrE4lxfsc2O8/dCf6jf
 YJ3N0gvv1LL1ulXf9sAkj0Zh55GjvVAii1W2Clwd1zfA2YJCGpqbQb9DmZDX+XpMiXt6tTbFM1I
 rNECky/EYHaujudE8xqELAwcCqEYjsfP+1inXXTcuyuASYimfH2tMm20xXgHNnV0Tuzf4tGfR3J
 TfoDoQnY72BG7hjgqCyh2AVIlKunoW3DIkpy5JpGE4tNqkwuxNprrxTeQp3eIf+rfEzIc25sQG6
 GZCBOffkwEhR4DHe3NyVsbPTd9PI4d3EPQ0APvTt9FmQuYZJ4tyI7p7wZl0aVvuxMzN+V+f9FAv
 MKeSgF6AKarSoQbDslhOhqwo+IigPFNkib+AdDrmVw6dqIgI2BbBBFneO3XZeSTNpu0mCOf0bRA
 1d2t+gYkEWvV04eU/n+6mnhwP0i4v9eeDzM6k2RXP+PALQEhCCvMIpv8XxuNC3d0YyEpkxq3MDg
 dxo6o023dQEGoRQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

static checker complains, that the block already breaks if IS_ERR(np)
and thus the extra !IS_ERR(np) check in the while condition is
superfluous. Avoid the extra check by using while(true) instead. This
should not change the runtime behavior at all and I expect the binary
to be more or less the same for an optimizing compiler.

Fixes: f368f87b22da ("power: supply: core: convert to fwnnode")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-pm/285c9c39-482c-480c-8b0b-07111e39fdfe@sabinyo.mountain/
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/power_supply_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index aedb20c1d2767309ae716712f8be8002b988f1b4..7c3913155dc0b7e51cdefe2974b09a9259ccb4b9 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -212,7 +212,7 @@ static int __power_supply_populate_supplied_from(struct power_supply *epsy,
 			break;
 		}
 		fwnode_handle_put(np);
-	} while (!IS_ERR(np));
+	} while (true);
 
 	return 0;
 }

---
base-commit: f9335bb4f5d4f3b913efd5872c2794d027dd85a6
change-id: 20250707-fix-psy-static-checker-warning-f6aac00b24dd

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


