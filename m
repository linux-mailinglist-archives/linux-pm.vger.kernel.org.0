Return-Path: <linux-pm+bounces-32543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E4EB2A1EE
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 14:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B13C17B25A
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 12:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1F61D618A;
	Mon, 18 Aug 2025 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WG5C6/pT"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E362029B0;
	Mon, 18 Aug 2025 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520414; cv=none; b=oeoPHkK1eMQ+wJaYm4IKrsKAwzkFLaQ0era4LESzSb/egr0NSVON6VcAOG/dKD1msHXka/nvIqFEU8O6LY0Ss9j7964hImzWUGb4hMR3xga3zn637lPQydASQ/9SQuRC+ktSpYdkyPqjTCULtaGfUe80T0yk2ZgjOvG6FheOpmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520414; c=relaxed/simple;
	bh=fBwGY1pf9/pZrhjxfF2lExvVGXSFMC7sT+sKvSTHCZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MHsb5aKEhW7n+dkMzNdrHcZPV9GuCQSQSggqmaptCSgDqKKN1yNmZfFc/G+cqqVaZ1ce3mAWQp/1hHWUkC/J8W1KsY6z5ME8eThQ/We49jHEHe11WeHvZiD/cc2znwMQJ+4e81OpO8UJKsNpm+xUr0mV6sZ43L7GX801h4hfcMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WG5C6/pT; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=OB
	mxvHZPIjB170wB6IcELcbHWu2NuzRe737D2dZcW1k=; b=WG5C6/pThVAjM+F3JX
	1MU09l2bcTqxQOANpxc5ciqxWp+Ywtwf/lJfOiFM7/jsYUr4GIwYGgRHbQnzgYrk
	3WQKxhiIiCyoW2L0FjeAzUkiu0NWcAFaW8Wu1ACm0Op7VS6SzjPyk+zOQrtKfued
	hmp6M3wEY+fveFQPiEe7ZQnbA=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wAnA8OBHaNoedlICw--.25568S2;
	Mon, 18 Aug 2025 20:33:08 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: sre@kernel.org
Cc: t.schramm@manjaro.org,
	zheyuma97@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH] power: supply: cw2015: Fix a alignment coding style issue
Date: Mon, 18 Aug 2025 20:32:59 +0800
Message-ID: <20250818123303.334853-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnA8OBHaNoedlICw--.25568S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyDKFW8Cw15tw4UGrWfZrb_yoWkXFgE9r
	Wxu3s7Kr15uF1Utw1qyF13Zr9aga4qqF97Xa1ktwsrZry7Gw4qyr4DCryDGw1DX3y7CrZ8
	uFyq9a13AF9xtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRAPESPUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEgGtXmijGIioAQAAsS

Fix the checkpatch warning:
CHECK: Alignment should match open parenthesis

Fixes: 0cb172a4918e ("power: supply: cw2015: Use device managed API to simplify the code")
Signed-off-by: Andy Yan <andyshrk@163.com>
---

 drivers/power/supply/cw2015_battery.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index f63c3c410451..382dff8805c6 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -702,8 +702,7 @@ static int cw_bat_probe(struct i2c_client *client)
 	if (!cw_bat->battery_workqueue)
 		return -ENOMEM;
 
-	devm_delayed_work_autocancel(&client->dev,
-							  &cw_bat->battery_delay_work, cw_bat_work);
+	devm_delayed_work_autocancel(&client->dev, &cw_bat->battery_delay_work, cw_bat_work);
 	queue_delayed_work(cw_bat->battery_workqueue,
 			   &cw_bat->battery_delay_work, msecs_to_jiffies(10));
 	return 0;
-- 
2.43.0

base-commit: 079dc9ff6c3e30152ce69c162b02893bf741d2db
branch: master


