Return-Path: <linux-pm+bounces-38454-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65281C80243
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8AFD3A3582
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EF92FD7D2;
	Mon, 24 Nov 2025 11:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="AVmokdW+"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837E82FB99B;
	Mon, 24 Nov 2025 11:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982495; cv=pass; b=f+/TqCGLLQAYypCKHpZRzjHNlkbAiTL6U1b3HmtUCHHdY7YOzZDPDwVoaQoBPK0ciAK/0q5CkY3tintastEXB/nO9HTDml2XyFsMjgPquseGmQeE4RYYRIOpLpnt6rm3szEeaHCX/M4LYzNdWc/5PKShm7yUbyqriBFOOi3yzyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982495; c=relaxed/simple;
	bh=V5x8hVM3+HVrOj1QgAtegq88Chg4b2A5o5KIyuCPGg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lt2GAxkYl+THHmS3X6d0TDaoJvDdCeC0tXTSn3QOaYh9TeKUU0sWQzllMW770Va/equW57SIGLuu8BRsRU3jXKrDE92c+Bi2hUIKa0FqCrL0heGsQZ/7VJISURUzk/vjkDMS+slynbUIBDlpyCHCnHwulV1sbzi5WaU995k0N2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=AVmokdW+; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763982473; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nzoEES+ACjGpL2CgVFGgU3syBjERBvBzhN2kRTtThhbgqW8+KEXCK0p2EHEHLM5fmYE+JJjSPA5rMq32ZjhglrlDVH9XsrB7yTlhLGUfDHjcClXdhra+EBORdl8w0PuSl/020ArSCO6FfyP5LXSBfp4RiUvmGxyMyk8c7y5PQfM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763982473; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7+Y/LyMk0RrNOFdGUfyDXTf7l2qJ7k0vXn6vVykaLc8=; 
	b=H4d4NAzp6dvdj1wstSaU088jgygaBkwHcYMTZKSYAtU0LBOWBbgWhkJReakAudE1jNU5tuiH4vIFatz4KtjjpogkVOn3BtxShyAPsWd8D8SRDyk+H4LsMsBiM85QL8wNwqJ8bkgyo8V/lJN/bdd5Eh5c6HveI4ys0+1gaBvbWmQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763982473;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=7+Y/LyMk0RrNOFdGUfyDXTf7l2qJ7k0vXn6vVykaLc8=;
	b=AVmokdW+EbfVSbxse8mX8JqLaz73oLON4Ix1989B+b1JvAWx4APu8+U9BsER4k0j
	JRIJ1EUukJeQbhAIW7vtY41USUwALnigG3YDg3pP6vbhyXKgm9y+x+nOodTuzhqnwTS
	bfeZVLFjt02/L+A6PvQq2xPcbH6lrTv8C9GGOmFU=
Received: by mx.zohomail.com with SMTPS id 1763982460325118.87585361846197;
	Mon, 24 Nov 2025 03:07:40 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 24 Nov 2025 12:07:02 +0100
Subject: [PATCH v2 13/13] interconnect: mediatek: Aggregate bandwidth with
 saturating add
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-mt8196-dvfsrc-v2-13-d9c1334db9f3@collabora.com>
References: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
In-Reply-To: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
2.52.0


