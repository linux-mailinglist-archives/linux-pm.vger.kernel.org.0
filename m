Return-Path: <linux-pm+bounces-30724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7A8B029D8
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 09:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AAA4A4259D
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 07:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12939221F1E;
	Sat, 12 Jul 2025 07:57:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E193351C5A;
	Sat, 12 Jul 2025 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752307044; cv=none; b=CnkxovBZaggqjfSYW6ozNxRNG40xDiy2KFTwaqdYCmKrv9NxOEtlfhCM8ulAUOJtGXJIkxgwRA7WnEV9WQAqMK72SDbCgO9k2/MShj1tuJ+EEwdLihO2nKoz0U90iHv5JsE6z4+g6ie7G3h4bqYYMcxtegZIvWSEneY0k1/8jkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752307044; c=relaxed/simple;
	bh=XzixfsF30CyClhd0788ncMU136HDBswlnVoJNaBje9g=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sCRIbo5yDdfJPW7Kl4m24q7/XDzt3KGjYmsalaoTGwFIwkaKvuHa44H1VW1S+gUHCS62GMGGw+6oWVEiAAmtuUPnyLhKw4EDE70GnviDcqMnzU/lsWcWiuYcvXui1YPsF8FAKDJZJjJT/NT5C8A+NheiFu9Cq0Y3XITyOVvUyPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61EFC4CEEF;
	Sat, 12 Jul 2025 07:57:23 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id AA99B5F939;
	Sat, 12 Jul 2025 15:57:21 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 iuncuim <iuncuim@gmail.com>
In-Reply-To: <20250703151132.2642378-1-iuncuim@gmail.com>
References: <20250703151132.2642378-1-iuncuim@gmail.com>
Subject: Re: (subset) [PATCH v2 0/8] Allwinner: A523: add support for A523
 THS0/1 controllers
Message-Id: <175230704168.812199.2009708647014789629.b4-ty@csie.org>
Date: Sat, 12 Jul 2025 15:57:21 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 03 Jul 2025 23:11:24 +0800, iuncuim wrote:
> This patch series adds temperature sensor support for the Allwinner A523
> family of processors (same die with H728/A527/T527)
> 
> Changes:
> 1) dt-bindings: nvmem: SID: Add binding for A523 SID controller
>  - added new patch
> 
> [...]

Applied to sunxi/dt-for-6.17 in local tree, thanks!

[7/8] arm64: dts: allwinner: A523: Add SID controller node
      commit: 082c6a2d06c0831d236760a29953355845eee988

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


