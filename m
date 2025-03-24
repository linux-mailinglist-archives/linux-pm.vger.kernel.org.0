Return-Path: <linux-pm+bounces-24458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86F2A6DD63
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 15:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF841882FCF
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2594225D536;
	Mon, 24 Mar 2025 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="TF7D20An"
X-Original-To: linux-pm@vger.kernel.org
Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB91C25F7BC
	for <linux-pm@vger.kernel.org>; Mon, 24 Mar 2025 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827782; cv=none; b=K6uo7IpPgM0UqBEL0mCYPl0bRk8caBouFEUGz5+CSKpLlxlKdg3f7Am0K02mzjNmc+PNrG0ftHSqAFuj2wCYCpkW2I7JrtFeDFdlrjOVWx2OVsNC7mGPOwelfOV/t4ZkBGjcA+s/TlqoNRtem6ci1yOyuggdLnO+w39I64kysJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827782; c=relaxed/simple;
	bh=4Bkx80EoyjanVtkC6e4fqLhmeJp14LvUdbINeWaGlhk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gkevy/iulRiJrbNJK4FFRv+IFMnf7FmiNCfl94iG2rBhRb12KXno6dGHrnG1w8JkgazEJtJJAlzzyMTTl0G1GZzC/QPO7cWmhvjsnepnmzeKShwNGzBTeDIYbQqgDurR6DwNWH5vSnxegTtQatTOLTl98rnNFCSoXGNDfkY5D7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=TF7D20An; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1742827384;
	bh=d/qv9SzNMP44v1ww6E+eqzu1hpeaSjpmsHfu5NyxdyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TF7D20AnZxSESbvaLMKYNTxbIHKUmdQN0RxexEi1WRfzF6uW+amn8k/ifznl3CClo
	 kICALpa0AbOQQyFlTOQzaK0hm+Kvihvum3PE5vZtZ2vhJMQlp8RiAQIa+c9/jkpcQu
	 msDQsH1UkfK3lncsuD0OIQY6BLgR5+Td7mNZUc0A=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4ZLwlD2CDlz6v97;
	Mon, 24 Mar 2025 14:43:04 +0000 (UTC)
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4ZLwlD1vgzz6v94;
	Mon, 24 Mar 2025 14:43:04 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98.1)
	(envelope-from <invernomuto@paranoici.org>)
	id 1twj15-00000000EH5-01UE;
	Mon, 24 Mar 2025 15:43:03 +0100
Date: Mon, 24 Mar 2025 15:42:47 +0100
From: Francesco Poli <invernomuto@paranoici.org>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: linux-pm list <linux-pm@vger.kernel.org>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, John Kacur
 <jkacur@redhat.com>
Subject: Re: cpupower: systemd unit to run cpupower at boot
Message-Id: <20250324154247.7fff2ca1c0df263c16a0f397@paranoici.org>
In-Reply-To: <Z-FQwMuVf_p7FoHn@thinkpad2024>
References: <20250322180357.1c17a180f1808533de77f186@paranoici.org>
	<Z-FQwMuVf_p7FoHn@thinkpad2024>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA512";
 boundary="Signature=_Mon__24_Mar_2025_15_42_47_+0100_YUjcKFIf7Obr2u9G"

--Signature=_Mon__24_Mar_2025_15_42_47_+0100_YUjcKFIf7Obr2u9G
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Mar 2025 08:32:00 -0400 John B. Wyatt IV wrote:

> On Sat, Mar 22, 2025 at 06:03:57PM +0100, Francesco Poli wrote:
> > The attached files are tested on Debian GNU/Linux trixie (current
>=20
> Would you please submit this in the form of a patch that we can apply
> to the tree?

Thanks for your reply.
I can try to submit in the form of a patch.

>=20
> Please read (note the no attachments):
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Wow, long document!
I am beginning to read it.

A question: should I base the patch on the mainline tree
<git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git>
or should I clone another, more specific tree?

>=20
> We do this to easily be able to comment in the mailing list and make it
> easy for others to review.
>=20
> > I took a look at how this is done in the [Arch Linux package] and I
> > enhanced/modernized the systemd unit (the three files in Arch Linux are
> > released under "GPL-2.0-or-later" terms).
> Is this an issue Shuah?

I hope that's not an issue.
Please let me know as soon as possible, if it is!    ;-)


--=20
 http://www.inventati.org/frx/
 There's not a second to spare! To the laboratory!
..................................................... Francesco Poli .
 GnuPG key fpr =3D=3D CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE

--Signature=_Mon__24_Mar_2025_15_42_47_+0100_YUjcKFIf7Obr2u9G
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEygERR5zS79/7gjklPhwn4R9pv/4FAmfhb2cACgkQPhwn4R9p
v/5LuQ//TERTVwJ2P+14SzSvHJpUj2bKwXJvOHnsO0V+6yvjCr437X8pdVx/3pRS
3g6rQ6u+etBbPSHO/iuIgzKNZVMUJ5Wxnbqhor8/jBQTCUkohCYje+azJ0gLorVR
Dum0j8T1PAK+LMG8ZjwzzC/FIdQBuCOFqW/IXxuOwAWfNOMbzwxCq+ypnmufCJ24
JknvPmYSIfIwiSDQ6kiEuNCjPx1ihoBj6WE4YtknrUqg2AKXmH96TrWUCOUWO38C
Nj1k4zHwMlSkYr1+7JhlyLgs9ooOXMmyzeQZVOMZRhPacFlJMkJP7bKVZul+e00e
7GQbDG5Ki4+nMZrLuIaLXrkhh5tssziWN+nhm39wxfye8n/+w4tFFD8X1iOg6fX/
XUlNCqYIAy449rogNNPDzkj6Y6hT4HNTdoOsEEVnRcuQBPuYZlPYTQDcHWkxt1iQ
CErhb7YnAXwlmZAV5fIyVKPn4tglRYL2sVM2thwmpvrM851g0yuzdv87lB8JjCno
4YDBTkann2sh4ifW5TpEdDW5qOBmjrzGCQLZ0jFU9I5m5XogekS2f86a6kIq4DKl
Gs/7xozzQ9a6Mr6aL3vpDTzlTa9l3wH52HYrWIQRpBxV+6BP3sILIE7JygXKrk04
ACWgUOr6iY5YmDxJAZecCkG44ZMDnUhO00B13/zoFjz4tPGafb4=
=1D3N
-----END PGP SIGNATURE-----

--Signature=_Mon__24_Mar_2025_15_42_47_+0100_YUjcKFIf7Obr2u9G--

