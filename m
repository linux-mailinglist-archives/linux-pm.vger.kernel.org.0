Return-Path: <linux-pm+bounces-15307-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E3D994397
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 11:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9CA0B27AEB
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 09:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3531DB52A;
	Tue,  8 Oct 2024 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Egsxwzzp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA42D1CEEA0
	for <linux-pm@vger.kernel.org>; Tue,  8 Oct 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378032; cv=none; b=agca9k5shVBeZczL3HBQc56StFjqWTW25yWY+zOPfKkqeojc7Khtah2hbRBNHXGLhO6UGMwPd0GY1PphzsH3dejjr0GORQjyPqOHEr79P7/yy3ePbyho9YWkiRIH9SOmrRl0YPcjYEs+7y2gMz0Efv08tku1zUmI08DoOQuip9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378032; c=relaxed/simple;
	bh=NAkU7Fk6Fp6cGUBKd+rBMuQ31s4lw/iDzBqC00OUzpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IEYvCBpCBrANqmnC3DGjakHAjaP3TuZKTcZ1j7wX9xXcMo/mhbk/vcg55Jbe5kMyJItKvnoW7yTDY4+6NpkdzbvDiIkKgB++KB66MSkwrpne4njBBKED261xoAvl2JQDzElkhAKBSfhnHByG9kRV9o1zZ1Wg36dShNSB42tbo2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Egsxwzzp; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c8daae8ae3so785192a12.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Oct 2024 02:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728378027; x=1728982827; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oADJGjtlfntgi0z62nuqr2PW+j4MIg/odMBZra4oxk=;
        b=EgsxwzzpYcbPdxaOIwqQ8mRJSGuu13KfkE1+oNvPO5eT6iQ+k+H8UyFS38Uq/RroXy
         IDTA10SRL0Upu1skWQlBehyUFZJiieNuUfQGPDIFaVNG430ZYodAIKZNeDs8opLFFmmH
         jvWpibHyizv+PxWYo9fOL7sQlkD8mWefPEdU8dK329iVQXhWl0oJqdaFhgXtDtSakm6l
         Qu2hVY4BRJRFj0qsW65/WzF1AdP/kLbIPenKbxkMdRPp0J7muan13ghsYdSaATLkrmqz
         s+5yBzZBBbacLvMS8S+h8Id9UAzXoxcZtwkoU+v61Rheq8VvXflQPD/TfezXQStWd/PB
         8CtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728378027; x=1728982827;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oADJGjtlfntgi0z62nuqr2PW+j4MIg/odMBZra4oxk=;
        b=Q3bhQKru7x88azRUqb2y16nyO3zGrcihYp2pLMRuuplochB0KS5fMizOwkNbbJTAvp
         hEuWossHulWLZQS7+7kaIyA3ig1gOJXIv1vECre0852liUHQcTLBIpt8xtyPd/nA8OAL
         Rb3HX2f+v6O0yYbWPHJHgXJKnv0Kk1Ac7KrkMDiMmzfnTd8UXBZKJZbdtmAJ82LcD1Ss
         6zw21ZNnfu7KlA9qeGxqVV/gF0fHvBJeyISZEb11p3YiDwwqS0jhnuLkcRxb7u9Y02+l
         GC6jNhabuTo0hOc/F57ponYHrM6f8xhPSj+27nNjZS+8+Q+tgvxL7AzVkEU8F6L6f/iv
         g7SA==
X-Gm-Message-State: AOJu0YxsE5JhY+GJAwgFJ5lXvfxOQRmRfi7LqGvvkd8PTLL6RLIJ6SFW
	uyDA+tdKFgaTHHAzxCJs6ZEHllGjIymDYKse/tsujMbcsbyAYQN7pM/Z/5yMfIE=
X-Google-Smtp-Source: AGHT+IE4rAwFz4YToK9oIOrST4cNJVzihTb7ARFndMACSf9P5n3oVTiyvIASIpzgE+N85pWnytiblQ==
X-Received: by 2002:a17:907:7d93:b0:a99:4c5e:1b35 with SMTP id a640c23a62f3a-a994c5e1e7fmr375623166b.5.1728378027050;
        Tue, 08 Oct 2024 02:00:27 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994e6e571asm294701166b.85.2024.10.08.02.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 02:00:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 08 Oct 2024 11:00:05 +0200
Subject: [PATCH v3 5/6] thermal: tegra: Simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-b4-cleanup-h-of-node-put-thermal-v3-5-825122398f71@linaro.org>
References: <20241008-b4-cleanup-h-of-node-put-thermal-v3-0-825122398f71@linaro.org>
In-Reply-To: <20241008-b4-cleanup-h-of-node-put-thermal-v3-0-825122398f71@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Chen-Yu Tsai <wenst@chromium.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1416;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=NAkU7Fk6Fp6cGUBKd+rBMuQ31s4lw/iDzBqC00OUzpk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnBPSeZwtVtveYq+plqJz96zA+Pl5Z10FmeGEoL
 z8/CK2Td3iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZwT0ngAKCRDBN2bmhouD
 19neEACPde0mZ3s9xDglnBk+mwX4fYnnR8YXiTLCvHtDoaID2MYCaS1/7liq1DK0w5ky95SVDfC
 lhNAjEEg7PICNBWpbcaGN3HmTqAJnBzqG48JxxPY0aL+0O+v0gYouUOg2Fen2+Bkx6Ww9dqoc/o
 b/ssg3PXLBrlIKvnr9TQG/a7R6ScWMInk9hROjjqa0wa8Qgf5Nod5OjDOj8eSlYZGYArRuQuJIK
 GxjDjXBjyuocDsS3gIwACdpad6Xq73fRnCHa+daqvzPkXTdoDvxne0pji/O3SWOc1XaPef4jZor
 VnhZx60VBfpe9mUu/SKskmb6eJTHMliR3VOd+z2rd35fEj9Ld+ZoMgqvgtYfMKppDfAIsY/nOEM
 j4Ty7gK+pfvlzClxwec9I1SfuS7u/iw/7b4bUof+NiTQfWVpq7JIhj0JID599K1sONd3KYR+n7l
 YV8obDRv68tTDgCgJHUPHLvfEb/CvDlbFrV+z8SBKni5bAVd559zQCMMkxIZZMmprhEwz5FhmxS
 q+dmqM084LYIbThZnZFUZNttvJQ24ILNvNBs5iesW3E2cs+WAMBNbITWDWQX7T8Upr14tH5bTHn
 XOW2R3O5u9gZoaGdC9yXwGMPr88H0hXRJKbpoPpxsjoRD5GG+jyzcePviq2TNoxErvhTmh8Vkmd
 VnXeFrorXAr9TYg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/tegra/soctherm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index a023c948afbddd6d9fc1a00b2fe310c71147bda9..ff4eedb553fb6e78c94b714dd179193c244b6589 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1651,7 +1651,7 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct tegra_soctherm *ts = dev_get_drvdata(dev);
-	struct device_node *np_stc, *np_stcc;
+	struct device_node *np_stc;
 	const char *name;
 	int i;
 
@@ -1668,7 +1668,7 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 		return;
 	}
 
-	for_each_child_of_node(np_stc, np_stcc) {
+	for_each_child_of_node_scoped(np_stc, np_stcc) {
 		struct soctherm_throt_cfg *stc;
 		struct thermal_cooling_device *tcd;
 		int err;
@@ -1683,7 +1683,6 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 
 		if (stc->init) {
 			dev_err(dev, "throttle-cfg: %s: redefined!\n", name);
-			of_node_put(np_stcc);
 			break;
 		}
 

-- 
2.43.0


