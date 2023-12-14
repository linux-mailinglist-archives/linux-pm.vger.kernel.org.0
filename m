Return-Path: <linux-pm+bounces-1161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F9D813673
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 17:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59392817A2
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A255760B94;
	Thu, 14 Dec 2023 16:40:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1446C114;
	Thu, 14 Dec 2023 08:40:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C741C15;
	Thu, 14 Dec 2023 08:41:01 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 866973F5A1;
	Thu, 14 Dec 2023 08:40:13 -0800 (PST)
Date: Thu, 14 Dec 2023 16:40:10 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Yangtao Li
 <tiny.windzz@gmail.com>, Brandon Cheo Fusi <fusibrandon13@gmail.com>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] cpufreq: sun50i: Add D1 support
Message-ID: <20231214164010.0be50a89@donnerap.manchester.arm.com>
In-Reply-To: <8351928.NyiUUSuA9g@archlinux>
References: <20231214103342.30775-1-fusibrandon13@gmail.com>
	<20231214103342.30775-3-fusibrandon13@gmail.com>
	<8351928.NyiUUSuA9g@archlinux>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Dec 2023 17:29:30 +0100
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:

Hi,

> On Thursday, December 14, 2023 11:33:39 AM CET Brandon Cheo Fusi wrote:
> > Add support for D1 based devices to the Allwinner H6 cpufreq
> > driver
> >=20
> > Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > ---
> >  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/s=
un50i-cpufreq-nvmem.c
> > index 32a9c88f8..ccf83780f 100644
> > --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > @@ -160,6 +160,7 @@ static struct platform_driver sun50i_cpufreq_driver=
 =3D {
> > =20
> >  static const struct of_device_id sun50i_cpufreq_match_list[] =3D {
> >  	{ .compatible =3D "allwinner,sun50i-h6" },
> > +	{ .compatible =3D "allwinner,sun20i-d1" }, =20
>=20
> This is not needed, as there is no functionality change.

That was my first reflex, too, but this is the *board* (fallback)
compatible, listed in the root node, so you have to list it here for each
SoC, together with the respective blocklist in the next patch.
We are doing the same for the H616, and actually also need that for the
H618. Weird, I know, but last time I check not easy to fix.

Cheers,
Andre

