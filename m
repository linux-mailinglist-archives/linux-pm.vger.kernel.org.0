Return-Path: <linux-pm+bounces-17001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C39F59BBDBC
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 20:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897992834A1
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 19:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BDC1CCB2E;
	Mon,  4 Nov 2024 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Db5+VECP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0696B1CC893;
	Mon,  4 Nov 2024 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747269; cv=none; b=ulkNbRWHQlOQryR8/GRWJFuJ2tgbxukQdt9QbdpHRsoXvc8fxtmOcyrXWjam7VnIFNxbYGZKh4POHdGz9avhSYs2WBgN/+wN1tdNNTm9iEDoUDQVlAnOKHe6tNA3ZP8QV4hQjWXcntDoh+B1fbh3wIxxV42tTjlZWmz9/ZmVVQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747269; c=relaxed/simple;
	bh=gYLDAt04WnrT85oSS6ETp+kMVsstlk0+hVvLhCGiug4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sO8gLx/RAV3w/8jzL73dsDBcB91MdSg9rSKaQvX7dPVrNf9edLtTNX5rVlLwJP9HeoZiEcZmeY1nlGZB/YQEpuKeAL3l3DMMW9RDNt4o4wlvbnClsduE7ERT0paUE9c//YrVJWhsiGLQsYAbl9gHH132qkH1P4nXKlnRSMbsR18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Db5+VECP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDBFC4CECE;
	Mon,  4 Nov 2024 19:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730747268;
	bh=gYLDAt04WnrT85oSS6ETp+kMVsstlk0+hVvLhCGiug4=;
	h=From:To:Cc:Subject:Date:From;
	b=Db5+VECPLXzzuwMFVO6vSzqRUlsWwzVEcLT+CeNlyse6u/6ByY6/jSwCq5vp10bGg
	 GT5R05uZMIjqYp3DAmeKJGsQxmTHjZrk8Ok+S6EiLwQ8H7XxjimtILhGk9PlKSHble
	 o6hKAA1ul3X9DCsQYfOA/hbhwBUCC6tgZV+D37IF/kmPdEIbR8UjytxRBGQCOR8+Qn
	 tUHY1wQ45XiTvLATyNUwrMbNf5zfn2aSoQpmgUZqBwYgZzGL4WsWkq/iB/ABQVgqYb
	 AyyuiVi5wAX/HSqrY0ZSnSHZszMZVThQCWA27zKddwC4Tc3zVnKW/UCGl26nboKisH
	 2n3ObSUtqwx5g==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pmdomain: imx: Use of_property_present() for non-boolean properties
Date: Mon,  4 Nov 2024 13:07:42 -0600
Message-ID: <20241104190742.276710-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of of_property_read_bool() for non-boolean properties is
deprecated in favor of of_property_present() when testing for property
presence.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/pmdomain/imx/gpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index 80a4dcc77199..fbb4c90b72c4 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -411,7 +411,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
 	pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
 
 	/* bail out if DT too old and doesn't provide the necessary info */
-	if (!of_property_read_bool(pdev->dev.of_node, "#power-domain-cells") &&
+	if (!of_property_present(pdev->dev.of_node, "#power-domain-cells") &&
 	    !pgc_node)
 		return 0;
 
@@ -511,7 +511,7 @@ static void imx_gpc_remove(struct platform_device *pdev)
 	pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
 
 	/* bail out if DT too old and doesn't provide the necessary info */
-	if (!of_property_read_bool(pdev->dev.of_node, "#power-domain-cells") &&
+	if (!of_property_present(pdev->dev.of_node, "#power-domain-cells") &&
 	    !pgc_node)
 		return;
 
-- 
2.45.2


