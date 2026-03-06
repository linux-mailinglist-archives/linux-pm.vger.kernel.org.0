Return-Path: <linux-pm+bounces-43821-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIA+FzzZqmnmXgEAu9opvQ
	(envelope-from <linux-pm+bounces-43821-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 14:40:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E16AE221E6C
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 14:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FA5F30371B5
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 13:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB3230146C;
	Fri,  6 Mar 2026 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEvm5BoX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA32FB97B;
	Fri,  6 Mar 2026 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772804369; cv=none; b=fKdKu6WkVtThTCzmeTFrvsYxV/JTVXdL2pThsJ3poa6USYU49SA5fJG3zBkMnGjUfDD0ueJVOAUaQmd2T9XaJ/UgG/EejxbN96exfvjBvwWs3Zxv2HCC8gej8TcWAaAcg6U5F5TlLRvuKZmGWnRCIOBo0wkTZQOMvNI/kuahU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772804369; c=relaxed/simple;
	bh=yp9JKJwekBl3X/p7vYFCWBZxq4g0m+lKe535L/neXTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etZnYy+lFF5YtSD6xSPT5Wd/E5JEEgX/PzqPJ4YVODi8SWJAWozZ3UeLEv5Xxbg6XCOvcpETpuMu801z9nijvig37BUYH+qtje9fPzjWJHhOHTR3OsKs0Db+YRjVVxaqoUCRCdjIIBN9yIiBd3w2GAqTCniKeGctZGld69SyfnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEvm5BoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F157C4CEF7;
	Fri,  6 Mar 2026 13:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772804369;
	bh=yp9JKJwekBl3X/p7vYFCWBZxq4g0m+lKe535L/neXTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uEvm5BoXyv/LFpQT3n5YUNgujXHbWvoak0Eiet3hdhpm00WSIEDG49yVSCT2WkKaR
	 AehUdHpIQL8uh2CLiSi7fR0mZi+WMfwjZZ6Es9gYkWq7PTrSDKzDdp3CbtyT6ZadGW
	 VSYO9xmxDqa5fbayjbTq4t1fmRAhjjuXFa1utH6I1xl0Ae1eFWpwMsHSld8wsFzh7c
	 uf2sfi/BTgUB6bO1MXDlNFSqcRWDA8I41Da/AAf8M7swlkB1V6uGym9eIcyHuhX54B
	 CR4NdVWZsCNUFK9UYM2yrDrvBc9qWgFjv9UyvEX36AxxGPWBsJL1YHHpZur9IuE52Y
	 qvpDitPo+KKVQ==
Date: Fri, 6 Mar 2026 13:39:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 1/6] regulator: dt-binding: regulator-max77620:
 convert to DT schema
Message-ID: <785a137c-2d8f-41ef-b537-4c330abc7e1d@sirena.org.uk>
References: <20260306133351.31589-1-clamor95@gmail.com>
 <20260306133351.31589-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WcxGa8/M4I7S4FLg"
Content-Disposition: inline
In-Reply-To: <20260306133351.31589-2-clamor95@gmail.com>
X-Cookie: A nuclear war can ruin your whole day.
X-Rspamd-Queue-Id: E16AE221E6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43821-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,intel.com,arm.com,samsung.com,bootlin.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sirena.org.uk:mid]
X-Rspamd-Action: no action


--WcxGa8/M4I7S4FLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 06, 2026 at 03:33:46PM +0200, Svyatoslav Ryhel wrote:
> Convert regulator-max77620 devicetree bindings for the MAX77620 PMIC from
> TXT to YAML format. This patch does not change any functionality; the
> bindings remain the same.

Acked-by: Mark Brown <broonie@kernel.org>

--WcxGa8/M4I7S4FLg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmq2QkACgkQJNaLcl1U
h9BTpAf/VQhTXep1Z1EZxraHM79qPPijBRsRSB/oeV1gK4szOZuDLChY0Y+NnWFN
HiEjSfxi/0H5uzm9n4igEyugcvZnqEDgpFC/vy9+pnlzSSCi3UfR2VXtaopB7R55
60MFQXvPuANz8eHssk8J0tQNLmeWPwTQKwAl4CSw0xknE541I+8JKIIwzqLhl4wX
YAY0Qv8eM1LkgPLRj17PO4tCLFa1ZYZLtT+SWW/7tLyuKco6U+dU4TnkZgWVUSTR
0uMqydmzgpsolDV+YSHndMxnL0g8qe8iJHxpKkmwWBNE+9dYs8dg0hsOrhjmQjSN
1iBpwcWCk5gut4X4zLPcK7//VixyBw==
=EW9n
-----END PGP SIGNATURE-----

--WcxGa8/M4I7S4FLg--

