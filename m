Return-Path: <linux-pm+bounces-24883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D154CA7E3C5
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 17:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052C4189C093
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 15:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC2F1F63DD;
	Mon,  7 Apr 2025 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKQS3aWs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAD11EB5DA;
	Mon,  7 Apr 2025 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038333; cv=none; b=Gfz+F0kUAFjVjR4PRhtxjLAId0WQB8Su+ycOK7qjoAFGwZzyR3zCO/ToSTDNt/GTyRyxjbT8XfMpPIUFNtt9jx0A72J28ZcSloXvCOXDptxf7qKIk9JKSEU5fC/9tSj+GVekol67n+B+J3D6xy+UAUbii/2KBF+SgNvMlFvADcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038333; c=relaxed/simple;
	bh=Mw9qucjIp0Omq/A9vAIb/29JeyZDGU+9uc/m9jCRX7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUGul2QS+jwaE58G2kPNge4fPAnzNnGXiCt7GNpJl5z0POWLRF9W7E4mVqcSY9IBp+Gv9AF2QiM+D2oTGIx94/wlzkwcIqTsLxGWmbiRkehk/A056ofRiZaq9jWmrR3wbgVZYsqGGJLzghENY7VJ8pQkaEhxCk33hRHw8eoxTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKQS3aWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031B8C4CEE8;
	Mon,  7 Apr 2025 15:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744038332;
	bh=Mw9qucjIp0Omq/A9vAIb/29JeyZDGU+9uc/m9jCRX7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKQS3aWs5xVxCEeJcS5zafu+bQCjIu6I8wU63yWdkZqgTpN0ZX/HSRgG0wgmWL3Df
	 tO4n9x0oecWmoMZuH9gLl66GZO1AzfyrFd6iPK8hsaD1rVynbuKzMzFYofrQdqnGmp
	 YE1GFpYc3rTrfy463qTV34W6ytzsjmWknY/GRntLu/xhoBMNTaqRfPiTSkkl8yRcm3
	 JZa3p5KhofL4wTtG8vofHq+wfE28TQJYr6EcDYsDgl5WUa2CRXX81T5kYlpVYFKA1X
	 tILrVOmLhSJEvkXnYTKUB3Ueun2ZuSdoGzFkrObrHcMl3dRZeuhARHTmLzv3nTPBng
	 XpeskTYpqLJZA==
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	zhouyanjie@wanyeetech.com,
	Conor Dooley <conor@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
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
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-mips@vger.kernel.org,
	imx@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: (subset) [PATCH 00/19] Arm cpu schema clean-ups
Date: Mon,  7 Apr 2025 16:04:56 +0100
Message-ID: <20250407-explicit-explain-a741ef76ba8e@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
References: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=698; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=3ED6nRUUmofI7rnQA5nqnPZ4e85/GutKQ3V+2IZjPhU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOmfX85o+sg3ueWv6O3Sh03r2wxfSPGs4/kmI3wy2pZ9l jij8++rHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjI0yMM/7PeKB0VzvzRsU76 6ZZK72k+2yufHdmVoe3au+jKpq5jvk8Y/oc+Uf8o/IzxBH/rpdnLH972fP4uU2Jz797u8z9eX11 z8TcbAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Thu, 03 Apr 2025 21:59:21 -0500, Rob Herring (Arm) wrote:
> The Arm cpu.yaml schema fails to restrict allowed properties in 'cpu'
> nodes. The result, not surprisely, is a number of additional properties
> and errors in .dts files. This series resolves those issues.
> 
> There's still more properties in arm32 DTS files which I have not
> documented. Mostly yet more supply names and "fsl,soc-operating-points".
> What's a few more warnings on the 10000s of warnings...
> 
> [...]

Applied to microchip-dt64, thanks!

[04/19] arm64: dts: microchip: sparx5: Fix CPU node "enable-method" property dependencies
        https://git.kernel.org/at91/c/ec32344d2a3b

Thanks,
Conor.

