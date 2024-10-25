Return-Path: <linux-pm+bounces-16437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1DD9AFD21
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 10:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112D21F22F83
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 08:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4933A1D3593;
	Fri, 25 Oct 2024 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Ijs4zHqN"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A191D2B22;
	Fri, 25 Oct 2024 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846195; cv=none; b=LH1TvJLQEh4yl4t9fe0FJnKODeiWA3EHnytzTszBtWzmVO/2rzZXAMXzwHeFPvstLSEcewRb8tSs5ZaAClBxOuHAugMw+95vKmttzKkxf/bQPg5eF2L5MvujPTVqvdA3YOS1j+YxD+tEuPKgTogF9HSx7sdFFj3SkjyYkzrJz30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846195; c=relaxed/simple;
	bh=omXfoihbkyRKq9YwHN4cjSROCIwkALzvsJjGLDTBlgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnoaBl4vATr8PzL4lQaHHVDyGZ6mXtTuMCSFld+lAyy1dpkGzQOQpT95VWf/+D0neKmr+NmfKAbGFwldS8uC77r2AIXbQZV4BQAOUO4IwOtgE70mo4NtU5zq8wik8TrKWxRhu0miUOwHsrngtd3aP7SN8nLxekpya4WLbC5rNJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Ijs4zHqN; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dCTo7/Paqcj1EVHb4+w12POrbZzZC7lWqiLNM5hDYKI=; b=Ijs4zHqNaVR7dlv1gXLpnhp09+
	b6VLYRy2mZtaoHGHyJZIttynYfdS68bztttwgmOEyOc8O+buh1qm7gjMoXDWEDquIoLTbRukqwN8t
	eoTZgzpqGSFtGi9Im9UwYsjy2nINm67DRvieKeJRLPAVdBZmIsE2xIW2YfMyhdJmJBbw1dkXlhZ+V
	YYehv11NjALmjpaUjHDjdG0FLkj3QJ2T8PVcNQbH8O/IAOid88QOR4Mj2/g8qbhI0WMbyIdZuNqlX
	Ia+mgPcZ91tYQKGC34/cKjZMs5ZmG5xVMdDLf+/nSysStHE4/Xqxn4H5qYIbjzN3aQH98Xxjd3PkY
	M6ttTubQ==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t4G0i-00078T-UX; Fri, 25 Oct 2024 10:49:32 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 =?ISO-8859-1?Q?Adri=E1n_Mart=EDnez?= Larumbe <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com
Subject:
 Re: [PATCH v3 7/7] arm64: dts: rockchip: Add GPU power domain regulator
 dependency for RK3588
Date: Fri, 25 Oct 2024 10:49:31 +0200
Message-ID: <39319975.10thIPus4b@diego>
In-Reply-To: <20241022154508.63563-8-sebastian.reichel@collabora.com>
References:
 <20241022154508.63563-1-sebastian.reichel@collabora.com>
 <20241022154508.63563-8-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Dienstag, 22. Oktober 2024, 17:41:52 CEST schrieb Sebastian Reichel:
> Enabling the GPU power domain requires that the GPU regulator is
> enabled. The regulator is enabled at boot time, but automatically
> gets disabled when there are no users.
>=20
> If the GPU driver is not probed at boot time or rebound while
> the system is running the system will try to enable the power
> domain before the regulator is enabled resulting in a failure
> hanging the whole system. Avoid this by adding an explicit
> dependency.
>=20
> Reported-by: Adri=E1n Mart=EDnez Larumbe <adrian.larumbe@collabora.com>
> Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On Rock 5B
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64=
/boot/dts/rockchip/rk3588-rock-5b.dts
> index 8f7a59918db7..717504383d46 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -465,6 +465,10 @@ &pcie3x4 {
>  	status =3D "okay";
>  };
> =20
> +&pd_gpu {
> +	domain-supply =3D <&vdd_gpu_s0>;
> +};
> +
>  &pinctrl {
>  	hdmirx {
>  		hdmirx_hpd: hdmirx-5v-detection {

nit: this seems to have seen some spillover from the not-yet-merged
hdmi-rx

Heiko



