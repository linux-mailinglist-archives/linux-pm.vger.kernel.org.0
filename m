Return-Path: <linux-pm+bounces-27532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9551CAC16E6
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 00:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10A937AF1AD
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 22:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C15280010;
	Thu, 22 May 2025 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="jlw1yAFC"
X-Original-To: linux-pm@vger.kernel.org
Received: from latitanza.investici.org (latitanza.investici.org [82.94.249.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF07619F11E
	for <linux-pm@vger.kernel.org>; Thu, 22 May 2025 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.94.249.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747953468; cv=none; b=atmhfqHzPK4Ut+oO0IvgDF9Jjw3C8onC3fCYL8AkiJVGDDvbKqIquPnjvXnPDsKwq1/IAjSneUONd1aZ/EZ+vdbe0S58YImNCsyT4SK2t9qDxFRa4NykScxPljj0b5m4Ni0e1me9vyBpYUFrhKev9DU29gqUP4GFvfyXOI+X9N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747953468; c=relaxed/simple;
	bh=K6M6fDRdPz23hc29y8yTUCcQsvBECwfgHWHy8kTXUMs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=n3QXg1og5BIMmEPaIFZo5UmKsAgZNImNQWe9cmbw2Duu/hgR4NcqVDBSHLd+fvBcxUy+tgHH9dAQZt1nQ6cp9SXIunWEg/I3TjtaAQNOtnh7l1cY0W+LGOcNmL0BrVsKfKq6YCLQtzReiVowtpqLVqs7OM/TlK5ed5Mc0lBXwSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=jlw1yAFC; arc=none smtp.client-ip=82.94.249.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1747952968;
	bh=E83lc7uFLbY6u8k7hQkO9OWOsJcfxy4DrzcY1ImGmTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jlw1yAFCWPmTBbL0jNqGHDU04cdlGhAsxo5KNRMs0je6JfbRej2PDrKfo7Smyh65w
	 hoHujehB6X/NLqRLesgDa5DZeLYncl8ym+JS96wiViaMf4j7T6EbixCy2SRRyac08k
	 E+1/YleH++FrbAQHJEoqSaiOoUhbb2w0Yi3BTnkA=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4b3NJ81vGLzGpND;
	Thu, 22 May 2025 22:29:28 +0000 (UTC)
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4b3NJ81hNhzGpN7;
	Thu, 22 May 2025 22:29:28 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98.2)
	(envelope-from <invernomuto@paranoici.org>)
	id 1uIEPn-00000000QH1-0Tpn;
	Fri, 23 May 2025 00:29:27 +0200
Date: Fri, 23 May 2025 00:21:13 +0200
From: Francesco Poli <invernomuto@paranoici.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: linux-pm list <linux-pm@vger.kernel.org>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV"
 <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>, Justin Forbes
 <jforbes@redhat.com>
Subject: Re: [PATCH] cpupower: split unitdir from libdir in Makefile
Message-Id: <20250523002113.ca1ff066061da6049721c275@paranoici.org>
In-Reply-To: <6deefc69-856e-44d7-b970-2f0127090539@leemhuis.info>
References: <20250521211656.65646-1-invernomuto@paranoici.org>
	<6deefc69-856e-44d7-b970-2f0127090539@leemhuis.info>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA512";
 boundary="Signature=_Fri__23_May_2025_00_21_13_+0200_1.gXPbjlQiderwXc"

--Signature=_Fri__23_May_2025_00_21_13_+0200_1.gXPbjlQiderwXc
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 22 May 2025 13:43:49 +0200 Thorsten Leemhuis wrote:

> On 21.05.25 23:14, Francesco Poli (wintermute) wrote:
> > Improve the installation procedure for the systemd service unit
> > 'cpupower.service', to be more flexible. Some distros install libraries
> > to /usr/lib64/, but systemd service units have to be installed to
> > /usr/lib/systemd/system: as a consequence, the installation procedure
> > should not assume that systemd service units can be installed to
> > ${libdir}/systemd/system ...
> > Define a dedicated variable ("unitdir") in the Makefile.
>=20
> Many thx for doing this!

You're welcome!   :-)

>=20
> Tested-by: Thorsten Leemhuis <linux@leemhuis.info>
>=20
> Nitpicking:
>=20
> > Link: https://lore.kernel.org/linux-pm/260b6d79-ab61-43b7-a0eb-813e257b=
c028@leemhuis.info/T/#m0601940ab439d5cbd288819d2af190ce59e810e6
> >=20
> > Fixes: 9c70b779ad91 ("cpupower: add a systemd service to run cpupower")
>=20
> There should be no blank line between those two lines.
>=20
> And you should use
> https://lore.kernel.org/linux-pm/16ad2364-0161-4724-90e1-b57559168843@lee=
mhuis.info/
> as URL after "Link:", as it is shorter. That's the URL you get to when
> you open
> https://lore.kernel.org/linux-pm/260b6d79-ab61-43b7-a0eb-813e257bc028@lee=
mhuis.info/T/#m0601940ab439d5cbd288819d2af190ce59e810e6
> and hit "permalink".
>=20
> Some maintainers might reject patches due to such aspects, so I thought
> it was better to let you know this before it causes trouble sooner or lat=
er.
[...]

Thank you for this nitpicking, I took note and I will do better
next time. I really appreciate that you took the time to report these
aspects.

Bye!


--=20
 http://www.inventati.org/frx/
 There's not a second to spare! To the laboratory!
..................................................... Francesco Poli .
 GnuPG key fpr =3D=3D CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE

--Signature=_Fri__23_May_2025_00_21_13_+0200_1.gXPbjlQiderwXc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEygERR5zS79/7gjklPhwn4R9pv/4FAmgvo1kACgkQPhwn4R9p
v/6uoA//azTVE/0BnSkqnsgFlgqkdFF9w+Z+dg43OoLpCqQCmwhAeTa++CFbn9un
oh9BQQBZeAa202k6XmoMqulXnVvmes7BFG3eV49kmLxDgjL0jlHW+5Oc/n5Xgodx
5P25fM+x88vWNh+41u/p5155GuqXCVYhq4Zrxf9LTZ1B4zaBJxvaUArBhJqey8Cb
tV5zfmensgoF1w1n5ea8NgJcNKLCGytm4SWOBpAyM7CAWPzWuc47beVugrl/CTZG
IpU2AOd9h8yUdtuTdtOrORyHu4q3qxfgaal3cQpDqn6G0phSTga60tiprNhdvbK3
CrgqKV50uyJf8IEJvkt+6OTQAAUYxT4lRR6XxVN704h8XmATf/YONQ7DQYWrPh1A
Fa8vpDHNasj62DlgItR0K2CGyBEwpbZRDFtouJJnzcoLucMPMkXQfoP7UdUwjwbV
3LHibnCrLnFVWJz3GYPumMsW+ymmGtxavz0LHlguRPOQ43p5BVTtPcGQUKdQPgCG
2Sv110SoRxr3Q2+axb9DzIuxqiQG9bxL6XvLjBUiw4GcJtk0fVpx4G5aiBE3ncva
yI0V735VrxZ+UFXeoTDBm9Tu7Ew/mJT7KMuKmmiPHfvBaBMuJK7Ch3gyydRcS4OX
3fuz9pKE6z/1WT6g+AVwU6BkgC3d0CrG+zqi36ew21vZ+w3LrPE=
=xI1f
-----END PGP SIGNATURE-----

--Signature=_Fri__23_May_2025_00_21_13_+0200_1.gXPbjlQiderwXc--

