Return-Path: <linux-pm+bounces-18351-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA659E049E
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 15:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4137DB32C70
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEE31FF61E;
	Mon,  2 Dec 2024 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jz8XLa9a"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16E01FDE05;
	Mon,  2 Dec 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144902; cv=none; b=JFcQMUEAN98Hq6j4mkp2OoaB+s+aOEgcGZ10Zlcc+IxWoIWy+d94aXWPKhMH7lrenbwwdCeVVJYZTRajrHPmj5f4hAYq7wsXGqYJDx7Fcfy2B9WJ2C2t+XnwOuC5F7u6QV5w81dtDZaW0r2IYlwN5Snae12egPks1qapItM0OYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144902; c=relaxed/simple;
	bh=Ef2b8udLHuXGFaC72TBWdqafXfxqKV9+55Tg/ue3f4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nob6B4p3ycQl1w5NjwIrLgMBj1ZaoxbwDLCzHAvJPnCncME8/wX+xfe/FwFOQl4CNu3CdgdC7MEJ3QPiSzVimlMYGhstK2dC4DF/QJPUyCBvaCiRDrXNvV6zVjvGD0qaTq4wtg7oH/HNHwJkOh+mdRDfPEcreLM/Ajg2RmO+eK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jz8XLa9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B835C4CEDF;
	Mon,  2 Dec 2024 13:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733144901;
	bh=Ef2b8udLHuXGFaC72TBWdqafXfxqKV9+55Tg/ue3f4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Jz8XLa9as+dSkLfDf/HTz3nQ8di7RoxUnOzJj5YZm7N0tuhlpEWQteg5decI5cqy6
	 si39MXQTXML09R5D+8Ecrvp9aNfXMK12PuITXtrIgJgtd8NQT41dh46bs6b0tljKGl
	 vWsFh2LXgT5xJLn9jP/vxSBoUs8X1WJOB6te/DK6c9qoslNTITYIAfvxY5pfIqXP04
	 PrMxFFJ01gai+TO2BByJee1zn+rb4HUuGSh6QCDHa47BZ4SHzJiwP0z1p8hjwcLMGm
	 cKBAyGVSPhiELkoyu5xxJIF7UzutgkHc9zeN6pWR96ZIWn4I1uF/QfmOXoORsdUgda
	 7HhfmIxkT5RTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601EAD7831E;
	Mon,  2 Dec 2024 13:08:21 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Date: Mon, 02 Dec 2024 14:07:17 +0100
Subject: [PATCH 3/4] arm64: defconfig: enable Maxim max1720x driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-b4-gs101_max77759_fg-v1-3-98d2fa7bfe30@uclouvain.be>
References: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
In-Reply-To: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, Thomas Antoine <t.antoine@uclouvain.be>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733144859; l=718;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=ucQGph6fETnDzKTb3OS0faNFj61tkZWbwahqqiH/Ct4=;
 b=y+t6HStF+LnskISJskU8kHe4uHWfGmyfR/MuVZ77JEhlbV3eIjbigVk184uDWmagPkGdPINld
 Nd5l7ROflaEC8lFm6zxOk6bbNyZEaeI62TMXepJKVlkYcn2BsMAic7w
X-Developer-Key: i=t.antoine@uclouvain.be; a=ed25519;
 pk=sw7UYl31W1LTpgWRiX4xIF5x6ok7YWZ6XZnHqy/d3dY=
X-Endpoint-Received: by B4 Relay for t.antoine@uclouvain.be/20241202 with
 auth_id=289
X-Original-From: Thomas Antoine <t.antoine@uclouvain.be>
Reply-To: t.antoine@uclouvain.be

From: Thomas Antoine <t.antoine@uclouvain.be>

Enable the Maxim max1720x as it is used by the gs101-oriole
(Google Pixel 6) board.

Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d13218d0c30f458d9c555ab9771a1fd9139ce1aa..e7523e53f2ed26bab39e64f3b2d8c8afc7c1a1f0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -675,6 +675,7 @@ CONFIG_NVMEM_REBOOT_MODE=m
 CONFIG_BATTERY_QCOM_BATTMGR=m
 CONFIG_BATTERY_SBS=m
 CONFIG_BATTERY_BQ27XXX=y
+CONFIG_BATTERY_MAX1720X=m
 CONFIG_BATTERY_MAX17042=m
 CONFIG_CHARGER_MT6360=m
 CONFIG_CHARGER_BQ25890=m

-- 
2.47.1



