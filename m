Return-Path: <linux-pm+bounces-21562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 140FFA2CE2C
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 21:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B549188F4DD
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 20:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC4D194C9E;
	Fri,  7 Feb 2025 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="cdx3OY+c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AxdWMWsG"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501302A1D8
	for <linux-pm@vger.kernel.org>; Fri,  7 Feb 2025 20:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738960285; cv=none; b=QhTmGAunZJMYwtykP9dHnQHnWFh+JBCVeNSYMM8/0P+4tHyqpLjkLI57gEVAvXZQAUHCOnz3CqDS0UgZeDwYbBI0brKduA4ytLE6PUNh5czJKBZME5Ps4GYswHwVcBHmIKPSGHsJuURwoUfy/F3IFhfEzRt+GISYXrRXQ8LKZVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738960285; c=relaxed/simple;
	bh=Eibft4DD8EARgcfOIc1oGQf8sh/RJK6NAEinlEyV15g=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=YCSe8uyMtShq1ZdfOLYd7yNXMaWma7X1NQ2KqN/ASIhn057hvKiH2EMKWdJzejW8CxSLxDgkdNgvTFbnEkkKrFGpmqayIuOjT5m14C8xV98rd4p/WF3wBPH8Z9LM4IGc1ncUuxMN+1P1u3FBPx3d+Bgc/cZC3Cr/gq9sV3+L5sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=cdx3OY+c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AxdWMWsG; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 392F213801F7;
	Fri,  7 Feb 2025 15:31:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 07 Feb 2025 15:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1738960282; x=1739046682; bh=e40Jc1bncfnnok4EoMl4mL/cKzNvltZ9
	PFkWvtOtsvw=; b=cdx3OY+cqA2vkEO9Sgt7jFDFuo1yo2jbniZ4BYFRc3Pt3ewx
	E6+VGw/RxBzkGwKR2KL3QZ2IM9CZR6U54mmrBKootRB4JN5URJ05/XvC/FNNqx8q
	J+em7tNwNDz8aBdtexLncNKXHDHnHZOdugzCShYW3jYhLulrhFskXL5S3eJbhZcB
	hTajvtF5n6/Hj5EUd6OpZcfa0vWFvpqV6n/XuR6xQ3Tnz1tmYIiE8DXQxCNNp8dc
	T6wz/iX5LOcUaZjxrpe9wEjvDEkcUizMiOAfTXil4eHKWrTUl45ihVHYA6I+MuO5
	M2LSoiBMzdvtZJjMMXsj8/whAC67IS7bwqEdaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738960282; x=
	1739046682; bh=e40Jc1bncfnnok4EoMl4mL/cKzNvltZ9PFkWvtOtsvw=; b=A
	xdWMWsGFdbUZR/7KI105Ba0HUhcYtppZDbLYL2X6hqvsAUovaAra7S2j8UlSlK9G
	My4ZMLgs58e0pZvQ7Px1+hBr50eoPzY+6oJMPRWVjxs9JtNJEbKV6aYis0hCY/Hj
	tkd0k/c9mXXFPajUCg4ZgMzubWjAfeteykYzlH+/o2h/5/h6BvKBI9zYcxGEVJlf
	RIIuI3qMdEkJ8XfUSZJJCEBOOZOf+A5iKyb/QQMGkuGjxth/EwLrp1nlfoRlJqdQ
	Z7vdfXDtywdf6CQkNV18yVABBqetBg6vLCc7yvQO+3/V6/3O7msh3PoprwNUT/kz
	WgfAZcnM9RHl5cHpQ8MnQ==
X-ME-Sender: <xms:mW2mZ3DL_yeDTRkYP8a030j8lNinjT7vlYBTLqBb4BvkPpki35aY4Q>
    <xme:mW2mZ9ha5su5wY_ur-e7dUg7Jgp7VToi3SfrJAki_Y9xTJaWygGqx_aGP-JpE6hJ4
    giqUe8Sc6vRQankSnE>
X-ME-Received: <xmr:mW2mZykWM81lbmfZe97zbsya5_gMJlXFq_MDPgN1jqZ2KYxP4TIuP4MUPK1lbEcZZ9o0fe_lxKtrCfUUSx24aKH0uyRCbaJzcsPxmbtfXMTV2Bgx0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfggtgesthdtredttddtvdenucfh
    rhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitgdrnhgvth
    eqnecuggftrfgrthhtvghrnhephefhheduieehlefghfelueetgeeggeejgeefgeduteeh
    ueffffeuieefleetvedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepnhhitghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnphhithhrvgessggrhihlihgsrh
    gvrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhmvgguihgrthgvkheslhhishhtshdrihhnfh
    hrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:mm2mZ5yxWIUGvKJTBZtcdBPRpz4-40ljlWkcz2wmj40QumaK0KlLeQ>
    <xmx:mm2mZ8SLabZWlR2xA2BKzYp1MjyzSTo_1n__lxfiwL1WV1mVzRQxxg>
    <xmx:mm2mZ8Y2GdAKHm3rpSWo4X8k6yY174ejLOmcYQQr07pFKDaDqOPXEQ>
    <xmx:mm2mZ9THF-fi6FaGAKkyD8Zj9V4eikr19d-M31Y0J_eOXLJ1Pv0CHA>
    <xmx:mm2mZyP9wnHBUDGVDqgjJ2L8A30j7jxrKO1cMaBG8Je7s65K2P7TkMo0>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 15:31:21 -0500 (EST)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id E2CC61008D93;
	Fri,  7 Feb 2025 15:31:20 -0500 (EST)
Date: Fri, 7 Feb 2025 15:31:20 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
    Daniel Lezcano <daniel.lezcano@linaro.org>
cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH] dts: arm64: mediatek: mt8188: add more thermal trip points
Message-ID: <696pn9r7-63r9-r2pp-rq18-471269pss1nr@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

From: Nicolas Pitre <npitre@baylibre.com>

Provide the "switch on" thermal trip point to be used by the power
allocator governor.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 338120930b..262eab8fd3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -472,6 +472,12 @@ cpu-little0-thermal {
 			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU0>;
 
 			trips {
+				cpu_little0_switch_on: trip-switch-on {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu_little0_alert0: trip-alert0 {
 					temperature = <85000>;
 					hysteresis = <2000>;
@@ -510,6 +516,12 @@ cpu-little1-thermal {
 			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU1>;
 
 			trips {
+				cpu_little1_switch_on: trip-switch-on {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu_little1_alert0: trip-alert0 {
 					temperature = <85000>;
 					hysteresis = <2000>;
@@ -548,6 +560,12 @@ cpu-little2-thermal {
 			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU2>;
 
 			trips {
+				cpu_little2_switch_on: trip-switch-on {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu_little2_alert0: trip-alert0 {
 					temperature = <85000>;
 					hysteresis = <2000>;
@@ -586,6 +604,12 @@ cpu-little3-thermal {
 			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU3>;
 
 			trips {
+				cpu_little3_switch_on: trip-switch-on {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu_little3_alert0: trip-alert0 {
 					temperature = <85000>;
 					hysteresis = <2000>;
@@ -624,6 +648,12 @@ cpu-big0-thermal {
 			thermal-sensors = <&lvts_mcu MT8188_MCU_BIG_CPU0>;
 
 			trips {
+				cpu_big0_switch_on: trip-switch-on {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu_big0_alert0: trip-alert0 {
 					temperature = <85000>;
 					hysteresis = <2000>;
@@ -658,6 +688,12 @@ cpu-big1-thermal {
 			thermal-sensors = <&lvts_mcu MT8188_MCU_BIG_CPU1>;
 
 			trips {
+				cpu_big1_switch_on: trip-switch-on {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu_big1_alert0: trip-alert0 {
 					temperature = <85000>;
 					hysteresis = <2000>;

