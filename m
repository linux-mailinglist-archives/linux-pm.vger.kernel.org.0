Return-Path: <linux-pm+bounces-39061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCFEC9B5B9
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 12:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 207264E239B
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 11:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5F23126C9;
	Tue,  2 Dec 2025 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cRpTLTYs"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59C53126BD;
	Tue,  2 Dec 2025 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676151; cv=none; b=Ol+dS0IdC6J6CBWERkSUxC7Ddte0lO/sRzK3lUMJbwvgGJbRoPJQLpn13j1/S8dgRqFu+UNngxAqM3hL8Ghi45VBWj1V6jU8iTAT6QSDXpOq+GtWLLLQQMyUUc7l9HEU3Q8a4P0vCTfmSOSAyeug3hbB8s3sMykiKe+hO8FFVBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676151; c=relaxed/simple;
	bh=tDq0D+E7RT9mmH4Gw3w8AGwTGul4wu0sFCYyhlaP8Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IUiSzVFxm0Ki7i80sN7IEWdk8duGzUrP/auh5CbWWY7Yk+V21xzuejFGl3jkSHlobLvMjTBJIJKMiKl/Vs15SygUoJorQEcseRdaS70bj605AjL7WKUqK+ghgZpjtMbIta6U/yb4tGzBJIBDy0l/j2WqmP4w/eKpOzVUXoFxkT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cRpTLTYs; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764676146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uq0n20ZSv9KfDjf++F5AwIp/jJxCX5oRiIaKEc/Zghs=;
	b=cRpTLTYswTE4oAS5bsdnQ2nH9bkkk6LYrzp5id3+EbXyUVhDGWm2q9CmJM+EXKa917IamM
	uct8LG5aWuhDdKqXvGm80HxnguUcv1BSHrjNHPuASeFZ+I/8pL52AFbwxBuqfnSpNVKq3g
	Hn39+VG5TF0GdEK/9EqzewnTsPFYomM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Freeman Liu <freeman.liu@unisoc.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: sprd: Fix temperature clamping in sprd_thm_temp_to_rawdata
Date: Tue,  2 Dec 2025 12:47:58 +0100
Message-ID: <20251202114758.375008-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The temperature was never clamped to SPRD_THM_TEMP_LOW or
SPRD_THM_TEMP_HIGH because the return value of clamp() was not used. Fix
this by assigning the clamped value to 'temp'.

Casting SPRD_THM_TEMP_LOW and SPRD_THM_TEMP_HIGH to int is also
redundant and can be removed.

Cc: stable@vger.kernel.org
Fixes: 554fdbaf19b1 ("thermal: sprd: Add Spreadtrum thermal driver support")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/thermal/sprd_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index f7fa83b2428e..44fa45f74da7 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -192,7 +192,7 @@ static int sprd_thm_temp_to_rawdata(int temp, struct sprd_thermal_sensor *sen)
 {
 	u32 val;
 
-	clamp(temp, (int)SPRD_THM_TEMP_LOW, (int)SPRD_THM_TEMP_HIGH);
+	temp = clamp(temp, SPRD_THM_TEMP_LOW, SPRD_THM_TEMP_HIGH);
 
 	/*
 	 * According to the thermal datasheet, the formula of converting
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


