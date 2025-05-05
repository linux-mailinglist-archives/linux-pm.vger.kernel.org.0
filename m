Return-Path: <linux-pm+bounces-26702-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D003AAB6EE
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 08:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1B8189505B
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 05:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A002D218AB4;
	Tue,  6 May 2025 00:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5EumBaV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738B22DFA4F;
	Mon,  5 May 2025 23:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486179; cv=none; b=XbO6TPhF6ySR5x3FxzGT3Ie7qHumFgrRTkouinKP1fijn95NgaW2GyK37ZV+ACypFOYYwDJUap8yM+epLiXM8nKrx7IMKts+N5eIN6Bo0p3N5v/6r97Paiw88ecPBskp5uLA+5nxJwvo7HEECRSmPEfKdqdL13Lo00kVpq5+rIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486179; c=relaxed/simple;
	bh=YF4sqYUsi/wUGYdPp1hwG53Z8+TWL3CmgslUzgxjWwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lpp2Rdws0ElvKfNIPwa3puhTnKzF7EC3m4BItpDW0TGzYDzvLUgyLcOmn2aQMh8A/FQYJU/qfOHTa/zrb++jHu9VFdi37dNYqg+rwRGx/U/MZVccJ6Zx7x6rT4LZA19n6zL0LPV9gt+hpVy48tCNGSzcvEOf3cLoJ9qRRAduwHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5EumBaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E69C4CEE4;
	Mon,  5 May 2025 23:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486178;
	bh=YF4sqYUsi/wUGYdPp1hwG53Z8+TWL3CmgslUzgxjWwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h5EumBaVcd3F2WTnvQQ4G1OkjH3isWLmfXhAXk6rh1NE8UTxpifDY8D9EpFfdrv5o
	 QZ1JuLgyKC5RbS6xeaxL+rDna2UZGhVMZFphryNc0uukLycmFxSy32Pidxa8TlWlZ7
	 r4OnjJtR0DBWtlsvn+sBV3C+rL5mg8rY2EoXo4yGL70y4AJc7pYcD+0RjQ1H8pqXiO
	 P9cMxktrpOpbnMurEVRKhk4DZKKaYvyCZ08R4Op69QVEdhg5ysLaupMSdg1nj9Jou6
	 XyOSBG8xZ0DWOaeBYTUzBypmLzChdYAszDfYRTXcDa2+1HN+Df/BXMmOU+j2zWTNpY
	 1c3w971Fthmrg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	shawnguo@kernel.org,
	shengjiu.wang@nxp.com,
	dario.binacchi@amarulasolutions.com,
	peng.fan@nxp.com,
	michael@amarulasolutions.com,
	krzysztof.kozlowski@linaro.org,
	joe@pf.is.s.u-tokyo.ac.jp,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 188/294] pmdomain: imx: gpcv2: use proper helper for property detection
Date: Mon,  5 May 2025 18:54:48 -0400
Message-Id: <20250505225634.2688578-188-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 13fce2b134f60..84d68c805cac8 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -1350,7 +1350,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 	}
 
 	if (IS_ENABLED(CONFIG_LOCKDEP) &&
-	    of_property_read_bool(domain->dev->of_node, "power-domains"))
+	    of_property_present(domain->dev->of_node, "power-domains"))
 		lockdep_set_subclass(&domain->genpd.mlock, 1);
 
 	ret = of_genpd_add_provider_simple(domain->dev->of_node,
-- 
2.39.5


