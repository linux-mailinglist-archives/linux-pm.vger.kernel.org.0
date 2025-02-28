Return-Path: <linux-pm+bounces-23177-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B28BA49AEA
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 14:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09F7E7A77E8
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 13:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E46B3F9D5;
	Fri, 28 Feb 2025 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="M0mtWwSS"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3918F6B;
	Fri, 28 Feb 2025 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750409; cv=none; b=or/ZRwMefEV2qbxca1hIbIGpednipVtwXPVG4B431J87PxwiHCOWd605ae98LLfHtcydroa0bFQMr3Z2McBUsi6j184lkL25+Sv757a7XURJkjZeXdM0jJYhR3kbDvikfeUXyhHhRxsDabAdLnpcQ4u8844G5qXbR6baZOxgnTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750409; c=relaxed/simple;
	bh=ViEBZK3EzIQxuHBMDu4S/+mF+gx5Aa58M+yPv1V91ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQLOXH2dTaLaopwDM12OX1yOpE/jqYB2yKFfASYn8205eKRTMbvKLy6ONV+zzNtrzQbCaq8N7rE9e2lR2w9O0NrXrUpxOIAzhHolNk1WlQqrYHs/u7QhVeukxuU0e+xsfcmGHjb5oLgZ8dDq9VEGsBgwM4aCNiZ20oTW8DOeU3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=M0mtWwSS; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZmbzHfuFGxMO/tUQLPQhCYSmxmQclsCq7HjjPDZTRLo=; b=M0mtWwSSXf5AxhHuLJS9gFksqw
	eAs8epReVMAXpLMykhMSsggIt3/IEvN0OLRRwPmjuJX8+cVhiG3el3nzXZ3chisBzRv0LXOWCHWbS
	Cmw+rNiMy3/oFYVPst8s5ohyV4n7NbLE08Tv3fBH/rD4qCfkU3sPGi5pW6ZdBrlXcFuNprylOr/aK
	nMg0YBEv+qLNpJaqV2qBBah5gZq8iVaIk/c/82QrHtBI6P2b4dINkJcAtkAFlaBJedZPQkBxKxkyF
	DHvgrxcy2eF373uVIHkhrRjkSeTHk7mnkcM810S/anTLny13IEeZMh7oagdJRyGTGOIkEHB2CxzMr
	ZMXBxjfg==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1to0hB-00018u-Dt; Fri, 28 Feb 2025 14:46:29 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Mark Brown <broonie@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	=?UTF-8?q?Adri=C3=A1n=20Mart=C3=ADnez=20Larumbe?= <adrian.larumbe@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Peter Geis <pgwipeout@gmail.com>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Vignesh Raman <vignesh.raman@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v6 0/8] Fix RK3588 power domain problems
Date: Fri, 28 Feb 2025 14:46:18 +0100
Message-ID: <174075035003.278101.1580632706000540174.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220-rk3588-gpu-pwr-domain-regulator-v6-0-a4f9c24e5b81@kernel.org>
References: <20250220-rk3588-gpu-pwr-domain-regulator-v6-0-a4f9c24e5b81@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 20 Feb 2025 19:58:03 +0100, Sebastian Reichel wrote:
> I got a report, that the Linux kernel crashes on Rock 5B when the panthor
> driver is loaded late after booting. The crash starts with the following
> shortened error print:
> 
> rockchip-pm-domain fd8d8000.power-management:power-controller: failed to set domain 'gpu', val=0
> rockchip-pm-domain fd8d8000.power-management:power-controller: failed to get ack on domain 'gpu', val=0xa9fff
> SError Interrupt on CPU4, code 0x00000000be000411 -- SError
> 
> [...]

Applied, thanks!

[8/8] arm64: dts: rockchip: Add GPU power domain regulator dependency for RK3588
      commit: f94500eb7328b35f3d0927635b1aba26c85ea4b0


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

