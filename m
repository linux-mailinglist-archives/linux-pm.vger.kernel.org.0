Return-Path: <linux-pm+bounces-35251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F175EB96EC7
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 19:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD1A1485209
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 17:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68E527D782;
	Tue, 23 Sep 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X94hNWOa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FA7277008;
	Tue, 23 Sep 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647135; cv=none; b=Ev6Is1fQ+Vj2mXPVfdkHzRL5MXtA6D/8C/HnXxOulJDZtIG+tWuLtScWp4dOFOqNSufRLTwU3JC8iXfZwJ8eJ870z1ZS/T92ajLcOEW13MVSf0mJufVSH8oeh8avq4OA5+k4W2saocPiHk+rRn/X6wkOxpr72R9rYjp7Z500jX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647135; c=relaxed/simple;
	bh=6y/EW7PhFEFbEHmiwkeVQkYAMVtGnoKaq4arLw4DZXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kE4mkZ3SDY73jR+81RON6BY1x8TE48x6BLSnsVQ+w1UnlFKoeqzd89Nei6HEv3QGEONge/yn2VNoNVvzGPmkS1gEHxHEolYbPFR5DT9CDcRKS3yfBhq09bwKBAhttHkYMC5khBtOJyZ/0DhE8WZ+A3mjqysEJ/x48KG3CVTcf5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X94hNWOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7FCCC2BCB0;
	Tue, 23 Sep 2025 17:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758647134;
	bh=6y/EW7PhFEFbEHmiwkeVQkYAMVtGnoKaq4arLw4DZXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X94hNWOaKpj4eiIdtc3eREnMUuOS0DLrVEuotrjp/nFmpxOhGOPuJtaJCQVGvtZCQ
	 KmyW7iCgVaussaXNvBbSFqcK2Vbrtt2hQ/X8yUt+xc0zHnu4Vm5c7dcNxCP5rJbq/p
	 SF6GNItGkmaI4TYBz1IQwi4lpzfm+wxl/HKafseuhjCoOmpMauL6U+06PMBGirXB93
	 aq0jvVGsgE2IKYiyQkJV9RL7MdcedxSVz7bAo1GHeMaQ5dwcZaIgzUL2l2qr7UhxBw
	 E9tTLS/o18KOXVhI/kaSv+2OfTxS2FkThf2+eUtezYjzKtFuidS90qhQKeH8B65yEL
	 9uftQEeFdpcZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD5ECAC5A5;
	Tue, 23 Sep 2025 17:05:34 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 23 Sep 2025 12:05:32 -0500
Subject: [PATCH v4 6/9] soc: tegra: fuse: speedo-tegra210: Add soc speedo 2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-t210-actmon-v4-6-442d1eb6377c@gmail.com>
References: <20250923-t210-actmon-v4-0-442d1eb6377c@gmail.com>
In-Reply-To: <20250923-t210-actmon-v4-0-442d1eb6377c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758647133; l=904;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=N7lGBqhTJZWYrEQodS0d8DsadeWZ1d1qRRIiTkeqLjU=;
 b=0ONLH6ndKxZB2LMvLtiqBopdbgCrCSk4YmehtNa9VxW4daIveaj3XylChxGrkFq4vGm0xqGaD
 0ATVgLUrkUEC5QH52Cfo1AI8F4A+/a80q5p9EOZyclW/kXX1FZrOR12
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
index a8cc3632977230fbfda0f8c3bfa7b7b25c2378fe..06c2bcbee5734207e3ebacb4057da2195f85321c 100644
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
2.51.0



