Return-Path: <linux-pm+bounces-29106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC86AE0F77
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 00:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C5317A8D0
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 22:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F195125B67D;
	Thu, 19 Jun 2025 22:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="liASiEjR"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1DA30E826;
	Thu, 19 Jun 2025 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750371238; cv=none; b=gcHnedqBUayOWTwUWLxopDA7QrAfUOA9Cjue2pVQp1gOHIAgPY+Tg8/xvFa8W3R334sm3FsrZt07Vl9iqDJYEYMMUllB0Xv3FIfDno4HBxKIvu2/nX/ohdvEECJ0wmXf4TRXG+AoBztQ4YjunhNEBTg3wjcgG4NsAO32sQLAXFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750371238; c=relaxed/simple;
	bh=VkvJZaf1xIQ7oLQmdRrNT1Hr+EoYVxauf+en4PevQXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHbwct2oigvvJt2Q66jBPvBV+kxSRV16ZoepZdEdUK0fqWyGNMhnCE7gGKekdtJjQWNlb7DTPfomuXgxQASNog9E5ZgkFJrNTCODIZ1LUtquqpGa9/rbjV/QZjtXnR/WqOo7UDa/jmE44YEJzcnRlQqwijaqdye6mQnyeXXeIq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=liASiEjR; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=9Y/aI1+KgOz6LLSAu2ncBoBTsqSkVCTLSAMw2PTIoL0=; b=liASiEjRzLOVhojwGDYmpVSYE2
	/DM61Ku2Wc7QEnUaf57vFLmY46CMKcSD6sWL6PjGivLcZBT/gFcT8/AkEZxEfnOhMjAQWnKAghDqP
	vV4T6udEV4HxgWlMfUqFsq75ONrCMs6Vs8r8pODGC9uUNwt12GLBnLmO+t3uBKnYPbmhkXqvmeHOL
	9+riJhsXg2e9noOJ2zH9CZ3zaAVQIllgsAmF9MDQKIjDlgSteNfw97gvzwiKS8tYzFi5ALpIk9HVm
	j0PQLgsZmj2Fip5gptktByvP/EavMxCYuMy/yiY1IRYDYKE9wigPn5+EroXq7E7PERI8md1gMDdq0
	/QgxUOpA==;
Received: from 85-207-219-154.static.bluetone.cz ([85.207.219.154] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uSNW2-0008Oo-1j; Fri, 20 Jun 2025 00:13:50 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH 0/9] rockchip: Add power controller support for RK3528
Date: Fri, 20 Jun 2025 00:13:38 +0200
Message-ID: <175037106381.1530547.11103096217205983785.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250518220707.669515-1-jonas@kwiboo.se>
References: <20250518220707.669515-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 18 May 2025 22:06:47 +0000, Jonas Karlman wrote:
> The Rockchip RK3528 support multiple power domains, one PD_GPU that can
> fully be powered down, and other that can be idle requested.
> 
> Vendor kernel flag all power domains on RK3528 as always-on, this takes
> a different route and instead tries to describe all devices power-domain
> in the device tree, even for controllers with unsupported runtime status.
> 
> [...]

Applied, thanks!

[4/9] arm64: dts: rockchip: Add power controller for RK3528
      commit: 654df8e74dbc19ba0625051079e6889e6999d16e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

