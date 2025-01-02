Return-Path: <linux-pm+bounces-19896-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 460B89FF88B
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 12:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EABA97A1404
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 11:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793851AF0B4;
	Thu,  2 Jan 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tel1G9tD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15E1AD41F;
	Thu,  2 Jan 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735816564; cv=none; b=nv/1ixVpGLhAfTO8AFdRumUFXuXKqkCRpWaQn1CtxN0oqSCtLdvf+S7BNLCDndgzH2q24S9HzHmWUgeF30YuCys3XOzH9rjSGqvHFXHjom9k7TTxFJcGuwFPtnMQepTC/TeLrUvv+gQEa/VDJNnWzBbCOYcgWaX0GIN4dGItU2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735816564; c=relaxed/simple;
	bh=TzjaYhY/z3XxXLGIN2R6r5WrYgQeVscsnkIXZorYgOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XlGJPnAoLgYO+TP9O0YnHCkGvtHS15DH2F8FDDERFuCkkVEXZ8gpHkh8uJiIxmt/qWOVsUMRc4q2wHm1Kx2la0Nx7mBGFleJzlupim9rk3nAFg6hhOxTJhB6NgyDF5Fm4kXtK7g34i5/DEaYuOEdtPLavjcsb9G3QbhWnmYQqn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tel1G9tD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBB29C4CEDF;
	Thu,  2 Jan 2025 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735816563;
	bh=TzjaYhY/z3XxXLGIN2R6r5WrYgQeVscsnkIXZorYgOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Tel1G9tDHbWDZKJA0yBm885Spi5Hv0lyWtvKOOeYMwHTURcTQMaoXl8s81R0ZRtoM
	 iJmhF7GiURrp7P5zJmhhjPIe2Gjs654OAkSQDepm4v9ICVoPfixP6t46SFkvRTSxBG
	 zoEr6iBi2T+ZP04eHVuein2/px8+IslsMqbJlDnDN7XxXw4m7oazWqgOyzFGM1yLGe
	 DoyVHHbDEU0MiveeGVkZlDw2Wr5h8IBL+inL29Fo+ytxJGQKUXQtH3lQIr8kWU3qyh
	 Z7voe7ZaGgzDqSRP2Ao2uaC31hsyQKfzCYyukGWwi3miHk1yPJjsMk7dBD8HdPd1oT
	 2jvkBTvgPkuQg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B5BE77188;
	Thu,  2 Jan 2025 11:16:03 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Date: Thu, 02 Jan 2025 12:15:05 +0100
Subject: [PATCH v2 3/4] arm64: defconfig: enable Maxim max1720x driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250102-b4-gs101_max77759_fg-v2-3-87959abeb7ff@uclouvain.be>
References: <20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be>
In-Reply-To: <20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, Thomas Antoine <t.antoine@uclouvain.be>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735816515; l=716;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=4mcHoKDe8g9Cb02OHRiFohYMU9w9oiqZT1kzkWCs778=;
 b=u0MDFhtyvDcPVMHQuoWVOLHGPzXV3ocxbaOLiaQom2uPtJRuCPR0HfSqrffKvygn/k6OgR/84
 UQ452q5sO5HDwZZZ+qihb1/5ZRmhVbSBhf9AHV5ljOjW1yQ/N3jmcky
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
index d13218d0c30f458d9c555ab9771a1fd9139ce1aa..7161387d1ebfea0d363e9413ef4350d83b581d96 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -676,6 +676,7 @@ CONFIG_BATTERY_QCOM_BATTMGR=m
 CONFIG_BATTERY_SBS=m
 CONFIG_BATTERY_BQ27XXX=y
 CONFIG_BATTERY_MAX17042=m
+CONFIG_BATTERY_MAX1720X=m
 CONFIG_CHARGER_MT6360=m
 CONFIG_CHARGER_BQ25890=m
 CONFIG_CHARGER_BQ25980=m

-- 
2.47.1



