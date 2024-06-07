Return-Path: <linux-pm+bounces-8762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C88E8FFF35
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 11:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72656B23E7F
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 09:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC6C15B967;
	Fri,  7 Jun 2024 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b="sdVHFK8s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qUBjp0xE"
X-Original-To: linux-pm@vger.kernel.org
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DAF15B15F
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752128; cv=none; b=LlqZpOZnDDKTfocBNh6YGO8uI+wGNcyo/OIYF8MOtt/nrq06o2LXe7E4iLXW7vPt5R6TKWxbrUBBi3ZA3l6NrEdZClr2xHwQIb/q9qTWQ3MC0cY69IcET6qyWt1v42iNfQ/BpNQiOGizzRrYAS3NCaNHMTUT88nkiDso0pohmrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752128; c=relaxed/simple;
	bh=bALKyIzSRDGCxZtdIHJAhmVSzKCaPUEqiaT81JjjFss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZEkPqawXCGcLo0t/UHew2GQyl1+ZMFkpVk8Za4msc2YgwBA9yvUkzjUNZkxSDOCCzlVZCZhIQMWb7N5QYWhuDU6tZhyY7Ww5B1R9QYhkxia7MQTbY1AiwwqZ1RYNSkwN+4e1zyY06GeY/o36Vz2g7IGyw72CuwP3VFBVUezxFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=testtoast.com; spf=pass smtp.mailfrom=testtoast.com; dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b=sdVHFK8s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qUBjp0xE; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=testtoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=testtoast.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 789971C000A6;
	Fri,  7 Jun 2024 05:22:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 07 Jun 2024 05:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1717752125; x=
	1717838525; bh=72uI3eq4d6+OkMTAQhAMzTpRYez97FZdnnGMYFn3G1s=; b=s
	dVHFK8sfaSBfjusu0TcpOZG1OPAZSBfvw5/VRjzsKBH7A5cFLcD5wRii+sr6Qrcs
	6IEzLTI/O21UA81v7z5dYpVpWeUV6am9w46rUnquEmlQpewbsc8EiSqfkrLz5KH8
	+jyaoZuv6DMaqe8vMoyxGlnCfoqqLCPW8QlaoXF9hhfbmJZ1a0/X7SLEnOXJeCxL
	cYRFcQanmoJggImxXsJ4Cl3VYaIF3GyIvD1pW82q6yissRcAkguKSB3pjHlGk4Dq
	JNk8aYNdHclvT1uld7usSNhs/Jjo1zM3bK/Fv6tENoGjwnr8zwGfPErsWTxFaeg8
	r4fZdmMNCsbrOoyn560ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717752125; x=
	1717838525; bh=72uI3eq4d6+OkMTAQhAMzTpRYez97FZdnnGMYFn3G1s=; b=q
	UBjp0xExKleqcgDMtMPtUgLITGp50zY2wRodVXNDuaVTBFDlw26Q3U5zwZZIEiTI
	Bkc7f2hfZCh6+OYWxM3q/LmjxhDKnuQ9WWvjwE0Y8yJIDMjRfbMjed0lLgWVUDfX
	7WpbxHbYvHLr1Oo1lZN8MSCFCuH+hr+W70XpADWrXyGGk8bK9yzflp6e1sFGdeQj
	NbIthU85DyNwfvgpGbR5ye17Op+ZCYDyRufKdrcC3RbP3myrt6mQ6YVOjH67Zodi
	lzPv1EOMAsqyaRV5RuxKkOYbWYCUQWeqLBbAu+G0O1lxQ0+9hW2UHNNudrauS/Uh
	Eia9plifbzMzc5N0mE6EA==
X-ME-Sender: <xms:PNFiZky3ydc7P1lph4moixN6V85NDWqYQsWNetVIqa2N-LsaqhvXAg>
    <xme:PNFiZoRvl0WL9OkeuPCAj1JbqMQlKj1v32iGb2VHRi0wkcXhduIqIikeTvRDztQ9o
    NaGDG3Qupaq2e549w>
X-ME-Received: <xmr:PNFiZmVru-y80wfr3pM3HLC742TqO6gdbn7mCyrrGYZs7xB-QZfO98AkBG1na4LcyatQIdmRqmoelzKsXJ2mbvXcuDsujmyd5PQpFSNc4TwyqGP_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedttddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfihrghn
    ucghrghlkhhlihhnuceorhihrghnsehtvghsthhtohgrshhtrdgtohhmqeenucggtffrrg
    htthgvrhhnpeffheeiffegtdfgffejteevgeefkeelieelkeevueetffetteduffevgeei
    ieehteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hrhigrnhesthgvshhtthhorghsthdrtghomh
X-ME-Proxy: <xmx:PNFiZijkSAr-hfqy_4Is3ydPhEbmZXvSomQcelw4vCnq3AZrcVW58A>
    <xmx:PNFiZmDZKB8dmNIHM825H2dOd7n7sm1tBANVHdqHWIWJvLZ2vjTXIQ>
    <xmx:PNFiZjJqFx1E_rZyitRSSs5jA01nDFOhlAFyusNAPL_y_NwjhiRpGA>
    <xmx:PNFiZtC0FiEfdl74ZUdqUzvPhgLxMJJH1rVrgGRtuv09DypcCd8iIQ>
    <xmx:PdFiZu78vH67yrYmgrY96lxPdsexbLz05Bd1Rv9rJjQmC2JAnajh66nB>
Feedback-ID: idc0145fc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 05:22:00 -0400 (EDT)
From: Ryan Walklin <ryan@testtoast.com>
To: Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Chris Morgan <macroalpha82@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Ryan Walklin <ryan@testtoast.com>
Subject: [PATCH 2/3] arm64: dts: allwinner: h616: add additional CPU OPPs for the H700
Date: Fri,  7 Jun 2024 21:20:34 +1200
Message-ID: <20240607092140.33112-3-ryan@testtoast.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607092140.33112-1-ryan@testtoast.com>
References: <20240607092140.33112-1-ryan@testtoast.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The H700 now shows stable operation with the 1.008, 1.032 and 1.512 GHz
DVFS operating points. The 1.5GHz OPP requires a VDD-CPU of 1.16V,
obtained from the vendor BSP. This voltage is slightly above the
recommended operating voltage for the H616 (H700 datasheet not publicly
available) but well within the absolute maximum of 1.3V.

Add the additional 1.032 GHz operating point to the H616 CPU-OPP table,
and enable the 1.008 and 1.512 points for the H700.

Signed-off-by: Ryan Walklin <ryan@testtoast.com>
---
 .../dts/allwinner/sun50i-h616-cpu-opp.dtsi    | 25 +++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
index aca22a7f0191c..dd10aaf472b66 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
@@ -11,7 +11,7 @@ opp-480000000 {
 			opp-hz = /bits/ 64 <480000000>;
 			opp-microvolt = <900000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
-			opp-supported-hw = <0x1f>;
+			opp-supported-hw = <0x3f>;
 		};
 
 		opp-600000000 {
@@ -25,7 +25,7 @@ opp-720000000 {
 			opp-hz = /bits/ 64 <720000000>;
 			opp-microvolt = <900000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
-			opp-supported-hw = <0x0d>;
+			opp-supported-hw = <0x2d>;
 		};
 
 		opp-792000000 {
@@ -50,8 +50,16 @@ opp-1008000000 {
 			opp-microvolt-speed2 = <950000>;
 			opp-microvolt-speed3 = <950000>;
 			opp-microvolt-speed4 = <1020000>;
+			opp-microvolt-speed5 = <900000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
-			opp-supported-hw = <0x1f>;
+			opp-supported-hw = <0x3f>;
+		};
+
+		opp-1032000000 {
+			opp-hz = /bits/ 64 <1032000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x20>;
 		};
 
 		opp-1104000000 {
@@ -59,8 +67,9 @@ opp-1104000000 {
 			opp-microvolt-speed0 = <1000000>;
 			opp-microvolt-speed2 = <1000000>;
 			opp-microvolt-speed3 = <1000000>;
+			opp-microvolt-speed5 = <950000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
-			opp-supported-hw = <0x0d>;
+			opp-supported-hw = <0x2d>;
 		};
 
 		opp-1200000000 {
@@ -70,8 +79,9 @@ opp-1200000000 {
 			opp-microvolt-speed2 = <1050000>;
 			opp-microvolt-speed3 = <1050000>;
 			opp-microvolt-speed4 = <1100000>;
+			opp-microvolt-speed5 = <1020000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
-			opp-supported-hw = <0x1f>;
+			opp-supported-hw = <0x3f>;
 		};
 
 		opp-1320000000 {
@@ -85,15 +95,16 @@ opp-1416000000 {
 			opp-hz = /bits/ 64 <1416000000>;
 			opp-microvolt = <1100000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
-			opp-supported-hw = <0x0d>;
+			opp-supported-hw = <0x2d>;
 		};
 
 		opp-1512000000 {
 			opp-hz = /bits/ 64 <1512000000>;
 			opp-microvolt-speed1 = <1100000>;
 			opp-microvolt-speed3 = <1100000>;
+			opp-microvolt-speed5 = <1160000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
-			opp-supported-hw = <0x0a>;
+			opp-supported-hw = <0x2a>;
 		};
 	};
 };
-- 
2.45.2


