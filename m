Return-Path: <linux-pm+bounces-40725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07406D18576
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6D9F3019078
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4359F38FF19;
	Tue, 13 Jan 2026 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kfynO2Fw"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC4438E112;
	Tue, 13 Jan 2026 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302021; cv=none; b=ruoiqcV239nN9mdCmllDnBVxBhEyG8nMrfdwr3o3MYuctfwAPW7JrW5yvT0ZQTois0ybSPrtIUGceu7eDEYiaEfAHrnpRhJoFTDGHQ85kKFxkJEYdoXjk4pKODHBkt5NKA/vPyqJ6QZxiCBcW7nindzGmJ0id9GbEFajy9v8Ty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302021; c=relaxed/simple;
	bh=Qtzz12boIO/VIHRD3C752NQeLrf04iw9L8Q1Ovq/IUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OraRrM00FGLVDiJeAxqA/rWWniSrDOgcHWUSojupxrokNqamRjSNylo4Lho3gTXlnHoq1gwFh37YP3M/t3CQGERiOwQeO+199H9UOg04XGtlePqWi6BDOM/XQ71Ottbt9fqBbSZ/1tKdu++HVdSp0ac84ATVnzeIr4u+zCtmaa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kfynO2Fw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768302017;
	bh=Qtzz12boIO/VIHRD3C752NQeLrf04iw9L8Q1Ovq/IUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kfynO2Fw+GmTUUJqbGGo7tn19FvNwLBWV3hhk8lcL6XU3zlCKt/ZexsO3EVcMl8Ru
	 b/G7wP2iQLL0Mn2/24j3bpuwI0EbVDStOa5UlZD/Bgm2qrJTPciB8w5huhrfXFONbN
	 ulrMeSadQKUM0g5UQkV5TvDKUWDd4yg3n6xFG31tc+JcRvH0UGOdE/tEXTphxQGZta
	 lAyCAnUU12GuXKEXrvI/dOR1qe7S/tMHZC1p699GDrkcCqDzFe2aX+gsJhpThU+rTC
	 SZk+3iQKYmteH8ClyWE+GUpfICjZaMh9vCDD6Uv1D4IE6yYGG+PH/ot8f732mPTlT8
	 /D+Sxp1qdSMqQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1C57C17E1406;
	Tue, 13 Jan 2026 12:00:17 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ulf.hansson@linaro.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 4/5] arm64: dts: mediatek: mt7622: Add missing clock to audio-controller
Date: Tue, 13 Jan 2026 12:00:11 +0100
Message-ID: <20260113110012.36984-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113110012.36984-1-angelogioacchino.delregno@collabora.com>
References: <20260113110012.36984-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing audio_mrgif_pd clock to the audio-controller node
to both resolve a dtbs_check warning and ensure that the AFE merge
interface is clocked while using audio.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 158bd9a305d7..133a6dcc8ef7 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -654,7 +654,8 @@ afe: audio-controller {
 				 <&audsys CLK_AUDIO_AFE>,
 				 <&audsys CLK_AUDIO_AFE_CONN>,
 				 <&audsys CLK_AUDIO_A1SYS>,
-				 <&audsys CLK_AUDIO_A2SYS>;
+				 <&audsys CLK_AUDIO_A2SYS>,
+				 <&audsys CLK_AUDIO_AFE_MRGIF>;
 
 			clock-names = "infra_sys_audio_clk",
 				      "top_audio_mux1_sel",
@@ -688,7 +689,8 @@ afe: audio-controller {
 				      "audio_afe_pd",
 				      "audio_afe_conn_pd",
 				      "audio_a1sys_pd",
-				      "audio_a2sys_pd";
+				      "audio_a2sys_pd",
+				      "audio_mrgif_pd";
 
 			assigned-clocks = <&topckgen CLK_TOP_A1SYS_HP_SEL>,
 					  <&topckgen CLK_TOP_A2SYS_HP_SEL>,
-- 
2.52.0


