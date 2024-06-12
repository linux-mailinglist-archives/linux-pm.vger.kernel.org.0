Return-Path: <linux-pm+bounces-9032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7709059B1
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 19:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950C71C224D5
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE78E17FAD4;
	Wed, 12 Jun 2024 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U+SEJKNG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Aq9oyhf"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBFD3209
	for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2024 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212346; cv=none; b=fny8Snn6+NL5UugqXMmFnjCC9SE5DdXZxwOsldlnrkKROdzhjVsaooPtQBvZfYdrJ+t6GcgXKUxyEwsR0b6SR2t+V1TlRlYhOo0CLiNCLSHKxxMCd5Pxnb5IiLT/XoBpo7VYHDiQh7agracrXt35jsDkEK6IG+wQJNbcdWjjTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212346; c=relaxed/simple;
	bh=8WGuN0hETz4Ew4ojH9yg2XxCRDDkRdqi4ZHHSTibsdI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F9Gws1Tn3bO+oMRxfAnmHkQzqSYlcfmQ6o7/a8V5/7mnGPtjdkHjnVJuUuWzsLQj23GVZyQuA25lalP1pBeGxKQu6spGkSgQ/84fp9oKIByV1lmL7PkMPsZQ5j7KQfBBAz7rlAhWsEJUYZbQ63/Zp0quK498biSdFXhYdpIoDHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U+SEJKNG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Aq9oyhf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Jun 2024 17:12:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718212342;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=13euhPoVEVnO4zlTNNzRC2hiHcQlnuhpzz+hGOM+6Gw=;
	b=U+SEJKNGRxT0Ns3pDojcKc18kcycjKOhuXAro6MpVJtqivrA2l1tl7yp62Ixwv/MVkHxXA
	GCzpRSR6XHc8a/JU6ZotG2araa3tXp8o6Oy3I+QfztuOVuAbvpnwVp4cvs7f8sl7XB4ltP
	+HTdki0aIWxHULVh/bbV2xQKsnwfnaQlWeMMkAWoyf1EJKSo45CfEiExUi3eiIB8uPTtbS
	A6Zg5Pqjy4SS4hmuM6hq4r1X8YrHNi4HPxT9VcXqyYtS1AXWJ8ptjVyVSd121dZZ5P0/Yb
	6l1WzEcF+A+v4Fi0kz+Ruh4z2H7TbzgzOPQurz797GDru4z6jv3O/2UrAhZt5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718212342;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=13euhPoVEVnO4zlTNNzRC2hiHcQlnuhpzz+hGOM+6Gw=;
	b=2Aq9oyhfBwKMsPx/DPJjqFoNBVyeKQNKNfPRq+lF3Oy5i/QcIUBkHlvmsmWRCvr+J6l3sf
	KwnUkZYdZN3Q4XAg==
From: "thermal-bot for Julien Panis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/mediatek/lvts_thermal:
 Remove filtered mode for mt8188
Cc: Nicolas Pitre <npitre@baylibre.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Julien Panis <jpanis@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To:
 <20240516-mtk-thermal-mt8188-mode-fix-v2-1-40a317442c62@baylibre.com>
References:
 <20240516-mtk-thermal-mt8188-mode-fix-v2-1-40a317442c62@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171821234230.10875.2842450639234187068.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     d9fef76e89498bf99cdb03f77b7091d7e95d7edd
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//d9fef76e89498bf99cdb03f77b7091d7e95d7edd
Author:        Julien Panis <jpanis@baylibre.com>
AuthorDate:    Thu, 16 May 2024 12:44:37 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 04 Jun 2024 19:40:51 +02:00

thermal/drivers/mediatek/lvts_thermal: Remove filtered mode for mt8188

Filtered mode is not supported on mt8188 SoC and is the source of bad
results. Move to immediate mode which provides good temperatures.

Fixes: f4745f546e60 ("thermal/drivers/mediatek/lvts_thermal: Add MT8188 support")
Reviewed-by: Nicolas Pitre <npitre@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Julien Panis <jpanis@baylibre.com>
Link: https://lore.kernel.org/r/20240516-mtk-thermal-mt8188-mode-fix-v2-1-40a317442c62@baylibre.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 0bb3a49..82c355c 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1458,7 +1458,6 @@ static const struct lvts_ctrl_data mt8188_lvts_mcu_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(1, 1, 1, 1),
 		.offset = 0x0,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	},
 	{
 		.lvts_sensor = {
@@ -1469,7 +1468,6 @@ static const struct lvts_ctrl_data mt8188_lvts_mcu_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x100,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	}
 };
 
@@ -1483,7 +1481,6 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(0, 1, 0, 0),
 		.offset = 0x0,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	},
 	{
 		.lvts_sensor = {
@@ -1496,7 +1493,6 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(1, 1, 1, 0),
 		.offset = 0x100,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	},
 	{
 		.lvts_sensor = {
@@ -1507,7 +1503,6 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x200,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	},
 	{
 		.lvts_sensor = {
@@ -1518,7 +1513,6 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x300,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	}
 };
 

