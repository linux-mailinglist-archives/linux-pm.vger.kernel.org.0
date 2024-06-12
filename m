Return-Path: <linux-pm+bounces-9030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF41905923
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 18:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDC1282885
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 16:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7E3181BA1;
	Wed, 12 Jun 2024 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rng/KsFr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4438180A9D;
	Wed, 12 Jun 2024 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211078; cv=none; b=rJWPs7VXuMVkCSgzqHoN9dcwRq0XLEqsKYL4h/SZs8Kt8flF7dsrVY6KRQbPajifE0gvc//FL3tHQJkWQ9ALdbVKufiTscQMoXg4jlo/3I6HI8fc6JMaHV6J1ydUMHZkBpOEomJ8DTp/zr+dIlourImPYYj3Vi4CkWS8SepDopI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211078; c=relaxed/simple;
	bh=RCaHtACj2SxL4hUQI5V+jP3OfLSwL9/Qp69eRQVinrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKFqDwOCoDt2wYihLhXkspicsyakCXEduxKREYyQcE+9oFbC9C4HvHdJ2cGnyXz6NFsGsQJKIyc50PcOIKA7B4252TBAJIMg2iwqmTtC1M50i1HmPp0DNw5NeSHsi/rWnFJ8rWCwLRwN0BL9SVqtP40hEbWYVfYFsU+TFIJ03Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rng/KsFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C534CC116B1;
	Wed, 12 Jun 2024 16:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718211078;
	bh=RCaHtACj2SxL4hUQI5V+jP3OfLSwL9/Qp69eRQVinrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rng/KsFrm67z5muQdvve4Da1go0NZ3uq+e5l4cMdvn9JltfTYbk6e/bnXM473NcQZ
	 KZEv/buQTkLr8MtKpXimApeaLy8lkQOOC747dIaIaT5nbOSJUAdeoHreVPrEJC7HNg
	 gs6aE+jBfHJa2zfr0Z32CLvJcvsyQ4cm3wLYGviFFvVZwP7Bl9BpMnrqZEJ06ahNO6
	 l8vM9HZ8YMjel4kB7+HLiwWO/CMtsRl0b+O+YFqnxD/Avs3fNakdqUIf40jI1alsAK
	 qlPIs+Z6yXagJxifwgoBKNfnu8cXuNjZSvovUKnPfiLKfeBq9BqiEmn6ZsgKPFjEWw
	 bP26jT61u94Cw==
Date: Wed, 12 Jun 2024 17:51:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Bryan Brattlof <bb@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Vibhore Vardhan <vibhore@ti.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] DONOTMERGE: dt-bindings: mfd: syscon: add TI's opp
 table compatible
Message-ID: <20240612-unranked-unsalted-b32674a98d4a@spud>
References: <20240612-ti-opp-updates-v1-0-3551c31d9872@ti.com>
 <20240612-ti-opp-updates-v1-3-3551c31d9872@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RLdNql4jJBieNqa9"
Content-Disposition: inline
In-Reply-To: <20240612-ti-opp-updates-v1-3-3551c31d9872@ti.com>


--RLdNql4jJBieNqa9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 11:41:52AM -0500, Bryan Brattlof wrote:
> The JTAG_USER_ID_USERCODE efuse address, which is located inside the
> WKUP_CTRL_MMR0 range holds information to identify the speed grades of
> various components on TI's K3 SoCs. Add a compatible to allow the
> cpufreq driver to obtain the data to limit the maximum frequency for the
> CPUs under Linux control.
>=20
> Signed-off-by: Bryan Brattlof <bb@ti.com>

$subject: DONOTMERGE: dt-bindings: mfd: syscon: add TI's opp table compatib=
le

Okay, if this isn't for merging then I won't Ack it.

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Document=
ation/devicetree/bindings/mfd/syscon.yaml
> index 7ed12a938baa3..ab1fcbe2148f7 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -88,6 +88,7 @@ properties:
>                - rockchip,rv1126-qos
>                - starfive,jh7100-sysmain
>                - ti,am62-usb-phy-ctrl
> +              - ti,am62-opp-efuse-table
>                - ti,am62p-cpsw-mac-efuse
>                - ti,am654-dss-oldi-io-ctrl
>                - ti,am654-serdes-ctrl
>=20
> --=20
> 2.45.2
>

--RLdNql4jJBieNqa9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmnSAQAKCRB4tDGHoIJi
0sWBAQCOPrkQuLnJ8hVCTnNLC9CZqP/gnQc6qb+FonTElR9zSQEA+XVKyJ8OzunD
0pSEZE1WzJwXwAz9j/q1rshvEKDl5gs=
=yCht
-----END PGP SIGNATURE-----

--RLdNql4jJBieNqa9--

