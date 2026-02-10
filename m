Return-Path: <linux-pm+bounces-42453-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJHyIUg3i2neRgAAu9opvQ
	(envelope-from <linux-pm+bounces-42453-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 14:48:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E038011B675
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 14:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54221304A328
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 13:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4408027CCF0;
	Tue, 10 Feb 2026 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4GDjjMx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F69D274FC2;
	Tue, 10 Feb 2026 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731181; cv=none; b=gRdVocXFxbb1Kxj+EI/Ayd54phMoGGU3zmThjnWsWyuo0HGEhk9v3aT7CAiiN8XjRSbhX2SGHjAfYfrVlq1izydyXzxFiV93DZS7yx1j/lH64fTeQltBe/nTR0a9r8q+ipOLlsTKkkjP9yg+W4DMbLlpLCnKm4qa0fT65moZyqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731181; c=relaxed/simple;
	bh=xIaQ9mE9WjsV1VOYv4AKH7JPw5sBhHo25m45P5YuLnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3eShUEC82ZU9XGF3B9tjbTCkLOz8shAE4R0AZfdVJBnPt492Cz2zthmbTZTjit9MTg3XCHivGK1cgmWQtZ2HEZnOmSOmxWNqnYPXFsYsDYiBDs0VJAO/S/32/6+bYyDSMgM9Hy7KWWHL/XDby6WROayaGjJsWFiohoH9WHghUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4GDjjMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E451BC116C6;
	Tue, 10 Feb 2026 13:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770731180;
	bh=xIaQ9mE9WjsV1VOYv4AKH7JPw5sBhHo25m45P5YuLnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A4GDjjMx9ExKObk//2ynhkUbzHEc8JT53zI0gYJ5qUL6cpwAj0IwBtuFouObf8qnQ
	 oSwMhHcvGJ2+g7P+5KPatHDXSekFVce9ad584Kc/u3eHiWeh9tsF4AH9RvIyuGKzr0
	 5hT5mE1EeLqEHRKRw0trUTwp23RRqNnIDC5wemF0CdyQ2Rq54GBNrR2mUcOxg3fwEp
	 M9PJ5LYq5G8BruPPS5aWglIIQ7thDxbO6X7BPxH+6Q2QCnyNimskjR5mo5FT5Xy8Hp
	 hE0lxFinbvHjJGppAc7GfRUrdY4AbpGOjj4CICWSx1NbNU/UWXU0es+vynEmShNRiF
	 ot+xJoHCH8P9w==
Date: Tue, 10 Feb 2026 13:46:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Adam Ford <aford173@gmail.com>
Cc: linux-mediatek@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Laura Nao <laura.nao@collabora.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/5] regulator: mt6363: Fix interrmittent timeout
Message-ID: <0d1dbeb1-68b5-4b1d-a07d-10f8bb47c105@sirena.org.uk>
References: <20260210053708.17239-1-aford173@gmail.com>
 <20260210053708.17239-4-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+IzQx6Pjw2gHNQNh"
Content-Disposition: inline
In-Reply-To: <20260210053708.17239-4-aford173@gmail.com>
X-Cookie: Spelling is a lossed art.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42453-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.infradead.org,collabora.com,baylibre.com,kernel.org,gmail.com,linaro.org,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: E038011B675
X-Rspamd-Action: no action


--+IzQx6Pjw2gHNQNh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 09, 2026 at 11:37:04PM -0600, Adam Ford wrote:
> Sometimes, the mt6363 regulator would fail to initialize and return with
> a TIMEOUT error, so add an extra instruction to wake up the bus before
> issuing the commands.

Please don't mix patches for multiple subsystems in a single series if
there's no dependencies, it just makes it look like there's dependencies
and makes it more complicated to get things applied.  You should also
supply a cover letter.

--+IzQx6Pjw2gHNQNh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmLNqYACgkQJNaLcl1U
h9BGZgf9GnEYtgwFfeWahWxOc9AG8aitDWEbX+AJrF/pojwMi6gx3YagpFAspqI0
2hHMTFIbbWRI67L9BCM5ETXn/MKFrJr6IxfpMI7+Q6gVYKiWAGlHUmCzQ0FfiBy2
YHsAVdWVj/ZIiLJB5Riwx2iPBYHFgv7bu8jWsMilz6U2vGSQDSiPjYq4jXb0kSJm
TqY8to2aMwY4wOeaF10k5zFHdqoLvVfInytKQWZ/LDHjzXI29x0elTdDNfilHtDK
rWjTWy0oPDqK1gKI9/CN2ZiD3lFfMy1NYyntf3C9NSOgGhZrIYmcc/RtC2ujwP2P
rchKSyFTT4qJVxQU/irY7eD8sdIOkw==
=krKu
-----END PGP SIGNATURE-----

--+IzQx6Pjw2gHNQNh--

