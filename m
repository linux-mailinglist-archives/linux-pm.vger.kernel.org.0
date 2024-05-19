Return-Path: <linux-pm+bounces-7973-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FF48C93BD
	for <lists+linux-pm@lfdr.de>; Sun, 19 May 2024 09:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375B21F21458
	for <lists+linux-pm@lfdr.de>; Sun, 19 May 2024 07:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6DD18059;
	Sun, 19 May 2024 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="N/q3aO5L"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A6D14006;
	Sun, 19 May 2024 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716105051; cv=none; b=CXw90NIiw6cApBOpV5y1VIgvvoO5wEIhRMW241axGLeZDl/rScFeMWe/kWInv4aQ+wielmi6dLu6D9IffszRW/afeIgoU7xyloJydm40PKkZq2LLF3TsB/KEokUz7gn5Wq7rxx6GkwR+3ItFtO/rTCuCUky9ipDkXzr56JHEbQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716105051; c=relaxed/simple;
	bh=jkN9s/UCfqcwcO60sG82AdVMCLkIhP/ZxGRMxoGJvNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BSSeq+FeEgxpVdzptd3X4zPh+Ff/5gSyaVNHsPI8XgEMchdPKJFa+GTsDdGy3PWY8ThOFdZBfghgTqUMdeDXwBwHhvoC/McRNYlsEeRPuYYAwwvr7KEw2v2nry007W07tF78i5f8BAd+yNE9STE8m8Ar9k5E0Xohc7wBf4LBE34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=N/q3aO5L; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716105046;
	bh=jkN9s/UCfqcwcO60sG82AdVMCLkIhP/ZxGRMxoGJvNY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N/q3aO5L67HYc0Qxj5I/En2FlSEjRWleBkFJgkdEvhG7K8aToJy+IZai/ddJTxGhU
	 +mlvuaPa9dJxjh7VAqoOohCAlTr8xOoNfhGoKcUfKXzNVSmzYnpRsyIoGvH9chGG2Q
	 uufYH9vgiLvklNEyO0GqE5Rsz4h4oaO8u4Egrspk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 19 May 2024 09:50:21 +0200
Subject: [PATCH 3/3] mfd: cros_ec: Register charge control subdevice
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240519-cros_ec-charge-control-v1-3-baf305dc79b8@weissschuh.net>
References: <20240519-cros_ec-charge-control-v1-0-baf305dc79b8@weissschuh.net>
In-Reply-To: <20240519-cros_ec-charge-control-v1-0-baf305dc79b8@weissschuh.net>
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
 Dustin Howett <dustin@howett.net>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716105045; l=701;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jkN9s/UCfqcwcO60sG82AdVMCLkIhP/ZxGRMxoGJvNY=;
 b=d/Xu0dphsEUz2K3zV15gzzcBWA+HAFvbHnpG9ZKAeDysndbIkVaCkAdx7xSdDSYr9PV2A5L34
 lBGrnU4Oo1FDRyuleOw+i1p4Ka4EIq1jGRdSPSMiYS5y44Ncdf308KG
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add ChromeOS EC-based charge control as EC subdevice.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/mfd/cros_ec_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index a52d59cc2b1e..c571cbc642c7 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -89,6 +89,7 @@ static const struct mfd_cell cros_ec_sensorhub_cells[] = {
 static const struct mfd_cell cros_usbpd_charger_cells[] = {
 	{ .name = "cros-usbpd-charger", },
 	{ .name = "cros-usbpd-logger", },
+	{ .name = "cros-charge-control", },
 };
 
 static const struct mfd_cell cros_usbpd_notify_cells[] = {

-- 
2.45.1


