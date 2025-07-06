Return-Path: <linux-pm+bounces-30231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CB9AFA86B
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 01:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B47189AD8C
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 23:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C041F8AC8;
	Sun,  6 Jul 2025 23:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="S5i+tdZV"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F01919005E
	for <linux-pm@vger.kernel.org>; Sun,  6 Jul 2025 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751845013; cv=pass; b=usKvI+DlyrL14F19HLA8vOKIfUpN7js+yRmuAtEVvIMGoQilrYZdM+bnHiXree/i4dcSVENThcZ5qFfYDmfKpzfO7TWklMWziCMT5tISNUS1R3vU+kmjPRJyDR79bzPMOjCxGbK/FMwj2IRjujCNYRCiH2ubhWRDV7F3QnjWy3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751845013; c=relaxed/simple;
	bh=ut6MmXusWWSmcEU4wG58lSpJgjtseEk8JQVBCFgglAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4CXh7BFDPhG1f4f8kFm4Ys3yYs5fzxStzg7aG0weWptDWIiUeRpnul7+dx6zOvWcUP0NBrJJ4JqbKLmPIc/OyxD65+LObV37r8rdVEZZA7rr6w452YY+45XxKGC2HyJ/Ngegb2YpQkeUlujg2ctiKF8ZHPj01jWLwmp1uvqvBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=S5i+tdZV; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751845005; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TMyC6Nj56Gm7JicCJh1VG7W/GzxxYdXBrwKlBaZTQPILusFudy1G1NcUtFU5Dlez0WBYM/M1JAC+S7452uodi6sAkKUYGkojeKlGr1Fn4b/bSe1Rcb9OpwIlIv77KK5fpQI/PSDKnVdGG8H9smdPfvRx4HBfwksic+5gNMiJp5g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751845005; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ut6MmXusWWSmcEU4wG58lSpJgjtseEk8JQVBCFgglAo=; 
	b=fuqEZsxAmtw2vGYWFIgQiNkjp+V2eE3uKSOT/VDeJx7GrFN58O/LrbJOnj3OQR5mdNq9mkXFhIJAR/pyXANu1kI17nIU1v1cSJGbgVNsbUPmGBbhQPynFHYoqnb8XkC8fO/OSzKLqyjMPRT4MG4Z7p4SBq/c25qVbuy/FBZdpT4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751845005;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=ut6MmXusWWSmcEU4wG58lSpJgjtseEk8JQVBCFgglAo=;
	b=S5i+tdZVkV9vJHLlvHN/xmibsHt5zzKYxvoOtqEu2Q/SJ1nSPit1+3eT7c4prlLG
	VoknDHIK8zMpK5Uh5yHPs9tVb4Cq1UCEfVTqIzvsewh52pK+PxGpPQH2vJFDz++fwfO
	w5zaivTayjsOQ57HX1BMZPmDK55rIxTD9DNSy78c=
Received: by mx.zohomail.com with SMTPS id 1751845001907173.35088717664098;
	Sun, 6 Jul 2025 16:36:41 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 20362180F14; Mon, 07 Jul 2025 01:36:39 +0200 (CEST)
Date: Mon, 7 Jul 2025 01:36:39 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Mark Brown <broonie@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH 00/10] power: supply: ug3105_battery: Switch to
 power_supply_batinfo_ocv2cap()
Message-ID: <cyhxxtweyya7yc5vmjg6trpmia4wtzsqxhwcgdh35p63hu7oja@4vjoryxaopq5>
References: <20250608204010.37482-1-hansg@kernel.org>
 <175055104892.226297.388983002573981633.b4-ty@collabora.com>
 <cql7vri3yyk3fl6y4rrmfbj6ca75gv3y2hap5as4ulcefjenwg@jlebnndhe65x>
 <aF3YYgw-GHpjepSs@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ue6gog4mxtbbt547"
Content-Disposition: inline
In-Reply-To: <aF3YYgw-GHpjepSs@finisterre.sirena.org.uk>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/251.827.75
X-ZohoMailClient: External


--ue6gog4mxtbbt547
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: (subset) [PATCH 00/10] power: supply: ug3105_battery: Switch to
 power_supply_batinfo_ocv2cap()
MIME-Version: 1.0

Hi,

On Fri, Jun 27, 2025 at 12:31:46AM +0100, Mark Brown wrote:
> On Sun, Jun 22, 2025 at 03:09:05AM +0200, Sebastian Reichel wrote:
>=20
> > I obviously also applied 1-7, but without b4 as that required some
> > manual work to prepare the immutable branch for regulator and
> > squashing the fixup patches :)
>=20
> > Here is the pull information for regulator:
>=20
> Uh, JFTR I hadn't actually reviewed this - there was a !fixup in the
> middle of the series so it looked like an obvious missend and I just
> binned it.

oh sorry, Hans' patch series was based on a much older series from
me, which has been pending for the last two kernel cycles. I somehow
misremembered, that you already Ack'd it, since it was so trivial.
I should have checked before merging this.

Greetings,

-- Sebastian

--ue6gog4mxtbbt547
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhrCIYACgkQ2O7X88g7
+prcKQ/9G6BBIJ/46xxKeC7UwZf333hB86X01IYr7w9830F4iKRqx5gnct4iCHQh
obWJaCSXU4Mj5AaBmOkdxpQxjtTWtYJqAbI75eP5jMhRWo6r85S6DSNN+LlY3uBI
0WGfLEV4pLXd90GOVpcJiHsxVHHAZ22DUxzbTw9pfbaeFnvdFHZ3jrjPJQFPiao3
UOdSKqDyg9EUEr8/3lAj/3aYoqaApp5WjDKtHNY47XV/hGlWgLYbd1v7EtaNRcc+
JNOXPlcYT9blJQXGgt9piNFugGtcUxGIL63r0M4YPNgno/Grmo+Jjd6ub1yO+Ffn
qYrgQAPg4QtbgMw7azEULHWdQ572WV089HOcTBJceiRQGAl9leQZdF2+tI2lFcrP
bh2MRTmyPoGayoSHAextXy12iv2ShJoot7VQXwroVZOw2g8GdMD35IO7zsx7oZ2M
OvSXX/AizR3DpelqcCaW3yNsef7QAUNGwPsRilpmK+40G0HUAQ/AVuah1SPN2s+w
lExlh4IoZTz31VoV2FReohxsuzbZHdtATaMv/ivkoM0ICXcCr+QYSmicPwoyDUKp
Y1Mv1gFTgRyhVa9208MrN+RJTkYiQgoX1NMO4yehS7nAUUZ0pVSN6k8S1uTUSlhL
osj+xS9Id0fF8opa+DIcmIszmzUKisFJ+WXvjdt7U9vPjaxAXek=
=xrdj
-----END PGP SIGNATURE-----

--ue6gog4mxtbbt547--

