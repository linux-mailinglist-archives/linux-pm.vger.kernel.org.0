Return-Path: <linux-pm+bounces-33039-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A33B34775
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 18:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D723D16D0B8
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 16:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B08301033;
	Mon, 25 Aug 2025 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CICHkMkk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E1F2FE059;
	Mon, 25 Aug 2025 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139566; cv=none; b=q7F1Lns91e6CmKfa+kv4+JZciGcU0awnjuVLDyr2Negb2kPRn8pAwRZCFUUBtC/uv1ekQT7vEE/X+VAA36jJyS5MMELtTy3UyuLRR5rNxroIKrAQlITe6wY0ZweQkDP4BYBI0Xq/tPP3pKPueyk7+p5qPauyy6UeqS10juR7qDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139566; c=relaxed/simple;
	bh=zxHmMRw5/sY4qKaSFZbZXzsqqlDUBxYTyqhzcESdego=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLjnYZa6G52SF3908rUS9YIcSoVxKTnuIcN/noD4efX3YeTte0CpocMmZepdf9nD0OaDWTjZL/KqgoquhSYRApOsr2WUMiPBCqT2IsWQDmHgDbJXJ05IJ5Af91bZ6XV5okgJ8IP5rPDtVU8F88feX+XZpCX05cP19aGAUZR6agY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CICHkMkk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E72FC4CEED;
	Mon, 25 Aug 2025 16:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756139566;
	bh=zxHmMRw5/sY4qKaSFZbZXzsqqlDUBxYTyqhzcESdego=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CICHkMkkEU+tjKP+MqFEALd3NOdg5W+pElM+0WrIhPjTS6gvBVpk4YyHGw8b9c2G7
	 D00hZB+RDGmjmf0Zy6Pqpo6llOt2tJXjZeYxygHGe9bo6dmAp6YfArRcXVi9rYmYmy
	 Nwg3WaISziM97mmNyca5dsnxVT+JJ//QDcaKyASMHtCmV6TEvwbcQOqyNubkA/PgHm
	 /PIa1chyi6bDCXNEPh8+nIEZihs/0rcDegmUfHxxIP/05Q1kwq1YyDmhNdpcHV3arw
	 6jp0f8vKZ6Eub9iONvptvqABRZsCoGkYTBoTnkqkNP5z1UViNxCNEymcSUKf4yxppU
	 1vvCfy5pbJN0w==
Date: Mon, 25 Aug 2025 17:32:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] dt-bindings: thermal: add Tegra114 soctherm header
Message-ID: <20250825-subtext-humorist-56ad14987b18@spud>
References: <20250825104026.127911-1-clamor95@gmail.com>
 <20250825104026.127911-5-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7tazrZqeQK2No255"
Content-Disposition: inline
In-Reply-To: <20250825104026.127911-5-clamor95@gmail.com>


--7tazrZqeQK2No255
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Acked-by: Conor Dooley <conor.dooley@microchip.com>

--7tazrZqeQK2No255
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKyQKAAKCRB4tDGHoIJi
0hNPAP0ZgYlArdqscbq1qWB/DsuZSnXLM/hf1evnYblufG+cdQD/YqSFvmrtGVLV
7kJhUCGCQ+v7FNibpnCq6pTJpwLnKgs=
=Cqzt
-----END PGP SIGNATURE-----

--7tazrZqeQK2No255--

