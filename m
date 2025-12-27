Return-Path: <linux-pm+bounces-39963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81224CDFD30
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 15:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 505603010AB9
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 14:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F80719AD8B;
	Sat, 27 Dec 2025 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="T/uH8xCw"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9371829408;
	Sat, 27 Dec 2025 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766845131; cv=pass; b=FEAjMon3j9XajQK8u/fZQE7yIAc9AJtc16yf7bNk6rR85XM+PIL+tvXHzTw9kMgXee+uQ2XEZmBcj1ooi/bvwD+pw5cmP+y4qF0q6NL9nUA1BYp/h8dvNceo5brgUHPq/ii3iSdVUefneTX1GS1/6MHIIq0rFsoyX/wg/zXssGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766845131; c=relaxed/simple;
	bh=0jbs1OT1KC+lQ0+DdOw/DBioVGjV567f3u4FKySc7jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcquqJppgYXm8vGcIfYWEkxuOGI+WPcVYN0mHA8qU7YypkeKKVRiqKOefYCVsY4vaxGor2+d4xqwu25rp2MAd7nXyNDVE8EzcDXuDO6K7sAB/862cQb71g/uKCVVPavsGf+4Lly5sG7Q807sAnEeKzQbpg6OIAp5XFiRNT3H4n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=T/uH8xCw; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1766845103; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eDg/NV5QmLF6drR5YDRbHhvQ9FDyRHpz4d5c6HlLfgYikZA+HZFPlSlBdG5XQHQ7X01SSe1TG+wNtRrs9NSXT7xDhqhHnPlJu94kMZcMcLqgL2GEIU9+gdUycskBjaC3elRUnzsa3zDqxsUVJ1Tg/BUH8L7iNq76W8XIrkZGyLA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766845103; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jzRjZmKvJw7I6a7ENB3s/cl9OVpEExAn8hbMD8cMxPw=; 
	b=HJC6DGMO2cMLbEc0o3fitCP7hrJrlkXCdJE9/d7NhOEodY6qTiuiCGSeXliNl+Px2WLKQFFPequLUsLttqQpRAbwQ/oYxaTCaEersqsda5CkyAUnJNj+6CyYq5fjDSV9uN3Gf44elgwNhF3Y4hraGcY0QQ+XuZel8mND2SZiCmo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766845103;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=jzRjZmKvJw7I6a7ENB3s/cl9OVpEExAn8hbMD8cMxPw=;
	b=T/uH8xCw2RLYlj3KxDCLxdKw2jdwYAZcK5WXp1DaILV+E0cW9TGV0XS1P9FPll2T
	5ElwNN6noixwH4Pq8CbPeb5GSTzmYid+ce0u8++f1GyzlpZ/Xb7qi/yuMC+8bfflx8c
	rX8LLwMT1ePljlzIVLJn0khDFuRKzx2UVTXGsshY=
Received: by mx.zohomail.com with SMTPS id 1766845100660199.61711369774093;
	Sat, 27 Dec 2025 06:18:20 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 814AE1803AB; Sat, 27 Dec 2025 15:18:16 +0100 (CET)
Date: Sat, 27 Dec 2025 15:18:16 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v1] PM: sleep: Fix suspend_test() at the TEST_CORE level
Message-ID: <aU_p-0fVKR7z-vtH@venus>
References: <6251576.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dvxkgxpxo3vjgzfp"
Content-Disposition: inline
In-Reply-To: <6251576.lOV4Wx5bFT@rafael.j.wysocki>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.5.1/266.841.63
X-ZohoMailClient: External


--dvxkgxpxo3vjgzfp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] PM: sleep: Fix suspend_test() at the TEST_CORE level
MIME-Version: 1.0

Hi,

On Fri, Dec 26, 2025 at 02:50:57PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Commit a10ad1b10402 ("PM: suspend: Make pm_test delay interruptible by
> wakeup events") replaced mdelay() in suspend_test() with msleep() which
> does not work at the TEST_CORE test level that calls suspend_test()
> while running on one CPU with interrupts off.
>=20
> Address this by making suspend_test() check if the test level is
> suitable for using msleep() and use mdelay() otherwise.
>=20
> Fixes: a10ad1b10402 ("PM: suspend: Make pm_test delay interruptible by wa=
keup events")
> Reported-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Closes: https://lore.kernel.org/linux-pm/aUsAk0k1N9hw8IkY@venus/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

I can confirm it fixes the issue I reported, so:

Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  kernel/power/suspend.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -349,9 +349,12 @@ static int suspend_test(int level)
>  	if (pm_test_level =3D=3D level) {
>  		pr_info("suspend debug: Waiting for %d second(s).\n",
>  				pm_test_delay);
> -		for (i =3D 0; i < pm_test_delay && !pm_wakeup_pending(); i++)
> -			msleep(1000);
> -
> +		for (i =3D 0; i < pm_test_delay && !pm_wakeup_pending(); i++) {
> +			if (level > TEST_CORE)
> +				msleep(1000);
> +			else
> +				mdelay(1000);
> +		}
>  		return 1;
>  	}
>  #endif /* !CONFIG_PM_DEBUG */
>=20
>=20
>=20

--dvxkgxpxo3vjgzfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmlP6qQACgkQ2O7X88g7
+ponhg/8DFhgtSQ9njudkn1alyQjlWQqEOFYqevvSV3QmMHRfP3el+TfwteArYOE
SFkG3q9W2nqkP2yOQ6Zk6e7FXHZwVTZD738DY+aUPIMrnw/sx8cGol4iEInGdLRR
XJLVk0d8sIn5D3ZlMkvw+Q1Em6XBb4jkXQJMD0MHuowrUCFB18WFNilviI/EgPWJ
q/2XLfhLcc3lQdTEHIAEcimZjfWKEoSZ/jHEDHtuSoNn29rSBmcrecdmYI2kOklI
Dsg/Ib4vjms7l0X+DbLHNu9BkFCoVtVLadOXPePZL9tEp+nljzuhBVEvVYW05ov7
vtBIY27HdmxiWSXaVQfjGovRbnoXghJZmtQFRhFQO4pgUXIHdA01A2auynaGsimp
E6I5ar35GZnOIQ8D/biMZE0eXNWZaP+7ZmFNvWTO6OoylK6UhMHZOeFV7rvF5tVB
MoIeL/gx8XQy5jmB3BPiHxhGr0G3r1EBajWreYzTNnlgrDTAXeFY7GxPtdU9zwNS
iod+3bPI0qVWe26EFM/uY6X8Jdb4tKosxDyY3RkYzuwpynrRHxmvZW16/OqTdEXY
4SmFYssYmHhTXnt2se8qwO4LTIBdmBzBQb1d+iOpaRSx1QELpvPSVIvNcHlGjd2Q
7TKVHTXk0im4i8Rd7I+actOVkOU8K7l6m/+LNLJhJatMpEFgCtI=
=7Rj5
-----END PGP SIGNATURE-----

--dvxkgxpxo3vjgzfp--

