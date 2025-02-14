Return-Path: <linux-pm+bounces-22093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C20A36450
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 18:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85D61894FD6
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 17:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ABF268FC4;
	Fri, 14 Feb 2025 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IWrbobA7"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969E7267F79;
	Fri, 14 Feb 2025 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553573; cv=none; b=e7lV9A9jrxhzQeWZGWIhlIAuoBtEzj60ZDsywv0S7lZpOLA3iJnK64X1lFKwQvFAdbWFJLoTCPysXvUgcp7hepUv+DaOK2ZhizK4pOZCYT+vlBcpk4JtLZ4+U14WR3QRR0k4cf//WZ77ij9hIQ2Cm2FvlhaWEqcFC+Vfr6Gas7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553573; c=relaxed/simple;
	bh=wI++aCyUGB25LBiHVhu7McH+lo9hKNW4TKBihjV2t5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lld814qBxavrw3sviNofI6wm5FfSxtadtXHWLQKz5rd8h8yocBGo7yZPOpOkXho6VYFMGWoYn7X8tpHRIparbQAbUZ/iPH4QVcub0lFlxZPJnV+sYxTPjL4m0rIXf/HdWGE0jq+Io5Zm/ucao8ZNsoaeo0BBhX5SHqQy5wi9yY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IWrbobA7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739553570;
	bh=wI++aCyUGB25LBiHVhu7McH+lo9hKNW4TKBihjV2t5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IWrbobA7J++IfnQOw9xWZ2+m4v9jqen7hW+JDSNXSiUOt6shIZyidH35E3W9NNlrd
	 IVPMdIiT1MYRz9LAv6Wq9JPOpm+Vl1JlzCsiiihVBAcSQfKC7u3o2ZRkHKlec4WZJx
	 a9AE5x0r6RX7ca2y8nl7R/uFH3nfMO65JSeovN35VY/oBEoEu1zxzKeKkXzx6FoCDy
	 LNOxSpkcjeSUNPD41iPJDBJhtnTdywV3hyKhCncWMwSu3MCdtCb6e9b/v4zmZuDOoP
	 6+XqrVWcRpKBHwk0KkXN2fmUdZpj7+m809W0K1f/mIuJnvZl4PnN+nrOoSnR/BJ/UO
	 a+RGSXpTfQiKA==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8109E17E0239;
	Fri, 14 Feb 2025 18:19:25 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 14 Feb 2025 14:18:34 -0300
Subject: [PATCH 03/13] mfd: mt6397-core: Add mfd_cell for mt6359-accdet
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250214-mt6359-accdet-dts-v1-3-677a151b9b4c@collabora.com>
References: <20250214-mt6359-accdet-dts-v1-0-677a151b9b4c@collabora.com>
In-Reply-To: <20250214-mt6359-accdet-dts-v1-0-677a151b9b4c@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Andrew Perepech <andrew.perepech@mediatek.com>
X-Mailer: b4 0.14.2

From: Andrew Perepech <andrew.perepech@mediatek.com>

Add an mfd_cell for mt6359-accdet and describe its IRQ resources to
allow the mt6359-accdet driver to probe.

Signed-off-by: Andrew Perepech <andrew.perepech@mediatek.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/mfd/mt6397-core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 0e5d59ae064a696ae2111e2b558b316667c14773..5f8ed898890783c0ce4e34c7eae0d8f678e7d7bc 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -84,6 +84,12 @@ static const struct resource mt6359_keys_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6359_IRQ_HOMEKEY_R, "homekey_r"),
 };
 
+static const struct resource mt6359_accdet_resources[] = {
+	DEFINE_RES_IRQ_NAMED(MT6359_IRQ_ACCDET, "accdet_irq"),
+	DEFINE_RES_IRQ_NAMED(MT6359_IRQ_ACCDET_EINT0, "accdet_eint0"),
+	DEFINE_RES_IRQ_NAMED(MT6359_IRQ_ACCDET_EINT1, "accdet_eint1"),
+};
+
 static const struct resource mt6323_keys_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6323_IRQ_STATUS_PWRKEY, "powerkey"),
 	DEFINE_RES_IRQ_NAMED(MT6323_IRQ_STATUS_FCHRKEY, "homekey"),
@@ -239,6 +245,12 @@ static const struct mfd_cell mt6359_devs[] = {
 		.resources = mt6359_keys_resources,
 		.of_compatible = "mediatek,mt6359-keys"
 	},
+	{
+		.name = "mt6359-accdet",
+		.of_compatible = "mediatek,mt6359-accdet",
+		.num_resources = ARRAY_SIZE(mt6359_accdet_resources),
+		.resources = mt6359_accdet_resources,
+	},
 };
 
 static const struct mfd_cell mt6397_devs[] = {

-- 
2.48.1


