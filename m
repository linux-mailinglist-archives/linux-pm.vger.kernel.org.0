Return-Path: <linux-pm+bounces-37592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F360BC3EBE1
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 08:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89E23A609F
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 07:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49603081B7;
	Fri,  7 Nov 2025 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B77wSxCE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E87926462E;
	Fri,  7 Nov 2025 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500435; cv=none; b=VbSiIos3aTQ85C+pWfF3UOnLDOqphR2BWAkKcw3IhBSY56XowqSoqq/Pjbye9QZVbwecS8tpJDnlRyzFmQL226fBCrNjLpLVFX3M5xNOCDuSeuPc9LxdX7vYXv0IKkwo26FKRvHOiahxXqfV6Vg2Vcu3l1Cvg/BET9N56ttCyBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500435; c=relaxed/simple;
	bh=gXGpZa9uWm0bQqtVqxWjBvVDTcrH0MAmYNONlowLZEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9mQFvyLxpHxENuBvnyFIOJSfwV0GyQI9sfFK0/srfO7U5gN5RyMlsL/uRCbZO5ENhpHExCnC1fJIjMvzWXdsocuG3BKP+e19SY7r1qKOIll13bIqig6DUZS85t5dKplTPYiL/DI/lvCAT5p/s7Cn9CJvpsykBCUf4m+GGEFZSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B77wSxCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DF0C4CEF8;
	Fri,  7 Nov 2025 07:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762500435;
	bh=gXGpZa9uWm0bQqtVqxWjBvVDTcrH0MAmYNONlowLZEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B77wSxCEFnZz8RglgJn1dvttGvTASh129gGwtPt4uS/iSM2d2FidrLULS8egkjuGm
	 UElZi/4gAqXDWBnKavjQD/+j5u03LXouNyybz+vW5CNfb7VS1S9rXdA1ho2Rt4eWC2
	 Q6Ymv30aWHLJTf/IiXKX5uceIVQL8NobFNkry9RLjkYpnG6pL/ml+SyuGQZGan4YbE
	 S2y8sXhJxHVP6MlAx6qISoJ92BDqopd6Rn0g4A0qmhHEvxMIAa5nsn1maTvRVc4XUD
	 WWpYcbSdX7CTTfQLMiSS9rPfBX86GrB5TpNAzYabLl/2YESjst83rs1NT7N3yFkQ2B
	 MRcVVSuwgylsA==
Date: Fri, 7 Nov 2025 08:27:12 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Richard Cochran <richardcochran@gmail.com>, Qiqi Wang <qiqi.wang@mediatek.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
	netdev@vger.kernel.org, Project_Global_Chrome_Upstream_Group@mediatek.com, 
	sirius.wang@mediatek.com, vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
Subject: Re: [PATCH v3 01/21] dt-bindings: clock: mediatek: Add MT8189 clock
 definitions
Message-ID: <20251107-hidden-idealistic-bullfrog-8f0c91@kuoka>
References: <20251106124330.1145600-1-irving-ch.lin@mediatek.com>
 <20251106124330.1145600-2-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106124330.1145600-2-irving-ch.lin@mediatek.com>

On Thu, Nov 06, 2025 at 08:41:46PM +0800, irving.ch.lin wrote:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> 
> Add device tree bindings for the clock of MediaTek MT8189 SoC.
> 
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> ---
>  .../bindings/clock/mediatek,mt8189-clock.yaml |  90 +++
>  .../clock/mediatek,mt8189-sys-clock.yaml      |  58 ++
>  .../dt-bindings/clock/mediatek,mt8189-clk.h   | 580 ++++++++++++++++++

This one was not tested, though, so dropping from patchwork...

Best regards,
Krzysztof


