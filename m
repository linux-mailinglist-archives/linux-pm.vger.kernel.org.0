Return-Path: <linux-pm+bounces-34220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0D2B4A5D2
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 10:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B321C21550
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 08:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B535D1EFF8D;
	Tue,  9 Sep 2025 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Ul/tCMtt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED9526FA52
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407612; cv=none; b=DhT9Nlarkr9uwHFo55sIPi8nlRIOf07ipAZFAs+UkCZHO8UhlOs0xGGKF5cr9dxXVej9E5AO5gmE6tl9lFw9cTI5tPZL3KA9mtSwqgowwqoc49zQmOihQMFKeXdd+yvFFJsvG/3Z+Ow+xBQJrq9Len6xsXOfPpCzkvboleGz/4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407612; c=relaxed/simple;
	bh=pXzuqrImXeJWFFQ0K35SwJI1PhXgtgYR7km+ODpMrOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrxpXinN7C0OXW6hpVKs6twPIjutPedzdGp+RgLVFdcsYnPbJdDFZm9XrkHqLKQm7vW13n4j2rszYBRbCqZstx91XMiCeZYVXXRsDzGSgnWxXetGhkNKqHcoS9ZdYIi5qv0d2xeJeYLdsIdi9j6ULp2QAI/vWGUAEkIw+JdRAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Ul/tCMtt; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=439+ZGOih5RHJfeOoq1gfrAFd0Ov/4mMgHr7V0fVGiw=; b=Ul/tCM
	ttyrKNiXbppGv4zPqYxypInAK+cQQVG4wGemCM7b4xIEAtKI1s0sSCr+EL1ZVo3r
	kELKDULSfeK69tdhUbZLHhj4wESxHosBuKqwoj7u4Ler2JX/vxcZeDaU0PaojF9+
	oMmoYN7pMf4CkSU2zB45MNUx3nePsCluHi3gcntq/Ht6vZX0fT4Cah/gqr7LvVN+
	SCuQnltnIO2BPgU+7rPwRjeOXrUKYz7xhEYfvTREvHQ67456haoMdQdG1RAIaGNf
	zXU9mOP/2ntoa6934ERWtZWQvYMYv1y/niq7aNPIIxXLHWhVm+/ywlfKTtzDorXy
	TCHKTZ2fklcmDJcQ==
Received: (qmail 172378 invoked from network); 9 Sep 2025 10:46:41 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Sep 2025 10:46:41 +0200
X-UD-Smtp-Session: l3s3148p1@NSzGV1o+YOwgAwDPXyerAKQ7QDbxBzog
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Marek Vasut <marek.vasut@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pm@vger.kernel.org
Subject: [RFC PATCH 2/2] thermal/drivers/rcar_gen3: use approved default values
Date: Tue,  9 Sep 2025 10:46:20 +0200
Message-ID: <20250909084618.23082-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250909084618.23082-4-wsa+renesas@sang-engineering.com>
References: <20250909084618.23082-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current default values for R-Car Gen4 are from a V4H Rev3.0 SoC.
They seem incomplete because of the same values for all THS instances.
Also, the bits to flag valid fuses were not set. So, better use the
values from the Rev2.2 SoC which have the valid flags set.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 07b53d4f2683..b7026ab733d4 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -372,12 +372,12 @@ static const struct rcar_gen3_thermal_fuse_default rcar_gen3_thermal_fuse_defaul
 };
 
 static const struct rcar_gen3_thermal_fuse_default rcar_gen3_thermal_fuse_default_info_gen4 = {
-	.ptat = { 3274, 2164, 985 },
-	.thcodes = { /* All four THS units share the same trimming */
-		{ 3218, 2617, 1980 },
-		{ 3218, 2617, 1980 },
-		{ 3218, 2617, 1980 },
-		{ 3218, 2617, 1980 },
+	.ptat = { 3146, 2076, 928 },
+	.thcodes = {
+		{ 3092, 2505, 1881 },
+		{ 2181, 2609, 2001 },
+		{ 3175, 2587, 1962 },
+		{ 3163, 2592, 1986 },
 	}
 };
 
-- 
2.47.2


