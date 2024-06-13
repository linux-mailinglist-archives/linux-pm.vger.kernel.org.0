Return-Path: <linux-pm+bounces-9081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCB9906FD8
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 14:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69B81F2156E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 12:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758E9146593;
	Thu, 13 Jun 2024 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1RW4gJcB"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B4F146012;
	Thu, 13 Jun 2024 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281291; cv=none; b=Iqi7MwIR8xpG0Z5FJkQZ+a/ITwklsOGsQkC72KUi9zAs5wLdITk/G+RGPQ+4ktmegIXI/xXYl4LZ3m+bzinC9aD7J3fB17RnLvI0IL+ao1cK0ye+gI8CecxJo3jbKNgy1lVQb7oPiY0HnFpsrEmwlm68CppNjEISz1NSI10q3Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281291; c=relaxed/simple;
	bh=Zf2QVQHYtZG5xZ24nVmTxdSDgQEn6skWNU7CifTDirE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4vtrPeRQnT5cxGidXzCo1LY4InY5lrJhIZ4JnPl7OEArB0ARocqGsMtfEM2bY3jh7VVohmEAgTSYMOHL1nvtH+MQL/SG6/u2M7RwFkdmkBnBC5NdNMcAP9V3wZNs3jN7K08ZALxp6D3uVHhTnV0zimKgWxYZvhMDVAa/iF5BX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1RW4gJcB; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718281289; x=1749817289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zf2QVQHYtZG5xZ24nVmTxdSDgQEn6skWNU7CifTDirE=;
  b=1RW4gJcBdif/sLD30beWcWEooBbA5wCeYT55eLro3Puy+M2xA0SqhdZk
   DYgv/OVumtwJAWFZBU3EuA92JEoGZAr0Pygdgk0GtGmsirH13e6SgYl/f
   SGfc10JqqUjRKeJSquleLhKBnI7E3CIpdRrDs2Ev+KKsxUSvCAsaJ2ruT
   fpptMvkwSrF8g70Qc+9+mM5k2G9PvIq+tAnmwT+nasjlorrZcVngCNMqV
   wpK3DObmQoUIxgCZzjYPQp3bSHC5wHi/UJHJFM4y8ahNIhuWsixI+D+7V
   xto4Wo21ZytYzSSR5a9TRCDm8dOuQK2CvknHWgA+WSBUMmPjYrq4JjRDI
   g==;
X-CSE-ConnectionGUID: 09xoRfvrQXi848V3FCW5zA==
X-CSE-MsgGUID: 8vF5tNClTD+xXwD0werExw==
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="asc'?scan'208";a="27390180"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2024 05:21:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 13 Jun 2024 05:21:01 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 13 Jun 2024 05:20:58 -0700
Date: Thu, 13 Jun 2024 13:20:41 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Lee Jones <lee@kernel.org>
CC: Bryan Brattlof <bb@ti.com>, Conor Dooley <conor@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Vibhore Vardhan
	<vibhore@ti.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/5] DONOTMERGE: dt-bindings: mfd: syscon: add TI's opp
 table compatible
Message-ID: <20240613-suspend-synapse-4c7596888198@wendy>
References: <20240612-ti-opp-updates-v1-0-3551c31d9872@ti.com>
 <20240612-ti-opp-updates-v1-3-3551c31d9872@ti.com>
 <20240612-unranked-unsalted-b32674a98d4a@spud>
 <20240612175457.b6q37nm6x4vsdnks@bryanbrattlof.com>
 <20240613120923.GP1504919@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4dSQxpXPdh66Ws15"
Content-Disposition: inline
In-Reply-To: <20240613120923.GP1504919@google.com>

--4dSQxpXPdh66Ws15
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 01:09:23PM +0100, Lee Jones wrote:
> On Wed, 12 Jun 2024, Bryan Brattlof wrote:
>=20
> > On June 12, 2024 thus sayeth Conor Dooley:
> > > On Wed, Jun 12, 2024 at 11:41:52AM -0500, Bryan Brattlof wrote:
> > > > The JTAG_USER_ID_USERCODE efuse address, which is located inside the
> > > > WKUP_CTRL_MMR0 range holds information to identify the speed grades=
 of
> > > > various components on TI's K3 SoCs. Add a compatible to allow the
> > > > cpufreq driver to obtain the data to limit the maximum frequency fo=
r the
> > > > CPUs under Linux control.
> > > >=20
> > > > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > >=20
> > > $subject: DONOTMERGE: dt-bindings: mfd: syscon: add TI's opp table co=
mpatible
> > >=20
> > > Okay, if this isn't for merging then I won't Ack it.
> >=20
> > Ha! Nice. If I don't hear anything from anyone else I'll send a v2 in a=
=20
> > few hours.
>=20
> What's the point of all the DONOTMERGE nonsense?

AFAICT, TI live in fear of subsystem maintainers merging the dts patches,
so they do this.

--4dSQxpXPdh66Ws15
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmrkGQAKCRB4tDGHoIJi
0p4nAP430IFUcjQwXnJpjpJNoZ23njiywSse6cUKT5szXvWGFgEA7QsOTBsgoK0z
SbwDcjhRJ+ruyIk8Pub0q/56L5mPTQw=
=Qv5H
-----END PGP SIGNATURE-----

--4dSQxpXPdh66Ws15--

