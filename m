Return-Path: <linux-pm+bounces-32573-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DE8B2AED2
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 19:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135F64E1A40
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD901346A04;
	Mon, 18 Aug 2025 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHuc2mk0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ACD343D7A;
	Mon, 18 Aug 2025 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536520; cv=none; b=YVnYG0Ncc/AZURGrytLkexlzpzzyGEoDn+mwjJw2d02B8T/Yko6EwVN1dKergr9iEIN9oUcbvhsF1VrTTy1tYr2pYGTsWhkFNpcP2MbB9EDvJsSIIb6gmJqT1uicbnf34rJK3XuWYFlhp42LooGuElv1afAgebqdu4d7kmKSiH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536520; c=relaxed/simple;
	bh=4JDlQ8uzlvj2ruUR4yCJvNZFDixeB2/kwpGfVbnLKXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxBbv8XGauTD1mbDGCcEbB9MjHM2/o316HDSuQiv6WMTOJZRNf2qt/DnxGmXswJDbZRESS+Duv/iaTe/tDdCt3fRjhkegf3kNEwi27Dl2vT23AM06tRxFDNO+q9iKekxGHwOgeKW9fv4NTBuPbjEK0yqy1EMSkzhngXH6E+VqWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHuc2mk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12B3C19422;
	Mon, 18 Aug 2025 17:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755536520;
	bh=4JDlQ8uzlvj2ruUR4yCJvNZFDixeB2/kwpGfVbnLKXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHuc2mk0vjVH9GvL4+Sejb0i88yCxRQPDa/S1zHykWesFOy4lVoPclbtAherEKjxm
	 LVeyc68wG2WA7mWaqrO3YmqQt7nUFxXt19QZMQDXDBIXOiIpsPx9dzuPaTQ4w6+cDs
	 2ZS4Ldc2rToQOmkZUjS0vtVnGU5Ya7DTYQ679Tobk+/u/goh6rdFWXOqJp20VzsVzo
	 7AHPvbvX6laSaM2q6Ajh3Kai7fWYIFWrUMVISnTzilGPg2wcfqx+0onD+3jgMu+SBq
	 bkAfNXMzPjQh9YV1MuqikohBZAluxs6e23//Nr8p8ypaAOpkEO6Ca0xjNfzGVNhLJs
	 OQS8/9gmNpB8g==
Date: Mon, 18 Aug 2025 18:01:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Jacky Bai <ping.bai@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: thermal: qoriq: Add compatible
 string for imx93
Message-ID: <20250818-photo-annually-0d87c4d06b00@spud>
References: <20250818-imx93_tmu-v3-0-35f79a86c072@nxp.com>
 <20250818-imx93_tmu-v3-1-35f79a86c072@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oPltdRaYEbsqi37T"
Content-Disposition: inline
In-Reply-To: <20250818-imx93_tmu-v3-1-35f79a86c072@nxp.com>


--oPltdRaYEbsqi37T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Acked-by: Conor Dooley <conor.dooley@microchip.com>

--oPltdRaYEbsqi37T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKNcggAKCRB4tDGHoIJi
0kVGAQD/a2PJxB0NyQoM1hisKZXKpeMuWnGPrk6iUuo0/adFTAEAi7jKc+5GsLQ+
AdgzhUAkr5oOFTq1HY/QmITWZs0WIwU=
=twvX
-----END PGP SIGNATURE-----

--oPltdRaYEbsqi37T--

