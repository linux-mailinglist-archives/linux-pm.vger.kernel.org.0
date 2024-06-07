Return-Path: <linux-pm+bounces-8763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2684A8FFF37
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 11:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F50EB23E55
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 09:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7DF15B566;
	Fri,  7 Jun 2024 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b="DWUHK7rX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J6Pbmdeg"
X-Original-To: linux-pm@vger.kernel.org
Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4816F15B966
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752135; cv=none; b=LoGyukVaUjBlazkWL+PJY+lUVFHjD6tfH+TmkesUUqIrcHtz320iWH686HSC4EjvQ1qDvy2eCS+tQm8fgabXtEPI489jafccZ9M/qaQJPzc/zy35eW9NSpMYwNvfp4NGMyjCsmdfzevsCpW/uchP8jr7FaA41ffPfX7t9vPZ1do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752135; c=relaxed/simple;
	bh=nMH5sAxwLTlHNCz3W9DR7+oe5oiX22vEeO7r7HFHk2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RL2aIbBWR61uO4IBaSwUwqQmH/JI1jgtdwvDPwINfg+SQJtXtAvF4SNpwovM4cx+78XdyIzFZcqa+MCFaAlTV89h2O3sX+VBFPiHQqsEG0l/JXjtS9Xp0oYtsNAv6uNZO40Mp2K3YgCPUsvp0WcR/E5VSVQlVvLCRbf+MLRv3HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=testtoast.com; spf=pass smtp.mailfrom=testtoast.com; dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b=DWUHK7rX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J6Pbmdeg; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=testtoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=testtoast.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8AF4F18000D1;
	Fri,  7 Jun 2024 05:22:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 07 Jun 2024 05:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1717752132; x=
	1717838532; bh=wTssuKZRMqBCH3zPoFw+akm/u8gEjJC/xTfr8YeMiz0=; b=D
	WUHK7rXz3l0rLZfn/vPVncIksZINnZ4mtj8lBOUVx+z1Cg3s9pUmF9lhyn8nwl+5
	vt2qZ6O1P1jhe5nFAyhYCkAQI2pzJFDpZc+gu6zOs/FPPrPPocHg30KArcnyAtkq
	vIpZ0kemNm3RNmcn/8I/emtkvgWEGmD36ylU6yub9nCQZTVdbAuTFudXB+ErwPf5
	UJ7S0qCkOVkZpw1LjRgZqhksavtGddTVsQzFV/Z1NN0kpxzefO7U97gypUeNewGq
	ba6dTHrNSv2SADv2DrzpxyiTfXLoYZH2vzHgl+TkQW6pikEUqIt/HZb64UGiuH0g
	PCXpu2ksMMXwKeQZ1y4/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717752132; x=
	1717838532; bh=wTssuKZRMqBCH3zPoFw+akm/u8gEjJC/xTfr8YeMiz0=; b=J
	6PbmdegERKFAGh9P38ELaQFHgRHu64Q/Y7sK2FZtFSx9r2v49r9IQOQfelxHBhLG
	IR33aYp4zumsj1AFmA19be0cay0GWMOzx4VmEaXmBDb0ZcFmqO6atTzZfwTrMyMy
	5y1kqjX91t2CY8ZhHfjCNWTMGCzGAeXNjaxg8neDCKVZIapm31f3OpuMW9cBSRk0
	IaUae33tO9Mu2BJqdSV2E0gI4lnuwZ/pXXcAmFBOld/x29HISJyJw1Wf13h927ii
	fNrs5bJb4EcMLajMK9QW4ZshdrZQ0upMDFqCRKfXoMP+tmI5xdp7mZTtw6K26Zd3
	gTcmBcyjDKJWThybYzGzQ==
X-ME-Sender: <xms:Q9FiZhv0DYTos-WEES8Wv5vErYDIP6BeBhXdoiAhNzrx-sfLvczN0w>
    <xme:Q9FiZqdNG375Alkra62w6RSOn7nlnMmzhvo1jlId1OEY_Jw3ITXBDIvBLqzTPU6an
    l0djuHedwcnuvOhxg>
X-ME-Received: <xmr:Q9FiZkxyuJhv289dFSW44dDm7z3NF-2Z-_eui6TcfSS2hT5DkvPAELcOIKhOLoTg6kdO-t_eQsgt5d6dLS0i-FAZlTq5BaTLb07lAOtSsk-n3RuG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedttddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfihrghn
    ucghrghlkhhlihhnuceorhihrghnsehtvghsthhtohgrshhtrdgtohhmqeenucggtffrrg
    htthgvrhhnpeffheeiffegtdfgffejteevgeefkeelieelkeevueetffetteduffevgeei
    ieehteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hrhigrnhesthgvshhtthhorghsthdrtghomh
X-ME-Proxy: <xmx:RNFiZoNeLEipjgXGPqwExVRrNsm22Se3wYhVabYiTEcTWxsFZy0vVQ>
    <xmx:RNFiZh-01Y4m-ry535Khld07xG17TBWHx3KH0aDgXP-jfX7CZZ0K6A>
    <xmx:RNFiZoUnTEDSEbA88LrgOi3A9X342e_n8dA8oS0ywj1-SzxI4oqBUA>
    <xmx:RNFiZifjJwPNxnQLz9s0f9CoYDNU0Wef26CCwIn4vcFGJR9hR1w8bw>
    <xmx:RNFiZk32JHJCCAduHD-9rQdjZBbkNiijScDaGVWn7U5JZQjieLS0iQnR>
Feedback-ID: idc0145fc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 05:22:07 -0400 (EDT)
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
Subject: [PATCH 3/3] arm64: dts: allwinner: rg35xx: Enable DVFS CPU frequency scaling
Date: Fri,  7 Jun 2024 21:20:35 +1200
Message-ID: <20240607092140.33112-4-ryan@testtoast.com>
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

The Anbernic RG35XX device variants (-2024, -H, -Plus and -SP) are the
only currently known devices to have an Allwinner H700 SoC. The closely
related RG28XX also has the H700 but a mainline DT for this device has
not yet been submitted.

Include the H616 CPU OPP table in the base device DTS, and increase the
DCDC1 regulator (vdd-cpu) upper voltage range to 1.16V, allowing the
CPU to reach 1.5GHz.

Signed-off-by: Ryan Walklin <ryan@testtoast.com>
---
 .../boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
index ee30584b6ad70..afb49e65859f9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
@@ -6,7 +6,7 @@
 /dts-v1/;
 
 #include "sun50i-h616.dtsi"
-
+#include "sun50i-h616-cpu-opp.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -221,7 +221,7 @@ regulators {
 			reg_dcdc1: dcdc1 {
 				regulator-always-on;
 				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1100000>;
+				regulator-max-microvolt = <1160000>;
 				regulator-name = "vdd-cpu";
 			};
 
-- 
2.45.2


