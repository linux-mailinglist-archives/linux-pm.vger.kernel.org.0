Return-Path: <linux-pm+bounces-33357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99371B3B1D6
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 06:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92511B27C48
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 04:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7153C223DF9;
	Fri, 29 Aug 2025 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDMA8kso"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349601ADC93;
	Fri, 29 Aug 2025 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440093; cv=none; b=LmxeW/pP0aD/6axUA0UcaHr2r0eSR9J8VIyBVyO2S1TS+NU8V7h0xQribKRyNScKBJm4E8BA82yKl8yU2oVC2VLi59lw/RBBFO4yTSXNggZEHQmQlFtJAvq3B7gZiWsjbi+AC6IBeMbsxqnu3WBDuM2Nt1bGn/FPhmhh32lDGOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440093; c=relaxed/simple;
	bh=Bl/tJOTKjknTlqwTUEECiiOiLP9LSlUl4/kl3b+x9+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=avm51Jv+QTfm2+gQb+fu/dZKe98yEypjx3k6EWuUJiPoROVt4kespoD4hiBghFCHyso2cW0HYCE+fzhstg9FaivPpPZwdMELSKd2fVPMbTRdSNGgQfr4+oW5F4sJkxl5O3EhiEEGZiwxRZ84Ym1VtXkiCZ82pYbtl7H3PDv1J8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDMA8kso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC7ADC4CEF9;
	Fri, 29 Aug 2025 04:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756440092;
	bh=Bl/tJOTKjknTlqwTUEECiiOiLP9LSlUl4/kl3b+x9+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KDMA8ksoeoTM8O3RtazAj01soDlySyTVfmE9uEXPH2JedoG1ESAVtDwSR+C66eN5Y
	 QwAa81bD7luRD2+B7EJoIfVTAA3yo5INpFxAqOlH0ZY/tSSO1tpr7UBJqx9QCCKRy0
	 Iscf28+cJsdJI4AYtnLd515ixoP3l+9LN0STPGfW4EKf3iiGL9ttN0tzG8gDoAKMG1
	 trvty8OSpY/JQ383Dab6TGiJ8fLRS5xXpfBBTiumuYnF8wEuHPZ6qq5soB5WQ9C9UF
	 7vYZKznT3chbDFazaFzvY/0UDmtvNPi3a+kW4M4bIDHDRIuk9sKZjI9UsV4hR4keRE
	 8BvLHOhf7d9lg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44C3C8303F;
	Fri, 29 Aug 2025 04:01:32 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Thu, 28 Aug 2025 23:01:29 -0500
Subject: [PATCH RFC 3/7] soc: tegra: fuse: speedo-tegra210: Add soc speedo
 2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-t210-actmon-v1-3-aeb19ec1f244@gmail.com>
References: <20250828-t210-actmon-v1-0-aeb19ec1f244@gmail.com>
In-Reply-To: <20250828-t210-actmon-v1-0-aeb19ec1f244@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756440091; l=920;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=isojD+vsQ6GMUI0n4UiI6pXl1P82vMLWzP2XI6DOUIc=;
 b=X+oENOtJ6PSQK6w4M/b6v+yDlwJUZO3OSStcth+1qalGBeKfPpEtGc4atN/hx6XMeQ8M8e2/j
 ncYPgf1yFrhDvPH8t5qb40TXI+YezXwulKE1eq2xbPh73GxaM9s2ha5
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
index 1cdd70c59c0753e602709f9179c0ab67d1b8f5e3..56d7b0858050b7e5bc931a9491d68b1ce7cc427c 100644
--- a/drivers/soc/tegra/fuse/speedo-tegra210.c
+++ b/drivers/soc/tegra/fuse/speedo-tegra210.c
@@ -101,6 +101,7 @@ static void __init rev_sku_to_speedo_ids(struct tegra_sku_info *sku_info,
 
 	case 0x8F:
 		if (speedo_rev >= 2) {
+			sku_info->soc_speedo_id = 2;
 			sku_info->cpu_speedo_id = 9;
 			sku_info->gpu_speedo_id = 2;
 			break;

-- 
2.50.1



