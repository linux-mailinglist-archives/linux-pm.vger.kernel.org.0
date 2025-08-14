Return-Path: <linux-pm+bounces-32381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A497B25DEB
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 09:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB0A1630C4
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 07:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2102D63E0;
	Thu, 14 Aug 2025 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tU+lJrGN"
X-Original-To: linux-pm@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396372D46D7;
	Thu, 14 Aug 2025 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157591; cv=none; b=P9+LE3gXk9xCohMfwXhLH8rH80LSfdFUQ3WhippjdHA9er+TpdjbHGW9RzT51M0u7Sz7HBnTrby7KVQjQ8yTr2KVojKHf+yHFfJvUslzyAVCMDPbjytWeDy9X4pjd4Z4u2vW1NbRIfFtlCqAsdh9dwZikV8bzNjcOfPYY19P0GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157591; c=relaxed/simple;
	bh=wGvNP9QjPqUELV+pOSxCEYivkRW072Paa5V4zMtUYfo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=UIZ2TObtd8YlckLTGk9cbuUeWAZkuY8rix1nMWqVPkvUzD45d5ynNx7vFTCbrVPa1JeX1yhxkVzccnbK3hU/w7XfF23m1CuR4ctia61QKIrLj7sEfk+ZKcwRKsl4z+KuVotpwIOWYKHKW3RBaFJieBR5Xqorm7uofc8wnRbeEik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tU+lJrGN; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1755157577; bh=bfZdKPCGA3xwcP/gjBM580mL+pIaZJJAtOyWzJYfOgY=;
	h=From:To:Cc:Subject:Date;
	b=tU+lJrGNeHL67SFMyAB/AV5wXQ6eksls6oxHISc9fIhP4HiXmcZkNl3OymLFfy965
	 wLu2hXiLK4Taa7aLS1cP+0ohtnx4kb8mHRwfMBWzJMglpjHzg9m8zhNINsjWKb7uO+
	 ligM28dnn0EvhVz225WlDauNO62vu3Rq2am9/Jq8=
Received: from VM-222-126-tencentos.localdomain ([14.116.239.34])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id A06A3CA7; Thu, 14 Aug 2025 15:40:06 +0800
X-QQ-mid: xmsmtpt1755157206tmsfl332c
Message-ID: <tencent_6983C78DFAA337B6895389FD937D5C73F608@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoe/REFXSmt3UyVpBzGKTm9WD+5ArBKlAecKlYMOhh8othaYL7nRi
	 F0NtH+2Tp5ZmttrcIHLa61jdD8wbc5MXoGkBN0ywytS3YFnL800N+y6OzXJaNJZ7fecUzSR9abVJ
	 OkpuoPpzTpSabxa38uUR6bAVFgMB/rmyid9hmaFthA4n8vGNe+Scdv/QqCodMdM/oZzlLw37WyW3
	 2HbBoQNi0tkeasCPMqxMhufv7NljTfSoBBXROagpn20cVexfIZyGOZZLfYrzrW0CooYN5IwZpEL5
	 OzpKtAFecZrmT9ZbQBOGH55ahEdxEx9mPVu1JZmW/9Cj74bwAQCqAJ1jfRiyB4OijnQV0M/Fq9RV
	 6AyS6gvBAlensLc0k42+NtT0BfxeyzLj2Pkw4pUWTY/iWhiAfy27PA1awGo8XUc4VQobMN69E36p
	 gOHgvc8/dOJ6ust95JiEYIA2MII2l6k42V999zoyP+elncd6o+PhJKDlLzy1kI6P9knCVNiRllFK
	 KQc79jNf4e3ud8/y2pgWw/1AqbxDot2OccmqY97TrNT14+1EKyGDdj4H+dDFX/MGLhJZWVEhZz5D
	 b0wm6NXxwRY9Xte7Xnv6I85oGZfqblSvLJ75pq3ECgD2eMSOYIfyqrBYFM8nALGBtudWpTrOQFy5
	 Mq+ZeWFbfBF7EJjjS04xsnZvTx6ZnACi4E/+I/MuCN+qvN10Qp8avIGYZaBjyGirfLHKgJ+sn2BS
	 /vziSQ502smaEGunc0si1Kho4BB9vg/mFcpTXcLpglT8iTInKyd5mwo6u/4xOim+mNfEq9sM8Urb
	 vLd4gRZZv7sBLs5r4L8W/SvvMu1vSZeyLngzbbpoEhvGLEAXQKBGIp5N+dbqCgw9ioSleJllWu6B
	 NirJ152c9F+BuuwlP/m+Wnt9kx26x4CLEpSQwTnjH4kQHl/sx9LvagX7hOl9cwOycvPobSgm30pF
	 Gfi4eaqdColPBrr343+otjjdZpFjP5A+dj07SWyyurAhDwbEVK3uQbYfr3gte9cHbfHpgvVfO6lQ
	 KJLb7IeuZu+aUURFYFbWhS2tq2r3+YHPNSK8YnALNlvvNMCmSs
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Wensheng Liu <961342126@qq.com>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vencent Liu <961342126@qq.com>
Subject: [PATCH] power: supply: Fix resource leak in ltc2941-battery-gauge.c
Date: Thu, 14 Aug 2025 15:39:55 +0800
X-OQ-MSGID: <20250814073955.718370-1-961342126@qq.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vencent Liu <961342126@qq.com>

The ltc294x_i2c_probe function increments the reference count
 of the device node via of_node_get() but fails to decrement it in several
 code paths. This leads to a reference count leak that prevents the device
 node from being properly released.

Signed-off-by: Vencent Liu <961342126@qq.com>
---
 drivers/power/supply/ltc2941-battery-gauge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index a1ddc4b060ce..64f900d6756d 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
+#include <linux/cleanup.h>
 
 #define I16_MSB(x)			((x >> 8) & 0xFF)
 #define I16_LSB(x)			(x & 0xFF)
@@ -443,7 +444,6 @@ static int ltc294x_i2c_probe(struct i2c_client *client)
 {
 	struct power_supply_config psy_cfg = {};
 	struct ltc294x_info *info;
-	struct device_node *np;
 	int ret;
 	u32 prescaler_exp;
 	s32 r_sense;
@@ -455,7 +455,7 @@ static int ltc294x_i2c_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, info);
 
-	np = of_node_get(client->dev.of_node);
+	struct device_node *np = of_node_get(client->dev.of_node);
 
 	info->id = (enum ltc294x_id) (uintptr_t) of_device_get_match_data(
 							&client->dev);
-- 
2.43.5


