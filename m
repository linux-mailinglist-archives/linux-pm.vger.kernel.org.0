Return-Path: <linux-pm+bounces-26699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D77AAB161
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 05:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3B5C7BAC43
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 03:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934663777B0;
	Tue,  6 May 2025 00:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lse/RbgD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94D1283121;
	Mon,  5 May 2025 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485433; cv=none; b=engMr6trT7fgZxRxzXmjPdSaKXSC6KhDAbYG2Fuej9zsWspxHD21x3pjre/kevi+jYZXDV+byWsJiJDSoG6Tl64gHyxpZdNeSsUzXEmmVWWHELoBvqLeO1eQKFtAmEdmhwGTLp8wzsasDj+G7QPDGZlJ0om40oNdQEn2YJzK1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485433; c=relaxed/simple;
	bh=x4IvsUEfzHlSC2LzP/8/YpTVrEUqXDFL+x1OF5RhMqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RXXcDGtUf7DsHtOOTYTWw9Fs+VuH77x2KPFUFcZj/k/HHgvKQxiv/hDae06yx2TydwWFgQxiEwCndQNlYm7W8GFuvSZNSKobYOI9o6BDRYGXxBITFYSaB/6PHQNY2bSzT4hKQyMvh2jNJUioDi6AAP2vnc0xKmmjXbGVM+/xQlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lse/RbgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580D3C4CEED;
	Mon,  5 May 2025 22:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485432;
	bh=x4IvsUEfzHlSC2LzP/8/YpTVrEUqXDFL+x1OF5RhMqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lse/RbgD4Ydb4c4WIcTxrSSg/aD5NqKt+xvYPVIRYPJjJMonf8vVUUL3qB6jiKuz0
	 agvFIB3ZcIDkZ6bisfl3CJyUssrqozdiZgpLH0i4Mx6OjRYTbKQ8DNABqInatI9/HR
	 EwK0m+MzuOfKHIJBlaIYZdwACAAozmnJcLvwL0Z1/9+Yxx59jmzolBvfjk83t99VG1
	 44sTVo4griiEBkN8zWemFrxH/rEoHMBu4TZ5csJDD0K4smzwXx7vG1wOyGvGMj4C5T
	 d6cyZlQuoUM14gOK8v+kNhV8NnON+ct5jcz7aGxdhdKYwIENUa6GkLKHS4YFns0bIh
	 5sB3IYhCc/Zjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	shawnguo@kernel.org,
	shengjiu.wang@nxp.com,
	peng.fan@nxp.com,
	joe@pf.is.s.u-tokyo.ac.jp,
	dario.binacchi@amarulasolutions.com,
	krzysztof.kozlowski@linaro.org,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 308/486] pmdomain: imx: gpcv2: use proper helper for property detection
Date: Mon,  5 May 2025 18:36:24 -0400
Message-Id: <20250505223922.2682012-308-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

[ Upstream commit 6568cb40e73163fa25e2779f7234b169b2e1a32e ]

Starting with commit c141ecc3cecd7 ("of: Warn when of_property_read_bool()
is used on non-boolean properties"), probing the gpcv2 device on i.MX8M
SoCs leads to warnings when LOCKDEP is enabled.

Fix this by checking property presence with of_property_present as
intended.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Link: https://lore.kernel.org/r/20250218-gpcv2-of-property-present-v1-1-3bb1a9789654@pengutronix.de
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pmdomain/imx/gpcv2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index e03c2cb39a693..0dbf1893abfa3 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -1361,7 +1361,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 	}
 
 	if (IS_ENABLED(CONFIG_LOCKDEP) &&
-	    of_property_read_bool(domain->dev->of_node, "power-domains"))
+	    of_property_present(domain->dev->of_node, "power-domains"))
 		lockdep_set_subclass(&domain->genpd.mlock, 1);
 
 	ret = of_genpd_add_provider_simple(domain->dev->of_node,
-- 
2.39.5


