Return-Path: <linux-pm+bounces-34074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B293AB4762B
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 20:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D51BA429AF
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 18:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B923127D773;
	Sat,  6 Sep 2025 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="zUfL4s8U"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F43021171D;
	Sat,  6 Sep 2025 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757183857; cv=none; b=IPhnQHa41znbIUCQA4Mz3dG3dbLvqJ+RzBWswKTaLr8Z/oTM9pPxn449Bk6o/lcTfG3GxBywDp7lGttebl4bj7EYxxhSQw91nUHStIRy5vawheXRzueApn5jXNiZ0WQd7MXxQDRrhZlvzNmpWj7b+1FAJNWADivf3wP9AtYGfsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757183857; c=relaxed/simple;
	bh=hPruiawnravlHUFNKTkQxxaPtFJbhczk4BB1r9Ut7gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZMDdxG6o1ogsrZ4rNeG+YOQb79zyyQsVlOi/Xtn9Yu9pB3ePHBbWx176cbZQ5iLXF6GVzTznIccgmD80D3VKQmwz0ixwrmfq0Z22Jr6si9MMPtLnCjjoR6dudYQ8b6AwOP7442gTTU58MbmxKQb3Nfl/uym2vR/qo9FoZ2pfQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=zUfL4s8U; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=ixgp0grp21H2AsoUs2fpv0iJHrH7SDIdhzu9KNRECUs=; b=zUfL4s8U0K9Q2MHNMM7l5z2A3k
	HSGFJ9vEoXv7ibDwXsOiPVKUCFvVWIbJ9iF4P0Ekkwdc8o879WQskezT8MWsqZGbwYcVVXuPnYiho
	WVciJJuqRAwj9WK/qdKky1pIzSfAkWqbWVySteyWQVBR1ni9v8Q4mkct4H6a5zuJ0Im+9Qb+Ormlv
	OglT+cTJHqa5SwMH+c3tdAIIpP6cgRhg+9+sdveb42AuA0fla1kJy6JesNwCJGdlcogGnzeWg4nnt
	j5wWodQiCGrnYN/fWLF6w+sIq5XxS+yk8IP7iZDQj6XyvSVdfig2z/fe/s71nI6A266E3w521EAsn
	jot+Zmdg==;
Received: from i53875a53.versanet.de ([83.135.90.83] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uuxms-0006t1-Id; Sat, 06 Sep 2025 20:37:22 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Chanwoo Choi <cw00.choi@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 2/2] PM / devfreq: rockchip-dfi: add support for LPDDR5
Date: Sat, 06 Sep 2025 20:37:21 +0200
Message-ID: <14289002.RDIVbhacDa@diego>
In-Reply-To:
 <20250530-rk3588-dfi-improvements-v1-2-6e077c243a95@collabora.com>
References:
 <20250530-rk3588-dfi-improvements-v1-0-6e077c243a95@collabora.com>
 <20250530-rk3588-dfi-improvements-v1-2-6e077c243a95@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Freitag, 30. Mai 2025, 15:38:09 Mitteleurop=C3=A4ische Sommerzeit schrie=
b Nicolas Frattaroli:
> The Rockchip RK3588 SoC can also support LPDDR5 memory. This type of
> memory needs some special case handling in the rockchip-dfi driver.
>=20
> Add support for it in rockchip-dfi, as well as the needed GRF register
> definitions.
>=20
> This has been tested as returning both the right cycle count and
> bandwidth on a LPDDR5 board where the CKR bit is 1. I couldn't test
> whether the values are correct on a system where CKR is 0, as I'm not
> savvy enough with the Rockchip tooling to know whether this can be set
> in the DDR init blob.
>=20
> Downstream has some special case handling for a hardware version where
> not just the control bits differ, but also the register. Since I don't
> know whether that hardware version is in any production silicon, it's
> left unimplemented for now, with an error message urging users to report
> if they have such a system.
>=20
> There is a slight change of behaviour for non-LPDDR5 systems: instead of
> writing 0 as the control flags to the control register and pretending
> everything is alright if the memory type is unknown, we now explicitly
> return an error.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

header additions
Acked-by: Heiko Stuebner <heiko@sntech.de>

> diff --git a/include/soc/rockchip/rk3588_grf.h b/include/soc/rockchip/rk3=
588_grf.h
> index 630b35a550640e57f1b5a50dfbe362653a7cbcc1..02a7b2432d9942e15a77424c4=
4fefec189faaa33 100644
> --- a/include/soc/rockchip/rk3588_grf.h
> +++ b/include/soc/rockchip/rk3588_grf.h
> @@ -12,7 +12,11 @@
>  #define RK3588_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3		GENMASK(13, 12)
>  #define RK3588_PMUGRF_OS_REG3_SYSREG_VERSION		GENMASK(31, 28)
> =20
> -#define RK3588_PMUGRF_OS_REG4           0x210
> -#define RK3588_PMUGRF_OS_REG5           0x214
> +#define RK3588_PMUGRF_OS_REG4				0x210
> +#define RK3588_PMUGRF_OS_REG5				0x214
> +#define RK3588_PMUGRF_OS_REG6				0x218
> +#define RK3588_PMUGRF_OS_REG6_LP5_BANK_MODE		GENMASK(2, 1)
> +/* Whether the LPDDR5 is in 2:1 (=3D 0) or 4:1 (=3D 1) CKR a.k.a. DQS mo=
de */
> +#define RK3588_PMUGRF_OS_REG6_LP5_CKR			BIT(0)
> =20
>  #endif /* __SOC_RK3588_GRF_H */
> diff --git a/include/soc/rockchip/rockchip_grf.h b/include/soc/rockchip/r=
ockchip_grf.h
> index e46fd72aea8d1f649768a3269b85176dacceef0e..41c7bb26fd5387df85e5b5818=
6b67bf74706f360 100644
> --- a/include/soc/rockchip/rockchip_grf.h
> +++ b/include/soc/rockchip/rockchip_grf.h
> @@ -13,6 +13,7 @@ enum {
>  	ROCKCHIP_DDRTYPE_LPDDR3	=3D 6,
>  	ROCKCHIP_DDRTYPE_LPDDR4	=3D 7,
>  	ROCKCHIP_DDRTYPE_LPDDR4X =3D 8,
> +	ROCKCHIP_DDRTYPE_LPDDR5	=3D 9,
>  };
> =20
>  #endif /* __SOC_ROCKCHIP_GRF_H */
>=20
>=20





