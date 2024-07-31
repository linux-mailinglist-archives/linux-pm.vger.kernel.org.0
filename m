Return-Path: <linux-pm+bounces-11770-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF0494362B
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 21:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8CF2844B8
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 19:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3566516D327;
	Wed, 31 Jul 2024 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caf5xRQG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C76B16D322;
	Wed, 31 Jul 2024 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453234; cv=none; b=T0TSxJbdaWo2XMnBrmmvB4vjd02ahf3YvHRyZBta2vup1w9UiMQzivFYgRcZENkgij52queO6GHnRakphy4pfc5Yixv6Hz4qUC0zslGSJ8zr3hoVUQdVtD6hK+ZjUBo7eaLEIKOIKJNyetKwt4UIGi13bsVPBjgv9pp514tKgpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453234; c=relaxed/simple;
	bh=kdjbGvEdRLgyREDQqkBuCZiTKYlAO4pgknOpuCR42LA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U/lH47PE+KjSW0N6k1fTmNzEaOAdecnRY6rNZ0/dnRWHB/YMwReHYikx3+5nVcz5AwVPZgFfsx/491A8MkVHugwFpLuK+HZFTkgWwWwl1pTi3mPN+bjHaA8UHFEIitgJk/U1Bs0Gv0L53HqaWyL7zKekOJe0uUHyklyLuz/FWJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caf5xRQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A923EC4AF09;
	Wed, 31 Jul 2024 19:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722453233;
	bh=kdjbGvEdRLgyREDQqkBuCZiTKYlAO4pgknOpuCR42LA=;
	h=From:To:Cc:Subject:Date:From;
	b=caf5xRQGUr+uSGQD4LDsPEdVwHh1TUG0gg5a8oemletv6sayaVMH+sj0LJAcmi9/c
	 FhX+Xb856DHFCuOBOLR5LKi/UeN/UYpQeT3Inz0rgVq4Djx1irVgA7w5FeGNbbm0/I
	 1PboGV+ogVV117gbsLkz8wXbwNH9xk4WnDYCb3yMjqRJoePYgBNaMJg6xTvI/13hNr
	 x73p+54bC33ieU+jmJUszf1A1MrErgt4hnL+Burltxs2sLxwqA7eveXFBpDnd2pK/Q
	 +Hj5sdTlr8QgnP6u6GWg8sTX7CZjovW20+ED+GA3I4zId1y5tioldO5gd9jSHosQH8
	 QRz3gIMT6UPYQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] devfreq: imx-bus: Use of_property_present()
Date: Wed, 31 Jul 2024 13:12:49 -0600
Message-ID: <20240731191312.1710417-11-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_property_present() to test for property presence rather than
of_get_property(). This is part of a larger effort to remove callers
of of_get_property() and similar functions. of_get_property() leaks
the DT property data pointer which is a problem for dynamically
allocated nodes which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/devfreq/imx-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
index 86850b7dea09..49798f542d68 100644
--- a/drivers/devfreq/imx-bus.c
+++ b/drivers/devfreq/imx-bus.c
@@ -59,7 +59,7 @@ static int imx_bus_init_icc(struct device *dev)
 	struct imx_bus *priv = dev_get_drvdata(dev);
 	const char *icc_driver_name;
 
-	if (!of_get_property(dev->of_node, "#interconnect-cells", NULL))
+	if (!of_property_present(dev->of_node, "#interconnect-cells"))
 		return 0;
 	if (!IS_ENABLED(CONFIG_INTERCONNECT_IMX)) {
 		dev_warn(dev, "imx interconnect drivers disabled\n");
-- 
2.43.0


