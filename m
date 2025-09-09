Return-Path: <linux-pm+bounces-34254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFCDB4FBC2
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 14:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05D914E2D44
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 12:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EED3334736;
	Tue,  9 Sep 2025 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="mk/wvg0a"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7EB23ED75;
	Tue,  9 Sep 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422256; cv=none; b=m27+UCB4uGySTQKe0JE5qyhZNunxiKnL7Fy1W+JexG92mv4Y48AbETlPlHvOdFQRV0QKPOQwqeQ+RjT7Ai54TME4nlHn/Yj2ueersyTeryBNmeH+4slFVDFLwOJ761unKZNztqCC9axsV2pqe2qHjIsjzHXGA3oiy9IPVGb4QTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422256; c=relaxed/simple;
	bh=zZ7ADGFgnAwZfafO2JUodzSZZilfqJT8n7SBJm89wNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzpjEqOlcWltOjzlqgfJuMeZlmzBq3AeUWuP7rf+otvt0oszMp4aNVCJkJi2i8aXK+xqI+4hv95drW+RUhsVl7VaTHI9yEySdduOAi8FLw7u6z4O/3D/UI7cMavo2puVfCsb19XecE3lYPxYv6gdR7KCUJWuOmp8PK/ZwWs5xFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=mk/wvg0a; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=zZ7ADGFgnAwZfafO2JUodzSZZilfqJT8n7SBJm89wNk=; b=mk/wvg0a0yuXY15yC0ROqz+TqB
	k4U+7c4HappQzKDL+GFKJnlYiJdz52zZornV8UKrlHoCIBxwrdWfpaN3kDhwjBZk5xvdgX2BwvoqM
	E7ChTwu4dZEnmMJs+tkoU/ELVMcuQmkhDyhpxMfREYrlh9kt3JTmwv2JMqwzTNZEoO5Zxt7a9+Tqi
	97kuig3Bdpn9UxLyp8MhEf7LBk8auxlgPqxL7lf50lhIj1+SxzjYCKoCI4pHlET81p+fMEr8HnEXR
	In4dXmZ2F8P0jiCtEtcyYzFFZVb0EHonkPmaazx9lt/491sHVhPzDZcTNrrOAHRsHbI+HxcEZUdMv
	4CYrjC4g==;
Received: from i53875b3d.versanet.de ([83.135.91.61] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uvxnv-0001FU-6Y; Tue, 09 Sep 2025 14:50:35 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Saravana Kannan <saravanak@google.com>, linux-pm@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sebin Francis <sebin.francis@ti.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 Peng Fan <peng.fan@oss.nxp.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Johan Hovold <johan@kernel.org>, Maulik Shah <maulik.shah@oss.qualcomm.com>,
 Michal Simek <michal.simek@amd.com>, Konrad Dybcio <konradybcio@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 2/5] pmdomain: rockchip: Fix regulator dependency with
 GENPD_FLAG_NO_STAY_ON
Date: Tue, 09 Sep 2025 14:50:34 +0200
Message-ID: <3633992.V25eIC5XRa@diego>
In-Reply-To: <20250909111130.132976-3-ulf.hansson@linaro.org>
References:
 <20250909111130.132976-1-ulf.hansson@linaro.org>
 <20250909111130.132976-3-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 9. September 2025, 13:11:21 Mitteleurop=C3=A4ische Sommerzeit =
schrieb Ulf Hansson:
> The deferred regulator retrieval for Rockchip PM domains are causing some
> weird dependencies. More precisely, if the power-domain is powered-on from
> the HW perspective, its corresponding regulator must not be powered-off v=
ia
> regulator_init_complete(), which is a late_initcall_sync.
>=20
> Even on platforms that don't have the domain-supply regulator specified f=
or
> the power-domain provider, may suffer from these problems.
>=20
> More precisely, things just happen to work before, because
> genpd_power_off_unused() (also a late_initcall_sync) managed to power-off
> the PM domain before regulator_init_complete() powered-off the regulator.
>=20
> Ideally this fragile dependency must be fixed properly for the Rockchip PM
> domains, but until then, let's fallback to the previous behaviour by using
> the GENPD_FLAG_NO_STAY_ON flag.
>=20
> Link: https://lore.kernel.org/all/20250902-rk3576-lockup-regression-v1-1-=
c4a0c9daeb00@collabora.com/
> Reported-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sy=
nc_state")
> Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until la=
te_initcall_sync")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

NPU on rk3588 now again correctly gets its supplying regulator and
running said npu does not end up in a kernel panic :-)

Tested-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Heiko Stuebner <heiko@sntech.de>



