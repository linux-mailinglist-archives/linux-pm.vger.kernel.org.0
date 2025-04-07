Return-Path: <linux-pm+bounces-24887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF757A7E62F
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 18:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF6D19008F7
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 16:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FEE210F71;
	Mon,  7 Apr 2025 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0sYCwTk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F3D2080EF;
	Mon,  7 Apr 2025 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042368; cv=none; b=UZDUokaU/xGXp18MFGZzfzGmryOW7GC2/LjJjewagTi+7QwSlIu530vHG9GYmRLXOEvUB0kAF4bi3ge5Uo/GYOGqNXpeBbpntRisyXHNXh6zFVIIztLiikQrLSUJLSPOOEpsCGabsDC2s3lgCH20dLt/MOmejsB3z+sPQKNTKkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042368; c=relaxed/simple;
	bh=q+DM7mRmWOxkXvkh3aOXzbgwklXnaznMqTCzPvYOHbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3CEdjw1Qx6zCgDn3/ichbiCYbjg3KlXeN+1BKo6PXLt6+VeDRpMIQdqpskPfaxkfbC8mCLzOee+hyEPaCSBg8rvzs3XuCFiLzDtRAVPS+U9JWniggcYjck4/2id9wOoBrs67AvZ0KPWO5ZVC/a6tqr/DQcLcgS1dftp8/aGMmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0sYCwTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1427DC4CEE7;
	Mon,  7 Apr 2025 16:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744042368;
	bh=q+DM7mRmWOxkXvkh3aOXzbgwklXnaznMqTCzPvYOHbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C0sYCwTkOaZdQGWE5ZnS5AwS8Mau5AZfW6ET8TsQLoPZM3+MDOauEwGevLQJgGgkW
	 lm5swzoo+5+9sxh63pACe1u4ojD8+ja4TuoHZ+SPW9D8aG+U/lhLOUcrz1gdorjIh6
	 u4NSbQFPpZVuYJ7afxYHoSWSa+ZqhDCwzvaLCp36WVfmINf6RrdwZFUyLH9RXHc65A
	 P5TMOxWonDolpE6fmkfATv7sVxmDsqr9/r8bB3l1qPPgz9mh8uCNi9VS6Or7JclGj9
	 8oJ85KJgU8bE63EH13tpQrqlp1KiUZK/vujilnOw1ZZVsx4GdUgRf9vxNautKlN6iy
	 B4UnCVF3DKIwQ==
Date: Mon, 7 Apr 2025 17:12:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: firmware: add toradex,smarc-ec
Message-ID: <20250407-impurity-cornball-0a1f534f5bf1@spud>
References: <20250407114947.41421-1-francesco@dolcini.it>
 <20250407114947.41421-2-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JmEBwwK8bMXzn6Dv"
Content-Disposition: inline
In-Reply-To: <20250407114947.41421-2-francesco@dolcini.it>


--JmEBwwK8bMXzn6Dv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 01:49:46PM +0200, Francesco Dolcini wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>=20
> The Toradex Embedded Controller provides system power-off and restart
> functionalities.
> The two variants, SMARC iMX95 and SMARC iMX8P, have a compatible
> I2C interface.
> Besides this, different compatible values are defined to allow for
> future implementation differences.
>=20
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--JmEBwwK8bMXzn6Dv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ/P5ewAKCRB4tDGHoIJi
0u4lAQDnMq7Y/0H1ump4Uxo6/BIgrEqL9zrv0ik35Tyv+t7HQgEA4Uhiamuict3T
BNZNPwb09KqXJk62YuhBLMMk/IHMEAc=
=G/o+
-----END PGP SIGNATURE-----

--JmEBwwK8bMXzn6Dv--

