Return-Path: <linux-pm+bounces-8115-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6858CE9A6
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 20:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D001C216EA
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 18:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B905A0F9;
	Fri, 24 May 2024 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZhUH4aW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D9E5103D;
	Fri, 24 May 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575282; cv=none; b=BDHf0/+imDWsJdIVLFrNXUzEX5aDhHdIazfUyZKQMwg/H+xbubOGfBgLm3Ub1ekzlRkVGWokGTsGi0YDiLJIGKFJ0aIDfgI8HkYZpDOxDdw6S4jodmWy9ekuzhjE62C6ySWy/EJQRPt8CT2fCZeV/vJ4as5HZvpzeXUNPTvKumw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575282; c=relaxed/simple;
	bh=iaUMhhMd54dtFhNkn184MRajR59ypgb42tdYKRQ0e/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOC6wH03tIAXU0sN9nPr/CuFD/rxCBmLYRTUg80nUKEi+TohAEXoeDOUmg3pcgWEIMhkNCWaz9BQeZW3MZdQs8jo98Jpz06BJb/uNshcOzfTv0gRPyLBwpGCEeYjuauEGkhKW1pWcIc+I7lsTLDXYjqitSWZmPr2h7OIjjKqP+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZhUH4aW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0203C32782;
	Fri, 24 May 2024 18:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716575280;
	bh=iaUMhhMd54dtFhNkn184MRajR59ypgb42tdYKRQ0e/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZhUH4aWWWqt0PgRmttC7fMf6OKQMKFQaHx8QA5i5qnWu8kaDHTUUXhD3PO6Sa7FJ
	 Zx49qQ8UmPSZ+TrCFfZwqS9Afm00Up9R3z7rqsG5edO+A7m+BcF3A5xpYuCVlPfj8X
	 Tcp8nU3vzO9CguXj3x6bEadMjMvPrDTzwVSMzeOQLrP/aDoLz+CwOT/DRrfTXsF7Fn
	 d8CaonqaKTBjxLjSBo9Y1dimcwQfBV3dnS9abLxfTmV2d6M2+Rzqu9s780YXYuMfG1
	 IDrcbU8MDHhzJU6qu6K/MgZPweJktjReCeIoP92+hVIMoOIwbQEB7zlQL89Iuzaw4y
	 5P4YONSSIG1eA==
Date: Fri, 24 May 2024 19:27:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Julien Panis <jpanis@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: thermal: mediatek: Rename thermal
 zone definitions for MT8186 and MT8188
Message-ID: <20240524-clatter-antivirus-b1939900ee58@spud>
References: <20240524-mtk-thermal-mt818x-dtsi-v5-0-56f8579820e7@baylibre.com>
 <20240524-mtk-thermal-mt818x-dtsi-v5-1-56f8579820e7@baylibre.com>
 <20240524-concerned-fritter-262f5e16293e@spud>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="joiORIfrHLDgKDZJ"
Content-Disposition: inline
In-Reply-To: <20240524-concerned-fritter-262f5e16293e@spud>


--joiORIfrHLDgKDZJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 07:24:47PM +0100, Conor Dooley wrote:
> On Fri, May 24, 2024 at 11:04:34AM +0200, Julien Panis wrote:
> > Use thermal zone names that make more sense.
> >=20
> > Signed-off-by: Julien Panis <jpanis@baylibre.com>
>=20
> Removing the defines is an ABI break. If these are all the same devices,
> but with more accurate naming, then keep the old defines and add new
> ones. However, the GPU1 define changes in the course of this patch which
> is more problematic.

> > [RFC] When PATCH 1/6 and 2/6 are squashed, checkpatch raises this WARNI=
NG:
> > "DT binding docs and includes should be a separate patch." That's why I
> > split them in this v5. The problem is that the driver can't be compiled
> > any more at PATCH 1/6. It needs PATCH 2/6 to be compiled. Should the
> > checkpatch warning be ignored here ? Should I finally squash PATCH 1/6
> > and PATCH 2/6 ?

Heh, and there's just one of the issues caused by your ABI break...

> Why do these names even make more sense? Where did the old names come
> from and where do the new?


Thanks,
Conor

--joiORIfrHLDgKDZJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlDcKgAKCRB4tDGHoIJi
0utTAP9kxCXNzFNcl8MrqFN8BJtQIS/Kvm+fTRGjMzR4A9EE5QD/UeZmmXbOuHu7
Gpb2kaTXJjMEecS77c+BSdgxlowavgM=
=xYN6
-----END PGP SIGNATURE-----

--joiORIfrHLDgKDZJ--

