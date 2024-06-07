Return-Path: <linux-pm+bounces-8760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCED8FFF2C
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 11:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1480B1F2A2B2
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 09:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB89415B566;
	Fri,  7 Jun 2024 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b="B7xP69OA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W4uWez5J"
X-Original-To: linux-pm@vger.kernel.org
Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3DF2209D
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752114; cv=none; b=rDArUTYSwfP0JRvh++rfuyNtAmBHmgBBmn/sF5yjM7/yIlLCgi63gIUgH0J+x61naNCm6QKurQ7LhHBs1/qD8lG+oo/w5WGUz+WFAvL0CYiOLJGRG+7pzeyUU89+QiSWg+oUYwUivtiI839tjo3qcxM5Qw/qbg6TwU62aSfmYVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752114; c=relaxed/simple;
	bh=CZ+l8BjOCzy9ISxj/1iuelcrxrCfPJUn2URIsh4/yOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qylDkD6+QUqYre6Cp1sjgLYfT5hivtPazKL6LgWl5aacrnWN+/YyGXq2/QNbWeDBTZr9k6fM5EpXSA24KicXSiV4XgUD3Yw/g3B15q3ldS2NNNAk9/XiFoMaEOkZUQbyiNCVwfG2sqMGwJrdylTSJ2k/MCrX0i+JxThYsLojRb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=testtoast.com; spf=pass smtp.mailfrom=testtoast.com; dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b=B7xP69OA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W4uWez5J; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=testtoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=testtoast.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 481CA1800154;
	Fri,  7 Jun 2024 05:21:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 07 Jun 2024 05:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1717752110; x=1717838510; bh=ZDusPDDIb7
	olYoJ57f+62UdQlKat/oJCMbyJixOxDTI=; b=B7xP69OAfLxtMoYvVkwsGe8jE3
	hGBxQRfrWYZWAPXOKSp4CNW6kncGOBUEHduF63qNxiPaWKFyof2r+fJp5S8NCOtD
	WbBNe5SJ9TE8DqTbW1g4Tuxjwjtrh5xBJiXGtmuCLCZSv11ceBUVxD9T+7/HH7QD
	UUHStFbH269G77Nspom6Pr6GRNpWtlwU5Fu5xpX3z0gRnFYQEn6Yn0B5LH9kTbV9
	R+3UTl2FhjfhY3QocFGd4Tb/8J2wbogocOZW5liO9IfSuu5FAZEAaRHKg/ueBnpn
	+nPBmVBAecLlVGCopAc5DvQSOxanAmN0aChnVHGqKbZMRoD8y7Qwzrz5r3Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717752110; x=1717838510; bh=ZDusPDDIb7olYoJ57f+62UdQlKat
	/oJCMbyJixOxDTI=; b=W4uWez5JKDWELBJf0vOB2M5GBVGJrEbL2Soi1d6VjGPu
	HydKpcu16YxFq7GfMseMW2TUQsDwYVnbAunhHuB37yvOZOe/ypGR6EfSf7kLrXlP
	3IzGZ4LrzJZ56f1UuyAXMJINfaNjY73srmM0VK7Z/Gpdkun/usDo/VpRxeSML7DK
	ZWY1WuN5B3SmTshHF/kX6pQndBWOvrC68ATem+zQNUXOEP7LuKt3Yqy2cYzV41s6
	gT9+X0SnPxHShQXNHenJhuejMGUj46NRYKzhZIyBZN5UCZd0a3PRL3zq53CJaW2R
	EJYdra3atPbkVRws7CJerO1hFUywb73jQ5AkxI85ZA==
X-ME-Sender: <xms:LtFiZs4PLpCwFuj8kuFBJTyXUXzUPAK_v4tVec6R0bv6E0fagyci3Q>
    <xme:LtFiZt7qrUMrfNlt4VXlmVIUNoCqoCu93AHW56nPZDPEC73CtROc41rSo_TmU5C0E
    RseJh2jOFHTmxYhJw>
X-ME-Received: <xmr:LtFiZrfMGBLH3RO4xU7XfG59hLQjJs8-9UEyFJbnYYHDFc-45cLR64JlVf2CO_h8FmQcJHnjRUnXGQiEVJzncoUOxTROE5PDdbfQdKAEeQF1FN1X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedttddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptfihrghnucgh
    rghlkhhlihhnuceorhihrghnsehtvghsthhtohgrshhtrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefjeejhfejhffgiedtleelhfeukeefteeukedtjedvueeugeduheduffekvedu
    ueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprhihrghnsehtvghsthhtohgrshhtrdgtohhm
X-ME-Proxy: <xmx:LtFiZhIAE6yjcZBdyw5iDAHRh_0zCY7l9y5I2hn_ZkUMgKjF3hdRWw>
    <xmx:LtFiZgL4Aj-SC_1sKm6P3_bNXo3uP81nU4tAmbJAPqPWmcxmRViYZA>
    <xmx:LtFiZiwB1F3krUw52EqjfoIXIUVqdEW4x41ErjAjmBmvpCWCjlse7Q>
    <xmx:LtFiZkKZfxs27wHE6FztWJXLUX2f-Yt9IAkI-nOW-fXWDjLhm0lLGQ>
    <xmx:LtFiZlCKeYVbCJApc-egCrrcvp-O3V5MW4nyeG-TBMqQxYBApvnGa-XA>
Feedback-ID: idc0145fc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 05:21:45 -0400 (EDT)
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
Subject: [PATCH 0/3] cpufreq: sun50i: add Allwinner H700 speed bin and additional OPPs 
Date: Fri,  7 Jun 2024 21:20:32 +1200
Message-ID: <20240607092140.33112-1-ryan@testtoast.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Support for the Allwinner H618, H618 and H700 was added to the sun50i cpufreq-nvmem driver recently [1] however at the time some operating points supported by the H700 and in use in vendor BSPs were found to be unstable during testing, so the H700 speed bin was not included in the mainline driver. 

Retesting with kernel 6.10rc2 (which carries subsequent fixes for the driver) shows stable operation with these additional OPPs.

This patchset adds the H700 speedbin index, enables the additional operating points for the H700 in the H616 OPP table, and enables DVFS support for the Anbernic REG35XX handheld devices, which are the only mainline-supported devices currently using the H700.

Regards,

Ryan

[1] https://lore.kernel.org/linux-sunxi/20240418154408.1740047-1-andre.przywara@arm.com

Ryan Walklin (3):
  cpufreq: sun50i: add Allwinner H700 speed bin
  arm64: dts: allwinner: h616: add additional CPU OPPs for the H700
  arm64: dts: allwinner: rg35xx: Enable DVFS CPU frequency scaling

 .../dts/allwinner/sun50i-h616-cpu-opp.dtsi    | 25 +++++++++++++------
 .../sun50i-h700-anbernic-rg35xx-2024.dts      |  4 +--
 drivers/cpufreq/sun50i-cpufreq-nvmem.c        |  3 +++
 3 files changed, 23 insertions(+), 9 deletions(-)

-- 
2.45.2


