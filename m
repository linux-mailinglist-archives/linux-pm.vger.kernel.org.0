Return-Path: <linux-pm+bounces-17277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1389C3176
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2024 10:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57D61F215BD
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2024 09:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A941537C3;
	Sun, 10 Nov 2024 09:25:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB0114D6F6;
	Sun, 10 Nov 2024 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731230757; cv=none; b=JHUs0ISvlbdZosDmbbVPfs9SVy8/4rkHilpBVZHbXlNT/ICwE6LLvCd8S3IRSjEdiPgjNlSLnCIVioL2GDrMYr8+9RT2QcAPLR63cXbgRE9cYTWN5vGPB1MyzWsOLnQb1RHnl0bYE5sa09MdAt56Wl1x6xydIGV9fPezeQazjy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731230757; c=relaxed/simple;
	bh=Xy9zNLBedDFSFBLuOp37hYuBc1tlCp7NbQzSTOam2o4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dwfuHVT8oDGyrcOegpcFbvI1tKujPq7M97LfLnxL+qCXjqka5v2Iiq75PvLpeA2lOJXkM6HfiTkXIP0922Gd0O7RXlrFF/ip79uvwlaGT3tCwd5W3rPhpfzSxPVBmIFWdN4EvEuwjGzXJ4SnYnc9UWiAHzRnkWxTCRzNNrYoetM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6E9C4CECD;
	Sun, 10 Nov 2024 09:25:56 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 66C5F5F836;
	Sun, 10 Nov 2024 17:25:54 +0800 (CST)
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
Message-Id: <173123075439.3498315.14594380373540297845.b4-ty@csie.org>
Date: Sun, 10 Nov 2024 17:25:54 +0800
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

[10/13] arm64: dts: allwinner: a100: perf1: Add eMMC and MMC node
        commit: af1ad5675a2b5feebb49df0e0ac7dab1aeabfaa8

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


