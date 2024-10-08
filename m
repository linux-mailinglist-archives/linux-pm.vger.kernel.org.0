Return-Path: <linux-pm+bounces-15310-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B909943E8
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 11:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C5D1F2318F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 09:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF7D193082;
	Tue,  8 Oct 2024 09:14:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1021925B5
	for <linux-pm@vger.kernel.org>; Tue,  8 Oct 2024 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378879; cv=none; b=dl6rWZEjDEze3Y30odvHhA0H8amCIVAm6rvpIeKodrSxKD25bK+grY7REb/+eaRDU5F0XLgh54TgBX+xJ8QCiOMWQs3N318/QL7q7Jyoe7pnIKpX5ErzFmAgQpqZ1ym6p/HO4Oz086NRNyj7b7OjmHzzezVxr3niLqdo4JEvXk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378879; c=relaxed/simple;
	bh=RbAAAptohwkXGF/lWasQYEt4BriFrYvFkoZCqLFBweA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lisP+qgzeb70JSk1LhLEF3fgd2P/AAvfPf9oIHrAnSL+1uy14239rkuo+2DREuDy6e8mn2Yth+GRu6+3HvkJZHuEXbnGoPXc/EUp2y58jhI9dZz5EQ7J/zarfsLb6C8eFkOePcuIWK1wu2CRuS53Xn/LCgm90NOG1Bo969eHnhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:af78:ce2e:2b4b:9f2a])
	by michel.telenet-ops.be with cmsmtp
	id MlET2D0090Eqs9l06lETAF; Tue, 08 Oct 2024 11:14:28 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sy6IL-003RYJ-1y;
	Tue, 08 Oct 2024 11:14:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sy6IV-00D2DE-HA;
	Tue, 08 Oct 2024 11:14:27 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 1/2] arm64: dts: renesas: r8a774c0: Re-add voltages to OPP table
Date: Tue,  8 Oct 2024 11:14:20 +0200
Message-Id: <2046da75f3db95b62f86c0482063c4d04c2b47d5.1728377971.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728377971.git.geert+renesas@glider.be>
References: <cover.1728377971.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_ENERGY_MODEL=y:

    cpu cpu0: EM: invalid perf. state: -22

When removing the (incorrect) voltages from the Operating Points
Parameters tables, it was assumed they were optional, and unused, when
none of the CPU nodes is tied to a regulator using the "cpu-supply"
property.  This assumption turned out to be incorrect, causing the
reported error message.

Fix this by re-adding the (correct) voltages.  Note that because all
voltages are identical, all operating points are considered to have the
same efficiency, and the energy model always picks the one with the
highest clock rate.

Reported-by: Renesas Test Team via Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Fixes: 554edc3e9239bb81 ("arm64: dts: renesas: r8a774c0: Remove bogus voltages from OPP table")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 7655d5e3a034166e..5d4db20033212218 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -49,14 +49,17 @@ cluster1_opp: opp-table-1 {
 		opp-shared;
 		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1030000>;
 			clock-latency-ns = <300000>;
 		};
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1030000>;
 			clock-latency-ns = <300000>;
 		};
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1030000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
-- 
2.34.1


