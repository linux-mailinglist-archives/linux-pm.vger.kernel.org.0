Return-Path: <linux-pm+bounces-9810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C17249134BD
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 17:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765191F21AA3
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB0C1E502;
	Sat, 22 Jun 2024 15:17:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3CCB660;
	Sat, 22 Jun 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719069437; cv=none; b=iU8oty+6Ltp+QRUP98s4EDK7FyAXcN0V3ZjK8ynJWhiZ+UjLDjvipiRCNHTBr7TuS93J/ivyX/z89FRzLQ74i1ssk9+ka/KpYPgf6MZc8x3QeMvBN1jTsb7iN8MuivzTlftYw/kQz321SuqXAqDLGVZ2+1TYlpiWjrVOvI/3FMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719069437; c=relaxed/simple;
	bh=rQ2/eH9yPvzW/PqT36AV4Sp0N9jPlNuuaT6FzvB26I8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LGFebF2kUboIv3zWetw2hVr2WfO901Ds+T4D029RtwsBdO64NsSAUPFInRawQB3P93431Wmex0/9eH3jknzVVAu8/H+kQ7nK1+exXGNaKZlRA6JVkwElwcKGtLUHahwAtjxDSJ63a4Mct+HRXMjctEb0H1W8NUTrBwm51rcyKgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10428C3277B;
	Sat, 22 Jun 2024 15:17:17 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 08D2C5F725;
	Sat, 22 Jun 2024 23:17:15 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Yangtao Li <tiny.windzz@gmail.com>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <vireshk@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Andre Przywara <andre.przywara@arm.com>, Ryan Walklin <ryan@testtoast.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, Chris Morgan <macroalpha82@gmail.com>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20240607092140.33112-1-ryan@testtoast.com>
References: <20240607092140.33112-1-ryan@testtoast.com>
Subject: Re: (subset) [PATCH 0/3] cpufreq: sun50i: add Allwinner H700 speed
 bin and additional OPPs
Message-Id: <171906943501.1109052.11689701111557656569.b4-ty@csie.org>
Date: Sat, 22 Jun 2024 23:17:15 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 07 Jun 2024 21:20:32 +1200, Ryan Walklin wrote:
> Support for the Allwinner H618, H618 and H700 was added to the sun50i cpufreq-nvmem driver recently [1] however at the time some operating points supported by the H700 and in use in vendor BSPs were found to be unstable during testing, so the H700 speed bin was not included in the mainline driver.
> 
> Retesting with kernel 6.10rc2 (which carries subsequent fixes for the driver) shows stable operation with these additional OPPs.
> 
> This patchset adds the H700 speedbin index, enables the additional operating points for the H700 in the H616 OPP table, and enables DVFS support for the Anbernic REG35XX handheld devices, which are the only mainline-supported devices currently using the H700.
> 
> Regards,
> 
> [...]

Applied to sunxi/dt-for-6.11 in sunxi/linux.git, thanks!

[2/3] arm64: dts: allwinner: h616: add additional CPU OPPs for the H700
      https://git.kernel.org/sunxi/linux/c/b05f15d0fc15
[3/3] arm64: dts: allwinner: rg35xx: Enable DVFS CPU frequency scaling
      https://git.kernel.org/sunxi/linux/c/e1e61fe3452d

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


