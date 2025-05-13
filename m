Return-Path: <linux-pm+bounces-27075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB59AB551A
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 14:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F44A7B7124
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 12:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285DA28E57A;
	Tue, 13 May 2025 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j3xc4JWN"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3185428DB63;
	Tue, 13 May 2025 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139880; cv=none; b=rngOeRllV5+zq1dQt6BsGWqAJdc+Rz4/8gkjVV1uoObAb96Ds7tWHD7FhrWeDh0HBv3RtlEpLfoJ1TRR9V6ZAuEUMMXHJRj9poUuUEDsKbkH99QLf06fqiUjob45z4p0q3NyL0cZwxXhuaa/LvwXQ6VTCEPBPqO3ULCU+Qkn9DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139880; c=relaxed/simple;
	bh=fjt+b6ZDxmU1+/5wktcdrba2wnmNrI/kMPory0RQIiY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UxgiPmXkfXH60bR5a8+DZC+EUD7OB4vraO5qeCGBTpkcxRkefFPmVljku612XZE4GfjXMGjWPNilW8dTEczS1jonAnMpUWfXAGaendh37wPiPZwoPDgxt2H2Wc7j4ghVu5QIqCyPgvqANqrFoh434ktm7Eab0YNwN50CEJ9Jufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j3xc4JWN; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=X4
	MJ/+6JtBMPbPuF59vBpYEq/KbfS0ifDdhTXR1Gy3s=; b=j3xc4JWN6ERkBKFlFY
	yjGhpPqXYcnL9e1cQsjPvLgj8a23t/LNTb1ZrU9VnBccaRDVuCbPu8iREY5SfqTf
	I35+O1/EExv5u+08KFPPEDYxhA4jh3nQHXvdy2RxXbEQvmYnMehaQJQblCQXMyNK
	v0cKdUM2rTDH+MdHHENxXwDGU=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDnD+wMPSNoW6TvAA--.61727S4;
	Tue, 13 May 2025 20:37:38 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yuanjun Gong <ruc_gongyuanjun@163.com>
Subject: [PATCH 1/1] power: return the correct error code
Date: Tue, 13 May 2025 20:37:32 +0800
Message-Id: <20250513123732.3041577-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDnD+wMPSNoW6TvAA--.61727S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF45tF4Dtr4xGFyDAw47Jwb_yoWDCwbEka
	4xK3s7trs0gr1fKr1Uur17Zr15u34DWwn2qayvqwsxKa17Cw45tr1xuFn3ZF47Aw4fAFWq
	gFZ0yrWfZFy8GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_VbyPUUUUU==
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/1tbiUQNM5WgjNy2N8AAAsX

In POWER_SUPPLY_PROP_MODEL_NAME branch of max1720x_battery_get_property(),
program would return -ENODEV out of FIELD_GET error, but it's better also
considering the error code returned by regmap_read() in case it fails.

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/power/supply/max1720x_battery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
index ea3912fd1de8..12ecb1f40fe1 100644
--- a/drivers/power/supply/max1720x_battery.c
+++ b/drivers/power/supply/max1720x_battery.c
@@ -426,6 +426,8 @@ static int max1720x_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		ret = regmap_read(info->regmap, MAX172XX_DEV_NAME, &reg_val);
+		if (ret)
+			return ret;
 		reg_val = FIELD_GET(MAX172XX_DEV_NAME_TYPE_MASK, reg_val);
 		if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX17201)
 			val->strval = max17201_model;
-- 
2.25.1


