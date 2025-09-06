Return-Path: <linux-pm+bounces-34085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CDFB4770D
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 22:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 323804E0301
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 20:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38BC2BFC73;
	Sat,  6 Sep 2025 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hL4sOwWF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FE3296BDF;
	Sat,  6 Sep 2025 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757189856; cv=none; b=Byut7TLWEwMrud+4EF8/MC1fn5eDIFbm6NKtmd2iXOruI1DqFPQwGvQjNYjY3Mbwi0rm81bAH7tyb67zX70BOpneMO6jduDj1tdj1YSMljoKQPiVAr5IluoTLize/GgffC4GLMPRdaoicw0uDFtGYcQq3jLQok1ICAwHZC4Zsnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757189856; c=relaxed/simple;
	bh=QE+tJk1zGwmAgzpewZ2cpQB2QWRaftfJfeA1AtKdsDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LCCwPtMGnElfM5hN5Fv/fR31RQN4ejK/jjpFHx5+oE+TzNiSJ2WhKxo/aNNZ2mR+VLsPlVwixVPfZUl1yO+OXELJ8l93b2arx6JR3fdnMBrvtMSGaEnsJREfPKR4EJekCCrEkJZtRDP5gZWD1w7spe6DoxbRB2MLGc5cMo8tXFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hL4sOwWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B685CC4AF10;
	Sat,  6 Sep 2025 20:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757189855;
	bh=QE+tJk1zGwmAgzpewZ2cpQB2QWRaftfJfeA1AtKdsDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hL4sOwWFatJxFYvhTyNgmap21Uy4OX0X/dbc1Dd745TVertZfa6aRHE6FyxZ8G5Tm
	 uHPskiVrtR/LQpb0obG5vGVc5PZROWnHkWJsOmzE/EG4TFBuw+EHlmyJFNP7OPoW6d
	 LKYKqi53nuVEcTV5OK+aacZYo57g0wi+2u1YYgiHNja7HWRxNqz9EVvJyz8+dBnIGL
	 dkUhZK/3o2r5FpqfS/rKYjYh5/KEa+lYH21zT+15AHt5c919MEqCjWuuzd2kXD7zTf
	 hVwmMqmdG0c3/whlY7jflMUt5cBhNaN6CE3I5kGetvCgRvHrq3HKdxqVQmaGuLxoPm
	 eZw+PToKzHxxg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE26ECAC582;
	Sat,  6 Sep 2025 20:17:35 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sat, 06 Sep 2025 15:16:56 -0500
Subject: [PATCH v3 6/9] soc: tegra: fuse: speedo-tegra210: Add soc speedo 2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-t210-actmon-v3-6-1403365d571e@gmail.com>
References: <20250906-t210-actmon-v3-0-1403365d571e@gmail.com>
In-Reply-To: <20250906-t210-actmon-v3-0-1403365d571e@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Osipenko <digetx@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757189854; l=904;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=IRRKZEiLQdonkqHTuobp6JolP/SAC2dsrByPD6yqKl4=;
 b=PZmk3AyXp13NbqIXi+I2Q47roGCN8f7EhFZnsHsZfE+JmBXRjxGRgUyiytVzKXZcCnx4RN8l7
 s7FH05RfIBkCLL3Pau8z+n34Ew3RgYOQ7m2ZZVnIstNn3U3ONBzu2Y5
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

The Jetson Nano series of modules only have 2 emc table entries,
different from other soc sku's. As the emc driver uses the soc speedo to
populate the emc opp tables, add a new speedo id to uniquely identify
this.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/soc/tegra/fuse/speedo-tegra210.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/tegra/fuse/speedo-tegra210.c b/drivers/soc/tegra/fuse/speedo-tegra210.c
index 60356159e00d2059e55eaacba27b5ca63bf96c90..c310bdabcfd06ea8f23facb4eaaf209f183dc4eb 100644
--- a/drivers/soc/tegra/fuse/speedo-tegra210.c
+++ b/drivers/soc/tegra/fuse/speedo-tegra210.c
@@ -97,6 +97,7 @@ static void __init rev_sku_to_speedo_ids(struct tegra_sku_info *sku_info,
 			break;
 
 		case 0x8F:
+			sku_info->soc_speedo_id = 2;
 			sku_info->cpu_speedo_id = 9;
 			sku_info->gpu_speedo_id = 2;
 			break;

-- 
2.50.1



