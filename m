Return-Path: <linux-pm+bounces-35697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD958BB7E0B
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 20:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31CDE4E54E6
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 18:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8335F2DA777;
	Fri,  3 Oct 2025 18:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="ohtHXZcr"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5241BCA0E
	for <linux-pm@vger.kernel.org>; Fri,  3 Oct 2025 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515878; cv=none; b=CSLtuWAH8Hb5BUYKpDdxAb6bYpe0qhFCw7d8udBdt8R74NYZR3koYm+slygEIwCx5Iaa530hcCOYLZveSWZgistYqeCnQTH8QLzkER9nDxClGoKYFJii2AarT39SxHDTvkHyrnX0j4HcV1RREG9BgudmFOETkwdJdem5Z9ePd6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515878; c=relaxed/simple;
	bh=HX+kpTW6oJpPu802Qe3o1aTuPUw5cnNk0EyKVYCAoO8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CdYZtKRpA+LYZT30iRp5QQUF8pYgmyX+22I8MUe13I70UXqIQXh5ccUovjUsG/su/9u+iBmJC80HYl9x2MYvyFT+03GAjky+OlSJ6IfJS01Cd7jT0Tln97xY1xyY5nUZjaKKLHcopP1dqqsy+ujGN4NJjVq5HD7wdqXdyXS+MAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=ohtHXZcr; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1759515872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1pZwuT/JLNXJewD2NH2HpDVLKQgrPsuLUQV2Ho86TzI=;
	b=ohtHXZcrdHCQRHZiN02OlCl0z3COcDpmx2RJFlgqqfGnMnnTAkQhBddhayj9xpSE/NUgDf
	ewxf87lAqgOPpJYLxMBTg+pjpvOs0qdpnsoW3LHa1OfUS5zTyvhW6c+CABkWzuEF9teVW6
	3Qo+QcWKihEQrFEyPjWQ+1hEazUl875JRSBgG4QRABl2TxZsn47zqrQQtlAFWpKQlx/YNt
	dL+vEZxLF/ZRL8d70ZXnzMkm0RDpt+DOHafIFIZ0hQXGOt+x2nd34wzYF3oP2Fq48OX+mf
	5qxnWUG2+ba36i5woRHH7yfEsQGEBPLCm4Au43JMIs1SnRIPA5lnkKnyEMC3bg==
Content-Type: multipart/signed;
 boundary=350687d2fbade414a961dffd460dfe7fc1681636fdd689bcf31c7eb97d01;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 03 Oct 2025 20:24:22 +0200
Message-Id: <DD8WBG9LXET7.189BAJGVYEOIR@cknow.org>
Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Nicolas Frattaroli"
 <nicolas.frattaroli@collabora.com>, "Heiko Stuebner" <heiko@sntech.de>,
 "Sebastian Reichel" <sebastian.reichel@collabora.com>, "Sebin Francis"
 <sebin.francis@ti.com>, "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>,
 "Jon Hunter" <jonathanh@nvidia.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: fw_devlink: Don't warn in
 fw_devlink_dev_sync_state()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Diederik de Haas" <didi.debian@cknow.org>, "Ulf Hansson"
 <ulf.hansson@linaro.org>, "Saravana Kannan" <saravanak@google.com>, "Rafael
 J . Wysocki" <rafael@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <linux-pm@vger.kernel.org>
References: <20250925115924.188257-1-ulf.hansson@linaro.org>
 <DD1XOHE6P5OC.2JUQRAGAE1KTU@cknow.org>
In-Reply-To: <DD1XOHE6P5OC.2JUQRAGAE1KTU@cknow.org>
X-Migadu-Flow: FLOW_OUT

--350687d2fbade414a961dffd460dfe7fc1681636fdd689bcf31c7eb97d01
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Sep 25, 2025 at 3:59 PM CEST, Diederik de Haas wrote:
> On Fri Sep 12, 2025 at 8:32 PM CEST, Saravana Kannan wrote:
>> Please don't just disable fw_devlink using fw_devlink=3Doff. We want to
>> fix any issues you are hitting with it. I might even delete this "off"
>> option sometime. It was meant as an early debug option.
>
> I want to test all my (Rockchip) devices to see if they 'need'
> that parameter to 'silence' the warning. I have a (vague) recollection
> that some don't need it (for that).

Not trying to revisit the discussion, only to report that data.
All tests were done with the 6.17 kernel and no 'fw_devlink=3Doff'.

Device				sync_state warning
Rock64 (rk3328)			yes
RockPro64 (rk3399)		no
Quartz64 Model A (rk3566)	no
Quartz64 Model B (rk3566)	yes
PineTab2 (rk3566)		yes
NanoPi R5S (rk3568)		yes
Rock 5B (rk3588)		yes

Cheers,
  Diederik

--350687d2fbade414a961dffd460dfe7fc1681636fdd689bcf31c7eb97d01
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaOAU2QAKCRDXblvOeH7b
bi+jAQClFJxngtaff7fByP/1aLRZByopcFs8SEZdCfX0NZgpzwEAjcnsnhLYGu4J
P6cjkclQbHy9mZ8x+FljMgEw+7fw2A4=
=1PVj
-----END PGP SIGNATURE-----

--350687d2fbade414a961dffd460dfe7fc1681636fdd689bcf31c7eb97d01--

