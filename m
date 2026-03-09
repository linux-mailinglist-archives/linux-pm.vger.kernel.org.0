Return-Path: <linux-pm+bounces-43956-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMCeIVjormlRKAIAu9opvQ
	(envelope-from <linux-pm+bounces-43956-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 16:33:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0693323BBEC
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 16:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3D0A303BA5C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 15:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5976E3D6484;
	Mon,  9 Mar 2026 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Lqqr0+Ru"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD053368BD;
	Mon,  9 Mar 2026 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069775; cv=pass; b=dIUzJOhS9F7d0EuAoW4fjzDja6i7uVQiQnzKUL5k0BhV1A1N7sBitTmhNq1p4PfEOcUIyhYVGEMGgmmOG1tCM2EOUhnKneDL6LXTe4B/4cyNgEaZTzFSUKJ0uCQmnBQd1xDcNmvAQ2ORs0nW5cEQdcfvV2pbzxeCAv0fvzNSNVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069775; c=relaxed/simple;
	bh=bF+8Izpr8cBvE31iG2ObcDqk8SMLxaNyyqmn8prekcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbb4LRcbPSnTufXl3QaJ4C2/YAgSGBr2QtStcLrWXWZMITkg9LdtM6wSfpJKRlfmzO7YwFpmWGxMKzQhIpf299y3++JNvwMvb/avV1BtJdPumwig+iAwtxZJTAmQWAcXD+GbAbx3iPlCshJ4RZS0CIWpALGs1mGzEJ+cjy8BzhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Lqqr0+Ru; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1773069765; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DeeTX2RgOTXlXkSnVJxrsnizd2XbDfgW7ko7mmzodZ5QzPLqnxIRdT1Sq8g4y3QH430/KQhpPAxhxVAmWbdGvKFkHXs3nYtXcBFa6uBfUkIwJ0ZUvphqopOSqqeph5DGCgEllMjNYtYbhSwO/es1b9YqzocEfh4UzCrT/bB1nIc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773069765; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+1QeBGhfbS5fwYxIVMpwwIk42C3t6ttYT0afdo4VaxM=; 
	b=YQ5HYmr7Kpw8L5+t58GvRsrGLHLTa7BTKW7Vy2g+gDJJ/kERmr7hBUyzzc8aN8+WEzLkk1ED34JN0aYSE5mzLAY6PeFGDlnmW9yqIKv7ElkMhPphzEldy5B6nqbHy2J/NWSDuufSY1aXhdzcPjeZecSWFeubW4kjbobOYoCkWSE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773069765;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=+1QeBGhfbS5fwYxIVMpwwIk42C3t6ttYT0afdo4VaxM=;
	b=Lqqr0+RuMganL1WByElamVZYe4PCcb+uu25tXoDm6jsQ9O4JjiW6zhyovhVzA77F
	GvMfXrGgLINIsZpq4TlHku70mQ/tNFZAoYVoHMeV35aNoWu8MkV7f36Bs33ANYB6KQB
	BhRVbSgNBAgxlTjmAwKTYC3eEvsLZHEbOSWpcYzU=
Received: by mx.zohomail.com with SMTPS id 1773069762453797.9120368836742;
	Mon, 9 Mar 2026 08:22:42 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id BDAC9182955; Mon, 09 Mar 2026 16:22:38 +0100 (CET)
Date: Mon, 9 Mar 2026 16:22:38 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Amit Sunil Dhamne <amitsd@google.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 2/3] power: supply: Add PD SPR AVS support to USB type
 enum
Message-ID: <aa7lRufFIdqHTOMg@venus>
References: <20260226055311.2591357-1-badhri@google.com>
 <20260226055311.2591357-3-badhri@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fbat4zjpvgruu2i7"
Content-Disposition: inline
In-Reply-To: <20260226055311.2591357-3-badhri@google.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.1.1.4.3/273.49.35
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 0693323BBEC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43956-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


--fbat4zjpvgruu2i7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/3] power: supply: Add PD SPR AVS support to USB type
 enum
MIME-Version: 1.0

Hi,

On Thu, Feb 26, 2026 at 05:53:10AM +0000, Badhri Jagan Sridharan wrote:
> Add two new members to the power_supply_usb_type to represent the
> USB Power Delivery (PD) Standard Power Range (SPR) Adjustable Voltage
> Supply (AVS) charging types:
>=20
> POWER_SUPPLY_USB_TYPE_PD_SPR_AVS: For devices supporting only the
> PD SPR AVS type.
>=20
> POWER_SUPPLY_USB_TYPE_PD_PPS_SPR_AVS: For devices that support both
> PD Programmable Power Supply (PPS) and PD SPR AVS.
>=20
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/power/supply/power_supply_sysfs.c | 2 ++
>  include/linux/power_supply.h              | 3 +++
>  2 files changed, 5 insertions(+)

This is missing an update to Documentation/ABI/testing/sysfs-class-power .

Greetings,

-- Sebastian

>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index dd3a48d72d2b..f30a7b9ccd5e 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -70,6 +70,8 @@ static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] =
=3D {
>  	[POWER_SUPPLY_USB_TYPE_PD]		=3D "PD",
>  	[POWER_SUPPLY_USB_TYPE_PD_DRP]		=3D "PD_DRP",
>  	[POWER_SUPPLY_USB_TYPE_PD_PPS]		=3D "PD_PPS",
> +	[POWER_SUPPLY_USB_TYPE_PD_SPR_AVS]	=3D "PD_SPR_AVS",
> +	[POWER_SUPPLY_USB_TYPE_PD_PPS_SPR_AVS]	=3D "PD_PPS_SPR_AVS",
>  	[POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID]	=3D "BrickID",
>  };
> =20
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 360ffdf272da..7a5e4c3242a0 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -210,6 +210,9 @@ enum power_supply_usb_type {
>  	POWER_SUPPLY_USB_TYPE_PD,		/* Power Delivery Port */
>  	POWER_SUPPLY_USB_TYPE_PD_DRP,		/* PD Dual Role Port */
>  	POWER_SUPPLY_USB_TYPE_PD_PPS,		/* PD Programmable Power Supply */
> +	/* PD Standard Power Range Adjustable Voltage Supply */
> +	POWER_SUPPLY_USB_TYPE_PD_SPR_AVS,
> +	POWER_SUPPLY_USB_TYPE_PD_PPS_SPR_AVS,	/* Supports both PD PPS + SPR AVS=
 */
>  	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
>  };
> =20
> --=20
> 2.53.0.414.gf7e9f6c205-goog
>=20

--fbat4zjpvgruu2i7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmmu5bcACgkQ2O7X88g7
+poP6w/9EAQf8X64v9yyi7qpDCRVPUn3XcDduahUTdSrZLtv/3NOrgSb9Nq2S0tJ
JDifxzK++R2mGoelKtuZc8VFE1Ok3ODXb5aBxr/kptyeNWUhrVIZVolwciGMStY/
51bbv4B0AQ5jGMaFOYpER+wtmW9Ds3C/QM/8F4kTmM2+LaO0GwgOy+1SdWRJbTai
kgzJ7vRd/+8Cz2czrX9TpARa35jazGtP+DsVr2etcPyuCm/JITnumSzGHfnUEtM6
eX2/P3BjrHjLw3x8N/SmsABMzVVVVTzxTmODG9d8WTHAted3pqbZr2Ps6lt1dcXc
ZztN6OSp84TcGyUbm8ybyeCKtZWAfswVC8k20HEcAikFlMrIEVg1LsWD8IetGTkE
DpBMKwJE2I5QCJEx6OZefBRWfTV3unoPmrVtCubsxyOazrW9z5hUKKUiHPHb9CBy
Xkli4CURR0rCJPGVa3FiX3lYV1XvmqT6nZdMCte4nu/WTADujpTZkEZHQ/BFaXlm
auc19VmJ9nhpzB1JeU3pQTRdMme+GbDchiEB7CVBtGGXgGE0uaXO+hBemLd1QFKP
yMN8ngeY/Ci7A8PtHh1U8PHLbRzCVpoO0DWOFM3havXF85AejIaK8E0lD5Q8gxB3
Wp3xbKJT/xfuNOiLgniRrGyjLBeCgbN9r935ill6xTHaqrHTwqo=
=1o87
-----END PGP SIGNATURE-----

--fbat4zjpvgruu2i7--

