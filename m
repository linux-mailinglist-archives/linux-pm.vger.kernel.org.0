Return-Path: <linux-pm+bounces-26830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF13AAE6E6
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 18:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 325B97BA5BE
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 16:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF2928C5A5;
	Wed,  7 May 2025 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyIymc2W"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3E028C2D1;
	Wed,  7 May 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635922; cv=none; b=HyTjQ4zGbIDhPFVppHAVKtQam4T+fzUWsTSatTxwme6FDkaOD5FOALg3EwK+mZBLcxuOt45+V/xBdcd5DrzaTtIRLeJQKyPm9Cg4mLdWfDwEI7M17/uxC+htpOi0pP/JHjC11smS/VvM7VL6JdYAy279XqF8JSNhT0+vNfnDdRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635922; c=relaxed/simple;
	bh=TqTyxNTUeXIXIbgbWfv1PyWf194MsWra/G7EgnvKn1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHlb5qsdiDYzDK4gUvfY4QV0gf5/Dbq5x7i6GXQ5V0Qr9sZyDgPHz7d9cgw5/C83eTIR3wTAs2EpaVb+nLHZBz1NaEFzA/FBnp6SaiaQ2ZkGPhkSVwYZktI2dHJc+P5zelSIpYcxzZDvGngvCg0BtEfRk3aBz94jVJ9OsVN1U9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyIymc2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04D7C4CEEE;
	Wed,  7 May 2025 16:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746635920;
	bh=TqTyxNTUeXIXIbgbWfv1PyWf194MsWra/G7EgnvKn1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AyIymc2WUwyOA8d+yIafhO3j7UN9ALcm+hJ4nXmJ5aU79oNpfstTIMGLCVRACV2ax
	 JIEL4T+cYujaPi/vwiJjQPC4CBIueS0dZzALrwNExDGGSWSKFn6qgHn2T76DlSbjQ3
	 YYukBbrippdZmajPTYXivGbBd+1EJCowJ68J2AOuR+NPZQOBFzORc8QXTv7jvjxdCo
	 zXkrngaysM8SKMppt6W/7J3mjFcHm61ktJqnwuI1oVgXCG8CPlgpinUZr1TYzdsm/P
	 +bCJSfEOkxWJvo5tKzdr27ATGxkeHQdH7e93YRxYX4YVB8zau06Vnv6oIxo+rJF1Nf
	 dc/dJAXbgPo7A==
From: Bjorn Andersson <andersson@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Konrad Dybcio <konradybcio@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	zhouyanjie@wanyeetech.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Andre Przywara <andre.przywara@arm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: (subset) [PATCH v2 00/17] Arm cpu schema clean-ups
Date: Wed,  7 May 2025 09:38:33 -0700
Message-ID: <174663591275.3531.6906045623469489227.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410-dt-cpu-schema-v2-0-63d7dc9ddd0a@kernel.org>
References: <20250410-dt-cpu-schema-v2-0-63d7dc9ddd0a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 10 Apr 2025 10:47:21 -0500, Rob Herring (Arm) wrote:
> The Arm cpu.yaml schema fails to restrict allowed properties in 'cpu'
> nodes. The result, not surprisely, is a number of additional properties
> and errors in .dts files. This series resolves those issues.
> 
> There's still more properties in arm32 DTS files which I have not
> documented. Mostly yet more supply names and "fsl,soc-operating-points".
> What's a few more warnings on the 10000s of warnings...
> 
> [...]

Applied, thanks!

[09/17] arm: dts: qcom: ipq4019: Drop redundant CPU "clock-latency"
        commit: 3ea267124573f24e67f0fe47c4a865f0f283f8fc

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

