Return-Path: <linux-pm+bounces-12400-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B44995624F
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 06:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E29282814
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 04:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011318801;
	Mon, 19 Aug 2024 04:01:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E132C8B;
	Mon, 19 Aug 2024 04:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724040078; cv=none; b=MKE7esl5EsHUR7cp8LxiqWPahi5nr+XSdlH2xxkWwXwjnfm5y4FG6wKvc+bGy6gmrgeVHzbHwuDTvrFywyofPV2OHq+sKXz/e4lfSIzQO2QTebVKLwrByGqljVvgU81+sGOl/IN1D/6N5UsvQtZ4QES/w57kiBUpd8c2O2iY/l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724040078; c=relaxed/simple;
	bh=gxeWHfO3jejqGM7Q82mHI2/zxgi3Swpm2sMFcSEeD/8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CQkcUijFnj8UBX5SlLviDbfkFVZQv7sMVGX1RWxlcAVI5n6pUxZ184BteDeMkzWCzLhbhzcNGkj9wccUfdBoCi3c3YMBfWySsfpihlInoKNP1aPYeJSlgAJ9YONk1gKkyRMHfYyHTUnGLKyDxR8NaHqk/TRbHC7mvXp1f87tQY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WnJg363x9z1j6Qx;
	Mon, 19 Aug 2024 11:56:15 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id B68C118001B;
	Mon, 19 Aug 2024 12:01:13 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 12:01:13 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <sre@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] power: supply: max8998_charger: Fix module autoloading
Date: Mon, 19 Aug 2024 12:08:31 +0800
Message-ID: <20240819040831.2801543-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/power/supply/max8998_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/max8998_charger.c b/drivers/power/supply/max8998_charger.c
index c26023b19f26..418b882b163d 100644
--- a/drivers/power/supply/max8998_charger.c
+++ b/drivers/power/supply/max8998_charger.c
@@ -191,6 +191,7 @@ static const struct platform_device_id max8998_battery_id[] = {
 	{ "max8998-battery", TYPE_MAX8998 },
 	{ }
 };
+MODULE_DEVICE_TABLE(platform, max8998_battery_id);
 
 static struct platform_driver max8998_battery_driver = {
 	.driver = {
-- 
2.34.1


