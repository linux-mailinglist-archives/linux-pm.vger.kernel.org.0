Return-Path: <linux-pm+bounces-26147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F602A9B5CA
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 19:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52E84C1666
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 17:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A8728F539;
	Thu, 24 Apr 2025 17:52:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4732228F521;
	Thu, 24 Apr 2025 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745517126; cv=none; b=DNqyWfrkaDmqXm+2QPaaTonbnybMz78RWvrawyhxI5intcGk66FATM+/AUYzgSulqZxh/rYP6NKbMuhNImddibLLqy2UsVvCkECVBGpgCTMp5aaeii2juZ7ux2FMSwwj2hbUMfXBpvAR2to0EoV/2WJOMvjdDPK9IhYeGwa0OJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745517126; c=relaxed/simple;
	bh=cpCE7WobKhXA4LBRFDjvwehvoeAoPu7OIv/2KgmRfrI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nZwLYb3LcbVzXOghH+7dyvvaAVLUaGEN5iZzEnkd0w4ei0brvOawIHchc3izQ6eb2Ym0x7ZaSLw+uIsMG7ew+6YaD/kN1Kw7mx8l7hjN9pLRrROJAfSkLwt5ph7aoRaoUKTG6ld+dMJwbsyg2BkDbg7ow/3VoKvLVmp3ivB80CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BD3C4CEE4;
	Thu, 24 Apr 2025 17:52:05 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 15CF25F71D;
	Fri, 25 Apr 2025 01:52:03 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Andre Przywara <andre.przywara@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, 
 Philippe Simons <simons.philippe@gmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-pm@vger.kernel.org
In-Reply-To: <20250416224839.9840-1-andre.przywara@arm.com>
References: <20250416224839.9840-1-andre.przywara@arm.com>
Subject: Re: (subset) [PATCH v2 0/4] arm64: sunxi: h616: Enable Mali GPU
Message-Id: <174551712297.4050580.7389706092232508624.b4-ty@csie.org>
Date: Fri, 25 Apr 2025 01:52:02 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 16 Apr 2025 23:48:35 +0100, Andre Przywara wrote:
> version 2 is addressing the comments I got from the reviewers (many
> thanks for that!). The list of power domains is now separated from the
> per-SoC data, to avoid going over the list twice. Also the error path
> takes care of removing already registered genpd objects.
> Based on v6.15-rc1, changelog below.
> 
> ==========================
> The Allwinner H616/H618/H313/H700 SoCs contain a Mali G32 MP2 GPU. This
> IP is from the Bifrost family and is already supported by the panfrost
> driver, so enabling support for 3D graphics on this SoC is rather
> straight-forward.
> However Allwinner added some bits in the PRCM block, that control the
> power domain for the GPU - on top of its power *supply*.
> 
> [...]

Applied to dt-for-6.16 in git@github.com:linux-sunxi/linux-sunxi.git, thanks!

[3/4] arm64: dts: allwinner: h616: Add Mali GPU node
      commit: 8e1bf57ee67d0bcd78c6f7e713f98795e378497b
[4/4] arm64: dts: allwinner: h616: enable Mali GPU for all boards
      commit: 0836bb7e2521dac3ce764613dd9c5d22f5b368d0

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


