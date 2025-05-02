Return-Path: <linux-pm+bounces-26582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E75AA76A3
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 18:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441FF1B60F7A
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 16:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FAE25D1E2;
	Fri,  2 May 2025 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="Sc464KU2"
X-Original-To: linux-pm@vger.kernel.org
Received: from latitanza.investici.org (latitanza.investici.org [82.94.249.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AB025D53A
	for <linux-pm@vger.kernel.org>; Fri,  2 May 2025 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.94.249.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746201783; cv=none; b=PCLyf2n/lqjzAp4MBtmY0bApKjxzDHHLuK5BJvhW+UbhnLgBA3XmEnHASFTDygtXqVyFfH9336jvEuNmBi/YaIJzX6lRMGppzxJHdgvHKwEhPrmn/FlRxhoy72MAA2dVlSifny83UQOjYxx//bJa9B54xQbjq76yRrKHF/gv5j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746201783; c=relaxed/simple;
	bh=n9MnA6EDQUVkCtMFnmW/t68G+hDIePR/zVB3Pyjxv+M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=b00iMB5LHQdiFTHF6qXdMP1DYvsZzWy0n9Csm8xyxNyUQTwSKrdRT6Ad8+WxcYuWNRNaKU5oEFbGzd8GVjPVoOQfhNUxh+QMYn57Tv7kcxteocVZymXROlSfLmPhKqI8izV5Yrr9FAmv8Rl+MeZDe+zdrIRYN8DTZl7a7UmC99s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=Sc464KU2; arc=none smtp.client-ip=82.94.249.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1746201197;
	bh=QUxsE5bEO6W93B4rm2NI9zovG9ezevY7ueJzYfxsAF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sc464KU2LNXsC5dMdbqOG43vQezl/dcVt4spmoGBlSIBlUX9O2sn1onjenNOQ4j9N
	 SBrAdlbStKJOtSSeQTr5w6VK2ZVh4u3CB10I4bRUzA1je9pO5UW08LlTifZtVMqhDs
	 eLC4fHY1F+SQdNQdIIBLQ74M0RUOumZnM1S7Annk=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4ZpwSF260xzGp4g;
	Fri,  2 May 2025 15:53:17 +0000 (UTC)
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4ZpwSF1ychzGp3L;
	Fri,  2 May 2025 15:53:17 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98.2)
	(envelope-from <invernomuto@paranoici.org>)
	id 1uAshQ-00000000Vfa-0XxA;
	Fri, 02 May 2025 17:53:16 +0200
Date: Fri, 2 May 2025 17:53:09 +0200
From: Francesco Poli <invernomuto@paranoici.org>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: linux-pm list <linux-pm@vger.kernel.org>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, John Kacur
 <jkacur@redhat.com>
Subject: Re: [PATCH v2] cpupower: add a systemd service to run cpupower
Message-Id: <20250502175309.05e66d43fc2654afb01721fc@paranoici.org>
In-Reply-To: <aBE9ly7vP0eryfMO@thinkpad2024>
References: <20250425151024.121630-1-invernomuto@paranoici.org>
	<aBE9ly7vP0eryfMO@thinkpad2024>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA512";
 boundary="Signature=_Fri__2_May_2025_17_53_09_+0200_i0o6teC6v34e2eby"

--Signature=_Fri__2_May_2025_17_53_09_+0200_i0o6teC6v34e2eby
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Apr 2025 16:59:03 -0400 John B. Wyatt IV wrote:

[...]
> Adding my tags.
>=20
> Reviewed-by: John B. Wyatt IV <jwyatt@redhat.com>
> Reviewed-by: John B. Wyatt IV <sageofredondo@gmail.com>
> Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
> Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>

Thanks a lot for reviewing and testing my patch!

Do I need to resend the patch (without any change) with these tags
added to the commit message?
Or is it pointless?


--=20
 http://www.inventati.org/frx/
 There's not a second to spare! To the laboratory!
..................................................... Francesco Poli .
 GnuPG key fpr =3D=3D CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE

--Signature=_Fri__2_May_2025_17_53_09_+0200_i0o6teC6v34e2eby
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEygERR5zS79/7gjklPhwn4R9pv/4FAmgU6mUACgkQPhwn4R9p
v/4NphAAxDyoksTKG6jdCdNDus6tOx9vv5c6CZOmVDebwX7zL8+0K/MF98qHIZ5e
zdJ8e7/0rtun9C03nuzk5x91y1NrtXGyM/ISIaJkb++cows/G0zEa9txgbdcOzHa
t+jTPPTFsmnF+Qk4+C07GdKugbhG1G9OJGrrLS7wDMw952O58nXgrszejZrbvR+F
sM6vhTqZAo687XZw4q4DN5izJ7YuaQ0nxec82h1HzEK4UigyRjr1HXgdou7vCwD+
s6Vb3OeknNaeKkC84bqVBfakNFIbmiNGk71Kwp/0sfomYymMwIHOn9iRkR0EXN9o
kqiVTPlf2vnVYrYGSYGmAPbiIwKGAh1X5b6xKcnKOG/sEUw7h/6WfRd5Tt1SmZ5Q
wqGQGvXbaADy2qxlyCIYNCelB7vUClM+8/LiQWCPfOanKzegEjvEgqKcB8WrxDFt
wme7quGmPtM30V+25TcLVHjKV9WqbNPUT0Iou3scBcS1q/1gEsPJIEwfikX5bXTj
2uO6A6YQ+MYwJv22vYx91OJWDmchL+SkmPmqHUa0xHFBECVFeljgd/C8hH6HDacU
mkai76XXrVizDJZzqQoqCXJZLUFLqp2Q+IMuG/ma1fmKf3lBf2CyCovlwcNbEtDM
veatS+rFsnvQIhg9vh+8uul2BlRpyTxMMqiFFRin8+PfCEdZLSI=
=cLAi
-----END PGP SIGNATURE-----

--Signature=_Fri__2_May_2025_17_53_09_+0200_i0o6teC6v34e2eby--

