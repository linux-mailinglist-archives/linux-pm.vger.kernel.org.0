Return-Path: <linux-pm+bounces-26335-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB470A9FDAD
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 01:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4581A86509
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 23:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DF9212D8A;
	Mon, 28 Apr 2025 23:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="KoryJbu0"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046932C85;
	Mon, 28 Apr 2025 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745882711; cv=pass; b=fCzvv2qTSTxZeqQVySVdFhGATlPKlnXms/Gx920mXfEQASDrIlPE8zj29xeM3qHewQNiiFwctP5hk1g8ZWCRgolozGe05IMx+c6Ptrlsw5PCtkAuew5duILwKaFcufdta81tLEMW/xiqsAhy4yZ+IK1YxiIAe2E9PGQO0WZ62/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745882711; c=relaxed/simple;
	bh=9swaiTY6yV/zG0GpHuMdlUbuRjORf82CYkhdSDQ4y34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peWqRGAqlJNVeHdwnz5GIN6Nue09s3jtNCWjayVPzCyRYgTn20d0d4dEm6QNP00XeYEvCsN/BPuQFmIo8miGWckGMjfWn+GI+USP6d3P+T/TB59AKmWkimzkhTAJgRcT6GPY/LTTWQOZyeTS0PPfRTXpt5j5xn1sM512JxzRTF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=KoryJbu0; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745882702; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=W8fljC7hgj9FYJ6hxkH/a2hOb0r7W8XNN1SlLVPn60/EXS8XBBQ9DCWfK9yNDY20ygAe5uDGd4gsmV0zdD0NNej8og2MWxJu1JO6pwLJiHK2fZgCwb3UduIkZxwjb3sB+gEJ32UA/KfB/tUKi9H9biGqGNAeYlk/OLs3rzGAlMs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745882702; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TV+1WXDql3Yy0rUyeqOIIEEZCuNdt8kcb49LSNvsIbA=; 
	b=l7QbZ6NMr6YpNvCx7hhhDXe8IUZsNBQvIlQW+I0DXv86UextXiYYO9b7BR4EAt5Yr95ar02VZlHCh0HXTjWwid8kP66597X7uArYd79+0jLRpd6QCQ7of3/xZPsGkKmfx3WoAFHOjPnqy8zHZIFAbgkLnqNz2PbhT4n/rH2qPxg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745882702;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=TV+1WXDql3Yy0rUyeqOIIEEZCuNdt8kcb49LSNvsIbA=;
	b=KoryJbu059VxG+ppyJ0uyJNV8z+hFiH5zAZu/wwvJln7TmzD+TvdtSSAWxLad/wj
	D3Gr8jUCQScxts8289VUO5jp9rAsm+yz15BDSWxXOXWXsBIGvPe/EUGhk1BV0Pa2m6+
	1xJKXxN19s4ePS9mUX/y3gSEQxndLApstLjs1f4A=
Received: by mx.zohomail.com with SMTPS id 1745882700740725.2340711569357;
	Mon, 28 Apr 2025 16:25:00 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 382C61806F3; Tue, 29 Apr 2025 01:24:58 +0200 (CEST)
Date: Tue, 29 Apr 2025 01:24:58 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] power: supply: core: Add additional health status
 values
Message-ID: <3nrolexijte4c2bax5soumid5hb7easvpmvcnzx55p5un33xmu@dxo3xecgt355>
References: <20250425231518.16125-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fhg3kgndsc3rfmji"
Content-Disposition: inline
In-Reply-To: <20250425231518.16125-1-W_Armin@gmx.de>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/244.214.33
X-ZohoMailClient: External


--fhg3kgndsc3rfmji
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/4] power: supply: core: Add additional health status
 values
MIME-Version: 1.0

Hi,

On Sat, Apr 26, 2025 at 01:15:15AM +0200, Armin Wolf wrote:
> Some batteries can signal when an internal fuse was blown. In such a
> case POWER_SUPPLY_HEALTH_DEAD is too vague for userspace applications
> to perform meaningful diagnostics.
>=20
> Additionally some batteries can also signal when some of their
> internal cells are imbalanced. In such a case returning
> POWER_SUPPLY_HEALTH_UNSPEC_FAILURE is again too vague for userspace
> applications to perform meaningful diagnostics.
>
> Add new health status values for both cases.
>=20
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 2 +-
>  drivers/power/supply/power_supply_sysfs.c   | 2 ++
>  include/linux/power_supply.h                | 2 ++
>  3 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index 2a5c1a09a28f..e84a7349f55f 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -456,7 +456,7 @@ Description:
>  			      "Over voltage", "Under voltage", "Unspecified failure", "Cold",
>  			      "Watchdog timer expire", "Safety timer expire",
>  			      "Over current", "Calibration required", "Warm",
> -			      "Cool", "Hot", "No battery"
> +			      "Cool", "Hot", "No battery", "Fuse blown", "Cell imbalanced"

I think it would be better to have it named "Blown fuse" and "Cell
imbalance" (without the d) or "Imbalanced cells". Otherwise LGTM.

Greetings,

-- Sebastian

--fhg3kgndsc3rfmji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmgQDkYACgkQ2O7X88g7
+pqQhA//cb78/0QH5CFOuHSYr8xizlHUnU4EILB62hhkRRv+jAQqkVsIKyJQ0G1x
MGYIwLaTsJQnHW4ilQq2HGQXg5QGRTJuHM8BJzC9365T+xhN/Xs2oB+gzGmu1w9H
VFZqQEumajBkW9J06s732bRvo7VLaeL54yrC3uuwOU4WV9nAKz4K6OOG01GoIU21
N4haRg2E/n21HheEADHjKXUqtJjae5Z/UI0m0Asj573ZNxlgdYMdZ8tlPDJTDlST
KqZ0aLLfSSFuZ4PKD/p/T0gOvifY13lF6pOQObX91SvgOoGooZdLMQJYROZ1ucRp
6GPugT7BsJ1yonzJbphRQjvI9p2SkLaqN7O4Bqa2aooXV7h+DC98qxknDl013yuC
agfhiCOnxr46K7dKaVnt27f6RsfZofBugAIz7zUaPYd6GrUfa6cf20Niw9kSfCTj
9Ax5knhh4lnJjW1OoUFvx5dT9jD5RLp5GET83d0039qrM5kLuPZeGlPpUp2NnLzZ
fB8VBNqAIRjEwiHETN/W3Z/ngmO9FKQIEs6aXPebfB5hZYkOOyMOeR1cbila0YdZ
C9ZqyoyOTtLO83udUDD23BwtSI0givdBOuBjD9qS3soHaRKSib4gor8i4SSq6KFa
+NPs1K1/ofUiQQSlA3Q7NVCwyggr3m/wMQ1fiUPStG0/Cilxdbw=
=RVGI
-----END PGP SIGNATURE-----

--fhg3kgndsc3rfmji--

