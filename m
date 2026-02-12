Return-Path: <linux-pm+bounces-42557-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPjmBTPUjWlA7wAAu9opvQ
	(envelope-from <linux-pm+bounces-42557-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 14:22:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 822DD12DC57
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 14:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CF5B303325B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 13:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB36834DB7C;
	Thu, 12 Feb 2026 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="C3T2hdlX"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7863019E7F7;
	Thu, 12 Feb 2026 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770902574; cv=none; b=gqEypNRy3raCn8sXE0aeL04dFDxs4LJlF/ngpIZNG9+Ors/QKZ0p+0Ii+NjiWdOr80BH3Rtq4kiaMthgYmfI5T0cpovrQPYbNs7XCzerL+wLXADM9ued5mezzZk0MMj2UhlqCIjJjrwA33X7BBXF6ROdmLdH4ghRfiE1URvg7PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770902574; c=relaxed/simple;
	bh=jVhqW5d5/4WvenW7FnYJhll+1n+XgrttPcOjEX9QFsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2GAXHqMDK+xkifjicKCnocRzQwoex8M8d5wCsXrn8ew/RCDZ/+3B7GzCxstR5EDHu0GGGxOIicLbUZ4vgpLx1b9vmSj7fYtof5JTjZMf4snXs1VUoxd68gM65EHt4jIvAaRALv4uFZyqg0deMnA/Az9d0YSXJUg7kZDPCoZtXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=C3T2hdlX; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=6WYgrh1rDbYZNtpEGMZFwhuaDpq+FiSgx7pXrEAtZIw=; b=C3T2hdlXcrBJ4qpsbxcT7Y0ydx
	3XZ2S09zc+uLa1AYHpq+dFepR9WumOyxeqOUjR/uuQd/AheonJ10tXqLmuak6bs/eMFer19H5ZD/Y
	Y2kCzw4TSfLiUHoZNiAErkgTMgeZDW24grBr2VGRqdM0lW9mw7UKZOThLKQmwLcedtYCR00QVeXvi
	w+CTrw0mhI0LW7tXMGpFhC3/bOihCpypfC+sJm3npeo/G4H2vBxvvbfAVJWKtzueV5Ir/QuQ09TEF
	VxOhQxlwpG5HBJApbZwGq8ww6chNoLs71C1D95AJFwMOTI4Uw+pU6qLmsU3kd7xj7tmrQVKD6ugHu
	esMmfaMQ==;
Received: from i53875be4.versanet.de ([83.135.91.228] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vqWeU-008Dft-KJ; Thu, 12 Feb 2026 14:22:38 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Finley Xiao <finley.xiao@rock-chips.com>, Frank Zhang <rmxpzlb@gmail.com>,
 linux-pm@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] pmdomain: rockchip: Fix rkvdec0/1 and venc0/1 for RK3588
Date: Thu, 12 Feb 2026 14:22:37 +0100
Message-ID: <16020302.lVVuGzaMjS@diego>
In-Reply-To: <1770891364-52147-1-git-send-email-shawn.lin@rock-chips.com>
References: <1770891364-52147-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42557-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[rock-chips.com,gmail.com,vger.kernel.org,collabora.com,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[sntech.de:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sntech.de:email,sntech.de:dkim]
X-Rspamd-Queue-Id: 822DD12DC57
X-Rspamd-Action: no action

Am Donnerstag, 12. Februar 2026, 11:16:04 Mitteleurop=C3=A4ische Normalzeit=
 schrieb Shawn Lin:
> From the RK3588 TRM Table 1-1 RK3588 Voltage Domain and Power Domain Summ=
ary,
> PD_RKVDEC0/1 and PD_VENC0/1 rely on VD_VCODEC which require extra voltage=
s to
> be applied, otherwise it breaks RK3588-evb1-v10 board after vdec support =
landed[1].
> The panic looks like below:
>=20
>   rockchip-pm-domain fd8d8000.power-management:power-controller: failed t=
o set domain 'rkvdec0' on, val=3D0
>   rockchip-pm-domain fd8d8000.power-management:power-controller: failed t=
o set domain 'rkvdec1' on, val=3D0
>   ...
>   Hardware name: Rockchip RK3588S EVB1 V10 Board (DT)
>   Workqueue: pm genpd_power_off_work_fn
>   Call trace:
>   show_stack+0x18/0x24 (C)
>   dump_stack_lvl+0x40/0x84
>   dump_stack+0x18/0x24
>   vpanic+0x1ec/0x4fc
>   vpanic+0x0/0x4fc
>   check_panic_on_warn+0x0/0x94
>   arm64_serror_panic+0x6c/0x78
>   do_serror+0xc4/0xcc
>   el1h_64_error_handler+0x3c/0x5c
>   el1h_64_error+0x6c/0x70
>   regmap_mmio_read32le+0x18/0x24 (P)
>   _regmap_bus_reg_read+0xfc/0x130
>   _regmap_read+0x188/0x1ac
>   regmap_read+0x54/0x78
>   rockchip_pd_power+0xcc/0x5f0
>   rockchip_pd_power_off+0x1c/0x4c
>   _genpd_power_off+0x84/0x120
>   genpd_power_off+0x1b4/0x260
>   genpd_power_off_work_fn+0x38/0x58
>   process_scheduled_works+0x194/0x2c4
>   worker_thread+0x2ac/0x3d8
>   kthread+0x104/0x124
>   ret_from_fork+0x10/0x20
>   SMP: stopping secondary CPUs
>   Kernel Offset: disabled
>   CPU features: 0x3000000,000e0005,40230521,0400720b
>   Memory Limit: none
>   ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---
>=20
> [1] https://lore.kernel.org/linux-rockchip/20251020212009.8852-2-detlev.c=
asanova@collabora.com/
> Fixes: db6df2e3fc16 ("pmdomain: rockchip: add regulator support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks for tracking this down. This will make sure the video
encoders/decoders will not probe, if the domain-supply is missing.


Reviewed-by: Heiko Stuebner <heiko@sntech.de>

>=20
> ---
>=20
>  drivers/pmdomain/rockchip/pm-domains.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 997e93c..040aa5f 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -1315,10 +1315,10 @@ static const struct rockchip_domain_info rk3588_p=
m_domains[] =3D {
>  	[RK3588_PD_NPUTOP]	=3D DOMAIN_RK3588("nputop",  0x0, BIT(3),  0,       =
0x0, BIT(11), BIT(2),  0x0, BIT(1),  BIT(1),  false, false),
>  	[RK3588_PD_NPU1]	=3D DOMAIN_RK3588("npu1",    0x0, BIT(4),  0,       0x=
0, BIT(12), BIT(3),  0x0, BIT(2),  BIT(2),  false, false),
>  	[RK3588_PD_NPU2]	=3D DOMAIN_RK3588("npu2",    0x0, BIT(5),  0,       0x=
0, BIT(13), BIT(4),  0x0, BIT(3),  BIT(3),  false, false),
> -	[RK3588_PD_VENC0]	=3D DOMAIN_RK3588("venc0",   0x0, BIT(6),  0,       0=
x0, BIT(14), BIT(5),  0x0, BIT(4),  BIT(4),  false, false),
> -	[RK3588_PD_VENC1]	=3D DOMAIN_RK3588("venc1",   0x0, BIT(7),  0,       0=
x0, BIT(15), BIT(6),  0x0, BIT(5),  BIT(5),  false, false),
> -	[RK3588_PD_RKVDEC0]	=3D DOMAIN_RK3588("rkvdec0", 0x0, BIT(8),  0,      =
 0x0, BIT(16), BIT(7),  0x0, BIT(6),  BIT(6),  false, false),
> -	[RK3588_PD_RKVDEC1]	=3D DOMAIN_RK3588("rkvdec1", 0x0, BIT(9),  0,      =
 0x0, BIT(17), BIT(8),  0x0, BIT(7),  BIT(7),  false, false),
> +	[RK3588_PD_VENC0]	=3D DOMAIN_RK3588("venc0",   0x0, BIT(6),  0,       0=
x0, BIT(14), BIT(5),  0x0, BIT(4),  BIT(4),  false, true),
> +	[RK3588_PD_VENC1]	=3D DOMAIN_RK3588("venc1",   0x0, BIT(7),  0,       0=
x0, BIT(15), BIT(6),  0x0, BIT(5),  BIT(5),  false, true),
> +	[RK3588_PD_RKVDEC0]	=3D DOMAIN_RK3588("rkvdec0", 0x0, BIT(8),  0,      =
 0x0, BIT(16), BIT(7),  0x0, BIT(6),  BIT(6),  false, true),
> +	[RK3588_PD_RKVDEC1]	=3D DOMAIN_RK3588("rkvdec1", 0x0, BIT(9),  0,      =
 0x0, BIT(17), BIT(8),  0x0, BIT(7),  BIT(7),  false, true),
>  	[RK3588_PD_VDPU]	=3D DOMAIN_RK3588("vdpu",    0x0, BIT(10), 0,       0x=
0, BIT(18), BIT(9),  0x0, BIT(8),  BIT(8),  false, false),
>  	[RK3588_PD_RGA30]	=3D DOMAIN_RK3588("rga30",   0x0, BIT(11), 0,       0=
x0, BIT(19), BIT(10), 0x0, 0,       0,       false, false),
>  	[RK3588_PD_AV1]		=3D DOMAIN_RK3588("av1",     0x0, BIT(12), 0,       0x=
0, BIT(20), BIT(11), 0x0, BIT(9),  BIT(9),  false, false),
>=20





