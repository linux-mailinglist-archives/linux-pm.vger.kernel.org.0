Return-Path: <linux-pm+bounces-19877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A1F9FF488
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jan 2025 17:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22AA2161CA7
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jan 2025 16:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A911E22E9;
	Wed,  1 Jan 2025 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="eBA94zS0"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24731854;
	Wed,  1 Jan 2025 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735748390; cv=pass; b=VPaDienBHGTiuiCiO5HREegEabFkPl6oJN9K6UoOXLVb2GJJBqXAGLUq6yWjb2bvKiSgQuQDpgX0rfedFfRTZcUTOUnFlJNQfkYLCZYWjKqs8/4K2G4AiGMVTpOYs4noisbnx6W/8QoadpzJhOOKz73WdXL9FYPabMo7f6bNkW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735748390; c=relaxed/simple;
	bh=ric4iNSuqLxj4fjkqYY2hfWQ0QejJbop6rkw+2de9Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1gW/DhPxCsP91GfMU5whbemHnWxJ22umQmFHUnvBwYfDXLSNnFpIfk95xB7EcqEvupiVDky93/FJwNbp0BSJTkT7xuZwIR8G+5oFKnrkQV0t3Q6L51cVFeOwbW1EkJK7sWGUwkj1QDaZBxUDgb7beK8r4PxfucPQ13Gdoy/Tjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=eBA94zS0; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1735748379; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FQs1evtVE2sgkPSEfsulAqeIdssyVbyYayntPb80XfeoSaHEcHPnJRj7jDGx+EC5mmZhjbWz+t3atz4javZSal9Dl3MhHYzUtW/1wSlNwem4htrw/4OJrc6qhuMtjf3Z1lmlgKLK3jTE8Y5jHzIAqX7ZHGWW1smU6YqO/NOGSKI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1735748379; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ric4iNSuqLxj4fjkqYY2hfWQ0QejJbop6rkw+2de9Ak=; 
	b=ZXQ+vPIusGUgKbBc6v55GrvU2wLrVkn99/VSDu2aWKFZupvcnajszicnp1xcEkGEcspgceCh6gm+GaGxffvA92f+fiVbhRjaKyRyvhEaa/IVl+0Tm2vRC1qG7FFBblbjxyZ9HxNdVzVXrfPHSkpgZMimc+Blcjc7BJ8WI1xpMo8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1735748379;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=ric4iNSuqLxj4fjkqYY2hfWQ0QejJbop6rkw+2de9Ak=;
	b=eBA94zS0C62BzhJ4Il+QGtm49Ex4K2U/sSjBi8/9jeZvXiIVlQUhexLs4ywlaYqe
	Zf5xD9OtAw4U0KN50tvxvPkUTvFWwHdGc9VoxYRiQJiGnwIZ5930KMnwhfeQSoLPRCT
	GuvQTTmB8Ioj6Ns4R3FpLHVX0ASYVb2JDiQVEUZY=
Received: by mx.zohomail.com with SMTPS id 1735748375571289.9748444958916;
	Wed, 1 Jan 2025 08:19:35 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id 95126106034B; Wed, 01 Jan 2025 17:19:31 +0100 (CET)
Date: Wed, 1 Jan 2025 17:19:31 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
Cc: Tarang Raval <tarang.raval@siliconsignals.io>, 
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 0/2] power: supply: Add STC3117 Fuel Gauge
Message-ID: <vnv44opjdghvz7sa2tso3yk5vbbaepredfyf64ds5jkaeujmcp@eolkitmwg3jn>
References: <20241220084958.32367-1-bhavin.sharma@siliconsignals.io>
 <173479644260.3359498.3393893755513748803.b4-ty@collabora.com>
 <PN2PPFF679F9759585FA8AC4AE446848843F20B2@PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hpzfsp4lsryjwr5q"
Content-Disposition: inline
In-Reply-To: <PN2PPFF679F9759585FA8AC4AE446848843F20B2@PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/235.736.4
X-ZohoMailClient: External


--hpzfsp4lsryjwr5q
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v13 0/2] power: supply: Add STC3117 Fuel Gauge
MIME-Version: 1.0

Hi,

On Wed, Jan 01, 2025 at 10:40:57AM +0000, Bhavin Sharma wrote:
> The patch has not yet appeared in linux-next tree. Do I have to
> provide something further?

No new patches have appeared in linux-next since 2024-12-20, since
Stephen Rothwell is on vacation until 2025-01-06:

https://lore.kernel.org/linux-next/20241220162051.50a762e4@canb.auug.org.au/

Greetings,

-- Sebastian

--hpzfsp4lsryjwr5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmd1awcACgkQ2O7X88g7
+prieA//SNjtqqq5T7TXBZKcx13x4EAPixEgMnd7sD0CD+LvwOk5UkeCJ4qGr+3s
Fzck5ieI/N+ILkJ/YCPxPI9biAaK4tSUoak7CYDvp2wK0wPklYrySM45op6jB4rr
PbnBdv59dVGi1MnfB/iN+McZLA4ZRJdt8KuEpei+6Glx9NiMmoL9f6ZFagQs5sX0
o17NpmXxFdwCDfDBEkP8ebhQ1Ja9fwbzkz8mYi5Blhv7LiOZWA1kYwfqkqjX8ccb
QT2cyifdI7BDyqCkE+6oxZ2RICuQzldeeXgtP6REt+z+tk+jANtPQHCf9YG78/j1
IVLL6qO+yin0F33KNik1azM8HKUdfN1tzxqoWP8I2XRDLTME5EdQ1qDPM34M1S/g
FlSWwDvcESdDL6EywySfi/Enrg8/0zN1CflGI/q3Cgdg/kzPtsBPypOLihoEowoP
C0BZRh9zWYdtH3pMAbmz/nGefs8ymKrzmPjykegqaouGBaTneA6NrreQ5xQPl7vl
ClKikzrgDu4Rs52+zs1jtj2jDidUVtXoNTJ9x2Ld3m/i0Vi0Q26/yxwL42dUpEgJ
OBD0b9OXwGxrCixRstkYTST6p+Uk2yvty6irVU9dS9WOxaxOct1vTTUGc0HaORa4
r92SSMPtFbink6JapLV05SYcKpyQpjROlyRE75xYIq4DZa2AVIc=
=3Qo6
-----END PGP SIGNATURE-----

--hpzfsp4lsryjwr5q--

