Return-Path: <linux-pm+bounces-43271-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB0WJDWQoGkokwQAu9opvQ
	(envelope-from <linux-pm+bounces-43271-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 19:25:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0761AD925
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 19:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC4A1309DEE1
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 18:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB18E3806B2;
	Thu, 26 Feb 2026 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sK2nFo78"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C3B35A3AD;
	Thu, 26 Feb 2026 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772129639; cv=none; b=o2wzsTBumE2lyzSp4QRsvgCOoT0P/pW6ayl53aflyAKTMPzzAPpwnw9PGtNsshDlwHa0nByfhEIKi+uOuuWEvpN76AhE8INWmKPOxErxbKFuwuqQzco8ZkqFt/Z/wKsqxkYnlDKMrF/dzrgK8kk0G66oC9hUSjp6orMzJo1upFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772129639; c=relaxed/simple;
	bh=g12q3sd6A4QeeQeyUBj2wH7c5NuAA+j/4pWnqnFsOGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUPenukPbW0GtBf0XZ54wCNN2P3Go7qS7jiiWOUdgmYTQGfcggGi8mP22UmE8Abahhv7HWQxKHizl5rE4kiEsxioYFm/2KqXovWluqSiavCKjegpB6wQ9EWNVotF7FsTKjf4utZaAsy/pk4qB6pJnHHRESOh9GuLQsLGk4bCLpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sK2nFo78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF2EC116C6;
	Thu, 26 Feb 2026 18:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772129639;
	bh=g12q3sd6A4QeeQeyUBj2wH7c5NuAA+j/4pWnqnFsOGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sK2nFo78m/JG8s2S2/8K+EwgTnGpk6NppJLMK+ckvH8O2tb4h3whb/tEv+9Vfz3L0
	 uqW3fzLvCdeToEtLh+Ggv6gbw4eWrVQzLp0DaTO8HCsz2XzBXVq6Y5xim7DaRHJIL0
	 VA3dicrxLRP3T5iVbvhgIfNg9VpQhPdULxIzYLZg+Blyd+POco5bGErWYeOPzeSuSn
	 AAoSKXLqNPD8nvPYyy8CnK+K5lY6ipGi5V5IJh3jg5jnYS/l73SFMz4TC5q2WxfGUq
	 KmZxqoDOWYy8WVRi26nWwfwZTVkvKd+05jp8oSmQpeHSUN+a81zLEqtU3KtQ5FYNgI
	 TLqJq9fBouTjw==
Date: Thu, 26 Feb 2026 18:13:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>, linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: nvidia: Document the Tegra238
 CCPLEX cluster
Message-ID: <20260226-lung-pandemic-6cf9c79f9226@spud>
References: <20260226151212.4067944-1-thierry.reding@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eJDs8sWyDUAgWKga"
Content-Disposition: inline
In-Reply-To: <20260226151212.4067944-1-thierry.reding@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-43271-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:email,nvidia.com:email]
X-Rspamd-Queue-Id: 2C0761AD925
X-Rspamd-Action: no action


--eJDs8sWyDUAgWKga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 04:12:11PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Tegra238 is derived from Tegra234 and uses a similar CCPLEX cluster,
> with slight variations but the same programming model. Add a compatible
> string to specify this particular implementation.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--eJDs8sWyDUAgWKga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaCNYgAKCRB4tDGHoIJi
0oYSAP928OLXm5h9F5ghdd4jj77nir/nEg5qQHqDKU4JUck0sgD9EmAdYsvh8ik9
+wi6aM3YuURYPzO1WCCdEVErKNTtDwk=
=Q+hO
-----END PGP SIGNATURE-----

--eJDs8sWyDUAgWKga--

