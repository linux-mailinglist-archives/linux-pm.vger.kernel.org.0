Return-Path: <linux-pm+bounces-15187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A549915A9
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 12:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71358284509
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 10:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7388D14373F;
	Sat,  5 Oct 2024 10:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="QvcNE8fv"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D1231C8A;
	Sat,  5 Oct 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122688; cv=none; b=Hl9Po87z+1eEA6IM+bcNXIbKu7m+541hGCDaOL98gcN0YtIrUn7zNFlpIIdkOuXRWRyTXOROq4erXJeTh/5L7Bluv+EQTV9C6K7i3nEuONewtl8Wxu7hRRMYhwccIpwyRtIo7JbmScYRJ8b84+XVneKJ1A6pa1hsd1hxk12qcAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122688; c=relaxed/simple;
	bh=TqpkU7g/Y7luq6W/VydlwUzftAlrXkbseidQfcUpmRI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dSUL91/jtXjtUnxKlvaNFvXhR84t2B9DLPbRB2XgGA0zaePen+Ifu/DvzDkxT9HspyEYPcPN1siL4K2/RZ3iN0p+VBlWSDlDuZdk0p0r6v94mn7djpwaVd21Hh6QwV8DPn0z9g5KfiN0xuBkWGMgWW5jf0dI8aEEWuZqq8nCevo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=QvcNE8fv; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122684;
	bh=TqpkU7g/Y7luq6W/VydlwUzftAlrXkbseidQfcUpmRI=;
	h=From:Subject:Date:To:Cc:From;
	b=QvcNE8fvCuWBf6mN4PF6oIGq0ZyrgqonkzqIrXkpZG34VpUz1Ody0Z5BSEEcFioFK
	 9L13MId0bHm2qVg6inxbs5bTJ2W8TYVViAFMIH7Z3FG6XjfhJTZD2B31To4ptOtEUO
	 0q42MQDOmEA+Lhoz2JrnBsWpdrdfk6PjNlBG3bok=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/7] power: supply: constify ocv and resistance tables
Date: Sat, 05 Oct 2024 12:04:16 +0200
Message-Id: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACAPAWcC/x3MwQqDMAwA0F+RnBfQKMr8FdlBbdwCoy1J3RTx3
 y0e3+UdYKzCBn1xgPJPTILPqB4FzJ/RvxnFZQOV1JRPIozhz4q2xvjdcRpTYt1xDt4S1h2RWzp
 XtdxADqLyItudD6/zvAC6rfnTbAAAAA==
X-Change-ID: 20240922-power-supply-battery-const-3722df7d16e4
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122683; l=1167;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=TqpkU7g/Y7luq6W/VydlwUzftAlrXkbseidQfcUpmRI=;
 b=VVWQylHFyGqBwlL6cFGyQsLEGzjKO8fkAuVQ98D6sHjZlMcFMXumFiD1ZjwIsfOoASNQZlyFg
 QZiNdUre9d9DuT9swV1wFUEexspr7M/loMvz9chI5gp1p3csfHQtoE0
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

These tables are nevery modified. Reflect this in the API and constify
the table definitions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (7):
      power: supply: core: constify power_supply_battery_info::resist_table
      power: supply: ab8500: constify resistance table
      power: supply: samsung-sdi-battery: constify resistance table
      power: supply: sc27xx: use const reference to ocv table
      power: supply: core: constify power_supply_battery_info::ocv_table
      power: supply: ab8500: constify ocv table
      power: supply: samsung-sdi-battery: constify ocv table

 drivers/power/supply/ab8500_bmdata.c       |  4 ++--
 drivers/power/supply/power_supply_core.c   | 12 ++++++------
 drivers/power/supply/samsung-sdi-battery.c | 10 +++++-----
 drivers/power/supply/sc27xx_fuel_gauge.c   |  2 +-
 include/linux/power_supply.h               | 10 +++++-----
 5 files changed, 19 insertions(+), 19 deletions(-)
---
base-commit: 27cc6fdf720183dce1dbd293483ec5a9cb6b595e
change-id: 20240922-power-supply-battery-const-3722df7d16e4

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


