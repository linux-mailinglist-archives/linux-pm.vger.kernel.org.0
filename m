Return-Path: <linux-pm+bounces-34253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF97B4FBC7
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 14:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281805E0FC3
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 12:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424343376AB;
	Tue,  9 Sep 2025 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="s9954l1u"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA95334733;
	Tue,  9 Sep 2025 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422243; cv=none; b=hL2AfboY9o+DpyyPjLdUESj3PyD3oHX2qU46W49PvZB/KjSyofWkHGgbvR4a9K1t88wEJX5u4CeqYCf+M1+HWb2MH3nGiZ0TqNIRvuLT55MflK6hmhBSyDxYEQRW1bHRmVp8XXNIhroyx/kAEulSRzip/zrm4ddtMF71Fi54gwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422243; c=relaxed/simple;
	bh=6pt6fdbI51HnlsLiKVQpPu5I3HDVPxOkLiCUOACXNg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BktqdKm4JBWlDBOHJlHDr9dtKSuR5T0aradExuqrh3trpP6kZ3cMtgjQTaNWOlc/U5ZWr/PGwJ2r+eAXW3eJkTVWGp2lbfTOxVkaUHgNLsMBa2IskMU812Ysyhke/QPEEcq8jZDbjO5/Hv0B13ctB2JQIivK2RpSLcEyZg+CQyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=s9954l1u; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=6pt6fdbI51HnlsLiKVQpPu5I3HDVPxOkLiCUOACXNg4=; b=s9954l1uhglycDr4Wx0bZzwOyN
	86g/vyWbzQ/33j/pZ6FDJ3oAlbiLLPt8rVzNBWHyObqeudvGOE8ui9BfDC/mFSAT4oI6Rfgr4sa2u
	DCIUzmgDwixU6jVGC/lyMmmzQ3KnjORJ17WtFYFUeAtF7b+wru5DFLz4gilvnAVguMtkS90YAfcG5
	pTo4PSbKviF6JHJKNvaaZqdmr6ZWCoqMAB9oD7klg1nf1goqgaizlzwtiYJTGeM7J4uhfJoNbLIHF
	D946yRmCUhqK1aZXOz+kPoEgvSRd9CV0uJ211wJ5JJe/TxsgJF7CjI8z7Y7CcR/jracjqAikkslKK
	TBZ7s/jw==;
Received: from i53875b3d.versanet.de ([83.135.91.61] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uvxnW-0001F3-Ee; Tue, 09 Sep 2025 14:50:10 +0200
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
 Re: [PATCH 1/5] pmdomain: core: Restore behaviour for disabling unused PM
 domains
Date: Tue, 09 Sep 2025 14:50:09 +0200
Message-ID: <6841173.4vTCxPXJkl@diego>
In-Reply-To: <20250909111130.132976-2-ulf.hansson@linaro.org>
References:
 <20250909111130.132976-1-ulf.hansson@linaro.org>
 <20250909111130.132976-2-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 9. September 2025, 13:11:20 Mitteleurop=C3=A4ische Sommerzeit =
schrieb Ulf Hansson:
> Recent changes to genpd prevents those PM domains being powered-on during
> initialization from being powered-off during the boot sequence. Based upon
> whether CONFIG_PM_CONFIG_PM_GENERIC_DOMAINS_OF is set of not, genpd relies
> on the sync_state mechanism or the genpd_power_off_unused() (which is a
> late_initcall_sync), to understand when it's okay to allow these PM domai=
ns
> to be powered-off.
>=20
> This new behaviour in genpd has lead to problems on different platforms.
> Let's therefore restore the behavior of genpd_power_off_unused().
> Moreover, let's introduce GENPD_FLAG_NO_STAY_ON, to allow genpd OF
> providers to opt-out from the new behaviour.
>=20
> Link: https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@lin=
aro.org/
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/all/20250902-rk3576-lockup-regression-v1-1-=
c4a0c9daeb00@collabora.com/
> Reported-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sy=
nc_state")
> Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until la=
te_initcall_sync")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

NPU on rk3588 now again correctly gets its supplying regulator and
running said npu does not end up in a kernel panic :-)

Tested-by: Heiko Stuebner <heiko@sntech.de>




