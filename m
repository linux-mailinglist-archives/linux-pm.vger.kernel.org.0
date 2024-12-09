Return-Path: <linux-pm+bounces-18810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A11FA9E90C9
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 11:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CF8280C92
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 10:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADC1216393;
	Mon,  9 Dec 2024 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoItZtL1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B42130AC8;
	Mon,  9 Dec 2024 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741202; cv=none; b=qsGg9SaQRn0OWaK2cUXE0lvxnaQAg33yhIoWkNCT07/DRfMJu+2ccxp4frJtTz8t1OIcHArKZx6dCvT/XHCmr9cXjvkYsV1u+epApmOAxqJdf6aQoHb8DIDu019FVGyD/1g5By/JAoyU2+1MZkNuNG5gBfsyZif1DYbJ80pPyc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741202; c=relaxed/simple;
	bh=ficvqIcjUVmyYtMbNfutVkfgvZVWzK9sxXwvtshVcDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dmPfPoil1yFWLqotdqu/P+/yv2KbNCFVmAinUHtqd5uNNgMdENYcvfz7eU/UQ2Nt1W/Jen9qz3qCFXoBE90pXsV0eI9oE3yAFE86RUFOdEvTBa5qd+cI7i2R1V7QUXRHQWRLLy2zqjwDzPjKAmjDY1gTbGvzMwrZHglE3rnlnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoItZtL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7113C4CED1;
	Mon,  9 Dec 2024 10:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733741200;
	bh=ficvqIcjUVmyYtMbNfutVkfgvZVWzK9sxXwvtshVcDg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ZoItZtL1ryOcxTz9cH/n2GgrlJXRTgRd8X3JmrOl9dK9+BTUUyBCaNZUPJBk5oEcP
	 m77Js3Otu6rOdzSVXPAXSDz1VQyrDW8pPDqlUx84cC0QbKkj7KMF2qSbJwVa1t1EXF
	 KvQ6RIonAGaJEI2XvL9O7OedPV5BFWphSuGQTURBnyH0zSYoH8dmek/Siz9U5CkK0N
	 vg7QSx6KbY70otFsGzJtDjXy1FJYHhGnCfDh26KXfY6UE/VK47J4VWwP+2q/X+RRX3
	 3iPJgm/RJYo5ktYSKjdvOxZ8aBgRzpc4Uwq/w6PZoqn+z2JNL4tk6m370bh1uTAhsm
	 rc5Lb//mlqbOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA342E7717D;
	Mon,  9 Dec 2024 10:46:40 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 09 Dec 2024 11:46:15 +0100
Subject: [PATCH] power: supply: gpio-charger: Fix set charge current limits
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-fix-charge-current-limit-v1-1-760d9b8f2af3@liebherr.com>
X-B4-Tracking: v=1; b=H4sIAHbKVmcC/x2MQQqAMAwEvyI5G7BFD/oV8VBrqgGtkqoI0r8bP
 A6zsy8kEqYEXfGC0M2J96hgygL84uJMyJMy2MrWxlYtBn5QjajxlwjFE1fe+ETXUDOOLkzBGND
 8ENLtf90POX+owkMkagAAAA==
X-Change-ID: 20241209-fix-charge-current-limit-a5e5bbafdf11
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733741199; l=1471;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=JMP/YPv48CKxY8k+OHWu1fWQP76Gr1cU/J9kXPrJcps=;
 b=BYybNBmEiGJm6J9m12P59VausTgYIExWvufe6VUrPuap1Hx5eJ7OG9YSOmiA/l0w0NPXVI/EY
 ZT1wKRPwS8uAgh5NI+K3CIJdEfSKOsTWHGLMq+HhoSwguHe5ryQ6IC7
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Fix set charge current limits for devices which allow to set the lowest
charge current limit to be greater zero. If requested charge current limit
is below lowest limit, the index equals current_limit_map_size which leads
to accessing memory beyond allocated memory.

Fixes: be2919d8355e ("power: supply: gpio-charger: add charge-current-limit feature")
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/power/supply/gpio-charger.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 68212b39785beabfe5536a18fa15bc249f7b1eea..6139f736ecbe4ffc74848797a72095f4cadf3b62 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -67,6 +67,14 @@ static int set_charge_current_limit(struct gpio_charger *gpio_charger, int val)
 		if (gpio_charger->current_limit_map[i].limit_ua <= val)
 			break;
 	}
+
+	/*
+	 * If a valid charge current limit isn't found, default to smallest
+	 * current limitation for safety reasons.
+	 */
+	if (i >= gpio_charger->current_limit_map_size)
+		i = gpio_charger->current_limit_map_size - 1;
+
 	mapping = gpio_charger->current_limit_map[i];
 
 	for (i = 0; i < ndescs; i++) {

---
base-commit: 88e4a7dc04b7828315292eb3acaa466c9c123d8b
change-id: 20241209-fix-charge-current-limit-a5e5bbafdf11

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



