Return-Path: <linux-pm+bounces-43272-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHojAOOToGl+kwQAu9opvQ
	(envelope-from <linux-pm+bounces-43272-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 19:41:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2011ADDDB
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 19:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A77F330D83A7
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 18:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E183338A2BE;
	Thu, 26 Feb 2026 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lchl6h57"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB361389E17;
	Thu, 26 Feb 2026 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130254; cv=none; b=OD2hHpY0oDNclkT9r+JekT+xExg4GV7Yowly3yagJ0dw1NFEOpmEqNjeeYNKHRr/cspd20S6B87NCSbYa9EzdyNNt63Q0quywidDUSDeEqRNp36eAAcBScHGbeldK8rd7MCy13EP9/uHlHg8LYHniGtaY72bXFStbDKa6Qv2e24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130254; c=relaxed/simple;
	bh=k4x6Z48xzF/dV2/cT3V3wABHH6+zjo6WJHix8CU51Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/FtSjHsKFD92hkQPt0Gx6znPcz1h+w2UK2EmEqki8bQ0luVUj9kpOXdzeIqjoC1Q/gt2NG5CV7j2f8bVP1Wm+nI7WyhdSikv1xICyhHxXCXxzXWt1rIo/10KgSYszISxvX4kw24Ayu0g8++kMT1CRkfnpeQMiM45BwiSAETQeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lchl6h57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A241C116C6;
	Thu, 26 Feb 2026 18:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772130254;
	bh=k4x6Z48xzF/dV2/cT3V3wABHH6+zjo6WJHix8CU51Y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lchl6h579PjTlVx42QI3hNgmYN9p1UNid6l9UrbAt/1N4PMGDOndVcIw5zVww0b2G
	 Nx5W5vhDCLs44pMA+kjn/UQftur2LQpuH9vMwQq0Xb4hZ85bnjJ6KjDHjxUbbyFi6R
	 3J2u+2Bma52RXrNU03+VbTDYNyV+fa0bAIzrtN/5u3PJocBSP3SbGYOAZt6VInHWGC
	 TXCzG2PwFlSLFbSZtUpo6pPh3QY8LGXqELM3vJ1AwbkucMbVu0+4SCYytySVk/76oA
	 25bnq7cyHAOaMn7bHLa2GYG9kW2r2gLR3NmW1QhN3Y9Sq4qMx8ryIRZQ1wrytoXDtR
	 s212HROfmblcA==
Date: Thu, 26 Feb 2026 18:24:09 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Juan Yescas <jyescas@google.com>,
	Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] power: supply: max17042: support Maxim MAX77759
 fuel gauge
Message-ID: <20260226-qualify-spearman-7741366b58ac@spud>
References: <20260226-max77759-fg-v1-0-ff0a08a70a9f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oda9qLIMzkgF0K8p"
Content-Disposition: inline
In-Reply-To: <20260226-max77759-fg-v1-0-ff0a08a70a9f@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43272-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: BF2011ADDDB
X-Rspamd-Action: no action


--oda9qLIMzkgF0K8p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 01:11:34PM +0000, Andr=E9 Draszik wrote:
>       dt-bindings: power: supply: max17042: add support for max77759
>       dt-bindings: power: supply: max17042: support shunt-resistor-micro-=
ohms
>       dt-bindings: power: supply: max17042: drop formatting specifier |

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--oda9qLIMzkgF0K8p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaCPyAAKCRB4tDGHoIJi
0jpUAP9Zppf7acAo4CSV+04+ovg36wKjPF5F9zaxo+PPgQiVYQEArucCX74458Mt
6czH8AoktNoXxEisV1VHkkpKlV2Pvww=
=iLcK
-----END PGP SIGNATURE-----

--oda9qLIMzkgF0K8p--

