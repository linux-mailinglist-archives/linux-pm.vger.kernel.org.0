Return-Path: <linux-pm+bounces-38070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CC9C5E9F9
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 18:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 574603A7C4B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 16:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013C133EB1D;
	Fri, 14 Nov 2025 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="FOVq4UkK"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E4033E375;
	Fri, 14 Nov 2025 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763139313; cv=pass; b=Nt+iV/eNQJwwaZCALV1FVQcP9YweAZz5toIdlzM2CRMHj0MTzHPJhr2nwHqyenCR6ZPWxpL8gZAJ0iJpjr/58CayPUOYvSLTziw2MDpliYrXp1u/wsGychmCUwtJSfcGEz4Vb5BcwmcU0uF5aF4apmfPYrL68FHOzKJMF8PKJbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763139313; c=relaxed/simple;
	bh=d1gnFMuI7qTAJxQJW4zBCoK/to4rjJMOw7v99JEKCuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B6OZ8B/xxOiu6ypDqsdpUAMVNRhPxg94OfEQRchSD2dr9Nv2EgLiTnvhqvGbkCdVBTQYJ6C2etsn+wVS0jxST+msKIGxoabDyE07L/IlakdiBXuk9BK1QMLPzFk3FoWpT3CVpuRw0E0CWpLgan8KwG/ObxtQD5Oja0PLl59uv2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=FOVq4UkK; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763139296; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h5OiMH7vcp26YusQN7J8hqNMoIYH9GkcIHxPj08uajIe7iiXyFTvEBXpI9H/c+/PAmVr7Zf2V/EKseEDXioL+Dd0B1omlJkC6K+0uPEm36HQl635CLahLIsMB898Vi9sPtDVDPT2N55BnEP6QlOvH/I/RWG2OGomQsGKJY2nxyY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763139296; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iI9J4tlNC+SSMmhFiTr7gPMAWNKQHr77sZKRtT+r31Q=; 
	b=eQ1A3H3Cp1YGfezXpOXoX2ZUYchKqJD8nj2RcKDJs4odlxjqu9oldKRkhQNT5vVWpN81zdD7aWM2gAinFhehCgHvQq0kJ1aH9fsMV0XB9dQLYmc4+yju0NZ4QsccdsX8CdpwA5Zl0Hb6InCrn3LZ61asSJ9O+yO8z4lJBMcdjkc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763139296;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=iI9J4tlNC+SSMmhFiTr7gPMAWNKQHr77sZKRtT+r31Q=;
	b=FOVq4UkK7aWrgSfBx2m2IFqsM6HoW64gusj9Lfzkfc3nRxuPs96vLFSWOP8xqatS
	VPCYwRdbzG8aN/JtJcE2KbCREX9aqK4knBNMIhYQyufyRPsL/g6M3qcPdoAUCrGt0Bz
	ZAzOlQG4wREuMDa7aIOzLa1gx3qUf06IP91LMVsY=
Received: by mx.zohomail.com with SMTPS id 1763139294579227.16027413825054;
	Fri, 14 Nov 2025 08:54:54 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 14 Nov 2025 17:54:07 +0100
Subject: [PATCH 13/13] interconnect: mediatek: Aggregate bandwidth with
 saturating add
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-mt8196-dvfsrc-v1-13-b956d4631468@collabora.com>
References: <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
In-Reply-To: <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Henry Chen <henryc.chen@mediatek.com>, Georgi Djakov <djakov@kernel.org>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3

By using a regular non-overflow-checking add, the MediaTek icc-emi
driver will happy wrap at U32_MAX + 1 to 0. As it's common for the
interconnect core to fill in INT_MAX values, this is not a hypothetical
situation, but something that actually happens in regular use. This
would be pretty disasterous if anything used this driver.

Replace the addition with an overflow-checked addition from overflow.h,
and saturate to U32_MAX if an overflow is detected.

Fixes: b45293799f75 ("interconnect: mediatek: Add MediaTek MT8183/8195 EMI Interconnect driver")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/interconnect/mediatek/icc-emi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/mediatek/icc-emi.c b/drivers/interconnect/mediatek/icc-emi.c
index 182aa2b0623a..dfa3a9cd9399 100644
--- a/drivers/interconnect/mediatek/icc-emi.c
+++ b/drivers/interconnect/mediatek/icc-emi.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/soc/mediatek/dvfsrc.h>
 
@@ -22,7 +23,9 @@ static int mtk_emi_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 {
 	struct mtk_icc_node *in = node->data;
 
-	*agg_avg += avg_bw;
+	if (check_add_overflow(*agg_avg, avg_bw, agg_avg))
+		*agg_avg = U32_MAX;
+
 	*agg_peak = max_t(u32, *agg_peak, peak_bw);
 
 	in->sum_avg = *agg_avg;

-- 
2.51.2


