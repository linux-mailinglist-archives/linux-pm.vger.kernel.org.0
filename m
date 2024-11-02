Return-Path: <linux-pm+bounces-16898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BF69B9F81
	for <lists+linux-pm@lfdr.de>; Sat,  2 Nov 2024 12:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45BD1F219C3
	for <lists+linux-pm@lfdr.de>; Sat,  2 Nov 2024 11:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2D216DC3C;
	Sat,  2 Nov 2024 11:46:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13A15A85E;
	Sat,  2 Nov 2024 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730547997; cv=none; b=khfGTD+TKelrtP3vjAXuWhDdMUTQXfBBNtoJIuKZdQxWh0ZgPPgHxOh4NjEhK9g9HPxewC0rD6xva2ANMFELl9g8DMMZilYr5UjdsVQ5kNwrHmot9DPWpQaerynjSi/5vtsx4mcS7HB+IDngiUBn/n8SziKuZYn8Nr+M44of62A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730547997; c=relaxed/simple;
	bh=I7knZNHDliZk9Hk0Pj85mAdWlDEOEeVfj001CftATno=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aTi1Ufu9jgInnELGc+Qu7GkcobDCVQhy6fkA+MZaC3oJk2kA4ANjVfr0V/8aVMFat5MTQk8ekQuN38SAYJRsNVqAudJZKprzeZiEJlSyM+Ki5S+dA/rEWZqrR3p3IYI5zMU+CyRMaJ02QkDgaTfvqC7u/SsoUqsPNazHvV6hxMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286AEC4CEC3;
	Sat,  2 Nov 2024 11:46:37 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 2061F5F9F2;
	Sat,  2 Nov 2024 19:46:34 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 Cody Eksal <masterr3c0rd@epochal.quest>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, Nishanth Menon <nm@ti.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Stephen Boyd <sboyd@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Yangtao Li <tiny.windzz@gmail.com>, 
 Parthiban <parthiban@linumiz.com>, Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
Subject: Re: (subset) [PATCH v2 00/13] sunxi: A100/A133 second stage
 support
Message-Id: <173054799410.64486.11694812401132710377.b4-ty@csie.org>
Date: Sat, 02 Nov 2024 19:46:34 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 31 Oct 2024 04:02:13 -0300, Cody Eksal wrote:
> This is V2 of this series [5], with some changes that were requested and
> others that were made after testing on more devices. Thank you for all of
> your feedback! A changelog is available below.
> 
> ==================
> Back in 2020, two Allwinner employees, Yangtao Li and Shuosheng Huang, each
> submitted a patch series for the A100 series of SoCs; [1] intended to add
> support for the watchdog, ARM PMU, DMA, USB, and (e)MMC controller, and [2]
> implemented DVFS support. Some patches from the first series landed, but
> the rest were seemingly abandoned.
> 
> [...]

Applied to dt-for-6.13 in git@github.com:linux-sunxi/linux-sunxi.git, thanks!

[01/13] arm64: dts: allwinner: A100: Add PMU mode
        commit: 248b20ed03545656bd1775ed115369854f58f55c
[02/13] arm64: dts: allwinner: a100: add watchdog node
        commit: f84a3aa7782687ca0fa54f768fc6bb825575f91a
[03/13] dt-bindings: phy: sun50i-a64: add a100 compatible
        commit: 4402ef303d4b90748646568cf48f52eea035057a
[04/13] dt-bindings: usb: Add A100 compatible string
        commit: 1e7d0e2a53e6bf4b43f78858b1fb10aa38259375
[05/13] dt-bindings: usb: sunxi-musb: Add A100 compatible string
        commit: e144e89de0e491ea191847b0dc15a5aeb27951eb
[06/13] arm64: dts: allwinner: a100: add usb related nodes
        commit: c3cc9b02f7490d93635692cf58b0a4e517a60ab2
[09/13] arm64: allwinner: a100: Add MMC related nodes
        commit: fcfbb8d9ec584c256c0a6e1ae3174a21b007f399

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


