Return-Path: <linux-pm+bounces-28303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8967AD1C42
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 13:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C00CB7A22FA
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 11:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BAF254AEC;
	Mon,  9 Jun 2025 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="lpyUj2t+"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6311B255F59;
	Mon,  9 Jun 2025 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749467480; cv=none; b=uNtp5TyMuxR5TcQb1eJfz0pQTaXk1F9ppda4AqBWV0lYSLPT/LTA7buwYfKKbhfoJ2QKeELYe1QR3/IASmNdmDVPTolTCC6lbUZWHNCIDD/EohHt3BzFArEZqNu59zVC6o1rDoHW9QU3FzTqUzWvIBwU/H6bDau52v3PZRO9HZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749467480; c=relaxed/simple;
	bh=KmuMug8eo+1xqQzVx3etjJKqVimLn63xMDr1MuVhHQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wcd3H80okEK6ELvPZXGenT84MT9HYcBqAN42rehWFsGpYkUc/mDEk7B/L3rTYFJ675XWWZOg2OzCjnJbJ9jM3M77h2tVp++bnImphPGjRgxT4ZyDnxU6dN9y580sTVmweEeOmlkM9ifJV9DDQ+szk1FW+8RFlezEjWdeepnRZic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=lpyUj2t+; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BBAmbvG9DKJ5ZBtHCrdVkfgG0G+RQFv12c3uqAQzHz0=; b=lpyUj2t+obwq5CMWCTbvg57HuZ
	dxrsN0ETGbkfP4ePm+9flK5EAPa+KIlaCmrXAwZ7Nvm5GWmkItNic0WUmhG0mtc8oINDLpBzoJTbG
	1NkkXWTzvf0GAUNELM9Wk2hMt5q1Lv249lG8uldv5Mdf9IkkEQXBnRI9DFjGjt7roYW70SL9KlGLu
	lS+KDeWHsNZ/kBWI9RB7D1lP3HSXtSnhp8p5BSjaL7Etc3PZbNkKLZedPbHqulac8WrMb2lnsUz1Q
	ldC71dvXi9NNcSCndKHsnMfU4a4MEsGXS+nBwjo/w4sUSNdOcE2vd0N72Frn7IDJtruiZ5DW5m0F5
	Ztlvlqmg==;
Received: from i53875b1c.versanet.de ([83.135.91.28] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uOaPC-0006VT-MY; Mon, 09 Jun 2025 13:11:06 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Mark Brown <broonie@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sam Edwards <cfsworks@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	=?UTF-8?q?Adri=C3=A1n=20Mart=C3=ADnez=20Larumbe?= <adrian.larumbe@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Peter Geis <pgwipeout@gmail.com>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Vignesh Raman <vignesh.raman@collabora.com>,
	=?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
	Sven Rademakers <sven.rademakers@gmail.com>,
	Joshua Riek <jjriek@verizon.net>,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [RESEND PATCH] arm64: dts: rockchip: Remove workaround that prevented Turing RK1 GPU power regulator control
Date: Mon,  9 Jun 2025 13:11:01 +0200
Message-ID: <174946744885.771907.2986962634832337844.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250608184855.130206-1-CFSworks@gmail.com>
References: <20250608184855.130206-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 08 Jun 2025 11:48:55 -0700, Sam Edwards wrote:
> The RK3588 GPU power domain cannot be activated unless the external
> power regulator is already on. When GPU support was added to this DT,
> we had no way to represent this requirement, so `regulator-always-on`
> was added to the `vdd_gpu_s0` regulator in order to ensure stability.
> A later patch series (see "Fixes:" commit) resolved this shortcoming,
> but that commit left the workaround -- and rendered the comment above
> it no longer correct.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Remove workaround that prevented Turing RK1 GPU power regulator control
      commit: 5952996d5303c96702ef30ad30ec0a01acda46d4

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

