Return-Path: <linux-pm+bounces-43430-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C00CwK8pWn8FQAAu9opvQ
	(envelope-from <linux-pm+bounces-43430-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 17:34:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E017D1DCEF5
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 17:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66D10307BA88
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 16:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B368C41C0BA;
	Mon,  2 Mar 2026 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EECPcWKZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7D63FD13D;
	Mon,  2 Mar 2026 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468900; cv=none; b=a+5fhvTMsRoUe/LlEuTmjgb+X04lQ8oeOANv7Z94BL4Z2U1+ylx5JC5EE2b6OgrySKhB7vS98Sq6oZqZBDwhAzLob0l9glx/hMi56HpT4Q4aAteZ7Xvwp80KcF0iZxOZdQIAqXrbTTeZccnEnx4PhUAATNbHexNvBJeCj4WAHwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468900; c=relaxed/simple;
	bh=DrTr4BdPO63/kSfkoOJCxr1R25ldxCtHea75ckboYk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtQrEFgEmI4sToGy/itpkQ9I8gc6Q/CBiGNzqYZLSft2NllmwLRPGVvIwDwdEGJf7+2BsbhzmkTAQFOpBW8u8Bt0C2bqtbuhL1apEj1BC/o0govl4rWsBp0wa0+x8xjLacKc/JaoWJzsaeEDHbPW/03IgnW+rodSpxnNgoek7DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EECPcWKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93ACEC2BC86;
	Mon,  2 Mar 2026 16:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772468899;
	bh=DrTr4BdPO63/kSfkoOJCxr1R25ldxCtHea75ckboYk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EECPcWKZhtK9HHOYZku04jjVDyu1w06van8Quc/dBidmzCg3JH1CE2cpzRK55NF0D
	 jJktZqNBlVahReJIdzxWkQBYz4AzP8LtH9CwzORYAdLqK9j7SE4e2iYFZnB7viUrdM
	 O9GoHsLr4omsw/jjWzhjQ9nW06X7hwRPhMSVQFSydv1gyZpnOGrvb54t9tW5uu1Jt7
	 zk3u3QBOQht9PR77N/kG8K5XZjmPQYUvn/NqwBW7wIFsI655NmSmlpRQDfs82kti3N
	 9DcVbajMcpXNjGENpd+J3E+eMd+sQPaWc+XKoA8qiCIwmVEye2fanCAbZBEt9LIuA4
	 77QO0yAcgYIRg==
Date: Mon, 2 Mar 2026 16:28:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/6] regulator: dt-bindings: sc2731: Deprecate compatible
 property
Message-ID: <5dbdbd4a-5446-4e67-8cd2-b2abbba4f68f@sirena.org.uk>
References: <20260222-sc27xx-mfd-cells-v1-0-69526fe74c77@abscue.de>
 <20260222-sc27xx-mfd-cells-v1-3-69526fe74c77@abscue.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kf6USxJBZ4GjMAJH"
Content-Disposition: inline
In-Reply-To: <20260222-sc27xx-mfd-cells-v1-3-69526fe74c77@abscue.de>
X-Cookie: You love peace.
X-Rspamd-Queue-Id: E017D1DCEF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43430-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,kernel.org,gmail.com,linux.alibaba.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


--Kf6USxJBZ4GjMAJH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2026 at 02:16:47PM +0100, Otto Pfl=FCger wrote:
> The node containing the regulators is always a child of the main PMIC
> node, which already has a compatible property identifying the type of
> PMIC. This makes the compatible in the child node redundant. Mark it
> as deprecated and remove it from the required property list and the
> examples.

Acked-by: Mark Brown <broonie@kernel.org>

--Kf6USxJBZ4GjMAJH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmlup0ACgkQJNaLcl1U
h9DcBwf/dRolwDx+gvFvuRwyQUpj6eDFz5cV8azndvu23rnyNIoAUQAvyBxcOGRF
X1Dnlyx6Ye+SbxnPfQenncP9FIuRRzf7fzFjQ1C7oW0zqoiRKlzHWYwneo4gcG+B
YzdyiS5UxIEHOG0hrtngKU6gb19QVaKNHkHTgf0aMGfRZQg/6hzj2RAo0zSNtGeq
BeyvWxOQdocX+aMkP01CdZa7HpBbJkzugXtF1JM4rTAoGnqN5YEs2HSLgJI2BHUp
XM8OJo4FIddXPOeKq1QioqcB2SDwDNLa/CnqRfvqy/S+VNypPnRTDq6oL+/TsD3i
pLpcJYWGM0qZ35zIHBtWfH/dP7j2XQ==
=NlVv
-----END PGP SIGNATURE-----

--Kf6USxJBZ4GjMAJH--

