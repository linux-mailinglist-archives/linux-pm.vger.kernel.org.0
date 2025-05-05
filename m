Return-Path: <linux-pm+bounces-26676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6754FAAA585
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 01:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4CD1889ED5
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 23:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1D73118E0;
	Mon,  5 May 2025 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqyQhuD8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084833118DD;
	Mon,  5 May 2025 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484217; cv=none; b=u9CwHAtSiN2u/vtn7/4P0vA3m20kX3mg2pJhF49hubmyQlJ1taAjqZ0/QY4onOB1jvLXwXFvN61+fOXgqhrkkSVB4YZFq/0qhCJgh4EyUdth7X6h79lAe40gku9jc70sDVyaSRYfNhZeKbFLlJTv1JTks6kvuhXLD388WS6i6bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484217; c=relaxed/simple;
	bh=0SqSalVLNIGV7ZGEkllDtan/2CZ5yqAgZD7fPjaulCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iie1tbWO+ObnSuOqVu1+BkvOsVu8GmD8s2dDQlj+xBP68/tpFZ84OHDnF5nEYtjDRERyFrrAu9+e/m7k37969cQzrsHH0lfuYPo0uUSMc+yZLHvQBF5LcN5WA9z/YeiFdcRXD2JZAiSle1/HgUUIdT+jL6KlVAXqY9Mp7vtHdAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqyQhuD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2CEC4CEE4;
	Mon,  5 May 2025 22:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484216;
	bh=0SqSalVLNIGV7ZGEkllDtan/2CZ5yqAgZD7fPjaulCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IqyQhuD8MmBuM3bt8GlSiHB9oharCb3ejbevYIWd+5G5Bw+RJk28oon3WbJRTSRkB
	 9MIESsKDWkGC9B07XY8nC8RSvCbO7Bti+FdmxQ9tfVmJOa3X1WmgK2nqV4YsDwNZYF
	 tUDaXyfCNbHIt217pLQKGGcXxyPfnzeayfXUJbUey/sP7A0LzzyANW4ffGnADzs73z
	 b5Uzr4sndhXCC+8sjSz49FbXsdgCuFQL+b4uYmyg2DFwjTiIOfVQ19rPCDGQvSLyuc
	 uKxsbvqkcUTSCbeUhULRSrDDHJKJyFWKAbnut2VFxxpIrjdDSOO7sBZRZ+w+Ko//yi
	 mAA1JKE7UnLLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	shawnguo@kernel.org,
	shengjiu.wang@nxp.com,
	joe@pf.is.s.u-tokyo.ac.jp,
	peng.fan@nxp.com,
	m.felsch@pengutronix.de,
	krzysztof.kozlowski@linaro.org,
	dario.binacchi@amarulasolutions.com,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 392/642] pmdomain: imx: gpcv2: use proper helper for property detection
Date: Mon,  5 May 2025 18:10:08 -0400
Message-Id: <20250505221419.2672473-392-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 958d34d4821b1..105fcaf13a34c 100644
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


