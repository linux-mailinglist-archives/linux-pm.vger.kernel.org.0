Return-Path: <linux-pm+bounces-8761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE718FFF33
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 11:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5F61F2A221
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 09:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2700515B576;
	Fri,  7 Jun 2024 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b="awahcg3s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Al2RjZgY"
X-Original-To: linux-pm@vger.kernel.org
Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F09615B99A
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752123; cv=none; b=sDjWHc+SEFuyaATKeYcEqDkhwTPnCntpiIY+bWVpizTL8lTzWZjXdbo+qgVE1dTjZJHg8q08TD7KnKqfasn4BdnTGrfs+S03RbZsBYd+p6KGc4A44k2o3plaDA5sjtBpzt5ER8RfRpYvXAMHlPpixrBu6Yge545uYm0jswRA/OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752123; c=relaxed/simple;
	bh=MZcEuW+lECDPkKx+XC7YSMmnOTsPQ07enkQZFogNwSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7mG7nS3HvOREejmR/g0HaV8Ibhn0X2ycyc30mUjYOHbcFTQjs8UZWxpu2DdHhfErJ+GeR/DTA4GKZS2BukSpfGhPCQTGPaVru+gguS/B8i7uFdQrbW0ZvWM7HYUNo98coJljPmh4U7U+j9GKX2DNQ4okx9IdWXReBXLQGtNlWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=testtoast.com; spf=pass smtp.mailfrom=testtoast.com; dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b=awahcg3s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Al2RjZgY; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=testtoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=testtoast.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 62ACD180016F;
	Fri,  7 Jun 2024 05:21:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 07 Jun 2024 05:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1717752118; x=
	1717838518; bh=Sv5NIoXfLwdHPS/w/5DnE7wjrnRxjhnUorroHktg3tU=; b=a
	wahcg3sCHR4UHQUFSnX6RaAS1QpMgHqyeHI9sqkP/QoCykTzaZxtTXsFBG+k5603
	85jgfuk31R40xEcbKldpm98jC97D6MoVwLHoDNb+JWkhZJLIvklXR1H/pMiA9Kif
	SGXCMrNacZGI3F2lQSo3wAyrewblG4Cor9kvTUVDwO8hRf4y+2ocn8MUWdtylGs+
	iDki10dfan1dhkYbF83wE0RmQyMRfpTDr9DyjGmnD/yHIH2pxvEan8TyzSh85f2s
	HLceYu1j/TGVaoWgZT0ETh25aRtvMEENsQeDnII2O/c3XTwRROyseEEDBQMt9+yf
	IBWhbI6cHB0Wt1OUCtvgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717752118; x=
	1717838518; bh=Sv5NIoXfLwdHPS/w/5DnE7wjrnRxjhnUorroHktg3tU=; b=A
	l2RjZgYJ5hF6BxQk/IoeHM/wIMtIZlsVHa4tB8yuqoCsF3N8WqaK4w9Z+P95hhqC
	E8eghKfddYDGvFSfM3xNyT722gozY2bfie75lDIPbb+sHdas7FaM878rbhUqBiCZ
	Rt/ogZWvtKxe+CD2Gqb+9z01ALJw8s3NCsCL5NAFUDdzQC4Kk4yH0gpgc9mfMR8J
	7hIaQv4cvqXhVNdLmc2FgD0ybDC0+pMVI6T4n4YXZkoqO3HpRlqHrI7Ml7CF4BmN
	HEzr1NgpZayl3qAZAP/fo0nI3lfeY41T+06a+JP7yGvWQ8v0FMbK4gJTzQRcWyjz
	deQ8+JSeAGaLEXALIJWQQ==
X-ME-Sender: <xms:NdFiZjp1y4Aa7pIYPMpk0fVTbTOz4_z1btaEr1joTou6eq6M4A_iTA>
    <xme:NdFiZtohYUdzK917YKhUSQYMaAKQoH48sbUI9qhVwnlwmWly0MlLjmKojVKaXg1Du
    8RJuRMJO1HL63o3NA>
X-ME-Received: <xmr:NdFiZgOeHeEsS_nnvTkVZcWk1XNsfmBq6hVkUceimESU09a6y5ZtZUhR4KBCYxIeSOFdUUwczKLS7dyihAnlNNea0Yt-ciUmjBa7pI6LdJOZhoRL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedttddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfihrghn
    ucghrghlkhhlihhnuceorhihrghnsehtvghsthhtohgrshhtrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehgeduffeiveeiuddufeelffeuteeiiedulefhteevgefgffehheeuudff
    veejvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprhihrghnsehtvghsthhtohgrshhtrdgt
    ohhm
X-ME-Proxy: <xmx:NdFiZm5lOv-kPntEGMN4ksp_ONIOx_1PMzCwfYjWXJ_pLYSEhQ5FjQ>
    <xmx:NdFiZi7IqUTLIio-F6SHwBAMiN-dcYtP7yO9zmwbvztsyyzIq5Fofw>
    <xmx:NdFiZugrcrXgC55IqxkF4oqMQPpNa7GD08pN7uhvu_PsYigb_ISYsQ>
    <xmx:NdFiZk6zjPFRPQo788SZEJi6VFZ04wRn3dqY8Q4b_tP0CiaeasiCFw>
    <xmx:NtFiZvx27wF2R3_9KE2Hcq6a0AtIyKAZH4xSXm76csuvqSb9wvE13glW>
Feedback-ID: idc0145fc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 05:21:52 -0400 (EDT)
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
Subject: [PATCH 1/3] cpufreq: sun50i: add Allwinner H700 speed bin
Date: Fri,  7 Jun 2024 21:20:33 +1200
Message-ID: <20240607092140.33112-2-ryan@testtoast.com>
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

Support for the Allwinner H618, H618 and H700 was added to the sun50i
cpufreq-nvmem driver recently [1] however at the time some operating
points supported by the H700 (1.008, 1.032 and 1.512 GHz) and in use by
vendor BSPs were found to be unstable during testing, so the H700 speed
bin and  the 1.032 GHz OPP were not included in the mainline driver.

Retesting with kernel 6.10rc2 (which carries additional fixes for the
driver) now shows stable operation with these points.

Add the H700 speed bin to the driver.

Signed-off-by: Ryan Walklin <ryan@testtoast.com>
--
[1] https://lore.kernel.org/linux-sunxi/20240418154408.1740047-1-andre.przywara@arm.com
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 0b882765cd66f..969f22aadd950 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -91,6 +91,9 @@ static u32 sun50i_h616_efuse_xlate(u32 speedbin)
 	case 0x5d00:
 		value = 0;
 		break;
+	case 0x6c00:
+		value = 5;
+		break;
 	default:
 		pr_warn("sun50i-cpufreq-nvmem: unknown speed bin 0x%x, using default bin 0\n",
 			speedbin & 0xffff);
-- 
2.45.2


