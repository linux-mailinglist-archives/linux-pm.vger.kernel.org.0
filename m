Return-Path: <linux-pm+bounces-30704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC96B02216
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 18:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2996A600FC
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 16:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F592EF2B9;
	Fri, 11 Jul 2025 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boaL7Oh5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038FA2EA15D;
	Fri, 11 Jul 2025 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752252164; cv=none; b=gmKwGge5m89dTrQzimy83DKgaQpsLRiHNXnx26ZY7BfSplyN4dWKwRj747Mwd+FtHccYdsKCSf1dhUUpxEG79ysTyObZqqVak/bi+8x7jsyGy8fbPI73kJL1yY6FXMcOB3Cg9gNtEMXnc38cv8GTbEqvQJJey7uxepDAZD2Lv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752252164; c=relaxed/simple;
	bh=eV0bXu0s/ddHR0HdGKgiSiUP56+lEzZpkmznMpgiK90=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aQxIzzfeSId053J07o7Afk5P5MyUEK3NdVZNzDt8yMgqpFXI/f8YLsJx877MO4xi0BtoTrzXp+bCdMdp7d1Ohp05h33JImA8X0tpr9f2VS4JAwggammgaEXNuNDkSChzrXGJqpL35lhtmGxIKIa1LYuTDapLeZF0gsrf/RBqxE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boaL7Oh5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7CAC4CEED;
	Fri, 11 Jul 2025 16:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752252163;
	bh=eV0bXu0s/ddHR0HdGKgiSiUP56+lEzZpkmznMpgiK90=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=boaL7Oh5uFTJc5XNOsKYGpgRXWYYqO+5tJ9zlsmEtmitNvf17xAzHf3NJTSM9VpWT
	 Thu3qngZ8CWlriz9qVNUFysV/cuw3upRpTC58L4DhtMKye9AUO97rHtXyhURfbZlak
	 P6+1a+oLkZcFxtX29waqUtePgd3A4dkaLAR2+2H6UB04nuqTskKNSI4Nsz4KOsP6T1
	 gBLOF6OQLOywkP8erliyTOrgjWqzx15hfGWR6fxP6X4VMcsukXcPUXCuXqGjbnaDrs
	 YYr+5reZ8tH1LGltVCRpb9//kHpUxwi50qXEC8fohubCKlE3EUrhKATWV7Of/WMJGi
	 2vZbqd3aMPkpA==
From: Srinivas Kandagatla <srini@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
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
Message-Id: <175225215900.5938.11774376916669080411.b4-ty@kernel.org>
Date: Fri, 11 Jul 2025 17:42:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 03 Jul 2025 23:11:24 +0800, iuncuim wrote:
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
> 
> This patch series adds temperature sensor support for the Allwinner A523
> family of processors (same die with H728/A527/T527)
> 
> Changes:
> 1) dt-bindings: nvmem: SID: Add binding for A523 SID controller
>  - added new patch
> 
> [...]

Applied, thanks!

[1/8] dt-bindings: nvmem: SID: Add binding for A523 SID controller
      commit: 68d386fb1ca01ddb4f70f07e3e7b8d51ef9743ac

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


