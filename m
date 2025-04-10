Return-Path: <linux-pm+bounces-25119-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5ADA84691
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 16:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C0317E120
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 14:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D7128D823;
	Thu, 10 Apr 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EuLiPLHY"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7C228CF46;
	Thu, 10 Apr 2025 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295998; cv=none; b=AoD6+M/kBpU948TtemhUkIEC8y1QFIot5n18gRVTo7uQxLt332vOpwq2UOzKHVZ2r2BA02pessuUSqAde2qiVzEMedy3tTZPUBBXI7/2a/FvsTkF18DrsO6lcs7LoB5M/0YihYdIOKvaK+EtuvUGlii9clIp5lkmXDDxYxJqA/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295998; c=relaxed/simple;
	bh=8jM0GiTANEpN3Vvw34YI8E8ETk1hl9c3ELCXlQvppCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+7jHQ59gK8vpTOVbnRl/azaZs7jGB+evlnxl3fnWj7AqY3r98yLuDKfUv4B9v/kHQi4kMINtJOB302WhL2YRxDjBGf8ijPipVuvr/kUHnglFvnYxmBqIRfu9YuLvCPi4J2RPDMuPv49Ym2i86TyK6FkRnKFTuscNv6L69IjSrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EuLiPLHY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744295995;
	bh=8jM0GiTANEpN3Vvw34YI8E8ETk1hl9c3ELCXlQvppCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EuLiPLHYqE/fGWVcqYHo1RYKTffLc8Pdb2+BnOHQU9QYtaGWYjs8AowpnMbL+A53N
	 Z3lg31kAx6ADFxhbwgOlIeEpdWp7gfqF7xskNMBEfkRcTGP4416oBJUgt0aGWOl3MW
	 YmtqQFED+JIc63F/rzKiB53XVoqKtvyryszOo9MS9eYBNiwf+9tXo/ogjsrd8oSF1Q
	 SgUoIOGD663S8pxZUJob9Jc28eky+95vXSue+jApT9qN688ZuYoSBFyBtDfbLn4Qz+
	 gLXgtLg/qkVIPLlALrzaJak1lokXKM3uC+CEF0kCBpyT43N3//4TJ1Uh6rlq+UeZyO
	 /8pQkZw2Laj0g==
Received: from IcarusMOD.eternityproject.eu (fi-19-199-243.service.infuturo.it [151.19.199.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8A08817E0EB8;
	Thu, 10 Apr 2025 16:39:53 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	fshao@chromium.org,
	y.oudjana@protonmail.com,
	wenst@chromium.org,
	lihongbo22@huawei.com,
	mandyjh.liu@mediatek.com,
	mbrugger@suse.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 2/3] pmdomain: mediatek: Bump maximum bus protect data array elements
Date: Thu, 10 Apr 2025 16:39:43 +0200
Message-ID: <20250410143944.475773-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410143944.475773-1-angelogioacchino.delregno@collabora.com>
References: <20250410143944.475773-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding support for the MediaTek Dimensity 1200
MT6893 SoC, bump the maximum elements of the bp_cfg array to 7.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
index 2ac96804b985..7085fa2976e9 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
@@ -44,7 +44,7 @@
 #define PWR_STATUS_AUDIO		BIT(24)
 #define PWR_STATUS_USB			BIT(25)
 
-#define SPM_MAX_BUS_PROT_DATA		6
+#define SPM_MAX_BUS_PROT_DATA		7
 
 enum scpsys_bus_prot_flags {
 	BUS_PROT_REG_UPDATE = BIT(1),
-- 
2.49.0


