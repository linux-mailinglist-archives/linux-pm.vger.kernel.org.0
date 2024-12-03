Return-Path: <linux-pm+bounces-18426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA859E15D2
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 09:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA50B2B71C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 08:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3371D4348;
	Tue,  3 Dec 2024 08:26:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from coelho.fi (coelho.fi [88.99.146.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758081CCECC
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.146.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733214411; cv=none; b=RozdAE7uy6JwCf13MrfAJZ4Iyfa7hPj89Edc1t48LpI8m5HTO03bRvdqfDmuc5KaJS7Hs4nw2icJfCbcYELpB721GdWPIVV+ZoEnt7B72ptKNuvjeQtLTTf6jTV8jeH5b4ZlR7Sl5cTI8wRPmx32z5Td+bdSWrkHXFFFCrPb/Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733214411; c=relaxed/simple;
	bh=0ZY1G3tgW/X7ZuOB8dy9YU3yOMA3LpFGGJSuCzl8agI=;
	h=Message-ID:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Subject; b=VUXsKqeKdlxvcBi5bdXPXCzi1/LwOjGTCz+OPEdRJ5pWoFbxI0hKfocknVd+bahfiq9ewkw21tjbsXPnomiTvuBEBY/4Xh9nt2Q+dard3ezKC5UGkS+G7HEChLVA7F7FSrdLN1bgYVk+1Lze3P3Pc8LlZ4LudA8QVnQAQfp2vt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coelho.fi; spf=pass smtp.mailfrom=coelho.fi; arc=none smtp.client-ip=88.99.146.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coelho.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelho.fi
Received: from 91-155-254-6.elisa-laajakaista.fi ([91.155.254.6] helo=[192.168.100.137])
	by coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97)
	(envelope-from <luca@coelho.fi>)
	id 1tINfb-00000002bL6-0JDg;
	Tue, 03 Dec 2024 09:50:08 +0200
Message-ID: <7a84d900879c555dab675605ba925bc91b02510d.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, "Borah,
 Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Coelho, Luciano"	
 <luciano.coelho@intel.com>, "Saarinen, Jani" <jani.saarinen@intel.com>, 
 "Nikula, Jani" <jani.nikula@intel.com>, "De Marchi, Lucas"
 <lucas.demarchi@intel.com>,  "intel-gfx@lists.freedesktop.org"	
 <intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"	
 <intel-xe@lists.freedesktop.org>, "linux-pm@vger.kernel.org"	
 <linux-pm@vger.kernel.org>, Sebastian Reichel
 <sebastian.reichel@collabora.com>
Date: Tue, 03 Dec 2024 09:50:05 +0200
In-Reply-To: <5e405ad4-34d6-4507-978f-3d81d4af2455@t-8ch.de>
References: 
	<SJ1PR11MB6129CCD82CD78D8EE6E27EF4B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
	 <SJ1PR11MB612965ACA3E84745346F0400B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
	 <5e405ad4-34d6-4507-978f-3d81d4af2455@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1-1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Level: 
Subject: Re: Regression on linux-next (next-20241120) and drm-tip

Hi,

On Tue, 2024-12-03 at 07:50 +0100, Thomas Wei=C3=9Fschuh wrote:
> (+Cc Sebastian)
>=20
> Hi Chaitanya,
>=20
> On 2024-12-03 05:07:47+0000, Borah, Chaitanya Kumar wrote:
> > Hope you are doing well. I am Chaitanya from the linux graphics team in=
 Intel.
> >=20
> > This mail is regarding a regression we are seeing in our CI runs[1] on =
linux-next repository.
>=20
> Thanks for the report.
>=20
> > Since the version next-20241120 [2], we are seeing the following regres=
sion
> >=20
> > ```````````````````````````````````````````````````````````````````````=
``````````
> > <4>[=C2=A0=C2=A0 19.990743] Oops: general protection fault, probably fo=
r non-canonical address 0xb11675ef8d1ccbce: 0000 [#1] PREEMPT SMP NOPTI
> > <4>[=C2=A0=C2=A0 19.990760] CPU: 21 UID: 110 PID: 867 Comm: prometheus-=
node Not tainted 6.12.0-next-20241120-next-20241120-gac24e26aa08f+ #1
> > <4>[=C2=A0=C2=A0 19.990771] Hardware name: Intel Corporation Arrow Lake=
 Client Platform/MTL-S UDIMM 2DPC EVCRB, BIOS MTLSFWI1.R00.4400.D85.2410100=
007 10/10/2024
> > <4>[=C2=A0=C2=A0 19.990782] RIP: 0010:power_supply_get_property+0x3e/0x=
e0
> > ```````````````````````````````````````````````````````````````````````=
``````````
> > Details log can be found in [3].=20
> >=20
> > After bisecting the tree, the following patch [4] seems to be the first=
 "bad"
> > commit
> >=20
> > ```````````````````````````````````````````````````````````````````````=
``````````````````````````````````
> > Commit 49000fee9e639f62ba1f965ed2ae4c5ad18d19e2
> > Author: =C2=A0 =C2=A0 Thomas Wei=C3=9Fschuh <mailto:linux@weissschuh.ne=
t>
> > AuthorDate: Sat Oct 5 12:05:03 2024 +0200
> > Commit: =C2=A0 =C2=A0 Sebastian Reichel <mailto:sebastian.reichel@colla=
bora.com>
> > CommitDate: Tue Oct 15 22:22:20 2024 +0200
> > =C2=A0 =C2=A0 power: supply: core: add wakeup source inhibit by power_s=
upply_config=C2=A0 =C2=A0=C2=A0
> > ```````````````````````````````````````````````````````````````````````=
``````````````````````````````````
> >=20
> > This is now seen in our drm-tip runs as well. [5]
> >=20
> > Could you please check why the patch causes this regression and provide=
 a fix if necessary?
>=20
> I don't see how this patch can lead to this error.
> Could you doublecheck the bisect?

FWIW I also bisected this and came to the same conclusion, this is the
first bad commit.  My guess is that some component is not yet setting
things up properly for the new feature.

This is very easily reproducible in our system, with vanilla 6.13-rc1,
so if there's anything you want to try, let us know.

--
Cheers,
Luca.

