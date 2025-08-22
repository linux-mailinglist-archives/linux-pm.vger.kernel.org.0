Return-Path: <linux-pm+bounces-32916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC1BB320DA
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 18:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7816414BF
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65B5312800;
	Fri, 22 Aug 2025 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdwyCWqj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE930E83A;
	Fri, 22 Aug 2025 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881634; cv=none; b=VxBeW1o24oIWPQbdQnKeZGP7WbRnptoVUibvAh3LDDa2wA4EnSk20Dzjv9+gCpwEkdz9huZluHi6SEoFo8lf/YV1wNaP+hAxcQXxViiyUOZYICMzT/arx4BlsZgZJOUgtLHsG3H7it+kurH+MmBmZQoAhRq11MtYbDOaamEqbZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881634; c=relaxed/simple;
	bh=J9Pc+PAihK6OLwpz+8d8MSEkFl3S9CIiabPdvcTk9v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Weuq7QFEUf5NBcopmgChfoBUhFIVNAWJTRoav90ekjPoA7BemhsrPO1DqPfQa2iRgoeC5c+txDfu56M8RSQli/8NOu/27ua44xkIJvkXts0fTom6Xei9pglclQPDI1AH9lrzTYqM1NhslFzSUD0931p8JFAhQgqzjUitZX/Wv+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdwyCWqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63074C4CEED;
	Fri, 22 Aug 2025 16:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755881634;
	bh=J9Pc+PAihK6OLwpz+8d8MSEkFl3S9CIiabPdvcTk9v8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LdwyCWqjwop9mnpY+v/oAFKE3edAqepKLXQyUCy+vtjyb2zYUljXfdkuHphvlPc/I
	 +Kl51TGtHpjk3Q3OVh2CV1ldi5R2qJd4CVYGz+9gjIJ/h6B2VwEOOlD9zdrya8lZQG
	 WvoLJ7goU1Ys8sswVHb4SvXRjUCcd+5yIoqQwwbt+nqNO64RbJFETce6bkOgePh3Qe
	 7ydnMdv6M7Hm3ZEOgqrmWoevoiC74nZ0Q95wLSJeqmYxJ/IPacNb/mqzswQZXXW7XT
	 8JSapDmG0hbvchp5AX5pg16yrniIRKfg3uktLojhRtWVUi58jkIOzXfay+7TarTS3v
	 lr1WlxWh2e/1g==
Date: Fri, 22 Aug 2025 17:53:49 +0100
From: Conor Dooley <conor@kernel.org>
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jianxin Pan <jianxin.pan@amlogic.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, "hongyu.chen1" <hongyu.chen1@amlogic.com>
Subject: Re: [PATCH 1/5] dt-bindings: power: add Amlogic S6 S7 S7D power
 domains
Message-ID: <20250822-gala-contents-4f16558dcd68@spud>
References: <20250822-pm-s6-s7-s7d-v1-0-82e3f3aff327@amlogic.com>
 <20250822-pm-s6-s7-s7d-v1-1-82e3f3aff327@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/+Hljh53Ey6WSwxk"
Content-Disposition: inline
In-Reply-To: <20250822-pm-s6-s7-s7d-v1-1-82e3f3aff327@amlogic.com>


--/+Hljh53Ey6WSwxk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Acked-by: Conor Dooley <conor.dooley@microchip.com>

--/+Hljh53Ey6WSwxk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKignQAKCRB4tDGHoIJi
0mN9AQDE4nlsgOE9D3gmaacJI+/i2rKetx2wsfYbDyeZK3FRzQD+NFyZz67qC78e
nDNCV2Nrhip+LAe9vQttb4M7UTiWxAk=
=MTEB
-----END PGP SIGNATURE-----

--/+Hljh53Ey6WSwxk--

