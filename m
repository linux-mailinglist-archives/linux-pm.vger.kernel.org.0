Return-Path: <linux-pm+bounces-32322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581E0B24F86
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 18:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91083AE50D
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3E0299A87;
	Wed, 13 Aug 2025 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="lSaAJlj3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E23D292B5D
	for <linux-pm@vger.kernel.org>; Wed, 13 Aug 2025 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101796; cv=none; b=gOwHX5j3q3TbEZRo0S6AhOP76STfaRXODnRVL2QQD3WTpUZVTVKbOYpWHs8oVRF3oCgl8lO22rp7YaoyFoEPEEk8O1/1t58lMQbt6nDv+3TZbE1OEBdN6aa28WH/iInYjuUedFHkOUc6mIbyKD8OaifBroSbiX8XTDJC/We+hnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101796; c=relaxed/simple;
	bh=xVg8CvieZt5JByD6/wKXe6JtbKR6IIrhg1tnR1M4DJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HctGe3rB442CFqmBR7668MeI3FaghMNapHaBcuJe+TinlEaptNxAg1k4/H8yiePHCavglSNqMSLkmuDs4SsFM2uN6oWBjBEGL4qyapEk6Q3mNSjZhT6Ry2mYBrU9S7G7YB28FJTCtkR4SIMXF/8HK9t6wO1HKzKF1mYeu39DTpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=lSaAJlj3; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=jqYS3VaYXkKa4Y2ba/jlry/eBEmss+btji6RsrdYjVU=; b=lSaAJl
	j3P1xa5oxGrMEvCrsh3RyGYeFMscjLCAjWJnIdt1JfkZ2z4cNtf56pvgM0AQfOgH
	SOLdvtmj5SrBs+xRO1orIA2A1dl558KFNtNwEjLsa1K9UxBcmvqX45lv2vUo/bEf
	0SoMKabQ2jAoqXekq0GczZgV7A220vdGHLSDl1Akr4AQgWnbZpoaRCOwoXBPON5R
	u75pCXD2p+dZCU1fpoza2Wp3FmzJxk4qVjLcBrHJHS8Tw7D5XYGsKjKAvNbeT6tH
	Rzb+NkbDV5fP5aa+cGSqRgpmu4zbFkpH+9QEvjTdQfMGz7TMtoTx60zbq/h7a7Ic
	0vfMA8FhcDPdJ+fw==
Received: (qmail 695377 invoked from network); 13 Aug 2025 18:16:22 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Aug 2025 18:16:22 +0200
X-UD-Smtp-Session: l3s3148p1@FsI7ekE8sJFtKLKq
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 14/21] pmdomain: remove unneeded 'fast_io' parameter in regmap_config
Date: Wed, 13 Aug 2025 18:15:00 +0200
Message-ID: <20250813161517.4746-15-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using MMIO with regmap, fast_io is implied. No need to set it
again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
No dependencies, can be applied directly to the subsystem tree. Buildbot is
happy, too.

 drivers/pmdomain/imx/gpc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index f18c7e6e75dd..33991f3c6b55 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -343,7 +343,6 @@ static const struct regmap_config imx_gpc_regmap_config = {
 	.rd_table = &access_table,
 	.wr_table = &access_table,
 	.max_register = 0x2ac,
-	.fast_io = true,
 };
 
 static struct generic_pm_domain *imx_gpc_onecell_domains[] = {
-- 
2.47.2


