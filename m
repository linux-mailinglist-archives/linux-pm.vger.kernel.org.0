Return-Path: <linux-pm+bounces-25580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 173DAA90E99
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 00:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9998819045F3
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 22:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D39238D2F;
	Wed, 16 Apr 2025 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljF9mtKp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6C9238C37;
	Wed, 16 Apr 2025 22:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744842465; cv=none; b=LCIN/OwV3ZTkhvrXho0TZDu9/oTYNxVk9vOu8SmJJqloHmH6X6sakzLN4o7FjyU3VBZAI0b3dexOZsdpZA3ax3RZn+fbQOCKnp9HdqjZRiHS7rs9QBfAdu/xvi/yCTEW1criE13VDFH7pgfhVekHIjNFF4cCrdu+rsGhyndcK1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744842465; c=relaxed/simple;
	bh=c1YE6Ln7/7gaamvCWhA5mV5HvtaQQs3Gef2ZyksqHjE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y7KZj+p9F7027fXJTBRQWT9rISy+Hlh50BPfF+U3djF9evo0rd48WOhuiiFcBVOOJTjeH3LtlvTYTTHuMvE8+v9PEang8uY0Dd01lC1K7TKYh85P2GBIPgnAAL+3mDn+QJh3/NQR33xLl/mrTsGGGnphNjbPTX1xPWMe945eUGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljF9mtKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED96C4CEE2;
	Wed, 16 Apr 2025 22:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744842465;
	bh=c1YE6Ln7/7gaamvCWhA5mV5HvtaQQs3Gef2ZyksqHjE=;
	h=From:To:Cc:Subject:Date:From;
	b=ljF9mtKp7WgPUHLfBJzn7Oahtqq0dc/nBA/m/8OVFTJPfo/1lpsFsyDufm9zHcX6W
	 Qk0uSve/xhoyh2Ixo0IPbQSNNR4Y2lHyfztnESEeY/5LD/v2QdkG5g84gYT3dhWg8+
	 iZvGummtbiyEpXu4E8tnIcQ3Vd5zb7APVtodWZb2pDeaW5YsAb/AioVmxmOFlnebp6
	 77a47H3OqjZMacLSJpdOAvPe36Zh/S4WuoVaeQUn4aKenydzidT99MnlYyNDAI3GuK
	 g4RKuMVGxcAi7Er9voVTjraOAjWwCO0DBzqwYeWQ4IZzywVHk8DiFnF6G1TN9h+sT0
	 +fsihPUzyof/A==
From: Kees Cook <kees@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] power: supply: sysfs: Remove duplicate NUL termination
Date: Wed, 16 Apr 2025 15:27:41 -0700
Message-Id: <20250416222740.work.569-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1940; i=kees@kernel.org; h=from:subject:message-id; bh=c1YE6Ln7/7gaamvCWhA5mV5HvtaQQs3Gef2ZyksqHjE=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkMenfWXPT6r1e5Ybs1V6/DW65LV9Pirs3yXSr61Mze9 fay0KjGjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIlMPM/wT0vC74lqE9eJN5wn a89f+LhuX+ltxwLBhB4X9ZBUL87KakaGcxffmRtJ8B81nObJ0bFW9Ih11Yv2ecZns4rVTngU2Zn yAgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

GCC 15's new -Wunterminated-string-initialization notices that one of
the sysfs attr strings would lack the implicit trailing NUL byte during
initialization:

drivers/power/supply/power_supply_sysfs.c:183:57: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (32 chars into 31 available) [-Wunterminated-string-initialization]
  183 |         POWER_SUPPLY_ATTR(CHARGE_CONTROL_START_THRESHOLD),
      |                                                         ^
drivers/power/supply/power_supply_sysfs.c:36:23: note: in definition of macro '_POWER_SUPPLY_ATTR'
   36 |         .attr_name = #_name "\0",               \
      |                       ^~~~~
drivers/power/supply/power_supply_sysfs.c:183:9: note: in expansion of macro 'POWER_SUPPLY_ATTR'
  183 |         POWER_SUPPLY_ATTR(CHARGE_CONTROL_START_THRESHOLD),
      |         ^~~~~~~~~~~~~~~~~

However, the macro used was explicitly adding a trailing NUL byte (which
is not needed). Remove this to avoid the GCC warning. No binary
differences are seen after this change (there was always run for a NUL
byte, it's just that the _second_ NUL byte was getting truncated).

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Sebastian Reichel <sre@kernel.org>
Cc: <linux-pm@vger.kernel.org>
---
 drivers/power/supply/power_supply_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index edb058c19c9c..439dd0bf8644 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -33,7 +33,7 @@ struct power_supply_attr {
 [POWER_SUPPLY_PROP_ ## _name] =			\
 {						\
 	.prop_name = #_name,			\
-	.attr_name = #_name "\0",		\
+	.attr_name = #_name,			\
 	.text_values = _text,			\
 	.text_values_len = _len,		\
 }
-- 
2.34.1


