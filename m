Return-Path: <linux-pm+bounces-43458-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFvKItsZpmnIKQAAu9opvQ
	(envelope-from <linux-pm+bounces-43458-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:14:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6218C1E66DE
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8704B303B379
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 22:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F275282F2A;
	Mon,  2 Mar 2026 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="LLW0fW+n"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2842F282F03;
	Mon,  2 Mar 2026 22:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492169; cv=pass; b=e/U5oG0gJfy2NPaK0443C6VDNxZ2Nusq3YNKNeINFVSZDLVGP3o5qMHXx4RGgEcZA2p16dtDUFXCDf9buPJZhC9SvkDTuB3jM8MEdwLxwpQQcHmymH0e4Sa1xhUhmY3Ys5KvMnTsVsT0CBtEzAw0KCAH80mZceFZkZH/3C63WXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492169; c=relaxed/simple;
	bh=YApuTjoaVVAlTMd0uOR2e6gALCspefAhrYxFXZzjvqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xz0Njp0CDFMvCFPZ0L+ZFqEk/NIFF5maqtiadNO5a3YIMIW344xRxzb9vpL03MsyEQnjLch53sa2n3JAA/ZlWUZugNKhoUoVOCgowDQrGM6AQjjv4H7T3CbmkZEgMR4slUw3Skm4Xf/QVfFSBC1itdywnOT3x5mTjI8TfnKkSNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=LLW0fW+n; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1772492149; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PA5Vyg5JJ1o6mkYIZByEs94sAGp8NKHm8ncmEqH5HF7vxyOiD4eUTr4pLSVQpca/hkrmEvuCT3+8h4EJYR44S3yLiJ20IE2x1RXW6UW4NrhfSwadyvOiX5PZo4jnrKiAVyqsoGhduspSb6k6fNZxu5VZyfHr1p26D6sathwn5oY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772492149; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/zdY8KHrZuIUijPdIoSdoYLMGu+rk0Tb9iREEpfohNo=; 
	b=lI7YhxZOD31+07z7vfs0KsXrAJ0I1W+9Yg0sHaPZtjwIvfSYrv8Ftqn7sMV0Q4rty/IYdyNUaf6ISQyB8FVJ4EF4RREGR0COEHPsRBYHnk0la/pwoFIlTdh7IX3bHJ4XmOT2Jb0kCGNCH8I9MWLSeCzGLkMqqpkCnEQjyqlYj2Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772492149;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=/zdY8KHrZuIUijPdIoSdoYLMGu+rk0Tb9iREEpfohNo=;
	b=LLW0fW+n6DCCwrKRfbBtuS2n8xKR/023CjQ2eKRWWHSd2RYMNkal4Lzk0CtZsG+Y
	cM4+wJ2JzSIdt5mT7gZkrU1EUnM53fGRklsruE6Qggj0UHHorYCu4aXcwJ8Bi/BWPXh
	H56omdqdNVlGCCGqs872JfF1hBrja8zgsUm261ss=
Received: by mx.zohomail.com with SMTPS id 1772492147652172.17855840863865;
	Mon, 2 Mar 2026 14:55:47 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 0804C180411; Mon, 02 Mar 2026 23:55:44 +0100 (CET)
Date: Mon, 2 Mar 2026 23:55:44 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, 
	Finley Xiao <finley.xiao@rock-chips.com>, Frank Zhang <rmxpzlb@gmail.com>, linux-pm@vger.kernel.org, 
	Detlev Casanova <detlev.casanova@collabora.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-rockchip@lists.infradead.org, stable@vger.kernel.org, Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: Re: [PATCH v3] pmdomain: rockchip: Fix PD_VCODEC for RK3588
Message-ID: <aaYVOClMqnXIUvjf@venus>
References: <1771988101-49877-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4zfusrcm7v6ffvo5"
Content-Disposition: inline
In-Reply-To: <1771988101-49877-1-git-send-email-shawn.lin@rock-chips.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.1.1.4.3/272.480.55
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 6218C1E66DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linaro.org,rock-chips.com,gmail.com,vger.kernel.org,collabora.com,sntech.de,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-43458-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,collabora.com:dkim,collabora.com:email]
X-Rspamd-Action: no action


--4zfusrcm7v6ffvo5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] pmdomain: rockchip: Fix PD_VCODEC for RK3588
MIME-Version: 1.0

Hi,

On Wed, Feb 25, 2026 at 10:55:01AM +0800, Shawn Lin wrote:
> From the RK3588 TRM Table 7-1 RK3588 Voltage Domain and Power Domain Summ=
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
>   regmap_bus_reg_read+0xfc/0x130
>   regmap_read+0x188/0x1ac
>   regmap_read+0x54/0x78
>   rockchip_pd_power+0xcc/0x5f0
>   rockchip_pd_power_off+0x1c/0x4c
>   genpd_power_off+0x84/0x120
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
> Chaoyi pointed out the PD_VCODEC is the parent of PD_RKVDEC0/1 and PD_VEN=
C0/1, so checking
> the PD_VCODEC is enough.
>=20
> [1] https://lore.kernel.org/linux-rockchip/20251020212009.8852-2-detlev.c=
asanova@collabora.com/
> Fixes: db6df2e3fc16 ("pmdomain: rockchip: add regulator support")
> Cc: stable@vger.kernel.org
> Suggested-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>=20
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>=20
> Changes in v3:
> - drop tags
> - rework it for just changing PD_VCODEC(chaoyi)
>=20
> Changes in v2:
> - collect tags
> - correct TRM section(Sebastian)
>=20
>  drivers/pmdomain/rockchip/pm-domains.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 997e93c..44d3484 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -1311,7 +1311,7 @@ static const struct rockchip_domain_info rk3576_pm_=
domains[] =3D {
>  static const struct rockchip_domain_info rk3588_pm_domains[] =3D {
>  	[RK3588_PD_GPU]		=3D DOMAIN_RK3588("gpu",     0x0, BIT(0),  0,       0x=
0, 0,       BIT(1),  0x0, BIT(0),  BIT(0),  false, true),
>  	[RK3588_PD_NPU]		=3D DOMAIN_RK3588("npu",     0x0, BIT(1),  BIT(1),  0x=
0, 0,       0,       0x0, 0,       0,       false, true),
> -	[RK3588_PD_VCODEC]	=3D DOMAIN_RK3588("vcodec",  0x0, BIT(2),  BIT(2),  =
0x0, 0,       0,       0x0, 0,       0,       false, false),
> +	[RK3588_PD_VCODEC]	=3D DOMAIN_RK3588("vcodec",  0x0, BIT(2),  BIT(2),  =
0x0, 0,       0,       0x0, 0,       0,       false, true),
>  	[RK3588_PD_NPUTOP]	=3D DOMAIN_RK3588("nputop",  0x0, BIT(3),  0,       =
0x0, BIT(11), BIT(2),  0x0, BIT(1),  BIT(1),  false, false),
>  	[RK3588_PD_NPU1]	=3D DOMAIN_RK3588("npu1",    0x0, BIT(4),  0,       0x=
0, BIT(12), BIT(3),  0x0, BIT(2),  BIT(2),  false, false),
>  	[RK3588_PD_NPU2]	=3D DOMAIN_RK3588("npu2",    0x0, BIT(5),  0,       0x=
0, BIT(13), BIT(4),  0x0, BIT(3),  BIT(3),  false, false),
> --=20
> 2.7.4
>=20
>=20

--4zfusrcm7v6ffvo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmmmFWwACgkQ2O7X88g7
+prm0w//c/OObis4A9+I6pXVvUB0m0bE1+Jpj/1KGWaM9zA+Y7wpeE2w3GaWPdN+
UgbQ3oH/0+1QL4zZ173YeiLf8h7VqseZF+S2+6YzjWnDsEpWRBwncXrw5e0MoAPN
8L/QfhrxUOD4RDLo6rBVsA+p+y61+mEGJrNKwbTqXQn7EATEQnHzIGLcF7xIKIaB
HKiX0tQ5yspsZ3SsjeEkUfteyS2+t4g2CIoDbOv2s5gv+N4+Os2WdlbzOrew5d3c
l0NQ0wH/OOVmGR9U2YWg/tu/O65+BlXMpE7iXexJ0xynkYwzVRiTAiI8lDTJ1wbb
HivXw6EKQjbihbV9IWGkbfActInVuGVUAn494yyNBNr0F6Ro1r+JR2Fm4sDwBEHi
yH3ZAShn0sPmrxi0lZ4+5QD+PDtrkyBfYMAQXHJJwoWs8hf3pDZ8k2uJei5sjCne
QXmIJlalS3cv7Kxhq09V46NiMSFhB7aPweQUj8oZFTmIhXzQIPZMI/sp0zoi2Ztr
J9vmq1bNsyGI5hFIedF4ZJ5CilQqmSHbedzXEgVcJCRXAeqI0yQyTzL6L4+BJVg7
CVIQLNdXdI+FM89hITqgD3fYjhFXrlCelppNeSit9RtuOoJhaYbrS4MdkfbDj7FX
W592zfgPsMbHVkxj4AwGm4AOl6VVvCPtm7UAFFSP5iMQJeYBs20=
=Wz7p
-----END PGP SIGNATURE-----

--4zfusrcm7v6ffvo5--

